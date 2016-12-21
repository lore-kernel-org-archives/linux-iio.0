Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from laurent.telenet-ops.be ([195.130.137.89]:47826 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757568AbcLUOJq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Dec 2016 09:09:46 -0500
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Cercueil <paul.cercueil@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH libiio] iio-monitor: Set locale before parsing double values from sysfs
Date: Wed, 21 Dec 2016 15:09:48 +0100
Message-Id: <1482329388-12376-1-git-send-email-geert@linux-m68k.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

strtod() uses the current locale when parsing numbers, while all values
in sysfs use the "C" locale.  Hence the former may expect a comma as the
radix character, while the latter always uses a decimal point, leading
to the display of incorrect values.

Temporarily switch to the "C" locale before parsing double numbers to
fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 examples/iio-monitor.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/examples/iio-monitor.c b/examples/iio-monitor.c
index 8b632187829869ae..558c0f33a36ef7b9 100644
--- a/examples/iio-monitor.c
+++ b/examples/iio-monitor.c
@@ -21,6 +21,7 @@
 #define _DEFAULT_SOURCE
 
 #include <cdk/cdk.h>
+#include <locale.h>
 #include <pthread.h>
 #include <stdbool.h>
 #include <unistd.h>
@@ -61,9 +62,13 @@ static bool is_valid_channel(struct iio_channel *chn)
 
 static double get_channel_value(struct iio_channel *chn)
 {
+	char *old_locale;
 	char buf[1024];
 	double val;
 
+	old_locale = strdup(setlocale(LC_NUMERIC, NULL));
+	setlocale(LC_NUMERIC, "C");
+
 	if (channel_has_attr(chn, "input")) {
 		iio_channel_attr_read(chn, "input", buf, sizeof(buf));
 		val = strtod(buf, NULL);
@@ -82,6 +87,9 @@ static double get_channel_value(struct iio_channel *chn)
 		}
 	}
 
+	setlocale(LC_NUMERIC, old_locale);
+	free(old_locale);
+
 	return val / 1000.0;
 }
 
-- 
1.9.1

