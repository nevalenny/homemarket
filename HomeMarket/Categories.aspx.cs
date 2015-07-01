using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NLog;

namespace HomeMarket
{
    public partial class Categories : System.Web.UI.Page
    {
        private Models.Repository repository = new Models.Repository();
        private static Logger logger { get; set; }
        public static Models.category emptyCategory = new Models.category();
        public static Models.category addCategory = new Models.category();
        public static Models.category editCategory = new Models.category();
        public static Models.category deleteCategory = new Models.category();
        public static String s_img_empty = "/Images/gem.png";
        public static String s_img_loading = "/Images/loading_spinner.gif";

        protected Categories()
        {
            logger = LogManager.GetCurrentClassLogger();
        }

        protected IEnumerable<Models.category> GetCategories()
        {
            return repository.Categories;
        }

        protected Models.category GetCategoryById(int Id)
        {
            try
            {
                return (from category in repository.Categories where category.ID == Id select category).First();
            }
            catch (Exception ex)
            {
                logger.ErrorException("Error occured on accessing DataBase", ex);
            }
            return emptyCategory;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    if (User.IsInRole("admins"))
                    {
                        // show invisible categories for admin
                        sds_categories.SelectCommand = "SELECT [ID], [Name], [Description], [Picture], [isVisible] FROM [categories] WHERE [isDeleted] = 'false' ORDER BY [Name] ASC";
                    }
                    rpt_categories.DataSource = sds_categories;
                    rpt_categories.DataBind();

                }
                catch (Exception ex)
                {
                    logger.ErrorException("Error occured on accessing DataBase", ex);
                }
            }
            lv_modals.DataBind();
        }

        protected void btn_add_category_Init(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            ScriptManager1.RegisterPostBackControl(btn);
        }

        protected void btn_edit_category_Init(object sender, EventArgs e)
        {
            Button btn_edit_category = sender as Button;
            ScriptManager1.RegisterAsyncPostBackControl(btn_edit_category);
        }

        protected void btn_delete_category_Init(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            ScriptManager1.RegisterAsyncPostBackControl(btn);
        }

        protected void btn_edit_close_Init(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            ScriptManager1.RegisterAsyncPostBackControl(btn);
        }

        protected void btn_edit_save_Init(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            ScriptManager1.RegisterPostBackControl(btn);
        }


        protected void rpt_categories_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            Button btn = e.CommandSource as Button;
            int iCategoryID = -1;
            Int32.TryParse(e.CommandArgument.ToString(), out iCategoryID);

            switch (e.CommandName)
            {
                case "EditCategory":
                    if (iCategoryID != -1)
                    {
                        editCategory = GetCategoryById(iCategoryID);

                        TextBox tb_name = (TextBox)lv_modals.FindControl("tb_edit_category_name");
                        if (tb_name != null)
                        {
                            tb_name.Text = editCategory.Name;
                            tb_name.Enabled = true;
                        }

                        TextBox tb_desc = (TextBox)lv_modals.FindControl("tb_edit_category_description");
                        if (tb_desc != null)
                        {
                            tb_desc.Text = editCategory.Description;
                            tb_desc.Enabled = true;
                        }

                        CheckBox cb_iv = (CheckBox)lv_modals.FindControl("cb_edit_category_isvisible");
                        if (cb_iv != null)
                        {
                            cb_iv.Checked = editCategory.isVisible;
                            cb_iv.Enabled = true;
                        }

                        Image img = (Image)lv_modals.FindControl("img_edit_category");
                        if (img != null) img.ImageUrl = editCategory.Picture;

                        ((UpdatePanel)lv_modals.FindControl("up_edit_category")).Update();

                    }
                    break;
                case "DeleteCategory":
                    if (iCategoryID != -1)
                    {
                        deleteCategory = GetCategoryById(iCategoryID);

                        Label lb_name = (Label)lv_modals.FindControl("lb_delete_category_name");
                        if (lb_name != null) lb_name.Text = deleteCategory.Name;

                        Label lb_desc = (Label)lv_modals.FindControl("lb_delete_category_description");
                        if (lb_desc != null) lb_desc.Text = deleteCategory.Description;

                        Image img = (Image)lv_modals.FindControl("img_delete_category");
                        if (img != null) img.ImageUrl = deleteCategory.Picture;

                        ((UpdatePanel)lv_modals.FindControl("up_delete_category")).Update();

                    }
                    break;
            }
        }

        protected void btn_edit_save_Click(object sender, EventArgs e)
        {
            sds_categories.UpdateParameters.Clear();
            sds_categories.UpdateParameters.Add("ID", editCategory.ID.ToString());

            TextBox tb_name = (TextBox)lv_modals.FindControl("tb_edit_category_name");
            if (tb_name != null) sds_categories.UpdateParameters.Add("Name", tb_name.Text);

            TextBox tb_desc = (TextBox)lv_modals.FindControl("tb_edit_category_description");
            if (tb_desc != null) sds_categories.UpdateParameters.Add("Description", tb_desc.Text);

            CheckBox cb_iv = (CheckBox)lv_modals.FindControl("cb_edit_category_isvisible");
            if (cb_iv != null) sds_categories.UpdateParameters.Add("isVisible", cb_iv.Checked ? "1" : "0");

            Image img = (Image)lv_modals.FindControl("img_edit_category");
            if (img != null) sds_categories.UpdateParameters.Add("Picture", editCategory.Picture); //TODO implement picture loading

            sds_categories.Update();
            Response.Redirect("~/Categories");
        }

        protected void btn_delete_save_Init(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            ScriptManager1.RegisterPostBackControl(btn);
        }

        protected void btn_delete_save_Click(object sender, EventArgs e)
        {
            sds_categories.DeleteParameters.Clear();
            sds_categories.DeleteParameters.Add("ID", deleteCategory.ID.ToString());

            sds_categories.Delete();
            Response.Redirect("~/Categories");
        }

        protected void btn_add_category_Click(object sender, EventArgs e)
        {
            sds_categories.InsertParameters.Clear();
            sds_categories.InsertParameters.Add("ID", addCategory.ID.ToString());

            TextBox tb_name = (TextBox)lv_modals.FindControl("tb_add_category_name");
            if (tb_name != null) sds_categories.InsertParameters.Add("Name", tb_name.Text);

            TextBox tb_desc = (TextBox)lv_modals.FindControl("tb_add_category_description");
            if (tb_desc != null) sds_categories.InsertParameters.Add("Description", tb_desc.Text);

            Image img = (Image)lv_modals.FindControl("img_add_category");
            if (img != null) ;
            sds_categories.InsertParameters.Add("Picture", s_img_empty); //TODO implement picture loading

            sds_categories.Insert();
            Response.Redirect("~/Categories");

        }

        protected void btn_add_Init(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            ScriptManager1.RegisterAsyncPostBackControl(btn);
        }

    }
}