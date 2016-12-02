Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wj0-f177.google.com ([209.85.210.177]:36674 "EHLO
        mail-wj0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759366AbcLBKRo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Dec 2016 05:17:44 -0500
Received: by mail-wj0-f177.google.com with SMTP id qp4so227984081wjc.3
        for <linux-iio@vger.kernel.org>; Fri, 02 Dec 2016 02:17:43 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        linux-pwm@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: fabrice.gasnier@st.com, gerald.baeza@st.com,
        arnaud.pouliquen@st.com, linus.walleij@linaro.org,
        linaro-kernel@lists.linaro.org, benjamin.gaignard@linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v3 2/7] MFD: add stm32 general purpose timer driver
Date: Fri,  2 Dec 2016 11:17:17 +0100
Message-Id: <1480673842-20804-3-git-send-email-benjamin.gaignard@st.com>
In-Reply-To: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
References: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This hardware block could at used at same time for PWM generation
and IIO timer for other IPs like DAC, ADC or other timers.
PWM and IIO timer configuration are mixed in the same registers
so we need a multi fonction driver to be able to share those registers.

version 2:
- rename driver "stm32-gptimer" to be align with SoC documentation
- only keep one compatible
- use of_platform_populate() instead of devm_mfd_add_devices()

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/mfd/Kconfig               | 10 ++++++
 drivers/mfd/Makefile              |  2 ++
 drivers/mfd/stm32-gptimer.c       | 73 +++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/stm32-gptimer.h | 62 +++++++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+)
 create mode 100644 drivers/mfd/stm32-gptimer.c
 create mode 100644 include/linux/mfd/stm32-gptimer.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index c6df644..e75abcb 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1607,6 +1607,15 @@ config MFD_STW481X
 	  in various ST Microelectronics and ST-Ericsson embedded
 	  Nomadik series.
 
+config MFD_STM32_GP_TIMER
+	tristate "Support for STM32 General Purpose Timer"
+	select MFD_CORE
+	select REGMAP
+	depends on ARCH_STM32
+	depends on OF
+	help
+	  Select this option to enable stm32 general purpose timer
+
 menu "Multimedia Capabilities Port drivers"
 	depends on ARCH_SA1100
 
@@ -1644,4 +1653,5 @@ config MFD_VEXPRESS_SYSREG
 	  on the ARM Ltd. Versatile Express board.
 
 endmenu
+
 endif
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 9834e66..86353b9 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -211,3 +211,5 @@ obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
 obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
 
 obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
