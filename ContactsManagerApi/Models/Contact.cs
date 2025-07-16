using System.ComponentModel.DataAnnotations;

namespace ContactManagerApi.Models
{
    public class Contact
    {
        public int Id { get; set; }

        [Required]
        public string Name { get; set; } = string.Empty;

        [EmailAddress]
        public string Email { get; set; } = string.Empty;

        [Phone]
        public string PhoneNumber { get; set; } = string.Empty;

        public string? ProfilePicture { get; set; }

        public DateTime DateCreated { get; set; } = DateTime.UtcNow;
    }
}