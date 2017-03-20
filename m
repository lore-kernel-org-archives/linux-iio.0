Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33469 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753509AbdCTN2M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Mar 2017 09:28:12 -0400
Date: Mon, 20 Mar 2017 09:25:31 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v1 2/2] iio: stm32 trigger: Add counter device
Message-ID: <20170320132531.GA12537@sophia>
References: <1488379506-23969-1-git-send-email-benjamin.gaignard@st.com>
 <1488379506-23969-3-git-send-email-benjamin.gaignard@st.com>
 <8e51243a-7371-37f0-6c62-53e7950dd85a@kernel.org>
 <CA+M3ks4BsrRWMOHQ4rVLB1VZxQQVyLt8JyUTkyp5WH1m1D4PnA@mail.gmail.com>
 <20170314185327.GA32092@sophia>
 <CA+M3ks7AGDCK+6kdsU3zJcEwqhF5rQMcOsRogCYPpFQ9o7kU_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CA+M3ks7AGDCK+6kdsU3zJcEwqhF5rQMcOsRogCYPpFQ9o7kU_g@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Mar 17, 2017 at 03:36:05PM +0100, Benjamin Gaignard wrote:
>2017-03-14 19:53 GMT+01:00 William Breathitt Gray <vilhelm.gray@gmail.com>:
>> On Sun, Mar 12, 2017 at 02:18:47PM +0100, Benjamin Gaignard wrote:
>>>2017-03-05 13:04 GMT+01:00 Jonathan Cameron <jic23@kernel.org>:
>>>> On 01/03/17 14:45, Benjamin Gaignard wrote:
>>>>> One of the features of STM32 trigger hardware block is a counter
>>>>> that can counts up/down depending of the levels and edges of the
>>>>> selected external pins.
>>>>>
>>>>> This patch allow to read/write the counter, get the direction and
>>>>> set the preset value.
>>>>> When counting up preset value is the limit of the counter.
>>>>> When counting down the counter start from preset value down to 0.
>>>>>
>>>>> The hardware have multiple way to use inputs edges and levels to
>>>>> performing counting, those different modes are exposed in:
>>>>> /sys/bus/iio/devices/iio:deviceX/in_count_count_mode_available
>>>>> and documented in Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>>>>>
>>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>>>> This is rapidly turning into a driver for soemthing other than a trigger,
>>>> but I suppose that doesn't matter to much.  We may just want to
>>>> move it at some stage...
>>>
>>>Yes It could be put into counter directory.
>>>
>>>>
>>>> The primary issues in here are still around the ABI for counter-mode
>>>> It's combining a load of generic concepts and forcing them all into
>>>> one attribute.  That never generalises well so we need to break these
>>>> up before moving futher with this one.
>>>
>>>I'm adding William in this thread since he has wrote 104-quad-8 driver.
>>>William may you help us to make this ABI more generic ?
>>>
>>>>
>>>> Few other bits inline.
>>>>
>>>> Jonathan
>>>>> ---
>>>>>  .../ABI/testing/sysfs-bus-iio-timer-stm32          |  40 ++++
>>>>>  drivers/iio/trigger/stm32-timer-trigger.c          | 231 ++++++++++++++++++++-
>>>>>  include/linux/mfd/stm32-timers.h                   |   2 +
>>>>>  3 files changed, 267 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>>>>> index 6534a60..17933ef 100644
>>>>> --- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>>>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>>>>> @@ -27,3 +27,43 @@ Description:
>>>>>               Reading returns the current sampling frequency.
>>>>>               Writing an value different of 0 set and start sampling.
>>>>>               Writing 0 stop sampling.
>>>>> +
>>>>> +What:                /sys/bus/iio/devices/iio:deviceX/in_count_count_mode_available
>>>>> +KernelVersion:       4.12
>>>>> +Contact:     benjamin.gaignard@st.com
>>>>> +Description:
>>>>> +             Reading returns the list of possible counting modes which are:
>>>>> +             - "internal_clock": Counter is clocked by the internal clock rising edges.
>>>> As we are describing this now as a hardware counter, perhaps this first one should be
>>>> something like
>>>> pseudo encoder, or simulated encoder to represent it's use as a way of providing encoder
>>>> like counting when we don't have an encoder.
>>>
>>>It is more a counter than an encoder here, I would like to keep "count
>>>mode" or "count control" for this.
>>>
>>>>
>>>>> +             - "encoder_1" : Counter is clocked by the rising edges of external pin 2 and the counter
>>>>> +                             direction depend of the level of external pin 1.
>>>>> +             - "encoder_2" : Counter is clocked by the rising edges of external pin 1 and the counter
>>>>> +                             direction depend of the level of external pin 2.
>>>>> +             - "encoder_3" : Counter counts up/down on channels 1 & 2 edge depending on channel 1 & 2 level.
>>>>> +                             Counter is clocked by the rising edges of external pins 1 & 2,
>>>>> +                             the counter direction is depend of the levels of external pin 1 & 2.
>>>> We absolutely need to figure out a generic name for these modes.  They are standard ways of handling an encoder
>>>> so it should be possible to come up with something.
>>>
>>>I can add them into a "quaduature mode" attribute:
>>>- channel_A
>>>- channel_B
>>>- 2x_speed
>>>
>>>For what I read it is generic way to describe encoder way of working.
>>>http://www.dynapar.com/Technology/Encoder_Basics/Quadrature_Encoder/
>>>An other mode could 4x_speed but it isn't supported by my hardware.
>>>
>>>>
>>>>> +             - "reset"     : Rising edges on pin 1 reinitializes the counter value to preset value.
>>>>> +             - "gated"     : Counter counts when external pin level is high.
>>>>> +                             Counter stops (but is not reset) as soon as external pin becomes low.
>>>>> +             - "trigger"   : Counter starts at a rising edge of the external pin (but it is not reset).
>>>> We still have the same issue here.  These are totally different concepts.
>>>> To drive towards a generic interface we need to split this up.
>>>>
>>>> What clock are the last 3 using?  Not clear from the description currently.
>>>
>>>The clock is the internal clock (like for the first one) so I think I
>>>can merge them into a single
>>>attribute.
>>>
>>>>
>>>> Right now it represents the hardware of this one device, not generic concepts which is where
>>>> we need to be.
>>
>> Hi Benjamin,
>>
>> I believe some of modes you are using for your count_mode attribute
>> would be more apt in a quadrature_mode attribute. I created the
>> count_mode attribute to provide a way to control how the counter value
>> itself is updated (whether the value rolls over back to zero, whether it
>> hits a value ceiling, etc.). However, your count_mode modes seem more
>> about how the input pins should be interpreted by the encoder hardware
>> -- which is why I recommend the quadrature_mode attribute.
>>
>> In particular, the "encoder_1" and "encoder_2" modes are akin to the
>> 104-QUAD-8 quadrature_mode "Non-quadrature" mode (albeit with the
>> ability to select which pin is clock and which is direction; similarly,
>> "internal_clock" is simply just "Non-quadrature" with a fixed clock and
>> fixed "up" direction, while "gated" is the same as "internal_clock" but
>> with the fixed clock gated by an external pin.
>>
>> In the 104-QUAD-8, I used the scale attribute to select the encoder
>> phase division. I would say the "encoder_3" mode is akin to the
>> 104-QUAD-8 "Quadrature" quadrature_mode mode with a scale set to "1" if
>> I understood your description correctly. Quadrature encoder modes are
>> pretty standard across devices: most quadrature encoders feature a x1,
>> x2, and x4 configuration. In the 104-QUAD-8, I used the scale attribute
>> to represent the specific quadrature configuration: quadrature x1 = "1"
>> scale, quadrature x2 = "0.5" scale, and quadrature x4 = "0.25" scale.
>>
>> So in summary, I'd recommend moving "internal_clock," "gated,"
>> "encoder_1," "encoder_2," and "encoder_3," to a quadrature_mode
>> attribute, and rename them to something along the lines of
>> "internal_clock," "internal_clock_gated," "channel_A," "channel_B," and
>> "quadrature" (with scale attribute set for encoder phase division)
>> respectively.
>
>That sound good for me. I will add a quadrature_mode attribute instead
>of count mode.
>Have double check in my hardware documentation for quadrature mode
>all edge of the both channels are always used so I guess I will hardcode
>scale to 0.25.

That's correct, if both rising and falling edges on both channels are
interpreted, 0.25 would be the proper scale value for your quadrature
mode.

>
>>
>> Now then, we're left with the "reset" mode and "trigger" mode. These two
>> modes are akin to similar functionality in the 104-QUAD-8 and I suspect
>> many other encoder/counter devices. The "reset" mode functionality for
>> example is essentially your "internal_clock" mode with the
>> preset-on-index functionality of the 104-QUAD-8., while the "trigger"
>> mode functionality is nothing more than the "internal_clock" mode with a
>> latchable gate.
>>
>> I'm not sure what the best way to implement these remaining two modes
>> would be however (whether to refactor them as "internal_clock" mode with
>> conditional checks for other attributes akin to the 104-QUAD-8
>> set_to_preset_on_index attribute). Perhaps Jonathan, may have some ideas
>> on what would be a good path forward here for these two modes; I suspect
>> refactoring the 104-QUAD-8 set_to_preset_on_index to a generic IIO
>> attribute may be useful as it is possible many devices have some sort of
>> triggered preset functionality.
>
>maybe "internal_clock_gated" could also be a combinaison of "internal_clock"
>+ a clock attribute like: always, gated, reset, triggered ?

I like this idea very much. However, we should give this attribute a
more generic name without explicit reference to "clock" so that it may
be used with other logical signal lines in other devices; I anticipate
refactoring the 104-QUAD-8 set_to_preset_on_index attribute to take
advantage of this new hypothetical attribute if it gets merged in with
this patch.

If I had to specify it, the functionality we are describing is some sort
of "enable mode" for an encoder channel input: whether the channel is
always enabled, conditionally enabled ("gated") based on external pin,
or latch enabled ("triggered") activated on the rising edge (or perhaps
even falling edge or level) of an external pin. For this reason, I
suggest the introduction of a new "encoder_channel_enable_mode"
attribute where these 3 configuration modes may be selected; feel free
to propose a better name for this attribute as naming is not really my
forte. ;)

