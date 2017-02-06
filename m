Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:36197 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752590AbdBFOWJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Feb 2017 09:22:09 -0500
Received: by mail-wr0-f179.google.com with SMTP id k90so23210546wrc.3
        for <linux-iio@vger.kernel.org>; Mon, 06 Feb 2017 06:22:09 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: linux-kernel@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: fabrice.gasnier@st.com, linaro-kernel@lists.linaro.org,
        benjamin.gaignard@linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v1 2/2] iio: stm32 trigger: Implement validate_trigger function
Date: Mon,  6 Feb 2017 15:21:52 +0100
Message-Id: <1486390912-24362-3-git-send-email-benjamin.gaignard@st.com>
In-Reply-To: <1486390912-24362-1-git-send-email-benjamin.gaignard@st.com>
References: <1486390912-24362-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add validate_trigger function in iio_trigger_ops to be able to accept
triggers as parents.

Because the hardware have 8 different ways to use parent levels and
edges, this patch introduce "slave_mode" sysfs attribute for stm32
triggers.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../ABI/testing/sysfs-bus-iio-timer-stm32          |  26 ++++++
 drivers/iio/trigger/stm32-timer-trigger.c          | 104 +++++++++++++++++++++
 2 files changed, 130 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
index 6534a60..ce974f7 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
+++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
@@ -27,3 +27,29 @@ Description:
 		Reading returns the current sampling frequency.
 		Writing an value different of 0 set and start sampling.
 		Writing 0 stop sampling.
+
+What:		/sys/bus/iio/devices/iio:deviceX/slave_mode_available
+KernelVersion:	4.12
+Contact:	benjamin.gaignard@st.com
+Description:
+		Reading returns the list possible slave modes which are:
+		- "disabled"  : The prescaler is clocked directly by the internal clock.
+		- "encoder_1" : Counter counts up/down on TI2FP1 edge depending on TI1FP2 level.
+		- "encoder_2" : Counter counts up/down on TI1FP2 edge depending on TI2FP1 level.
+		- "encoder_3" : Counter counts up/down on both TI1FP1 and TI2FP2 edges depending
+				on the level of the other input.
+		- "reset"     : Rising edge of the selected trigger input reinitializes the counter
+				and generates an update of the registers.
+		- "gated"     : The counter clock is enabled when the trigger input is high.
+				The counter stops (but is not reset) as soon as the trigger becomes low.
+				Both start and stop of the counter are controlled.
+		- "trigger"   : The counter starts at a rising edge of the trigger TRGI (but it is not
+				reset). Only the start of the counter is controlled.
+		- "external_clock": Rising edges of the selected trigger (TRGI) clock the counter.
+
+What:		/sys/bus/iio/devices/iio:deviceX/slave_mode
+KernelVersion:	4.12
+Contact:	benjamin.gaignard@st.com
+Description:
+		Reading returns the current slave mode.
+		Writing set the slave mode
diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 994b96d..d1ffe49 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 
 #define MAX_TRIGGERS 6
+#define MAX_VALIDS 5
 
 /* List the triggers created by each timer */
 static const void *triggers_table[][MAX_TRIGGERS] = {
@@ -32,12 +33,29 @@
 	{ TIM12_TRGO, TIM12_CH1, TIM12_CH2,},
 };
 
