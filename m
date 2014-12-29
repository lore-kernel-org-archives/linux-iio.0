Return-Path: <stefan.wahren@i2se.com>
From: Stefan Wahren <stefan.wahren@i2se.com>
To: jic23@kernel.org
Cc: festevam@gmail.com,
	kristina.martsenko@gmail.com,
	knaack.h@gmx.de,
	marex@denx.de,
	kernel@pengutronix.de,
	pawel.moll@arm.com,
	ijc+devicetree@hellion.org.uk,
	robh+dt@kernel.org,
	galak@codeaurora.org,
	mark.rutland@arm.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 2/2] iio: mxs-lradc: check ranges of ts properties
Date: Mon, 29 Dec 2014 10:27:21 +0000
Message-Id: <1419848841-12749-3-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1419848841-12749-1-git-send-email-stefan.wahren@i2se.com>
References: <1419848841-12749-1-git-send-email-stefan.wahren@i2se.com>
List-ID: <linux-iio@vger.kernel.org>

The devicetree binding for mxs-lradc defines ranges for the
touchscreen properties. In order to avoid unexpected behavior like
division by zero, we better check these ranges during probe and
abort in error case.

Additionally this patch adds an important note from the reference
manual about the range of sample delay.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 drivers/staging/iio/adc/mxs-lradc.c |   45 +++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index f053535..d9d6fad 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -436,7 +436,14 @@ static void mxs_lradc_setup_ts_channel(struct mxs_lradc *lradc, unsigned ch)
 	 */
 	mxs_lradc_reg_clear(lradc, LRADC_CH_VALUE_MASK, LRADC_CH(ch));
 
-	/* prepare the delay/loop unit according to the oversampling count */
+	/*
+	 * prepare the delay/loop unit according to the oversampling count
+	 *
+	 * from the datasheet:
+	 * "The DELAY fields in HW_LRADC_DELAY0, HW_LRADC_DELAY1,
+	 * HW_LRADC_DELAY2, and HW_LRADC_DELAY3 must be non-zero; otherwise,
+	 * the LRADC will not trigger the delay group."
+	 */
 	mxs_lradc_reg_wrt(lradc, LRADC_DELAY_TRIGGER(1 << ch) |
 		LRADC_DELAY_TRIGGER_DELAYS(0) |
 		LRADC_DELAY_LOOP(lradc->over_sample_cnt - 1) |
@@ -1495,20 +1502,38 @@ static int mxs_lradc_probe_touchscreen(struct mxs_lradc *lradc,
 		return -EINVAL;
 	}
 
-	lradc->over_sample_cnt = 4;
-	ret = of_property_read_u32(lradc_node, "fsl,ave-ctrl", &adapt);
-	if (ret == 0)
+	if (of_property_read_u32(lradc_node, "fsl,ave-ctrl", &adapt)) {
+		lradc->over_sample_cnt = 4;
+	} else {
+		if (adapt < 1 || adapt > 32) {
+			dev_err(lradc->dev, "Invalid sample count (%u)\n",
+				adapt);
+			return -EINVAL;
+		}
 		lradc->over_sample_cnt = adapt;
+	}
 
-	lradc->over_sample_delay = 2;
-	ret = of_property_read_u32(lradc_node, "fsl,ave-delay", &adapt);
-	if (ret == 0)
+	if (of_property_read_u32(lradc_node, "fsl,ave-delay", &adapt)) {
+		lradc->over_sample_delay = 2;
+	} else {
+		if (adapt < 2 || adapt > LRADC_DELAY_DELAY_MASK + 1) {
+			dev_err(lradc->dev, "Invalid sample delay (%u)\n",
+				adapt);
+			return -EINVAL;
+		}
 		lradc->over_sample_delay = adapt;
+	}
 
-	lradc->settling_delay = 10;
-	ret = of_property_read_u32(lradc_node, "fsl,settling", &adapt);
-	if (ret == 0)
+	if (of_property_read_u32(lradc_node, "fsl,settling", &adapt)) {
+		lradc->settling_delay = 10;
+	} else {
+		if (adapt < 1 || adapt > LRADC_DELAY_DELAY_MASK) {
+			dev_err(lradc->dev, "Invalid settling delay (%u)\n",
+				adapt);
+			return -EINVAL;
+		}
 		lradc->settling_delay = adapt;
+	}
 
 	return 0;
 }
-- 
1.7.9.5
