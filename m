Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33399 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758850AbdCVIid (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Mar 2017 04:38:33 -0400
Date: Wed, 22 Mar 2017 14:08:24 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: lars@metafoo.de
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: iio: Replace a bit shift by a use of BIT.
Message-ID: <20170322083824.GA26432@arushi-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch replaces bit shifting on 1 with the BIT(x) macro.
This was done with coccinelle:
@@
constant c;
@@

-1 << c
+BIT(c)

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
changes in v2
 -change the cc list

 drivers/staging/iio/adc/ad7816.c |  2 +-
 drivers/staging/iio/cdc/ad7150.c |  2 +-
 drivers/staging/iio/cdc/ad7746.c | 22 +++++++++++-----------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 17d280581e24..42f637ca0251 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -222,7 +222,7 @@ static ssize_t ad7816_show_value(struct device *dev,
 		value = (s8)((data >> AD7816_TEMP_FLOAT_OFFSET) - 103);
 		data &= AD7816_TEMP_FLOAT_MASK;
 		if (value < 0)
-			data = (1 << AD7816_TEMP_FLOAT_OFFSET) - data;
+			data = (BIT(AD7816_TEMP_FLOAT_OFFSET)) - data;
 		return sprintf(buf, "%d.%.2d\n", value, data * 25);
 	}
 	return sprintf(buf, "%u\n", data);
diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index ca72af3e9d4b..c5574b3ee939 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -232,7 +232,7 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
 	if (ret < 0)
 		goto error_ret;
 
-	cfg = ret & ~((0x03 << 5) | (0x1 << 7));
+	cfg = ret & ~((0x03 << 5) | (BIT(7)));
 
 	switch (type) {
 	case IIO_EV_TYPE_MAG_ADAPTIVE:
diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 81f8b9ee1120..8c573817826f 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -45,20 +45,20 @@
 #define AD7746_STATUS_RDYCAP		BIT(0)
 
 /* Capacitive Channel Setup Register Bit Designations (AD7746_REG_CAP_SETUP) */
-#define AD7746_CAPSETUP_CAPEN		(1 << 7)
-#define AD7746_CAPSETUP_CIN2		(1 << 6) /* AD7746 only */
-#define AD7746_CAPSETUP_CAPDIFF		(1 << 5)
-#define AD7746_CAPSETUP_CACHOP		(1 << 0)
+#define AD7746_CAPSETUP_CAPEN		(BIT(7))
+#define AD7746_CAPSETUP_CIN2		(BIT(6)) /* AD7746 only */
+#define AD7746_CAPSETUP_CAPDIFF		(BIT(5))
+#define AD7746_CAPSETUP_CACHOP		(BIT(0))
 
 /* Voltage/Temperature Setup Register Bit Designations (AD7746_REG_VT_SETUP) */
-#define AD7746_VTSETUP_VTEN		(1 << 7)
+#define AD7746_VTSETUP_VTEN		(BIT(7))
 #define AD7746_VTSETUP_VTMD_INT_TEMP	(0 << 5)
-#define AD7746_VTSETUP_VTMD_EXT_TEMP	(1 << 5)
+#define AD7746_VTSETUP_VTMD_EXT_TEMP	(BIT(5))
 #define AD7746_VTSETUP_VTMD_VDD_MON	(2 << 5)
 #define AD7746_VTSETUP_VTMD_EXT_VIN	(3 << 5)
-#define AD7746_VTSETUP_EXTREF		(1 << 4)
-#define AD7746_VTSETUP_VTSHORT		(1 << 1)
-#define AD7746_VTSETUP_VTCHOP		(1 << 0)
+#define AD7746_VTSETUP_EXTREF		(BIT(4))
+#define AD7746_VTSETUP_VTSHORT		(BIT(1))
+#define AD7746_VTSETUP_VTCHOP		(BIT(0))
 
 /* Excitation Setup Register Bit Designations (AD7746_REG_EXC_SETUP) */
 #define AD7746_EXCSETUP_CLKCTRL		BIT(7)
@@ -75,14 +75,14 @@
 #define AD7746_CONF_VTFS_MASK		GENMASK(7, 6)
 #define AD7746_CONF_CAPFS_MASK		GENMASK(5, 3)
 #define AD7746_CONF_MODE_IDLE		(0 << 0)
-#define AD7746_CONF_MODE_CONT_CONV	(1 << 0)
+#define AD7746_CONF_MODE_CONT_CONV	(BIT(0))
 #define AD7746_CONF_MODE_SINGLE_CONV	(2 << 0)
 #define AD7746_CONF_MODE_PWRDN		(3 << 0)
 #define AD7746_CONF_MODE_OFFS_CAL	(5 << 0)
 #define AD7746_CONF_MODE_GAIN_CAL	(6 << 0)
 
 /* CAPDAC Register Bit Designations (AD7746_REG_CAPDACx) */
-#define AD7746_CAPDAC_DACEN		(1 << 7)
+#define AD7746_CAPDAC_DACEN		(BIT(7))
 #define AD7746_CAPDAC_DACP(x)		((x) & 0x7F)
 
 /*
-- 
2.11.0

