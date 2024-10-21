<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="OrderStatus.aspx.cs" Inherits="Foodie_Adda.Admin.OrderStatus" %>

<%@ Import Namespace="Foodie_Adda" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Include DataTables CSS/JS (Bootstrap Integration) -->
    <link href="https://cdn.datatables.net/1.10.21/css/dataTables.bootstrap4.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/buttons/1.6.4/css/buttons.bootstrap4.min.css" rel="stylesheet">

    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.21/js/dataTables.bootstrap4.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/1.6.4/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/1.6.4/js/buttons.bootstrap4.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/1.6.4/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/1.6.4/js/buttons.print.min.js"></script>

    <!-- Script for Auto Hiding the Message -->
    <script>  
        window.onload = function () {
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID%>").style.display = "none";
            }, 5000);
        };
 </script>

    <!-- DataTables Initialization -->
    <script>
        $(document).ready(function () {
            $('#categoryTable').DataTable({
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
        <div class="align-align-self-end">
            <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
        </div>
        <div class="main-body">
            <div class="page-wrapper">
                <div class="page-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-header">
                                </div>
                                <div class="card-block">
                                    <div class="row">


                                        <div class="col-sm-6 col-md-8 col-lg-8">
                                            <h3 class="sub-title">Order List</h3>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">
                                                    <table id="categoryTable" class="table table-striped table-bordered">
                                                        <thead>
                                                            <tr>
                                                                <th class="table-plus">Order No.</th>
                                                                <th>Order Date</th>
                                                                <th>Status</th>
                                                                <th>Product Name</th>
                                                                <th>Total Price</th>
                                                                <th>Payment Mode</th>
                                                                <th class="datatable-nosort">Edit</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <asp:Repeater ID="rOrderStatus" runat="server" OnItemCommand="rOrderStatus_ItemCommand">
                                                                <ItemTemplate>
                                                                    <tr>
                                                                        <td>
                                                                            <%# Eval("OrderNo") %>
                                                                        </td>
                                                                        <td>
                                                                            <%# Eval("OrderDate") %>
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'
                                                                                CssClass='<%# Eval("Status").ToString() == "Delivered" ? "badge badge-success" : "badge badge-warning"  %>'></asp:Label>
                                                                        </td>
                                                                        <td><%# Eval("Name") %></td>
                                                                        <td><%# Eval("TotalPrice") %></td>
                                                                        <td><%# Eval("PaymentMode") %></td>

                                                                        <td>
                                                                            <asp:LinkButton ID="lnkEdit" Text="Edit" runat="server" CssClass="badge badge-primary"
                                                                                CommandArgument='<%# Eval("OrderDetailsId") %>' CommandName="edit">
                                                            <i class="ti-pencil"></i>
                                                                            </asp:LinkButton>
                                                                        </td>
                                                                    </tr>
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>


                                        </div>


                                        <div class="col-sm-6 col-md-4 col-lg-4 mobile-inputs">
                                            <asp:Panel ID="pUpdateOrderStatus" runat="server">
                                                <h3 class="sub-title">Update Status</h3>
                                                <div>
                                                <div class="form-group">
                                                    <label>Order Status</label>

                                                    <div>
                                                    <asp:DropDownList ID="ddlOrderStatus" runat="server" CssClass="form-control">
                                                        <asp:ListItem Value="0">Select Status</asp:ListItem>
                                                        <asp:ListItem>Pending</asp:ListItem>
                                                        <asp:ListItem>Dispached</asp:ListItem>
                                                        <asp:ListItem>Delivered</asp:ListItem>
                                                    </asp:DropDownList>
                                                        <asp:RequiredFieldValidator ID="rfvDdlOrderStatus" runat="server" ForeColor="Red" ControlToValidate="ddlOrderStatus"
                                                            ErrorMessage="Order Staus is Required" SetFocusOnError="true" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                                                    <asp:HiddenField ID="hdnId" runat="server" Value="0" />
                                                    </div>
                                                </div>
                                                
                                                <div class="pb-5">
                                                    <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-primary" 
                                                        OnClick="btnUpdate_Click" />
                                                    &nbsp;
    
                                                   <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-primary" 
                                                      OnClick="btnCancel_Click" />
                                                </div>
                                                
                                             </div>
                                            </asp:Panel>

                                        </div>

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
