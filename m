Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36210 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbdBZPAS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Feb 2017 10:00:18 -0500
Received: by mail-qk0-f181.google.com with SMTP id x71so65196204qkb.3
        for <linux-iio@vger.kernel.org>; Sun, 26 Feb 2017 06:59:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <aaf51d6a-3b84-4fc2-d20c-394d24fe217c@kernel.org>
References: <1487947695-9305-1-git-send-email-benjamin.gaignard@st.com>
 <1487947695-9305-3-git-send-email-benjamin.gaignard@st.com> <aaf51d6a-3b84-4fc2-d20c-394d24fe217c@kernel.org>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Sun, 26 Feb 2017 15:59:11 +0100
Message-ID: <CA+M3ks60mfq6Pc8LGJi=qJ7Eu_LBMu2OWOp5OZDc8X6bHnC-3w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: stm32 trigger: Implement parent trigger feature
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2017-02-25 18:53 GMT+01:00 Jonathan Cameron <jic23@kernel.org>:
> On 24/02/17 14:48, Benjamin Gaignard wrote:
>> Add validate_trigger function in iio_trigger_ops and
>> dev_attr_parent_trigger into trigger attribute group to be able
>> to accept triggers as parents.
>>
>> Introduce an IIO device with one IIO_COUNT channel to get access
>> to counter value. Counter directions can be set/get when writing/reading
>> /sys/bus/iio/devices/iio:deviceX/in_count0_count_direction.
>>
>> The hardware have multiple way to use inputs edges and levels to
>> performing counting, those different modes are exposed in:
>> /sys/bus/iio/devices/iio:deviceX/in_count_count_mode_available.
> Funny though it sounds, this is to general to generalize.
> See below.
>>
>> "trigger_rising_edges" mode is automatically set when a valid
>> parent trigger is set.
> We still have an issue of two overlapping concepts here, that
> of a clock and that of a parent trigger. Perhaps it's valid
> to have a clock set to be the parent trigger, but that is
> kind of the odd case rather than the normal use of
> parent triggers (in my head at least :)
>
> So what we end up with here is something we have kind of messed
> around with before...
>
> An event acting as a trigger.
> Conceptually your 'preset' occurring is an event in IIO terms
> (there is on going work to present exactly that event to userspace
> for the other encoder driver we have).
>
> That event is then acting as a trigger, even if that trigger
> is not 'visible' as such to userspace.
>
> This event as trigger is something we have messed around with
> from the very start but never formalized. It is one of the things
> that would make good use of an inkernel consumer interface
> for events.  If we had one of those, a tiny driver and a bit of
> configfs magic interface and we'd be able to use any event as
> a trigger.
>
> Hence I rather like this. You could say it fits with my
> world view ;)
>
> Only remaining question to my mind is whether we need to make that
> presence of an 'event' explicit?  Doesn't necessarily have
> to happen now, but if it existed in some sense it might make
> it easier for generic userspace to interpret what is going on.
>
> Maybe something for the future.
>
> Anyhow, still some work to do here, but moving in a viable
> direction (I think) so keep up the good work!

An other way is to get a device which is a trigger consumer without
having buffer or
>
> Jonathan
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>>
>> version 2:
>> - use dev_attr_parent_trigger
>> - improve slave modes documentation
>>
>> version 3:
>> - add one channel to get counter raw value
>> ---
>>  .../ABI/testing/sysfs-bus-iio-timer-stm32          |  63 +++++
>>  drivers/iio/trigger/stm32-timer-trigger.c          | 256 ++++++++++++++=
++++++-
>>  include/linux/mfd/stm32-timers.h                   |   2 +
>>  3 files changed, 315 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Docum=
entation/ABI/testing/sysfs-bus-iio-timer-stm32
>> index 6534a60..63852a9 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>> @@ -27,3 +27,66 @@ Description:
>>               Reading returns the current sampling frequency.
>>               Writing an value different of 0 set and start sampling.
>>               Writing 0 stop sampling.
>> +
>> +What:                /sys/bus/iio/devices/iio:deviceX/in_count0_raw
>> +KernelVersion:       4.12
>> +Contact:     benjamin.gaignard@st.com
>> +Description:
>> +             Reading returns counter current value.
> Assuming it counts every one this can definitely be in_count0_input (so p=
rocessed)
> as it's in the 'base' units. Kind of hard not to be with a counter.
>
> Hohum. Just checked docs and this is documented as _raw.
> Oh well no real harm in doing that I guess so perhaps we just stay with t=
hat even
> if it's a little silly.
>
> Anyhow, no need to document stuff in here that is in the main docs
> sysfs-bus-iio

