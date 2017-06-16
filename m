Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36403 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752418AbdFPQAL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Jun 2017 12:00:11 -0400
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
Subject: [PATCH 2/8] mfd: Add STM32 LPTimer driver
Date: Fri, 16 Jun 2017 17:58:40 +0200
Message-ID: <1497628726-7563-3-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1497628726-7563-1-git-send-email-fabrice.gasnier@st.com>
References: <1497628726-7563-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

STM32 Low Power Timer hardware block can be used for:
- PWM generation
- IIO trigger (in sync with PWM)
- IIO quadrature encoder counter
PWM and IIO timer configuration are mixed in the same registers so
we need a multi fonction driver to be able to share those registers.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/mfd/Kconfig               |  15 ++++++
 drivers/mfd/Makefile              |   1 +
 drivers/mfd/stm32-lptimer.c       | 110 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/stm32-lptimer.h |  55 +++++++++++++++++++
 4 files changed, 181 insertions(+)
 create mode 100644 drivers/mfd/stm32-lptimer.c
 create mode 100644 include/linux/mfd/stm32-lptimer.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3eb5c93..32c1f3f 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1683,6 +1683,21 @@ config MFD_STW481X
 	  in various ST Microelectronics and ST-Ericsson embedded
 	  Nomadik series.
 
+config MFD_STM32_LPTIMER
+	tristate "Support for STM32 low power timer"
+	depends on (ARCH_STM32 && OF) || COMPILE_TEST
+	select MFD_CORE
+	select REGMAP
+	select REGMAP_MMIO
+	select RESET_CONTROLLER
+	help
+	  Select this option to enable STM32 low power timer driver
+	  used for PWM, IIO trigger, IIO encoder and counter. This driver
+	  allows to share the resources between these drivers.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called stm32-lptimer.
+
 config MFD_STM32_TIMERS
 	tristate "Support for STM32 Timers"
 	depends on (ARCH_STM32 && OF) || COMPILE_TEST
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index c16bf1e..a5308d8 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -219,5 +219,6 @@ obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
 obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
 obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
 
+obj-$(CONFIG_MFD_STM32_LPTIMER)	+= stm32-lptimer.o
 obj-$(CONFIG_MFD_STM32_TIMERS) 	+= stm32-timers.o
 obj-$(CONFIG_MFD_MXS_LRADC)     += mxs-lradc.o
