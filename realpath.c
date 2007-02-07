#include <limits.h>
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>

extern char *dirname(char *p);

int
main(int argc, char *argv[])
{
   char resolved_path[PATH_MAX *2];
   char *tmp;
   if (!argv[1])
   {
      fprintf(stderr,
         "Usage: realpath <file>\n"
         "       return the realpath C call of the file specified\n");
      return (1);
   }
   tmp = realpath(argv[1], resolved_path);
   if (!tmp)
   {
      if (errno == ENOENT)
      {
         /* return the dirname of the path */
         tmp = realpath(dirname(argv[1]), resolved_path);
      }
      else
      {
         return (errno);
      }
   }
   printf("%s\n", tmp);
   return (0);
}

