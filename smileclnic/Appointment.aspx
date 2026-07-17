<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Appointment.aspx.cs" Inherits="SmileClinic.Appointment" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Smile Clinic | Book Appointment</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link href="Style/appointemen.css" rel="stylesheet" />
</head>
<body class="appointment-page">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        
        <a href="indexHome.aspx" class="home-fixed-btn" title="Back to Home">
            <i class="fas fa-home"></i> 
        </a>

        <div class="appointment-container">
            <div class="main-glass-container">
                
                <div class="Form-header">
                    <img src="img/logo.png" alt="Smile Clinic" onerror="this.style.display='none'" />
                    <h2>Book Appointment</h2>
                </div>

                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        
                        <div class="msg-container">
                            <asp:Label ID="lblMsg" runat="server" CssClass="alert" Visible="false"></asp:Label>
                        </div>

                        <div class="appointment-content-wrapper">
                            
                            <!-- قسم إدخال البيانات -->
                            <div class="input-section">
                                <div class="input-group">
                                    <label class="custom-phone-label">Phone Number</label>
                                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control-glass" placeholder="07xxxxxxxx" />
                                </div>

                                <div class="input-group">
                                    <label class="repeater-label">Select Doctor</label>
                                    <asp:DropDownList ID="ddlDoctor" runat="server" CssClass="form-control-glass" AutoPostBack="true" OnSelectedIndexChanged="ddlDoctor_SelectedIndexChanged">
                                        <asp:ListItem Text="-- Select Doctor --" Value="" />
                                        <asp:ListItem Text="Dr. Ahmad Khaled" Value="Dr. Ahmad Khaled" />
                                        <asp:ListItem Text="Dr. Omar Al-Hassan" Value="Dr. Omar Al-Hassan" />
                                    </asp:DropDownList>
                                </div>

                                <div class="divider"></div>

                                <label class="repeater-label">1. Choose Month</label>
                                <div class="repeater-flex months-flex">
                                    <asp:Repeater ID="rptMonths" runat="server" OnItemCommand="rptMonths_ItemCommand">
                                        <ItemTemplate>
                                            <asp:Button runat="server" Text='<%# Eval("MonthName") %>' CommandName="SelectMonth" CommandArgument='<%# Eval("MonthValue") %>' CssClass="btn-glass-info" UseSubmitBehavior="false" />
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>

                                <label class="repeater-label">2. Choose Day</label>
                                <div class="repeater-flex days-container">
                                    <asp:Repeater ID="rptDays" runat="server" OnItemCommand="rptDays_ItemCommand">
                                        <ItemTemplate>
                                            <asp:Button runat="server" Text='<%# Eval("Day") %>' CommandName="SelectDay" CommandArgument='<%# Eval("FullDate") %>' CssClass="btn-glass-day" UseSubmitBehavior="false" />
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>

                                <div class="input-group">
                                    <label class="repeater-label">3. Available Times</label>
                                    <asp:DropDownList ID="ddlTime" runat="server" CssClass="form-control-glass" />
                                </div>

                                <asp:Button ID="btnBook" runat="server" Text="Confirm Booking Now" CssClass="btn-book-final" OnClick="btnBook_Click" />
                            </div>

                            <!-- قسم جدول المواعيد -->
                            <div class="table-section">
                                <h3 class="table-title">Your Appointments History</h3>
                                <div class="table-responsive">
                                    <asp:GridView ID="gvAppointments" runat="server" AutoGenerateColumns="False" 
                                                  CssClass="glass-table" GridLines="None" OnRowCommand="gvAppointments_RowCommand" DataKeyNames="Id">
                                        <Columns>
                                            <asp:BoundField DataField="Doctor" HeaderText="Doctor" />
                                            <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}" />
                                            <asp:BoundField DataField="Time" HeaderText="Time" />
                                            <asp:TemplateField HeaderText="Status">
                                                <ItemTemplate>
                                                    <span class='status-badge <%# Eval("Status").ToString().ToLower() %>'>
                                                        <%# Eval("Status") %>
                                                    </span>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Action">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" 
                                                                    CommandName="CancelAppointment" CommandArgument='<%# Eval("Id") %>' 
                                                                    CssClass="btn-cancel-glass" OnClientClick="return confirm('Are you sure you want to cancel this appointment?');" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <EmptyDataTemplate>
                                            <div class="empty-table">No appointments found.</div>
                                        </EmptyDataTemplate>
                                    </asp:GridView>
                                </div>
                            </div>

                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>

            </div>
        </div>
    </form>

    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@emailjs/browser@3/dist/email.min.js"></script>
    <script type="text/javascript">
// @ts-nocheck
(function () {
    var globalWindow = window;
    if (globalWindow && globalWindow.emailjs) {
        globalWindow.emailjs.init("cjQRSUhHdSxWuC4Yo");
    }
})();
</script>
</body>
</html>