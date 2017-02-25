Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47004 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbdBYR7p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Feb 2017 12:59:45 -0500
Subject: Re: [PATCH v3 2/2] iio: stm32 trigger: Implement parent trigger
 feature
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
References: <1487947695-9305-1-git-send-email-benjamin.gaignard@st.com>
 <1487947695-9305-3-git-send-email-benjamin.gaignard@st.com>
Cc: fabrice.gasnier@st.com, linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <aaf51d6a-3b84-4fc2-d20c-394d24fe217c@kernel.org>
Date: Sat, 25 Feb 2017 17:53:36 +0000
MIME-Version: 1.0
In-Reply-To: <1487947695-9305-3-git-send-email-benjamin.gaignard@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/02/17 14:48, Benjamin Gaignard wrote:
> Add validate_trigger function in iio_trigger_ops and
> dev_attr_parent_trigger into trigger attribute group to be able
> to accept triggers as parents.
> 
> Introduce an IIO device with one IIO_COUNT channel to get access
> to counter value. Counter directions can be set/get when writing/reading
> /sys/bus/iio/devices/iio:deviceX/in_count0_count_direction.
> 
> The hardware have multiple way to use inputs edges and levels to
> performing counting, those different modes are exposed in:
> /sys/bus/iio/devices/iio:deviceX/in_count_count_mode_available.
Funny though it sounds, this is to general to generalize.
See below.
> 
> "trigger_rising_edges" mode is automatically set when a valid
> parent trigger is set.
We still have an issue of two overlapping concepts here, that
of a clock and that of a parent trigger. Perhaps it's valid
to have a clock set to be the parent trigger, but that is
kind of the odd case rather than the normal use of 
parent triggers (in my head at least :)

So what we end up with here is something we have kind of messed
around with before...

An event acting as a trigger.
Conceptually your 'preset' occurring is an event in IIO terms
(there is on going work to present exactly that event to userspace
for the other encoder driver we have).

That event is then acting as a trigger, even if that trigger
is not 'visible' as such to userspace.

This event as trigger is something we have messed around with
from the very start but never formalized. It is one of the things
that would make good use of an inkernel consumer interface
for events.  If we had one of those, a tiny driver and a bit of
configfs magic interface and we'd be able to use any event as
a trigger.

Hence I rather like this. You could say it fits with my
world view ;)

Only remaining question to my mind is whether we need to make that
presence of an 'event' explicit?  Doesn't necessarily have
to happen now, but if it existed in some sense it might make
it easier for generic userspace to interpret what is going on.

Maybe something for the future.

Anyhow, still some work to do here, but moving in a viable
direction (I think) so keep up the good work!

Jonathan
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> 
> version 2:
> - use dev_attr_parent_trigger
> - improve slave modes documentation
> 
> version 3:
> - add one channel to get counter raw value
> ---
>  .../ABI/testing/sysfs-bus-iio-timer-stm32          |  63 +++++
>  drivers/iio/trigger/stm32-timer-trigger.c          | 256 ++++++++++++++++++++-
>  include/linux/mfd/stm32-timers.h                   |   2 +
>  3 files changed, 315 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> index 6534a60..63852a9 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> @@ -27,3 +27,66 @@ Description:
>  		Reading returns the current sampling frequency.
>  		Writing an value different of 0 set and start sampling.
>  		Writing 0 stop sampling.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_count0_raw
> +KernelVersion:	4.12
> +Contact:	benjamin.gaignard@st.com
> +Description:
> +		Reading returns counter current value.
Assuming it counts every one this can definitely be in_count0_input (so processed)
as it's in the 'base' units. Kind of hard not to be with a counter.

Hohum. Just checked docs and this is documented as _raw.
Oh well no real harm in doing that I guess so perhaps we just stay with that even
if it's a little silly.

