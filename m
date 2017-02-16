Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37068 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932195AbdBPOXS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Feb 2017 09:23:18 -0500
Received: by mail-wm0-f48.google.com with SMTP id v77so16381077wmv.0
        for <linux-iio@vger.kernel.org>; Thu, 16 Feb 2017 06:23:18 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: linux-kernel@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: fabrice.gasnier@st.com, linaro-kernel@lists.linaro.org,
        benjamin.gaignard@linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 2/2] iio: stm32 trigger: Implement parent trigger feature
Date: Thu, 16 Feb 2017 15:23:03 +0100
Message-Id: <1487254984-20122-3-git-send-email-benjamin.gaignard@st.com>
In-Reply-To: <1487254984-20122-1-git-send-email-benjamin.gaignard@st.com>
References: <1487254984-20122-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add validate_trigger function in iio_trigger_ops and
dev_attr_parent_trigger into trigger attribute group to be able
to accept triggers as parents.

Because the hardware have 8 different ways to use parent levels and
edges, this patch introduce "slave_mode" sysfs attribute for stm32
triggers. Modes usages are described in sysfs-bus-iio-timer-stm32

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>

version 2:
- use dev_attr_parent_trigger
- improve slave modes documentation
---
 .../ABI/testing/sysfs-bus-iio-timer-stm32          |  43 +++++++++
 drivers/iio/trigger/stm32-timer-trigger.c          | 105 +++++++++++++++++++++
 2 files changed, 148 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
index 6534a60..7d667f9 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
+++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
@@ -27,3 +27,46 @@ Description:
 		Reading returns the current sampling frequency.
 		Writing an value different of 0 set and start sampling.
 		Writing 0 stop sampling.
+
+What:		/sys/bus/iio/devices/triggerX/slave_mode_available
+KernelVersion:	4.12
+Contact:	benjamin.gaignard@st.com
+Description:
+		Reading returns the list possible slave modes which are:
+		- "disabled"  : Parent trigger levels or edges have do not impact on trigger.
+				Trigger is clocked by the internal clock.
+				This is the default mode.
+		- "encoder_1" : Trigger internal counter counts up/down on channel 2 edge depending on channel 1 level.
+		- "encoder_2" : Trigger internal counter counts up/down on channel 1 edge depending on channel 2 level.
+		- "encoder_3" : Trigger internal counter counts up/down on channels 1 & 2 edge
+				depending on channel 1 & 2 level.
+		- "reset"     : Rising edge on parent trigger reinitializes the trigger	and generates
+				an update of auto-reload, prescaler and	repetition counter registers.
+		- "gated"     : The trigger is enabled when the parent trigger input is high.
+				The trigger stops (but is not reset) as soon as the parent trigger becomes low.
+		- "trigger"   : The trigger starts at a rising edge of the parent trigger (but it is not reset).
+		- "external_clock": Rising edges of the parent trigger clock the trigger.
+
+		Encoder modes are used to automatically handle the counting direction of the internal counter.
+		Those modes are typically used for high-accuracy rotor position sensing in electrical motors
+		or for digital potentiometers. From the two outputs of a quadrature encoder sensor the timer
+		extracts a clock on each and every active edge and adjusts the counting direction depending on
+		the relative phase-shift between the two incomings signals. The timer counter thus directly
+		holds the angular position of the motor or the potentionmeter.
+
+		For "reset", "gated" and "trigger" modes the trigger will fire N+1 times when internal counter
+		will reach the value of auto-reload register. N is defined by the value of repetition counter.
+		Those modes could allow parent trigger to control when sampling frequency of the current trigger
+		start or stop.
+		Since PWM and trigger features are mixed in the same hardware block those 3 modes could be used
+		to synchronize PWMs start while PWM sysfs API is used to set period and duty cycle.
+
+		In "external clock" mode parent trigger can control the current trigger clock (and so the sampling
+		frequency) for example to correct jittering.
+
+What:		/sys/bus/iio/devices/triggerX/slave_mode
+KernelVersion:	4.12
+Contact:	benjamin.gaignard@st.com
+Description:
+		Reading returns the current slave mode.
+		Writing set the slave mode
diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 994b96d..a4f1061 100644
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
@@ -221,10 +239,66 @@ static IIO_DEVICE_ATTR(master_mode, 0660,
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
+	&dev_attr_parent_trigger.attr,
 	NULL,
 };
 
@@ -237,8 +311,38 @@ static IIO_DEVICE_ATTR(master_mode, 0660,
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
@@ -312,6 +416,7 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
 	priv->clk = ddata->clk;
 	priv->max_arr = ddata->max_arr;
 	priv->triggers = triggers_table[index];
+	priv->valids = valids_table[index];
 
 	ret = stm32_setup_iio_triggers(priv);
 	if (ret)
-- 
1.9.1

