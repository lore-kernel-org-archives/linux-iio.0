Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:36261 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdAQOeJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2017 09:34:09 -0500
Received: by mail-lf0-f51.google.com with SMTP id z134so105781714lff.3
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2017 06:33:10 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        "Ivan T . Ivanov" <iivanov.xz@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rama Krishna Phani A <rphani@codeaurora.org>
Subject: [PATCH 2/3 v3] iio: adc: break out common code from SPMI VADC
Date: Tue, 17 Jan 2017 15:25:14 +0100
Message-Id: <20170117142515.10578-2-linus.walleij@linaro.org>
In-Reply-To: <20170117142515.10578-1-linus.walleij@linaro.org>
References: <20170117142515.10578-1-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The SPMI VADC and the earlier XOADC share a subset of
common code, so to be able to use the same code in both
drivers, we break out a separate file with the common code,
prefix exported functions that are no longer static with
qcom_* and bake an object qcom-vadc.o that contains both
files: qcom-vadc-common.o and qcom-spmi-vadc.o.

Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
Cc: Ivan T. Ivanov <iivanov.xz@gmail.com>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Rama Krishna Phani A <rphani@codeaurora.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Rewrite on top of Rama Krishna's changes. Now we use the
  generic channel properties, calibration graph and prescale
  settings in all VADC drivers. I did away with the vtable
  indirection which I just don't see the point of, it's
  better to just pass the type of conversion function around
  and have a switch case select the conversion. It was done like
  that in the vendor tree but it's not a good idea.
ChangeLog v1->v2:
- No changes just reposting
---
 drivers/iio/adc/Makefile           |   3 +-
 drivers/iio/adc/qcom-spmi-vadc.c   | 325 ++-----------------------------------
 drivers/iio/adc/qcom-vadc-common.c | 228 ++++++++++++++++++++++++++
 drivers/iio/adc/qcom-vadc-common.h | 103 ++++++++++++
 4 files changed, 348 insertions(+), 311 deletions(-)
 create mode 100644 drivers/iio/adc/qcom-vadc-common.c
 create mode 100644 drivers/iio/adc/qcom-vadc-common.h

diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 260d083a2b3f..f8fe647b7abe 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -41,7 +41,8 @@ obj-$(CONFIG_MXS_LRADC) += mxs-lradc.o
 obj-$(CONFIG_NAU7802) += nau7802.o
 obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
 obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
-obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
+qcom-vadc-y := qcom-vadc-common.o
+obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-vadc.o qcom-spmi-vadc.o
 obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
 obj-$(CONFIG_STX104) += stx104.o
 obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index 0a19761d656c..9e600bfd1765 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -28,6 +28,8 @@
 
 #include <dt-bindings/iio/qcom,spmi-vadc.h>
 
+#include "qcom-vadc-common.h"
+
 /* VADC register and bit definitions */
 #define VADC_REVISION2				0x1
 #define VADC_REVISION2_SUPPORTED_VADC		1
@@ -75,84 +77,10 @@
 
 #define VADC_DATA				0x60	/* 16 bits */
 
