Return-Path: <SRS0=PEcC=YR=linaro.org=benjamin.gaignard@kernel.org>
MIME-Version: 1.0
In-Reply-To: <c46e6e59-b5b6-39e6-d6f4-5ca4539f746c@kernel.org>
References: <1481292919-26587-1-git-send-email-benjamin.gaignard@st.com>
 <1481292919-26587-7-git-send-email-benjamin.gaignard@st.com>
 <70f15b07-55d9-bd0d-25c7-712363e30974@kernel.org> <CA+M3ks7O_6cWZLAAjEvPD-DQBmU--qrsuh1HfcTa9eLqaT-+fQ@mail.gmail.com>
 <c46e6e59-b5b6-39e6-d6f4-5ca4539f746c@kernel.org>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Tue, 3 Jan 2017 10:23:34 +0100
Message-ID: <CA+M3ks6jshX-rEsi7Qfo-65awzWcHsEMVBjm-baYy979V9187Q@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] IIO: add STM32 timer trigger driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, robh+dt@kernel.org,
	Mark Rutland <mark.rutland@arm.com>, Alexandre Torgue <alexandre.torgue@st.com>,
	devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
	Linux PWM List <linux-pwm@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabrice Gasnier <fabrice.gasnier@st.com>, Gerald Baeza <gerald.baeza@st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@st.com>, Linus Walleij <linus.walleij@linaro.org>,
	Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

2017-01-02 19:22 GMT+01:00 Jonathan Cameron <jic23@kernel.org>:
> On 02/01/17 08:46, Benjamin Gaignard wrote:
>> 2016-12-30 22:12 GMT+01:00 Jonathan Cameron <jic23@kernel.org>:
>>> On 09/12/16 14:15, Benjamin Gaignard wrote:
>>>> Timers IPs can be used to generate triggers for other IPs like
>>>> DAC, ADC or other timers.
>>>> Each trigger may result of timer internals signals like counter enable=
,
>>>> reset or edge, this configuration could be done through "master_mode"
>>>> device attribute.
>>>>
>>>> A timer device could be triggered by other timers, we use the trigger
>>>> name and is_stm32_iio_timer_trigger() function to distinguish them
>>>> and configure IP input switch.
>>>>
>>>> Timer may also decide on which event (edge, level) they could
>>>> be activated by a trigger, this configuration is done by writing in
>>>> "slave_mode" device attribute.
>>>>
>>>> Since triggers could also be used by DAC or ADC their names are define=
d
>>>> in include/ nux/iio/timer/stm32-timer-trigger.h so those IPs will be a=
ble
>>>> to configure themselves in valid_trigger function
>>>>
>>>> Trigger have a "sampling_frequency" attribute which allow to configure
>>>> timer sampling frequency without using PWM interface
>>>>
>>>> version 5:
>>>> - simplify tables of triggers
>>>> - only create an IIO device when needed
>>>>
>>>> version 4:
>>>> - get triggers configuration from "reg" in DT
>>>> - add tables of triggers
>>>> - sampling frequency is enable/disable when writing in trigger
>>>>   sampling_frequency attribute
>>>> - no more use of interruptions
>>>>
>>>> version 3:
>>>> - change compatible to "st,stm32-timer-trigger"
>>>> - fix attributes access right
>>>> - use string instead of int for master_mode and slave_mode
>>>> - document device attributes in sysfs-bus-iio-timer-stm32
>>>>
>>>> version 2:
>>>> - keep only one compatible
>>>> - use st,input-triggers-names and st,output-triggers-names
>>>>   to know which triggers are accepted and/or create by the device
>>> Firstly, sorry it has taken me so long to get back to this.
>>>
>>> I'm still not keen on this use of iio_device elements just to act as
>>> glue between triggers.  I think we need to work out a more light weight
>>> way to do this.  As you are only using them for validation and to provi=
de
>>> somewhere to hang the control attibutes off, there is nothing stopping =
us
>>> moving that over to the iio_trigger instead which would avoid the messy
>>> duality going on here.
>>
>> I have add an iio_device because each hardware can generate multiple
>> triggers (up to 5: trgo, ch 1...4) and slave_mode attribute will impact =
all the
>> triggers of a device. For me it was making sense to centralize that in a=
n
>> iio_device rather than having an attribute "shared" (from hardware
>> point of view)
>> on multiple triggers.
>> Since master_mode attribute is only used by trgo and not impact ch1...4
>> triggers I will move it to trigger instead of the iio_device.
>>
>> I also wanted to be able to connect triggers on a iio_device as I
>> could do for an
>> ADC with a command like 'echo "tim1_trgo" > iio_deviceX/trigger/current_=
trigger'
> This is interesting, but with a bit of refactoring I would think it would
> be possible to share some of that code thus allowing non IIO devices to
> bind to triggers.  Ultimately I want to be able to bind a trigger to
> a trigger - I appreciate here the topology is more limited than that
> so some complexity comes in.
>
> My gut feeling is that representing that topology explicitly is hard
> to do in a remotely general way, but lets try it and see.
> We run into this sort of interdependency issue between different bits of
> the hardware all the time.  Setting a value somewhere effects the configu=
ration
> elsewhere - often the best plan is to just let that happen and leave it u=
p to
> userspace to check for changes if it cares.