diff --git a/drivers/mfd/stm32-lptimer.c b/drivers/mfd/stm32-lptimer.c
new file mode 100644
index 0000000..fcfefa3
--- /dev/null
+++ b/drivers/mfd/stm32-lptimer.c
@@ -0,0 +1,110 @@
+/*
+ * This file is part of STM32 low-power timer driver
+ *
+ * Copyright (C) STMicroelectronics 2017
+ *
+ * Author: Fabrice Gasnier <fabrice.gasnier@st.com>
+ * Inspired from: stm32-timers from Benjamin Gaignard
+ *
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#include <linux/mfd/stm32-lptimer.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/reset.h>
+
+static const struct regmap_config stm32_lptimer_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = sizeof(u32),
+	.max_register = 0x3fc,
+};
+
+static int stm32_lptimer_detect_encoder(struct stm32_lptimer *ddata)
+{
+	u32 val, enc = STM32_LPTIM_ENC;
+	int ret;
+
+	/*
+	 * Quadrature encoder mode bit can only be written and read back when
+	 * LP Timer supports is.
+	 */
+	ret = regmap_update_bits(ddata->regmap, STM32_LPTIM_CFGR, enc, enc);
+	if (ret)
+		return ret;
+	ret = regmap_read(ddata->regmap, STM32_LPTIM_CFGR, &val);
+	if (ret)
+		return ret;
+	ret = regmap_update_bits(ddata->regmap, STM32_LPTIM_CFGR, enc, 0);
+	if (ret)
+		return ret;
+	ddata->has_encoder = !!val;
+
+	return 0;
+}
+
+static int stm32_lptimer_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct stm32_lptimer *ddata;
+	struct reset_control *rst;
+	struct resource *res;
+	void __iomem *mmio;
+	int ret;
+
+	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mmio = devm_ioremap_resource(dev, res);
+	if (IS_ERR(mmio))
+		return PTR_ERR(mmio);
+
+	ddata->regmap = devm_regmap_init_mmio_clk(dev, "int", mmio,
+						  &stm32_lptimer_regmap_cfg);
+	if (IS_ERR(ddata->regmap))
+		return PTR_ERR(ddata->regmap);
+
+	ddata->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(ddata->clk))
+		return PTR_ERR(ddata->clk);
+
+	rst = devm_reset_control_get_optional(dev, NULL);
+	if (IS_ERR(rst))
+		return PTR_ERR(rst);
+
+	if (rst) {
+		reset_control_assert(rst);
+		reset_control_deassert(rst);
+	}
+
+	ret = stm32_lptimer_detect_encoder(ddata);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, ddata);
+
+	return devm_of_platform_populate(&pdev->dev);
+}
+
+static const struct of_device_id stm32_lptimer_of_match[] = {
+	{ .compatible = "st,stm32-lptimer", },
+	{ /* end node */ },
+};
+MODULE_DEVICE_TABLE(of, stm32_lptimer_of_match);
+
+static struct platform_driver stm32_lptimer_driver = {
+	.probe = stm32_lptimer_probe,
+	.driver = {
+		.name = "stm32-lptimer",
+		.of_match_table = stm32_lptimer_of_match,
+	},
+};
+module_platform_driver(stm32_lptimer_driver);
+
+MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics STM32 Low Power Timer");
+MODULE_ALIAS("platform:stm32-lptimer");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/stm32-lptimer.h b/include/linux/mfd/stm32-lptimer.h
new file mode 100644
index 0000000..72bc9be
--- /dev/null
+++ b/include/linux/mfd/stm32-lptimer.h
@@ -0,0 +1,55 @@
+/*
+ * This file is part of STM32 low-power timer driver
+ *
+ * Copyright (C) STMicroelectronics 2016
+ *
+ * Author: Fabrice Gasnier <fabrice.gasnier@st.com>
+ * Inspired from: stm32-timers
+ *
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#ifndef _LINUX_STM32_LPTIMER_H_
+#define _LINUX_STM32_LPTIMER_H_
+
+#include <linux/clk.h>
+#include <linux/regmap.h>
+
+#define STM32_LPTIM_ISR		0x00	/* Interrupt and Status Reg  */
+#define STM32_LPTIM_ICR		0x04	/* Interrupt Clear Reg       */
+#define STM32_LPTIM_IER		0x08	/* Interrupt Enable Reg      */
+#define STM32_LPTIM_CFGR	0x0C	/* Configuration Reg         */
+#define STM32_LPTIM_CR		0x10	/* Control Reg               */
+#define STM32_LPTIM_CMP		0x14	/* Compare Reg               */
+#define STM32_LPTIM_ARR		0x18	/* Autoreload Reg            */
+#define STM32_LPTIM_CNT		0x1C	/* Counter Reg               */
+
+/* STM32_LPTIM_ISR - bit fields */
+#define STM32_LPTIM_CMPOK_ARROK		GENMASK(4, 3)
+#define STM32_LPTIM_ARROK		BIT(4)
+#define STM32_LPTIM_CMPOK		BIT(3)
+
+/* STM32_LPTIM_ICR - bit fields */
+#define STM32_LPTIM_CMPOKCF_ARROKCF	GENMASK(4, 3)
+
+/* STM32_LPTIM_CR - bit fields */
+#define STM32_LPTIM_CNTSTRT	BIT(2)
+#define STM32_LPTIM_ENABLE	BIT(0)
+
+/* STM32_LPTIM_CFGR - bit fields */
+#define STM32_LPTIM_ENC		BIT(24)
+#define STM32_LPTIM_COUNTMODE	BIT(23)
+#define STM32_LPTIM_WAVPOL	BIT(21)
+#define STM32_LPTIM_PRESC	GENMASK(11, 9)
+#define STM32_LPTIM_CKPOL	GENMASK(2, 1)
+
+/* STM32_LPTIM_ARR */
+#define STM32_LPTIM_MAX_ARR	0xFFFF
+
+struct stm32_lptimer {
+	struct clk *clk;
+	struct regmap *regmap;
+	bool has_encoder;
+};
+
+#endif
-- 
1.9.1