Ok I will remove it from stm32-timer documentation
>> +
>> +What:                /sys/bus/iio/devices/iio:deviceX/in_count_count_di=
rection_available
>> +KernelVersion:       4.12
>> +Contact:     benjamin.gaignard@st.com
>> +Description:
>> +             Reading returns the list of possible counting directions w=
hich
>> +             are:
>> +             - "up"  : counter is increasing.
>> +             - "down": counter is decreasing.
> This is now generic enough we should probably move it into the main docs =
rather than
> repeating for each device.
>
> So cut this out of here and out of the 104_counter file and put it in
> sysfs-bus-iio.
>
> Note that for some you'll have to drop the bits in the 104-counter-quad-8=
 file that say
> if things are read only or not.  The sysfs ABI docs don't need to say so =
that is fine.

Okay

>> +
>> +What:                /sys/bus/iio/devices/iio:deviceX/in_count0_count_d=
irection
>> +KernelVersion:       4.12
>> +Contact:     benjamin.gaignard@st.com
>> +Description:
>> +             Reading returns the counting directions:
>> +             - "up"  : counter is increasing.
>> +             - "down": counter is decreasing.
>> +             Writing set the counting direction.
>> +
>> +What:                /sys/bus/iio/devices/iio:deviceX/in_count_count_mo=
de_available
>> +KernelVersion:       4.12
>> +Contact:     benjamin.gaignard@st.com
>> +Description:
> I still think this needs breaking up if we are going to have any hope of =
a generic interface.
>
>> +             Reading returns the list of possible counting modes which =
are:
>> +             - "internal_clock": Counter is clocked by the internal clo=
ck rising edges.
> This is about the feed clock - not a mode as such.
>
>> +             - "encoder_1" : Counter counts up/down on channel 2 edge d=
epending on channel 1 level.
>> +             - "encoder_2" : Counter counts up/down on channel 1 edge d=
epending on channel 2 level.
>> +             - "encoder_3" : Counter counts up/down on channels 1 & 2 e=
dge depending on channel 1 & 2 level.
> These combine the feed clock and the interpretation.  To my mind, two dif=
ferent things.
>
> I kind of dislike the fact we can be either an internal clock or an encod=
er. seems that if you have an encoder
> wired it would be nuts to use the internal clock, but given we do this on=
 various rigs at work to fake
> things when the encoder isn't moving I can't claim there is no use case ;=
)
>
>> +             - "reset"     : Rising edges on parent trigger reinitializ=
es the counter value to preset value.
>> +             - "gated"     : Counter counts when the parent trigger inp=
ut is high.
>> +                             Counter stops (but is not reset) as soon a=
s the parent trigger becomes low.
>> +             - "trigger"   : Counter starts at a rising edge of the par=
ent trigger (but it is not reset).
> These are gating of the feed clock
>
>> +             - "trigger_rising_edges": Rising edges of the parent trigg=
er are used as clock by the counter.
> This one is about the feed clock again.
>
> So we need at least 3 different things.
> 1. Feed clock selection.
> 2. Encoder interpretation selection - arguably we should have an explicit=
 description of the encoder
> as a device in it's own right but I guess we can ignore that for now.
> 3. The parent trigger 'use'.

Here all is about how is clocked device counter, it could be by:
- the internal SoC clock rising edges
- the rising edges of some external pins (encoder, reset, gated, trigger)
- the rising edges of an internal signal which is represented by a trigger.

Without parent trigger I can already push the all except the last one.
Maybe doing like this is a better solution ?

