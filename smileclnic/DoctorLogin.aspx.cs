using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace SmileClinic
{
    public partial class DoctorLogin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string password = txtPassword.Text.Trim();

            string cs = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string q = "SELECT Id, Name FROM Doctors WHERE Name=@Name AND Password=@Password";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Password", password);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    Session["DoctorId"] = Convert.ToInt32(dr["Id"]);
                    Session["DoctorName"] = dr["Name"].ToString();
                    Response.Redirect("OnlyDoctor.aspx");
                }
                else
                {
                    lblMsg.Text = "اسم الدكتور أو كلمة المرور غلط!";
                    lblMsg.CssClass = "alert alert-danger";
                    lblMsg.Visible = true;
                }
            }
        }
    }
}