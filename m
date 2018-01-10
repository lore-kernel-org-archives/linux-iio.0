Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam03on0084.outbound.protection.outlook.com ([104.47.42.84]:11584
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932174AbeAJLax (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 10 Jan 2018 06:30:53 -0500
From: <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>, <michael.hennerich@analog.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <devicetree@vger.kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/3] staging: iio: adc: ad7192: fix external frequency setting
Date: Wed, 10 Jan 2018 13:29:54 +0200
Message-ID: <20180110112956.23931-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

According to the datasheet:
* 0 - external crystal, connected from pin MCLK1 to MCLK2
* 1 - external clock, applied to MCLK2 pin
* 2 - internal 4.92 Mhz clock; pin MCLK2 is tristated
* 3 - internal 4.92 Mhz clock; internal clock is available on MCLK2

Which means that the external clock value only has sense
for value 1 (AD7192_CLK_EXT_MCLK2).

Also added range validation for the external frequency
setting, which the datasheet mentions that it's
between 2.4576 and 5.12 Mhz.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/staging/iio/adc/ad7192.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 7f204013d6d4..7bc04101d133 100644
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
@@ -245,16 +253,16 @@ static int ad7192_setup(struct ad7192_state *st,
 
 	switch (pdata->clock_source_sel) {
 	case AD7192_CLK_EXT_MCLK1_2:
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
+	case AD7192_CLK_EXT_MCLK2:
+		if (ad7192_valid_external_frequency(pdata->clock_source_sel)) {
+			st->mclk = pdata->clock_source_sel;
+			break;
+		}
+		/* FALLTHROUGH */
 	default:
 		ret = -EINVAL;
 		goto out;
-- 
2.14.1

