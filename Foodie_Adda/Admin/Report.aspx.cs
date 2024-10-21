﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Foodie_Adda.Admin
{
    public partial class Report : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["breddCrum"] = "Selling Report";
                if (Session["admin"] == null)
                {
                    Response.Redirect("../User/Login.aspx");
                }
               
            }
        }

        private void getReportData(DateTime fromDate, DateTime toDate)
        {
            double grandtotal = 0;
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("SellingReport7781", con);
            cmd.Parameters.AddWithValue("@FromDate", fromDate);
            cmd.Parameters.AddWithValue("@ToDate", toDate);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            if(dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    grandtotal += Convert.ToDouble(dr["TotalPrice"]);
                }
                lblTotal.Text = "Sold Cost: ₹" + grandtotal;
                lblTotal.CssClass = "badge badge-primary";
            }
            rReport.DataSource = dt;
            rReport.DataBind();
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            DateTime fromDate = Convert.ToDateTime(txtFromDate.Text);
            DateTime toDate = Convert.ToDateTime(txtToDate.Text);
            if (toDate > DateTime.Now)
            {
                Response.Write("<script>alert('Todate can not be greater than current date!');</script>");
            }
            else if (fromDate > toDate)
            {
                Response.Write("<script>alert('FromDate can not be greater than toDate!');</script>");
            }
            else
            {
                getReportData(fromDate , toDate);
            }
        }
    }
}