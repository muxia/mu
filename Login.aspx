<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>在线考试系统</title>
    <link href="xStyleSheet.css" rel="stylesheet" type="text/css" />
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center" style="width: 963px; height: 513px;">
        &nbsp;
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td style="height: 16px"><img src="images/登陆页面.jpg" width="980" height="200" alt="" /></td>
      </tr>
    </table>
      <table width="100%" border="1" cellspacing="0" cellpadding="0"  bordercolorlight="#FFFFFF">
        <tr>
          <td>
          <table width="80%"  border="1" align="center" cellpadding="0" cellspacing="0" bordercolordark="#000000" bordercolorlight="#FFFFFF" style="height: 202px">
         
              <td width="200">
              <div align="center">
                  <asp:Label ID="lblAccount" runat="server"  Text="账号(ID)：" ></asp:Label>
                &nbsp;
                </div>
                </td>
              <td align="left" style="width: 277px" >
              <asp:TextBox ID="txtNum" runat="server"  Height="25" Width="176px"></asp:TextBox>
              </td>
              <td width="122" align="center" >
              <asp:RadioButtonList ID="rblUserID" runat="server" RepeatDirection="Horizontal"  AutoPostBack="True"  OnSelectedIndexChanged="rblUserID_SelectedIndexChanged">
                  <asp:ListItem Selected="True">ID</asp:ListItem>
                  <asp:ListItem>用户名</asp:ListItem>
              </asp:RadioButtonList>
              </td>
              <td width="109" align="center" height="50">
              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtNum"
                        Display="Dynamic" ErrorMessage="请输入账号" ForeColor="DarkGray" Font-Size="10pt">
               </asp:RequiredFieldValidator>
                &nbsp;
                </td>
            <tr>
              <td height="50" ><div align="center"> 密 码：</div></td>
              <td colspan="2" align="left" ><asp:TextBox ID="txtPwd" runat="server" MaxLength="12" TextMode="Password"  Height="25" Width="176px"></asp:TextBox>&nbsp;
              </td>
              <td align="center" >
              <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPwd"
                        Display="Dynamic" ErrorMessage="密码不能为空" ForeColor="DimGray" Font-Size="10pt">
                        </asp:RequiredFieldValidator>
                &nbsp;
                </td>
            </tr>
            <tr>
            <td height="50" >
              <div align="center"> 身 份：</div>
          </td>
              <td colspan="2" align="left" >
              <asp:DropDownList ID="ddlstatus" runat="server"  Font-Size="Larger" Height="25" Width="121px">
                  <asp:ListItem >学生</asp:ListItem>
                  <asp:ListItem>教师</asp:ListItem>
                  <asp:ListItem Selected="True">管理员</asp:ListItem>
                </asp:DropDownList>
                &nbsp;
                </td>
             <td align="center" style="width: 62px; height: 30px;">&nbsp;</td>
            </tr>
            <tr>
              <td style="height: 50px" >
              <div align="center"> 验证码：</div>
              </td>
              <td align="left" style="width: 277px; height: 20px;" ><asp:TextBox ID="txtCode" runat="server" Height="25px" Width="112px"></asp:TextBox></td>
              <td align="center" style="height: 20px" ><asp:Image ID="Image1" runat="server" Width="100px" BorderColor="Gray" BorderWidth="1px" Height="32px" ImageUrl="~/Image.aspx" />
              </td>
              <td align="center" style="height: 20px" >
              <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtCode"
              Display="Dynamic" ErrorMessage="请输入验证码" ForeColor="DimGray" Font-Size="10pt"></asp:RequiredFieldValidator>
                &nbsp;
                </td>
            </tr>     
              <td height="50px" colspan="5"  align="center">&nbsp;
                  <asp:Button ID="btnlogin" runat="server" Text="登录" OnClick="btnlogin_Click" Height="30px" width="5cm" />            
                &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnconcel" runat="server" Text="取消" OnClick="btnconcel_Click" CausesValidation="False" Height="30px" width="5cm" />
                <tr>
              <td colspan="5" >&nbsp;
                  <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label></td>
            </tr>
          </table>
                </td>
       
          </table>
          </td>
        </tr>
      </table>
      </td>
  </tr>
