<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Contacts.aspx.cs" Inherits="Foodie_Adda.Admin.Contacts" %>
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
            $('#contactTable').DataTable({
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
                                     <div class="col-12 mobile-inputs">
                                         <h3 class="sub-title">Contact Lists</h3>
                                         <div class="card-block table-border-style">
                                             <div class="table-responsive">
                                                 <table id="contactTable" class="table table-striped table-bordered">
                                                     <thead>
                                                         <tr>
                                                             <th class="table-plus">SrNo</th>
                                                             <th>User Name</th>
                                                             <th>Email</th>
                                                             <th>Subject</th>
                                                             <th>Message</th>
                                                             <th>Contact Date</th>
                                                             <th class="datatable-nosort">Delete</th>
                                                         </tr>
                                                     </thead>
                                                     <tbody>
                                                         <asp:Repeater ID="rContacts" runat="server" OnItemCommand="rContacts_ItemCommand">
                                                             <ItemTemplate>
                                                                 <tr>
                                                                     <td class="table-plus"><%# Eval("SrNo") %></td>
                                                                     <td><%# Eval("Name") %></td>
                                                                     <td><%# Eval("Email") %></td>
                                                                     <td><%# Eval("Subject") %></td>
                                                                     <td><%# Eval("Message") %></td>
                                                                     <td><%# Eval("CreatedDate") %></td>

                                                          <td>
                                                           <asp:LinkButton ID="lnkDelete" Text="Delete" runat="server" CssClass="badge bg-danger"
                                                                  CommandArgument='<%# Eval("ContactId") %>' CommandName="delete"
                                                                  OnClientClick="return confirm('Do you want to delete this record?');">
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