>> +
>> +             Encoder modes are used to automatically handle the countin=
g direction of the internal counter.
>> +             Those modes are typically used for high-accuracy rotor pos=
ition sensing in electrical motors
>> +             or for digital potentiometers. From the two outputs of a q=
uadrature encoder sensor the timer
>> +             extracts a clock on each and every active edge and adjusts=
 the counting direction depending on
>> +             the relative phase-shift between the two incomings signals=
. The timer counter thus directly
>> +             holds the angular position of the motor.
>> +
>> +             "trigger_rising_edges" mode is automatically set when a va=
lid parent trigger is set.
>> +
>> +What:                /sys/bus/iio/devices/iio:deviceX/in_count0_count_m=
ode
>> +KernelVersion:       4.12
>> +Contact:     benjamin.gaignard@st.com
>> +Description:
>> +             Reading returns the current counting mode.
>> +
>> +What:                /sys/bus/iio/devices/iio:deviceX/in_count0_preset
>> +KernelVersion:       4.12
>> +Contact:     benjamin.gaignard@st.com
>> +Description:
>> +             Reading returns the current preset value.
>> +             Writing set the preset value.
>> +             When counting up the counter start from 0 and fire an even=
t when reach preset value.
>> +             When counting down the counter start from preset value and=
 fire event when reach 0.
