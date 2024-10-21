<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="Foodie_Adda.Admin.Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Bootstrap CSS and DataTables CSS -->
    <link href="https://cdn.datatables.net/1.10.21/css/dataTables.bootstrap4.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/buttons/1.6.4/css/buttons.bootstrap4.min.css" rel="stylesheet">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.21/js/dataTables.bootstrap4.min.js"></script>

    <!-- DataTables Buttons JS -->
    <script src="https://cdn.datatables.net/buttons/1.6.4/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/1.6.4/js/buttons.bootstrap4.min.js"></script>

    <!-- PDFMake (for PDF export) -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>

    <!-- JSZip (for CSV/Excel export) -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>

    <!-- Buttons for CSV, PDF, Print -->
    <script src="https://cdn.datatables.net/buttons/1.6.4/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/1.6.4/js/buttons.print.min.js"></script>

    <!-- DataTables Initialization -->
    <script>
        $(document).ready(function () {
            $('#reportTable').DataTable({
                dom: 'Bfrtip',
                buttons: ['csv', 'pdf', 'print'],
                paging: true,
                searching: true,
                ordering: true,
                info: true,
                lengthChange: true,
                autoWidth: false
            });
        });
 </script>

    <div class="pcoded-inner-content pt-0">

        <div class="main-body">
            <div class="page-wrapper">
                <div class="page-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-header">
                                    <div class="container">
                                        <div class="form-row">
                                            <div class="form-group col-md-4">
                                                <label>From Date</label>
                                                <asp:RequiredFieldValidator ID="rfvFromDate" runat="server" ForeColor="Red" ErrorMessage="*"
                                                    SetFocusOnError="true" Display="Dynamic" ControlToValidate="txtFromDate"></asp:RequiredFieldValidator>
                                                <asp:TextBox ID="txtFromDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label>To Date</label>
                                                <asp:RequiredFieldValidator ID="rfvToDate" runat="server" ForeColor="Red" ErrorMessage="*"
                                                    SetFocusOnError="true" Display="Dynamic" ControlToValidate="txtToDate"></asp:RequiredFieldValidator>
                                                <asp:TextBox ID="txtToDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary mt-md-4"
                                                    OnClick="btnSearch_Click" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-block">
                                    <div class="row">
                                        <div class="col-12 mobile-inputs">
                                            <h3 class="sub-title">Selling Report</h3>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">
                                                    <table id="reportTable" class="table table-striped table-bordered">
                                                        <thead>
                                                            <tr>
                                                                <th>SrNo</th>
                                                                <th>Full Name</th>
                                                                <th>Email</th>
                                                                <th>Item Orders</th>
                                                                <th>Total Cost</th>

                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <asp:Repeater ID="rReport" runat="server">
                                                                <ItemTemplate>
                                                                    <tr>
                                                                        <td><%# Eval("SrNo") %></td>
                                                                        <td><%# Eval("Name") %></td>
                                                                        <td><%# Eval("Email") %></td>
                                                                        <td><%# Eval("TotalOrders") %></td>
                                                                        <td><%# Eval("TotalPrice") %></td>

                                                                    </tr>
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row pl-4">
                                        <asp:Label ID="lblTotal" runat="server" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