+/* List the triggers accepted by each timer */
+static const void *valids_table[][MAX_VALIDS] = {
+	{ TIM5_TRGO, TIM2_TRGO, TIM4_TRGO, TIM3_TRGO,},
+	{ TIM1_TRGO, TIM8_TRGO, TIM3_TRGO, TIM4_TRGO,},
+	{ TIM1_TRGO, TIM8_TRGO, TIM5_TRGO, TIM4_TRGO,},
+	{ TIM1_TRGO, TIM2_TRGO, TIM3_TRGO, TIM8_TRGO,},
+	{ TIM2_TRGO, TIM3_TRGO, TIM4_TRGO, TIM8_TRGO,},
+	{ }, /* timer 6 */
+	{ }, /* timer 7 */
+	{ TIM1_TRGO, TIM2_TRGO, TIM4_TRGO, TIM5_TRGO,},
+	{ TIM2_TRGO, TIM3_TRGO,},
+	{ }, /* timer 10 */
+	{ }, /* timer 11 */
+	{ TIM4_TRGO, TIM5_TRGO,},
+};
+
 struct stm32_timer_trigger {
 	struct device *dev;
 	struct regmap *regmap;
 	struct clk *clk;
 	u32 max_arr;
 	const void *triggers;
+	const void *valids;
 };
 
 static int stm32_timer_start(struct stm32_timer_trigger *priv,
@@ -221,10 +239,65 @@ static IIO_DEVICE_ATTR(master_mode, 0660,
 		       stm32_tt_store_master_mode,
 		       0);
 
+static char *slave_mode_table[] = {
+	"disabled",
+	"encoder_1",
+	"encoder_2",
+	"encoder_3",
+	"reset",
+	"gated",
+	"trigger",
+	"external_clock",
+};
+
+static ssize_t stm32_tt_show_slave_mode(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
+	u32 smcr;
+
+	regmap_read(priv->regmap, TIM_SMCR, &smcr);
+	smcr &= TIM_SMCR_SMS;
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", slave_mode_table[smcr]);
+}
+
+static ssize_t stm32_tt_store_slave_mode(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(slave_mode_table); i++) {
+		if (!strncmp(slave_mode_table[i], buf,
+			     strlen(slave_mode_table[i]))) {
+			regmap_update_bits(priv->regmap,
+					   TIM_SMCR, TIM_SMCR_SMS, i);
+			return len;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static IIO_CONST_ATTR(slave_mode_available,
+"disabled encoder_1 encoder_2 encoder_3 reset gated trigger external_clock");
+
+static IIO_DEVICE_ATTR(slave_mode, 0660,
+		       stm32_tt_show_slave_mode,
+		       stm32_tt_store_slave_mode,
+		       0);
+
 static struct attribute *stm32_trigger_attrs[] = {
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_dev_attr_master_mode.dev_attr.attr,
 	&iio_const_attr_master_mode_available.dev_attr.attr,
+	&iio_dev_attr_slave_mode.dev_attr.attr,
+	&iio_const_attr_slave_mode_available.dev_attr.attr,
 	NULL,
 };
 
@@ -237,8 +310,38 @@ static IIO_DEVICE_ATTR(master_mode, 0660,
 	NULL,
 };
 
+static int stm32_validate_trigger(struct iio_trigger *trig,
+				  struct iio_trigger *parent)
+{
+	struct stm32_timer_trigger *priv = iio_trigger_get_drvdata(trig);
+	const char * const *cur = priv->valids;
+	unsigned int i = 0;
+
+	if (!parent) {
+		regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_TS, 0);
+		return 0;
+	}
+
+	if (!is_stm32_timer_trigger(parent))
+		return -EINVAL;
+
+	while (cur && *cur) {
+		if (!strncmp(parent->name, *cur, strlen(parent->name))) {
+			regmap_update_bits(priv->regmap,
+					   TIM_SMCR, TIM_SMCR_TS,
+					   i << TIM_SMCR_TS_SHIFT);
+			return 0;
+		}
+		cur++;
+		i++;
+	}
+
+	return -EINVAL;
+}
+
 static const struct iio_trigger_ops timer_trigger_ops = {
 	.owner = THIS_MODULE,
+	.validate_trigger = stm32_validate_trigger,
 };
 
 static int stm32_setup_iio_triggers(struct stm32_timer_trigger *priv)
@@ -312,6 +415,7 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
 	priv->clk = ddata->clk;
 	priv->max_arr = ddata->max_arr;
 	priv->triggers = triggers_table[index];
+	priv->valids = valids_table[index];
 
 	ret = stm32_setup_iio_triggers(priv);
 	if (ret)
-- 
1.9.1

