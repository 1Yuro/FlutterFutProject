using Microsoft.AspNetCore.Mvc;
using Mesaj.Data;
using Microsoft.EntityFrameworkCore;
using Mesaj.Entities;
using Mesaj.Migrations;

namespace Mesaj.Controllers
{
    public class LigTablosuController : Controller
    {
        DataContext context = new DataContext();
        public LigTablosuController(DataContext _context)
        {
            context = _context;
        }
        [HttpGet]
        public IActionResult TakimlariGetir()
        {
            List<Lig> ligs = context.ligTablosu.ToList();
            return Json(ligs);
        }

        [HttpPost]
        public IActionResult Takimlar([FromBody] Lig lig)
        {


            if (lig == null)
            {
                return BadRequest("Body null olamaz");
            }
            else
            {
                return Ok(lig);
            }

            return Ok();

        }
    }
}
