Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:36509 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752707AbdBTN0k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Feb 2017 08:26:40 -0500
Received: by mail-qt0-f180.google.com with SMTP id k15so86473916qtg.3
        for <linux-iio@vger.kernel.org>; Mon, 20 Feb 2017 05:26:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <c601d9ff-63cc-11f8-3c7f-68acb44133fa@kernel.org>
References: <1487254984-20122-1-git-send-email-benjamin.gaignard@st.com>
 <1487254984-20122-3-git-send-email-benjamin.gaignard@st.com> <c601d9ff-63cc-11f8-3c7f-68acb44133fa@kernel.org>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Mon, 20 Feb 2017 14:26:38 +0100
Message-ID: <CA+M3ks6PjTr36qSy1epQwqBfJj7oGVH69D2Rff7c1dCzi_RDdA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: stm32 trigger: Implement parent trigger feature
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

2017-02-19 16:53 GMT+01:00 Jonathan Cameron <jic23@kernel.org>:
> Hi All,
>
> Would be really helpful to get some other input on this.
> It's fiddly to put it lightly but if we get it right I think
> the interface will be useful in all sorts of common cases.
>
> On 16/02/17 14:23, Benjamin Gaignard wrote:
>> Add validate_trigger function in iio_trigger_ops and
>> dev_attr_parent_trigger into trigger attribute group to be able
>> to accept triggers as parents.
>>
>> Because the hardware have 8 different ways to use parent levels and
>> edges, this patch introduce "slave_mode" sysfs attribute for stm32
>> triggers. Modes usages are described in sysfs-bus-iio-timer-stm32
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Hi Benjamin,
>
> I'm increasingly convinced we need to be careful with the ABI
> on this to end up with something generic. It's useful stuff, but
> this particular hardware fuses various concepts based on them
> being on the same wire taking no noticed of whether the hardware
> upstream constrains what makes sense.
>
> Rarely are those concepts independent of
> what is actually wired to that signal so on a real system
> it is a lot less flexible than the hardware on it's own might
> imply.
>
> This is really giving me a headache on a Sunday afternoon.
> I don't have a good answer (yet). I'd like to completely
> separate the concepts but it is not obvious how to do it.

Maybe it give you a headache because it is going in wrong way...

I just discover that an quadratic encoder driver exist in IIO (104-quad-8).
>From my point of view it does exactly the same than my hardware:
- there are channels to read/write counter value and set/get preset value.
- counting modes are exposed using iio_enum
- counter direction could read from a channel

The main differences are the number and definition of counting modes.
Implementing my driver in this way is even better since it will allow to ge=
t/set
the counter and that was missing in parent trigger approach.

To summarize I could:
- use the current code (iio trigger) set a sampling frequency for ADC/DAC
- add quadratic encoder like (iio device) with counting mode, count directi=
on,
  quadrature mode and counter value channels.

That would really simplify the problem !

> I appreciate that what I'm asking will make this driver more
> complex, but I think we need to reflect accurately what the signals
> are in order to not leave userspace with access to modes that make
> absolutely no sense for a given hardware setup.
>
> This is a bit rambling, but hopefully following through will
> make sense...
>>
>> version 2:
>> - use dev_attr_parent_trigger
>> - improve slave modes documentation
>> ---
>>  .../ABI/testing/sysfs-bus-iio-timer-stm32          |  43 +++++++++
>>  drivers/iio/trigger/stm32-timer-trigger.c          | 105 ++++++++++++++=
+++++++
>>  2 files changed, 148 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Docum=
entation/ABI/testing/sysfs-bus-iio-timer-stm32
>> index 6534a60..7d667f9 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>> @@ -27,3 +27,46 @@ Description:
>>               Reading returns the current sampling frequency.
>>               Writing an value different of 0 set and start sampling.
>>               Writing 0 stop sampling.
>> +
>> +What:                /sys/bus/iio/devices/triggerX/slave_mode_available
> I think we need to drive this towards a generic description, whether that=
's easy or not.
> This needs to be clear and extensible.
>> +KernelVersion:       4.12
>> +Contact:     benjamin.gaignard@st.com
>> +Description:
>> +             Reading returns the list possible slave modes which are:
>> +             - "disabled"  : Parent trigger levels or edges have do not=
 impact on trigger.
>> +                             Trigger is clocked by the internal clock.
>> +                             This is the default mode.
> Don't bother with this first one.  The way to disable a parent trigger is=
 to not have
> one assigned.
>
> Remember a trigger won't have any effect on anything until we have a buff=
er
> actually using it so it doesn't matter what mode we come up in initially.
> Let the default be anything as that will be easier for a generic interfac=
e.
>
>> +             - "encoder_1" : Trigger internal counter counts up/down on=
 channel 2 edge depending on channel 1 level.
