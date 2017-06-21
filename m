Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:25208 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752462AbdFUOb1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jun 2017 10:31:27 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <benjamin.gaignard@linaro.org>,
        <jic23@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>
CC: <mark.rutland@arm.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: [PATCH v2 8/8] iio: counter: Add support for STM32 LPTimer
Date: Wed, 21 Jun 2017 16:30:15 +0200
Message-ID: <1498055415-31513-9-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1498055415-31513-1-git-send-email-fabrice.gasnier@st.com>
References: <1498055415-31513-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add support for STM32 Low-Power Timer, that can be used as counter
or quadrature encoder.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- s/Low Power/Low-Power
- update few comments
---
 .../ABI/testing/sysfs-bus-iio-lptimer-stm32        |  57 +++
 drivers/iio/counter/Kconfig                        |   9 +
 drivers/iio/counter/Makefile                       |   1 +
 drivers/iio/counter/stm32-lptimer-cnt.c            | 383 +++++++++++++++++++++
 4 files changed, 450 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32
 create mode 100644 drivers/iio/counter/stm32-lptimer-cnt.c

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32
new file mode 100644
index 0000000..ad2cc63
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32
@@ -0,0 +1,57 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_count0_preset
+KernelVersion:	4.13
+Contact:	fabrice.gasnier@st.com
+Description:
+		Reading returns the current preset value. Writing sets the
+		preset value. Encoder counts continuously from 0 to preset
+		value, depending on direction (up/down).
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_count_quadrature_mode_available
+KernelVersion:	4.13
+Contact:	fabrice.gasnier@st.com
+Description:
+		Reading returns the list possible quadrature modes.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_count0_quadrature_mode
+KernelVersion:	4.13
+Contact:	fabrice.gasnier@st.com
+Description:
+		Configure the device counter quadrature modes:
+		- non-quadrature:
+			Encoder IN1 input servers as the count input (up
+			direction).
+		- quadrature:
+			Encoder IN1 and IN2 inputs are mixed to get direction
+			and count.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_count_polarity_available
+KernelVersion:	4.13
+Contact:	fabrice.gasnier@st.com
+Description:
+		Reading returns the list possible active edges.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_count0_polarity
+KernelVersion:	4.13
+Contact:	fabrice.gasnier@st.com
+Description:
+		Configure the device encoder/counter active edge:
+		- rising-edge
+		- falling-edge
+		- both-edges
+
+		In non-quadrature mode, device counts up on active edge.
+		In quadrature mode, encoder counting scenarios are as follows:
+		----------------------------------------------------------------
+		| Active  | Level on |      IN1 signal    |     IN2 signal     |
+		| edge    | opposite |------------------------------------------
+		|         | signal   |  Rising  | Falling |  Rising  | Falling |
+		----------------------------------------------------------------
+		| Rising  | High ->  |   Down   |    -    |    Up    |    -    |
+		| edge    | Low  ->  |    Up    |    -    |   Down   |    -    |
+		----------------------------------------------------------------
+		| Falling | High ->  |    -     |    Up   |    -     |   Down  |
+		| edge    | Low  ->  |    -     |   Down  |    -     |    Up   |
+		----------------------------------------------------------------
+		| Both    | High ->  |   Down   |    Up   |    Up    |   Down  |
+		| edges   | Low  ->  |    Up    |   Down  |   Down   |    Up   |
+		----------------------------------------------------------------
diff --git a/drivers/iio/counter/Kconfig b/drivers/iio/counter/Kconfig
index b37e5fc..474e1ac 100644
--- a/drivers/iio/counter/Kconfig
+++ b/drivers/iio/counter/Kconfig
@@ -21,4 +21,13 @@ config 104_QUAD_8
 	  The base port addresses for the devices may be configured via the base
 	  array module parameter.
 
+config STM32_LPTIMER_CNT
+	tristate "STM32 LP Timer encoder counter driver"
+	depends on MFD_STM32_LPTIMER || COMPILE_TEST
+	help
+	  Select this option to enable STM32 Low-Power Timer quadrature encoder
+	  and counter driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called stm32-lptimer-cnt.
 endmenu
