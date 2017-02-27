Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36700 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbdB0JGl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Feb 2017 04:06:41 -0500
Received: by mail-pg0-f66.google.com with SMTP id 25so331144pgy.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Feb 2017 01:06:31 -0800 (PST)
From: Gargi Sharma <gs051095@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: gregkh@linuxfoundation.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org, pmeerw@pmeerw.net,
        knaack.h@gmx.de, linux-iio@vger.kernel.org,
        Gargi Sharma <gs051095@gmail.com>
Subject: [PATCH] staging: iio: ad5933: move contents of header file to source file
Date: Mon, 27 Feb 2017 11:42:08 +0530
Message-Id: <1488175928-15013-1-git-send-email-gs051095@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The contents of the header file are used only by this single
source file.  Move content into .c and remove .h.

Signed-off-by: Gargi Sharma <gs051095@gmail.com>
---
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c | 20 ++++++++++++++++++-
 drivers/staging/iio/trigger/iio-trig-bfin-timer.h | 24 -----------------------
 2 files changed, 19 insertions(+), 25 deletions(-)
 delete mode 100644 drivers/staging/iio/trigger/iio-trig-bfin-timer.h

diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index 4e0b4ee..8077b9d 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -19,7 +19,25 @@
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