>> +             - "encoder_2" : Trigger internal counter counts up/down on=
 channel 1 edge depending on channel 2 level.
>> +             - "encoder_3" : Trigger internal counter counts up/down on=
 channels 1 & 2 edge
>> +                             depending on channel 1 & 2 level.
> Conceptually these are clocks that are getting divided down. So the
> child trigger has to have some concept of a divisor being applied.
> We can then describe these, but it needs to be a truly generic
> fashion which will be tricky.  In a sense, I'd expect these to be
> properties of the parent trigger rather than how it is being used
> by the child.
>
> Hmm.  Not sure on this so would like other opinions.
> The concept of triggers having two channels is somewhat of a stretch.
>
> To my mind, whether the inputs are connected to an encoder and what type
> it is should probably be a device tree property.  You wouldn't typically
> pretend for some channels that you have an encoder and reset on other
> channels.  So I think a trigger at the top level should be either
> an encoder or not and it should know from DT what type it is.
>
> This may be a pain to implement, but I think we need to do so.
>
>> +             - "reset"     : Rising edge on parent trigger reinitialize=
s the trigger and generates
>> +                             an update of auto-reload, prescaler and re=
petition counter registers.
>> +             - "gated"     : The trigger is enabled when the parent tri=
gger input is high.
>> +                             The trigger stops (but is not reset) as so=
on as the parent trigger becomes low.
> These two are our classic cases on a 'counting' trigger but in this case =
it is fed by another clock.
> It think we need to separate that relationship.
>
> A trigger that is a clock divider (fires every N clock cycles) can have:
>
> 1) A clock source, be it the default one / external or one of the encoder=
 types
> (though a given input should only be able to provide one of them as that
> is pretty much a wiring question rather than policy decision).
>
> 2) A parent trigger which can drive reset, gating (ignore clock) or start=
ing
>
> I have no issue with these both being controllable from userspace, but
> I can't see a generic interface where they are both via a single
> simple attribute.
>
>
>> +             - "trigger"   : The trigger starts at a rising edge of the=
 parent trigger (but it is not reset).
>> +             - "external_clock": Rising edges of the parent trigger clo=
ck the trigger.
>
> Note that in IIO ABI it is absolutely acceptable to have any attribute
> change the value of any other (hardware dependencies are way to complex
> to represent explicitly in some cases - like this one).
>
> So I think we might need quite a few attrs to make this work.
>
> parent-trigger
>         - as it is, but only handling the ones that are effecting the 'st=
ate' of the trigger counter, not it's rate.
>
> parent-clock
>         - allow this to also take a trigger but will be used in only the =
clock modes. If set to null we are on
>         the internal clock. Will be cleared if a parent-trigger is set as=
 it can't be both.
>         I'm not sure this will generalise well as we might feed of things=
 that aren't trigger.
>
> parent-clock-interpretation
>         - encoder, normal (at a push, maybe the encoder types but with me=
aningful names reflecting their wiring)
>          (I'd actually much prefer these to be facets of the parent trigg=
er - it only makes sense if
>         there is an encoder there or not - they also need not be configur=
ed from userspace)
>
> parent-trigger-interpretation
>         - reset, gated, start
>
>
> We could flatten this perhaps by broadening the parent-trigger concept to=
 explicitly allow it to be a clock.
>
> parent-trigger:
> parent-trigger-interpretation:
>         - reset_counter, gated, start_counter, as_clock (only gated is re=
ally generic, in that
> it could apply to any trigger including those that aren't periodic counte=
rs)
>
> parent-trigger-clock-type
>         - encoder, normal - though I think these really ought to be part =
of the parent trigger itself.
> As I've said, it makes no sense to be an encoder if there isn't encoder h=
ardware on the wires.
>
> I think I'm favouring the last option as long as the clock type in those =
modes is coming from
> DT or similar for the parent trigger. To my mind it has nothing really to=
 do with the child
> trigger.
>
>
> Anyhow, everyone please take a look at this!. It's a fairly big chunk of =
ABI that we will
> probably want to use more widely.
>
> Certainly applying a sysfs or interrrupt trigger (on a gpio) as a parent =
to a high resolution
> timer trigger and using in startcounter or resetcounter modes seems to me=
 a very useful
