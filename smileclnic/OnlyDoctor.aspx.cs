using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Net.Mail;
namespace SmileClinic
{
    public partial class OnlyDoctor : Page
    {
        string cs = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["DoctorName"] == null)
            {
                Response.Redirect("DoctorLogin.aspx");
                return;
            }
            if (!IsPostBack)
            {
                lblDoctorName.Text = Session["DoctorName"].ToString();
                LoadPatients();
                LoadPrescriptions();
                LoadTreatmentPlans();
            }
        }
        private void LoadPatients()
        {
            string doctor = Session["DoctorName"].ToString();
            using (SqlConnection con = new SqlConnection(cs))
            {
                string q = @"SELECT a.Id AS AppointmentId, u.Name AS PatientName, 
                             a.Date, a.Time, a.Status
                             FROM Appointments a
                             JOIN Users u ON a.UserId = u.Id
                             WHERE a.Doctor = @Doctor
                             ORDER BY a.Date DESC";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@Doctor", doctor);
                con.Open();
                gvPatients.DataSource = cmd.ExecuteReader();
                gvPatients.DataBind();
            }
        }
        protected void gvPatients_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvPatients.EditIndex = -1;
            LoadPatients();
        }
        protected void gvPatients_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Confirm" || e.CommandName == "Cancel")
            {
                int appointmentId = int.Parse(e.CommandArgument.ToString());
                if (e.CommandName == "Confirm")
                {
                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        string q = "UPDATE Appointments SET Status='Confirmed' WHERE Id=@Id";
                        SqlCommand cmd = new SqlCommand(q, con);
                        cmd.Parameters.AddWithValue("@Id", appointmentId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                else if (e.CommandName == "Cancel")
                {
                    string patientEmail = "";
                    string patientName = "";

                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        // جلب إيميل المريض
                        string q = @"SELECT u.Email, u.Name FROM Users u
                     JOIN Appointments a ON a.UserId = u.Id
                     WHERE a.Id = @Id";
                        SqlCommand cmd = new SqlCommand(q, con);
                        cmd.Parameters.AddWithValue("@Id", appointmentId);
                        con.Open();
                        SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.Read())
                        {
                            patientEmail = dr["Email"].ToString();
                            patientName = dr["Name"].ToString();
                        }
                    }

                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        string q = "UPDATE Appointments SET Status='Cancelled' WHERE Id=@Id";
                        SqlCommand cmd = new SqlCommand(q, con);
                        cmd.Parameters.AddWithValue("@Id", appointmentId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }

                    // إرسال الإيميل
                    if (!string.IsNullOrEmpty(patientEmail))
                    {
                        try
                        {
                            MailMessage mail = new MailMessage();
                            mail.From = new MailAddress("asayrasaja33@gmail.com", "SmileCare Clinic");
                            mail.To.Add(patientEmail);
                            mail.Subject = "تم إلغاء موعدك — SmileCare";
                            mail.Body = $"عزيزنا {patientName}،\n\nنأسف لإبلاغك بأنه تم إلغاء موعدك.\nيرجى الحجز مرة أخرى من خلال موقعنا.\n\nشكراً،\nفريق SmileCare";
                            mail.IsBodyHtml = false;

                            SmtpClient smtp = new SmtpClient();
                            smtp.Send(mail);
                        }
                       
                        catch (Exception ex)
                        {
                            lblMsg.Text = "خطأ بالإيميل: " + ex.Message;
                            lblMsg.CssClass = "alert alert-danger";
                            lblMsg.Visible = true;
                        }
                    
                    }
                }
                LoadPatients();
                LoadPrescriptions();
            
            }
            else if (e.CommandName == "Prescribe")
            {
                int rowIndex = int.Parse(e.CommandArgument.ToString());
                GridViewRow row = gvPatients.Rows[rowIndex];

                // التأكد من أن الحالة Confirmed قبل فتح اللوحة
                string status = row.Cells[3].Text;
                if (status != "Confirmed") return;
                int appointmentId = (int)gvPatients.DataKeys[rowIndex].Value;
                string patientName = row.Cells[0].Text;
                hfPrescriptionAppointmentId.Value = appointmentId.ToString();
                lblPrescriptionPatient.Text = patientName;
                pnlPrescription.Visible = true;
            }
        }
        protected void gvPatients_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gvPatients.SelectedRow;
            string status = row.Cells[3].Text;

            // التعديل: لا تظهر الخطط إلا إذا كان الموعد مؤكداً
            if (status != "Confirmed")
            {
                pnlPlan.Visible = false;
                pnlPrescription.Visible = false;
                return;
            }
            string patientName = row.Cells[0].Text;
            string appointmentId = gvPatients.DataKeys[gvPatients.SelectedIndex].Value.ToString();
            hfAppointmentId.Value = appointmentId;
            hfPrescriptionAppointmentId.Value = appointmentId;
            lblSelectedPatient.Text = patientName;
            lblPrescriptionPatient.Text = patientName;
            pnlPlan.Visible = true;
        }
        protected void btnSavePlan_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtDiagnosis.Text))
            {
                lblMsg.Text = "الرجاء إدخال التشخيص.";
                lblMsg.CssClass = "alert alert-danger";
                lblMsg.Visible = true;
                return;
            }
            using (SqlConnection con = new SqlConnection(cs))
            {
                string q = @"INSERT INTO TreatmentPlans 
                             (AppointmentId, Diagnosis, TreatmentSteps, SessionsCount, EstimatedCost)
                             VALUES (@AppId, @Diagnosis, @Steps, @Sessions, @Cost)";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@AppId", hfAppointmentId.Value);
                cmd.Parameters.AddWithValue("@Diagnosis", txtDiagnosis.Text.Trim());
                cmd.Parameters.AddWithValue("@Steps", txtSteps.Text.Trim());
                cmd.Parameters.AddWithValue("@Sessions", int.Parse(txtSessions.Text));
                cmd.Parameters.AddWithValue("@Cost", decimal.Parse(txtCost.Text));
                con.Open();
                cmd.ExecuteNonQuery();
            }
            txtDiagnosis.Text = "";
            txtSteps.Text = "";
            txtSessions.Text = "";
            txtCost.Text = "";
            pnlPlan.Visible = false;
            lblMsg.Text = "تم حفظ خطة العلاج بنجاح!";
            lblMsg.CssClass = "alert alert-success";
            lblMsg.Visible = true;
            LoadPatients();
            LoadTreatmentPlans();
        }
        protected void btnSavePrescription_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtMedName.Text))
            {
                lblPrescriptionMsg.Text = "الرجاء إدخال اسم الدواء.";
                lblPrescriptionMsg.CssClass = "alert alert-danger";
                lblPrescriptionMsg.Visible = true;
                return;
            }
            using (SqlConnection con = new SqlConnection(cs))
            {
                string q = @"INSERT INTO Prescriptions (AppointmentId, MedicationName, Dosage, IsDispensed)
                     VALUES (@AppId, @Med, @Dosage, 0)";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@AppId", hfPrescriptionAppointmentId.Value);
                cmd.Parameters.AddWithValue("@Med", txtMedName.Text.Trim());
                cmd.Parameters.AddWithValue("@Dosage", txtDosage.Text.Trim());
                con.Open();
                cmd.ExecuteNonQuery();
            }
            txtMedName.Text = "";
            txtDosage.Text = "";
            lblPrescriptionMsg.Text = "تم حفظ الوصفة بنجاح!";
            lblPrescriptionMsg.CssClass = "alert alert-success";
            lblPrescriptionMsg.Visible = true;
            LoadPrescriptions();
        }
        private void LoadPrescriptions()
        {
            string doctor = Session["DoctorName"].ToString();
            using (SqlConnection con = new SqlConnection(cs))
            {
                string q = @"SELECT u.Name AS PatientName, p.MedicationName, p.Dosage, p.IsDispensed
                     FROM Prescriptions p
                     JOIN Appointments a ON p.AppointmentId = a.Id
                     JOIN Users u ON a.UserId = u.Id
                     WHERE a.Doctor = @Doctor
                     ORDER BY p.Id DESC";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@Doctor", doctor);
                con.Open();
                gvPrescriptions.DataSource = cmd.ExecuteReader();
                gvPrescriptions.DataBind();
            }
        }

        private void LoadTreatmentPlans()
        {
            string doctor = Session["DoctorName"].ToString();
            using (SqlConnection con = new SqlConnection(cs))
            {
                string q = @"SELECT u.Name AS PatientName, t.Diagnosis, t.TreatmentSteps,
                     t.SessionsCount, t.EstimatedCost, t.CreatedAt
                     FROM TreatmentPlans t
                     JOIN Appointments a ON t.AppointmentId = a.Id
                     JOIN Users u ON a.UserId = u.Id
                     WHERE a.Doctor = @Doctor
                     ORDER BY t.CreatedAt DESC";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@Doctor", doctor);
                con.Open();
                gvTreatmentPlans.DataSource = cmd.ExecuteReader();
                gvTreatmentPlans.DataBind();
            }
        }

    }
}