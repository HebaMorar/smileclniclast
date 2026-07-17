<%@ Page Title="Login"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="Login.aspx.cs"
    Inherits="SmileClinic.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="style/Login-SignupStyle.css" rel="stylesheet" />
    
    <div class="auth-page">
        <div class="auth-card">
            <div class="Form-header">
                <img src="img/logo.png" alt="SmileCare Logo" />
                <h2>Login</h2>
            </div>

            <asp:Label ID="lblMessage" runat="server" CssClass="message" />

            <asp:TextBox ID="txtEmail" runat="server"
                CssClass="inputBox auth-input"
                TextMode="Email"
                placeholder="Email Address" />

            <asp:TextBox ID="txtPassword" runat="server"
                CssClass="inputBox auth-input"
                TextMode="Password"
                placeholder="Password" />

            <asp:Button ID="btnLogin" runat="server"
                Text="Login"
                CssClass="btn btn-primary auth-btn"
                OnClick="btnLogin_Click" />

            <div class="links">
                <a href="Signup.aspx">Don't have an account? Signup</a><br />
                <a href="ResetPassword.aspx">Forgot Password?</a>
            </div>
        </div>
    </div>
</asp:Content>