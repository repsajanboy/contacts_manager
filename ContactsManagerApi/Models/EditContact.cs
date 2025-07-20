namespace ContactsManagerApi.Models
{
    public class EditContactDTO
    {
        public int Id { get; set; }
        public string Name { get; set; } = "";
        public string Email { get; set; } = "";
        public string PhoneNumber { get; set; } = "";
        public string ProfilePicture { get; set; } = "";
        public IFormFile? UpdatedProfilePicture { get; set; }
        public DateTime DateCreated { get; set; }
    }
}