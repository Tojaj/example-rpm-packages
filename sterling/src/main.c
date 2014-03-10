#define GETTEXT_PACKAGE "sterling"
#include <glib/gi18n-lib.h>
#include <glib.h>
#include <glib/gprintf.h>
#include <stdlib.h>
#include <locale.h>
#include "config.h"

int
main()
{
    setlocale (LC_ALL, "");
    bindtextdomain (GETTEXT_PACKAGE, LOCALEDIR);
    bind_textdomain_codeset (GETTEXT_PACKAGE, "UTF-8");
    textdomain (GETTEXT_PACKAGE);

    g_printf(_("Hello\n"));

    return EXIT_SUCCESS;
}
