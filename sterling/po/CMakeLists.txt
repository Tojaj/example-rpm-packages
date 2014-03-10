SET (PO_files
    cs.po
    de.po
    fr.po
    it.po
    ru.po
    )
GETTEXT_CREATE_TRANSLATIONS(${PROJECT_NAME}.pot ALL ${PO_files})
