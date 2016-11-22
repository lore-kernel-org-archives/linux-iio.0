Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34161 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755667AbcKVQOA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Nov 2016 11:14:00 -0500
Received: by mail-wm0-f47.google.com with SMTP id u144so5963722wmu.1
        for <linux-iio@vger.kernel.org>; Tue, 22 Nov 2016 08:13:59 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        linux-pwm@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: fabrice.gasnier@st.com, gerald.baeza@st.com,
        arnaud.pouliquen@st.com, linus.walleij@linaro.org,
        linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 4/7] add pwm driver for stm32 plaftorm
Date: Tue, 22 Nov 2016 17:13:24 +0100
Message-Id: <1479831207-32699-5-git-send-email-benjamin.gaignard@st.com>
In-Reply-To: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
References: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This driver add support for pwm driver on stm32 platform.
The SoC have multiple instances of the hardware IP and each
of them could have small differences: number of channels,
complementary output, counter register size...
To handle those variations each block have its own compatible
linked to internal table that describe them.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/pwm/Kconfig     |   8 ++
 drivers/pwm/Makefile    |   1 +
 drivers/pwm/pwm-stm32.c | 358 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 367 insertions(+)
 create mode 100644 drivers/pwm/pwm-stm32.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index bf01288..aeee045 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -388,6 +388,14 @@ config PWM_STI
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-sti.
 
+config PWM_STM32
+	bool "STMicroelectronics STM32 PWM"
+	depends on ARCH_STM32
+	depends on OF
+	select MFD_STM32_TIMER
+	help
+	  Generic PWM framework driver for STM32 SoCs.
+
 config PWM_STMPE
 	bool "STMPE expander PWM export"
 	depends on MFD_STMPE
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 1194c54..5aa9308 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
 obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
+obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
 obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
 obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
