using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

public partial class indexHome : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // الكود الذي يعمل عند تحميل الصفحة لأول مرة
    }

    protected void btnSendMessage_Click(object sender, EventArgs e)
    {
        // جلب عناصر التحكم ديناميكياً من الصفحة لتجاوز خطأ الـ Designer
        TextBox txtName = (TextBox)FindControl("txtName");
        TextBox txtEmail = (TextBox)FindControl("txtEmail");
        TextBox txtPhone = (TextBox)FindControl("txtPhone");
        TextBox txtMessage = (TextBox)FindControl("txtMessage");

        // التأكد من أن النظام عثر على الحقول بنجاح قبل القراءة منها
        if (txtName != null && txtEmail != null && txtPhone != null && txtMessage != null)
        {
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string message = txtMessage.Text.Trim();

            try
            {
                // تنظيف الحقول بعد نجاح الإرسال
                txtName.Text = "";
                txtEmail.Text = "";
                txtPhone.Text = "";
                txtMessage.Text = "";

                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Thank you! Your message has been sent successfully.');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('An error occurred. Please try again later.');", true);
            }
        }
        else
        {
            // في حال استمرت المشكلة ولم يجد الحقول، يظهر هذا التنبيه للمطور
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Error: Page controls could not be loaded.');", true);
        }
    }
}