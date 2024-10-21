using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Xml.Linq;

namespace Foodie_Adda.User
{
    public partial class Payment : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataReader dr, dr1;
        DataTable dt;
        SqlTransaction transaction = null;
        string name = string.Empty; string cardNo = string.Empty; string expiryDate = string.Empty; string cvv = string.Empty;
        string address = string.Empty; string paymentMode = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["userId"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        protected void lbCardSubmit_Click(object sender, EventArgs e)
        { 
            name = txtName.Text.Trim();
            cardNo = txtCardNo.Text.Trim();
            cardNo = string.Format("************{0}", txtCardNo.Text.Trim().Substring(12, 4));
            expiryDate = txtExpMonth.Text.Trim() + "/" + txtExpYear.Text.Trim();
            cvv = txtCvv.Text.Trim();
            address = txtAddress.Text.Trim();
            paymentMode = "card";
            if (Session["userId"] != null)
            {
                OrderPayment(name, cardNo, expiryDate, cvv, address, paymentMode);
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void lbCodSubmit_Click(object sender, EventArgs e)
        {
            address = txtAddress.Text.Trim();
            paymentMode = "cod";
            if (Session["userId"] != null)
            {
                OrderPayment(name, cardNo, expiryDate, cvv, address, paymentMode);
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        void OrderPayment(string name, string cardNo, string expiryDate, string cvv, string address, string paymentMode)
        {
            int paymentId = 0;
            int productId = 0;
            int quantity = 0;

            // Prepare DataTable to hold order details
            dt = new DataTable();
            dt.Columns.AddRange(new DataColumn[7]
            {
        new DataColumn("OrderNo", typeof(string)),
        new DataColumn("ProductId", typeof(int)),
        new DataColumn("Quantity", typeof(int)),
        new DataColumn("UserId", typeof(int)),
        new DataColumn("Status", typeof(string)),
        new DataColumn("PaymentId", typeof(int)),
        new DataColumn("OrderDate", typeof(DateTime)),
            });

            con = new SqlConnection(Connection.GetConnectionString());
            con.Open();

            #region Sql Transaction
            transaction = con.BeginTransaction();
            try
            {
                // Save payment details
                cmd = new SqlCommand("Save_Payment7781", con, transaction);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@CardNo", cardNo);
                cmd.Parameters.AddWithValue("@ExpiryDate", expiryDate);
                cmd.Parameters.AddWithValue("@Cvv", cvv);
                cmd.Parameters.AddWithValue("@Address", address);
                cmd.Parameters.AddWithValue("@PaymentMode", paymentMode);
                cmd.Parameters.Add("@InsertedId", SqlDbType.Int).Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();

                // Get inserted payment ID
                paymentId = Convert.ToInt32(cmd.Parameters["@InsertedId"].Value);

                // Retrieve cart items
                cmd = new SqlCommand("Cart_Crud7781", con, transaction);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Action", "SELECT");
                cmd.Parameters.AddWithValue("@UserId", Convert.ToInt32(Session["userId"]));
                dr = cmd.ExecuteReader();

                // Fetch product ID and quantity from cart items
                while (dr.Read())
                {
                    productId = dr["ProductId"] != DBNull.Value ? Convert.ToInt32(dr["ProductId"]) : 0;

                    quantity = dr["Quantity"] != DBNull.Value ? Convert.ToInt32(dr["Quantity"]) : 0;

                    if (productId == 0 || quantity == 0) continue;

                    // Update product quantity
                    UpdateQuantity(productId, quantity, transaction, con);

                    // Remove item from cart
                    DeleteCartItem(productId, transaction, con);

                    dt.Rows.Add(Connection.Utils.GetUniqueId(), productId, quantity, Convert.ToInt32(Session["userId"]), "Pending",
                                paymentId, DateTime.Now);
                }
                dr.Close();

                // Save order details
                if (dt.Rows.Count > 0)
                {
                    cmd = new SqlCommand("Save_Orders7781", con, transaction);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@tblOrders", dt);
                    cmd.ExecuteNonQuery();
                }

                // Commit transaction and display success message
                transaction.Commit();
                lblMsg.Visible = true;
                lblMsg.Text = "Your item ordered successfully!!!";
                lblMsg.CssClass = "alert alert-success";

                // Add a small delay before redirecting (2 seconds)
                Response.AddHeader("REFRESH", "1;URL=Invoice.aspx?id=" + paymentId);
            }
            catch (Exception ex)
            {
                // Rollback transaction in case of error
                try
                {
                    transaction.Rollback();
                }
                catch (Exception rollbackEx)
                {
                    Response.Write("<script>alert('Transaction rollback failed: " + rollbackEx.Message + "');</script>");
                }

                // Display the main error message
                lblMsg.Visible = true;
                lblMsg.Text = "An error occurred: " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
            finally
            {
                con.Close();
            }
            #endregion Sql Transaction
        }

        void UpdateQuantity(int productId, int quantity, SqlTransaction sqlTransaction, SqlConnection sqlConnection)
        {
            int dbQuantity;
            cmd = new SqlCommand("Product_Crud7781", sqlConnection, sqlTransaction);
            cmd.Parameters.AddWithValue("@Action", "GETBYID");
            cmd.Parameters.AddWithValue("@ProductId", productId);
            cmd.CommandType = CommandType.StoredProcedure;

            try
            {
                dr1 = cmd.ExecuteReader();
                while (dr1.Read())
                {
                    dbQuantity = (int)dr1["Quantity"];
                    if (dbQuantity > quantity && dbQuantity > 2)
                    {
                        dbQuantity = dbQuantity - quantity;
                        cmd = new SqlCommand("Product_Crud7781", sqlConnection, sqlTransaction);
                        cmd.Parameters.AddWithValue("@Action", "QTYUPDATE");
                        cmd.Parameters.AddWithValue("@Quantity", dbQuantity);
                        cmd.Parameters.AddWithValue("@ProductId", productId);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.ExecuteNonQuery();
                    }
                }
                dr1.Close();
            }
            catch (Exception ex)
            {
                Response.Write("<script> alert('" + ex.Message + "');</script > ");
            }
        }

        void DeleteCartItem(int productId, SqlTransaction sqlTransaction, SqlConnection sqlConnection)
        {
            cmd = new SqlCommand("Cart_Crud7781", sqlConnection, sqlTransaction);
            cmd.Parameters.AddWithValue("@Action", "DELETE");
            cmd.Parameters.AddWithValue("@ProductId", productId);
            cmd.Parameters.AddWithValue("@UserId", Convert.ToInt32(Session["userId"]));
            cmd.CommandType = CommandType.StoredProcedure;


            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error - " + ex.Message + ");<script>");
            }
        }
    }
}
