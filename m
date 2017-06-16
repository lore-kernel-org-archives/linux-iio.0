Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:20947 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752252AbdFPQAG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Jun 2017 12:00:06 -0400
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
Subject: [PATCH 4/8] pwm: Add STM32 LPTimer PWM driver
Date: Fri, 16 Jun 2017 17:58:42 +0200
Message-ID: <1497628726-7563-5-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1497628726-7563-1-git-send-email-fabrice.gasnier@st.com>
References: <1497628726-7563-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add support for single PWM channel on Low Power Timer, that can be
found on some STM32 platforms.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/pwm/Kconfig        |  10 +++
 drivers/pwm/Makefile       |   1 +
 drivers/pwm/pwm-stm32-lp.c | 216 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 227 insertions(+)
 create mode 100644 drivers/pwm/pwm-stm32-lp.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 313c107..6ac4477 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -417,6 +417,16 @@ config PWM_STM32
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-stm32.
 
+config PWM_STM32_LP
+	tristate "STMicroelectronics STM32 PWM LP"
+	depends on MFD_STM32_LPTIMER || COMPILE_TEST
+	help
+	  Generic PWM framework driver for STMicroelectronics STM32 SoCs
+	  with Low Power Timer (LPTIM).
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-stm32-lp.
+
 config PWM_STMPE
 	bool "STMPE expander PWM export"
 	depends on MFD_STMPE
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 93da1f7..a3a4bee 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
 obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
 obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
+obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
 obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
 obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
