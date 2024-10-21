<%@ Page Title="" Language="C#" MasterPageFile="~/User/Home.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Foodie_Adda.Index" %>
<%@ Import Namespace="Foodie_Adda" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- offer section -->

    <section class="offer_section layout_padding-bottom">
        <div class="offer_container">
            <div class="container ">
                <div class="row">
                    <asp:Repeater ID="rCategory" runat="server">
                        <ItemTemplate>
                            <div class="col-md-6  ">
                                <div class="box ">
                                    <div class="img-box">
                                        <a href="Menu.aspx?id=<%# Eval("CategoryId") %>">
                                        <img src="<%# Connection.Utils.GetImageUrl( Eval("ImageUrl"))%>" alt="">
                                        </a>
                                    </div>
                                    <div class="detail-box">
                                        <h5><%# Eval("Name") %></h5>
                                        <h6>
                                            <span>20%</span> Off
                                        </h6>
                                        <a href="Menu.aspx?id=<%# Eval("CategoryId") %>">Order Now
             <svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 456.029 456.029" style="enable-background: new 0 0 456.029 456.029;" xml:space="preserve">
                 <g>
                     <g>
                         <path d="M345.6,338.862c-29.184,0-53.248,23.552-53.248,53.248c0,29.184,23.552,53.248,53.248,53.248
              c29.184,0,53.248-23.552,53.248-53.248C398.336,362.926,374.784,338.862,345.6,338.862z" />
                     </g>
                 </g>
                 <g>
                     <g>
                         <path d="M439.296,84.91c-1.024,0-2.56-0.512-4.096-0.512H112.64l-5.12-34.304C104.448,27.566,84.992,10.67,61.952,10.67H20.48
              C9.216,10.67,0,19.886,0,31.15c0,11.264,9.216,20.48,20.48,20.48h41.472c2.56,0,4.608,2.048,5.12,4.608l31.744,216.064
              c4.096,27.136,27.648,47.616,55.296,47.616h212.992c26.624,0,49.664-18.944,55.296-45.056l33.28-166.4
              C457.728,97.71,450.56,86.958,439.296,84.91z" />
                     </g>
                 </g>
                 <g>
                     <g>
                         <path d="M215.04,389.55c-1.024-28.16-24.576-50.688-52.736-50.688c-29.696,1.536-52.224,26.112-51.2,55.296
              c1.024,28.16,24.064,50.688,52.224,50.688h1.024C193.536,443.31,216.576,418.734,215.04,389.55z" />
                     </g>
                 </g>
                 <g>
                 </g>
                 <g>
                 </g>
                 <g>
                 </g>
                 <g>
                 </g>
                 <g>
                 </g>
                 <g>
                 </g>
                 <g>
                 </g>
                 <g>
                 </g>
                 <g>
                 </g>
                 <g>
                 </g>
                 <g>
                 </g>
                 <g>
                 </g>
                 <g>
                 </g>
                 <g>
                 </g>
                 <g>
                 </g>
             </svg>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>


                </div>
            </div>
        </div>
    </section>

    <!-- end offer section -->


    <!-- about section -->

    <section class="about_section layout_padding">
        <div class="container  ">

            <div class="row">
                <div class="col-md-6 ">
                    <div class="img-box">
                        <img src="images/about-img.png" alt="">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="detail-box">
                        <div class="heading_container">
                            <h2>We Are Foodie Adda
                            </h2>
                        </div>
                        <p>
                            Welcome to [Foodie Adda], where passion for great food meets the convenience of modern technology! We believe that ordering food should be as delightful as enjoying it. Our platform connects you with the best local restaurants and food services, offering a wide range of dishes that cater to every palate. Whether you’re craving a classic pizza, a healthy salad, or an exotic international dish, we’ve got you covered!
At [Foodie Adda], quality and customer satisfaction are our top priorities. Our user-friendly interface makes it easy for you to browse menus, customize orders, and track deliveries—all from the comfort of your home. We are committed to ensuring that every meal is delivered fresh, fast, and with the highest standards of service.
Thank you for choosing us as your trusted partner in satisfying your culinary cravings. We look forward to serving you the best food experience, one meal at a time.
                        </p>
                        <a href="About.aspx">Read More
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- end about section -->

   <!-- book section -->
 <section class="book_section layout_padding">
     <div class="container">
         <div class="heading_container">
             <div class="align-self-end">
                 <asp:Label ID="lblMsg" runat="server"></asp:Label>
             </div>
             <h2>Send Your Query</h2>

         </div>
         <div class="row">
             <div class="col-md-6">
                 <div class="form_container">

                     <div>
                         <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Your Name"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Name is required"
                             ControlToValidate="txtName" ForeColor="Red" Display="Dynamic" SetFocusOnError="true">
                         </asp:RequiredFieldValidator>
                     </div>
                     <div>
                         <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Your Email" TextMode="Email"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Email is required"
                             ControlToValidate="txtEmail" ForeColor="Red" Display="Dynamic" SetFocusOnError="true">
                         </asp:RequiredFieldValidator>
                     </div>
                     <div>
                         <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" placeholder="Subject"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="rfvSubject" runat="server" ErrorMessage="Subject is required"
                             ControlToValidate="txtSubject" ForeColor="Red" Display="Dynamic" SetFocusOnError="true">
                         </asp:RequiredFieldValidator>
                     </div>
                     <div>
                         <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" placeholder="Enter Your Query/Feedback"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="rfvMessage" runat="server" ErrorMessage="Query/Feedback is required"
                             ControlToValidate="txtMessage" ForeColor="Red" Display="Dynamic" SetFocusOnError="true">
                         </asp:RequiredFieldValidator>
                     </div>
                    <div class="btn_box">
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-warning rounded-pill pl-4 pr-4 text-white" 
                            OnClick="btnSubmit_Click" />
                     </div>

                 </div>
             </div>
             <div class="col-md-6">
                 <div class="map_container ">
                     <div id="googleMap">
                         
                     </div>
                 </div>
             </div>
         </div>
     </div>
 </section>
 <!-- end book section -->

    <!-- client section -->

    <section class="client_section layout_padding-bottom">
        <div class="container">
            <div class="heading_container heading_center psudo_white_primary mb_45">
                <h2>What Says Our Customers
                </h2>
            </div>
            <div class="carousel-wrap row ">
                <div class="owl-carousel client_owl-carousel">
                    <div class="item">
                        <div class="box">
                            <div class="detail-box">
                                <p>
                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam
                                </p>
                                <h6>Moana Michell
                                </h6>
                                <p>
                                    magna aliqua
                                </p>
                            </div>
                            <div class="img-box">
                                <img src="images/client1.jpg" alt="" class="box-img">
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <div class="box">
                            <div class="detail-box">
                                <p>
                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam
                                </p>
                                <h6>Mike Hamell
                                </h6>
                                <p>
                                    magna aliqua
                                </p>
                            </div>
                            <div class="img-box">
                                <img src="images/client2.jpg" alt="" class="box-img">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- end client section -->
</asp:Content>