-#define VADC_CONV_TIME_MIN_US			2000
-#define VADC_CONV_TIME_MAX_US			2100
-
-/* Min ADC code represents 0V */
-#define VADC_MIN_ADC_CODE			0x6000
-/* Max ADC code represents full-scale range of 1.8V */
-#define VADC_MAX_ADC_CODE			0xa800
-
-#define VADC_ABSOLUTE_RANGE_UV			625000
-#define VADC_RATIOMETRIC_RANGE			1800
-
-#define VADC_DEF_PRESCALING			0 /* 1:1 */
-#define VADC_DEF_DECIMATION			0 /* 512 */
-#define VADC_DEF_HW_SETTLE_TIME			0 /* 0 us */
-#define VADC_DEF_AVG_SAMPLES			0 /* 1 sample */
-#define VADC_DEF_CALIB_TYPE			VADC_CALIB_ABSOLUTE
-
-#define VADC_DECIMATION_MIN			512
-#define VADC_DECIMATION_MAX			4096
-
-#define VADC_HW_SETTLE_DELAY_MAX		10000
-#define VADC_AVG_SAMPLES_MAX			512
-
-#define KELVINMIL_CELSIUSMIL			273150
-
-#define PMI_CHG_SCALE_1				-138890
-#define PMI_CHG_SCALE_2				391750000000LL
-
 #define VADC_CHAN_MIN			VADC_USBIN
 #define VADC_CHAN_MAX			VADC_LR_MUX3_BUF_PU1_PU2_XO_THERM
 
 /**
- * struct vadc_map_pt - Map the graph representation for ADC channel
- * @x: Represent the ADC digitized code.
- * @y: Represent the physical data which can be temperature, voltage,
- *     resistance.
- */
-struct vadc_map_pt {
-	s32 x;
-	s32 y;
-};
-
-/*
- * VADC_CALIB_ABSOLUTE: uses the 625mV and 1.25V as reference channels.
- * VADC_CALIB_RATIOMETRIC: uses the reference voltage (1.8V) and GND for
- * calibration.
- */
-enum vadc_calibration {
-	VADC_CALIB_ABSOLUTE = 0,
-	VADC_CALIB_RATIOMETRIC
-};
-
-/**
- * struct vadc_linear_graph - Represent ADC characteristics.
- * @dy: numerator slope to calculate the gain.
- * @dx: denominator slope to calculate the gain.
- * @gnd: A/D word of the ground reference used for the channel.
- *
- * Each ADC device has different offset and gain parameters which are
- * computed to calibrate the device.
- */
-struct vadc_linear_graph {
-	s32 dy;
-	s32 dx;
-	s32 gnd;
-};
-
-/**
- * struct vadc_prescale_ratio - Represent scaling ratio for ADC input.
- * @num: the inverse numerator of the gain applied to the input channel.
- * @den: the inverse denominator of the gain applied to the input channel.
- */
-struct vadc_prescale_ratio {
-	u32 num;
-	u32 den;
-};
-
-/**
  * struct vadc_channel_prop - VADC channel property.
  * @channel: channel number, refer to the channel list.
  * @calibration: calibration type.
@@ -162,9 +90,8 @@ struct vadc_prescale_ratio {
  *	start of conversion.
  * @avg_samples: ability to provide single result from the ADC
  *	that is an average of multiple measurements.
- * @scale_fn: Represents the scaling function to convert voltage
+ * @scale_fn_type: Represents the scaling function to convert voltage
  *	physical units desired by the client for the channel.
- *	Referenced from enum vadc_scale_fn_type.
  */
 struct vadc_channel_prop {
 	unsigned int channel;
@@ -173,7 +100,7 @@ struct vadc_channel_prop {
 	unsigned int prescale;
 	unsigned int hw_settle_time;
 	unsigned int avg_samples;
-	unsigned int scale_fn;
+	enum vadc_scale_fn_type scale_fn_type;
 };
 
 /**
@@ -204,35 +131,6 @@ struct vadc_priv {
 	struct mutex		 lock;
 };
 
-/**
- * struct vadc_scale_fn - Scaling function prototype
- * @scale: Function pointer to one of the scaling functions
- *	which takes the adc properties, channel properties,
- *	and returns the physical result.
- */
-struct vadc_scale_fn {
-	int (*scale)(struct vadc_priv *, const struct vadc_channel_prop *,
-		     u16, int *);
-};
-
-/**
- * enum vadc_scale_fn_type - Scaling function to convert ADC code to
- *				physical scaled units for the channel.
- * SCALE_DEFAULT: Default scaling to convert raw adc code to voltage (uV).
- * SCALE_THERM_100K_PULLUP: Returns temperature in millidegC.
- *				 Uses a mapping table with 100K pullup.
- * SCALE_PMIC_THERM: Returns result in milli degree's Centigrade.
- * SCALE_XOTHERM: Returns XO thermistor voltage in millidegC.
- * SCALE_PMI_CHG_TEMP: Conversion for PMI CHG temp
- */
-enum vadc_scale_fn_type {
-	SCALE_DEFAULT = 0,
-	SCALE_THERM_100K_PULLUP,
-	SCALE_PMIC_THERM,
-	SCALE_XOTHERM,
-	SCALE_PMI_CHG_TEMP,
-};
-
 static const struct vadc_prescale_ratio vadc_prescale_ratios[] = {
 	{.num =  1, .den =  1},
 	{.num =  1, .den =  3},
@@ -244,44 +142,6 @@ static const struct vadc_prescale_ratio vadc_prescale_ratios[] = {
 	{.num =  1, .den = 10}
 };
 
-/* Voltage to temperature */
-static const struct vadc_map_pt adcmap_100k_104ef_104fb[] = {
-	{1758,	-40},
-	{1742,	-35},
-	{1719,	-30},
-	{1691,	-25},
-	{1654,	-20},
-	{1608,	-15},
-	{1551,	-10},
-	{1483,	-5},
-	{1404,	0},
-	{1315,	5},
-	{1218,	10},
-	{1114,	15},
-	{1007,	20},
-	{900,	25},
-	{795,	30},
-	{696,	35},
-	{605,	40},
-	{522,	45},
-	{448,	50},
-	{383,	55},
-	{327,	60},
-	{278,	65},
-	{237,	70},
-	{202,	75},
-	{172,	80},
-	{146,	85},
-	{125,	90},
-	{107,	95},
-	{92,	100},
-	{79,	105},
-	{68,	110},
-	{59,	115},
-	{51,	120},
-	{44,	125}
-};
-
 static int vadc_read(struct vadc_priv *vadc, u16 offset, u8 *data)
 {
 	return regmap_bulk_read(vadc->regmap, vadc->base + offset, data, 1);
@@ -553,159 +413,6 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
 	return ret;
 }
 
-static int vadc_map_voltage_temp(const struct vadc_map_pt *pts,
-				 u32 tablesize, s32 input, s64 *output)
-{
-	bool descending = 1;
-	u32 i = 0;
-
-	if (!pts)
-		return -EINVAL;
-
-	/* Check if table is descending or ascending */
-	if (tablesize > 1) {
-		if (pts[0].x < pts[1].x)
-			descending = 0;
-	}
-
-	while (i < tablesize) {
-		if ((descending) && (pts[i].x < input)) {
-			/* table entry is less than measured*/
-			 /* value and table is descending, stop */
-			break;
-		} else if ((!descending) &&
-				(pts[i].x > input)) {
-			/* table entry is greater than measured*/
-			/*value and table is ascending, stop */
-			break;
-		}
-		i++;
-	}
-
-	if (i == 0) {
-		*output = pts[0].y;
-	} else if (i == tablesize) {
-		*output = pts[tablesize - 1].y;
-	} else {
-		/* result is between search_index and search_index-1 */
-		/* interpolate linearly */
-		*output = (((s32)((pts[i].y - pts[i - 1].y) *
-			(input - pts[i - 1].x)) /
-			(pts[i].x - pts[i - 1].x)) +
-			pts[i - 1].y);
-	}
-
-	return 0;
-}
-
-static void vadc_scale_calib(struct vadc_priv *vadc, u16 adc_code,
-			     const struct vadc_channel_prop *prop,
-			     s64 *scale_voltage)
-{
-	*scale_voltage = (adc_code -
-		vadc->graph[prop->calibration].gnd);
-	*scale_voltage *= vadc->graph[prop->calibration].dx;
-	*scale_voltage = div64_s64(*scale_voltage,
-		vadc->graph[prop->calibration].dy);
-	if (prop->calibration == VADC_CALIB_ABSOLUTE)
-		*scale_voltage +=
-		vadc->graph[prop->calibration].dx;
-
-	if (*scale_voltage < 0)
-		*scale_voltage = 0;
-}
-
-static int vadc_scale_volt(struct vadc_priv *vadc,
-			   const struct vadc_channel_prop *prop, u16 adc_code,
-			   int *result_uv)
-{
-	const struct vadc_prescale_ratio *prescale;
-	s64 voltage = 0, result = 0;
-
-	vadc_scale_calib(vadc, adc_code, prop, &voltage);
-
-	prescale = &vadc_prescale_ratios[prop->prescale];
-	voltage = voltage * prescale->den;
-	result = div64_s64(voltage, prescale->num);
-	*result_uv = result;
-
-	return 0;
-}
-
-static int vadc_scale_therm(struct vadc_priv *vadc,
-			    const struct vadc_channel_prop *prop, u16 adc_code,
-			    int *result_mdec)
-{
-	s64 voltage = 0, result = 0;
-
-	vadc_scale_calib(vadc, adc_code, prop, &voltage);
-
-	if (prop->calibration == VADC_CALIB_ABSOLUTE)
-		voltage = div64_s64(voltage, 1000);
-
-	vadc_map_voltage_temp(adcmap_100k_104ef_104fb,
-			      ARRAY_SIZE(adcmap_100k_104ef_104fb),
-			      voltage, &result);
-	result *= 1000;
-	*result_mdec = result;
-
-	return 0;
-}
-
-static int vadc_scale_die_temp(struct vadc_priv *vadc,
-			       const struct vadc_channel_prop *prop,
-			       u16 adc_code, int *result_mdec)
-{
-	const struct vadc_prescale_ratio *prescale;
-	s64 voltage = 0;
-	u64 temp; /* Temporary variable for do_div */
-
-	vadc_scale_calib(vadc, adc_code, prop, &voltage);
-
-	if (voltage > 0) {
-		prescale = &vadc_prescale_ratios[prop->prescale];
-		temp = voltage * prescale->den;
-		do_div(temp, prescale->num * 2);
-		voltage = temp;
-	} else {
-		voltage = 0;
-	}
-
-	voltage -= KELVINMIL_CELSIUSMIL;
-	*result_mdec = voltage;
-
-	return 0;
-}
-
-static int vadc_scale_chg_temp(struct vadc_priv *vadc,
-			       const struct vadc_channel_prop *prop,
-			       u16 adc_code, int *result_mdec)
-{
-	const struct vadc_prescale_ratio *prescale;
-	s64 voltage = 0, result = 0;
-
-	vadc_scale_calib(vadc, adc_code, prop, &voltage);
-
-	prescale = &vadc_prescale_ratios[prop->prescale];
-	voltage = voltage * prescale->den;
-	voltage = div64_s64(voltage, prescale->num);
-	voltage = ((PMI_CHG_SCALE_1) * (voltage * 2));
-	voltage = (voltage + PMI_CHG_SCALE_2);
-	result =  div64_s64(voltage, 1000000);
-	*result_mdec = result;
-
-	return 0;
-}
-
-static int vadc_decimation_from_dt(u32 value)
-{
-	if (!is_power_of_2(value) || value < VADC_DECIMATION_MIN ||
-	    value > VADC_DECIMATION_MAX)
-		return -EINVAL;
-
-	return __ffs64(value / VADC_DECIMATION_MIN);
-}
-
 static int vadc_prescaling_from_dt(u32 num, u32 den)
 {
 	unsigned int pre;
@@ -742,14 +449,6 @@ static int vadc_avg_samples_from_dt(u32 value)
 	return __ffs64(value);
 }
 
-static struct vadc_scale_fn scale_fn[] = {
-	[SCALE_DEFAULT] = {vadc_scale_volt},
-	[SCALE_THERM_100K_PULLUP] = {vadc_scale_therm},
-	[SCALE_PMIC_THERM] = {vadc_scale_die_temp},
-	[SCALE_XOTHERM] = {vadc_scale_therm},
-	[SCALE_PMI_CHG_TEMP] = {vadc_scale_chg_temp},
-};
-
 static int vadc_read_raw(struct iio_dev *indio_dev,
 			 struct iio_chan_spec const *chan, int *val, int *val2,
 			 long mask)
@@ -766,7 +465,13 @@ static int vadc_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			break;
 
-		scale_fn[prop->scale_fn].scale(vadc, prop, adc_code, val);
+		ret = qcom_vadc_scale(prop->scale_fn_type,
+				&vadc->graph[prop->calibration],
+				&vadc_prescale_ratios[prop->prescale],
+				(prop->calibration == VADC_CALIB_ABSOLUTE),
+				adc_code, val);
+		if (ret)
+			break;
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_RAW:
@@ -809,7 +514,7 @@ struct vadc_channels {
 	unsigned int prescale_index;
 	enum iio_chan_type type;
 	long info_mask;
-	unsigned int scale_fn;
+	enum vadc_scale_fn_type scale_fn_type;
 };
 
 #define VADC_CHAN(_dname, _type, _mask, _pre, _scale)			\
@@ -818,7 +523,7 @@ struct vadc_channels {
 		.prescale_index = _pre,					\
 		.type = _type,						\
 		.info_mask = _mask,					\
-		.scale_fn = _scale					\
+		.scale_fn_type = _scale					\
 	},								\
 
 #define VADC_NO_CHAN(_dname, _type, _mask, _pre)			\
@@ -976,7 +681,7 @@ static int vadc_get_dt_channel_data(struct device *dev,
 
 	ret = of_property_read_u32(node, "qcom,decimation", &value);
 	if (!ret) {
-		ret = vadc_decimation_from_dt(value);
+		ret = qcom_vadc_decimation_from_dt(value);
 		if (ret < 0) {
 			dev_err(dev, "%02x invalid decimation %d\n",
 				chan, value);
@@ -1068,7 +773,7 @@ static int vadc_get_dt_data(struct vadc_priv *vadc, struct device_node *node)
 			return ret;
 		}
 
-		prop.scale_fn = vadc_chans[prop.channel].scale_fn;
+		prop.scale_fn_type = vadc_chans[prop.channel].scale_fn_type;
 		vadc->chan_props[index] = prop;
 
 		vadc_chan = &vadc_chans[prop.channel];
diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
new file mode 100644
index 000000000000..39f8152f06f1
--- /dev/null
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -0,0 +1,228 @@
+#include <linux/bug.h>
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/math64.h>
+#include <linux/log2.h>
+#include <linux/err.h>
+
+#include "qcom-vadc-common.h"
+
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
+static int qcom_vadc_map_voltage_temp(const struct vadc_map_pt *pts,
+				      u32 tablesize, s32 input, s64 *output)
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
+static void qcom_vadc_scale_calib(const struct vadc_linear_graph *calib_graph,
+				  u16 adc_code,
+				  bool absolute,
+				  s64 *scale_voltage)
+{
+	*scale_voltage = (adc_code - calib_graph->gnd);
+	*scale_voltage *= calib_graph->dx;
+	*scale_voltage = div64_s64(*scale_voltage, calib_graph->dy);
+	if (absolute)
+		*scale_voltage += calib_graph->dx;
+
+	if (*scale_voltage < 0)
+		*scale_voltage = 0;
+}
+
+int qcom_vadc_scale_volt(const struct vadc_linear_graph *calib_graph,
+			 const struct vadc_prescale_ratio *prescale,
+			 bool absolute, u16 adc_code,
+			 int *result_uv)
+{
+	s64 voltage = 0, result = 0;
+
+	qcom_vadc_scale_calib(calib_graph, adc_code, absolute, &voltage);
+
+	voltage = voltage * prescale->den;
+	result = div64_s64(voltage, prescale->num);
+	*result_uv = result;
+
+	return 0;
+}
+
+int qcom_vadc_scale_therm(const struct vadc_linear_graph *calib_graph,
+			  const struct vadc_prescale_ratio *prescale,
+			  bool absolute, u16 adc_code,
+			  int *result_mdec)
+{
+	s64 voltage = 0, result = 0;
+	int ret;
+
+	qcom_vadc_scale_calib(calib_graph, adc_code, absolute, &voltage);
+
+	if (absolute)
+		voltage = div64_s64(voltage, 1000);
+
+	ret = qcom_vadc_map_voltage_temp(adcmap_100k_104ef_104fb,
+					 ARRAY_SIZE(adcmap_100k_104ef_104fb),
+					 voltage, &result);
+	if (ret)
+		return ret;
+
+	result *= 1000;
+	*result_mdec = result;
+
+	return 0;
+}
+
+int qcom_vadc_scale_die_temp(const struct vadc_linear_graph *calib_graph,
+			     const struct vadc_prescale_ratio *prescale,
+			     bool absolute,
+			     u16 adc_code, int *result_mdec)
+{
+	s64 voltage = 0;
+	u64 temp; /* Temporary variable for do_div */
+
+	qcom_vadc_scale_calib(calib_graph, adc_code, absolute, &voltage);
+
+	if (voltage > 0) {
+		temp = voltage * prescale->den;
+		do_div(temp, prescale->num * 2);
+		voltage = temp;
+	} else {
+		voltage = 0;
+	}
+
+	voltage -= KELVINMIL_CELSIUSMIL;
+	*result_mdec = voltage;
+
+	return 0;
+}
+
+int qcom_vadc_scale_chg_temp(const struct vadc_linear_graph *calib_graph,
+			     const struct vadc_prescale_ratio *prescale,
+			     bool absolute,
+			     u16 adc_code, int *result_mdec)
+{
+	s64 voltage = 0, result = 0;
+
+	qcom_vadc_scale_calib(calib_graph, adc_code, absolute, &voltage);
+
+	voltage = voltage * prescale->den;
+	voltage = div64_s64(voltage, prescale->num);
+	voltage = ((PMI_CHG_SCALE_1) * (voltage * 2));
+	voltage = (voltage + PMI_CHG_SCALE_2);
+	result =  div64_s64(voltage, 1000000);
+	*result_mdec = result;
+
+	return 0;
+}
+
+int qcom_vadc_scale(enum vadc_scale_fn_type scaletype,
+		    const struct vadc_linear_graph *calib_graph,
+		    const struct vadc_prescale_ratio *prescale,
+		    bool absolute,
+		    u16 adc_code, int *result)
+{
+	switch (scaletype) {
+	case SCALE_DEFAULT:
+		return qcom_vadc_scale_volt(calib_graph, prescale,
+					    absolute, adc_code,
+					    result);
+	case SCALE_THERM_100K_PULLUP:
+	case SCALE_XOTHERM:
+		return qcom_vadc_scale_therm(calib_graph, prescale,
+					     absolute, adc_code,
+					     result);
+	case SCALE_PMIC_THERM:
+		return qcom_vadc_scale_die_temp(calib_graph, prescale,
+						absolute, adc_code,
+						result);
+	case SCALE_PMI_CHG_TEMP:
+		return qcom_vadc_scale_chg_temp(calib_graph, prescale,
+						absolute, adc_code,
+						result);
+	default:
+		return -EINVAL;
+	}
+}
+
+int qcom_vadc_decimation_from_dt(u32 value)
+{
+	if (!is_power_of_2(value) || value < VADC_DECIMATION_MIN ||
+	    value > VADC_DECIMATION_MAX)
+		return -EINVAL;
+
+	return __ffs64(value / VADC_DECIMATION_MIN);
+}
diff --git a/drivers/iio/adc/qcom-vadc-common.h b/drivers/iio/adc/qcom-vadc-common.h
new file mode 100644
index 000000000000..aacf051f3c2a
--- /dev/null
+++ b/drivers/iio/adc/qcom-vadc-common.h
@@ -0,0 +1,103 @@
+/*
+ * Code shared between the different Qualcomm PMIC voltage ADCs
+ */
+
+#define VADC_CONV_TIME_MIN_US			2000
+#define VADC_CONV_TIME_MAX_US			2100
+
+/* Min ADC code represents 0V */
+#define VADC_MIN_ADC_CODE			0x6000
+/* Max ADC code represents full-scale range of 1.8V */
+#define VADC_MAX_ADC_CODE			0xa800
+
+#define VADC_ABSOLUTE_RANGE_UV			625000
+#define VADC_RATIOMETRIC_RANGE			1800
+
+#define VADC_DEF_PRESCALING			0 /* 1:1 */
+#define VADC_DEF_DECIMATION			0 /* 512 */
+#define VADC_DEF_HW_SETTLE_TIME			0 /* 0 us */
+#define VADC_DEF_AVG_SAMPLES			0 /* 1 sample */
+#define VADC_DEF_CALIB_TYPE			VADC_CALIB_ABSOLUTE
+
+#define VADC_DECIMATION_MIN			512
+#define VADC_DECIMATION_MAX			4096
+
+#define VADC_HW_SETTLE_DELAY_MAX		10000
+#define VADC_AVG_SAMPLES_MAX			512
+
+#define KELVINMIL_CELSIUSMIL			273150
+
+#define PMI_CHG_SCALE_1				-138890
+#define PMI_CHG_SCALE_2				391750000000LL
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
+/*
+ * VADC_CALIB_ABSOLUTE: uses the 625mV and 1.25V as reference channels.
+ * VADC_CALIB_RATIOMETRIC: uses the reference voltage (1.8V) and GND for
+ * calibration.
+ */
+enum vadc_calibration {
+	VADC_CALIB_ABSOLUTE = 0,
+	VADC_CALIB_RATIOMETRIC
+};
+
+/**
+ * struct vadc_linear_graph - Represent ADC characteristics.
+ * @dy: numerator slope to calculate the gain.
+ * @dx: denominator slope to calculate the gain.
+ * @gnd: A/D word of the ground reference used for the channel.
+ *
+ * Each ADC device has different offset and gain parameters which are
+ * computed to calibrate the device.
+ */
+struct vadc_linear_graph {
+	s32 dy;
+	s32 dx;
+	s32 gnd;
+};
+
+/**
+ * struct vadc_prescale_ratio - Represent scaling ratio for ADC input.
+ * @num: the inverse numerator of the gain applied to the input channel.
+ * @den: the inverse denominator of the gain applied to the input channel.
+ */
+struct vadc_prescale_ratio {
+	u32 num;
+	u32 den;
+};
+
+/**
+ * enum vadc_scale_fn_type - Scaling function to convert ADC code to
+ *				physical scaled units for the channel.
+ * SCALE_DEFAULT: Default scaling to convert raw adc code to voltage (uV).
+ * SCALE_THERM_100K_PULLUP: Returns temperature in millidegC.
+ *				 Uses a mapping table with 100K pullup.
+ * SCALE_PMIC_THERM: Returns result in milli degree's Centigrade.
+ * SCALE_XOTHERM: Returns XO thermistor voltage in millidegC.
+ * SCALE_PMI_CHG_TEMP: Conversion for PMI CHG temp
+ */
+enum vadc_scale_fn_type {
+	SCALE_DEFAULT = 0,
+	SCALE_THERM_100K_PULLUP,
+	SCALE_PMIC_THERM,
+	SCALE_XOTHERM,
+	SCALE_PMI_CHG_TEMP,
+};
+
+int qcom_vadc_scale(enum vadc_scale_fn_type scaletype,
+		    const struct vadc_linear_graph *calib_graph,
+		    const struct vadc_prescale_ratio *prescale,
+		    bool absolute,
+		    u16 adc_code, int *result_mdec);
+
+int qcom_vadc_decimation_from_dt(u32 value);
-- 
2.9.3

