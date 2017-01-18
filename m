Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35273 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753520AbdAROVy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jan 2017 09:21:54 -0500
Received: by mail-wm0-f53.google.com with SMTP id r126so247101530wmr.0
        for <linux-iio@vger.kernel.org>; Wed, 18 Jan 2017 06:21:23 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        linux-pwm@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: fabrice.gasnier@st.com, gerald.baeza@st.com,
        arnaud.pouliquen@st.com, linaro-kernel@lists.linaro.org,
        benjamin.gaignard@linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v8 6/8] IIO: add STM32 timer trigger driver
Date: Wed, 18 Jan 2017 15:20:49 +0100
Message-Id: <1484749251-14445-7-git-send-email-benjamin.gaignard@st.com>
In-Reply-To: <1484749251-14445-1-git-send-email-benjamin.gaignard@st.com>
References: <1484749251-14445-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Timers IPs can be used to generate triggers for other IPs like
DAC or ADC.
Each trigger may result of timer internals signals like counter enable,
reset or edge, this configuration could be done through "master_mode"
device attribute.

Since triggers could be used by DAC or ADC their names are defined
in include/ nux/iio/timer/stm32-timer-trigger.h and is_stm32_iio_timer_trigger
function could be used to check if the trigger is valid or not.

"trgo" trigger have a "sampling_frequency" attribute which allow to configure
timer sampling frequency.

version 8:
- change kernel version from 4.10 to 4.11 in ABI documentation

version 7:
- remove all iio_device related code
- move driver into trigger directory

version 5:
- simplify tables of triggers
- only create an IIO device when needed

version 4:
- get triggers configuration from "reg" in DT
- add tables of triggers
- sampling frequency is enable/disable when writing in trigger
  sampling_frequency attribute
- no more use of interruptions

version 3:
- change compatible to "st,stm32-timer-trigger"
- fix attributes access right
- use string instead of int for master_mode and slave_mode
- document device attributes in sysfs-bus-iio-timer-stm32

version 2:
- keep only one compatible
- use st,input-triggers-names and st,output-triggers-names
  to know which triggers are accepted and/or create by the device

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 .../ABI/testing/sysfs-bus-iio-timer-stm32          |  29 ++
 drivers/iio/trigger/Kconfig                        |   9 +
 drivers/iio/trigger/Makefile                       |   1 +
 drivers/iio/trigger/stm32-timer-trigger.c          | 342 +++++++++++++++++++++
 include/linux/iio/timer/stm32-timer-trigger.h      |  62 ++++
 5 files changed, 443 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
 create mode 100644 drivers/iio/trigger/stm32-timer-trigger.c
 create mode 100644 include/linux/iio/timer/stm32-timer-trigger.h

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
new file mode 100644
index 0000000..6534a60
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
@@ -0,0 +1,29 @@
+What:		/sys/bus/iio/devices/triggerX/master_mode_available
+KernelVersion:	4.11
+Contact:	benjamin.gaignard@st.com
+Description:
+		Reading returns the list possible master modes which are:
+		- "reset"     :	The UG bit from the TIMx_EGR register is used as trigger output (TRGO).
+		- "enable"    : The Counter Enable signal CNT_EN is used as trigger output.
+		- "update"    : The update event is selected as trigger output.
+				For instance a master timer can then be used as a prescaler for a slave timer.
+		- "compare_pulse" : The trigger output send a positive pulse when the CC1IF flag is to be set.
+		- "OC1REF"    : OC1REF signal is used as trigger output.
+		- "OC2REF"    : OC2REF signal is used as trigger output.
+		- "OC3REF"    : OC3REF signal is used as trigger output.
+		- "OC4REF"    : OC4REF signal is used as trigger output.
+
+What:		/sys/bus/iio/devices/triggerX/master_mode
+KernelVersion:	4.11
+Contact:	benjamin.gaignard@st.com
+Description:
+		Reading returns the current master modes.
+		Writing set the master mode
+
+What:		/sys/bus/iio/devices/triggerX/sampling_frequency
+KernelVersion:	4.11
+Contact:	benjamin.gaignard@st.com
+Description:
+		Reading returns the current sampling frequency.
+		Writing an value different of 0 set and start sampling.
+		Writing 0 stop sampling.
diff --git a/drivers/iio/trigger/Kconfig b/drivers/iio/trigger/Kconfig
index 809b2e7..e4d4e63 100644
--- a/drivers/iio/trigger/Kconfig
+++ b/drivers/iio/trigger/Kconfig
@@ -24,6 +24,15 @@ config IIO_INTERRUPT_TRIGGER
 	  To compile this driver as a module, choose M here: the
 	  module will be called iio-trig-interrupt.
 
