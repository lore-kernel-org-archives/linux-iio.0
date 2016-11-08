Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48172 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932754AbcKHMBB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Nov 2016 07:01:01 -0500
From: Rama Krishna Phani A <rphani@codeaurora.org>
To: linux-iio@vger.kernel.org, jic23@kernel.org
Cc: linux-arm-msm@vger.kernel.org, cdevired@codeaurora.org,
        smohanad@codeaurora.org, mgautam@codeaurora.org,
        sivaa@codeaurora.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, Julia.Lawall@lip6.fr,
        Rama Krishna Phani A <rphani@codeaurora.org>
Subject: [PATCH V4 1/2] iio: adc: spmi-vadc: Update function for generic voltage conversion
Date: Tue,  8 Nov 2016 17:28:53 +0530
Message-Id: <1478606334-12394-2-git-send-email-rphani@codeaurora.org>
In-Reply-To: <1478606334-12394-1-git-send-email-rphani@codeaurora.org>
References: <1478606334-12394-1-git-send-email-rphani@codeaurora.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Several channels are supported in ADC of PMIC which can be used to
measure voltage, temperature, current etc. Hardware provides
readings for all channels in adc code. That adc code needs to be
converted to voltage. Logic for conversion of adc code to voltage
is common for all ADC channels(voltage, temperature, current etc).
Implement separate function for generic conversion logic.

Signed-off-by: Rama Krishna Phani A <rphani@codeaurora.org>
---
 drivers/iio/adc/qcom-spmi-vadc.c | 52 +++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index c2babe5..93c0639 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2012-2014, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2012-2016, The Linux Foundation. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -468,27 +468,38 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
 	return ret;
 }
 
-static s32 vadc_calibrate(struct vadc_priv *vadc,
-			  const struct vadc_channel_prop *prop, u16 adc_code)
+static void vadc_scale_calib(struct vadc_priv *vadc, u16 adc_code,
+			     const struct vadc_channel_prop *prop,
+			     s64 *scale_voltage)
 {
-	const struct vadc_prescale_ratio *prescale;
-	s64 voltage;
+	*scale_voltage = (adc_code -
+		vadc->graph[prop->calibration].gnd);
+	*scale_voltage *= vadc->graph[prop->calibration].dx;
+	*scale_voltage = div64_s64(*scale_voltage,
+		vadc->graph[prop->calibration].dy);
+	if (prop->calibration == VADC_CALIB_ABSOLUTE)
+		*scale_voltage +=
+		vadc->graph[prop->calibration].dx;
 
-	voltage = adc_code - vadc->graph[prop->calibration].gnd;
-	voltage *= vadc->graph[prop->calibration].dx;
-	voltage = div64_s64(voltage, vadc->graph[prop->calibration].dy);
+	if (*scale_voltage < 0)
+		*scale_voltage = 0;
+}
 
-	if (prop->calibration == VADC_CALIB_ABSOLUTE)
-		voltage += vadc->graph[prop->calibration].dx;
+static int vadc_scale_volt(struct vadc_priv *vadc,
+			   const struct vadc_channel_prop *prop, u16 adc_code,
+			   int *result_uv)
+{
+	const struct vadc_prescale_ratio *prescale;
+	s64 voltage = 0, result = 0;
 
-	if (voltage < 0)
-		voltage = 0;
+	vadc_scale_calib(vadc, adc_code, prop, &voltage);
 
 	prescale = &vadc_prescale_ratios[prop->prescale];
-
 	voltage = voltage * prescale->den;
+	result = div64_s64(voltage, prescale->num);
+	*result_uv = result;
 
-	return div64_s64(voltage, prescale->num);
+	return 0;
 }
 
 static int vadc_decimation_from_dt(u32 value)
@@ -552,11 +563,8 @@ static int vadc_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			break;
 
-		*val = vadc_calibrate(vadc, prop, adc_code);
+		vadc_scale_volt(vadc, prop, adc_code, val);
 
-		/* 2mV/K, return milli Celsius */
-		*val /= 2;
-		*val -= KELVINMIL_CELSIUSMIL;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_RAW:
 		prop = &vadc->chan_props[chan->address];
@@ -564,12 +572,8 @@ static int vadc_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			break;
 
-		*val = vadc_calibrate(vadc, prop, adc_code);
+		*val = (int)adc_code;
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE:
-		*val = 0;
-		*val2 = 1000;
-		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		ret = -EINVAL;
 		break;
@@ -617,7 +621,7 @@ struct vadc_channels {
 
 #define VADC_CHAN_VOLT(_dname, _pre)					\
 	VADC_CHAN(_dname, IIO_VOLTAGE,					\
-		  BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),	\
+		  BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_PROCESSED),\
 		  _pre)							\
 
 /*
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