Anyhow, no need to document stuff in here that is in the main docs
sysfs-bus-iio
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_count_count_direction_available
> +KernelVersion:	4.12
> +Contact:	benjamin.gaignard@st.com
> +Description:
> +		Reading returns the list of possible counting directions which
> +		are:
> +		- "up"	: counter is increasing.
> +		- "down": counter is decreasing.
This is now generic enough we should probably move it into the main docs rather than
repeating for each device.

So cut this out of here and out of the 104_counter file and put it in 
sysfs-bus-iio. 

Note that for some you'll have to drop the bits in the 104-counter-quad-8 file that say
if things are read only or not.  The sysfs ABI docs don't need to say so that is fine. 
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_count0_count_direction
> +KernelVersion:	4.12
> +Contact:	benjamin.gaignard@st.com
> +Description:
> +		Reading returns the counting directions:
> +		- "up"	: counter is increasing.
> +		- "down": counter is decreasing.
> +		Writing set the counting direction.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_count_count_mode_available
> +KernelVersion:	4.12
> +Contact:	benjamin.gaignard@st.com
> +Description:
I still think this needs breaking up if we are going to have any hope of a generic interface.

> +		Reading returns the list of possible counting modes which are:
> +		- "internal_clock": Counter is clocked by the internal clock rising edges.
This is about the feed clock - not a mode as such.

> +		- "encoder_1" : Counter counts up/down on channel 2 edge depending on channel 1 level.
> +		- "encoder_2" : Counter counts up/down on channel 1 edge depending on channel 2 level.
> +		- "encoder_3" : Counter counts up/down on channels 1 & 2 edge depending on channel 1 & 2 level.
These combine the feed clock and the interpretation.  To my mind, two different things.

I kind of dislike the fact we can be either an internal clock or an encoder. seems that if you have an encoder
wired it would be nuts to use the internal clock, but given we do this on various rigs at work to fake 
things when the encoder isn't moving I can't claim there is no use case ;)

> +		- "reset"     : Rising edges on parent trigger reinitializes the counter value to preset value.
> +		- "gated"     : Counter counts when the parent trigger input is high.
> +				Counter stops (but is not reset) as soon as the parent trigger becomes low.
> +		- "trigger"   : Counter starts at a rising edge of the parent trigger (but it is not reset).
These are gating of the feed clock

> +		- "trigger_rising_edges": Rising edges of the parent trigger are used as clock by the counter.
This one is about the feed clock again.

So we need at least 3 different things.
1. Feed clock selection.
2. Encoder interpretation selection - arguably we should have an explicit description of the encoder
as a device in it's own right but I guess we can ignore that for now.
3. The parent trigger 'use'.

> +
> +		Encoder modes are used to automatically handle the counting direction of the internal counter.
> +		Those modes are typically used for high-accuracy rotor position sensing in electrical motors
> +		or for digital potentiometers. From the two outputs of a quadrature encoder sensor the timer
> +		extracts a clock on each and every active edge and adjusts the counting direction depending on
> +		the relative phase-shift between the two incomings signals. The timer counter thus directly
> +		holds the angular position of the motor.
> +
> +		"trigger_rising_edges" mode is automatically set when a valid parent trigger is set.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_count0_count_mode
> +KernelVersion:	4.12
> +Contact:	benjamin.gaignard@st.com
> +Description:
> +		Reading returns the current counting mode.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_count0_preset
> +KernelVersion:	4.12
> +Contact:	benjamin.gaignard@st.com
> +Description:
> +		Reading returns the current preset value.
> +		Writing set the preset value.
> +		When counting up the counter start from 0 and fire an event when reach preset value.
> +		When counting down the counter start from preset value and fire event when reach 0.
Fair enough, I hadn't thought if it like this, but makes sense.

> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> index 994b96d..04f5f05 100644
> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> @@ -15,6 +15,7 @@
>  #include <linux/platform_device.h>
>  
>  #define MAX_TRIGGERS 6
> +#define MAX_VALIDS 5
>  
>  /* List the triggers created by each timer */
>  static const void *triggers_table[][MAX_TRIGGERS] = {
> @@ -32,12 +33,29 @@
>  	{ TIM12_TRGO, TIM12_CH1, TIM12_CH2,},
>  };
>  
> +/* List the triggers accepted by each timer */
> +static const void *valids_table[][MAX_VALIDS] = {
> +	{ TIM5_TRGO, TIM2_TRGO, TIM3_TRGO, TIM4_TRGO,},
> +	{ TIM1_TRGO, TIM8_TRGO, TIM3_TRGO, TIM4_TRGO,},
> +	{ TIM1_TRGO, TIM2_TRGO, TIM5_TRGO, TIM4_TRGO,},
> +	{ TIM1_TRGO, TIM2_TRGO, TIM3_TRGO, TIM8_TRGO,},
> +	{ TIM2_TRGO, TIM3_TRGO, TIM4_TRGO, TIM8_TRGO,},
> +	{ }, /* timer 6 */
> +	{ }, /* timer 7 */
> +	{ TIM1_TRGO, TIM2_TRGO, TIM4_TRGO, TIM5_TRGO,},
> +	{ TIM2_TRGO, TIM3_TRGO,},
> +	{ }, /* timer 10 */
> +	{ }, /* timer 11 */
> +	{ TIM4_TRGO, TIM5_TRGO,},
> +};
> +
>  struct stm32_timer_trigger {
>  	struct device *dev;
>  	struct regmap *regmap;
>  	struct clk *clk;
>  	u32 max_arr;
>  	const void *triggers;
> +	const void *valids;
>  };
>  
>  static int stm32_timer_start(struct stm32_timer_trigger *priv,
> @@ -180,8 +198,7 @@ static ssize_t stm32_tt_show_master_mode(struct device *dev,
>  					 struct device_attribute *attr,
>  					 char *buf)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
> +	struct stm32_timer_trigger *priv = dev_get_drvdata(dev);
>  	u32 cr2;
>  
>  	regmap_read(priv->regmap, TIM_CR2, &cr2);
> @@ -194,10 +211,10 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
>  					  struct device_attribute *attr,
>  					  const char *buf, size_t len)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
> +	struct stm32_timer_trigger *priv = dev_get_drvdata(dev);
>  	int i;
>  
> +
>  	for (i = 0; i < ARRAY_SIZE(master_mode_table); i++) {
>  		if (!strncmp(master_mode_table[i], buf,
>  			     strlen(master_mode_table[i]))) {
> @@ -225,6 +242,7 @@ static IIO_DEVICE_ATTR(master_mode, 0660,
>  	&iio_dev_attr_sampling_frequency.dev_attr.attr,
>  	&iio_dev_attr_master_mode.dev_attr.attr,
>  	&iio_const_attr_master_mode_available.dev_attr.attr,
> +	&dev_attr_parent_trigger.attr,
>  	NULL,
>  };
>  
> @@ -237,8 +255,49 @@ static IIO_DEVICE_ATTR(master_mode, 0660,
>  	NULL,
>  };
>  
> +static int stm32_validate_trigger(struct iio_trigger *trig,
> +				  struct iio_trigger *parent)
> +{
> +	struct stm32_timer_trigger *priv = iio_trigger_get_drvdata(trig);
> +	const char * const *cur = priv->valids;
> +	unsigned int i = 0;
> +
> +	if (!parent) {
> +		regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_TS, 0);
> +		return 0;
> +	}
> +
> +	if (!is_stm32_timer_trigger(parent))
> +		return -EINVAL;
> +
> +	while (cur && *cur) {
> +		if (!strncmp(parent->name, *cur, strlen(parent->name))) {
> +			regmap_update_bits(priv->regmap,
> +					   TIM_SMCR, TIM_SMCR_TS,
> +					   i << TIM_SMCR_TS_SHIFT);
> +
> +			/*
> +			 * By default make parent trigger rising edges
> +			 * use as clock for the counter
> +			 */
> +			regmap_update_bits(priv->regmap, TIM_SMCR,
> +					   TIM_SMCR_SMS, TIM_SMCR_SMS);
> +
> +			/* Enable controller */
> +			regmap_update_bits(priv->regmap, TIM_CR1,
> +					   TIM_CR1_CEN, TIM_CR1_CEN);
> +			return 0;
> +		}
> +		cur++;
> +		i++;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static const struct iio_trigger_ops timer_trigger_ops = {
>  	.owner = THIS_MODULE,
> +	.validate_trigger = stm32_validate_trigger,
>  };
>  
>  static int stm32_setup_iio_triggers(struct stm32_timer_trigger *priv)
> @@ -275,6 +334,185 @@ static int stm32_setup_iio_triggers(struct stm32_timer_trigger *priv)
>  	return 0;
>  }
>  
> +static int stm32_trigger_read_raw(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan,
> +				  int *val, int *val2, long mask)
> +{
> +	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +	{
> +		u32 cnt;
> +
> +		regmap_read(priv->regmap, TIM_CNT, &cnt);
> +		*val = cnt;
> +
> +		return IIO_VAL_INT;
> +	}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info stm32_trigger_info = {
> +	.driver_module = THIS_MODULE,
> +	.read_raw = stm32_trigger_read_raw,
> +};
> +
> +static const char *const stm32_count_modes[] = {
> +	"internal_clock",
> +	"encoder_1",
> +	"encoder_2",
> +	"encoder_3",
> +	"reset",
> +	"gated",
> +	"trigger",
> +	"trigger_rising_edges"
> +};
> +
> +static int stm32_set_count_mode(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				unsigned int mode)
> +{
> +	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
> +
> +	regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS, mode);
> +
> +	return 0;
> +}
> +
> +static int stm32_get_count_mode(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan)
> +{
> +	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
> +	u32 smcr;
> +
> +	regmap_read(priv->regmap, TIM_SMCR, &smcr);
> +	smcr &= TIM_SMCR_SMS;
> +
> +	return smcr;
> +}
> +
> +static const struct iio_enum stm32_count_mode_enum = {
> +	.items = stm32_count_modes,
> +	.num_items = ARRAY_SIZE(stm32_count_modes),
> +	.set = stm32_set_count_mode,
> +	.get = stm32_get_count_mode
> +};
> +
> +static const char *const stm32_count_direction_states[] = {
> +	"up",
> +	"down"
> +};
> +
> +static int stm32_set_count_direction(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     unsigned int mode)
> +{
> +	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
> +
> +	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_DIR, mode);
> +
> +	return 0;
> +}
> +
> +static int stm32_get_count_direction(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan)
> +{
> +	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
> +	u32 cr1;
> +
> +	regmap_read(priv->regmap, TIM_CR1, &cr1);
> +
> +	return (cr1 & TIM_CR1_DIR);
> +}
> +
> +static const struct iio_enum stm32_count_direction_enum = {
> +	.items = stm32_count_direction_states,
> +	.num_items = ARRAY_SIZE(stm32_count_direction_states),
> +	.set = stm32_set_count_direction,
> +	.get = stm32_get_count_direction
> +};
> +
> +static ssize_t stm32_count_get_preset(struct iio_dev *indio_dev,
> +				      uintptr_t private,
> +				      const struct iio_chan_spec *chan,
> +				      char *buf)
> +{
> +	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
> +	u32 arr;
> +
> +	regmap_read(priv->regmap, TIM_ARR, &arr);
> +
> +	return snprintf(buf, PAGE_SIZE, "%u\n", arr);
> +}
> +
> +static ssize_t stm32_count_set_preset(struct iio_dev *indio_dev,
> +				      uintptr_t private,
> +				      const struct iio_chan_spec *chan,
> +				      const char *buf, size_t len)
> +{
> +	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
> +	unsigned int preset;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 0, &preset);
> +	if (ret)
> +		return ret;
> +
> +	regmap_write(priv->regmap, TIM_ARR, preset);
> +	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, TIM_CR1_ARPE);
> +
> +	return len;
> +}
> +
> +static const struct iio_chan_spec_ext_info stm32_trigger_count_info[] = {
> +	{
> +		.name = "preset",
> +		.shared = IIO_SEPARATE,
> +		.read = stm32_count_get_preset,
> +		.write = stm32_count_set_preset
> +	},
> +	IIO_ENUM("count_direction", IIO_SEPARATE, &stm32_count_direction_enum),
> +	IIO_ENUM_AVAILABLE("count_direction", &stm32_count_direction_enum),
> +	IIO_ENUM("count_mode", IIO_SEPARATE, &stm32_count_mode_enum),
> +	IIO_ENUM_AVAILABLE("count_mode", &stm32_count_mode_enum),
> +	{}
> +};
> +
> +static const struct iio_chan_spec stm32_trigger_channel = {
> +	.type = IIO_COUNT,
> +	.channel = 0,
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	.ext_info = stm32_trigger_count_info,
> +	.indexed = 1
> +};
> +
> +static struct stm32_timer_trigger *stm32_setup_iio_device(struct device *dev)
> +{
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev,
> +					  sizeof(struct stm32_timer_trigger));
> +	if (!indio_dev)
> +		return NULL;
> +
> +	indio_dev->name = dev_name(dev);
> +	indio_dev->dev.parent = dev;
> +	indio_dev->info = &stm32_trigger_info;
> +	indio_dev->num_channels = 1;
> +	indio_dev->channels = &stm32_trigger_channel;
> +	indio_dev->dev.of_node = dev->of_node;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return NULL;
> +
> +	return iio_priv(indio_dev);
> +}
> +
>  /**
>   * is_stm32_timer_trigger
>   * @trig: trigger to be checked
> @@ -299,10 +537,15 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
>  	if (of_property_read_u32(dev->of_node, "reg", &index))
>  		return -EINVAL;
>  
> -	if (index >= ARRAY_SIZE(triggers_table))
> +	if (index >= ARRAY_SIZE(triggers_table)
> +	    || index >= ARRAY_SIZE(valids_table))
>  		return -EINVAL;
>  
> -	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	/* Create an IIO device only if we have triggers to be validated */
> +	if (*valids_table[index])
> +		priv = stm32_setup_iio_device(dev);
> +	else
> +		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  
>  	if (!priv)
>  		return -ENOMEM;
> @@ -312,6 +555,7 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
>  	priv->clk = ddata->clk;
>  	priv->max_arr = ddata->max_arr;
>  	priv->triggers = triggers_table[index];
> +	priv->valids = valids_table[index];
>  
>  	ret = stm32_setup_iio_triggers(priv);
>  	if (ret)
> diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
> index d030004..4a0abbc 100644
> --- a/include/linux/mfd/stm32-timers.h
> +++ b/include/linux/mfd/stm32-timers.h
> @@ -21,6 +21,7 @@
>  #define TIM_CCMR1	0x18	/* Capt/Comp 1 Mode Reg    */
>  #define TIM_CCMR2	0x1C	/* Capt/Comp 2 Mode Reg    */
>  #define TIM_CCER	0x20	/* Capt/Comp Enable Reg    */
> +#define TIM_CNT		0x24	/* Counter		   */
>  #define TIM_PSC		0x28	/* Prescaler               */
>  #define TIM_ARR		0x2c	/* Auto-Reload Register    */
>  #define TIM_CCR1	0x34	/* Capt/Comp Register 1    */
> @@ -30,6 +31,7 @@
>  #define TIM_BDTR	0x44	/* Break and Dead-Time Reg */
>  
>  #define TIM_CR1_CEN	BIT(0)	/* Counter Enable	   */
> +#define TIM_CR1_DIR	BIT(4)  /* Counter Direction	   */
>  #define TIM_CR1_ARPE	BIT(7)	/* Auto-reload Preload Ena */
>  #define TIM_CR2_MMS	(BIT(4) | BIT(5) | BIT(6)) /* Master mode selection */
>  #define TIM_SMCR_SMS	(BIT(0) | BIT(1) | BIT(2)) /* Slave mode selection */
> 

