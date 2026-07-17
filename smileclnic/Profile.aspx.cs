using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace SmileClinic
{
    public partial class Profile : Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }


            if (!IsPostBack)
            {
                LoadUserData();
                LoadPrescriptions();
                LoadTreatmentPlan();
            }

        }



        private void LoadUserData()
        {
            string cs = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // قمنا بتغيير UserName إلى Name هنا
                SqlCommand cmd = new SqlCommand(@"
            SELECT Name, Email, Phone
            FROM Users
            WHERE Id=@Id", con);

                cmd.Parameters.AddWithValue("@Id", Session["UserId"]);
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    // قراءة القيمة باستخدام الحقل الصحيح ["Name"]
                    lblUserName.Text = dr["Name"].ToString();
                    lblName.Text = dr["Name"].ToString();
                    lblEmail.Text = dr["Email"].ToString();

                    lblPhone.Text = dr["Phone"] != DBNull.Value ? dr["Phone"].ToString() : "";
                }
                dr.Close();
            }
        }


        protected void btnEdit_Click(object sender, EventArgs e)
        {


            txtName.Text = lblName.Text;

            txtEmail.Text = lblEmail.Text;

            txtPhone.Text = lblPhone.Text;



            lblName.Visible = false;

            lblEmail.Visible = false;

            lblPhone.Visible = false;



            txtName.Visible = true;

            txtEmail.Visible = true;

            txtPhone.Visible = true;



            btnSave.Visible = true;

            btnEdit.Visible = false;


        }








        protected void btnSave_Click(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // أضفنا تحديث الـ Phone هنا
                SqlCommand cmd = new SqlCommand(@"
    UPDATE Users
    SET Name=@Name,  -- تأكد أنها Name وليست UserName
        Email=@Email,
        Phone=@Phone
    WHERE Id=@Id", con);

                cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim()); // تمرير قيمة صندوق النص
                cmd.Parameters.AddWithValue("@Id", Session["UserId"]);

                cmd.ExecuteNonQuery();
            }

            Session["UserName"] = txtName.Text.Trim();
            Session["UserEmail"] = txtEmail.Text.Trim();

            LoadUserData();

            // إخفاء وإظهار العناصر تلقائياً بعد الحفظ
            txtName.Visible = false;
            txtEmail.Visible = false;
            txtPhone.Visible = false;

            lblName.Visible = true;
            lblEmail.Visible = true;
            lblPhone.Visible = true;

            btnSave.Visible = false;
            btnEdit.Visible = true;
        }




        private void LoadPrescriptions()
        {

            int userId = (int)Session["UserId"];


            string cs = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;



            using (SqlConnection con = new SqlConnection(cs))
            {

                string q = @"
                SELECT a.Doctor,
                       p.MedicationName,
                       p.Dosage,
                       p.IsDispensed
                FROM Prescriptions p
                JOIN Appointments a
                ON p.AppointmentId = a.Id
                WHERE a.UserId=@UserId
                ORDER BY p.Id DESC";



                SqlCommand cmd = new SqlCommand(q, con);


                cmd.Parameters.AddWithValue("@UserId", userId);



                con.Open();


                gvPrescriptions.DataSource = cmd.ExecuteReader();

                gvPrescriptions.DataBind();

            }

        }








        private void LoadTreatmentPlan()
        {

            int userId = (int)Session["UserId"];


            string cs = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;



            using (SqlConnection con = new SqlConnection(cs))
            {


                string q = @"
                SELECT a.Doctor,
                       t.Diagnosis,
                       t.TreatmentSteps,
                       t.SessionsCount,
                       t.EstimatedCost,
                       t.CreatedAt
                FROM TreatmentPlans t
                JOIN Appointments a
                ON t.AppointmentId=a.Id
                WHERE a.UserId=@UserId
                ORDER BY t.CreatedAt DESC";



                SqlCommand cmd = new SqlCommand(q, con);


                cmd.Parameters.AddWithValue("@UserId", userId);



                con.Open();


                gvTreatmentPlans.DataSource = cmd.ExecuteReader();

                gvTreatmentPlans.DataBind();

            }

        }








        protected void btnLogout_Click(object sender, EventArgs e)
        {

            Session.Clear();

            Session.Abandon();

            Response.Redirect("Login.aspx");

        }


    }
}