Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:33591 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752979AbdC0OuG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Mar 2017 10:50:06 -0400
Received: by mail-qt0-f169.google.com with SMTP id i34so39455120qtc.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Mar 2017 07:50:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170327135502.GB13775@sophia>
References: <1490607804-24889-1-git-send-email-benjamin.gaignard@st.com>
 <1490607804-24889-3-git-send-email-benjamin.gaignard@st.com> <20170327135502.GB13775@sophia>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Mon, 27 Mar 2017 16:43:26 +0200
Message-ID: <CA+M3ks7QH9umT60GPUcww=CHHq7+2XQ4jN7-LnVfdsY+0p+yuA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: stm32 trigger: Add counter enable modes
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, mwelling@ieee.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2017-03-27 15:55 GMT+02:00 William Breathitt Gray <vilhelm.gray@gmail.com>:
> On Mon, Mar 27, 2017 at 11:43:24AM +0200, Benjamin Gaignard wrote:
>>Device counting could be controlled by the level or the edges of
>>a trigger.
>>in_count0_enable_mode attibute allow to set the control mode.
>>
>>Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>
> This patch is pretty straight-forward and all right with me. A minor
> nitpick inline regarding documentation.
>
> Reviewed-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>
>>---
>> .../ABI/testing/sysfs-bus-iio-timer-stm32          | 23 +++++++
>> drivers/iio/trigger/stm32-timer-trigger.c          | 70 ++++++++++++++++=
++++++
>> 2 files changed, 93 insertions(+)
>>
>>diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Docume=
ntation/ABI/testing/sysfs-bus-iio-timer-stm32
>>index bf795ad..c0a1edc 100644
>>--- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>>+++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>>@@ -59,3 +59,26 @@ Description:
>>               quadrature:
>>                       Encoder A and B inputs are mixed to get direction
>>                       and count with a scale of 0.25.
>>+
>>+What:         /sys/bus/iio/devices/iio:deviceX/in_count_enable_mode_avai=
lable
>>+KernelVersion:        4.12
>>+Contact:      benjamin.gaignard@st.com
>>+Description:
>>+              Reading returns the list possible enable modes.
>>+
>>+What:         /sys/bus/iio/devices/iio:deviceX/in_count0_enable_mode
>>+KernelVersion:        4.12
>>+Contact:      benjamin.gaignard@st.com
>>+Description:
>>+              Configure the device counter enable modes, in all case
>>+              counting direction is set by in_count0_count_direction
>>+              attribute and the counter is clocked by the internal clock=
.
>>+              always:
>>+                      Counter is always ON.
>>+
>>+              gated:
>>+                      Counting is enabled when connected trigger signal
>>+                      level is high else counting is disabled.
>>+
>>+              triggered:
>>+                      Counting start on rising edge of the connected tri=
gger.
>
> When I read the description of the "triggered" mode, I get the
> impression that counting is restarted every time there is a rising edge
> from the connected trigger signal. However, from our previous
> discussions I believe this mode is simply a latched enable.
>
> Perhaps it may be beneficial for clarity to rework the description to
> say something along the lines of: "Counting is enabled on rising edge of
> the connected trigger, and remains enabled for the duration of this
> selected mode."

I will update that in v4.

Thanks

>
> William Breathitt Gray
>
>>diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trig=
ger/stm32-timer-trigger.c
>>index 7db904c..0f1a2cf 100644
>>--- a/drivers/iio/trigger/stm32-timer-trigger.c
>>+++ b/drivers/iio/trigger/stm32-timer-trigger.c
>>@@ -353,6 +353,74 @@ static int stm32_counter_write_raw(struct iio_dev *i=
ndio_dev,
>>       .write_raw =3D stm32_counter_write_raw
>> };
>>
>>+static const char *const stm32_enable_modes[] =3D {
>>+      "always",
>>+      "gated",
>>+      "triggered",
>>+};
>>+
>>+static int stm32_enable_mode2sms(int mode)
>>+{
>>+      switch (mode) {
>>+      case 0:
>>+              return 0;
>>+      case 1:
>>+              return 5;
>>+      case 2:
>>+              return 6;
>>+      }
>>+
>>+      return -EINVAL;
>>+}
>>+
>>+static int stm32_set_enable_mode(struct iio_dev *indio_dev,
>>+                               const struct iio_chan_spec *chan,
>>+                               unsigned int mode)
>>+{
>>+      struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
>>+      int sms =3D stm32_enable_mode2sms(mode);
>>+
>>+      if (sms < 0)
>>+              return sms;
>>+
>>+      regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS, sms);
>>+
>>+      return 0;
>>+}
>>+
>>+static int stm32_sms2enable_mode(int mode)
>>+{
>>+      switch (mode) {
>>+      case 0:
>>+              return 0;
>>+      case 5:
>>+              return 1;
>>+      case 6:
>>+              return 2;
>>+      }
>>+
>>+      return -EINVAL;
>>+}
>>+
>>+static int stm32_get_enable_mode(struct iio_dev *indio_dev,
>>+                               const struct iio_chan_spec *chan)
>>+{
>>+      struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
>>+      u32 smcr;
>>+
>>+      regmap_read(priv->regmap, TIM_SMCR, &smcr);
>>+      smcr &=3D TIM_SMCR_SMS;
>>+
>>+      return stm32_sms2enable_mode(smcr);
>>+}
>>+
>>+static const struct iio_enum stm32_enable_mode_enum =3D {
>>+      .items =3D stm32_enable_modes,
>>+      .num_items =3D ARRAY_SIZE(stm32_enable_modes),
>>+      .set =3D stm32_set_enable_mode,
>>+      .get =3D stm32_get_enable_mode
>>+};
>>+
>> static const char *const stm32_quadrature_modes[] =3D {
>>       "channel_A",
>>       "channel_B",
>>@@ -466,6 +534,8 @@ static ssize_t stm32_count_set_preset(struct iio_dev =
*indio_dev,
>>       IIO_ENUM_AVAILABLE("count_direction", &stm32_count_direction_enum)=
,
>>       IIO_ENUM("quadrature_mode", IIO_SEPARATE, &stm32_quadrature_mode_e=
num),
>>       IIO_ENUM_AVAILABLE("quadrature_mode", &stm32_quadrature_mode_enum)=
,
>>+      IIO_ENUM("enable_mode", IIO_SEPARATE, &stm32_enable_mode_enum),
>>+      IIO_ENUM_AVAILABLE("enable_mode", &stm32_enable_mode_enum),
>>       {}
>> };
>>
>>--
>>1.9.1
>>



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