+config IIO_STM32_TIMER_TRIGGER
+	tristate "STM32 Timer Trigger"
+	depends on (ARCH_STM32 && OF && MFD_STM32_TIMERS) || COMPILE_TEST
+	help
+	  Select this option to enable STM32 Timer Trigger
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called stm32-timer-trigger.
+
 config IIO_TIGHTLOOP_TRIGGER
 	tristate "A kthread based hammering loop trigger"
 	depends on IIO_SW_TRIGGER
diff --git a/drivers/iio/trigger/Makefile b/drivers/iio/trigger/Makefile
index aab4dc2..5c4ecd3 100644
--- a/drivers/iio/trigger/Makefile
+++ b/drivers/iio/trigger/Makefile
@@ -6,5 +6,6 @@
 
 obj-$(CONFIG_IIO_HRTIMER_TRIGGER) += iio-trig-hrtimer.o
 obj-$(CONFIG_IIO_INTERRUPT_TRIGGER) += iio-trig-interrupt.o
+obj-$(CONFIG_IIO_STM32_TIMER_TRIGGER) += stm32-timer-trigger.o
 obj-$(CONFIG_IIO_SYSFS_TRIGGER) += iio-trig-sysfs.o
 obj-$(CONFIG_IIO_TIGHTLOOP_TRIGGER) += iio-trig-loop.o
diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
new file mode 100644
index 0000000..994b96d
--- /dev/null
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -0,0 +1,342 @@
+/*
+ * Copyright (C) STMicroelectronics 2016
+ *
+ * Author: Benjamin Gaignard <benjamin.gaignard@st.com>
+ *
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/timer/stm32-timer-trigger.h>
+#include <linux/iio/trigger.h>
+#include <linux/mfd/stm32-timers.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#define MAX_TRIGGERS 6
+
+/* List the triggers created by each timer */
+static const void *triggers_table[][MAX_TRIGGERS] = {
+	{ TIM1_TRGO, TIM1_CH1, TIM1_CH2, TIM1_CH3, TIM1_CH4,},
+	{ TIM2_TRGO, TIM2_CH1, TIM2_CH2, TIM2_CH3, TIM2_CH4,},
+	{ TIM3_TRGO, TIM3_CH1, TIM3_CH2, TIM3_CH3, TIM3_CH4,},
+	{ TIM4_TRGO, TIM4_CH1, TIM4_CH2, TIM4_CH3, TIM4_CH4,},
+	{ TIM5_TRGO, TIM5_CH1, TIM5_CH2, TIM5_CH3, TIM5_CH4,},
+	{ TIM6_TRGO,},
+	{ TIM7_TRGO,},
+	{ TIM8_TRGO, TIM8_CH1, TIM8_CH2, TIM8_CH3, TIM8_CH4,},
+	{ TIM9_TRGO, TIM9_CH1, TIM9_CH2,},
+	{ }, /* timer 10 */
+	{ }, /* timer 11 */
+	{ TIM12_TRGO, TIM12_CH1, TIM12_CH2,},
+};
+
+struct stm32_timer_trigger {
+	struct device *dev;
+	struct regmap *regmap;
+	struct clk *clk;
+	u32 max_arr;
+	const void *triggers;
+};
+
+static int stm32_timer_start(struct stm32_timer_trigger *priv,
+			     unsigned int frequency)
+{
+	unsigned long long prd, div;
+	int prescaler = 0;
+	u32 ccer, cr1;
+
+	/* Period and prescaler values depends of clock rate */
+	div = (unsigned long long)clk_get_rate(priv->clk);
+
+	do_div(div, frequency);
+
+	prd = div;
+
+	/*
+	 * Increase prescaler value until we get a result that fit
+	 * with auto reload register maximum value.
+	 */
+	while (div > priv->max_arr) {
+		prescaler++;
+		div = prd;
+		do_div(div, (prescaler + 1));
+	}
+	prd = div;
+
+	if (prescaler > MAX_TIM_PSC) {
+		dev_err(priv->dev, "prescaler exceeds the maximum value\n");
+		return -EINVAL;
+	}
+
+	/* Check if nobody else use the timer */
+	regmap_read(priv->regmap, TIM_CCER, &ccer);
+	if (ccer & TIM_CCER_CCXE)
+		return -EBUSY;
+
+	regmap_read(priv->regmap, TIM_CR1, &cr1);
+	if (!(cr1 & TIM_CR1_CEN))
+		clk_enable(priv->clk);
+
+	regmap_write(priv->regmap, TIM_PSC, prescaler);
+	regmap_write(priv->regmap, TIM_ARR, prd - 1);
+	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, TIM_CR1_ARPE);
+
+	/* Force master mode to update mode */
+	regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS, 0x20);
+
+	/* Make sure that registers are updated */
+	regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
+
+	/* Enable controller */
+	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, TIM_CR1_CEN);
+
+	return 0;
+}
+
+static void stm32_timer_stop(struct stm32_timer_trigger *priv)
+{
+	u32 ccer, cr1;
+
+	regmap_read(priv->regmap, TIM_CCER, &ccer);
+	if (ccer & TIM_CCER_CCXE)
+		return;
+
+	regmap_read(priv->regmap, TIM_CR1, &cr1);
+	if (cr1 & TIM_CR1_CEN)
+		clk_disable(priv->clk);
+
+	/* Stop timer */
+	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
+	regmap_write(priv->regmap, TIM_PSC, 0);
+	regmap_write(priv->regmap, TIM_ARR, 0);
+
+	/* Make sure that registers are updated */
+	regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
+}
+
+static ssize_t stm32_tt_store_frequency(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t len)
+{
+	struct iio_trigger *trig = to_iio_trigger(dev);
+	struct stm32_timer_trigger *priv = iio_trigger_get_drvdata(trig);
+	unsigned int freq;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &freq);
+	if (ret)
+		return ret;
+
+	if (freq == 0) {
+		stm32_timer_stop(priv);
+	} else {
+		ret = stm32_timer_start(priv, freq);
+		if (ret)
+			return ret;
+	}
+
+	return len;
+}
+
+static ssize_t stm32_tt_read_frequency(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct iio_trigger *trig = to_iio_trigger(dev);
+	struct stm32_timer_trigger *priv = iio_trigger_get_drvdata(trig);
+	u32 psc, arr, cr1;
+	unsigned long long freq = 0;
+
+	regmap_read(priv->regmap, TIM_CR1, &cr1);
+	regmap_read(priv->regmap, TIM_PSC, &psc);
+	regmap_read(priv->regmap, TIM_ARR, &arr);
+
+	if (psc && arr && (cr1 & TIM_CR1_CEN)) {
+		freq = (unsigned long long)clk_get_rate(priv->clk);
+		do_div(freq, psc);
+		do_div(freq, arr);
+	}
+
+	return sprintf(buf, "%d\n", (unsigned int)freq);
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ(0660,
+			      stm32_tt_read_frequency,
+			      stm32_tt_store_frequency);
+
+static char *master_mode_table[] = {
+	"reset",
+	"enable",
+	"update",
+	"compare_pulse",
+	"OC1REF",
+	"OC2REF",
+	"OC3REF",
+	"OC4REF"
+};
+
+static ssize_t stm32_tt_show_master_mode(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
+	u32 cr2;
+
+	regmap_read(priv->regmap, TIM_CR2, &cr2);
+	cr2 = (cr2 & TIM_CR2_MMS) >> TIM_CR2_MMS_SHIFT;
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", master_mode_table[cr2]);
+}
+
+static ssize_t stm32_tt_store_master_mode(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(master_mode_table); i++) {
+		if (!strncmp(master_mode_table[i], buf,
+			     strlen(master_mode_table[i]))) {
+			regmap_update_bits(priv->regmap, TIM_CR2,
+					   TIM_CR2_MMS, i << TIM_CR2_MMS_SHIFT);
+			/* Make sure that registers are updated */
+			regmap_update_bits(priv->regmap, TIM_EGR,
+					   TIM_EGR_UG, TIM_EGR_UG);
+			return len;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static IIO_CONST_ATTR(master_mode_available,
+	"reset enable update compare_pulse OC1REF OC2REF OC3REF OC4REF");
+
+static IIO_DEVICE_ATTR(master_mode, 0660,
+		       stm32_tt_show_master_mode,
+		       stm32_tt_store_master_mode,
+		       0);
+
+static struct attribute *stm32_trigger_attrs[] = {
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_dev_attr_master_mode.dev_attr.attr,
+	&iio_const_attr_master_mode_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group stm32_trigger_attr_group = {
+	.attrs = stm32_trigger_attrs,
+};
+
+static const struct attribute_group *stm32_trigger_attr_groups[] = {
+	&stm32_trigger_attr_group,
+	NULL,
+};
+
+static const struct iio_trigger_ops timer_trigger_ops = {
+	.owner = THIS_MODULE,
+};
+
+static int stm32_setup_iio_triggers(struct stm32_timer_trigger *priv)
+{
+	int ret;
+	const char * const *cur = priv->triggers;
+
+	while (cur && *cur) {
+		struct iio_trigger *trig;
+
+		trig = devm_iio_trigger_alloc(priv->dev, "%s", *cur);
+		if  (!trig)
+			return -ENOMEM;
+
+		trig->dev.parent = priv->dev->parent;
+		trig->ops = &timer_trigger_ops;
+
+		/*
+		 * sampling frequency and master mode attributes
+		 * should only be available on trgo trigger which
+		 * is always the first in the list.
+		 */
+		if (cur == priv->triggers)
+			trig->dev.groups = stm32_trigger_attr_groups;
+
+		iio_trigger_set_drvdata(trig, priv);
+
+		ret = devm_iio_trigger_register(priv->dev, trig);
+		if (ret)
+			return ret;
+		cur++;
+	}
+
+	return 0;
+}
+
+/**
+ * is_stm32_timer_trigger
+ * @trig: trigger to be checked
+ *
+ * return true if the trigger is a valid stm32 iio timer trigger
+ * either return false
+ */
+bool is_stm32_timer_trigger(struct iio_trigger *trig)
+{
+	return (trig->ops == &timer_trigger_ops);
+}
+EXPORT_SYMBOL(is_stm32_timer_trigger);
+
+static int stm32_timer_trigger_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct stm32_timer_trigger *priv;
+	struct stm32_timers *ddata = dev_get_drvdata(pdev->dev.parent);
+	unsigned int index;
+	int ret;
+
+	if (of_property_read_u32(dev->of_node, "reg", &index))
+		return -EINVAL;
+
+	if (index >= ARRAY_SIZE(triggers_table))
+		return -EINVAL;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	priv->regmap = ddata->regmap;
+	priv->clk = ddata->clk;
+	priv->max_arr = ddata->max_arr;
+	priv->triggers = triggers_table[index];
+
+	ret = stm32_setup_iio_triggers(priv);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static const struct of_device_id stm32_trig_of_match[] = {
+	{ .compatible = "st,stm32-timer-trigger", },
+	{ /* end node */ },
+};
+MODULE_DEVICE_TABLE(of, stm32_trig_of_match);
+
+static struct platform_driver stm32_timer_trigger_driver = {
+	.probe = stm32_timer_trigger_probe,
+	.driver = {
+		.name = "stm32-timer-trigger",
+		.of_match_table = stm32_trig_of_match,
+	},
+};
+module_platform_driver(stm32_timer_trigger_driver);
+
+MODULE_ALIAS("platform: stm32-timer-trigger");
+MODULE_DESCRIPTION("STMicroelectronics STM32 Timer Trigger driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/iio/timer/stm32-timer-trigger.h b/include/linux/iio/timer/stm32-timer-trigger.h
new file mode 100644
index 0000000..55535ae
--- /dev/null
+++ b/include/linux/iio/timer/stm32-timer-trigger.h
@@ -0,0 +1,62 @@
+/*
+ * Copyright (C) STMicroelectronics 2016
+ *
+ * Author: Benjamin Gaignard <benjamin.gaignard@st.com>
+ *
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#ifndef _STM32_TIMER_TRIGGER_H_
+#define _STM32_TIMER_TRIGGER_H_
+
+#define TIM1_TRGO	"tim1_trgo"
+#define TIM1_CH1	"tim1_ch1"
+#define TIM1_CH2	"tim1_ch2"
+#define TIM1_CH3	"tim1_ch3"
+#define TIM1_CH4	"tim1_ch4"
+
+#define TIM2_TRGO	"tim2_trgo"
+#define TIM2_CH1	"tim2_ch1"
+#define TIM2_CH2	"tim2_ch2"
+#define TIM2_CH3	"tim2_ch3"
+#define TIM2_CH4	"tim2_ch4"
+
+#define TIM3_TRGO	"tim3_trgo"
+#define TIM3_CH1	"tim3_ch1"
+#define TIM3_CH2	"tim3_ch2"
+#define TIM3_CH3	"tim3_ch3"
+#define TIM3_CH4	"tim3_ch4"
+
+#define TIM4_TRGO	"tim4_trgo"
+#define TIM4_CH1	"tim4_ch1"
+#define TIM4_CH2	"tim4_ch2"
+#define TIM4_CH3	"tim4_ch3"
+#define TIM4_CH4	"tim4_ch4"
+
+#define TIM5_TRGO	"tim5_trgo"
+#define TIM5_CH1	"tim5_ch1"
+#define TIM5_CH2	"tim5_ch2"
+#define TIM5_CH3	"tim5_ch3"
+#define TIM5_CH4	"tim5_ch4"
+
+#define TIM6_TRGO	"tim6_trgo"
+
+#define TIM7_TRGO	"tim7_trgo"
+
+#define TIM8_TRGO	"tim8_trgo"
+#define TIM8_CH1	"tim8_ch1"
+#define TIM8_CH2	"tim8_ch2"
+#define TIM8_CH3	"tim8_ch3"
+#define TIM8_CH4	"tim8_ch4"
+
+#define TIM9_TRGO	"tim9_trgo"
+#define TIM9_CH1	"tim9_ch1"
+#define TIM9_CH2	"tim9_ch2"
+
+#define TIM12_TRGO	"tim12_trgo"
+#define TIM12_CH1	"tim12_ch1"
+#define TIM12_CH2	"tim12_ch2"
+
+bool is_stm32_timer_trigger(struct iio_trigger *trig);
+
+#endif
-- 
1.9.1

