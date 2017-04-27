Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37870 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939239AbdD0N3c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Apr 2017 09:29:32 -0400
Received: by mail-wm0-f41.google.com with SMTP id m123so18518311wma.0
        for <linux-iio@vger.kernel.org>; Thu, 27 Apr 2017 06:29:31 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: linux-kernel@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, vilhelm.gray@gmail.com, mwelling@ieee.org
Cc: fabrice.gasnier@st.com, linaro-kernel@lists.linaro.org,
        benjamin.gaignard@linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 2/2] iio: make stm32 trigger driver use INDIO_HARDWARE_TRIGGERED mode
Date: Thu, 27 Apr 2017 15:29:16 +0200
Message-Id: <1493299756-18157-3-git-send-email-benjamin.gaignard@st.com>
In-Reply-To: <1493299756-18157-1-git-send-email-benjamin.gaignard@st.com>
References: <1493299756-18157-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add validate function to be use to use the correct trigger.
Add an attribute to configure device mode like for quadrature and
enable modes

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../ABI/testing/sysfs-bus-iio-timer-stm32          | 15 ++++++
 drivers/iio/trigger/stm32-timer-trigger.c          | 61 ++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
index 230020e..cccdf57 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
+++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
@@ -90,3 +90,18 @@ Description:
 			Counting is enabled on rising edge of the connected
 			trigger, and remains enabled for the duration of this
 			selected mode.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_count_trigger_mode_available
+KernelVersion:	4.13
+Contact:	benjamin.gaignard@st.com
+Description:
+		Reading returns the list possible trigger modes.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_count0_trigger_mode
+KernelVersion:	4.13
+Contact:	benjamin.gaignard@st.com
+Description:
+		Configure the device counter trigger mode
+		counting direction is set by in_count0_count_direction
+		attribute and the counter is clocked by the connected trigger
+		rising edges.
diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 0f1a2cf..7c6e90e 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -347,12 +347,70 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int stm32_counter_validate_trigger(struct iio_dev *indio_dev,
+					  struct iio_trigger *trig)
+{
+	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
+	const char * const *cur = priv->valids;
+	unsigned int i = 0;
+
+	if (!is_stm32_timer_trigger(trig))
+		return -EINVAL;
+
+	while (cur && *cur) {
+		if (!strncmp(trig->name, *cur, strlen(trig->name))) {
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
 static const struct iio_info stm32_trigger_info = {
 	.driver_module = THIS_MODULE,
+	.validate_trigger = stm32_counter_validate_trigger,
 	.read_raw = stm32_counter_read_raw,
 	.write_raw = stm32_counter_write_raw
 };
 
+static const char *const stm32_trigger_modes[] = {
+	"trigger",
+};
+
+static int stm32_set_trigger_mode(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan,
+				  unsigned int mode)
+{
+	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
+
+	regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS, TIM_SMCR_SMS);
+
+	return 0;
+}
+
+static int stm32_get_trigger_mode(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan)
+{
+	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
+	u32 smcr;
+
+	regmap_read(priv->regmap, TIM_SMCR, &smcr);
+
+	return smcr == TIM_SMCR_SMS ? 0 : -EINVAL;
+}
+
+static const struct iio_enum stm32_trigger_mode_enum = {
+	.items = stm32_trigger_modes,
+	.num_items = ARRAY_SIZE(stm32_trigger_modes),
+	.set = stm32_set_trigger_mode,
+	.get = stm32_get_trigger_mode
+};
+
 static const char *const stm32_enable_modes[] = {
 	"always",
 	"gated",
@@ -536,6 +594,8 @@ static ssize_t stm32_count_set_preset(struct iio_dev *indio_dev,
 	IIO_ENUM_AVAILABLE("quadrature_mode", &stm32_quadrature_mode_enum),
 	IIO_ENUM("enable_mode", IIO_SEPARATE, &stm32_enable_mode_enum),
 	IIO_ENUM_AVAILABLE("enable_mode", &stm32_enable_mode_enum),
+	IIO_ENUM("trigger_mode", IIO_SEPARATE, &stm32_trigger_mode_enum),
+	IIO_ENUM_AVAILABLE("trigger_mode", &stm32_trigger_mode_enum),
 	{}
 };
 
@@ -560,6 +620,7 @@ static struct stm32_timer_trigger *stm32_setup_counter_device(struct device *dev
 	indio_dev->name = dev_name(dev);
 	indio_dev->dev.parent = dev;
 	indio_dev->info = &stm32_trigger_info;
+	indio_dev->modes = INDIO_HARDWARE_TRIGGERED;
 	indio_dev->num_channels = 1;
 	indio_dev->channels = &stm32_trigger_channel;
 	indio_dev->dev.of_node = dev->of_node;
-- 
1.9.1

