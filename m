Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wj0-f169.google.com ([209.85.210.169]:36604 "EHLO
        mail-wj0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753162AbcLFNvR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Dec 2016 08:51:17 -0500
Received: by mail-wj0-f169.google.com with SMTP id tk12so26675450wjb.3
        for <linux-iio@vger.kernel.org>; Tue, 06 Dec 2016 05:51:15 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        "Ivan T . Ivanov" <iivanov.xz@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 2/3] iio: adc: break out common code from SPMI VADC
Date: Tue,  6 Dec 2016 14:51:09 +0100
Message-Id: <1481032269-27067-1-git-send-email-linus.walleij@linaro.org>
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
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/adc/Makefile           |  3 +-
 drivers/iio/adc/qcom-spmi-vadc.c   | 95 +++-----------------------------------
 drivers/iio/adc/qcom-vadc-common.c | 38 +++++++++++++++
 drivers/iio/adc/qcom-vadc-common.h | 69 +++++++++++++++++++++++++++
 4 files changed, 116 insertions(+), 89 deletions(-)
 create mode 100644 drivers/iio/adc/qcom-vadc-common.c
 create mode 100644 drivers/iio/adc/qcom-vadc-common.h

diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 7a40c04c311f..f9468d228b1e 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -38,7 +38,8 @@ obj-$(CONFIG_MXS_LRADC) += mxs-lradc.o
 obj-$(CONFIG_NAU7802) += nau7802.o
 obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
 obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
-obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
+qcom-vadc-y := qcom-vadc-common.o
+obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-vadc.o qcom-spmi-vadc.o
 obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
 obj-$(CONFIG_STX104) += stx104.o
 obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index c2babe50a0d8..74d21afa34a9 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -28,6 +28,8 @@
 
 #include <dt-bindings/iio/qcom,spmi-vadc.h>
 
+#include "qcom-vadc-common.h"
+
 /* VADC register and bit definitions */
 #define VADC_REVISION2				0x1
 #define VADC_REVISION2_SUPPORTED_VADC		1
@@ -75,69 +77,9 @@
 
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
-#define VADC_RATIOMETRIC_RANGE_UV		1800000
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
 #define VADC_CHAN_MIN			VADC_USBIN
 #define VADC_CHAN_MAX			VADC_LR_MUX3_BUF_PU1_PU2_XO_THERM
 
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
 /**
  * struct vadc_channel_prop - VADC channel property.
  * @channel: channel number, refer to the channel list.
@@ -471,33 +413,10 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
 static s32 vadc_calibrate(struct vadc_priv *vadc,
 			  const struct vadc_channel_prop *prop, u16 adc_code)
 {
-	const struct vadc_prescale_ratio *prescale;
-	s64 voltage;
-
-	voltage = adc_code - vadc->graph[prop->calibration].gnd;
-	voltage *= vadc->graph[prop->calibration].dx;
-	voltage = div64_s64(voltage, vadc->graph[prop->calibration].dy);
-
-	if (prop->calibration == VADC_CALIB_ABSOLUTE)
-		voltage += vadc->graph[prop->calibration].dx;
-
-	if (voltage < 0)
-		voltage = 0;
-
-	prescale = &vadc_prescale_ratios[prop->prescale];
-
-	voltage = voltage * prescale->den;
-
-	return div64_s64(voltage, prescale->num);
-}
-
-static int vadc_decimation_from_dt(u32 value)
-{
-	if (!is_power_of_2(value) || value < VADC_DECIMATION_MIN ||
-	    value > VADC_DECIMATION_MAX)
-		return -EINVAL;
-
-	return __ffs64(value / VADC_DECIMATION_MIN);
+	return qcom_vadc_calibrate(&vadc_prescale_ratios[prop->prescale],
+				   &vadc->graph[prop->calibration],
+				   (prop->calibration == VADC_CALIB_ABSOLUTE),
+				   adc_code);
 }
 
 static int vadc_prescaling_from_dt(u32 num, u32 den)
@@ -752,7 +671,7 @@ static int vadc_get_dt_channel_data(struct device *dev,
 
 	ret = of_property_read_u32(node, "qcom,decimation", &value);
 	if (!ret) {
-		ret = vadc_decimation_from_dt(value);
+		ret = qcom_vadc_decimation_from_dt(value);
 		if (ret < 0) {
 			dev_err(dev, "%02x invalid decimation %d\n",
 				chan, value);
diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
new file mode 100644
index 000000000000..f67fc5e2a702
--- /dev/null
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -0,0 +1,38 @@
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/math64.h>
+#include <linux/log2.h>
+#include <linux/err.h>
+
+#include "qcom-vadc-common.h"
+
+s32 qcom_vadc_calibrate(const struct vadc_prescale_ratio *prescale,
+			const struct vadc_linear_graph *graph,
+			bool absolute,
+			u16 adc_code)
+{
+	s64 voltage;
+
+	voltage = adc_code - graph->gnd;
+	voltage *= graph->dx;
+	voltage = div64_s64(voltage, graph->dy);
+
+	if (absolute)
+		voltage += graph->dx;
+
+	if (voltage < 0)
+		voltage = 0;
+
+	voltage = voltage * prescale->den;
+
+	return div64_s64(voltage, prescale->num);
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
index 000000000000..b41cb501eef8
--- /dev/null
+++ b/drivers/iio/adc/qcom-vadc-common.h
@@ -0,0 +1,69 @@
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
+#define VADC_RATIOMETRIC_RANGE_UV		1800000
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
+s32 qcom_vadc_calibrate(const struct vadc_prescale_ratio *prescale,
+			const struct vadc_linear_graph *graph,
+			bool absolute,
+			u16 adc_code);
+int qcom_vadc_decimation_from_dt(u32 value);
-- 
2.7.4

