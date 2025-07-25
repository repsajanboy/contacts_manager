using ContactsManagerApi.Data;
using ContactsManagerApi.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ContactManagerApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ContactsController : ControllerBase
    {
        private readonly ApPDbContext _context;

        public ContactsController(ApPDbContext context)
        {
            _context = context;
        }

        // GET: /api/contacts
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            return Ok(await _context.Contacts.ToListAsync());
        }

        // GET: /api/contacts/{id}
        [HttpGet("{id}")]
        public async Task<IActionResult> Get(int id)
        {
            var contact = await _context.Contacts.FindAsync(id);
            return contact is null ? NotFound() : Ok(contact);
        }

        // POST: /api/contacts
        [HttpPost]
        public async Task<IActionResult> Create([FromForm] AddContactDTO contactDTO)
        {
            string? filePath = "";

            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            if (contactDTO.ProfilePicture != null)
            {
                var uploadsDir = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/uploads");

                if (!Directory.Exists(uploadsDir))
                    Directory.CreateDirectory(uploadsDir);

                var uniqueFileName = Guid.NewGuid() + Path.GetExtension(contactDTO.ProfilePicture.FileName);
                var fullPath = Path.Combine(uploadsDir, uniqueFileName);

                using (var stream = new FileStream(fullPath, FileMode.Create))
                {
                    await contactDTO.ProfilePicture.CopyToAsync(stream);
                }

                filePath = $"uploads/{uniqueFileName}";
            }

            var contact = new Contact
            {
                Name = contactDTO.Name,
                Email = contactDTO.Email,
                PhoneNumber = contactDTO.PhoneNumber,
                ProfilePicture = filePath,
                DateCreated = DateTime.UtcNow,
            };

            _context.Contacts.Add(contact);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(Get), new { id = contact.Id }, contact);
        }

        // PUT: /api/contacts/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, [FromForm] EditContactDTO updatedDTO)
        {
            if (id != updatedDTO.Id)
                return BadRequest("ID mismatch");

            var existing = await _context.Contacts.FindAsync(id);
            if (existing is null)
                return NotFound();

            existing.Name = updatedDTO.Name;
            existing.Email = updatedDTO.Email;
            existing.PhoneNumber = updatedDTO.PhoneNumber;

            if (updatedDTO.UpdatedProfilePicture != null)
            {
                var uploadsDir = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/uploads");

                if (!Directory.Exists(uploadsDir))
                    Directory.CreateDirectory(uploadsDir);

                var uniqueFileName = Guid.NewGuid() + Path.GetExtension(updatedDTO.UpdatedProfilePicture.FileName);
                var fullPath = Path.Combine(uploadsDir, uniqueFileName);

                using (var stream = new FileStream(fullPath, FileMode.Create))
                {
                    await updatedDTO.UpdatedProfilePicture.CopyToAsync(stream);
                }

                existing.ProfilePicture = $"uploads/{uniqueFileName}";
            }

            await _context.SaveChangesAsync();
            return NoContent();
        }

        // DELETE: /api/contacts/{id}
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var contact = await _context.Contacts.FindAsync(id);
            if (contact is null)
                return NotFound();

            _context.Contacts.Remove(contact);
            await _context.SaveChangesAsync();
            return NoContent();
        }
    }
}