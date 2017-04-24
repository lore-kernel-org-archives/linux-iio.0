Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:55732 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1428274AbdDXUU0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 24 Apr 2017 16:20:26 -0400
Subject: [PATCH 4/7] HID: debug: Replace five seq_printf() calls by seq_putc()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <2d526d72-a740-367b-04a9-ed698435f8ed@users.sourceforge.net>
Message-ID: <f7ad5a57-2f41-cc0a-5015-e99d58239a2d@users.sourceforge.net>
Date: Mon, 24 Apr 2017 22:20:10 +0200
MIME-Version: 1.0
In-Reply-To: <2d526d72-a740-367b-04a9-ed698435f8ed@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 24 Apr 2017 20:34:29 +0200

Five single characters should be put into a sequence.
Thus use the corresponding function "seq_putc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-debug.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 5271db593478..d47d5085bc99 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -499,7 +499,7 @@ char *hid_resolv_usage(unsigned usage, struct seq_file *f) {
 		len++;
 	}
 	else {
-		seq_printf(f, ".");
+		seq_putc(f, '.');
 	}
 	for (p = hid_usage_table; p->description; p++)
 		if (p->page == (usage >> 16)) {
@@ -550,7 +550,8 @@ void hid_dump_field(struct hid_field *field, int n, struct seq_file *f) {
 	}
 	tab(n, f); seq_printf(f, "Usage(%d)\n", field->maxusage);
 	for (j = 0; j < field->maxusage; j++) {
-		tab(n+2, f); hid_resolv_usage(field->usage[j].hid, f); seq_printf(f, "\n");
+		tab(n + 2, f); hid_resolv_usage(field->usage[j].hid, f);
+		seq_putc(f, '\n');
 	}
 	if (field->logical_minimum != field->logical_maximum) {
 		tab(n, f); seq_printf(f, "Logical Minimum(%d)\n", field->logical_minimum);
@@ -594,7 +595,7 @@ void hid_dump_field(struct hid_field *field, int n, struct seq_file *f) {
 				data >>= 4;
 				if (nibble != 0) {
 					if(earlier_unit++ > 0)
-						seq_printf(f, "*");
+						seq_putc(f, '*');
 					seq_printf(f, "%s", units[sys][i]);
 					if(nibble != 1) {
 						/* This is a _signed_ nibble(!) */
@@ -1041,5 +1042,5 @@ static void hid_dump_input_mapping(struct hid_device *hid, struct seq_file *f)
 					hid_resolv_event(usage->type, usage->code, f);
-					seq_printf(f, "\n");
+					seq_putc(f, '\n');
 				}
 			}
 		}
@@ -1066,7 +1067,7 @@ static int hid_debug_rdesc_show(struct seq_file *f, void *p)
 
 	/* dump parsed data and input mappings */
 	hid_dump_device(hdev, f);
-	seq_printf(f, "\n");
+	seq_putc(f, '\n');
 	hid_dump_input_mapping(hdev, f);
 
 	return 0;
-- 
2.12.2

