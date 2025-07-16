using ContactManagerApi.Models;
using Microsoft.EntityFrameworkCore;

namespace ContactManagerApi.Data
{
    public class ApPDbContext : DbContext
    {
        public ApPDbContext(DbContextOptions<ApPDbContext> options) : base(options)
        {
            public DbSet<Contact> Contacts => Set<Contact>();
        }
    }
}