> tool to have more generally.  Even gated might work well for osciloscope =
type triggered
> captures.
>
> If we generalize the hrt slightly to be on for a period then we can do so=
mething like.
>
> gpio based interrupt trigger ---resetcounter--> hrttimer (on after a time=
, off sometime later
> --- gated ---> hrttimer at high frequency
>
> Which is relatively elegant and uses simple elements.
>
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
>> +             holds the angular position of the motor or the potentionme=
ter.
> Not without a reset or index mark being built in, it doesn't.  Relative a=
ngular position. I've not come
> across a pot that works this way (any links?)
>> +
>> +             For "reset", "gated" and "trigger" modes the trigger will =
fire N+1 times when internal counter
>> +             will reach the value of auto-reload register. N is defined=
 by the value of repetition counter.
> That makes these child triggers really periodic timers, just with weird c=
lock inputs.
>> +             Those modes could allow parent trigger to control when sam=
pling frequency of the current trigger
>> +             start or stop.
>> +             Since PWM and trigger features are mixed in the same hardw=
are block those 3 modes could be used
>> +             to synchronize PWMs start while PWM sysfs API is used to s=
et period and duty cycle.
>> +
>> +             In "external clock" mode parent trigger can control the cu=
rrent trigger clock (and so the sampling
>> +             frequency) for example to correct jittering.
>> +
>> +What:                /sys/bus/iio/devices/triggerX/slave_mode
>> +KernelVersion:       4.12
>> +Contact:     benjamin.gaignard@st.com
>> +Description:
>> +             Reading returns the current slave mode.
>> +             Writing set the slave mode
>> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/tri=
gger/stm32-timer-trigger.c
>> index 994b96d..a4f1061 100644
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
>> +     { TIM5_TRGO, TIM2_TRGO, TIM4_TRGO, TIM3_TRGO,},
>> +     { TIM1_TRGO, TIM8_TRGO, TIM3_TRGO, TIM4_TRGO,},
>> +     { TIM1_TRGO, TIM8_TRGO, TIM5_TRGO, TIM4_TRGO,},
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
>> @@ -221,10 +239,66 @@ static IIO_DEVICE_ATTR(master_mode, 0660,
>>                      stm32_tt_store_master_mode,
>>                      0);
>>
>> +static char *slave_mode_table[] =3D {
>> +     "disabled",
>> +     "encoder_1",
>> +     "encoder_2",
>> +     "encoder_3",
>> +     "reset",
>> +     "gated",
>> +     "trigger",
>> +     "external_clock",
>> +};
>> +
>> +static ssize_t stm32_tt_show_slave_mode(struct device *dev,
>> +                                     struct device_attribute *attr,
>> +                                     char *buf)
>> +{
>> +     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
>> +     struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
>> +     u32 smcr;
>> +
>> +     regmap_read(priv->regmap, TIM_SMCR, &smcr);
>> +     smcr &=3D TIM_SMCR_SMS;
>> +
>> +     return snprintf(buf, PAGE_SIZE, "%s\n", slave_mode_table[smcr]);
>> +}
>> +
>> +static ssize_t stm32_tt_store_slave_mode(struct device *dev,
>> +                                      struct device_attribute *attr,
>> +                                      const char *buf, size_t len)
>> +{
>> +     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
>> +     struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
>> +     int i;
>> +
>> +     for (i =3D 0; i < ARRAY_SIZE(slave_mode_table); i++) {
>> +             if (!strncmp(slave_mode_table[i], buf,
>> +                          strlen(slave_mode_table[i]))) {
>> +                     regmap_update_bits(priv->regmap,
>> +                                        TIM_SMCR, TIM_SMCR_SMS, i);
>> +                     return len;
>> +             }
>> +     }
>> +
>> +     return -EINVAL;
>> +}
>> +
>> +static IIO_CONST_ATTR(slave_mode_available,
>> +"disabled encoder_1 encoder_2 encoder_3 reset gated trigger external_cl=
ock");
>> +
>> +static IIO_DEVICE_ATTR(slave_mode, 0660,
>> +                    stm32_tt_show_slave_mode,
>> +                    stm32_tt_store_slave_mode,
>> +                    0);
>> +
>>  static struct attribute *stm32_trigger_attrs[] =3D {
>>       &iio_dev_attr_sampling_frequency.dev_attr.attr,
>>       &iio_dev_attr_master_mode.dev_attr.attr,
>>       &iio_const_attr_master_mode_available.dev_attr.attr,
>> +     &iio_dev_attr_slave_mode.dev_attr.attr,
>> +     &iio_const_attr_slave_mode_available.dev_attr.attr,
>> +     &dev_attr_parent_trigger.attr,
>>       NULL,
>>  };
>>
>> @@ -237,8 +311,38 @@ static IIO_DEVICE_ATTR(master_mode, 0660,
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
>> @@ -312,6 +416,7 @@ static int stm32_timer_trigger_probe(struct platform=
_device *pdev)
>>       priv->clk =3D ddata->clk;
>>       priv->max_arr =3D ddata->max_arr;
>>       priv->triggers =3D triggers_table[index];
>> +     priv->valids =3D valids_table[index];
>>
>>       ret =3D stm32_setup_iio_triggers(priv);
>>       if (ret)
>>
>



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
