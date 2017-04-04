Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:35119 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752922AbdDDHhg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Apr 2017 03:37:36 -0400
Received: by mail-qt0-f181.google.com with SMTP id x35so131570343qtc.2
        for <linux-iio@vger.kernel.org>; Tue, 04 Apr 2017 00:37:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <72583ad3-de0c-ab51-66f4-769687273a15@kernel.org>
References: <1490607804-24889-1-git-send-email-benjamin.gaignard@st.com>
 <1490607804-24889-3-git-send-email-benjamin.gaignard@st.com>
 <3553cca5-0097-000e-40e0-934ef0dca776@kernel.org> <CA+M3ks4LD+=VGLC+sEa16sH7vZD6zQ6JDRw0OSiDakpBqWTPqg@mail.gmail.com>
 <72583ad3-de0c-ab51-66f4-769687273a15@kernel.org>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Tue, 4 Apr 2017 09:37:25 +0200
Message-ID: <CA+M3ks7Qd0PcwnwFi5ytEV-wOH5TKvv5GnetKAMHO-4qLyKZiw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: stm32 trigger: Add counter enable modes
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        mwelling@ieee.org, Fabrice Gasnier <fabrice.gasnier@st.com>,
        Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2017-04-03 21:58 GMT+02:00 Jonathan Cameron <jic23@kernel.org>:
> On 03/04/17 11:17, Benjamin Gaignard wrote:
>> 2017-04-02 13:12 GMT+02:00 Jonathan Cameron <jic23@kernel.org>:
>>> On 27/03/17 10:43, Benjamin Gaignard wrote:
>>>> Device counting could be controlled by the level or the edges of
>>>> a trigger.
>>>> in_count0_enable_mode attibute allow to set the control mode.
>>>>
>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>>>> ---
>>>>  .../ABI/testing/sysfs-bus-iio-timer-stm32          | 23 +++++++
>>>>  drivers/iio/trigger/stm32-timer-trigger.c          | 70 +++++++++++++=
+++++++++
>>>>  2 files changed, 93 insertions(+)
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Doc=
umentation/ABI/testing/sysfs-bus-iio-timer-stm32
>>>> index bf795ad..c0a1edc 100644
>>>> --- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>>>> @@ -59,3 +59,26 @@ Description:
>>>>               quadrature:
>>>>                       Encoder A and B inputs are mixed to get directio=
n
>>>>                       and count with a scale of 0.25.
>>>> +
>>>> +What:                /sys/bus/iio/devices/iio:deviceX/in_count_enable=
_mode_available
>>>> +KernelVersion:       4.12
>>>> +Contact:     benjamin.gaignard@st.com
>>>> +Description:
>>>> +             Reading returns the list possible enable modes.
>>>> +
>>>> +What:                /sys/bus/iio/devices/iio:deviceX/in_count0_enabl=
e_mode
>>>> +KernelVersion:       4.12
>>>> +Contact:     benjamin.gaignard@st.com
>>>> +Description:
>>>> +             Configure the device counter enable modes, in all case
>>>> +             counting direction is set by in_count0_count_direction
>>>> +             attribute and the counter is clocked by the internal clo=
ck.
>>> Silly question, how does one use the encoder modes then?
>>
>> When setting an encoder mode internal counter is enabled no need to touc=
h to
>> in_count0_enable_mode in those cases
> So in that case it's ignored?
> I'd be tempted to change the docs to drop the fact it is an internal cloc=
k.
> However you'll also need to ensure that when an encoder mode is selected
> this attribute will always read 'always'.   I think that ends up consiste=
nt..

The counter could be drive (i.e counting up/down) by 3 type of source:
- the internal clock with 3 modes "always", "gated" and "triggered"
- the encoder input egdes and levels: 3 modes "channel_A", "channel_B"
and "quadrature"
- the rising egdes of a  connected trigger which is an internal signal
(for a later patch)

For each counter "source" I have an attribute but in the hardware they
are exclusive.
For example set "quadrature" means that the counter is counting on the edge=
s of
encoder inputs and no more on the rising edges of the internal clock.

I would like to keep this representing the hardware status so if an
encoder mode is
selected in_count0_enable_mode will return -EINVAL.

