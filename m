Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Rama Krishna Phani A <rphani@codeaurora.org>
Subject: [PATCH] guessing
Date: Sun,  8 Jan 2017 21:01:40 +0000
Message-Id: <20170108210140.17507-1-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

---
 drivers/iio/adc/qcom-spmi-vadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index faaf711325b5..0a19761d656c 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -641,7 +641,7 @@ static int vadc_scale_therm(struct vadc_priv *vadc,
 	vadc_scale_calib(vadc, adc_code, prop, &voltage);
 
 	if (prop->calibration == VADC_CALIB_ABSOLUTE)
-		voltage /= 1000;
+		voltage = div64_s64(voltage, 1000);
 
 	vadc_map_voltage_temp(adcmap_100k_104ef_104fb,
 			      ARRAY_SIZE(adcmap_100k_104ef_104fb),
-- 
2.11.0
