Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:45838 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbcLUOKN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Dec 2016 09:10:13 -0500
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Cercueil <paul.cercueil@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH libiio] iio-monitor: Add support for current and power
Date: Wed, 21 Dec 2016 15:10:19 +0100
Message-Id: <1482329419-12442-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently iio-monitor supports temperature and voltage values only.
Everything else is treated like a voltage.

Add support for common values like current and power.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 examples/iio-monitor.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/examples/iio-monitor.c b/examples/iio-monitor.c
index 558c0f33a36ef7b9..b508049fdb5dfc3f 100644
--- a/examples/iio-monitor.c
+++ b/examples/iio-monitor.c
@@ -93,6 +93,29 @@ static double get_channel_value(struct iio_channel *chn)
 	return val / 1000.0;
 }
 
+static struct {
+	const char *id;
+	const char *unit;
+} map[] = {
+	{ "current",	"A" },
+	{ "power",	"W" },
+	{ "temp",	"°C" },
+	{ "voltage",	"V" },
+	{ 0, },
+};
+
+static const char *id_to_unit(const char *id)
+{
+	unsigned int i;
+
+	for (i = 0; map[i].id; i++) {
+		if (!strncmp(id, map[i].id, strlen(map[i].id)))
+			return map[i].unit;
+	}
+
+	return "";
+}
+
 static void * read_thd(void *d)
 {
 	struct iio_context *ctx = d;
@@ -131,7 +154,7 @@ static void * read_thd(void *d)
 		nb_channels = iio_device_get_channels_count(dev);
 		for (i = 0; i < nb_channels; i++) {
 			const char *id;
-			bool is_temp = false;
+			const char *unit;
 			struct iio_channel *chn =
 				iio_device_get_channel(dev, i);
 			if (!is_valid_channel(chn))
@@ -142,7 +165,7 @@ static void * read_thd(void *d)
 			id = iio_channel_get_id(chn);
 			if (!name)
 				name = id;
-			is_temp = !strncmp(id, "temp", 4);
+			unit = id_to_unit(id);
 
 			sprintf(buf, "</%u></B>%s<!B><!%u>",
 					BLUE, name, BLUE);
@@ -152,8 +175,8 @@ static void * read_thd(void *d)
 			freeChtype(str);
 
 			sprintf(buf, "</%u></B>%.3lf %s<!B><!%u>",
-					YELLOW, get_channel_value(chn),
-					is_temp ? "°C" : "V", YELLOW);
+					YELLOW, get_channel_value(chn), unit,
+					YELLOW);
 			str = char2Chtype(buf, &len, &align);
 			writeChtype(right, col / 2, line++,
 					str, HORIZONTAL, 0, len);
-- 
1.9.1

