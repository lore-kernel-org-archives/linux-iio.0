Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59934 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbdCEMFA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2017 07:05:00 -0500
Subject: Re: [PATCH v1 2/2] iio: stm32 trigger: Add counter device
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
References: <1488379506-23969-1-git-send-email-benjamin.gaignard@st.com>
 <1488379506-23969-3-git-send-email-benjamin.gaignard@st.com>
Cc: fabrice.gasnier@st.com, linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8e51243a-7371-37f0-6c62-53e7950dd85a@kernel.org>
Date: Sun, 5 Mar 2017 12:04:54 +0000
MIME-Version: 1.0
In-Reply-To: <1488379506-23969-3-git-send-email-benjamin.gaignard@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/03/17 14:45, Benjamin Gaignard wrote:
> One of the features of STM32 trigger hardware block is a counter
> that can counts up/down depending of the levels and edges of the
> selected external pins.
> 
> This patch allow to read/write the counter, get the direction and
> set the preset value.
> When counting up preset value is the limit of the counter.
> When counting down the counter start from preset value down to 0.
> 
> The hardware have multiple way to use inputs edges and levels to
> performing counting, those different modes are exposed in:
> /sys/bus/iio/devices/iio:deviceX/in_count_count_mode_available
> and documented in Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
This is rapidly turning into a driver for soemthing other than a trigger,
but I suppose that doesn't matter to much.  We may just want to
move it at some stage...

The primary issues in here are still around the ABI for counter-mode
It's combining a load of generic concepts and forcing them all into
one attribute.  That never generalises well so we need to break these
up before moving futher with this one.

Few other bits inline.

Jonathan
> ---
>  .../ABI/testing/sysfs-bus-iio-timer-stm32          |  40 ++++
>  drivers/iio/trigger/stm32-timer-trigger.c          | 231 ++++++++++++++++++++-
>  include/linux/mfd/stm32-timers.h                   |   2 +
>  3 files changed, 267 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> index 6534a60..17933ef 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> @@ -27,3 +27,43 @@ Description:
>  		Reading returns the current sampling frequency.
>  		Writing an value different of 0 set and start sampling.
>  		Writing 0 stop sampling.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_count_count_mode_available
> +KernelVersion:	4.12
> +Contact:	benjamin.gaignard@st.com
> +Description:
> +		Reading returns the list of possible counting modes which are:
> +		- "internal_clock": Counter is clocked by the internal clock rising edges.
As we are describing this now as a hardware counter, perhaps this first one should be
something like
pseudo encoder, or simulated encoder to represent it's use as a way of providing encoder
like counting when we don't have an encoder.

> +		- "encoder_1" : Counter is clocked by the rising edges of external pin 2 and the counter
> +				direction depend of the level of external pin 1.
> +		- "encoder_2" : Counter is clocked by the rising edges of external pin 1 and the counter
> +				direction depend of the level of external pin 2.
> +		- "encoder_3" : Counter counts up/down on channels 1 & 2 edge depending on channel 1 & 2 level.
> +				Counter is clocked by the rising edges of external pins 1 & 2,
> +				the counter direction is depend of the levels of external pin 1 & 2.
We absolutely need to figure out a generic name for these modes.  They are standard ways of handling an encoder
so it should be possible to come up with something.

> +		- "reset"     : Rising edges on pin 1 reinitializes the counter value to preset value.
> +		- "gated"     : Counter counts when external pin level is high.
> +				Counter stops (but is not reset) as soon as external pin becomes low.
> +		- "trigger"   : Counter starts at a rising edge of the external pin (but it is not reset).
We still have the same issue here.  These are totally different concepts.
To drive towards a generic interface we need to split this up.

What clock are the last 3 using?  Not clear from the description currently.

Right now it represents the hardware of this one device, not generic concepts which is where
we need to be.


> +
> +		Encoder modes are used to automatically handle the counting direction of the internal counter.
> +		Those modes are typically used for high-accuracy rotor position sensing in electrical motors
> +		or for digital potentiometers. From the two outputs of a quadrature encoder sensor the timer
> +		extracts a clock on each and every active edge and adjusts the counting direction depending on
> +		the relative phase-shift between the two incomings signals. The timer counter thus directly
> +		holds the angular position of the motor.
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
This is generic, so as with the other attribute you just handled, please make some generic text
to cover both this and that in the other counter driver and move it up to the generic docs.
> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> index 994b96d..9026265 100644
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
> @@ -194,8 +211,7 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
>  					  struct device_attribute *attr,
>  					  const char *buf, size_t len)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
> +	struct stm32_timer_trigger *priv = dev_get_drvdata(dev);
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(master_mode_table); i++) {
> @@ -275,6 +291,203 @@ static int stm32_setup_iio_triggers(struct stm32_timer_trigger *priv)
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
> +static int stm32_trigger_write_raw(struct iio_dev *indio_dev,
> +				   struct iio_chan_spec const *chan,
> +				   int val, int val2, long mask)
> +{
> +	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
Why the brackets?
> +	{
> +		regmap_write(priv->regmap, TIM_CNT, val);
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
> +	.write_raw = stm32_trigger_write_raw
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
> @@ -299,10 +512,15 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
>  	if (of_property_read_u32(dev->of_node, "reg", &index))
>  		return -EINVAL;
>  
> -	if (index >= ARRAY_SIZE(triggers_table))
> +	if (index >= ARRAY_SIZE(triggers_table) ||
> +	    index >= ARRAY_SIZE(valids_table))
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
> @@ -312,6 +530,7 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
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

