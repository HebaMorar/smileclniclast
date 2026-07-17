<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DoctorLogin.aspx.cs" Inherits="SmileClinic.DoctorLogin" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Smile Clinic | Doctor Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
 <link rel="stylesheet" href="Style/Login-SignupStyle.css" />
    <style>
        .home-fixed-btn {
    position: fixed;
    top: 25px;
    left: 25px;
    background: rgba(255, 255, 255, 0.4) !important;
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.4);
    color: #0d3f8a;
    width: 50px;
    height: 50px;
    border-radius: 50%;
    font-size: 20px;
    display: flex;
    justify-content: center;
    align-items: center;
    box-shadow: 0 8px 32px 0 rgba(13, 63, 138, 0.15);
    transition: all 0.3s ease;
    z-index: 1000;
    text-decoration: none;
}

.home-fixed-btn:hover {
    background: linear-gradient(135deg, #0d3f8a, #2d8fe3) !important;
    color: #ffffff;
    border-color: transparent;
    transform: scale(1.1) rotate(-10deg);
    box-shadow: 0 8px 25px rgba(45, 143, 227, 0.35);
}
    </style>
</head>
<body>
    <a href="indexHome.aspx" class="home-fixed-btn" title="Back to Home">
    <i class="fas fa-home"></i> 
</a>
    <!-- إضافة كلاس auth-page كحاوية رئيسية لتطبيق الخلفية والتوسيط -->
    <div class="auth-page">
        
        <a href="indexHome.aspx" class="btn-universal-home" style="position: absolute; top: 20px; left: 20px; z-index: 10;">
            <i class="fas fa-home"></i> Home
        </a>

        <form id="form1" runat="server" class="auth-card">
            
          <div class="Form-header">
   
    <h2>Welcome Doctor</h2>
    <div class="subtitle" style="color: #e2f1ff; opacity: 0.9; margin-bottom: 15px; font-size: 14px;">
        Sign in to the Medical Portal
    </div>
</div>

            <div class="form-section">
                
                <!-- حقل اسم الطبيب (حافظ على خاصية ClientID للـ Label) -->
                <div class="input-group" style="text-align: left; margin-bottom: 10px;">
                    <label class="input-label" for="<%= txtName.ClientID %>" style="color: #ffffff; font-size: 14px; display: block; margin-bottom: 5px;">Doctor Name</label>
                    <asp:TextBox ID="txtName" runat="server" placeholder="Enter your full name" CssClass="inputBox auth-input" />
                </div>

                <!-- حقل كلمة المرور -->
                <div class="input-group" style="text-align: left; margin-bottom: 15px;">
                    <label class="input-label" for="<%= txtPassword.ClientID %>" style="color: #ffffff; font-size: 14px; display: block; margin-bottom: 5px;">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" placeholder="********" TextMode="Password" CssClass="inputBox auth-input" />
                </div>

                <!-- رسالة الخطأ ASP Control كلاس الميسج الجديد -->
                <asp:Label ID="lblMsg" runat="server" CssClass="message" Visible="false" />

                <!-- زر تسجيل الدخول ASP Control مع الكلاسات الجديدة -->
                <asp:Button ID="btnLogin" runat="server" Text="Access Dashboard" CssClass="btn-primary auth-btn" OnClick="btnLogin_Click" />

                <!-- الروابط السفلية المحدثة بالكلاس links -->
                <div class="links">
                    <a href="#" onclick="return false;">Forgot password?</a> 
                    <span style="color: #ffffff; opacity: 0.5; margin: 0 5px;">|</span>
                    <a href="#" onclick="return false;">Technical support</a>
                </div>
                
            </div>
        </form>

    </div>
</body>
</html>