Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wj0-f181.google.com ([209.85.210.181]:36304 "EHLO
        mail-wj0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762132AbdAEJ0C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Jan 2017 04:26:02 -0500
Received: by mail-wj0-f181.google.com with SMTP id ew7so16595310wjc.3
        for <linux-iio@vger.kernel.org>; Thu, 05 Jan 2017 01:26:01 -0800 (PST)
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
Subject: [PATCH v7 2/8] MFD: add STM32 Timers driver
Date: Thu,  5 Jan 2017 10:25:38 +0100
Message-Id: <1483608344-9012-3-git-send-email-benjamin.gaignard@st.com>
In-Reply-To: <1483608344-9012-1-git-send-email-benjamin.gaignard@st.com>
References: <1483608344-9012-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This hardware block could at used at same time for PWM generation
and IIO timers.
PWM and IIO timer configuration are mixed in the same registers
so we need a multi fonction driver to be able to share those registers.

version 7:
- rebase on v4.10-rc2

version 6:
- rename files to stm32-timers
- rename functions to stm32_timers_xxx

version 5:
- fix Lee comments about detect function
- add missing dependency on REGMAP_MMIO

version 4:
- add a function to detect Auto Reload Register (ARR) size
- rename the structure shared with other drivers

version 2:
- rename driver "stm32-gptimer" to be align with SoC documentation
- only keep one compatible
- use of_platform_populate() instead of devm_mfd_add_devices()

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../devicetree/bindings/mfd/stm32-timers.txt       |  2 +-
 drivers/mfd/Kconfig                                | 11 +++
 drivers/mfd/Makefile                               |  2 +
 drivers/mfd/stm32-timers.c                         | 80 ++++++++++++++++++++++
 include/linux/mfd/stm32-timers.h                   | 71 +++++++++++++++++++
 5 files changed, 165 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mfd/stm32-timers.c
 create mode 100644 include/linux/mfd/stm32-timers.h

diff --git a/Documentation/devicetree/bindings/mfd/stm32-timers.txt b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
index a73301d..897e7c2 100644
--- a/Documentation/devicetree/bindings/mfd/stm32-timers.txt
+++ b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
@@ -12,7 +12,7 @@ Required parameters:
 
 - reg:			Physical base address and length of the controller's
 			registers.
-- clock-names: 		Set to "int".
+- clock-names:		Set to "int".
 - clocks: 		Phandle to the clock used by the timer module.
 			For Clk properties, please refer to ../clock/clock-bindings.txt
 
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 4ce3b6f..d0c14b8 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1621,6 +1621,17 @@ config MFD_STW481X
 	  in various ST Microelectronics and ST-Ericsson embedded
 	  Nomadik series.
 
+config MFD_STM32_TIMERS
+	tristate "Support for STM32 Timers"
+	depends on (ARCH_STM32 && OF) || COMPILE_TEST
+	select MFD_CORE
+	select REGMAP
+	select REGMAP_MMIO
+	help
+	  Select this option to enable STM32 timers driver used
+	  for PWM and IIO Timer. This driver allow to share the
+	  registers between the others drivers.
+
 menu "Multimedia Capabilities Port drivers"
 	depends on ARCH_SA1100
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index dda4d4f..876ca86 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -212,3 +212,5 @@ obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
 
 obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
 obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
+
+obj-$(CONFIG_MFD_STM32_TIMERS) 	+= stm32-timers.o
diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
new file mode 100644
index 0000000..41bd901
--- /dev/null
+++ b/drivers/mfd/stm32-timers.c
@@ -0,0 +1,80 @@
+/*
+ * Copyright (C) STMicroelectronics 2016
+ *
+ * Author: Benjamin Gaignard <benjamin.gaignard@st.com>
+ *
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#include <linux/mfd/stm32-timers.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/reset.h>
+
+static const struct regmap_config stm32_timers_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = sizeof(u32),
+	.max_register = 0x400,
+};
+
+static void stm32_timers_get_arr_size(struct stm32_timers *ddata)
+{
+	/*
+	 * Only the available bits will be written so when readback
+	 * we get the maximum value of auto reload register
+	 */
+	regmap_write(ddata->regmap, TIM_ARR, ~0L);
+	regmap_read(ddata->regmap, TIM_ARR, &ddata->max_arr);
+	regmap_write(ddata->regmap, TIM_ARR, 0x0);
+}
+
+static int stm32_timers_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct stm32_timers *ddata;
+	struct resource *res;
+	void __iomem *mmio;
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
+						  &stm32_timers_regmap_cfg);
+	if (IS_ERR(ddata->regmap))
+		return PTR_ERR(ddata->regmap);
+
+	ddata->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(ddata->clk))
+		return PTR_ERR(ddata->clk);
+
+	stm32_timers_get_arr_size(ddata);
+
+	platform_set_drvdata(pdev, ddata);
+
+	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
+}
+
+static const struct of_device_id stm32_timers_of_match[] = {
+	{ .compatible = "st,stm32-timers", },
+	{ /* end node */ },
+};
+MODULE_DEVICE_TABLE(of, stm32_timers_of_match);
+
+static struct platform_driver stm32_timers_driver = {
+	.probe = stm32_timers_probe,
+	.driver	= {
+		.name = "stm32-timers",
+		.of_match_table = stm32_timers_of_match,
+	},
+};
+module_platform_driver(stm32_timers_driver);
+
+MODULE_DESCRIPTION("STMicroelectronics STM32 Timers");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
new file mode 100644
index 0000000..d030004
--- /dev/null
+++ b/include/linux/mfd/stm32-timers.h
@@ -0,0 +1,71 @@
+/*
+ * Copyright (C) STMicroelectronics 2016
+ *
+ * Author: Benjamin Gaignard <benjamin.gaignard@st.com>
+ *
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
+#define TIM_CCER_CC2E	BIT(4)	/* Capt/Comp 2  out Ena    */
+#define TIM_CCER_CC3E	BIT(8)	/* Capt/Comp 3  out Ena    */
+#define TIM_CCER_CC4E	BIT(12)	/* Capt/Comp 4  out Ena    */
+#define TIM_CCER_CCXE	(BIT(0) | BIT(4) | BIT(8) | BIT(12))
+#define TIM_BDTR_BKE	BIT(12) /* Break input enable	   */
+#define TIM_BDTR_BKP	BIT(13) /* Break input polarity	   */
+#define TIM_BDTR_AOE	BIT(14)	/* Automatic Output Enable */
+#define TIM_BDTR_MOE	BIT(15)	/* Main Output Enable      */
+#define TIM_BDTR_BKF	(BIT(16) | BIT(17) | BIT(18) | BIT(19))
+#define TIM_BDTR_BK2F	(BIT(20) | BIT(21) | BIT(22) | BIT(23))
+#define TIM_BDTR_BK2E	BIT(24) /* Break 2 input enable	   */
+#define TIM_BDTR_BK2P	BIT(25) /* Break 2 input polarity  */
+
+#define MAX_TIM_PSC		0xFFFF
+#define TIM_CR2_MMS_SHIFT	4
+#define TIM_SMCR_TS_SHIFT	4
+#define TIM_BDTR_BKF_MASK	0xF
+#define TIM_BDTR_BKF_SHIFT	16
+#define TIM_BDTR_BK2F_SHIFT	20
+
+struct stm32_timers {
+	struct clk *clk;
+	struct regmap *regmap;
+	u32 max_arr;
+};
+#endif
-- 
1.9.1

