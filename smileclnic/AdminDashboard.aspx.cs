using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmileClinic
{
    public partial class AdminDashboard : Page
    {
        string cs = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["IsAdmin"] == null || !(bool)Session["IsAdmin"])
            {
                Response.Redirect("AdminLogin.aspx");
                return;
            }
            if (!IsPostBack)
            {
                LoadAll();
            }
        }

        private void LoadAll()
        {
            LoadUsers();
            LoadMessages();
            LoadAppointmentDropdown();
            LoadPrescriptions();
        }

        private void LoadUsers()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT Id, Name, Email FROM Users ORDER BY Id", con);
                con.Open();
                gvUsers.DataSource = cmd.ExecuteReader();
                gvUsers.DataBind();
            }
        }

        private void LoadMessages()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT Fullname, Email, Message, CreatedAt FROM ContactUs ORDER BY CreatedAt DESC", con);
                con.Open();
                gvMessages.DataSource = cmd.ExecuteReader();
                gvMessages.DataBind();
            }
        }

        private void LoadAppointmentDropdown()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string q = @"SELECT a.Id, u.Name + ' - ' + a.Doctor + ' (' + CONVERT(varchar,a.Date,103) + ')' AS Label
                             FROM Appointments a JOIN Users u ON a.UserId=u.Id
                             WHERE a.Status != 'Cancelled'
                             ORDER BY a.Date DESC";
                SqlCommand cmd = new SqlCommand(q, con);
                con.Open();
                ddlAppointments.DataSource = cmd.ExecuteReader();
                ddlAppointments.DataTextField = "Label";
                ddlAppointments.DataValueField = "Id";
                ddlAppointments.DataBind();
            }
        }

        private void LoadPrescriptions()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string q = @"SELECT p.Id, u.Name AS PatientName, a.Doctor,
                             p.MedicationName, p.Dosage, p.IsDispensed
                             FROM Prescriptions p
                             JOIN Appointments a ON p.AppointmentId = a.Id
                             JOIN Users u ON a.UserId = u.Id
                             ORDER BY p.Id DESC";
                SqlCommand cmd = new SqlCommand(q, con);
                con.Open();
                gvPrescriptions.DataSource = cmd.ExecuteReader();
                gvPrescriptions.DataBind();
            }
        }

        protected void btnAddPrescription_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtMedName.Text))
            {
                ShowMsg("Please enter a medication name.", "alert-danger");
                return;
            }
            using (SqlConnection con = new SqlConnection(cs))
            {
                string q = @"INSERT INTO Prescriptions (AppointmentId, MedicationName, Dosage, IsDispensed)
                             VALUES (@AppId, @Med, @Dosage, 0)";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@AppId", ddlAppointments.SelectedValue);
                cmd.Parameters.AddWithValue("@Med", txtMedName.Text.Trim());
                cmd.Parameters.AddWithValue("@Dosage", txtDosage.Text.Trim());
                con.Open();
                cmd.ExecuteNonQuery();
            }
            txtMedName.Text = "";
            txtDosage.Text = "";
            ShowMsg("Prescription added successfully!", "alert-success");
            LoadAll();
        }

        protected void gvPrescriptions_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Dispense")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("UPDATE Prescriptions SET IsDispensed=1 WHERE Id=@Id", con);
                    cmd.Parameters.AddWithValue("@Id", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                ShowMsg("Medication marked as dispensed!", "alert-success");
                LoadAll();
            }
        }

        private void ShowMsg(string text, string css)
        {
            lblMsg.Text = text;
            lblMsg.CssClass = "alert " + css;
            lblMsg.Style["display"] = "block"; // لضمان ظهور التنبيه برمجياً
        }
    }
}