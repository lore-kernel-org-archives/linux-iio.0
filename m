Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53537 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754133AbcJYF1r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Oct 2016 01:27:47 -0400
From: Rama Krishna Phani A <rphani@codeaurora.org>
To: linux-iio@vger.kernel.org, jic23@kernel.org
Cc: linux-arm-msm@vger.kernel.org, smohanad@codeaurora.org,
        mgautam@codeaurora.org,
        Rama Krishna Phani A <rphani@codeaurora.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V1]iio: adc: spmi-vadc: Changes to support different scaling
Date: Tue, 25 Oct 2016 10:57:03 +0530
Message-Id: <1477373226-29587-1-git-send-email-rphani@codeaurora.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add changes to support different scale functions to convert adc code to
physical units.

Signed-off-by: Rama Krishna Phani A <rphani@codeaurora.org>
---
 drivers/iio/adc/qcom-spmi-vadc.c | 319 ++++++++++++++++++++++++++++++---------
 1 file changed, 249 insertions(+), 70 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index c2babe5..e605a9d 100644
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
@@ -92,6 +92,8 @@
 #define VADC_DEF_AVG_SAMPLES			0 /* 1 sample */
 #define VADC_DEF_CALIB_TYPE			VADC_CALIB_ABSOLUTE
 
+#define VADC_DEF_SCALE_FN			SCALE_DEFAULT
+
 #define VADC_DECIMATION_MIN			512
 #define VADC_DECIMATION_MAX			4096
 
@@ -100,9 +102,43 @@
 
 #define KELVINMIL_CELSIUSMIL			273150
 
+#define PMI_CHG_SCALE_1				-138890
+#define PMI_CHG_SCALE_2				391750000000
+
 #define VADC_CHAN_MIN			VADC_USBIN
 #define VADC_CHAN_MAX			VADC_LR_MUX3_BUF_PU1_PU2_XO_THERM
 