> Fair enough, I hadn't thought if it like this, but makes sense.
>
>> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/tri=
gger/stm32-timer-trigger.c
>> index 994b96d..04f5f05 100644
>> --- a/drivers/iio/trigger/stm32-timer-trigger.c
>> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/platform_device.h>
>>
>>  #define MAX_TRIGGERS 6
>> +#define MAX_VALIDS 5
>>
>>  /* List the triggers created by each timer */
>>  static const void *triggers_table[][MAX_TRIGGERS] =3D {
>> @@ -32,12 +33,29 @@
>>       { TIM12_TRGO, TIM12_CH1, TIM12_CH2,},
>>  };
>>
>> +/* List the triggers accepted by each timer */
>> +static const void *valids_table[][MAX_VALIDS] =3D {
>> +     { TIM5_TRGO, TIM2_TRGO, TIM3_TRGO, TIM4_TRGO,},
>> +     { TIM1_TRGO, TIM8_TRGO, TIM3_TRGO, TIM4_TRGO,},
>> +     { TIM1_TRGO, TIM2_TRGO, TIM5_TRGO, TIM4_TRGO,},
>> +     { TIM1_TRGO, TIM2_TRGO, TIM3_TRGO, TIM8_TRGO,},
>> +     { TIM2_TRGO, TIM3_TRGO, TIM4_TRGO, TIM8_TRGO,},
>> +     { }, /* timer 6 */
>> +     { }, /* timer 7 */
>> +     { TIM1_TRGO, TIM2_TRGO, TIM4_TRGO, TIM5_TRGO,},
>> +     { TIM2_TRGO, TIM3_TRGO,},
>> +     { }, /* timer 10 */
>> +     { }, /* timer 11 */
>> +     { TIM4_TRGO, TIM5_TRGO,},
>> +};
>> +
>>  struct stm32_timer_trigger {
>>       struct device *dev;
>>       struct regmap *regmap;
>>       struct clk *clk;
>>       u32 max_arr;
>>       const void *triggers;
>> +     const void *valids;
>>  };
>>
>>  static int stm32_timer_start(struct stm32_timer_trigger *priv,
>> @@ -180,8 +198,7 @@ static ssize_t stm32_tt_show_master_mode(struct devi=
ce *dev,
>>                                        struct device_attribute *attr,
>>                                        char *buf)
>>  {
>> -     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
>> -     struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
>> +     struct stm32_timer_trigger *priv =3D dev_get_drvdata(dev);
>>       u32 cr2;
>>
>>       regmap_read(priv->regmap, TIM_CR2, &cr2);
>> @@ -194,10 +211,10 @@ static ssize_t stm32_tt_store_master_mode(struct d=
evice *dev,
>>                                         struct device_attribute *attr,
>>                                         const char *buf, size_t len)
>>  {
>> -     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
>> -     struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
>> +     struct stm32_timer_trigger *priv =3D dev_get_drvdata(dev);
>>       int i;
>>
>> +
>>       for (i =3D 0; i < ARRAY_SIZE(master_mode_table); i++) {
>>               if (!strncmp(master_mode_table[i], buf,
>>                            strlen(master_mode_table[i]))) {
>> @@ -225,6 +242,7 @@ static IIO_DEVICE_ATTR(master_mode, 0660,
>>       &iio_dev_attr_sampling_frequency.dev_attr.attr,
>>       &iio_dev_attr_master_mode.dev_attr.attr,
>>       &iio_const_attr_master_mode_available.dev_attr.attr,
>> +     &dev_attr_parent_trigger.attr,
>>       NULL,
>>  };
>>
>> @@ -237,8 +255,49 @@ static IIO_DEVICE_ATTR(master_mode, 0660,
>>       NULL,
>>  };
>>
>> +static int stm32_validate_trigger(struct iio_trigger *trig,
>> +                               struct iio_trigger *parent)
>> +{
>> +     struct stm32_timer_trigger *priv =3D iio_trigger_get_drvdata(trig)=
;
>> +     const char * const *cur =3D priv->valids;
>> +     unsigned int i =3D 0;
>> +
>> +     if (!parent) {
>> +             regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_TS, 0)=
;
>> +             return 0;
>> +     }
>> +
>> +     if (!is_stm32_timer_trigger(parent))
>> +             return -EINVAL;
>> +
>> +     while (cur && *cur) {
>> +             if (!strncmp(parent->name, *cur, strlen(parent->name))) {
>> +                     regmap_update_bits(priv->regmap,
>> +                                        TIM_SMCR, TIM_SMCR_TS,
>> +                                        i << TIM_SMCR_TS_SHIFT);
>> +
>> +                     /*
>> +                      * By default make parent trigger rising edges
>> +                      * use as clock for the counter
>> +                      */
>> +                     regmap_update_bits(priv->regmap, TIM_SMCR,
>> +                                        TIM_SMCR_SMS, TIM_SMCR_SMS);
>> +
>> +                     /* Enable controller */
>> +                     regmap_update_bits(priv->regmap, TIM_CR1,
>> +                                        TIM_CR1_CEN, TIM_CR1_CEN);
>> +                     return 0;
>> +             }
>> +             cur++;
>> +             i++;
>> +     }
>> +
>> +     return -EINVAL;
>> +}
>> +
>>  static const struct iio_trigger_ops timer_trigger_ops =3D {
>>       .owner =3D THIS_MODULE,
>> +     .validate_trigger =3D stm32_validate_trigger,
>>  };
>>
>>  static int stm32_setup_iio_triggers(struct stm32_timer_trigger *priv)
>> @@ -275,6 +334,185 @@ static int stm32_setup_iio_triggers(struct stm32_t=
imer_trigger *priv)
>>       return 0;
>>  }
>>
>> +static int stm32_trigger_read_raw(struct iio_dev *indio_dev,
>> +                               struct iio_chan_spec const *chan,
>> +                               int *val, int *val2, long mask)
>> +{
>> +     struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
>> +
>> +     switch (mask) {
>> +     case IIO_CHAN_INFO_RAW:
>> +     {
>> +             u32 cnt;
>> +
>> +             regmap_read(priv->regmap, TIM_CNT, &cnt);
>> +             *val =3D cnt;
>> +
>> +             return IIO_VAL_INT;
>> +     }
>> +     }
>> +
>> +     return -EINVAL;
>> +}
>> +
>> +static const struct iio_info stm32_trigger_info =3D {
>> +     .driver_module =3D THIS_MODULE,
>> +     .read_raw =3D stm32_trigger_read_raw,
>> +};
>> +
>> +static const char *const stm32_count_modes[] =3D {
>> +     "internal_clock",
>> +     "encoder_1",
>> +     "encoder_2",
>> +     "encoder_3",
>> +     "reset",
>> +     "gated",
>> +     "trigger",
>> +     "trigger_rising_edges"
>> +};
>> +
>> +static int stm32_set_count_mode(struct iio_dev *indio_dev,
>> +                             const struct iio_chan_spec *chan,
>> +                             unsigned int mode)
>> +{
>> +     struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
>> +
>> +     regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS, mode);
>> +
>> +     return 0;
>> +}
>> +
>> +static int stm32_get_count_mode(struct iio_dev *indio_dev,
>> +                             const struct iio_chan_spec *chan)
>> +{
>> +     struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
>> +     u32 smcr;
>> +
>> +     regmap_read(priv->regmap, TIM_SMCR, &smcr);
>> +     smcr &=3D TIM_SMCR_SMS;
>> +
>> +     return smcr;
>> +}
>> +
>> +static const struct iio_enum stm32_count_mode_enum =3D {
>> +     .items =3D stm32_count_modes,
>> +     .num_items =3D ARRAY_SIZE(stm32_count_modes),
>> +     .set =3D stm32_set_count_mode,
>> +     .get =3D stm32_get_count_mode
>> +};
>> +
>> +static const char *const stm32_count_direction_states[] =3D {
>> +     "up",
>> +     "down"
>> +};
>> +
>> +static int stm32_set_count_direction(struct iio_dev *indio_dev,
>> +                                  const struct iio_chan_spec *chan,
>> +                                  unsigned int mode)
>> +{
>> +     struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
>> +
>> +     regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_DIR, mode);
>> +
>> +     return 0;
>> +}
>> +
>> +static int stm32_get_count_direction(struct iio_dev *indio_dev,
>> +                                  const struct iio_chan_spec *chan)
>> +{
>> +     struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
>> +     u32 cr1;
>> +
>> +     regmap_read(priv->regmap, TIM_CR1, &cr1);
>> +
>> +     return (cr1 & TIM_CR1_DIR);
>> +}
>> +
>> +static const struct iio_enum stm32_count_direction_enum =3D {
>> +     .items =3D stm32_count_direction_states,
>> +     .num_items =3D ARRAY_SIZE(stm32_count_direction_states),
>> +     .set =3D stm32_set_count_direction,
>> +     .get =3D stm32_get_count_direction
>> +};
>> +
>> +static ssize_t stm32_count_get_preset(struct iio_dev *indio_dev,
>> +                                   uintptr_t private,
>> +                                   const struct iio_chan_spec *chan,
>> +                                   char *buf)
>> +{
>> +     struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
>> +     u32 arr;
>> +
>> +     regmap_read(priv->regmap, TIM_ARR, &arr);
>> +
>> +     return snprintf(buf, PAGE_SIZE, "%u\n", arr);
>> +}
>> +
>> +static ssize_t stm32_count_set_preset(struct iio_dev *indio_dev,
>> +                                   uintptr_t private,
>> +                                   const struct iio_chan_spec *chan,
>> +                                   const char *buf, size_t len)
>> +{
>> +     struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
>> +     unsigned int preset;
>> +     int ret;
>> +
>> +     ret =3D kstrtouint(buf, 0, &preset);
>> +     if (ret)
>> +             return ret;
>> +
>> +     regmap_write(priv->regmap, TIM_ARR, preset);
>> +     regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, TIM_CR1_AR=
PE);
>> +
>> +     return len;
>> +}
>> +
>> +static const struct iio_chan_spec_ext_info stm32_trigger_count_info[] =
=3D {
>> +     {
>> +             .name =3D "preset",
>> +             .shared =3D IIO_SEPARATE,
>> +             .read =3D stm32_count_get_preset,
>> +             .write =3D stm32_count_set_preset
>> +     },
>> +     IIO_ENUM("count_direction", IIO_SEPARATE, &stm32_count_direction_e=
num),
>> +     IIO_ENUM_AVAILABLE("count_direction", &stm32_count_direction_enum)=
,
>> +     IIO_ENUM("count_mode", IIO_SEPARATE, &stm32_count_mode_enum),
>> +     IIO_ENUM_AVAILABLE("count_mode", &stm32_count_mode_enum),
>> +     {}
>> +};
>> +
>> +static const struct iio_chan_spec stm32_trigger_channel =3D {
>> +     .type =3D IIO_COUNT,
>> +     .channel =3D 0,
>> +     .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
>> +     .ext_info =3D stm32_trigger_count_info,
>> +     .indexed =3D 1
>> +};
>> +
>> +static struct stm32_timer_trigger *stm32_setup_iio_device(struct device=
 *dev)
