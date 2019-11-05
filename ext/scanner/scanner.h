#ifndef __SCANNER_H__
#define __SCANNER_H__

void *unwrap_scanner(const VALUE rb_vscanner);

VALUE rb_fscan_string(const VALUE rb_vscanner, VALUE rb_vinput);

#endif