</table>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
            ShowSummary="False" />
    </form>
</body>
</html>








using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;


public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["accountMode"] = "id";
        }
    }
    protected void btnlogin_Click(object sender, EventArgs e)
    {
        if (txtCode.Text.Trim() != Session["verify"].ToString())
        {
            Response.Write("<script>alert('验证码错误');location='Login.aspx'</script>");
        }
        else
        {
            if (this.ddlstatus.SelectedValue == "学生")
            {
                if (BaseClass.CheckStudent(txtNum.Text.Trim(), txtPwd.Text.Trim()))
                {
                    Session["studentID"] = txtNum.Text.Trim();
                    Response.Redirect("student/student.aspx");
                }
                else
                {
                    Response.Write("<script>alert('您不是学生或者用户名和密码错误');location='Login.aspx'</script>");
                }
            }
            if (this.ddlstatus.SelectedValue == "教师")
                {
                    string mode=Session["accountMode"].ToString();
                    if (mode=="id")
                    {
                        if (BaseClass.CheckTeacher(txtNum.Text.Trim(), txtPwd.Text.Trim()))
                        {
                            Session["teacherID"] = txtNum.Text;
                            Response.Redirect("teacher/Teacher.aspx");
                        }
                        else
                        {
                            Response.Write("<script>alert('您不是教师或者用户名和密码错误');location='Login.aspx'</script>");
                        }
                    }
                    else
                    {
                        Response.Write("<script>alert('你现在是用账户名来登录');location='Login.aspx'</script>");

                        string id = BaseClass.CheckTeacherByName(txtNum.Text.Trim(), txtPwd.Text.Trim());
                        Label1.Text = id;
                     
                        if (id != "")
                        {
                            Session["teacherID"] = id;
                            Response.Redirect("teacher/Teacher.aspx");
                        }
                        else
                        {
                            Response.Write("<script>alert('您不是教师或者用户名和密码错误');location='Login.aspx'</script>");
                        }
                    }
                }

            
            if (this.ddlstatus.SelectedValue == "管理员")
            {
                string mode = Session["accountMode"].ToString();
                if (mode=="id")
                {
                    if (BaseClass.CheckAdmin(txtNum.Text.Trim(), txtPwd.Text.Trim()))
                    {
                        Session["admin"] = txtNum.Text;

                        Response.Redirect("admin/Admin.aspx");
                    }
                    else
                    {
                        Response.Write("<script>alert('您不是管理员或者用户名和密码错误');location='Login.aspx'</script>");
                    }
                }
                else
                {
                    if (BaseClass.CheckAdminByName(txtNum.Text.Trim(), txtPwd.Text.Trim()))
                    {
                        Session["adminName"] = txtNum.Text;
                        Session["admin"] = "";
                        Response.Redirect("admin/Admin.aspx");
                    }
                    else
                    {
                        Response.Write("<script>alert('您不是管理员或者用户名和密码错误');location='Login.aspx'</script>");
                    }
                }
            }
        }
    }
    protected void btnconcel_Click(object sender, EventArgs e)
    {
        RegisterStartupScript("提示", "<script>window.close();</script>");
    }
    protected void rblUserID_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rblUserID.SelectedIndex == 1)
        {
            lblAccount.Text = "账号(名)";
            Session["accountMode"] = "name"; 
            txtNum.Text = "";
            txtPwd.Text = "";
            txtCode.Text = "";
        }
        else
        {
            lblAccount.Text = "账号(ID)";
            Session["accountMode"] = "id"; 
            txtNum.Text = "";
            txtPwd.Text = "";
            txtCode.Text = "";
        }
    }
}


