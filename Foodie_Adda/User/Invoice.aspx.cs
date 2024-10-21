using iTextSharp.text.pdf;
using iTextSharp.text;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace Foodie_Adda.User
{
    public partial class Invoice : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["userId"] != null)
                {
                    if (Request.QueryString["id"] != null)
                    {
                        ViewState["paymentid"] = Request.QueryString["id"].ToString();
                        rOrderItem.DataSource = GetOrderDetails();
                        rOrderItem.DataBind();
                    }
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        DataTable GetOrderDetails()
        {
            double grandTotal = 0;
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Invoice7781", con);
            cmd.Parameters.AddWithValue("@Action", "INVOICEBYID");
            cmd.Parameters.AddWithValue("@PaymentId", ViewState["paymentid"]);
            cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow drow in dt.Rows)
                {
                    grandTotal += Convert.ToDouble(drow["TotalPrice"]);
                }
            }
            DataRow dr = dt.NewRow();
            dr["TotalPrice"] = grandTotal;
            dt.Rows.Add(dr);
            return dt;
        }

        protected void lbDownloadInvoice_Click(object sender, EventArgs e)
        {
            // Get the invoice details
            DataTable dtInvoice = GetOrderDetails();

            if (dtInvoice.Rows.Count > 0)
            {
                // Create a PDF document
                Document pdfDoc = new Document(PageSize.A4, 25, 25, 30, 30);
                using (MemoryStream memoryStream = new MemoryStream())
                {
                    PdfWriter writer = PdfWriter.GetInstance(pdfDoc, memoryStream);
                    pdfDoc.Open();

                    // Add Title
                    Paragraph title = new Paragraph("Order Invoice\n\n", new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD, BaseColor.BLACK));
                    title.Alignment = Element.ALIGN_CENTER;
                    pdfDoc.Add(title);

                    //// Add Customer Details (if needed)
                    //Paragraph customerDetails = new Paragraph("Customer ID: " + Session["userId"].ToString() + "\nInvoice ID: " + ViewState["paymentid"].ToString() + "\n\n");
                    //pdfDoc.Add(customerDetails);

                    // Create a table with the same columns as your Repeater
                    PdfPTable table = new PdfPTable(6);
                    table.WidthPercentage = 100;
                    table.SetWidths(new float[] { 10, 15, 30, 15, 15, 15 }); // Set the column widths

                    // Add Table Headers
                    table.AddCell("Sr.No");
                    table.AddCell("Order No");
                    table.AddCell("Item Name");
                    table.AddCell("Unit Price");
                    table.AddCell("Quantity");
                    table.AddCell("Total Price");

                    // Add Rows to the table
                    foreach (DataRow row in dtInvoice.Rows)
                    {
                        table.AddCell(row["Srno"].ToString());
                        table.AddCell(row["OrderNo"].ToString());
                        table.AddCell(row["Name"].ToString());
                        table.AddCell("₹" + row["Price"].ToString());
                        table.AddCell(row["Quantity"].ToString());
                        table.AddCell("₹" + row["TotalPrice"].ToString());
                    }

                    // Add Total Price
                    table.AddCell("");
                    table.AddCell("");
                    table.AddCell("");
                    table.AddCell("");
                    table.AddCell("Grand Total:");
                    table.AddCell("₹" + dtInvoice.Rows[dtInvoice.Rows.Count - 1]["TotalPrice"].ToString());

                    pdfDoc.Add(table);

                    // Close the PDF document
                    pdfDoc.Close();

                    // Download the PDF file
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("content-disposition", "attachment; filename=Invoice_" + ViewState["paymentid"] + ".pdf");
                    Response.BinaryWrite(memoryStream.ToArray());
                    Response.End();
                }
            }
        }
    }
}