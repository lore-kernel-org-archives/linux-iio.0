Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Rama Krishna Phani A <rphani@codeaurora.org>
Subject: [PATCH 1/2] iio:adc:qcom-spmi-vadc : fix undefined __divdi3
Date: Fri, 30 Dec 2016 18:25:49 +0000
Message-Id: <20161230182550.12038-1-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

A simple do_div call works here as all the signed 64 bit is
actually small and unsigned at this point, and the numerator is
u32.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Cc: Rama Krishna Phani A <rphani@codeaurora.org>
---
 drivers/iio/adc/qcom-spmi-vadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index aaf4caf06505..9da3a8fb7514 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -664,7 +664,7 @@ static int vadc_scale_die_temp(struct vadc_priv *vadc,
 	if (voltage > 0) {
 		prescale = &vadc_prescale_ratios[prop->prescale];
 		voltage = voltage * prescale->den;
-		voltage /= (prescale->num * 2);
+		do_div(voltage, prescale->num * 2);
 	} else {
 		voltage = 0;
 	}
-- 
2.11.0
