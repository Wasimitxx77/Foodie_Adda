<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Category.aspx.cs" Inherits="Foodie_Adda.Admin.Category" %>

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

    <!-- Script for Image Preview -->
    <script>
        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=imgCategory.ClientID%>').prop('src', e.target.result)
                        .width(200)
                        .height(200);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
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

                                        <!-- Category Form Section -->
                                        <div class="col-sm-6 col-md-4 col-lg-4">
                                            <h3 class="sub-title">Category</h3>
                                            <div class="form-group">
                                                <label>Category Name</label>
                                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter Category Name" required></asp:TextBox>
                                                <asp:HiddenField ID="hdnId" runat="server" Value="0" />
                                            </div>
                                            <div class="form-group">
                                                <label>Category Image</label>
                                                <asp:FileUpload ID="fuCategoryImage" runat="server" CssClass="form-control" onchange="ImagePreview(this);" />
                                            </div>
                                            <div class="form-check pl-4">
                                                <asp:CheckBox ID="cbIsActive" runat="server" Text="&nbsp; IsActive" CssClass="form-check-input" />
                                            </div>
                                            <div class="pb-5">
                                                <asp:Button ID="btnAddOrUpdate" runat="server" Text="Add" CssClass="btn btn-primary" OnClick="btnAddOrUpdate_Click" />
                                                &nbsp;
                                                <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-primary" CausesValidation="false" OnClick="btnClear_Click" />
                                            </div>
                                            <asp:Image ID="imgCategory" runat="server" CssClass="img-thumbnail" />
                                        </div>

                                        <!-- Category List Section with DataTable -->
                                        <div class="col-sm-6 col-md-8 col-lg-8 mobile-inputs">
                                            <h3 class="sub-title">Category Lists</h3>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">
                                                    <table id="categoryTable" class="table table-striped table-bordered">
                                                        <thead>
                                                            <tr>
                                                                <th class="table-plus">Name</th>
                                                                <th>Image</th>
                                                                <th>IsActive</th>
                                                                <th>Created Date</th>
                                                                <th class="datatable-nosort">Action</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <asp:Repeater ID="rCategory" runat="server" OnItemCommand="rCategory_ItemCommand" OnItemDataBound="rCategory_ItemDataBound">
                                                                <ItemTemplate>
                                                                    <tr>
                                                                        <td><%# Eval("Name") %></td>
                                                                        <td>
                                                                            <img alt="" width="40px" src="<%# Connection.Utils.GetImageUrl(Eval ("ImageUrl")) %>" />
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label ID="lblIsActive" runat="server" Text='<%# Eval("IsActive") %>'></asp:Label>
                                                                        </td>
                                                                        <td><%# Eval("CreatedDate") %></td>
                                                                
                                                                <td>
                                                                    <asp:LinkButton ID="lnkEdit" Text="Edit" runat="server" CssClass="badge badge-primary"
                                                                        CommandArgument='<%# Eval("CategoryId") %>' CommandName="edit">
                                                                    <i class="ti-pencil"></i>
                                                                    </asp:LinkButton>

                                                                    <asp:LinkButton ID="lnkDelete" Text="Delete" runat="server" CssClass="badge bg-danger"
                                                                        CommandArgument='<%# Eval("CategoryId") %>' CommandName="delete"
                                                                        OnClientClick="return confirm('Do you want to delete this category?');">
                                                                  <i class="ti-trash"></i>
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