new file mode 100644
index 0000000..0de1256
--- /dev/null
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -0,0 +1,216 @@
+/*
+ * This file is part of STM32 low-power timer driver
+ *
+ * Copyright (C) STMicroelectronics 2017
+ *
+ * Author: Gerald Baeza <gerald.baeza@st.com>
+ *
+ * License terms: GNU General Public License (GPL), version 2
+ *
+ * Inspired by pwm-stm32.c from Gerald Baeza
+ */
+
+#include <linux/bitfield.h>
+#include <linux/mfd/stm32-lptimer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+struct stm32_pwm_lp {
+	struct pwm_chip chip;
+	struct clk *clk;
+	struct regmap *regmap;
+};
+
+static inline struct stm32_pwm_lp *to_stm32_pwm_lp(struct pwm_chip *chip)
+{
+	return container_of(chip, struct stm32_pwm_lp, chip);
+}
+
+static const u8 prescalers[] = {1, 2, 4, 8, 16, 32, 64, 128};
+
+static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			      struct pwm_state *state)
+{
+	struct stm32_pwm_lp *priv = to_stm32_pwm_lp(chip);
+	unsigned long long prd, div, dty;
+	struct pwm_state cstate;
+	u32 val, mask, cfgr, wavpol, presc = 0;
+	bool reenable = false;
+	int ret;
+
+	pwm_get_state(pwm, &cstate);
+
+	if (!state->enabled) {
+		if (cstate.enabled) {
+			/* Disable LP timer */
+			ret = regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
+			if (ret)
+				return ret;
+			clk_disable(priv->clk);
+		}
+		return 0;
+	}
+
+	/* Calculate the period and prescaler value */
+	div = (unsigned long long)clk_get_rate(priv->clk) * state->period;
+	do_div(div, NSEC_PER_SEC);
+	prd = div;
+	while (div > STM32_LPTIM_MAX_ARR) {
+		presc++;
+		if (presc >= ARRAY_SIZE(prescalers)) {
+			dev_err(priv->chip.dev, "max prescaler exceeded\n");
+			return -EINVAL;
+		}
+		div = prd;
+		do_div(div, prescalers[presc]);
+	}
+	prd = div;
+
+	/* Calculate the duty cycle */
+	dty = prd * state->duty_cycle;
+	do_div(dty, state->period);
+
+	wavpol = FIELD_PREP(STM32_LPTIM_WAVPOL, state->polarity);
+
+	if (!cstate.enabled) {
+		ret = clk_enable(priv->clk);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_read(priv->regmap, STM32_LPTIM_CFGR, &cfgr);
+	if (ret)
+		goto err;
+
+	if ((wavpol != FIELD_GET(STM32_LPTIM_WAVPOL, cfgr)) ||
+	    (presc != FIELD_GET(STM32_LPTIM_PRESC, cfgr))) {
+		val = FIELD_PREP(STM32_LPTIM_PRESC, presc) | wavpol;
+		mask = STM32_LPTIM_PRESC | STM32_LPTIM_WAVPOL;
+
+		/* Must disable LP timer to modify CFGR */
+		ret = regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
+		if (ret)
+			goto err;
+		reenable = true;
+		ret = regmap_update_bits(priv->regmap, STM32_LPTIM_CFGR, mask,
+					 val);
+		if (ret)
+			goto err;
+	}
+
+	if (!cstate.enabled || reenable) {
+		/* Must enable LP timer to modify CMP & ARR */
+		ret = regmap_write(priv->regmap, STM32_LPTIM_CR,
+				   STM32_LPTIM_ENABLE);
+		if (ret)
+			goto err;
+	}
+
+	ret = regmap_write(priv->regmap, STM32_LPTIM_ARR, prd - 1);
+	if (ret)
+		goto err;
+
+	ret = regmap_write(priv->regmap, STM32_LPTIM_CMP, prd - (1 + dty));
+	if (ret)
+		goto err;
+
+	/* ensure CMP & ARR registers are properly written */
+	ret = regmap_read_poll_timeout(priv->regmap, STM32_LPTIM_ISR, val,
+				       (val & STM32_LPTIM_CMPOK_ARROK),
+				       100, 1000);
+	if (ret) {
+		dev_err(priv->chip.dev, "ARR/CMP registers write issue\n");
+		goto err;
+	}
+	ret = regmap_write(priv->regmap, STM32_LPTIM_ICR,
+			   STM32_LPTIM_CMPOKCF_ARROKCF);
+	if (ret)
+		goto err;
+
+	if (!cstate.enabled || reenable) {
+		/* Start LP timer in continuous mode */
+		ret = regmap_update_bits(priv->regmap, STM32_LPTIM_CR,
+					 STM32_LPTIM_CNTSTRT,
+					 STM32_LPTIM_CNTSTRT);
+		if (ret) {
+			regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
+			goto err;
+		}
+	}
+
+	return 0;
+err:
+	if (!cstate.enabled)
+		clk_disable(priv->clk);
+
+	return ret;
+}
+
+static const struct pwm_ops stm32_pwm_lp_ops = {
+	.owner = THIS_MODULE,
+	.apply = stm32_pwm_lp_apply,
+};
+
+static int stm32_pwm_lp_probe(struct platform_device *pdev)
+{
+	struct stm32_lptimer *ddata = dev_get_drvdata(pdev->dev.parent);
+	struct stm32_pwm_lp *priv;
+	int ret;
+
+	if (IS_ERR_OR_NULL(ddata))
+		return -EINVAL;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regmap = ddata->regmap;
+	priv->clk = ddata->clk;
+	if (!priv->regmap || !priv->clk)
+		return -EINVAL;
+
+	priv->chip.base = -1;
+	priv->chip.dev = &pdev->dev;
+	priv->chip.ops = &stm32_pwm_lp_ops;
+	priv->chip.npwm = 1;
+
+	ret = pwmchip_add(&priv->chip);
+	if (ret < 0)
+		return ret;
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static int stm32_pwm_lp_remove(struct platform_device *pdev)
+{
+	struct stm32_pwm_lp *priv = platform_get_drvdata(pdev);
+
+	if (pwm_is_enabled(priv->chip.pwms))
+		pwm_disable(priv->chip.pwms);
+
+	return pwmchip_remove(&priv->chip);
+}
+
+static const struct of_device_id stm32_pwm_lp_of_match[] = {
+	{ .compatible = "st,stm32-pwm-lp", },
+	{ /* end node */ },
+};
+MODULE_DEVICE_TABLE(of, stm32_pwm_lp_of_match);
+
+static struct platform_driver stm32_pwm_lp_driver = {
+	.probe	= stm32_pwm_lp_probe,
+	.remove	= stm32_pwm_lp_remove,
+	.driver	= {
+		.name = "stm32-pwm-lp",
+		.of_match_table = of_match_ptr(stm32_pwm_lp_of_match),
+	},
+};
+module_platform_driver(stm32_pwm_lp_driver);
+
+MODULE_ALIAS("platform:stm32-pwm-lp");
+MODULE_DESCRIPTION("STMicroelectronics STM32 PWM LP driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

