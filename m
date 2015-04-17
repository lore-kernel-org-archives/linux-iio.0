Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37785 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965455AbbDQOvQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2015 10:51:16 -0400
Received: by widdi4 with SMTP id di4so23230918wid.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2015 07:51:14 -0700 (PDT)
From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] iio: adc: spmi-vadc: Fix overflow in output value normalization
Date: Fri, 17 Apr 2015 17:51:08 +0300
Message-Id: <1429282268-30501-1-git-send-email-ivan.ivanov@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

With 'dx' equal to 0.625V and 15 bit ADC, calculations overflow
when difference against GND is ~20% of the ADC range. Fix this.

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
---
 drivers/iio/adc/qcom-spmi-vadc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index 3211729..0c4618b 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -18,6 +18,7 @@
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -471,11 +472,11 @@ static s32 vadc_calibrate(struct vadc_priv *vadc,
 			  const struct vadc_channel_prop *prop, u16 adc_code)
 {
 	const struct vadc_prescale_ratio *prescale;
-	s32 voltage;
+	s64 voltage;

 	voltage = adc_code - vadc->graph[prop->calibration].gnd;
 	voltage *= vadc->graph[prop->calibration].dx;
-	voltage = voltage / vadc->graph[prop->calibration].dy;
+	voltage = div64_s64(voltage, vadc->graph[prop->calibration].dy);

 	if (prop->calibration == VADC_CALIB_ABSOLUTE)
 		voltage += vadc->graph[prop->calibration].dx;
@@ -487,7 +488,7 @@ static s32 vadc_calibrate(struct vadc_priv *vadc,

 	voltage = voltage * prescale->den;

-	return voltage / prescale->num;
+	return div64_s64(voltage, prescale->num);
 }

 static int vadc_decimation_from_dt(u32 value)
--
1.9.1