okay

>> If I change that to parent_trigger attribute it change this behavior
>> and I will have to
>> duplicated what is done in iio_trigger_write_current() to find and
>> validate triggers.
> I get the reasoning, but we still end up with something represented
> by an IIO device that isn't providing any channels at all. It's simply
> using some of the infrastructure.  To my mind it is 'something else'
> and should be represented as such.  I have no problem at all with
> you registering additional elements in /sysfs/bus/iio/ to represent
> these shared elements - we already have drivers that do that to
> provide some centralized infrastructure (e.g. the sysfs-trigger)

My hardware block are timers maybe I can add a channel type "IIO_TIMER"
and declare a channel with info_mask_separate =3D BIT(IIO_CHAN_INFO_SAMP_FR=
EQ)
so I will be able to write/read sampling frequency on IIO device.

> I'm worried about the scope spread we get for an IIO device otherwise.
> They serve a well defined purpose at the moment, and that isn't what
> is happening here.
>
> So my gut feeling is we are better deliberately not representing the
> inter dependence and claiming all triggers we are creating are
> independent.  That way we can have a nice generic infrastructure
> that will work in all cases (be it pushing the sanity checking to
> userspace).
>
> So each trigger has direct access to what controls it.  Changing anything
> can effect other triggers in weird ways.
>
> I'm finding it hard to see anything else generalizing sufficiently
> as we'll always get cases where we can't represent the topology without
> diving into the complexity of something like the media controller
> framework.
>
> Jonathan
>>
>>> I might still be missing something though!
>>>
>>> You would only I think need 3 attributes
>>>
>>> parrent_trigger
>>> and something like your master_mode and slave_mode attributes.
>>>
>>> The parrent_trigger would need some validation etc, but if we keep it
>>> within this driver initially that won't be hard to do. Checking the dev=
ice
>>> parent matches will do most of it.
>>>
>>> Jonathan
>>>>
>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>>>> ---
>>>>  .../ABI/testing/sysfs-bus-iio-timer-stm32          |  55 +++
>>>>  drivers/iio/Kconfig                                |   2 +-
>>>>  drivers/iio/Makefile                               |   1 +
>>>>  drivers/iio/timer/Kconfig                          |  13 +
>>>>  drivers/iio/timer/Makefile                         |   1 +
>>>>  drivers/iio/timer/stm32-timer-trigger.c            | 466 ++++++++++++=
+++++++++
>>>>  drivers/iio/trigger/Kconfig                        |   1 -
>>>>  include/linux/iio/timer/stm32-timer-trigger.h      |  62 +++
>>>>  8 files changed, 599 insertions(+), 2 deletions(-)
>>>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-timer-stm3=
2
>>>>  create mode 100644 drivers/iio/timer/Kconfig
>>>>  create mode 100644 drivers/iio/timer/Makefile
>>>>  create mode 100644 drivers/iio/timer/stm32-timer-trigger.c
>>>>  create mode 100644 include/linux/iio/timer/stm32-timer-trigger.h
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Doc=
umentation/ABI/testing/sysfs-bus-iio-timer-stm32
>>>> new file mode 100644
>>>> index 0000000..26583dd
>>>> --- /dev/null
>>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>>>> @@ -0,0 +1,55 @@
>>>> +What:                /sys/bus/iio/devices/iio:deviceX/master_mode_ava=
ilable
>>>> +KernelVersion:       4.10
>>>> +Contact:     benjamin.gaignard@st.com
>>>> +Description:
>>>> +             Reading returns the list possible master modes which are=
:
>>>> +             - "reset"     : The UG bit from the TIMx_EGR register is=
 used as trigger output (TRGO).
>>>> +             - "enable"    : The Counter Enable signal CNT_EN is used=
 as trigger output.
>>>> +             - "update"    : The update event is selected as trigger =
output.
>>>> +                             For instance a master timer can then be =
used as a prescaler for a slave timer.
>>>> +             - "compare_pulse" : The trigger output send a positive p=
ulse when the CC1IF flag is to be set.
>>>> +             - "OC1REF"    : OC1REF signal is used as trigger output.
>>>> +             - "OC2REF"    : OC2REF signal is used as trigger output.
>>>> +             - "OC3REF"    : OC3REF signal is used as trigger output.
>>>> +             - "OC4REF"    : OC4REF signal is used as trigger output.
>>>> +
>>>> +What:                /sys/bus/iio/devices/iio:deviceX/master_mode
>>>> +KernelVersion:       4.10
>>>> +Contact:     benjamin.gaignard@st.com
>>>> +Description:
>>>> +             Reading returns the current master modes.
>>>> +             Writing set the master mode
>>>> +
>>>> +What:                /sys/bus/iio/devices/iio:deviceX/slave_mode_avai=
lable
>>>> +KernelVersion:       4.10
>>>> +Contact:     benjamin.gaignard@st.com
>>>> +Description:
>>>> +             Reading returns the list possible slave modes which are:
>>>> +             - "disabled"  : The prescaler is clocked directly by the=
 internal clock.
