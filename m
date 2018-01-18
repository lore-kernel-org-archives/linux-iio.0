Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn3nam01on0066.outbound.protection.outlook.com ([104.47.33.66]:52512
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756455AbeAROo6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 18 Jan 2018 09:44:58 -0500
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w0IEisEl018139
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK)
        for <linux-iio@vger.kernel.org>; Thu, 18 Jan 2018 06:44:54 -0800
From: <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>
CC: <michael.hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2] staging: iio: adc: ad7192: fix external frequency setting
Date: Thu, 18 Jan 2018 16:44:49 +0200
Message-ID: <20180118144449.20115-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

The external clock frequency was set only when selecting
the internal clock, which is fixed at 4.9152 Mhz.

This is incorrect, since it should be set when any of
the external clock or crystal settings is selected.

Added range validation for the validating the external
(crystal/clock) frequency setting.
Valid values are between 2.4576 and 5.12 Mhz.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changes since v1:
 * assign frequency from `pdata->ext_clk_hz`, not `pdata->ext_clk_hz`
 * check frequency range for both crystal & (external) clock
 * print error if clock range is invalid
 * patch was split away from patch-series (for device-tree bindings)

 drivers/staging/iio/adc/ad7192.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index aebbc3b58194..6d110f817b4e 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -141,6 +141,8 @@
 #define AD7192_GPOCON_P1DAT	BIT(1) /* P1 state */
 #define AD7192_GPOCON_P0DAT	BIT(0) /* P0 state */
 
+#define AD7192_EXT_FREQ_MHZ_MIN	2457600
+#define AD7192_EXT_FREQ_MHZ_MAX	5120000
 #define AD7192_INT_FREQ_MHZ	4915200
 
 /* NOTE:
@@ -217,6 +219,12 @@ static int ad7192_calibrate_all(struct ad7192_state *st)
 				ARRAY_SIZE(ad7192_calib_arr));
 }
 
+static inline bool ad7192_valid_external_frequency(u32 freq)
+{
+	return (freq >= AD7192_EXT_FREQ_MHZ_MIN &&
+		freq <= AD7192_EXT_FREQ_MHZ_MAX);
+}
+
 static int ad7192_setup(struct ad7192_state *st,
 			const struct ad7192_platform_data *pdata)
 {
@@ -244,17 +252,19 @@ static int ad7192_setup(struct ad7192_state *st,
 			 id);
 
 	switch (pdata->clock_source_sel) {
-	case AD7192_CLK_EXT_MCLK1_2:
-	case AD7192_CLK_EXT_MCLK2:
-		st->mclk = AD7192_INT_FREQ_MHZ;
-		break;
 	case AD7192_CLK_INT:
 	case AD7192_CLK_INT_CO:
-		if (pdata->ext_clk_hz)
-			st->mclk = pdata->ext_clk_hz;
-		else
-			st->mclk = AD7192_INT_FREQ_MHZ;
+		st->mclk = AD7192_INT_FREQ_MHZ;
 		break;
+	case AD7192_CLK_EXT_MCLK1_2:
+	case AD7192_CLK_EXT_MCLK2:
+		if (ad7192_valid_external_frequency(pdata->ext_clk_hz)) {
+			st->mclk = pdata->ext_clk_hz;
+			break;
+		}
+		dev_err(&st->sd.spi->dev, "Invalid frequency setting %u\n",
+			pdata->ext_clk_hz);
+		/* FALLTHROUGH */
 	default:
 		ret = -EINVAL;
 		goto out;
-- 
2.14.1