>
> Also there will be other devices that do these gating and triggering etc =
but
> will do it even when fed by an encoder.
>
> Jonathan
>>
>>>
>>>> +             always:
>>>> +                     Counter is always ON.
>>>> +
>>>> +             gated:
>>>> +                     Counting is enabled when connected trigger signa=
l
>>>> +                     level is high else counting is disabled.
>>>> +
>>>> +             triggered:
>>>> +                     Counting start on rising edge of the connected t=
rigger.
>>>
>>>
>>>> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/t=
rigger/stm32-timer-trigger.c
>>>> index 7db904c..0f1a2cf 100644
>>>> --- a/drivers/iio/trigger/stm32-timer-trigger.c
>>>> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
>>>> @@ -353,6 +353,74 @@ static int stm32_counter_write_raw(struct iio_dev=
 *indio_dev,
>>>>       .write_raw =3D stm32_counter_write_raw
>>>>  };
>>>>
>>>> +static const char *const stm32_enable_modes[] =3D {
>>>> +     "always",
>>>> +     "gated",
>>>> +     "triggered",
>>>> +};
>>>> +
>>>> +static int stm32_enable_mode2sms(int mode)
>>>> +{
>>>> +     switch (mode) {
>>>> +     case 0:
>>>> +             return 0;
>>>> +     case 1:
>>>> +             return 5;
>>>> +     case 2:
>>>> +             return 6;
>>>> +     }
>>>> +
>>>> +     return -EINVAL;
>>>> +}
>>>> +
>>>> +static int stm32_set_enable_mode(struct iio_dev *indio_dev,
>>>> +                              const struct iio_chan_spec *chan,
>>>> +                              unsigned int mode)
>>>> +{
>>>> +     struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
>>>> +     int sms =3D stm32_enable_mode2sms(mode);
>>>> +
>>>> +     if (sms < 0)
>>>> +             return sms;
>>>> +
>>>> +     regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS, sms);
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int stm32_sms2enable_mode(int mode)
>>>> +{
>>>> +     switch (mode) {
>>>> +     case 0:
>>>> +             return 0;
>>>> +     case 5:
>>>> +             return 1;
>>>> +     case 6:
>>>> +             return 2;
>>>> +     }
>>>> +
>>>> +     return -EINVAL;
>>>> +}
>>>> +
>>>> +static int stm32_get_enable_mode(struct iio_dev *indio_dev,
>>>> +                              const struct iio_chan_spec *chan)
>>>> +{
>>>> +     struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
>>>> +     u32 smcr;
>>>> +
>>>> +     regmap_read(priv->regmap, TIM_SMCR, &smcr);
>>>> +     smcr &=3D TIM_SMCR_SMS;
>>>> +
>>>> +     return stm32_sms2enable_mode(smcr);
>>>> +}
>>>> +
>>>> +static const struct iio_enum stm32_enable_mode_enum =3D {
>>>> +     .items =3D stm32_enable_modes,
>>>> +     .num_items =3D ARRAY_SIZE(stm32_enable_modes),
>>>> +     .set =3D stm32_set_enable_mode,
>>>> +     .get =3D stm32_get_enable_mode
>>>> +};
>>>> +
>>>>  static const char *const stm32_quadrature_modes[] =3D {
>>>>       "channel_A",
>>>>       "channel_B",
>>>> @@ -466,6 +534,8 @@ static ssize_t stm32_count_set_preset(struct iio_d=
ev *indio_dev,
>>>>       IIO_ENUM_AVAILABLE("count_direction", &stm32_count_direction_enu=
m),
>>>>       IIO_ENUM("quadrature_mode", IIO_SEPARATE, &stm32_quadrature_mode=
_enum),
>>>>       IIO_ENUM_AVAILABLE("quadrature_mode", &stm32_quadrature_mode_enu=
m),
>>>> +     IIO_ENUM("enable_mode", IIO_SEPARATE, &stm32_enable_mode_enum),
>>>> +     IIO_ENUM_AVAILABLE("enable_mode", &stm32_enable_mode_enum),
>>>>       {}
>>>>  };
>>>>
>>>>
>>>
>>
>>
>>
>



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