>>>> +             - "encoder_1" : Counter counts up/down on TI2FP1 edge de=
pending on TI1FP2 level.
>>>> +             - "encoder_2" : Counter counts up/down on TI1FP2 edge de=
pending on TI2FP1 level.
>>>> +             - "encoder_3" : Counter counts up/down on both TI1FP1 an=
d TI2FP2 edges depending
>>>> +                             on the level of the other input.
>>>> +             - "reset"     : Rising edge of the selected trigger inpu=
t reinitializes the counter
>>>> +                             and generates an update of the registers=
.
>>>> +             - "gated"     : The counter clock is enabled when the tr=
igger input is high.
>>>> +                             The counter stops (but is not reset) as =
soon as the trigger becomes low.
>>>> +                             Both start and stop of the counter are c=
ontrolled.
>>>> +             - "trigger"   : The counter starts at a rising edge of t=
he trigger TRGI (but it is not
>>>> +                             reset). Only the start of the counter is=
 controlled.
>>>> +             - "external_clock": Rising edges of the selected trigger=
 (TRGI) clock the counter.
>>>> +
>>>> +What:                /sys/bus/iio/devices/iio:deviceX/slave_mode
>>>> +KernelVersion:       4.10
>>>> +Contact:     benjamin.gaignard@st.com
>>>> +Description:
>>>> +             Reading returns the current slave mode.
>>>> +             Writing set the slave mode
>>>> +
>>>> +What:                /sys/bus/iio/devices/triggerX/sampling_frequency
>>>> +KernelVersion:       4.10
>>>> +Contact:     benjamin.gaignard@st.com
>>>> +Description:
>>>> +             Reading returns the current sampling frequency.
>>>> +             Writing an value different of 0 set and start sampling.
>>>> +             Writing 0 stop sampling.
>>>> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
>>>> index 6743b18..2de2a80 100644
>>>> --- a/drivers/iio/Kconfig
>>>> +++ b/drivers/iio/Kconfig
>>>> @@ -90,5 +90,5 @@ source "drivers/iio/potentiometer/Kconfig"
>>>>  source "drivers/iio/pressure/Kconfig"
>>>>  source "drivers/iio/proximity/Kconfig"
>>>>  source "drivers/iio/temperature/Kconfig"
>>>> -
>>>> +source "drivers/iio/timer/Kconfig"
>>>>  endif # IIO
>>>> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
>>>> index 87e4c43..b797c08 100644
>>>> --- a/drivers/iio/Makefile
>>>> +++ b/drivers/iio/Makefile
>>>> @@ -32,4 +32,5 @@ obj-y +=3D potentiometer/
>>>>  obj-y +=3D pressure/
>>>>  obj-y +=3D proximity/
>>>>  obj-y +=3D temperature/
>>>> +obj-y +=3D timer/
>>>>  obj-y +=3D trigger/
>>>> diff --git a/drivers/iio/timer/Kconfig b/drivers/iio/timer/Kconfig
>>>> new file mode 100644
>>>> index 0000000..e3c21f2
>>>> --- /dev/null
>>>> +++ b/drivers/iio/timer/Kconfig
>>>> @@ -0,0 +1,13 @@
>>>> +#
>>>> +# Timers drivers
>>>> +
>>>> +menu "Timers"
>>>> +
>>>> +config IIO_STM32_TIMER_TRIGGER
>>>> +     tristate "STM32 Timer Trigger"
>>>> +     depends on (ARCH_STM32 && OF && MFD_STM32_TIMERS) || COMPILE_TES=
T
>>>> +     select IIO_TRIGGERED_EVENT
>>>> +     help
>>>> +       Select this option to enable STM32 Timer Trigger
>>>> +
>>>> +endmenu
>>>> diff --git a/drivers/iio/timer/Makefile b/drivers/iio/timer/Makefile
>>>> new file mode 100644
>>>> index 0000000..4ad95ec9
>>>> --- /dev/null
>>>> +++ b/drivers/iio/timer/Makefile
>>>> @@ -0,0 +1 @@
>>>> +obj-$(CONFIG_IIO_STM32_TIMER_TRIGGER) +=3D stm32-timer-trigger.o
>>>> diff --git a/drivers/iio/timer/stm32-timer-trigger.c b/drivers/iio/tim=
er/stm32-timer-trigger.c
>>>> new file mode 100644
>>>> index 0000000..8d16e8f
>>>> --- /dev/null
>>>> +++ b/drivers/iio/timer/stm32-timer-trigger.c
>>>> @@ -0,0 +1,466 @@
>>>> +/*
>>>> + * Copyright (C) STMicroelectronics 2016
>>>> + *
>>>> + * Author: Benjamin Gaignard <benjamin.gaignard@st.com>
>>>> + *
>>>> + * License terms:  GNU General Public License (GPL), version 2
>>>> + */
>>>> +
>>>> +#include <linux/iio/iio.h>
>>>> +#include <linux/iio/sysfs.h>
>>>> +#include <linux/iio/timer/stm32-timer-trigger.h>
>>>> +#include <linux/iio/trigger.h>
>>>> +#include <linux/iio/triggered_event.h>
>>>> +#include <linux/interrupt.h>
>>>> +#include <linux/mfd/stm32-timers.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/platform_device.h>
>>>> +
>>>> +#define MAX_TRIGGERS 6
>>>> +#define MAX_VALIDS 5
>>>> +
>>>> +/* List the triggers created by each timer */
>>>> +static const void *triggers_table[][MAX_TRIGGERS] =3D {
>>>> +     { TIM1_TRGO, TIM1_CH1, TIM1_CH2, TIM1_CH3, TIM1_CH4,},
>>>> +     { TIM2_TRGO, TIM2_CH1, TIM2_CH2, TIM2_CH3, TIM2_CH4,},
>>>> +     { TIM3_TRGO, TIM3_CH1, TIM3_CH2, TIM3_CH3, TIM3_CH4,},
>>>> +     { TIM4_TRGO, TIM4_CH1, TIM4_CH2, TIM4_CH3, TIM4_CH4,},
>>>> +     { TIM5_TRGO, TIM5_CH1, TIM5_CH2, TIM5_CH3, TIM5_CH4,},
>>>> +     { TIM6_TRGO,},
>>>> +     { TIM7_TRGO,},
>>>> +     { TIM8_TRGO, TIM8_CH1, TIM8_CH2, TIM8_CH3, TIM8_CH4,},
>>>> +     { TIM9_TRGO, TIM9_CH1, TIM9_CH2,},
>>>> +     { TIM12_TRGO, TIM12_CH1, TIM12_CH2,},
>>>> +};
>>>> +
>>>> +/* List the triggers accepted by each timer */
>>>> +static const void *valids_table[][MAX_VALIDS] =3D {
>>>> +     { TIM5_TRGO, TIM2_TRGO, TIM4_TRGO, TIM3_TRGO,},
>>>> +     { TIM1_TRGO, TIM8_TRGO, TIM3_TRGO, TIM4_TRGO,},
>>>> +     { TIM1_TRGO, TIM8_TRGO, TIM5_TRGO, TIM4_TRGO,},
>>>> +     { TIM1_TRGO, TIM2_TRGO, TIM3_TRGO, TIM8_TRGO,},
>>>> +     { TIM2_TRGO, TIM3_TRGO, TIM4_TRGO, TIM8_TRGO,},
>>>> +     { }, /* timer 6 */
>>>> +     { }, /* timer 7 */
>>>> +     { TIM1_TRGO, TIM2_TRGO, TIM4_TRGO, TIM5_TRGO,},
>>>> +     { TIM2_TRGO, TIM3_TRGO,},
>>>> +     { TIM4_TRGO, TIM5_TRGO,},
>>>> +};
>>>> +
>>>> +struct stm32_timer_trigger {
>>>> +     struct device *dev;
>>>> +     struct regmap *regmap;
>>>> +     struct clk *clk;
>>>> +     u32 max_arr;
>>>> +     const void *triggers;
>>>> +     const void *valids;
>>>> +};
>>>> +
>>>> +static int stm32_timer_start(struct stm32_timer_trigger *priv,
>>>> +                          unsigned int frequency)
>>>> +{
>>>> +     unsigned long long prd, div;
>>>> +     int prescaler =3D 0;
>>>> +     u32 ccer, cr1;
>>>> +
>>>> +     /* Period and prescaler values depends of clock rate */
>>>> +     div =3D (unsigned long long)clk_get_rate(priv->clk);
>>>> +
>>>> +     do_div(div, frequency);
>>>> +
>>>> +     prd =3D div;
>>>> +
>>>> +     /*
>>>> +      * Increase prescaler value until we get a result that fit
>>>> +      * with auto reload register maximum value.
>>>> +      */
>>>> +     while (div > priv->max_arr) {
>>>> +             prescaler++;
>>>> +             div =3D prd;
>>>> +             do_div(div, (prescaler + 1));
>>>> +     }
>>>> +     prd =3D div;
>>>> +
>>>> +     if (prescaler > MAX_TIM_PSC) {
>>>> +             dev_err(priv->dev, "prescaler exceeds the maximum value\=
n");
>>>> +             return -EINVAL;
>>>> +     }
>>>> +
>>>> +     /* Check if nobody else use the timer */
>>>> +     regmap_read(priv->regmap, TIM_CCER, &ccer);
>>>> +     if (ccer & TIM_CCER_CCXE)
>>>> +             return -EBUSY;
>>>> +
>>>> +     regmap_read(priv->regmap, TIM_CR1, &cr1);
>>>> +     if (!(cr1 & TIM_CR1_CEN))
>>>> +             clk_enable(priv->clk);
>>>> +
>>>> +     regmap_write(priv->regmap, TIM_PSC, prescaler);
>>>> +     regmap_write(priv->regmap, TIM_ARR, prd - 1);
>>>> +     regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, TIM_CR1_=
ARPE);
>>>> +
>>>> +     /* Force master mode to update mode */
>>>> +     regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS, 0x20);
>>>> +
>>>> +     /* Make sure that registers are updated */
>>>> +     regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG=
);
>>>> +
>>>> +     /* Enable controller */
>>>> +     regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, TIM_CR1_C=
EN);
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static void stm32_timer_stop(struct stm32_timer_trigger *priv)
>>>> +{
>>>> +     u32 ccer, cr1;
>>>> +
>>>> +     regmap_read(priv->regmap, TIM_CCER, &ccer);
>>>> +     if (ccer & TIM_CCER_CCXE)
>>>> +             return;
>>>> +
>>>> +     regmap_read(priv->regmap, TIM_CR1, &cr1);
>>>> +     if (cr1 & TIM_CR1_CEN)
>>>> +             clk_disable(priv->clk);
>>>> +
>>>> +     /* Stop timer */
>>>> +     regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
>>>> +     regmap_write(priv->regmap, TIM_PSC, 0);
>>>> +     regmap_write(priv->regmap, TIM_ARR, 0);
>>>> +}
>>>> +
>>>> +static ssize_t stm32_tt_store_frequency(struct device *dev,
>>>> +                                     struct device_attribute *attr,
>>>> +                                     const char *buf, size_t len)
>>>> +{
>>>> +     struct iio_trigger *trig =3D to_iio_trigger(dev);
>>>> +     struct stm32_timer_trigger *priv =3D iio_trigger_get_drvdata(tri=
g);
>>>> +     unsigned int freq;
>>>> +     int ret;
>>>> +
>>>> +     ret =3D kstrtouint(buf, 10, &freq);
>>>> +     if (ret)
>>>> +             return ret;
>>>> +
>>>> +     if (freq =3D=3D 0) {
>>>> +             stm32_timer_stop(priv);
>>>> +     } else {
>>>> +             ret =3D stm32_timer_start(priv, freq);
>>>> +             if (ret)
>>>> +                     return ret;
>>>> +     }
>>>> +
>>>> +     return len;
>>>> +}
>>>> +
>>>> +static ssize_t stm32_tt_read_frequency(struct device *dev,
>>>> +                                    struct device_attribute *attr, ch=
ar *buf)
>>>> +{
>>>> +     struct iio_trigger *trig =3D to_iio_trigger(dev);
>>>> +     struct stm32_timer_trigger *priv =3D iio_trigger_get_drvdata(tri=
g);
>>>> +     u32 psc, arr, cr1;
>>>> +     unsigned long long freq =3D 0;
>>>> +
>>>> +     regmap_read(priv->regmap, TIM_CR1, &cr1);
>>>> +     regmap_read(priv->regmap, TIM_PSC, &psc);
>>>> +     regmap_read(priv->regmap, TIM_ARR, &arr);
>>>> +
>>>> +     if (psc && arr && (cr1 & TIM_CR1_CEN)) {
>>>> +             freq =3D (unsigned long long)clk_get_rate(priv->clk);
>>>> +             do_div(freq, psc);
>>>> +             do_div(freq, arr);
>>>> +     }
>>>> +
>>>> +     return sprintf(buf, "%d\n", (unsigned int)freq);
>>>> +}
>>>> +
>>>> +static IIO_DEV_ATTR_SAMP_FREQ(0660,
>>>> +                           stm32_tt_read_frequency,
>>>> +                           stm32_tt_store_frequency);
>>>> +
>>>> +static struct attribute *stm32_trigger_attrs[] =3D {
>>>> +     &iio_dev_attr_sampling_frequency.dev_attr.attr,
>>>> +     NULL,
>>>> +};
>>>> +
>>>> +static const struct attribute_group stm32_trigger_attr_group =3D {
>>>> +     .attrs =3D stm32_trigger_attrs,
>>>> +};
>>>> +
>>>> +static const struct attribute_group *stm32_trigger_attr_groups[] =3D =
{
>>>> +     &stm32_trigger_attr_group,
>>>> +     NULL,
>>>> +};
>>>> +
>>>> +static char *master_mode_table[] =3D {
>>>> +     "reset",
>>>> +     "enable",
>>>> +     "update",
>>>> +     "compare_pulse",
>>>> +     "OC1REF",
>>>> +     "OC2REF",
>>>> +     "OC3REF",
>>>> +     "OC4REF"
>>>> +};
>>>> +
>>>> +static ssize_t stm32_tt_show_master_mode(struct device *dev,
>>>> +                                      struct device_attribute *attr,
>>>> +                                      char *buf)
>>>> +{
>>>> +     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
>>>> +     struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
>>>> +     u32 cr2;
>>>> +
>>>> +     regmap_read(priv->regmap, TIM_CR2, &cr2);
>>>> +     cr2 =3D (cr2 & TIM_CR2_MMS) >> TIM_CR2_MMS_SHIFT;
>>>> +
>>>> +     return snprintf(buf, PAGE_SIZE, "%s\n", master_mode_table[cr2]);
>>>> +}
>>>> +
>>>> +static ssize_t stm32_tt_store_master_mode(struct device *dev,
>>>> +                                       struct device_attribute *attr,
>>>> +                                       const char *buf, size_t len)
>>>> +{
>>>> +     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
>>>> +     struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
>>>> +     int i;
>>>> +
>>>> +     for (i =3D 0; i < ARRAY_SIZE(master_mode_table); i++) {
>>>> +             if (!strncmp(master_mode_table[i], buf,
>>>> +                          strlen(master_mode_table[i]))) {
>>>> +                     regmap_update_bits(priv->regmap, TIM_CR2,
>>>> +                                        TIM_CR2_MMS, i << TIM_CR2_MMS=
_SHIFT);
>>>> +                     return len;
>>>> +             }
>>>> +     }
>>>> +
>>>> +     return -EINVAL;
>>>> +}
>>>> +
>>>> +static IIO_CONST_ATTR(master_mode_available,
>>>> +     "reset enable update compare_pulse OC1REF OC2REF OC3REF OC4REF")=
;
>>>> +
>>>> +static IIO_DEVICE_ATTR(master_mode, 0660,
>>>> +                    stm32_tt_show_master_mode,
>>>> +                    stm32_tt_store_master_mode,
>>>> +                    0);
>>>> +
>>>> +static char *slave_mode_table[] =3D {
>>>> +     "disabled",
>>>> +     "encoder_1",
>>>> +     "encoder_2",
>>>> +     "encoder_3",
>>>> +     "reset",
>>>> +     "gated",
>>>> +     "trigger",
>>>> +     "external_clock",
>>>> +};
>>>> +
>>>> +static ssize_t stm32_tt_show_slave_mode(struct device *dev,
>>>> +                                     struct device_attribute *attr,
>>>> +                                     char *buf)
>>>> +{
>>>> +     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
>>>> +     struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
>>>> +     u32 smcr;
>>>> +
>>>> +     regmap_read(priv->regmap, TIM_SMCR, &smcr);
>>>> +     smcr &=3D TIM_SMCR_SMS;
>>>> +
>>>> +     return snprintf(buf, PAGE_SIZE, "%s\n", slave_mode_table[smcr]);
>>>> +}
>>>> +
>>>> +static ssize_t stm32_tt_store_slave_mode(struct device *dev,
>>>> +                                      struct device_attribute *attr,
>>>> +                                      const char *buf, size_t len)
>>>> +{
>>>> +     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
>>>> +     struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
>>>> +     int i;
>>>> +
>>>> +     for (i =3D 0; i < ARRAY_SIZE(slave_mode_table); i++) {
>>>> +             if (!strncmp(slave_mode_table[i], buf,
>>>> +                          strlen(slave_mode_table[i]))) {
>>>> +                     regmap_update_bits(priv->regmap,
>>>> +                                        TIM_SMCR, TIM_SMCR_SMS, i);
>>>> +                     return len;
>>>> +             }
>>>> +     }
>>>> +
>>>> +     return -EINVAL;
>>>> +}
>>>> +
>>>> +static IIO_CONST_ATTR(slave_mode_available,
>>>> +"disabled encoder_1 encoder_2 encoder_3 reset gated trigger external_=
clock");
>>>> +
>>>> +static IIO_DEVICE_ATTR(slave_mode, 0660,
>>>> +                    stm32_tt_show_slave_mode,
>>>> +                    stm32_tt_store_slave_mode,
>>>> +                    0);
>>>> +
>>>> +static struct attribute *stm32_timer_attrs[] =3D {
>>>> +     &iio_dev_attr_master_mode.dev_attr.attr,
>>>> +     &iio_const_attr_master_mode_available.dev_attr.attr,
>>>> +     &iio_dev_attr_slave_mode.dev_attr.attr,
>>>> +     &iio_const_attr_slave_mode_available.dev_attr.attr,
>>>> +     NULL,
>>>> +};
>>>> +
>>>> +static const struct attribute_group stm32_timer_attr_group =3D {
>>>> +     .attrs =3D stm32_timer_attrs,
>>>> +};
>>>> +
>>>> +static const struct iio_trigger_ops timer_trigger_ops =3D {
>>>> +     .owner =3D THIS_MODULE,
>>>> +};
>>>> +
>>>> +static int stm32_setup_iio_triggers(struct stm32_timer_trigger *priv)
>>>> +{
>>>> +     int ret;
>>>> +     const char * const *cur =3D priv->triggers;
>>>> +
>>>> +     while (cur && *cur) {
>>>> +             struct iio_trigger *trig;
>>>> +
>>>> +             trig =3D devm_iio_trigger_alloc(priv->dev, "%s", *cur);
>>>> +             if  (!trig)
>>>> +                     return -ENOMEM;
>>>> +
>>>> +             trig->dev.parent =3D priv->dev->parent;
>>>> +             trig->ops =3D &timer_trigger_ops;
>>>> +             trig->dev.groups =3D stm32_trigger_attr_groups;
>>>> +             iio_trigger_set_drvdata(trig, priv);
>>>> +
>>>> +             ret =3D devm_iio_trigger_register(priv->dev, trig);
>>>> +             if (ret)
>>>> +                     return ret;
>>>> +             cur++;
>>>> +     }
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +/**
>>>> + * is_stm32_timer_trigger
>>>> + * @trig: trigger to be checked
>>>> + *
>>>> + * return true if the trigger is a valid stm32 iio timer trigger
>>>> + * either return false
>>>> + */
>>>> +bool is_stm32_timer_trigger(struct iio_trigger *trig)
>>>> +{
>>>> +     return (trig->ops =3D=3D &timer_trigger_ops);
>>>> +}
>>>> +EXPORT_SYMBOL(is_stm32_timer_trigger);
>>>> +
>>>> +static int stm32_validate_trigger(struct iio_dev *indio_dev,
>>>> +                               struct iio_trigger *trig)
>>>> +{
>>>> +     struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
>>>> +     const char * const *cur =3D priv->valids;
>>>> +     unsigned int i =3D 0;
>>>> +
>>>> +     if (!is_stm32_timer_trigger(trig))
>>>> +             return -EINVAL;
>>>> +
>>>> +     while (cur && *cur) {
>>>> +             if (!strncmp(trig->name, *cur, strlen(trig->name))) {
>>>> +                     regmap_update_bits(priv->regmap,
>>>> +                                        TIM_SMCR, TIM_SMCR_TS,
>>>> +                                        i << TIM_SMCR_TS_SHIFT);
>>>> +                     return 0;
>>>> +             }
>>>> +             cur++;
>>>> +             i++;
>>>> +     }
>>>> +
>>>> +     return -EINVAL;
>>>> +}
>>>> +
>>>> +static const struct iio_info stm32_trigger_info =3D {
>>>> +     .driver_module =3D THIS_MODULE,
>>>> +     .validate_trigger =3D stm32_validate_trigger,
>>>> +     .attrs =3D &stm32_timer_attr_group,
>>>> +};
>>>> +
>>>> +static struct stm32_timer_trigger *stm32_setup_iio_device(struct devi=
ce *dev)
>>>> +{
>>>> +     struct iio_dev *indio_dev;
>>>> +     int ret;
>>>> +
>>>> +     indio_dev =3D devm_iio_device_alloc(dev,
>>>> +                                       sizeof(struct stm32_timer_trig=
ger));
>>>> +     if (!indio_dev)
>>>> +             return NULL;
>>>> +
>>>> +     indio_dev->name =3D dev_name(dev);
>>>> +     indio_dev->dev.parent =3D dev;
>>>> +     indio_dev->info =3D &stm32_trigger_info;
>>>> +     indio_dev->modes =3D INDIO_EVENT_TRIGGERED;
>>>> +     indio_dev->num_channels =3D 0;
>>>> +     indio_dev->dev.of_node =3D dev->of_node;
>>>> +
>>>> +     ret =3D devm_iio_device_register(dev, indio_dev);
>>>> +     if (ret)
>>>> +             return NULL;
>>>> +
>>>> +     return iio_priv(indio_dev);
>>>> +}
>>>> +
>>>> +static int stm32_timer_trigger_probe(struct platform_device *pdev)
>>>> +{
>>>> +     struct device *dev =3D &pdev->dev;
>>>> +     struct stm32_timer_trigger *priv;
>>>> +     struct stm32_timers *ddata =3D dev_get_drvdata(pdev->dev.parent)=
;
>>>> +     unsigned int index;
>>>> +     int ret;
>>>> +
>>>> +     if (of_property_read_u32(dev->of_node, "reg", &index))
>>>> +             return -EINVAL;
>>>> +
>>>> +     if (index >=3D ARRAY_SIZE(triggers_table))
>>>> +             return -EINVAL;
>>>> +
>>>> +     /* Create an IIO device only if we have triggers to be validated=
 */
>>>> +     if (*valids_table[index])
>>>> +             priv =3D stm32_setup_iio_device(dev);
>>>
>>> I still don't like this. Really feels like we shouldn't be creating an
>>> iio device with all the bagage that carries just to allow us to do the
>>> trigger trees.  We ought to have a much more light weight solution for =
this
>>> functionality - we aren't typically even using the interrupt tree stuff
>>> that the triggers for devices are all really about.
>>>
>>> A simpler approach of allowing each trigger the option of a parent seem=
s like
>>> it would be cleaner.  Could be done entirely within this driver in the =
first
>>> instance.  Basically it would just look like your master and slave attr=
ibutes
>>> but have those under triggerX not iio:deviceX.
>>>
>>> We can work out how to make it more generic later - including perhaps t=
he
>>> option to trigger from triggers outside this driver, using some paralle=
l
>>> infrastructure to the device triggering.
>>>
>>>
>>>> +     else
>>>> +             priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>>> +
>>>> +     if (!priv)
>>>> +             return -ENOMEM;
>>>> +
>>>> +     priv->dev =3D dev;
>>>> +     priv->regmap =3D ddata->regmap;
>>>> +     priv->clk =3D ddata->clk;
>>>> +     priv->max_arr =3D ddata->max_arr;
>>>> +     priv->triggers =3D triggers_table[index];
>>>> +     priv->valids =3D valids_table[index];
>>>> +
>>>> +     ret =3D stm32_setup_iio_triggers(priv);
>>>> +     if (ret)
>>>> +             return ret;
>>>> +
>>>> +     platform_set_drvdata(pdev, priv);
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static const struct of_device_id stm32_trig_of_match[] =3D {
>>>> +     { .compatible =3D "st,stm32-timer-trigger", },
>>>> +     { /* end node */ },
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, stm32_trig_of_match);
>>>> +
>>>> +static struct platform_driver stm32_timer_trigger_driver =3D {
>>>> +     .probe =3D stm32_timer_trigger_probe,
>>>> +     .driver =3D {
>>>> +             .name =3D "stm32-timer-trigger",
>>>> +             .of_match_table =3D stm32_trig_of_match,
>>>> +     },
>>>> +};
>>>> +module_platform_driver(stm32_timer_trigger_driver);
>>>> +
>>>> +MODULE_ALIAS("platform: stm32-timer-trigger");
>>>> +MODULE_DESCRIPTION("STMicroelectronics STM32 Timer Trigger driver");
>>>> +MODULE_LICENSE("GPL v2");
>>>> diff --git a/drivers/iio/trigger/Kconfig b/drivers/iio/trigger/Kconfig
>>>> index 809b2e7..f2af4fe 100644
>>>> --- a/drivers/iio/trigger/Kconfig
>>>> +++ b/drivers/iio/trigger/Kconfig
>>>> @@ -46,5 +46,4 @@ config IIO_SYSFS_TRIGGER
>>>>
>>>>         To compile this driver as a module, choose M here: the
>>>>         module will be called iio-trig-sysfs.
>>>> -
>>> Clean this up.
>>
>> ok
>>
>>>>  endmenu
>>>> diff --git a/include/linux/iio/timer/stm32-timer-trigger.h b/include/l=
inux/iio/timer/stm32-timer-trigger.h
>>>> new file mode 100644
>>>> index 0000000..55535ae
>>>> --- /dev/null
>>>> +++ b/include/linux/iio/timer/stm32-timer-trigger.h
>>>> @@ -0,0 +1,62 @@
>>>> +/*
>>>> + * Copyright (C) STMicroelectronics 2016
>>>> + *
>>>> + * Author: Benjamin Gaignard <benjamin.gaignard@st.com>
>>>> + *
>>>> + * License terms:  GNU General Public License (GPL), version 2
>>>> + */
>>>> +
>>>> +#ifndef _STM32_TIMER_TRIGGER_H_
>>>> +#define _STM32_TIMER_TRIGGER_H_
>>>> +
>>>> +#define TIM1_TRGO    "tim1_trgo"
>>>> +#define TIM1_CH1     "tim1_ch1"
>>>> +#define TIM1_CH2     "tim1_ch2"
>>>> +#define TIM1_CH3     "tim1_ch3"
>>>> +#define TIM1_CH4     "tim1_ch4"
>>>> +
>>>> +#define TIM2_TRGO    "tim2_trgo"
>>>> +#define TIM2_CH1     "tim2_ch1"
>>>> +#define TIM2_CH2     "tim2_ch2"
>>>> +#define TIM2_CH3     "tim2_ch3"
>>>> +#define TIM2_CH4     "tim2_ch4"
>>>> +
>>>> +#define TIM3_TRGO    "tim3_trgo"
>>>> +#define TIM3_CH1     "tim3_ch1"
>>>> +#define TIM3_CH2     "tim3_ch2"
>>>> +#define TIM3_CH3     "tim3_ch3"
>>>> +#define TIM3_CH4     "tim3_ch4"
>>>> +
>>>> +#define TIM4_TRGO    "tim4_trgo"
>>>> +#define TIM4_CH1     "tim4_ch1"
>>>> +#define TIM4_CH2     "tim4_ch2"
>>>> +#define TIM4_CH3     "tim4_ch3"
>>>> +#define TIM4_CH4     "tim4_ch4"
>>>> +
>>>> +#define TIM5_TRGO    "tim5_trgo"
>>>> +#define TIM5_CH1     "tim5_ch1"
>>>> +#define TIM5_CH2     "tim5_ch2"
>>>> +#define TIM5_CH3     "tim5_ch3"
>>>> +#define TIM5_CH4     "tim5_ch4"
>>>> +
>>>> +#define TIM6_TRGO    "tim6_trgo"
>>>> +
>>>> +#define TIM7_TRGO    "tim7_trgo"
>>>> +
>>>> +#define TIM8_TRGO    "tim8_trgo"
>>>> +#define TIM8_CH1     "tim8_ch1"
>>>> +#define TIM8_CH2     "tim8_ch2"
>>>> +#define TIM8_CH3     "tim8_ch3"
>>>> +#define TIM8_CH4     "tim8_ch4"
>>>> +
>>>> +#define TIM9_TRGO    "tim9_trgo"
>>>> +#define TIM9_CH1     "tim9_ch1"
>>>> +#define TIM9_CH2     "tim9_ch2"
>>>> +
>>>> +#define TIM12_TRGO   "tim12_trgo"
>>>> +#define TIM12_CH1    "tim12_ch1"
>>>> +#define TIM12_CH2    "tim12_ch2"
>>>> +
>>>> +bool is_stm32_timer_trigger(struct iio_trigger *trig);
>>>> +
>>>> +#endif
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
