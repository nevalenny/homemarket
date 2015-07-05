using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Routing;
using Microsoft.AspNet.FriendlyUrls;

namespace HomeMarket
{
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.MapPageRoute("", "Goods/{CategoryID}", "~/Goods.aspx", true, new RouteValueDictionary { { "CategoryID", @"\d{1,8}" } });
            routes.MapPageRoute("", "goods/{CategoryID}", "~/Goods.aspx", true, new RouteValueDictionary { { "CategoryID", @"\d{1,8}" } });
            routes.MapPageRoute("", "categories", "~/Categories.aspx");
            routes.MapPageRoute("", "Checkout", "~/Checkout.aspx");
            routes.MapPageRoute("", "", "~/Categories.aspx");
            routes.EnableFriendlyUrls();
        }
    }
}