I would like to move the "reset" mode to its own attribute for now
called "preset_mode" (again with no commitment to this particular
attribute name); this is the attribute to which I would refactor the
existing 104-QUAD-8 set_to_preset_on_index. For the STM32, I envision
two possible modes for this attribute: "disabled" and "internal_clock."
In the future, I imagine devices with preset functionality triggered by
selectable inputs -- e.g. an internal clock, an external pin, a timer
countdown, etc.

William Breathitt Gray

>
>> William Breathitt Gray
>>
>>>>
>>>>
>>>>> +
>>>>> +             Encoder modes are used to automatically handle the counting direction of the internal counter.
>>>>> +             Those modes are typically used for high-accuracy rotor position sensing in electrical motors
>>>>> +             or for digital potentiometers. From the two outputs of a quadrature encoder sensor the timer
>>>>> +             extracts a clock on each and every active edge and adjusts the counting direction depending on
>>>>> +             the relative phase-shift between the two incomings signals. The timer counter thus directly
>>>>> +             holds the angular position of the motor.
>>>>> +
>>>>> +What:                /sys/bus/iio/devices/iio:deviceX/in_count0_count_mode
>>>>> +KernelVersion:       4.12
>>>>> +Contact:     benjamin.gaignard@st.com
>>>>> +Description:
>>>>> +             Reading returns the current counting mode.
>>>>> +
>>>>> +What:                /sys/bus/iio/devices/iio:deviceX/in_count0_preset
>>>>> +KernelVersion:       4.12
>>>>> +Contact:     benjamin.gaignard@st.com
>>>>> +Description:
>>>>> +             Reading returns the current preset value.
>>>>> +             Writing set the preset value.
>>>>> +             When counting up the counter start from 0 and fire an event when reach preset value.
>>>>> +             When counting down the counter start from preset value and fire event when reach 0.
>>>> This is generic, so as with the other attribute you just handled, please make some generic text
>>>> to cover both this and that in the other counter driver and move it up to the generic docs.
>>>>> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
>>>>> index 994b96d..9026265 100644
>>>>> --- a/drivers/iio/trigger/stm32-timer-trigger.c
>>>>> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
>>>>> @@ -15,6 +15,7 @@
>>>>>  #include <linux/platform_device.h>
>>>>>
>>>>>  #define MAX_TRIGGERS 6
>>>>> +#define MAX_VALIDS 5
>>>>>
>>>>>  /* List the triggers created by each timer */
>>>>>  static const void *triggers_table[][MAX_TRIGGERS] = {
>>>>> @@ -32,12 +33,29 @@
>>>>>       { TIM12_TRGO, TIM12_CH1, TIM12_CH2,},
>>>>>  };
>>>>>
>>>>> +/* List the triggers accepted by each timer */
>>>>> +static const void *valids_table[][MAX_VALIDS] = {
>>>>> +     { TIM5_TRGO, TIM2_TRGO, TIM3_TRGO, TIM4_TRGO,},
>>>>> +     { TIM1_TRGO, TIM8_TRGO, TIM3_TRGO, TIM4_TRGO,},
>>>>> +     { TIM1_TRGO, TIM2_TRGO, TIM5_TRGO, TIM4_TRGO,},
>>>>> +     { TIM1_TRGO, TIM2_TRGO, TIM3_TRGO, TIM8_TRGO,},
>>>>> +     { TIM2_TRGO, TIM3_TRGO, TIM4_TRGO, TIM8_TRGO,},
>>>>> +     { }, /* timer 6 */
>>>>> +     { }, /* timer 7 */
>>>>> +     { TIM1_TRGO, TIM2_TRGO, TIM4_TRGO, TIM5_TRGO,},
>>>>> +     { TIM2_TRGO, TIM3_TRGO,},
>>>>> +     { }, /* timer 10 */
>>>>> +     { }, /* timer 11 */
>>>>> +     { TIM4_TRGO, TIM5_TRGO,},
>>>>> +};
>>>>> +
>>>>>  struct stm32_timer_trigger {
>>>>>       struct device *dev;
>>>>>       struct regmap *regmap;
>>>>>       struct clk *clk;
>>>>>       u32 max_arr;
>>>>>       const void *triggers;
>>>>> +     const void *valids;
>>>>>  };
>>>>>
>>>>>  static int stm32_timer_start(struct stm32_timer_trigger *priv,
>>>>> @@ -180,8 +198,7 @@ static ssize_t stm32_tt_show_master_mode(struct device *dev,
>>>>>                                        struct device_attribute *attr,
>>>>>                                        char *buf)
>>>>>  {
>>>>> -     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>>>> -     struct stm32_timer_trigger *priv = iio_priv(indio_dev);
>>>>> +     struct stm32_timer_trigger *priv = dev_get_drvdata(dev);
>>>>>       u32 cr2;
>>>>>
>>>>>       regmap_read(priv->regmap, TIM_CR2, &cr2);
>>>>> @@ -194,8 +211,7 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
>>>>>                                         struct device_attribute *attr,
>>>>>                                         const char *buf, size_t len)
>>>>>  {
>>>>> -     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>>>> -     struct stm32_timer_trigger *priv = iio_priv(indio_dev);
>>>>> +     struct stm32_timer_trigger *priv = dev_get_drvdata(dev);
>>>>>       int i;
>>>>>
>>>>>       for (i = 0; i < ARRAY_SIZE(master_mode_table); i++) {
>>>>> @@ -275,6 +291,203 @@ static int stm32_setup_iio_triggers(struct stm32_timer_trigger *priv)
>>>>>       return 0;
>>>>>  }
>>>>>
>>>>> +static int stm32_trigger_read_raw(struct iio_dev *indio_dev,
>>>>> +                               struct iio_chan_spec const *chan,
>>>>> +                               int *val, int *val2, long mask)
>>>>> +{
>>>>> +     struct stm32_timer_trigger *priv = iio_priv(indio_dev);
>>>>> +
>>>>> +     switch (mask) {
>>>>> +     case IIO_CHAN_INFO_RAW:
>>>>> +     {
>>>>> +             u32 cnt;
>>>>> +
>>>>> +             regmap_read(priv->regmap, TIM_CNT, &cnt);
>>>>> +             *val = cnt;
>>>>> +
>>>>> +             return IIO_VAL_INT;
>>>>> +     }
>>>>> +     }
>>>>> +
>>>>> +     return -EINVAL;
>>>>> +}
>>>>> +
>>>>> +static int stm32_trigger_write_raw(struct iio_dev *indio_dev,
>>>>> +                                struct iio_chan_spec const *chan,
>>>>> +                                int val, int val2, long mask)
>>>>> +{
>>>>> +     struct stm32_timer_trigger *priv = iio_priv(indio_dev);
>>>>> +
>>>>> +     switch (mask) {
>>>>> +     case IIO_CHAN_INFO_RAW:
>>>> Why the brackets?
>>>
>>>I will simplify code with if (mask == IIO_CHAN_INFO_RAW)
>>>
>>>>> +     {
>>>>> +             regmap_write(priv->regmap, TIM_CNT, val);
>>>>> +
>>>>> +             return IIO_VAL_INT;
>>>>> +     }
>>>>> +     }
>>>>> +
>>>>> +     return -EINVAL;
>>>>> +}
>>>>> +
>>>>> +static const struct iio_info stm32_trigger_info = {
>>>>> +     .driver_module = THIS_MODULE,
>>>>> +     .read_raw = stm32_trigger_read_raw,
>>>>> +     .write_raw = stm32_trigger_write_raw
>>>>> +};
>>>>> +
>>>>> +static const char *const stm32_count_modes[] = {
>>>>> +     "internal_clock",
>>>>> +     "encoder_1",
>>>>> +     "encoder_2",
>>>>> +     "encoder_3",
>>>>> +     "reset",
>>>>> +     "gated",
>>>>> +     "trigger",
>>>>
>>>>> +};
>>>>> +
>>>>> +static int stm32_set_count_mode(struct iio_dev *indio_dev,
>>>>> +                             const struct iio_chan_spec *chan,
>>>>> +                             unsigned int mode)
>>>>> +{
>>>>> +     struct stm32_timer_trigger *priv = iio_priv(indio_dev);
>>>>> +
>>>>> +     regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS, mode);
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +static int stm32_get_count_mode(struct iio_dev *indio_dev,
>>>>> +                             const struct iio_chan_spec *chan)
>>>>> +{
>>>>> +     struct stm32_timer_trigger *priv = iio_priv(indio_dev);
>>>>> +     u32 smcr;
>>>>> +
>>>>> +     regmap_read(priv->regmap, TIM_SMCR, &smcr);
>>>>> +     smcr &= TIM_SMCR_SMS;
>>>>> +
>>>>> +     return smcr;
>>>>> +}
>>>>> +
>>>>> +static const struct iio_enum stm32_count_mode_enum = {
>>>>> +     .items = stm32_count_modes,
>>>>> +     .num_items = ARRAY_SIZE(stm32_count_modes),
>>>>> +     .set = stm32_set_count_mode,
>>>>> +     .get = stm32_get_count_mode
>>>>> +};
>>>>> +
>>>>> +static const char *const stm32_count_direction_states[] = {
>>>>> +     "up",
>>>>> +     "down"
>>>>> +};
>>>>> +
>>>>> +static int stm32_set_count_direction(struct iio_dev *indio_dev,
>>>>> +                                  const struct iio_chan_spec *chan,
>>>>> +                                  unsigned int mode)
>>>>> +{
>>>>> +     struct stm32_timer_trigger *priv = iio_priv(indio_dev);
>>>>> +
>>>>> +     regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_DIR, mode);
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +static int stm32_get_count_direction(struct iio_dev *indio_dev,
>>>>> +                                  const struct iio_chan_spec *chan)
>>>>> +{
>>>>> +     struct stm32_timer_trigger *priv = iio_priv(indio_dev);
>>>>> +     u32 cr1;
>>>>> +
>>>>> +     regmap_read(priv->regmap, TIM_CR1, &cr1);
>>>>> +
>>>>> +     return (cr1 & TIM_CR1_DIR);
>>>>> +}
>>>>> +
>>>>> +static const struct iio_enum stm32_count_direction_enum = {
>>>>> +     .items = stm32_count_direction_states,
>>>>> +     .num_items = ARRAY_SIZE(stm32_count_direction_states),
>>>>> +     .set = stm32_set_count_direction,
>>>>> +     .get = stm32_get_count_direction
>>>>> +};
>>>>> +
>>>>> +static ssize_t stm32_count_get_preset(struct iio_dev *indio_dev,
>>>>> +                                   uintptr_t private,
>>>>> +                                   const struct iio_chan_spec *chan,
>>>>> +                                   char *buf)
>>>>> +{
>>>>> +     struct stm32_timer_trigger *priv = iio_priv(indio_dev);
>>>>> +     u32 arr;
>>>>> +
>>>>> +     regmap_read(priv->regmap, TIM_ARR, &arr);
>>>>> +
>>>>> +     return snprintf(buf, PAGE_SIZE, "%u\n", arr);
>>>>> +}
>>>>> +
>>>>> +static ssize_t stm32_count_set_preset(struct iio_dev *indio_dev,
>>>>> +                                   uintptr_t private,
>>>>> +                                   const struct iio_chan_spec *chan,
>>>>> +                                   const char *buf, size_t len)
>>>>> +{
>>>>> +     struct stm32_timer_trigger *priv = iio_priv(indio_dev);
>>>>> +     unsigned int preset;
>>>>> +     int ret;
>>>>> +
>>>>> +     ret = kstrtouint(buf, 0, &preset);
>>>>> +     if (ret)
>>>>> +             return ret;
>>>>> +
>>>>> +     regmap_write(priv->regmap, TIM_ARR, preset);
>>>>> +     regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, TIM_CR1_ARPE);
>>>>> +
>>>>> +     return len;
>>>>> +}
>>>>> +
>>>>> +static const struct iio_chan_spec_ext_info stm32_trigger_count_info[] = {
>>>>> +     {
>>>>> +             .name = "preset",
>>>>> +             .shared = IIO_SEPARATE,
>>>>> +             .read = stm32_count_get_preset,
>>>>> +             .write = stm32_count_set_preset
>>>>> +     },
>>>>> +     IIO_ENUM("count_direction", IIO_SEPARATE, &stm32_count_direction_enum),
>>>>> +     IIO_ENUM_AVAILABLE("count_direction", &stm32_count_direction_enum),
>>>>> +     IIO_ENUM("count_mode", IIO_SEPARATE, &stm32_count_mode_enum),
>>>>> +     IIO_ENUM_AVAILABLE("count_mode", &stm32_count_mode_enum),
>>>>> +     {}
>>>>> +};
>>>>> +
>>>>> +static const struct iio_chan_spec stm32_trigger_channel = {
>>>>> +     .type = IIO_COUNT,
>>>>> +     .channel = 0,
>>>>> +     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>>>>> +     .ext_info = stm32_trigger_count_info,
>>>>> +     .indexed = 1
>>>>> +};
>>>>> +
>>>>> +static struct stm32_timer_trigger *stm32_setup_iio_device(struct device *dev)
>>>>> +{
>>>>> +     struct iio_dev *indio_dev;
>>>>> +     int ret;
>>>>> +
>>>>> +     indio_dev = devm_iio_device_alloc(dev,
>>>>> +                                       sizeof(struct stm32_timer_trigger));
>>>>> +     if (!indio_dev)
>>>>> +             return NULL;
>>>>> +
>>>>> +     indio_dev->name = dev_name(dev);
>>>>> +     indio_dev->dev.parent = dev;
>>>>> +     indio_dev->info = &stm32_trigger_info;
>>>>> +     indio_dev->num_channels = 1;
>>>>> +     indio_dev->channels = &stm32_trigger_channel;
>>>>> +     indio_dev->dev.of_node = dev->of_node;
>>>>> +
>>>>> +     ret = devm_iio_device_register(dev, indio_dev);
>>>>> +     if (ret)
>>>>> +             return NULL;
>>>>> +
>>>>> +     return iio_priv(indio_dev);
>>>>> +}
>>>>> +
>>>>>  /**
>>>>>   * is_stm32_timer_trigger
>>>>>   * @trig: trigger to be checked
>>>>> @@ -299,10 +512,15 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
>>>>>       if (of_property_read_u32(dev->of_node, "reg", &index))
>>>>>               return -EINVAL;
>>>>>
>>>>> -     if (index >= ARRAY_SIZE(triggers_table))
>>>>> +     if (index >= ARRAY_SIZE(triggers_table) ||
>>>>> +         index >= ARRAY_SIZE(valids_table))
>>>>>               return -EINVAL;
>>>>>
>>>>> -     priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>>>> +     /* Create an IIO device only if we have triggers to be validated */
>>>>> +     if (*valids_table[index])
>>>>> +             priv = stm32_setup_iio_device(dev);
>>>>> +     else
>>>>> +             priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>>>>
>>>>>       if (!priv)
>>>>>               return -ENOMEM;
>>>>> @@ -312,6 +530,7 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
>>>>>       priv->clk = ddata->clk;
>>>>>       priv->max_arr = ddata->max_arr;
>>>>>       priv->triggers = triggers_table[index];
>>>>> +     priv->valids = valids_table[index];
>>>>>
>>>>>       ret = stm32_setup_iio_triggers(priv);
>>>>>       if (ret)
>>>>> diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
>>>>> index d030004..4a0abbc 100644
>>>>> --- a/include/linux/mfd/stm32-timers.h
>>>>> +++ b/include/linux/mfd/stm32-timers.h
>>>>> @@ -21,6 +21,7 @@
>>>>>  #define TIM_CCMR1    0x18    /* Capt/Comp 1 Mode Reg    */
>>>>>  #define TIM_CCMR2    0x1C    /* Capt/Comp 2 Mode Reg    */
>>>>>  #define TIM_CCER     0x20    /* Capt/Comp Enable Reg    */
>>>>> +#define TIM_CNT              0x24    /* Counter                 */
>>>>>  #define TIM_PSC              0x28    /* Prescaler               */
>>>>>  #define TIM_ARR              0x2c    /* Auto-Reload Register    */
>>>>>  #define TIM_CCR1     0x34    /* Capt/Comp Register 1    */
>>>>> @@ -30,6 +31,7 @@
>>>>>  #define TIM_BDTR     0x44    /* Break and Dead-Time Reg */
>>>>>
>>>>>  #define TIM_CR1_CEN  BIT(0)  /* Counter Enable          */
>>>>> +#define TIM_CR1_DIR  BIT(4)  /* Counter Direction       */
>>>>>  #define TIM_CR1_ARPE BIT(7)  /* Auto-reload Preload Ena */
>>>>>  #define TIM_CR2_MMS  (BIT(4) | BIT(5) | BIT(6)) /* Master mode selection */
>>>>>  #define TIM_SMCR_SMS (BIT(0) | BIT(1) | BIT(2)) /* Slave mode selection */
>>>>>
>>>>
>
>
>
>-- 
>Benjamin Gaignard
>
>Graphic Study Group
>
>Linaro.org │ Open source software for ARM SoCs
>
>Follow Linaro: Facebook | Twitter | Blog
