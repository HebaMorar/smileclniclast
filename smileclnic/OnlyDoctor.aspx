<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OnlyDoctor.aspx.cs" Inherits="SmileClinic.OnlyDoctor" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Smile Clinic | Doctor Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="../Style/onlydoctor.css" >
</head>
<body class="admin-bg">

    <a href="indexHome.aspx" class="home-fixed-btn" title="Back to Home">
        <i class="fas fa-home"></i> 
    </a>
    
    <form id="form1" runat="server" class="doctor-dashboard">
        <!-- تم إلغاء خلفية الـ card لتصبح شفافة كالأدمن تماماً -->
        <div class="dashboard-card" style="background: transparent !important; box-shadow: none !important; border: none !important;">
            
            <div class="card-header-custom d-flex flex-wrap justify-content-between align-items-center" style="background: transparent !important; border-bottom: 2px solid #2d8fe3; padding: 1.5rem 0;">
                <div>
                    <h2 class="mb-0" style="color: #0b355c; font-weight: 700;">
                        <i class="fas fa-stethoscope me-2" style="color: #1976D2;"></i> 
                        Doctor Dashboard
                    </h2>
                    <p class="text-muted mt-1 mb-0">Manage appointments, treatment plans & prescriptions</p>
                </div>
                
                <div class="welcome-badge mt-2 mt-sm-0" style="background: rgba(223, 244, 255, 0.6); color: #0d3f8a; border-radius: 50px; padding: 8px 16px;">
                    <i class="fas fa-user-md me-1"></i> 
                    Welcome, <asp:Label ID="lblDoctorName" runat="server" CssClass="fw-bold" />
                </div>
            </div>

            <div class="p-4 px-0"> <!-- إلغاء الحواف الجانبية للتطابق مع أبعاد صفحة الأدمن -->
                <div class="d-flex align-items-center">
                    <i class="fas fa-calendar-check fs-4 me-2" style="color: #1976D2;"></i>
                    <h3 class="section-title mb-0">Patient Appointments</h3>
                </div>
                
                <asp:GridView ID="gvPatients" runat="server" CssClass="dash-grid mt-3" GridLines="None"
                    AutoGenerateColumns="false" EmptyDataText="📭 No upcoming appointments"
                    DataKeyNames="AppointmentId"
                    OnSelectedIndexChanged="gvPatients_SelectedIndexChanged"
                    OnRowCommand="gvPatients_RowCommand"
                    OnRowCancelingEdit="gvPatients_RowCancelingEdit">
                    <Columns>
                        <asp:TemplateField HeaderText="Patient Name" HeaderStyle-CssClass="text-center">
                            <ItemTemplate>
                                <strong><%# Eval("PatientName") %></strong>
                                <asp:Panel runat="server" Visible='<%# Eval("Status").ToString() == "Cancelled" %>'>
                                    <span class="cancelled-note badge bg-danger mt-1">⚠️ Patient requested to rebook</span>
                                </asp:Panel>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}" ItemStyle-CssClass="text-nowrap" />
                        <asp:BoundField DataField="Time" HeaderText="Time" />
                        <asp:BoundField DataField="Status" HeaderText="Status" ItemStyle-CssClass="fw-semibold" />
                        <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-nowrap">
                            <ItemTemplate>
                                <div class="d-flex flex-wrap gap-1">
                                    <asp:LinkButton runat="server" CommandName="Confirm" 
                                        CommandArgument='<%# Eval("AppointmentId") %>'
                                        CssClass="btn btn-sm btn-success" 
                                        Visible='<%# Eval("Status").ToString() == "Pending" %>'>
                                        <i class="fas fa-check-circle me-1"></i>Confirm
                                    </asp:LinkButton>
                                    
                                    <asp:LinkButton runat="server" CommandName="Cancel" 
                                        CommandArgument='<%# Eval("AppointmentId") %>'
                                        CssClass="btn btn-sm btn-danger" 
                                        Visible='<%# Eval("Status").ToString() != "Cancelled" %>'>
                                        <i class="fas fa-times-circle me-1"></i>Cancel
                                    </asp:LinkButton>
                                    
                                    <asp:Button runat="server" Text="Treatment Plan" CommandName="Select" 
                                        CssClass="btn btn-sm btn-primary"
                                        Visible='<%# Eval("Status").ToString() == "Confirmed" %>'>
                                    </asp:Button>
                                    
                                    <asp:Button runat="server" Text="Prescription" CommandName="Prescribe" 
                                        CommandArgument='<%# Container.DataItemIndex %>'
                                        CssClass="btn btn-sm btn-info text-white"
                                        Visible='<%# Eval("Status").ToString() == "Confirmed" %>'>
                                    </asp:Button>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

                <asp:Panel ID="pnlPlan" runat="server" Visible="false" CssClass="action-panel card mt-4" style="background: rgba(255, 255, 255, 0.2) !important; backdrop-filter: blur(10px); border: 1px solid rgba(255,255,255,0.2);">
                    <div class="card-header bg-transparent">
                        <i class="fas fa-clinic-medical text-primary me-2"></i> 
                        <strong>Add Treatment Plan for</strong> 
                        <asp:Label ID="lblSelectedPatient" runat="server" CssClass="text-primary fw-bold"></asp:Label>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Diagnosis</label>
                            <asp:TextBox ID="txtDiagnosis" runat="server" CssClass="form-control" placeholder="Enter diagnosis details..." TextMode="MultiLine" Rows="3" style="background: rgba(255,255,255,0.5);" />
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Treatment Steps</label>
                            <asp:TextBox ID="txtSteps" runat="server" CssClass="form-control" placeholder="Describe each step..." TextMode="MultiLine" Rows="4" style="background: rgba(255,255,255,0.5);" />
                        </div>
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Number of Sessions</label>
                                <asp:TextBox ID="txtSessions" runat="server" CssClass="form-control" placeholder="e.g., 4" TextMode="Number" style="background: rgba(255,255,255,0.5);" />
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Estimated Cost ($)</label>
                                <asp:TextBox ID="txtCost" runat="server" CssClass="form-control" placeholder="0.00" TextMode="Number" step="0.01" style="background: rgba(255,255,255,0.5);" />
                            </div>
                        </div>
                        <asp:HiddenField ID="hfAppointmentId" runat="server" />
                        <asp:Button ID="btnSavePlan" runat="server" Text="Save Treatment Plan" CssClass="btn btn-primary w-100 py-2 rounded-pill fw-bold" OnClick="btnSavePlan_Click" />
                        <asp:Label ID="lblMsg" runat="server" Visible="false" CssClass="mt-3 alert alert-info d-block" />
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlPrescription" runat="server" Visible="false" CssClass="action-panel card mt-4" style="background: rgba(255, 255, 255, 0.2) !important; backdrop-filter: blur(10px); border: 1px solid rgba(255,255,255,0.2);">
                    <div class="card-header bg-transparent">
                        <i class="fas fa-prescription-bottle text-success me-2"></i>
                        <strong>Prescription for</strong> 
                        <asp:Label ID="lblPrescriptionPatient" runat="server" CssClass="text-success fw-bold"></asp:Label>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Medication Name</label>
                            <asp:TextBox ID="txtMedName" runat="server" CssClass="form-control" placeholder="e.g., Amoxicillin 500mg" style="background: rgba(255,255,255,0.5);" />
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Dosage & Instructions</label>
                            <asp:TextBox ID="txtDosage" runat="server" CssClass="form-control" placeholder="e.g., 1 tablet every 8 hours for 5 days" TextMode="MultiLine" Rows="2" style="background: rgba(255,255,255,0.5);" />
                        </div>
                        <asp:HiddenField ID="hfPrescriptionAppointmentId" runat="server" />
                        <asp:Button ID="btnSavePrescription" runat="server" Text="Save Prescription" CssClass="btn btn-success w-100 py-2 rounded-pill fw-bold" OnClick="btnSavePrescription_Click" />
                        <asp:Label ID="lblPrescriptionMsg" runat="server" Visible="false" CssClass="mt-3 alert alert-warning d-block" />
                    </div>
                </asp:Panel>

                <div class="mt-5">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-tablets fs-4 me-2" style="color: #1976D2;"></i>
                        <h3 class="section-title">Prescriptions Issued</h3>
                    </div>
                    <asp:GridView ID="gvPrescriptions" runat="server" CssClass="dash-grid mt-3" GridLines="None"
                        AutoGenerateColumns="false" EmptyDataText="📋 No medications prescribed yet">
                        <Columns>
                            <asp:BoundField DataField="PatientName" HeaderText="Patient" />
                            <asp:BoundField DataField="MedicationName" HeaderText="Medication" />
                            <asp:BoundField DataField="Dosage" HeaderText="Dosage" />
                            <asp:TemplateField HeaderText="Dispensed">
                                <ItemTemplate>
                                    <span class='<%# Convert.ToBoolean(Eval("IsDispensed")) ? "status-confirmed" : "status-pending" %>'>
                                        <%# Convert.ToBoolean(Eval("IsDispensed")) ? "✅ Yes" : "⏳ No" %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>

                <div class="mt-5">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-file-medical fs-4 me-2" style="color: #1976D2;"></i>
                        <h3 class="section-title">Treatment Plans</h3>
                    </div>
                    <asp:GridView ID="gvTreatmentPlans" runat="server" CssClass="dash-grid mt-3" GridLines="None"
                        AutoGenerateColumns="false" EmptyDataText="📄 No treatment plans available">
                        <Columns>
                            <asp:BoundField DataField="PatientName" HeaderText="Patient" />
                            <asp:BoundField DataField="Diagnosis" HeaderText="Diagnosis" />
                            <asp:BoundField DataField="TreatmentSteps" HeaderText="Treatment Steps" />
                            <asp:BoundField DataField="SessionsCount" HeaderText="Sessions" />
                            <asp:BoundField DataField="EstimatedCost" HeaderText="Cost ($)" DataFormatString="{0:F2}" />
                            <asp:BoundField DataField="CreatedAt" HeaderText="Date Created" DataFormatString="{0:dd/MM/yyyy}" />
                        </Columns>
                    </asp:GridView>
                </div>
                
                <div class="footer-note mt-4">
                    <i class="fas fa-shield-alt me-1"></i> Secure medical portal | Smile Clinic © 2026
                </div>
            </div>
        </div>
    </form>
</body>
</html>