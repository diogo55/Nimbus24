﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using Nimbus24;

namespace Nimbus24.Controllers
{
    public class PrestadorsController : Controller
    {
        private Nimbus24Context db = new Nimbus24Context();


        public ActionResult Historico()
        {

            var id = (from p in db.Prestador
                      where p.mail == User.Identity.Name
                      select p.Id);

           var serviço = (from s in db.Serviço
                               where s.idPrestador == id.First()
                               select s);

           return View(serviço.ToList());
          
        }

        public ActionResult Login()
        {
            ViewData["Message"] = "Faça o Login:";
            return View();
        }

        [HttpPost]
        public ActionResult Login(string mail, string password)
        {
            if (ModelState.IsValid)
            {
                var prestadores = (from m in db.Prestador
                                where m.mail == mail && m.password == password
                                select m);
                if (prestadores.ToList<Prestador>().Count > 0)
                {
                    Prestador prestador = prestadores.ToList<Prestador>().ElementAt<Prestador>(0);
                    FormsAuthentication.SetAuthCookie(prestador.mail, false);
                    return RedirectToAction("Index", "Home");
                }
                else
                {
                    ModelState.AddModelError("", "Mail and Password combination is incorrect!");
                }
            }
            return View();

        }

        public ActionResult LoginSuccess()
        {
            return RedirectToAction("Index", "Home");
        }

        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Login", "Prestadors");
        }

        // GET: Prestadors/Create
        public ActionResult Registar()
        {
            ViewBag.Cidade_cidade = new SelectList(db.Cidade, "Cidade1", "Cidade1");
            return View();
        }

        // POST: Prestadors/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Registar([Bind(Include = "Id,nome,mail,rating,password,contacto,Cidade_cidade")] Prestador prestador)
        {
            if (ModelState.IsValid)
            {
                prestador.rating = 0;
                db.Prestador.Add(prestador);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.Cidade_cidade = new SelectList(db.Cidade, "Cidade1", "Cidade1", prestador.Cidade_cidade);
            return View(prestador);
        }

        // GET: Prestadors
        public ActionResult Index()
        {
            var prestador = db.Prestador.Include(p => p.Cidade);
            return View(prestador.ToList());
        }

        // GET: Prestadors/Details/5
        public ActionResult Details(int id)
        {
            if (id == -1)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Prestador prestador = db.Prestador.Find(id);
            if (prestador == null)
            {
                return HttpNotFound();
            }
            return View(prestador);
        }

        // GET: Prestadors/Create
        public ActionResult Create()
        {
            ViewBag.Cidade_cidade = new SelectList(db.Cidade, "Cidade1", "Cidade1");
            return View();
        }

        // POST: Prestadors/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,nome,mail,rating,password,contacto,Cidade_cidade")] Prestador prestador)
        {
            if (ModelState.IsValid)
            {
                db.Prestador.Add(prestador);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.Cidade_cidade = new SelectList(db.Cidade, "Cidade1", "Cidade1", prestador.Cidade_cidade);
            return View(prestador);
        }

        // GET: Prestadors/Edit/5
        public ActionResult Edit(int id)
        {
            if (id == -1)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Prestador prestador = db.Prestador.Find(id);
            if (prestador == null)
            {
                return HttpNotFound();
            }
            ViewBag.Cidade_cidade = new SelectList(db.Cidade, "Cidade1", "Cidade1", prestador.Cidade_cidade);
            return View(prestador);
        }

        // POST: Prestadors/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,nome,mail,rating,password,contacto,Cidade_cidade")] Prestador prestador)
        {
            if (ModelState.IsValid)
            {
                db.Entry(prestador).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.Cidade_cidade = new SelectList(db.Cidade, "Cidade1", "Cidade1", prestador.Cidade_cidade);
            return View(prestador);
        }

        // GET: Prestadors/Delete/5
        public ActionResult Delete(int id)
        {
            if (id == -1)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Prestador prestador = db.Prestador.Find(id);
            if (prestador == null)
            {
                return HttpNotFound();
            }
            return View(prestador);
        }

        // POST: Prestadors/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Prestador prestador = db.Prestador.Find(id);
            db.Prestador.Remove(prestador);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
