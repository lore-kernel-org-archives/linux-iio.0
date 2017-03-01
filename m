Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33821 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbdCAFek (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Mar 2017 00:34:40 -0500
Received: by mail-pg0-f66.google.com with SMTP id s67so4587722pgb.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Feb 2017 21:34:40 -0800 (PST)
Date: Wed, 1 Mar 2017 10:57:12 +0530
From: sayli karnik <karniksayli1995@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH] staging: iio: ad7280a: Group similar macros into enums
Message-ID: <20170301052712.GA19851@sayli-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The patch groups similar macros into enum data types.

Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.h | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.h b/drivers/staging/iio/adc/ad7280a.h
index ccfb90d..08e97d4 100644
--- a/drivers/staging/iio/adc/ad7280a.h
+++ b/drivers/staging/iio/adc/ad7280a.h
@@ -13,15 +13,19 @@
  * TODO: struct ad7280_platform_data needs to go into include/linux/iio
  */
 
-#define AD7280A_ACQ_TIME_400ns			0
-#define AD7280A_ACQ_TIME_800ns			1
-#define AD7280A_ACQ_TIME_1200ns			2
-#define AD7280A_ACQ_TIME_1600ns			3
+enum {
+	AD7280A_CONV_AVG_DIS = 0,
+	AD7280A_CONV_AVG_2,
+	AD7280A_CONV_AVG_4,
+	AD7280A_CONV_AVG_8,
+};
 
-#define AD7280A_CONV_AVG_DIS			0
-#define AD7280A_CONV_AVG_2			1
-#define AD7280A_CONV_AVG_4			2
-#define AD7280A_CONV_AVG_8			3
+enum {
+	AD7280A_ACQ_TIME_400ns = 0,
+	AD7280A_ACQ_TIME_800ns,
+	AD7280A_ACQ_TIME_1200ns,
+	AD7280A_ACQ_TIME_1600ns,
+};
 
 #define AD7280A_ALERT_REMOVE_VIN5		BIT(2)
 #define AD7280A_ALERT_REMOVE_VIN4_VIN5		BIT(3)
-- 
2.7.4