new file mode 100644
index 0000000..2d71ee7
--- /dev/null
+++ b/drivers/pwm/pwm-stm32.c
@@ -0,0 +1,358 @@
+/*
+ * Copyright (C) STMicroelectronics 2016
+ * Author:  Gerald Baeza <gerald.baeza@st.com>
+ * License terms:  GNU General Public License (GPL), version 2
+ *
+ * Inspired by timer-stm32.c from Maxime Coquelin
+ *             pwm-atmel.c from Bo Shen
+ */
+
+#include <linux/module.h>
+#include <linux/pwm.h>
+
+#include <linux/mfd/stm32-mfd-timer.h>
+
+#define DRIVER_NAME "stm32-pwm"
+
+#define CAP_COMPLEMENTARY	BIT(0)
+#define CAP_32BIT_COUNTER	BIT(1)
+#define CAP_BREAKINPUT		BIT(2)
+
+struct stm32_pwm_cfg {
+	int npwm;
+	int caps;
+};
+
+static struct stm32_pwm_cfg f4_pwm_cfg[] = {
+	/* for pwm 1 and 8 */
+	{
+		.npwm = 4,
+		.caps = CAP_COMPLEMENTARY | CAP_BREAKINPUT,
+	},
+	/* for pwm 2 and 5 */
+	{
+		.npwm = 4,
+		.caps = CAP_32BIT_COUNTER,
+	},
+	/* for pwm 3 and 4 */
+	{
+		.npwm = 4,
+		.caps = 0,
+	},
+	/* for pwm 9 and 12 */
+	{
+		.npwm = 2,
+		.caps = 0,
+	},
+	/* for pwm 10, 11, 13 and 14 */
+	{
+		.npwm = 1,
+		.caps = 0,
+	},
+};
+
+struct stm32_pwm_dev {
+	struct device *dev;
+	struct clk *clk;
+	struct regmap *regmap;
+	struct pwm_chip chip;
+	struct stm32_pwm_cfg *cfg;
+	bool have_breakinput;
+	u32 breakinput_polarity;
+};
+
+#define to_stm32_pwm_dev(x) container_of(chip, struct stm32_pwm_dev, chip)
+
+static u32 __active_channels(struct stm32_pwm_dev *pwm_dev)
+{
+	u32 ccer;
+
+	regmap_read(pwm_dev->regmap, TIM_CCER, &ccer);
+
+	return ccer & TIM_CCER_CCXE;
+}
+
+static int write_ccrx(struct stm32_pwm_dev *dev, struct pwm_device *pwm,
+		      u32 ccr)
+{
+	switch (pwm->hwpwm) {
+	case 0:
+		return regmap_write(dev->regmap, TIM_CCR1, ccr);
+	case 1:
+		return regmap_write(dev->regmap, TIM_CCR2, ccr);
+	case 2:
+		return regmap_write(dev->regmap, TIM_CCR3, ccr);
+	case 3:
+		return regmap_write(dev->regmap, TIM_CCR4, ccr);
+	}
+	return -EINVAL;
+}
+
+static int stm32_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			    int duty_ns, int period_ns)
+{
+	struct stm32_pwm_dev *dev = to_stm32_pwm_dev(chip);
+	unsigned long long prd, div, dty;
+	int prescaler = 0;
+	u32 max_arr = 0xFFFF, ccmr, mask, shift, bdtr;
+
+	if (dev->cfg->caps & CAP_32BIT_COUNTER)
+		max_arr = 0xFFFFFFFF;
+
+	/* Period and prescaler values depends of clock rate */
+	div = (unsigned long long)clk_get_rate(dev->clk) * period_ns;
+
+	do_div(div, NSEC_PER_SEC);
+	prd = div;
+
+	while (div > max_arr) {
+		prescaler++;
+		div = prd;
+		do_div(div, (prescaler + 1));
+	}
+	prd = div;
+
+	if (prescaler > MAX_TIM_PSC) {
+		dev_err(chip->dev, "prescaler exceeds the maximum value\n");
+		return -EINVAL;
+	}
+
+	/* All channels share the same prescaler and counter so
+	 * when two channels are active at the same we can't change them
+	 */
+	if (__active_channels(dev) & ~(1 << pwm->hwpwm * 4)) {
+		u32 psc, arr;
+
+		regmap_read(dev->regmap, TIM_PSC, &psc);
+		regmap_read(dev->regmap, TIM_ARR, &arr);
+
+		if ((psc != prescaler) || (arr != prd - 1))
+			return -EINVAL;
+	}
+
+	regmap_write(dev->regmap, TIM_PSC, prescaler);
+	regmap_write(dev->regmap, TIM_ARR, prd - 1);
+	regmap_update_bits(dev->regmap, TIM_CR1, TIM_CR1_ARPE, TIM_CR1_ARPE);
+
+	/* Calculate the duty cycles */
+	dty = prd * duty_ns;
+	do_div(dty, period_ns);
+
+	write_ccrx(dev, pwm, dty);
+
+	/* Configure output mode */
+	shift = (pwm->hwpwm & 0x1) * 8;
+	ccmr = (TIM_CCMR_PE | TIM_CCMR_M1) << shift;
+	mask = 0xFF << shift;
+
+	if (pwm->hwpwm & 0x2)
+		regmap_update_bits(dev->regmap, TIM_CCMR2, mask, ccmr);
+	else
+		regmap_update_bits(dev->regmap, TIM_CCMR1, mask, ccmr);
+
+	bdtr = TIM_BDTR_MOE | TIM_BDTR_AOE;
+	if (dev->have_breakinput) {
+		bdtr |= TIM_BDTR_BKE;
+		if (dev->breakinput_polarity)
+			bdtr |= TIM_BDTR_BKP;
+	}
+
+	regmap_update_bits(dev->regmap, TIM_BDTR,
+			   TIM_BDTR_MOE | TIM_BDTR_AOE |
+			   TIM_BDTR_BKP | TIM_BDTR_BKE,
+			   bdtr);
+
+	return 0;
+}
+
+static int stm32_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
+				  enum pwm_polarity polarity)
+{
+	u32 mask;
+	struct stm32_pwm_dev *dev = to_stm32_pwm_dev(chip);
+
+	mask = TIM_CCER_CC1P << (pwm->hwpwm * 4);
+	if (dev->cfg->caps & CAP_COMPLEMENTARY)
+		mask |= TIM_CCER_CC1NP << (pwm->hwpwm * 4);
+
+	regmap_update_bits(dev->regmap, TIM_CCER, mask,
+			   polarity == PWM_POLARITY_NORMAL ? 0 : mask);
+
+	return 0;
+}
+
+static int stm32_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	u32 mask;
+	struct stm32_pwm_dev *dev = to_stm32_pwm_dev(chip);
+
+	clk_enable(dev->clk);
+
+	/* Enable channel */
+	mask = TIM_CCER_CC1E << (pwm->hwpwm * 4);
+	if (dev->cfg->caps & CAP_COMPLEMENTARY)
+		mask |= TIM_CCER_CC1NE << (pwm->hwpwm * 4);
+
+	regmap_update_bits(dev->regmap, TIM_CCER, mask, mask);
+
+	/* Make sure that registers are updated */
+	regmap_update_bits(dev->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
+
+	/* Enable controller */
+	regmap_update_bits(dev->regmap, TIM_CR1, TIM_CR1_CEN, TIM_CR1_CEN);
+
+	return 0;
+}
+
+static void stm32_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	u32 mask;
+	struct stm32_pwm_dev *dev = to_stm32_pwm_dev(chip);
+
+	/* Disable channel */
+	mask = TIM_CCER_CC1E << (pwm->hwpwm * 4);
+	if (dev->cfg->caps & CAP_COMPLEMENTARY)
+		mask |= TIM_CCER_CC1NE << (pwm->hwpwm * 4);
+
+	regmap_update_bits(dev->regmap, TIM_CCER, mask, 0);
+
+	/* When all channels are disabled, we can disable the controller */
+	if (!__active_channels(dev))
+		regmap_update_bits(dev->regmap, TIM_CR1, TIM_CR1_CEN, 0);
+
+	clk_disable(dev->clk);
+}
+
+static const struct pwm_ops stm32pwm_ops = {
+	.config = stm32_pwm_config,
+	.set_polarity = stm32_pwm_set_polarity,
+	.enable = stm32_pwm_enable,
+	.disable = stm32_pwm_disable,
+};
+
+static const struct of_device_id stm32_pwm_of_match[] = {
+	{
+		.compatible = "st,stm32-pwm1",
+		.data = &f4_pwm_cfg[0],
+	},
+	{
+		.compatible = "st,stm32-pwm2",
+		.data = &f4_pwm_cfg[1],
+	},
+	{
+		.compatible = "st,stm32-pwm3",
+		.data = &f4_pwm_cfg[2],
+	},
+	{
+		.compatible = "st,stm32-pwm4",
+		.data = &f4_pwm_cfg[2],
+	},
+	{
+		.compatible = "st,stm32-pwm5",
+		.data = &f4_pwm_cfg[1],
+	},
+	{
+		.compatible = "st,stm32-pwm8",
+		.data = &f4_pwm_cfg[0],
+	},
+	{
+		.compatible = "st,stm32-pwm9",
+		.data = &f4_pwm_cfg[3],
+	},
+	{
+		.compatible = "st,stm32-pwm10",
+		.data = &f4_pwm_cfg[4],
+	},
+	{
+		.compatible = "st,stm32-pwm11",
+		.data = &f4_pwm_cfg[4],
+	},
+	{
+		.compatible = "st,stm32-pwm12",
+		.data = &f4_pwm_cfg[3],
+	},
+	{
+		.compatible = "st,stm32-pwm13",
+		.data = &f4_pwm_cfg[4],
+	},
+	{
+		.compatible = "st,stm32-pwm14",
+		.data = &f4_pwm_cfg[4],
+	},
+	{
+		/* end node */
+	},
+};
+MODULE_DEVICE_TABLE(of, stm32_pwm_of_match);
+
+static int stm32_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct stm32_mfd_timer_dev *mfd = pdev->dev.platform_data;
+	struct stm32_pwm_dev *pwm;
+	int ret;
+
+	pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+
+	pwm->regmap = mfd->regmap;
+	pwm->clk = mfd->clk;
+
+	if (!pwm->regmap || !pwm->clk)
+		return -EINVAL;
+
+	/* populate data structure depending on compatibility */
+	if (!of_match_node(stm32_pwm_of_match, np)->data)
+		return -EINVAL;
+
+	pwm->cfg =
+	(struct stm32_pwm_cfg *)of_match_node(stm32_pwm_of_match, np)->data;
+
+	if (pwm->cfg->caps & CAP_BREAKINPUT) {
+		if (!of_property_read_u32(np, "st,breakinput-polarity",
+					  &pwm->breakinput_polarity))
+			pwm->have_breakinput = true;
+	}
+
+	pwm->chip.base = -1;
+	pwm->chip.dev = dev;
+	pwm->chip.ops = &stm32pwm_ops;
+	pwm->chip.npwm = pwm->cfg->npwm;
+
+	ret = pwmchip_add(&pwm->chip);
+	if (ret < 0)
+		return ret;
+
+	platform_set_drvdata(pdev, pwm);
+
+	return 0;
+}
+
+static int stm32_pwm_remove(struct platform_device *pdev)
+{
+	struct stm32_pwm_dev *pwm = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < pwm->cfg->npwm; i++)
+		pwm_disable(&pwm->chip.pwms[i]);
+
+	pwmchip_remove(&pwm->chip);
+
+	return 0;
+}
+
+static struct platform_driver stm32_pwm_driver = {
+	.probe		= stm32_pwm_probe,
+	.remove		= stm32_pwm_remove,
+	.driver	= {
+		.name	= DRIVER_NAME,
+		.of_match_table = stm32_pwm_of_match,
+	},
+};
+module_platform_driver(stm32_pwm_driver);
+
+MODULE_ALIAS("platform:" DRIVER_NAME);
+MODULE_DESCRIPTION("STMicroelectronics STM32 PWM driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1

