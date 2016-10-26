Return-Path: <rphani@codeaurora.org>
From: Rama Krishna Phani A <rphani@codeaurora.org>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	smohanad@codeaurora.org,
	mgautam@codeaurora.org,
	sivaa@codeaurora.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	Julia.Lawall@lip6.fr,
	Rama Krishna Phani A <rphani@codeaurora.org>
Subject: [PATCH V2 2/2] iio: adc: spmi-vadc: Changes to support different scaling
Date: Wed, 26 Oct 2016 18:30:51 +0530
Message-Id: <1477486851-24700-3-git-send-email-rphani@codeaurora.org>
In-Reply-To: <1477486851-24700-1-git-send-email-rphani@codeaurora.org>
References: <1477486851-24700-1-git-send-email-rphani@codeaurora.org>
List-ID: <linux-iio@vger.kernel.org>

Add changes to support different scale functions to convert adc code to
physical units.

Signed-off-by: Rama Krishna Phani A <rphani@codeaurora.org>
---
 .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt |  14 ++
 drivers/iio/adc/qcom-spmi-vadc.c                   | 263 +++++++++++++++++----
 2 files changed, 236 insertions(+), 41 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
index 0fb4613..39e31c0e 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
@@ -37,6 +37,12 @@ VADC node:
     Value type: <prop-encoded-array>
     Definition: End of conversion interrupt.
 
+- qcom,vadc-poll-eoc:
+    Usage: optional
+    Value type: <bool>
+    Definition: Use polling instead of interrupts for End of Conversion
+		completion.
+
 Channel node properties:
 
 - reg:
@@ -92,6 +98,14 @@ Channel node properties:
             Valid values are: 1, 2, 4, 8, 16, 32, 64, 128, 256, 512
             If property is not found, 1 sample will be used.
 
+- qcom,scale-function:
+    Usage: optional
+    Value type: <u32>
+    Definition: Scaling function used to convert raw ADC code to
+	units specific to a given channel. Scaled units can be
+	microvolts, millidegC.Valid values are: 0, 1, 2, 3, 4.
+	If property is not found, 0 scaling will be used.
+
 NOTE:
 
 Following channels, also known as reference point channels, are used for
diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index ff4d549..6e521a9 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
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
@@ -468,6 +546,51 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
 	return ret;
 }
 
+static int vadc_map_voltage_temp(const struct vadc_map_pt *pts,
+				 u32 tablesize, s32 input, s64 *output)
+{
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
+		if ((descending) && (pts[i].x < input)) {
+			/* table entry is less than measured*/
+			 /* value and table is descending, stop */
+			break;
+		} else if ((!descending) &&
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
+
+	return 0;
+}
+
 static void vadc_scale_calib(struct vadc_priv *vadc, u16 adc_code,
 			     const struct vadc_channel_prop *prop,
 			     s64 *scale_voltage)
@@ -489,15 +612,61 @@ static s64 vadc_scale_fn(struct vadc_priv *vadc,
 			 const struct vadc_channel_prop *prop, u16 adc_code)
 {
 	const struct vadc_prescale_ratio *prescale;
-	s64 voltage = 0;
+	s64 voltage = 0, result = 0;
+	int ret;
+
+	switch (prop->scale_function) {
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
+			voltage /= 1000;
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
+			voltage /= (prescale->num * 2);
+		} else {
+			voltage = 0;
+		}
+
+		voltage -= KELVINMIL_CELSIUSMIL;
 
-	vadc_scale_calib(vadc, adc_code, prop, &voltage);
+		return voltage;
 
-	prescale = &vadc_prescale_ratios[prop->prescale];
+	case SCALE_PMI_CHG_TEMP:
+		vadc_scale_calib(vadc, adc_code, prop, &voltage);
+		prescale = &vadc_prescale_ratios[prop->prescale];
+		voltage = voltage * prescale->den;
 
-	voltage = voltage * prescale->den;
+		voltage = div64_s64(voltage, prescale->num);
+		voltage = ((PMI_CHG_SCALE_1) * (voltage * 2));
+		voltage = (voltage + PMI_CHG_SCALE_2);
+		return div64_s64(voltage, 1000000);
 
-	return div64_s64(voltage, prescale->num);
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
 }
 
 static int vadc_decimation_from_dt(u32 value)
@@ -615,7 +784,9 @@ struct vadc_channels {
 	},								\
 
 #define VADC_CHAN_TEMP(_dname, _pre)					\
-	VADC_CHAN(_dname, IIO_TEMP, BIT(IIO_CHAN_INFO_PROCESSED), _pre)	\
+	VADC_CHAN(_dname, IIO_TEMP,	\
+		BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_PROCESSED), \
+		_pre)	\
 
 #define VADC_CHAN_VOLT(_dname, _pre)					\
 	VADC_CHAN(_dname, IIO_VOLTAGE,				\
@@ -639,7 +810,7 @@ struct vadc_channels {
 	VADC_CHAN_TEMP(DIE_TEMP, 0)
 	VADC_CHAN_VOLT(REF_625MV, 0)
 	VADC_CHAN_VOLT(REF_1250MV, 0)
-	VADC_CHAN_VOLT(CHG_TEMP, 0)
+	VADC_CHAN_TEMP(CHG_TEMP, 0)
 	VADC_CHAN_VOLT(SPARE1, 0)
 	VADC_CHAN_VOLT(SPARE2, 0)
 	VADC_CHAN_VOLT(GND_REF, 0)
@@ -693,41 +864,41 @@ struct vadc_channels {
 	VADC_CHAN_VOLT(AMUX_PU2, 0)
 	VADC_CHAN_VOLT(LR_MUX3_BUF_XO_THERM, 0)
 
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
+	VADC_CHAN_TEMP(LR_MUX3_BUF_PU1_XO_THERM, 0)
 
-	VADC_CHAN_VOLT(LR_MUX1_PU2_BAT_THERM, 0)
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
+	VADC_CHAN_TEMP(LR_MUX3_BUF_PU2_XO_THERM, 0)
 
-	VADC_CHAN_VOLT(LR_MUX1_PU1_PU2_BAT_THERM, 0)
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
 };
 
 static int vadc_get_dt_channel_data(struct device *dev,
@@ -804,6 +975,11 @@ static int vadc_get_dt_channel_data(struct device *dev,
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
@@ -966,16 +1142,21 @@ static int vadc_probe(struct platform_device *pdev)
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
