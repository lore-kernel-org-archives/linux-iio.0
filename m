Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33728 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdBZVGv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Feb 2017 16:06:51 -0500
Received: by mail-pg0-f65.google.com with SMTP id 5so10421690pgj.0
        for <linux-iio@vger.kernel.org>; Sun, 26 Feb 2017 13:05:35 -0800 (PST)
Date: Mon, 27 Feb 2017 02:35:17 +0530
From: sayli karnik <karniksayli1995@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH] staging: iio: iio-trig-bfin-timer: Move contents of header
 file to source file
Message-ID: <20170226210516.GA20649@sayli-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The contents of the header file are used only by this single
source file. Move content into .c and delete .h.

Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
---
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c | 21 +++++++++++++++++++-
 drivers/staging/iio/trigger/iio-trig-bfin-timer.h | 24 -----------------------
 2 files changed, 20 insertions(+), 25 deletions(-)
 delete mode 100644 drivers/staging/iio/trigger/iio-trig-bfin-timer.h

diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index 4e0b4ee..5708247 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -19,7 +19,26 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
 
-#include "iio-trig-bfin-timer.h"
+/**
+ * struct iio_bfin_timer_trigger_pdata - timer trigger platform data
+ * @output_enable: Enable external trigger pulse generation.
+ * @active_low: Whether the trigger pulse is active low.
+ * @duty_ns: Length of the trigger pulse in nanoseconds.
+ *
+ * This struct is used to configure the output pulse generation of the blackfin
+ * timer trigger. If output_enable is set to true an external trigger signal
+ * will generated on the pin corresponding to the timer. This is useful for
+ * converters which needs an external signal to start conversion. active_low and
+ * duty_ns are used to configure the type of the trigger pulse. If output_enable
+ * is set to false no external trigger pulse will be generated and active_low
+ * and duty_ns are ignored.
+ **/
+
+struct iio_bfin_timer_trigger_pdata {
+	bool output_enable;
+	bool active_low;
+	unsigned int duty_ns;
+};
 
 struct bfin_timer {
 	unsigned short id, bit;
diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.h b/drivers/staging/iio/trigger/iio-trig-bfin-timer.h
deleted file mode 100644
index c07321f..0000000
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.h
+++ /dev/null
@@ -1,24 +0,0 @@
-#ifndef __IIO_BFIN_TIMER_TRIGGER_H__
-#define __IIO_BFIN_TIMER_TRIGGER_H__
-
-/**
- * struct iio_bfin_timer_trigger_pdata - timer trigger platform data
- * @output_enable: Enable external trigger pulse generation.
- * @active_low: Whether the trigger pulse is active low.
- * @duty_ns: Length of the trigger pulse in nanoseconds.
- *
- * This struct is used to configure the output pulse generation of the blackfin
- * timer trigger. If output_enable is set to true an external trigger signal
- * will generated on the pin corresponding to the timer. This is useful for
- * converters which needs an external signal to start conversion. active_low and
- * duty_ns are used to configure the type of the trigger pulse. If output_enable
- * is set to false no external trigger pulse will be generated and active_low
- * and duty_ns are ignored.
- **/
-struct iio_bfin_timer_trigger_pdata {
-	bool output_enable;
-	bool active_low;
-	unsigned int duty_ns;
-};
-
-#endif
-- 
2.7.4

