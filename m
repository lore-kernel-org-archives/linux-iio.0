Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58288 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752270AbdDCT6V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2017 15:58:21 -0400
Subject: Re: [PATCH v3 2/2] iio: stm32 trigger: Add counter enable modes
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
References: <1490607804-24889-1-git-send-email-benjamin.gaignard@st.com>
 <1490607804-24889-3-git-send-email-benjamin.gaignard@st.com>
 <3553cca5-0097-000e-40e0-934ef0dca776@kernel.org>
 <CA+M3ks4LD+=VGLC+sEa16sH7vZD6zQ6JDRw0OSiDakpBqWTPqg@mail.gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        mwelling@ieee.org, Fabrice Gasnier <fabrice.gasnier@st.com>,
        Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <72583ad3-de0c-ab51-66f4-769687273a15@kernel.org>
Date: Mon, 3 Apr 2017 20:58:18 +0100
MIME-Version: 1.0
In-Reply-To: <CA+M3ks4LD+=VGLC+sEa16sH7vZD6zQ6JDRw0OSiDakpBqWTPqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/04/17 11:17, Benjamin Gaignard wrote:
> 2017-04-02 13:12 GMT+02:00 Jonathan Cameron <jic23@kernel.org>:
>> On 27/03/17 10:43, Benjamin Gaignard wrote:
>>> Device counting could be controlled by the level or the edges of
>>> a trigger.
>>> in_count0_enable_mode attibute allow to set the control mode.
>>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>>> ---
>>>  .../ABI/testing/sysfs-bus-iio-timer-stm32          | 23 +++++++
>>>  drivers/iio/trigger/stm32-timer-trigger.c          | 70 ++++++++++++++++++++++
>>>  2 files changed, 93 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>>> index bf795ad..c0a1edc 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>>> @@ -59,3 +59,26 @@ Description:
>>>               quadrature:
>>>                       Encoder A and B inputs are mixed to get direction
>>>                       and count with a scale of 0.25.
>>> +
>>> +What:                /sys/bus/iio/devices/iio:deviceX/in_count_enable_mode_available
>>> +KernelVersion:       4.12
>>> +Contact:     benjamin.gaignard@st.com
>>> +Description:
>>> +             Reading returns the list possible enable modes.
>>> +
>>> +What:                /sys/bus/iio/devices/iio:deviceX/in_count0_enable_mode
>>> +KernelVersion:       4.12
>>> +Contact:     benjamin.gaignard@st.com
>>> +Description:
>>> +             Configure the device counter enable modes, in all case
>>> +             counting direction is set by in_count0_count_direction
>>> +             attribute and the counter is clocked by the internal clock.
>> Silly question, how does one use the encoder modes then?
> 
> When setting an encoder mode internal counter is enabled no need to touch to
> in_count0_enable_mode in those cases
So in that case it's ignored? 
I'd be tempted to change the docs to drop the fact it is an internal clock.
However you'll also need to ensure that when an encoder mode is selected
this attribute will always read 'always'.   I think that ends up consistent..

Also there will be other devices that do these gating and triggering etc but
will do it even when fed by an encoder.

Jonathan
> 
>>
>>> +             always:
>>> +                     Counter is always ON.
>>> +
>>> +             gated:
>>> +                     Counting is enabled when connected trigger signal
>>> +                     level is high else counting is disabled.
>>> +
>>> +             triggered:
>>> +                     Counting start on rising edge of the connected trigger.
>>
>>
>>> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
>>> index 7db904c..0f1a2cf 100644
>>> --- a/drivers/iio/trigger/stm32-timer-trigger.c
>>> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
>>> @@ -353,6 +353,74 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
>>>       .write_raw = stm32_counter_write_raw
>>>  };
>>>
>>> +static const char *const stm32_enable_modes[] = {
>>> +     "always",
>>> +     "gated",
>>> +     "triggered",
>>> +};
>>> +
>>> +static int stm32_enable_mode2sms(int mode)
>>> +{
>>> +     switch (mode) {
>>> +     case 0:
>>> +             return 0;
>>> +     case 1:
>>> +             return 5;
>>> +     case 2:
>>> +             return 6;
>>> +     }
>>> +
>>> +     return -EINVAL;
>>> +}
>>> +
>>> +static int stm32_set_enable_mode(struct iio_dev *indio_dev,
>>> +                              const struct iio_chan_spec *chan,
>>> +                              unsigned int mode)
>>> +{
>>> +     struct stm32_timer_trigger *priv = iio_priv(indio_dev);
>>> +     int sms = stm32_enable_mode2sms(mode);
>>> +
>>> +     if (sms < 0)
>>> +             return sms;
>>> +
>>> +     regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS, sms);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int stm32_sms2enable_mode(int mode)
>>> +{
>>> +     switch (mode) {
>>> +     case 0:
>>> +             return 0;
>>> +     case 5:
>>> +             return 1;
>>> +     case 6:
>>> +             return 2;
>>> +     }
>>> +
>>> +     return -EINVAL;
>>> +}
>>> +
>>> +static int stm32_get_enable_mode(struct iio_dev *indio_dev,
>>> +                              const struct iio_chan_spec *chan)
>>> +{
>>> +     struct stm32_timer_trigger *priv = iio_priv(indio_dev);
>>> +     u32 smcr;
>>> +
>>> +     regmap_read(priv->regmap, TIM_SMCR, &smcr);
>>> +     smcr &= TIM_SMCR_SMS;
>>> +
>>> +     return stm32_sms2enable_mode(smcr);
>>> +}
>>> +
>>> +static const struct iio_enum stm32_enable_mode_enum = {
>>> +     .items = stm32_enable_modes,
>>> +     .num_items = ARRAY_SIZE(stm32_enable_modes),
>>> +     .set = stm32_set_enable_mode,
>>> +     .get = stm32_get_enable_mode
>>> +};
>>> +
>>>  static const char *const stm32_quadrature_modes[] = {
>>>       "channel_A",
>>>       "channel_B",
>>> @@ -466,6 +534,8 @@ static ssize_t stm32_count_set_preset(struct iio_dev *indio_dev,
>>>       IIO_ENUM_AVAILABLE("count_direction", &stm32_count_direction_enum),
>>>       IIO_ENUM("quadrature_mode", IIO_SEPARATE, &stm32_quadrature_mode_enum),
>>>       IIO_ENUM_AVAILABLE("quadrature_mode", &stm32_quadrature_mode_enum),
>>> +     IIO_ENUM("enable_mode", IIO_SEPARATE, &stm32_enable_mode_enum),
>>> +     IIO_ENUM_AVAILABLE("enable_mode", &stm32_enable_mode_enum),
>>>       {}
>>>  };
>>>
>>>
>>
> 
> 
> 

