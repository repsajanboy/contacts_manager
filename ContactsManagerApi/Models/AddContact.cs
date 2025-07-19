namespace ContactsManagerApi.Models
{
    public class AddContactDTO
    {
        public string Name { get; set; } = "";
        public string Email { get; set; } = "";
        public string PhoneNumber { get; set; } = "";
        public IFormFile? ProfilePicture { get; set; }
        public DateTime DateCreated { get; set; } = DateTime.UtcNow;
    }
}