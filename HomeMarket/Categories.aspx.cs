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
        public Models.category emptyCategory = new Models.category();
        public Models.category editCategory = new Models.category();
        public Models.category deleteCategory = new Models.category();

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
            try
            {
                rpt_categories.DataSource = repository.Categories.ToList<Models.category>();
                rpt_categories.DataBind();
               
            }
            catch (Exception ex)
            {
                logger.ErrorException("Error occured on accessing DataBase", ex);                
            }

       
        }

        protected void btn_add_category_Click(object sender, EventArgs e)
        {
        }


        protected void btn_edit_category_Click(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            int iCategoryID = -1;
            Int32.TryParse(btn.Attributes["data-id"], out iCategoryID);
            if(iCategoryID != -1)
            {
                editCategory = GetCategoryById(3);

                if (Context.User.IsInRole("admins"))
                {
                    TextBox tb_name = (TextBox)lv_modals.FindControl("tb_edit_category_name");
                    if (tb_name != null) tb_name.Text = editCategory.Name;
                    TextBox tb_desc = (TextBox)lv_modals.FindControl("tb_edit_category_description");
                    if (tb_desc != null) tb_desc.Text = editCategory.Description;
                    ((UpdatePanel)lv_modals.FindControl("up_edit_category")).Update();
                }
                
            }
        }

        protected void btn_delete_category_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int iCategoryID = 0;
            Int32.TryParse(btn.Attributes["data-id"], out iCategoryID);
            if (iCategoryID != 0)
            {
                deleteCategory = GetCategoryById(iCategoryID);
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

    }
}