+
+obj-$(CONFIG_MFD_STM32_GP_TIMER) 	+= stm32-gptimer.o
diff --git a/drivers/mfd/stm32-gptimer.c b/drivers/mfd/stm32-gptimer.c
new file mode 100644
index 0000000..54fb95c
--- /dev/null
+++ b/drivers/mfd/stm32-gptimer.c
@@ -0,0 +1,73 @@
+/*
+ * stm32-gptimer.c
+ *
+ * Copyright (C) STMicroelectronics 2016
+ * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/reset.h>
+
+#include <linux/mfd/stm32-gptimer.h>
+
+static const struct regmap_config stm32_gptimer_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = sizeof(u32),
+	.max_register = 0x400,
+	.fast_io = true,
+};
+
+static int stm32_gptimer_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct stm32_gptimer_dev *mfd;
+	struct resource *res;
+	void __iomem *mmio;
+
+	mfd = devm_kzalloc(dev, sizeof(*mfd), GFP_KERNEL);
+	if (!mfd)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENOMEM;
+
+	mmio = devm_ioremap_resource(dev, res);
+	if (IS_ERR(mmio))
+		return PTR_ERR(mmio);
+
+	mfd->regmap = devm_regmap_init_mmio_clk(dev, "clk_int", mmio,
+						&stm32_gptimer_regmap_cfg);
+	if (IS_ERR(mfd->regmap))
+		return PTR_ERR(mfd->regmap);
+
+	mfd->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(mfd->clk))
+		return PTR_ERR(mfd->clk);
+
+	platform_set_drvdata(pdev, mfd);
+
+	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
+}
+
+static const struct of_device_id stm32_gptimer_of_match[] = {
+	{
+		.compatible = "st,stm32-gptimer",
+	},
+};
+MODULE_DEVICE_TABLE(of, stm32_gptimer_of_match);
+
+static struct platform_driver stm32_gptimer_driver = {
+	.probe		= stm32_gptimer_probe,
+	.driver	= {
+		.name	= "stm32-gptimer",
+		.of_match_table = stm32_gptimer_of_match,
+	},
+};
+module_platform_driver(stm32_gptimer_driver);
+
+MODULE_DESCRIPTION("STMicroelectronics STM32 general purpose timer");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/stm32-gptimer.h b/include/linux/mfd/stm32-gptimer.h
new file mode 100644
index 0000000..f8c92de
--- /dev/null
+++ b/include/linux/mfd/stm32-gptimer.h
@@ -0,0 +1,62 @@
+/*
+ * stm32-gptimer.h
+ *
+ * Copyright (C) STMicroelectronics 2016
+ * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#ifndef _LINUX_STM32_GPTIMER_H_
+#define _LINUX_STM32_GPTIMER_H_
+
+#include <linux/clk.h>
+#include <linux/regmap.h>
+
+#define TIM_CR1		0x00	/* Control Register 1      */
+#define TIM_CR2		0x04	/* Control Register 2      */
+#define TIM_SMCR	0x08	/* Slave mode control reg  */
+#define TIM_DIER	0x0C	/* DMA/interrupt register  */
+#define TIM_SR		0x10	/* Status register	   */
+#define TIM_EGR		0x14	/* Event Generation Reg    */
+#define TIM_CCMR1	0x18	/* Capt/Comp 1 Mode Reg    */
+#define TIM_CCMR2	0x1C	/* Capt/Comp 2 Mode Reg    */
+#define TIM_CCER	0x20	/* Capt/Comp Enable Reg    */
+#define TIM_PSC		0x28	/* Prescaler               */
+#define TIM_ARR		0x2c	/* Auto-Reload Register    */
+#define TIM_CCR1	0x34	/* Capt/Comp Register 1    */
+#define TIM_CCR2	0x38	/* Capt/Comp Register 2    */
+#define TIM_CCR3	0x3C	/* Capt/Comp Register 3    */
+#define TIM_CCR4	0x40	/* Capt/Comp Register 4    */
+#define TIM_BDTR	0x44	/* Break and Dead-Time Reg */
+
+#define TIM_CR1_CEN	BIT(0)	/* Counter Enable	   */
+#define TIM_CR1_ARPE	BIT(7)	/* Auto-reload Preload Ena */
+#define TIM_CR2_MMS	(BIT(4) | BIT(5) | BIT(6)) /* Master mode selection */
+#define TIM_SMCR_SMS	(BIT(0) | BIT(1) | BIT(2)) /* Slave mode selection */
+#define TIM_SMCR_TS	(BIT(4) | BIT(5) | BIT(6)) /* Trigger selection */
+#define TIM_DIER_UIE	BIT(0)	/* Update interrupt	   */
+#define TIM_SR_UIF	BIT(0)	/* Update interrupt flag   */
+#define TIM_EGR_UG	BIT(0)	/* Update Generation       */
+#define TIM_CCMR_PE	BIT(3)	/* Channel Preload Enable  */
+#define TIM_CCMR_M1	(BIT(6) | BIT(5))  /* Channel PWM Mode 1 */
+#define TIM_CCER_CC1E	BIT(0)	/* Capt/Comp 1  out Ena    */
+#define TIM_CCER_CC1P	BIT(1)	/* Capt/Comp 1  Polarity   */
+#define TIM_CCER_CC1NE	BIT(2)	/* Capt/Comp 1N out Ena    */
+#define TIM_CCER_CC1NP	BIT(3)	/* Capt/Comp 1N Polarity   */
+#define TIM_CCER_CCXE	(BIT(0) | BIT(4) | BIT(8) | BIT(12))
+#define TIM_BDTR_BKE	BIT(12) /* Break input enable	   */
+#define TIM_BDTR_BKP	BIT(13) /* Break input polarity	   */
+#define TIM_BDTR_AOE	BIT(14)	/* Automatic Output Enable */
+#define TIM_BDTR_MOE	BIT(15)	/* Main Output Enable      */
+
+#define MAX_TIM_PSC		0xFFFF
+
+struct stm32_gptimer_dev {
+	/* Device data */
+	struct clk *clk;
+
+	/* Registers mapping */
+	struct regmap *regmap;
+};
+
+#endif
-- 
1.9.1