>> +{
>> +     struct iio_dev *indio_dev;
>> +     int ret;
>> +
>> +     indio_dev =3D devm_iio_device_alloc(dev,
>> +                                       sizeof(struct stm32_timer_trigge=
r));
>> +     if (!indio_dev)
>> +             return NULL;
>> +
>> +     indio_dev->name =3D dev_name(dev);
>> +     indio_dev->dev.parent =3D dev;
>> +     indio_dev->info =3D &stm32_trigger_info;
>> +     indio_dev->num_channels =3D 1;
>> +     indio_dev->channels =3D &stm32_trigger_channel;
>> +     indio_dev->dev.of_node =3D dev->of_node;
>> +
>> +     ret =3D devm_iio_device_register(dev, indio_dev);
>> +     if (ret)
>> +             return NULL;
>> +
>> +     return iio_priv(indio_dev);
>> +}
>> +
>>  /**
>>   * is_stm32_timer_trigger
>>   * @trig: trigger to be checked
>> @@ -299,10 +537,15 @@ static int stm32_timer_trigger_probe(struct platfo=
rm_device *pdev)
>>       if (of_property_read_u32(dev->of_node, "reg", &index))
>>               return -EINVAL;
>>
>> -     if (index >=3D ARRAY_SIZE(triggers_table))
>> +     if (index >=3D ARRAY_SIZE(triggers_table)
>> +         || index >=3D ARRAY_SIZE(valids_table))
>>               return -EINVAL;
>>
>> -     priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +     /* Create an IIO device only if we have triggers to be validated *=
/
>> +     if (*valids_table[index])
>> +             priv =3D stm32_setup_iio_device(dev);
>> +     else
>> +             priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>
>>       if (!priv)
>>               return -ENOMEM;
>> @@ -312,6 +555,7 @@ static int stm32_timer_trigger_probe(struct platform=
_device *pdev)
>>       priv->clk =3D ddata->clk;
>>       priv->max_arr =3D ddata->max_arr;
>>       priv->triggers =3D triggers_table[index];
>> +     priv->valids =3D valids_table[index];
>>
>>       ret =3D stm32_setup_iio_triggers(priv);
>>       if (ret)
>> diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-=
timers.h
>> index d030004..4a0abbc 100644
>> --- a/include/linux/mfd/stm32-timers.h
>> +++ b/include/linux/mfd/stm32-timers.h
>> @@ -21,6 +21,7 @@
>>  #define TIM_CCMR1    0x18    /* Capt/Comp 1 Mode Reg    */
>>  #define TIM_CCMR2    0x1C    /* Capt/Comp 2 Mode Reg    */
>>  #define TIM_CCER     0x20    /* Capt/Comp Enable Reg    */
>> +#define TIM_CNT              0x24    /* Counter                 */
>>  #define TIM_PSC              0x28    /* Prescaler               */
>>  #define TIM_ARR              0x2c    /* Auto-Reload Register    */
>>  #define TIM_CCR1     0x34    /* Capt/Comp Register 1    */
>> @@ -30,6 +31,7 @@
>>  #define TIM_BDTR     0x44    /* Break and Dead-Time Reg */
>>
>>  #define TIM_CR1_CEN  BIT(0)  /* Counter Enable          */
>> +#define TIM_CR1_DIR  BIT(4)  /* Counter Direction       */
>>  #define TIM_CR1_ARPE BIT(7)  /* Auto-reload Preload Ena */
>>  #define TIM_CR2_MMS  (BIT(4) | BIT(5) | BIT(6)) /* Master mode selectio=
n */
>>  #define TIM_SMCR_SMS (BIT(0) | BIT(1) | BIT(2)) /* Slave mode selection=
 */
>>
>



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
