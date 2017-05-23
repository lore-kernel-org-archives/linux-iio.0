Return-Path: <SRS0=cE2T=45=atomide.com=tony@kernel.org>
From: Tony Lindgren <tony@atomide.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Marcel Partap <mpartap@gmx.net>,
	Michael Scott <michael.scott@linaro.org>
Subject: [PATCH 3/3] iio: adc: cpcap: Remove hung interrupt quirk
Date: Mon, 22 May 2017 17:51:46 -0700
Message-Id: <20170523005146.726-4-tony@atomide.com>
In-Reply-To: <20170523005146.726-1-tony@atomide.com>
References: <20170523005146.726-1-tony@atomide.com>
List-ID: <linux-iio@vger.kernel.org>

This is no longer needed as the real problem was interrupt flags
not getting passed properly from device tree to the cpcap-core.c
mfd driver. This got fixed with commit ac89473213c6 ("mfd: cpcap:
Fix interrupt to use level interrupt") So let's remove ADC
interrupt specific the quirk.

Cc: Marcel Partap <mpartap@gmx.net>
Cc: Michael Scott <michael.scott@linaro.org>
Reviewed-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/iio/adc/cpcap-adc.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
--- a/drivers/iio/adc/cpcap-adc.c
+++ b/drivers/iio/adc/cpcap-adc.c
@@ -89,7 +89,7 @@
 #define ST_ADC_CAL_BATTI_LOW_THRESHOLD	494
 #define ST_ADC_CALIBRATE_DIFF_THRESHOLD	3
 
-#define CPCAP_ADC_MAX_RETRIES		5	/* Calibration and quirk */
+#define CPCAP_ADC_MAX_RETRIES		5	/* Calibration */
 
 /**
  * struct cpcap_adc_ato - timing settings for cpcap adc
@@ -635,27 +635,6 @@ static void cpcap_adc_setup_bank(struct cpcap_adc *ddata,
 	}
 }
 
-/*
- * Occasionally the ADC does not seem to start and there will be no
- * interrupt. Let's re-init interrupt to prevent the ADC from hanging
- * for the next request. It is unclear why this happens, but the next
- * request will usually work after doing this.
- */
-static void cpcap_adc_quirk_reset_lost_irq(struct cpcap_adc *ddata)
-{
-	int error;
-
-	dev_info(ddata->dev, "lost ADC irq, attempting to reinit\n");
-	disable_irq(ddata->irq);
-	error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
-				   CPCAP_BIT_ADTRIG_DIS,
-				   CPCAP_BIT_ADTRIG_DIS);
-	if (error)
-		dev_warn(ddata->dev, "%s reset failed: %i\n",
-			 __func__, error);
-	enable_irq(ddata->irq);
-}
-
 static int cpcap_adc_start_bank(struct cpcap_adc *ddata,
 				struct cpcap_adc_request *req)
 {
@@ -673,7 +652,6 @@ static int cpcap_adc_start_bank(struct cpcap_adc *ddata,
 			return 0;
 
 		if (error == 0) {
-			cpcap_adc_quirk_reset_lost_irq(ddata);
 			error = -ETIMEDOUT;
 			continue;
 		}
-- 
2.13.0
