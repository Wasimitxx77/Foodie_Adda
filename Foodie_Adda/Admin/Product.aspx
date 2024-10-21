<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="Foodie_Adda.Admin.Product" %>

<%@ Import Namespace="Foodie_Adda" %>
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

    <script>  
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID%>").style.display = "none";
            }, seconds * 1000);
            // Initialize the DataTable after the page is fully loaded
            $('#productTable').DataTable({
                dom: 'Bfrtip',  // Define where the buttons should appear
                buttons: [
                    'csv', 'pdf', 'print'  // CSV, PDF, and Print buttons
                ],
                paging: true,       // Enable pagination
                searching: true,    // Enable searching
                info: true,         // Show information about the records
                ordering: true,     // Enable column sorting
                lengthChange: true, // Allow the user to change the number of displayed rows
                autoWidth: false    // Disable auto width calculation
            });
        };

    </script>
    <script>
        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=imgProduct.ClientID%>').prop('src', e.target.result)
                        .width(200)
                        .height(200);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
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

                                        <div class="col-sm-6 col-md-4 col-lg-4">
                                            <h3 class="sub-title">Product</h3>
                                            <div class="form-group">
                                                <label>Product Name</label>
                                                <div>
                                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control"
                                                        placeholder="Enter Product Name"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                                        ErrorMessage="Name is required" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtName"></asp:RequiredFieldValidator>
                                                    <asp:HiddenField ID="hdnId" runat="server" Value="0" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label>Product Description</label>
                                                <div>
                                                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control"
                                                        placeholder="Enter Product Description" TextMode="MultiLine"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                                        ErrorMessage="Description is required" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtDescription">
                                                    </asp:RequiredFieldValidator>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label>Product Price(₹)</label>
                                                <div>
                                                    <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control"
                                                        placeholder="Enter Product Price"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                                        ErrorMessage="Price is required" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtPrice">
                                                    </asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                                        ErrorMessage="Price must be in decimal (e.g., 123.45)" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"
                                                        ControlToValidate="txtPrice" ValidationExpression="^\d{0,8}(\.\d{1,4})?$">
                                                    </asp:RegularExpressionValidator>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label>Product Quantity</label>
                                                <div>
                                                    <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control"
                                                        placeholder="Enter Product Quantity"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                                        ErrorMessage="Quantity is required" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtQuantity">
                                                    </asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                                                        ErrorMessage="Quantity must be non negative (e.g., 123.45)" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"
                                                        ControlToValidate="txtQuantity" ValidationExpression="^([1-9]\d*|0)?$">
                                                    </asp:RegularExpressionValidator>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label>Product Image</label>
                                                <div>
                                                    <asp:FileUpload ID="fuProductImage" runat="server" CssClass="form-control" onchange="ImagePreview(this);" />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label>Product Category</label>
                                                <div>
                                                    <asp:DropDownList ID="ddlCategories" runat="server" CssClass="form-control" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="CategoryId" AppendDataBoundItems="true">

                                                        <asp:ListItem Value="0">Select Category</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                                                        ForeColor="Red" ErrorMessage="Category is required" SetFocusOnError="true"
                                                        Display="Dynamic" ControlToValidate="ddlCategories" InitialValue="0">
                                                    </asp:RequiredFieldValidator>
                                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MyFood %>" SelectCommand="SELECT [CategoryId], [Name] FROM [Categories]"></asp:SqlDataSource>
                                                </div>
                                            </div>

                                            <div class="form-check pl-4">
                                                <asp:CheckBox ID="cbIsActive" runat="server" Text="&nbsp; IsActive" CssClass="form-check-input" />
                                            </div>
                                            <div class="pb-5">
                                                <asp:Button ID="btnAddOrUpdate" runat="server" Text="Add" CssClass="btn btn-primary"
                                                    OnClick="btnAddOrUpdate_Click" />
                                                &nbsp;
                                       <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-primary"
                                           CausesValidation="false" OnClick="btnClear_Click" />


                                            </div>
                                            <asp:Image ID="imgProduct" runat="server" CssClass="img-thumbnail" />
                                        </div>

                                        <div class="col-sm-6 col-md-8 col-lg-8 mobile-inputs">
                                            <h3 class="sub-title">Product Lists</h3>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">

                                                    <table id="productTable" class="table table-striped table-bordered">
                                                        <thead>
                                                            <tr>

                                                                <th class="table-plus">Name</th>
                                                                <th>Image</th>
                                                                <th>Price(₹)</th>
                                                                <th>Qty</th>
                                                                <th>Category</th>
                                                                <th>IsActive</th>
                                                                <th>Description</th>
                                                                <th>CreatedDate</th>
                                                                <th class="datatable-nosort">Action</th>


                                                            </tr>
                                                        </thead>
                                                        <tbody>

                                                            <asp:Repeater ID="rProduct" runat="server" OnItemCommand="rProduct_ItemCommand"
                                                                OnItemDataBound="rProduct_ItemDataBound">


                                                                <ItemTemplate>
                                                                    <tr>
                                                                        <td class="table-plus"><%#Eval("Name") %>  </td>
                                                                        <td>

                                                                            <img alt="" width="40" src="<%# Connection.Utils.GetImageUrl(Eval ("ImageUrl")) %>" />
                                                                        </td>

                                                                        <td><%#Eval("Price") %> 
                                                                        </td>

                                                                        <td>
                                                                            <asp:Label ID="lblQuantity" runat="server" Text='<%#Eval("Quantity") %>'> </asp:Label>
                                                                        </td>

                                                                        <td><%#Eval("CategoryName") %>
                                                                        </td>

                                                                        <td>
                                                                            <asp:Label ID="lblIsActive" runat="server" Text='<%#Eval("IsActive") %>'> </asp:Label>
                                                                        </td>

                                                                        <td><%#Eval("Description") %>
                                                                        </td>

                                                                        <td><%#Eval("CreatedDate") %> 

                                                                        </td>
                                                                        <td>
                                                                            <asp:LinkButton ID="lnkEdit" Text="Edit" runat="server"
                                                                                CssClass="badge badge-primary" CausesValidation="false"
                                                                                CommandArgument='<%# Eval("ProductId") %>' CommandName="edit">
                                                                <i class="ti-pencil"></i>
                                                                            </asp:LinkButton>

                                                                            <asp:LinkButton ID="lnkDelete" Text="Delete" runat="server" CssClass="badge bg-danger"
                                                                                CommandArgument='<%# Eval("ProductId") %>' CommandName="delete"
                                                                                OnClientClick="return confirm('Do you want to delete this product?');"
                                                                                CausesValidation="false">
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
