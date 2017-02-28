Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34421 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdB1UY7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Feb 2017 15:24:59 -0500
Received: by mail-pg0-f65.google.com with SMTP id s67so2829695pgb.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Feb 2017 12:23:39 -0800 (PST)
Date: Tue, 28 Feb 2017 23:56:30 +0530
From: sayli karnik <karniksayli1995@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH] staging: iio: ad7280a: Move contents of header file to
 source file
Message-ID: <20170228182630.GA10423@sayli-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The contents of the header file are used only by this single
source file.  Move content into .c and remove .h.

Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 15 +++++++++++++++
 drivers/staging/iio/adc/ad7280a.h | 15 ---------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index ee679ac..44d13dc 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -22,6 +22,21 @@
 
 #include "ad7280a.h"
 
+#define AD7280A_ACQ_TIME_400ns			0
+#define AD7280A_ACQ_TIME_800ns			1
+#define AD7280A_ACQ_TIME_1200ns			2
+#define AD7280A_ACQ_TIME_1600ns			3
+
+#define AD7280A_CONV_AVG_DIS			0
+#define AD7280A_CONV_AVG_2			1
+#define AD7280A_CONV_AVG_4			2
+#define AD7280A_CONV_AVG_8			3
+
+#define AD7280A_ALERT_REMOVE_VIN5		BIT(2)
+#define AD7280A_ALERT_REMOVE_VIN4_VIN5		BIT(3)
+#define AD7280A_ALERT_REMOVE_AUX5		BIT(0)
+#define AD7280A_ALERT_REMOVE_AUX4_AUX5		BIT(1)
+
 /* Registers */
 #define AD7280A_CELL_VOLTAGE_1		0x0  /* D11 to D0, Read only */
 #define AD7280A_CELL_VOLTAGE_2		0x1  /* D11 to D0, Read only */
diff --git a/drivers/staging/iio/adc/ad7280a.h b/drivers/staging/iio/adc/ad7280a.h
index ccfb90d..1b50dd8 100644
--- a/drivers/staging/iio/adc/ad7280a.h
+++ b/drivers/staging/iio/adc/ad7280a.h
@@ -13,21 +13,6 @@
  * TODO: struct ad7280_platform_data needs to go into include/linux/iio
  */
 
-#define AD7280A_ACQ_TIME_400ns			0
-#define AD7280A_ACQ_TIME_800ns			1
-#define AD7280A_ACQ_TIME_1200ns			2
-#define AD7280A_ACQ_TIME_1600ns			3
-
-#define AD7280A_CONV_AVG_DIS			0
-#define AD7280A_CONV_AVG_2			1
-#define AD7280A_CONV_AVG_4			2
-#define AD7280A_CONV_AVG_8			3
-
-#define AD7280A_ALERT_REMOVE_VIN5		BIT(2)
-#define AD7280A_ALERT_REMOVE_VIN4_VIN5		BIT(3)
-#define AD7280A_ALERT_REMOVE_AUX5		BIT(0)
-#define AD7280A_ALERT_REMOVE_AUX4_AUX5		BIT(1)
-
 struct ad7280_platform_data {
 	unsigned int		acquisition_time;
 	unsigned int		conversion_averaging;
-- 
2.7.4