diff --git a/drivers/iio/counter/Makefile b/drivers/iio/counter/Makefile
index 007e884..1b9a896 100644
--- a/drivers/iio/counter/Makefile
+++ b/drivers/iio/counter/Makefile
@@ -5,3 +5,4 @@
 # When adding new entries keep the list in alphabetical order
 
 obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
+obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
diff --git a/drivers/iio/counter/stm32-lptimer-cnt.c b/drivers/iio/counter/stm32-lptimer-cnt.c
new file mode 100644
index 0000000..1c5909b
--- /dev/null
+++ b/drivers/iio/counter/stm32-lptimer-cnt.c
@@ -0,0 +1,383 @@
+/*
+ * STM32 Low-Power Timer Encoder and Counter driver
+ *
+ * Copyright (C) STMicroelectronics 2017
+ *
+ * Author: Fabrice Gasnier <fabrice.gasnier@st.com>
+ *
+ * Inspired by 104-quad-8 and stm32-timer-trigger drivers.
+ *
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#include <linux/bitfield.h>
+#include <linux/iio/iio.h>
+#include <linux/mfd/stm32-lptimer.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+struct stm32_lptim_cnt {
+	struct device *dev;
+	struct regmap *regmap;
+	struct clk *clk;
+	u32 preset;
+	u32 polarity;
+	u32 quadrature_mode;
+};
+
+static int stm32_lptim_is_enabled(struct stm32_lptim_cnt *priv)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_read(priv->regmap, STM32_LPTIM_CR, &val);
+	if (ret)
+		return ret;
+
+	return FIELD_GET(STM32_LPTIM_ENABLE, val);
+}
+
+static int stm32_lptim_set_enable_state(struct stm32_lptim_cnt *priv,
+					int enable)
+{
+	int ret;
+	u32 val;
+
+	val = FIELD_PREP(STM32_LPTIM_ENABLE, enable);
+	ret = regmap_write(priv->regmap, STM32_LPTIM_CR, val);
+	if (ret)
+		return ret;
+
+	if (!enable) {
+		clk_disable(priv->clk);
+		return 0;
+	}
+
+	/* LP timer must be enabled before writing CMP & ARR */
+	ret = regmap_write(priv->regmap, STM32_LPTIM_ARR, priv->preset);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, STM32_LPTIM_CMP, 0);
+	if (ret)
+		return ret;
+
+	/* ensure CMP & ARR registers are properly written */
+	ret = regmap_read_poll_timeout(priv->regmap, STM32_LPTIM_ISR, val,
+				       (val & STM32_LPTIM_CMPOK_ARROK),
+				       100, 1000);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, STM32_LPTIM_ICR,
+			   STM32_LPTIM_CMPOKCF_ARROKCF);
+	if (ret)
+		return ret;
+
+	ret = clk_enable(priv->clk);
+	if (ret) {
+		regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
+		return ret;
+	}
+
+	/* Start LP timer in continuous mode */
+	return regmap_update_bits(priv->regmap, STM32_LPTIM_CR,
+				  STM32_LPTIM_CNTSTRT, STM32_LPTIM_CNTSTRT);
+}
+
+static int stm32_lptim_setup(struct stm32_lptim_cnt *priv, int enable)
+{
+	u32 mask = STM32_LPTIM_ENC | STM32_LPTIM_COUNTMODE |
+		   STM32_LPTIM_CKPOL | STM32_LPTIM_PRESC;
+	u32 val;
+
+	/* Setup LP timer encoder/counter and polarity, without prescaler */
+	if (priv->quadrature_mode)
+		val = enable ? STM32_LPTIM_ENC : 0;
+	else
+		val = enable ? STM32_LPTIM_COUNTMODE : 0;
+	val |= FIELD_PREP(STM32_LPTIM_CKPOL, enable ? priv->polarity : 0);
+
+	return regmap_update_bits(priv->regmap, STM32_LPTIM_CFGR, mask, val);
+}
+
+static int stm32_lptim_write_raw(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 int val, int val2, long mask)
+{
+	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_ENABLE:
+		if (val < 0 || val > 1)
+			return -EINVAL;
+
+		/* Check nobody uses the timer, or already disabled/enabled */
+		ret = stm32_lptim_is_enabled(priv);
+		if ((ret < 0) || (!ret && !val))
+			return ret;
+		if (val && ret)
+			return -EBUSY;
+
+		ret = stm32_lptim_setup(priv, val);
+		if (ret)
+			return ret;
+		return stm32_lptim_set_enable_state(priv, val);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int stm32_lptim_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
+{
+	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
+	u32 dat;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_read(priv->regmap, STM32_LPTIM_CNT, &dat);
+		if (ret)
+			return ret;
+		*val = dat;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_ENABLE:
+		ret = stm32_lptim_is_enabled(priv);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		/* Non-quadrature mode: scale = 1 */
+		*val = 1;
+		*val2 = 0;
+		if (priv->quadrature_mode) {
+			/*
+			 * Quadrature encoder mode:
+			 * - both edges, quarter cycle, scale is 0.25
+			 * - either rising/falling edge scale is 0.5
+			 */
+			if (priv->polarity > 1)
+				*val2 = 2;
+			else
+				*val2 = 1;
+		}
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info stm32_lptim_cnt_iio_info = {
+	.read_raw = stm32_lptim_read_raw,
+	.write_raw = stm32_lptim_write_raw,
+	.driver_module = THIS_MODULE,
+};
+
+static const char *const stm32_lptim_quadrature_modes[] = {
+	"non-quadrature",
+	"quadrature",
+};
+
+static int stm32_lptim_get_quadrature_mode(struct iio_dev *indio_dev,
+					   const struct iio_chan_spec *chan)
+{
+	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
+
+	return priv->quadrature_mode;
+}
+
+static int stm32_lptim_set_quadrature_mode(struct iio_dev *indio_dev,
+					   const struct iio_chan_spec *chan,
+					   unsigned int type)
+{
+	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
+
+	if (stm32_lptim_is_enabled(priv))
+		return -EBUSY;
+
+	priv->quadrature_mode = type;
+
+	return 0;
+}
+
+static const struct iio_enum stm32_lptim_quadrature_mode_en = {
+	.items = stm32_lptim_quadrature_modes,
+	.num_items = ARRAY_SIZE(stm32_lptim_quadrature_modes),
+	.get = stm32_lptim_get_quadrature_mode,
+	.set = stm32_lptim_set_quadrature_mode,
+};
+
+static const char * const stm32_lptim_cnt_polarity[] = {
+	"rising-edge", "falling-edge", "both-edges",
+};
+
+static int stm32_lptim_cnt_get_polarity(struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan)
+{
+	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
+
+	return priv->polarity;
+}
+
+static int stm32_lptim_cnt_set_polarity(struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan,
+					unsigned int type)
+{
+	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
+
+	if (stm32_lptim_is_enabled(priv))
+		return -EBUSY;
+
+	priv->polarity = type;
+
+	return 0;
+}
+
+static const struct iio_enum stm32_lptim_cnt_polarity_en = {
+	.items = stm32_lptim_cnt_polarity,
+	.num_items = ARRAY_SIZE(stm32_lptim_cnt_polarity),
+	.get = stm32_lptim_cnt_get_polarity,
+	.set = stm32_lptim_cnt_set_polarity,
+};
+
+static ssize_t stm32_lptim_cnt_get_preset(struct iio_dev *indio_dev,
+					  uintptr_t private,
+					  const struct iio_chan_spec *chan,
+					  char *buf)
+{
+	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", priv->preset);
+}
+
+static ssize_t stm32_lptim_cnt_set_preset(struct iio_dev *indio_dev,
+					  uintptr_t private,
+					  const struct iio_chan_spec *chan,
+					  const char *buf, size_t len)
+{
+	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
+	int ret;
+
+	if (stm32_lptim_is_enabled(priv))
+		return -EBUSY;
+
+	ret = kstrtouint(buf, 0, &priv->preset);
+	if (ret)
+		return ret;
+
+	if (priv->preset > STM32_LPTIM_MAX_ARR)
+		return -EINVAL;
+
+	return len;
+}
+
+/* LP timer with encoder */
+static const struct iio_chan_spec_ext_info stm32_lptim_enc_ext_info[] = {
+	{
+		.name = "preset",
+		.shared = IIO_SEPARATE,
+		.read = stm32_lptim_cnt_get_preset,
+		.write = stm32_lptim_cnt_set_preset,
+	},
+	IIO_ENUM("polarity", IIO_SEPARATE, &stm32_lptim_cnt_polarity_en),
+	IIO_ENUM_AVAILABLE("polarity", &stm32_lptim_cnt_polarity_en),
+	IIO_ENUM("quadrature_mode", IIO_SEPARATE,
+		 &stm32_lptim_quadrature_mode_en),
+	IIO_ENUM_AVAILABLE("quadrature_mode", &stm32_lptim_quadrature_mode_en),
+	{}
+};
+
+static const struct iio_chan_spec stm32_lptim_enc_channels = {
+	.type = IIO_COUNT,
+	.channel = 0,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			      BIT(IIO_CHAN_INFO_ENABLE) |
+			      BIT(IIO_CHAN_INFO_SCALE),
+	.ext_info = stm32_lptim_enc_ext_info,
+	.indexed = 1,
+};
+
+/* LP timer without encoder (counter only) */
+static const struct iio_chan_spec_ext_info stm32_lptim_cnt_ext_info[] = {
+	{
+		.name = "preset",
+		.shared = IIO_SEPARATE,
+		.read = stm32_lptim_cnt_get_preset,
+		.write = stm32_lptim_cnt_set_preset,
+	},
+	IIO_ENUM("polarity", IIO_SEPARATE, &stm32_lptim_cnt_polarity_en),
+	IIO_ENUM_AVAILABLE("polarity", &stm32_lptim_cnt_polarity_en),
+	{}
+};
+
+static const struct iio_chan_spec stm32_lptim_cnt_channels = {
+	.type = IIO_COUNT,
+	.channel = 0,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			      BIT(IIO_CHAN_INFO_ENABLE) |
+			      BIT(IIO_CHAN_INFO_SCALE),
+	.ext_info = stm32_lptim_cnt_ext_info,
+	.indexed = 1,
+};
+
+static int stm32_lptim_cnt_probe(struct platform_device *pdev)
+{
+	struct stm32_lptimer *ddata = dev_get_drvdata(pdev->dev.parent);
+	struct stm32_lptim_cnt *priv;
+	struct iio_dev *indio_dev;
+
+	if (IS_ERR_OR_NULL(ddata))
+		return -EINVAL;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	priv = iio_priv(indio_dev);
+	priv->dev = &pdev->dev;
+	priv->regmap = ddata->regmap;
+	priv->clk = ddata->clk;
+	priv->preset = STM32_LPTIM_MAX_ARR;
+
+	indio_dev->name = dev_name(&pdev->dev);
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->dev.of_node = pdev->dev.of_node;
+	indio_dev->info = &stm32_lptim_cnt_iio_info;
+	if (ddata->has_encoder)
+		indio_dev->channels = &stm32_lptim_enc_channels;
+	else
+		indio_dev->channels = &stm32_lptim_cnt_channels;
+	indio_dev->num_channels = 1;
+
+	platform_set_drvdata(pdev, priv);
+
+	return devm_iio_device_register(&pdev->dev, indio_dev);
+}
+
+static const struct of_device_id stm32_lptim_cnt_of_match[] = {
+	{ .compatible = "st,stm32-lptimer-counter", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, stm32_lptim_cnt_of_match);
+
+static struct platform_driver stm32_lptim_cnt_driver = {
+	.probe = stm32_lptim_cnt_probe,
+	.driver = {
+		.name = "stm32-lptimer-counter",
+		.of_match_table = stm32_lptim_cnt_of_match,
+	},
+};
+module_platform_driver(stm32_lptim_cnt_driver);
+
+MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
+MODULE_ALIAS("platform:stm32-lptimer-counter");
+MODULE_DESCRIPTION("STMicroelectronics STM32 LPTIM counter driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

