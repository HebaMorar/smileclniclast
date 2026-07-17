<%@ Page Title="Admin Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="SmileClinic.AdminLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Font Awesome و Google Fonts -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,400;14..32,500;14..32,600;14..32,700&display=swap" rel="stylesheet" />

  <link href="Style/loginadmin.css" rel="stylesheet" />
    <a href="indexHome.aspx" class="home-fixed-btn" title="Back to Home">
    <i class="fas fa-home"></i> 
</a>
    <div class="login-wrapper">
        <div class="login-card">

            <h2>Welcome Admin</h2>
            <span class="sub-text">Sign in to the Admin Panel</span>

            <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Font-Bold="true" EnableViewState="false"></asp:Label>

            <div class="form-group">
                <label for="txtUsername"><i class="fas fa-user-cog me-2" style="color: #1a3a5c;"></i> Admin Name</label>
                <div class="input-icon-wrapper">
                    <i class="fas fa-user-cog"></i>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter your admin name" />
                </div>
            </div>

            <div class="form-group">
                <label for="txtPassword"><i class="fas fa-lock me-2" style="color: #1a3a5c;"></i> Password</label>
                <div class="input-icon-wrapper">
                    <i class="fas fa-lock"></i>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="········" />
                </div>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Sign In" OnClick="btnLogin_Click" CssClass="btn-login" />

            <div class="login-links">
                <a href="#">Forgot password?</a>
                <span class="divider">|</span>
                <a href="#">Technical support</a>
            </div>

        </div>
    </div>
</asp:Content>