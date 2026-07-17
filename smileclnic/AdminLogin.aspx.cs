using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;

namespace SmileClinic
{
    public partial class AdminLogin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            string connString = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT COUNT(*) FROM Admins WHERE Username=@Username AND Password=@Password";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", password);
                conn.Open();
                int count = (int)cmd.ExecuteScalar();

                if (count == 1)
                {
                    Session["IsAdmin"] = true;
                    Session["AdminName"] = username;
                    Response.Redirect("AdminDashboard.aspx");
                }
                else
                {
                    lblMessage.Text = "Invalid username or password!";
                    lblMessage.ForeColor = Color.Red;
                }
            }
        }
    }
}
