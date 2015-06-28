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
        public static Models.category editCategory = new Models.category();
        public static Models.category deleteCategory = new Models.category();

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
                    rpt_categories.DataSource = sds_categories;//repository.Categories.ToList<Models.category>();
                    rpt_categories.DataBind();

                }
                catch (Exception ex)
                {
                    logger.ErrorException("Error occured on accessing DataBase", ex);
                }
            }
        }

        protected void btn_add_category_Init(object sender, EventArgs e)
        {
            Button btn_add_category = sender as Button;
            ScriptManager1.RegisterAsyncPostBackControl(btn_add_category);
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

                        Button btn_save = (Button)lv_modals.FindControl("btn_edit_save");
                        if (btn_save != null)
                        {
                            btn_save.CommandArgument = iCategoryID.ToString();
                            btn_save.Enabled = true;
                        }

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

                        Button btn_save = (Button)lv_modals.FindControl("btn_delete_save");
                        if (btn_save != null) btn_save.CommandArgument = iCategoryID.ToString();

                        ((UpdatePanel)lv_modals.FindControl("up_delete_category")).Update();

                    }
                    break;
            }
        }

        protected void btn_edit_close_Click(object sender, EventArgs e)
        {
            TextBox tb_name = (TextBox)lv_modals.FindControl("tb_edit_category_name");
            if (tb_name != null) tb_name.Text = "";

            TextBox tb_desc = (TextBox)lv_modals.FindControl("tb_edit_category_description");
            if (tb_desc != null) tb_desc.Text = "";

            Image img = (Image)lv_modals.FindControl("img_edit_category");
            if (img != null) img.ImageUrl = "";

            System.Threading.Thread.Sleep(2000);
            ((UpdatePanel)lv_modals.FindControl("up_edit_category")).Update();
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
            if (cb_iv != null) sds_categories.UpdateParameters.Add("isVisible", editCategory.isVisible.ToString());

            Image img = (Image)lv_modals.FindControl("img_edit_category");
            if (img != null) sds_categories.UpdateParameters.Add("Picture", img.ImageUrl);

            sds_categories.Update();
            rpt_categories.DataSource = sds_categories;
            rpt_categories.DataBind();
            Response.Redirect("~/Categories");
        }

    }
}