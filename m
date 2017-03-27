Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35436 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753012AbdC0NzH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Mar 2017 09:55:07 -0400
Date: Mon, 27 Mar 2017 09:55:03 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: linux-kernel@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mwelling@ieee.org, fabrice.gasnier@st.com,
        linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v3 2/2] iio: stm32 trigger: Add counter enable modes
Message-ID: <20170327135502.GB13775@sophia>
References: <1490607804-24889-1-git-send-email-benjamin.gaignard@st.com>
 <1490607804-24889-3-git-send-email-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1490607804-24889-3-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Mar 27, 2017 at 11:43:24AM +0200, Benjamin Gaignard wrote:
>Device counting could be controlled by the level or the edges of
>a trigger.
>in_count0_enable_mode attibute allow to set the control mode.
>
>Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>

This patch is pretty straight-forward and all right with me. A minor
nitpick inline regarding documentation.

Reviewed-by: William Breathitt Gray <vilhelm.gray@gmail.com>

>---
> .../ABI/testing/sysfs-bus-iio-timer-stm32          | 23 +++++++
> drivers/iio/trigger/stm32-timer-trigger.c          | 70 ++++++++++++++++++++++
> 2 files changed, 93 insertions(+)
>
>diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>index bf795ad..c0a1edc 100644
>--- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>+++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>@@ -59,3 +59,26 @@ Description:
> 		quadrature:
> 			Encoder A and B inputs are mixed to get direction
> 			and count with a scale of 0.25.
>+
>+What:		/sys/bus/iio/devices/iio:deviceX/in_count_enable_mode_available
>+KernelVersion:	4.12
>+Contact:	benjamin.gaignard@st.com
>+Description:
>+		Reading returns the list possible enable modes.
>+
>+What:		/sys/bus/iio/devices/iio:deviceX/in_count0_enable_mode
>+KernelVersion:	4.12
>+Contact:	benjamin.gaignard@st.com
>+Description:
>+		Configure the device counter enable modes, in all case
>+		counting direction is set by in_count0_count_direction
>+		attribute and the counter is clocked by the internal clock.
>+		always:
>+			Counter is always ON.
>+
>+		gated:
>+			Counting is enabled when connected trigger signal
>+			level is high else counting is disabled.
>+
>+		triggered:
>+			Counting start on rising edge of the connected trigger.

When I read the description of the "triggered" mode, I get the
impression that counting is restarted every time there is a rising edge
from the connected trigger signal. However, from our previous
discussions I believe this mode is simply a latched enable.

Perhaps it may be beneficial for clarity to rework the description to
say something along the lines of: "Counting is enabled on rising edge of
the connected trigger, and remains enabled for the duration of this
selected mode."

William Breathitt Gray

>diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
>index 7db904c..0f1a2cf 100644
>--- a/drivers/iio/trigger/stm32-timer-trigger.c
>+++ b/drivers/iio/trigger/stm32-timer-trigger.c
>@@ -353,6 +353,74 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
> 	.write_raw = stm32_counter_write_raw
> };
> 
>+static const char *const stm32_enable_modes[] = {
>+	"always",
>+	"gated",
>+	"triggered",
>+};
>+
>+static int stm32_enable_mode2sms(int mode)
>+{
>+	switch (mode) {
>+	case 0:
>+		return 0;
>+	case 1:
>+		return 5;
>+	case 2:
>+		return 6;
>+	}
>+
>+	return -EINVAL;
>+}
>+
>+static int stm32_set_enable_mode(struct iio_dev *indio_dev,
>+				 const struct iio_chan_spec *chan,
>+				 unsigned int mode)
>+{
>+	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
>+	int sms = stm32_enable_mode2sms(mode);
>+
>+	if (sms < 0)
>+		return sms;
>+
>+	regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS, sms);
>+
>+	return 0;
>+}
>+
>+static int stm32_sms2enable_mode(int mode)
>+{
>+	switch (mode) {
>+	case 0:
>+		return 0;
>+	case 5:
>+		return 1;
>+	case 6:
>+		return 2;
>+	}
>+
>+	return -EINVAL;
>+}
>+
>+static int stm32_get_enable_mode(struct iio_dev *indio_dev,
>+				 const struct iio_chan_spec *chan)
>+{
>+	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
>+	u32 smcr;
>+
>+	regmap_read(priv->regmap, TIM_SMCR, &smcr);
>+	smcr &= TIM_SMCR_SMS;
>+
>+	return stm32_sms2enable_mode(smcr);
>+}
>+
>+static const struct iio_enum stm32_enable_mode_enum = {
>+	.items = stm32_enable_modes,
>+	.num_items = ARRAY_SIZE(stm32_enable_modes),
>+	.set = stm32_set_enable_mode,
>+	.get = stm32_get_enable_mode
>+};
>+
> static const char *const stm32_quadrature_modes[] = {
> 	"channel_A",
> 	"channel_B",
>@@ -466,6 +534,8 @@ static ssize_t stm32_count_set_preset(struct iio_dev *indio_dev,
> 	IIO_ENUM_AVAILABLE("count_direction", &stm32_count_direction_enum),
> 	IIO_ENUM("quadrature_mode", IIO_SEPARATE, &stm32_quadrature_mode_enum),
> 	IIO_ENUM_AVAILABLE("quadrature_mode", &stm32_quadrature_mode_enum),
>+	IIO_ENUM("enable_mode", IIO_SEPARATE, &stm32_enable_mode_enum),
>+	IIO_ENUM_AVAILABLE("enable_mode", &stm32_enable_mode_enum),
> 	{}
> };
> 
>-- 
>1.9.1
>
