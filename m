Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:32978 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752561AbbC0Lxy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 27 Mar 2015 07:53:54 -0400
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH] tools: iio: generic_buffer: Fix generic scale extraction
Date: Fri, 27 Mar 2015 13:53:00 +0200
Message-Id: <1427457180-2668-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When using generic_buffer to read data, the scale is not properly
detected for scale shared by type. This is caused by a problem
with the generation of generic name out of the full name.
E.g.: for current->name in_accel_z, the extracted generic name
is "in" (when it should be "in_accel"). This is used in generic_buffer
to generate scale and offset paths (in_accel_scale).

Consider the in_ or out_ prefix when extracting the generic name
from the full name.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 tools/iio/iio_utils.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index aea9282..63fbf99 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -18,6 +18,11 @@
 
 const char *iio_dir = "/sys/bus/iio/devices/";
 
+static char * const iio_direction[] = {
+	"in",
+	"out",
+};
+
 /**
  * iioutils_break_up_name() - extract generic name from full channel name
  * @full_name: the full channel name
@@ -28,10 +33,19 @@ int iioutils_break_up_name(const char *full_name,
 {
 	char *current;
 	char *w, *r;
-	char *working;
+	char *working, *prefix = "";
+	int i;
 
-	current = strdup(full_name);
+	for (i = 0; i < sizeof(iio_direction) / sizeof(iio_direction[0]); i++)
+		if (!strncmp(full_name, iio_direction[i],
+			     strlen(iio_direction[i]))) {
+			prefix = iio_direction[i];
+			break;
+		}
+
+	current = strdup(full_name + strlen(prefix) + 1);
 	working = strtok(current, "_\0");
+
 	w = working;
 	r = working;
 
@@ -43,7 +57,7 @@ int iioutils_break_up_name(const char *full_name,
 		r++;
 	}
 	*w = '\0';
-	*generic_name = strdup(working);
+	asprintf(generic_name, "%s_%s", prefix, working);
 	free(current);
 
 	return 0;
-- 
1.9.1