+/**
+ * enum vadc_scale_fn_type - Scaling function to convert ADC code to
+ *				physical scaled units for the channel.
+ * %SCALE_DEFAULT: Default scaling to convert raw adc code to voltage (uV).
+ * %SCALE_THERM_100K_PULLUP: Returns temperature in millidegC.
+ *				 Uses a mapping table with 100K pullup.
+ * %SCALE_PMIC_THERM: Returns result in milli degree's Centigrade.
+ * %SCALE_XOTHERM: Returns XO thermistor voltage in millidegC.
+ * %SCALE_PMI_CHG_TEMP: Conversion for PMI CHG temp
+ * %SCALE_NONE: Do not use this scaling type.
+ */
+enum vadc_scale_fn_type {
+	SCALE_DEFAULT = 0,
+	SCALE_THERM_100K_PULLUP,
+	SCALE_PMIC_THERM,
+	SCALE_XOTHERM,
+	SCALE_PMI_CHG_TEMP,
+	SCALE_NONE,
+};
+
+/**
+ * struct vadc_map_pt - Map the graph representation for ADC channel
+ * @x: Represent the ADC digitized code.
+ * @y: Represent the physical data which can be temperature, voltage,
+ *     resistance.
+ */
+struct vadc_map_pt {
+	s32 x;
+	s32 y;
+};
+
 /*
  * VADC_CALIB_ABSOLUTE: uses the 625mV and 1.25V as reference channels.
  * VADC_CALIB_RATIOMETRIC: uses the reference voltage (1.8V) and GND for
@@ -148,6 +184,9 @@ struct vadc_prescale_ratio {
  *	start of conversion.
  * @avg_samples: ability to provide single result from the ADC
  *	that is an average of multiple measurements.
+ *@scale_function: Represents the scaling function to convert voltage
+ *	physical units desired by the client for the channel.
+ *	Referenced from enum vadc_scale_fn_type.
  */
 struct vadc_channel_prop {
 	unsigned int channel;
@@ -156,6 +195,7 @@ struct vadc_channel_prop {
 	unsigned int prescale;
 	unsigned int hw_settle_time;
 	unsigned int avg_samples;
+	unsigned int scale_function;
 };
 
 /**
@@ -197,6 +237,44 @@ struct vadc_priv {
 	{.num =  1, .den = 10}
 };
 
+/* Voltage to temperature */
+static const struct vadc_map_pt adcmap_100k_104ef_104fb[] = {
+	{1758,	-40},
+	{1742,	-35},
+	{1719,	-30},
+	{1691,	-25},
+	{1654,	-20},
+	{1608,	-15},
+	{1551,	-10},
+	{1483,	-5},
+	{1404,	0},
+	{1315,	5},
+	{1218,	10},
+	{1114,	15},
+	{1007,	20},
+	{900,	25},
+	{795,	30},
+	{696,	35},
+	{605,	40},
+	{522,	45},
+	{448,	50},
+	{383,	55},
+	{327,	60},
+	{278,	65},
+	{237,	70},
+	{202,	75},
+	{172,	80},
+	{146,	85},
+	{125,	90},
+	{107,	95},
+	{92,	100},
+	{79,	105},
+	{68,	110},
+	{59,	115},
+	{51,	120},
+	{44,	125}
+};
+
 static int vadc_read(struct vadc_priv *vadc, u16 offset, u8 *data)
 {
 	return regmap_bulk_read(vadc->regmap, vadc->base + offset, data, 1);
@@ -418,7 +496,7 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
 	u16 read_1, read_2;
 	int ret;
 
-	vadc->graph[VADC_CALIB_RATIOMETRIC].dx = VADC_RATIOMETRIC_RANGE_UV;
+	vadc->graph[VADC_CALIB_RATIOMETRIC].dx = VADC_RATIOMETRIC_RANGE;
 	vadc->graph[VADC_CALIB_ABSOLUTE].dx = VADC_ABSOLUTE_RANGE_UV;
 
 	prop = vadc_get_channel(vadc, VADC_REF_1250MV);
@@ -468,27 +546,128 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
 	return ret;
 }
 
-static s32 vadc_calibrate(struct vadc_priv *vadc,
-			  const struct vadc_channel_prop *prop, u16 adc_code)
+static int vadc_map_voltage_temp(const struct vadc_map_pt *pts,
+				 u32 tablesize, s32 input, s64 *output)
 {
-	const struct vadc_prescale_ratio *prescale;
-	s64 voltage;
+	bool descending = 1;
+	u32 i = 0;
+
+	if (!pts)
+		return -EINVAL;
+
+	/* Check if table is descending or ascending */
+	if (tablesize > 1) {
+		if (pts[0].x < pts[1].x)
+			descending = 0;
+	}
+
+	while (i < tablesize) {
+		if ((descending == 1) && (pts[i].x < input)) {
+			/* table entry is less than measured*/
+			 /* value and table is descending, stop */
+			break;
+		} else if ((descending == 0) &&
+				(pts[i].x > input)) {
+			/* table entry is greater than measured*/
+			/*value and table is ascending, stop */
+			break;
+		}
+		i++;
+	}
+
+	if (i == 0) {
+		*output = pts[0].y;
+	} else if (i == tablesize) {
+		*output = pts[tablesize - 1].y;
+	} else {
+		/* result is between search_index and search_index-1 */
+		/* interpolate linearly */
+		*output = (((s32)((pts[i].y - pts[i - 1].y) *
+			(input - pts[i - 1].x)) /
+			(pts[i].x - pts[i - 1].x)) +
+			pts[i - 1].y);
+	}
 
-	voltage = adc_code - vadc->graph[prop->calibration].gnd;
-	voltage *= vadc->graph[prop->calibration].dx;
-	voltage = div64_s64(voltage, vadc->graph[prop->calibration].dy);
+	return 0;
+}
 
+static void vadc_scale_calib(struct vadc_priv *vadc, u16 adc_code,
+			     const struct vadc_channel_prop *prop,
+			     s64 *scale_voltage)
+{
+	*scale_voltage = (adc_code -
+		vadc->graph[prop->calibration].gnd);
+	*scale_voltage *= vadc->graph[prop->calibration].dx;
+	*scale_voltage = div64_s64(*scale_voltage,
+		vadc->graph[prop->calibration].dy);
 	if (prop->calibration == VADC_CALIB_ABSOLUTE)
-		voltage += vadc->graph[prop->calibration].dx;
+		*scale_voltage +=
+		vadc->graph[prop->calibration].dx;
 
-	if (voltage < 0)
-		voltage = 0;
+	if (*scale_voltage < 0)
+		*scale_voltage = 0;
+}
 
-	prescale = &vadc_prescale_ratios[prop->prescale];
+static s64 vadc_scale_fn(struct vadc_priv *vadc,
+			 const struct vadc_channel_prop *prop, u16 adc_code)
+{
+	const struct vadc_prescale_ratio *prescale;
+	s64 voltage = 0, result = 0;
+	int ret;
 
-	voltage = voltage * prescale->den;
+	switch (prop->scale_function) {
 
-	return div64_s64(voltage, prescale->num);
+	case SCALE_DEFAULT:
+		vadc_scale_calib(vadc, adc_code, prop, &voltage);
+
+		prescale = &vadc_prescale_ratios[prop->prescale];
+		voltage = voltage * prescale->den;
+		return div64_s64(voltage, prescale->num);
+
+	case SCALE_THERM_100K_PULLUP:
+	case SCALE_XOTHERM:
+		vadc_scale_calib(vadc, adc_code, prop, &voltage);
+
+		if (prop->calibration == VADC_CALIB_ABSOLUTE)
+			do_div(voltage, 1000);
+
+		vadc_map_voltage_temp(adcmap_100k_104ef_104fb,
+				      ARRAY_SIZE(adcmap_100k_104ef_104fb),
+				      voltage, &result);
+		result *= 1000;
+		return result;
+
+	case SCALE_PMIC_THERM:
+		vadc_scale_calib(vadc, adc_code, prop, &voltage);
+
+		if (voltage > 0) {
+			prescale = &vadc_prescale_ratios[prop->prescale];
+			voltage = voltage * prescale->den;
+			do_div(voltage, prescale->num * 2);
+		} else {
+			voltage = 0;
+		}
+
+		voltage -= KELVINMIL_CELSIUSMIL;
+
+		return voltage;
+
+	case SCALE_PMI_CHG_TEMP:
+		vadc_scale_calib(vadc, adc_code, prop, &voltage);
+		prescale = &vadc_prescale_ratios[prop->prescale];
+		voltage = voltage * prescale->den;
+
+		voltage = div64_s64(voltage, prescale->num);
+		voltage = ((PMI_CHG_SCALE_1) * (voltage * 2));
+		voltage = (voltage + PMI_CHG_SCALE_2);
+		return div64_s64(voltage, 1000000);
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
 }
 
 static int vadc_decimation_from_dt(u32 value)
@@ -552,11 +731,8 @@ static int vadc_read_raw(struct iio_dev *indio_dev,
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
@@ -564,12 +740,8 @@ static int vadc_read_raw(struct iio_dev *indio_dev,
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
@@ -613,11 +785,13 @@ struct vadc_channels {
 	},								\
 
 #define VADC_CHAN_TEMP(_dname, _pre)					\
-	VADC_CHAN(_dname, IIO_TEMP, BIT(IIO_CHAN_INFO_PROCESSED), _pre)	\
+	VADC_CHAN(_dname, IIO_TEMP,	\
+		BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_PROCESSED), \
+		_pre)	\
 
 #define VADC_CHAN_VOLT(_dname, _pre)					\
-	VADC_CHAN(_dname, IIO_VOLTAGE,					\
-		  BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),	\
+	VADC_CHAN(_dname, IIO_VOLTAGE,				\
+		  BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_PROCESSED),\
 		  _pre)							\
 
 /*
@@ -637,12 +811,11 @@ struct vadc_channels {
 	VADC_CHAN_TEMP(DIE_TEMP, 0)
 	VADC_CHAN_VOLT(REF_625MV, 0)
 	VADC_CHAN_VOLT(REF_1250MV, 0)
-	VADC_CHAN_VOLT(CHG_TEMP, 0)
+	VADC_CHAN_TEMP(CHG_TEMP, 0)
 	VADC_CHAN_VOLT(SPARE1, 0)
 	VADC_CHAN_VOLT(SPARE2, 0)
 	VADC_CHAN_VOLT(GND_REF, 0)
 	VADC_CHAN_VOLT(VDD_VADC, 0)
-
 	VADC_CHAN_VOLT(P_MUX1_1_1, 0)
 	VADC_CHAN_VOLT(P_MUX2_1_1, 0)
 	VADC_CHAN_VOLT(P_MUX3_1_1, 0)
@@ -659,7 +832,6 @@ struct vadc_channels {
 	VADC_CHAN_VOLT(P_MUX14_1_1, 0)
 	VADC_CHAN_VOLT(P_MUX15_1_1, 0)
 	VADC_CHAN_VOLT(P_MUX16_1_1, 0)
-
 	VADC_CHAN_VOLT(P_MUX1_1_3, 1)
 	VADC_CHAN_VOLT(P_MUX2_1_3, 1)
 	VADC_CHAN_VOLT(P_MUX3_1_3, 1)
@@ -676,7 +848,6 @@ struct vadc_channels {
 	VADC_CHAN_VOLT(P_MUX14_1_3, 1)
 	VADC_CHAN_VOLT(P_MUX15_1_3, 1)
 	VADC_CHAN_VOLT(P_MUX16_1_3, 1)
-
 	VADC_CHAN_VOLT(LR_MUX1_BAT_THERM, 0)
 	VADC_CHAN_VOLT(LR_MUX2_BAT_ID, 0)
 	VADC_CHAN_VOLT(LR_MUX3_XO_THERM, 0)
@@ -690,42 +861,40 @@ struct vadc_channels {
 	VADC_CHAN_VOLT(AMUX_PU1, 0)
 	VADC_CHAN_VOLT(AMUX_PU2, 0)
 	VADC_CHAN_VOLT(LR_MUX3_BUF_XO_THERM, 0)
-
-	VADC_CHAN_VOLT(LR_MUX1_PU1_BAT_THERM, 0)
+	VADC_CHAN_TEMP(LR_MUX1_PU1_BAT_THERM, 0)
 	VADC_CHAN_VOLT(LR_MUX2_PU1_BAT_ID, 0)
-	VADC_CHAN_VOLT(LR_MUX3_PU1_XO_THERM, 0)
-	VADC_CHAN_VOLT(LR_MUX4_PU1_AMUX_THM1, 0)
-	VADC_CHAN_VOLT(LR_MUX5_PU1_AMUX_THM2, 0)
-	VADC_CHAN_VOLT(LR_MUX6_PU1_AMUX_THM3, 0)
+	VADC_CHAN_TEMP(LR_MUX3_PU1_XO_THERM, 0)
+	VADC_CHAN_TEMP(LR_MUX4_PU1_AMUX_THM1, 0)
+	VADC_CHAN_TEMP(LR_MUX5_PU1_AMUX_THM2, 0)
+	VADC_CHAN_TEMP(LR_MUX6_PU1_AMUX_THM3, 0)
 	VADC_CHAN_VOLT(LR_MUX7_PU1_AMUX_HW_ID, 0)
-	VADC_CHAN_VOLT(LR_MUX8_PU1_AMUX_THM4, 0)
-	VADC_CHAN_VOLT(LR_MUX9_PU1_AMUX_THM5, 0)
+	VADC_CHAN_TEMP(LR_MUX8_PU1_AMUX_THM4, 0)
+	VADC_CHAN_TEMP(LR_MUX9_PU1_AMUX_THM5, 0)
 	VADC_CHAN_VOLT(LR_MUX10_PU1_AMUX_USB_ID, 0)
-	VADC_CHAN_VOLT(LR_MUX3_BUF_PU1_XO_THERM, 0)
-
-	VADC_CHAN_VOLT(LR_MUX1_PU2_BAT_THERM, 0)
+	VADC_CHAN_TEMP(LR_MUX3_BUF_PU1_XO_THERM, 0)
+	VADC_CHAN_TEMP(LR_MUX1_PU2_BAT_THERM, 0)
 	VADC_CHAN_VOLT(LR_MUX2_PU2_BAT_ID, 0)
-	VADC_CHAN_VOLT(LR_MUX3_PU2_XO_THERM, 0)
-	VADC_CHAN_VOLT(LR_MUX4_PU2_AMUX_THM1, 0)
-	VADC_CHAN_VOLT(LR_MUX5_PU2_AMUX_THM2, 0)
-	VADC_CHAN_VOLT(LR_MUX6_PU2_AMUX_THM3, 0)
+	VADC_CHAN_TEMP(LR_MUX3_PU2_XO_THERM, 0)
+	VADC_CHAN_TEMP(LR_MUX4_PU2_AMUX_THM1, 0)
+	VADC_CHAN_TEMP(LR_MUX5_PU2_AMUX_THM2, 0)
+	VADC_CHAN_TEMP(LR_MUX6_PU2_AMUX_THM3, 0)
 	VADC_CHAN_VOLT(LR_MUX7_PU2_AMUX_HW_ID, 0)
-	VADC_CHAN_VOLT(LR_MUX8_PU2_AMUX_THM4, 0)
-	VADC_CHAN_VOLT(LR_MUX9_PU2_AMUX_THM5, 0)
+	VADC_CHAN_TEMP(LR_MUX8_PU2_AMUX_THM4, 0)
+	VADC_CHAN_TEMP(LR_MUX9_PU2_AMUX_THM5, 0)
 	VADC_CHAN_VOLT(LR_MUX10_PU2_AMUX_USB_ID, 0)
-	VADC_CHAN_VOLT(LR_MUX3_BUF_PU2_XO_THERM, 0)
-
-	VADC_CHAN_VOLT(LR_MUX1_PU1_PU2_BAT_THERM, 0)
+	VADC_CHAN_TEMP(LR_MUX3_BUF_PU2_XO_THERM, 0)
+	VADC_CHAN_TEMP(LR_MUX1_PU1_PU2_BAT_THERM, 0)
 	VADC_CHAN_VOLT(LR_MUX2_PU1_PU2_BAT_ID, 0)
-	VADC_CHAN_VOLT(LR_MUX3_PU1_PU2_XO_THERM, 0)
-	VADC_CHAN_VOLT(LR_MUX4_PU1_PU2_AMUX_THM1, 0)
-	VADC_CHAN_VOLT(LR_MUX5_PU1_PU2_AMUX_THM2, 0)
-	VADC_CHAN_VOLT(LR_MUX6_PU1_PU2_AMUX_THM3, 0)
+	VADC_CHAN_TEMP(LR_MUX3_PU1_PU2_XO_THERM, 0)
+	VADC_CHAN_TEMP(LR_MUX4_PU1_PU2_AMUX_THM1, 0)
+	VADC_CHAN_TEMP(LR_MUX5_PU1_PU2_AMUX_THM2, 0)
+	VADC_CHAN_TEMP(LR_MUX6_PU1_PU2_AMUX_THM3, 0)
 	VADC_CHAN_VOLT(LR_MUX7_PU1_PU2_AMUX_HW_ID, 0)
-	VADC_CHAN_VOLT(LR_MUX8_PU1_PU2_AMUX_THM4, 0)
-	VADC_CHAN_VOLT(LR_MUX9_PU1_PU2_AMUX_THM5, 0)
+	VADC_CHAN_TEMP(LR_MUX8_PU1_PU2_AMUX_THM4, 0)
+	VADC_CHAN_TEMP(LR_MUX9_PU1_PU2_AMUX_THM5, 0)
 	VADC_CHAN_VOLT(LR_MUX10_PU1_PU2_AMUX_USB_ID, 0)
-	VADC_CHAN_VOLT(LR_MUX3_BUF_PU1_PU2_XO_THERM, 0)
+	VADC_CHAN_TEMP(LR_MUX3_BUF_PU1_PU2_XO_THERM, 0)
+
 };
 
 static int vadc_get_dt_channel_data(struct device *dev,
@@ -802,6 +971,11 @@ static int vadc_get_dt_channel_data(struct device *dev,
 		prop->avg_samples = VADC_DEF_AVG_SAMPLES;
 	}
 
+	ret = of_property_read_u32(node, "qcom,scale-function",
+				   &prop->scale_function);
+	if (ret)
+		prop->scale_function = SCALE_DEFAULT;
+
 	if (of_property_read_bool(node, "qcom,ratiometric"))
 		prop->calibration = VADC_CALIB_RATIOMETRIC;
 	else
@@ -850,9 +1024,9 @@ static int vadc_get_dt_data(struct vadc_priv *vadc, struct device_node *node)
 
 		iio_chan->channel = prop.channel;
 		iio_chan->datasheet_name = vadc_chan->datasheet_name;
+		iio_chan->extend_name = child->name;
 		iio_chan->info_mask_separate = vadc_chan->info_mask;
 		iio_chan->type = vadc_chan->type;
-		iio_chan->indexed = 1;
 		iio_chan->address = index++;
 
 		iio_chan++;
@@ -964,16 +1138,21 @@ static int vadc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	irq_eoc = platform_get_irq(pdev, 0);
-	if (irq_eoc < 0) {
-		if (irq_eoc == -EPROBE_DEFER || irq_eoc == -EINVAL)
-			return irq_eoc;
-		vadc->poll_eoc = true;
-	} else {
-		ret = devm_request_irq(dev, irq_eoc, vadc_isr, 0,
-				       "spmi-vadc", vadc);
-		if (ret)
-			return ret;
+	vadc->poll_eoc = of_property_read_bool(node,
+						"qcom,vadc-poll-eoc");
+
+	if (!vadc->poll_eoc) {
+		irq_eoc = platform_get_irq(pdev, 0);
+		if (irq_eoc < 0) {
+			if (irq_eoc == -EPROBE_DEFER || irq_eoc == -EINVAL)
+				return irq_eoc;
+			vadc->poll_eoc = true;
+		} else {
+			ret = devm_request_irq(dev, irq_eoc, vadc_isr, 0,
+					       "spmi-vadc", vadc);
+			if (ret)
+				return ret;
+		}
 	}
 
 	ret = vadc_reset(vadc);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

