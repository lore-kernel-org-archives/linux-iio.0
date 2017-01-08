Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tarvos.retrosnub.co.uk ([217.168.153.95]:37134 "EHLO
        tarvos.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751620AbdAHVGe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 16:06:34 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
        Rama Krishna Phani A <rphani@codeaurora.org>
Subject: [PATCH] iio:adc:qcom-spmi-vadc: use div64_s64 instead of direct 64 bit division.
Date: Sun,  8 Jan 2017 21:06:29 +0000
Message-Id: <20170108210629.17725-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Another one of these that we missed previously which prevents test builds
of this driver on 32 bit platforms as it gives an undefined __divdi3 warning.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
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

