Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43720 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942191AbcJZNBz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Oct 2016 09:01:55 -0400
From: Rama Krishna Phani A <rphani@codeaurora.org>
To: linux-iio@vger.kernel.org, jic23@kernel.org
Cc: linux-arm-msm@vger.kernel.org, smohanad@codeaurora.org,
        mgautam@codeaurora.org, sivaa@codeaurora.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, Julia.Lawall@lip6.fr,
        Rama Krishna Phani A <rphani@codeaurora.org>
Subject: [PATCH V2 1/2] iio: adc: spmi-vadc: Update changes to support reporting of Raw adc code.
Date: Wed, 26 Oct 2016 18:30:50 +0530
Message-Id: <1477486851-24700-2-git-send-email-rphani@codeaurora.org>
In-Reply-To: <1477486851-24700-1-git-send-email-rphani@codeaurora.org>
References: <1477486851-24700-1-git-send-email-rphani@codeaurora.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Update changes to support reporting of Raw adc code.

Signed-off-by: Rama Krishna Phani A <rphani@codeaurora.org>
---
 drivers/iio/adc/qcom-spmi-vadc.c | 54 +++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index c2babe5..ff4d549 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2012-2014, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2012-2016, The Linux Foundation. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -84,7 +84,7 @@
 #define VADC_MAX_ADC_CODE			0xa800
 
 #define VADC_ABSOLUTE_RANGE_UV			625000
-#define VADC_RATIOMETRIC_RANGE_UV		1800000
+#define VADC_RATIOMETRIC_RANGE			1800
 
 #define VADC_DEF_PRESCALING			0 /* 1:1 */
 #define VADC_DEF_DECIMATION			0 /* 512 */
@@ -418,7 +418,7 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
 	u16 read_1, read_2;
 	int ret;
 
-	vadc->graph[VADC_CALIB_RATIOMETRIC].dx = VADC_RATIOMETRIC_RANGE_UV;
+	vadc->graph[VADC_CALIB_RATIOMETRIC].dx = VADC_RATIOMETRIC_RANGE;
 	vadc->graph[VADC_CALIB_ABSOLUTE].dx = VADC_ABSOLUTE_RANGE_UV;
 
 	prop = vadc_get_channel(vadc, VADC_REF_1250MV);
@@ -468,21 +468,30 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
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
+static s64 vadc_scale_fn(struct vadc_priv *vadc,
+			 const struct vadc_channel_prop *prop, u16 adc_code)
+{
+	const struct vadc_prescale_ratio *prescale;
+	s64 voltage = 0;
 
-	if (voltage < 0)
-		voltage = 0;
+	vadc_scale_calib(vadc, adc_code, prop, &voltage);
 
 	prescale = &vadc_prescale_ratios[prop->prescale];
 
@@ -552,11 +561,8 @@ static int vadc_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			break;
 
-		*val = vadc_calibrate(vadc, prop, adc_code);
+		*val = vadc_scale_fn(vadc, prop, adc_code);
 
-		/* 2mV/K, return milli Celsius */
-		*val /= 2;
-		*val -= KELVINMIL_CELSIUSMIL;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_RAW:
 		prop = &vadc->chan_props[chan->address];
@@ -564,12 +570,8 @@ static int vadc_read_raw(struct iio_dev *indio_dev,
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
@@ -616,8 +618,8 @@ struct vadc_channels {
 	VADC_CHAN(_dname, IIO_TEMP, BIT(IIO_CHAN_INFO_PROCESSED), _pre)	\
 
 #define VADC_CHAN_VOLT(_dname, _pre)					\
-	VADC_CHAN(_dname, IIO_VOLTAGE,					\
-		  BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),	\
+	VADC_CHAN(_dname, IIO_VOLTAGE,				\
+		  BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_PROCESSED),\
 		  _pre)							\
 
 /*
@@ -850,9 +852,9 @@ static int vadc_get_dt_data(struct vadc_priv *vadc, struct device_node *node)
 
 		iio_chan->channel = prop.channel;
 		iio_chan->datasheet_name = vadc_chan->datasheet_name;
+		iio_chan->extend_name = child->name;
 		iio_chan->info_mask_separate = vadc_chan->info_mask;
 		iio_chan->type = vadc_chan->type;
-		iio_chan->indexed = 1;
 		iio_chan->address = index++;
 
 		iio_chan++;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

