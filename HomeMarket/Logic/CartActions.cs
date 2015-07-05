﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HomeMarket.Logic
{
    public class CartActions : IDisposable
    {
        public string UserCartId { get; set; }

        public const string CartSessionKey = "CartId";

        private Models.MarketContext _db = new Models.MarketContext();

        public void AddToCart(int id)
        {
            UserCartId = GetUserCartId();

            var cartItem = _db.CartItems.SingleOrDefault(
                c => c.UserId == UserCartId
                && c.GoodId == id);
            if (cartItem == null)
            {
                cartItem = new Models.CartItem
                {
                    ID = Guid.NewGuid().ToString(),
                    GoodId = id,
                    UserId = UserCartId,
                    Good = _db.goods.SingleOrDefault(p => p.ID == id),
                    Quantity = 1,
                    DateCreated = DateTime.Now
                };

                _db.CartItems.Add(cartItem);
            }
            else
            {
                cartItem.Quantity++;
            }
            _db.SaveChanges();
        }

        public void RemoveFromCart(int id)
        {
            UserCartId = GetUserCartId();

            var cartItem = _db.CartItems.First(
                c => c.UserId == UserCartId
                && c.GoodId == id);
            if (cartItem != null)
            {
                cartItem.Quantity--;
                if(cartItem.Quantity<=0)
                {
                    _db.CartItems.Remove(cartItem);
                }
            }
            _db.SaveChanges();
        }

        public void BuyAll()
        {
            UserCartId = GetUserCartId();
            Models.CartItem cartItem = new Models.CartItem();

            try
            {
                cartItem = _db.CartItems.First(c => c.UserId == UserCartId);
            }
            catch
            {
            }

            var user = _db.Users.First(u => u.UserName == UserCartId);

            while(cartItem!=null && cartItem.Quantity>0)
            {
                var good = _db.goods.FirstOrDefault(g => g.ID == cartItem.Good.ID);
                user.WalletBalance -= (decimal)cartItem.Good.Price;
                good.Available--;
                cartItem.Quantity--;
                if (cartItem.Quantity <= 0)
                {
                    _db.CartItems.Remove(cartItem);
                }
                _db.SaveChanges();
                try
                {
                    cartItem = _db.CartItems.First(c => c.UserId == UserCartId && c.Quantity > 0);
                }
                catch (Exception ex)
                {
                    cartItem = null;
                }
            }
        }


        public void Dispose()
        {
            if (_db != null)
            {
                _db.Dispose();
                _db = null;
            }
        }

        public string GetUserCartId()
        {
            if (HttpContext.Current.Session[CartSessionKey] == null)
            {
                if (!string.IsNullOrWhiteSpace(HttpContext.Current.User.Identity.Name))
                {
                    HttpContext.Current.Session[CartSessionKey] = HttpContext.Current.User.Identity.Name;
                }
                else
                {
                    Guid tempCartId = Guid.NewGuid();
                    HttpContext.Current.Session[CartSessionKey] = tempCartId.ToString();
                }
            }
            return HttpContext.Current.Session[CartSessionKey].ToString();
        }

        public List<Models.CartItem> GetCartItems()
        {
            UserCartId = GetUserCartId();
            return _db.CartItems.Where(c => c.UserId == UserCartId).OrderBy(c => c.Good.Name).ToList();
        }
        public decimal TotalSum()
        {
            decimal sum = 0;
            foreach (Models.CartItem item in GetCartItems())
            {
                sum += (decimal)item.Good.Price * item.Quantity;
            }
            return sum;
        }

        public int TotalCount()
        {
            int count = 0;
            foreach (Models.CartItem item in GetCartItems())
            {
                count += item.Quantity;
            }
            return count;
        }

    }
}