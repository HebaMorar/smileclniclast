using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

namespace SmileClinic
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string pass = txtNewPassword.Text.Trim();
            string confirm = txtConfirmPassword.Text.Trim();

            if (pass != confirm)
            {
                lblMessage.Text = "Passwords do not match";
                return;
            }

            string cs = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                SqlCommand check = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Email=@Email", con);
                check.Parameters.AddWithValue("@Email", email);

                if ((int)check.ExecuteScalar() == 0)
                {
                    lblMessage.Text = "Email not found";
                    return;
                }

                string hashed = Hash(pass);

                SqlCommand update = new SqlCommand(
                    "UPDATE Users SET Password=@Password WHERE Email=@Email", con);

                update.Parameters.AddWithValue("@Password", hashed);
                update.Parameters.AddWithValue("@Email", email);

                update.ExecuteNonQuery();

                lblMessage.Text = "Password updated successfully";
            }
        }

        private string Hash(string input)
        {
            using (SHA256 sha = SHA256.Create())
            {
                byte[] bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(input));
                StringBuilder sb = new StringBuilder();

                foreach (byte b in bytes)
                    sb.Append(b.ToString("x2"));

                return sb.ToString();
            }
        }
    }
}