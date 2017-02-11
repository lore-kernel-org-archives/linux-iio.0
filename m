Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45411 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753041AbdBKLOh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Feb 2017 06:14:37 -0500
Subject: Re: [PATCH v1 2/2] iio: stm32 trigger: Implement validate_trigger
 function
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
References: <1486390912-24362-1-git-send-email-benjamin.gaignard@st.com>
 <1486390912-24362-3-git-send-email-benjamin.gaignard@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Cc: fabrice.gasnier@st.com, linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Message-ID: <4dc12f85-a664-b0c1-58b7-e207099d3f73@kernel.org>
Date: Sat, 11 Feb 2017 11:14:33 +0000
MIME-Version: 1.0
In-Reply-To: <1486390912-24362-3-git-send-email-benjamin.gaignard@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/02/17 14:21, Benjamin Gaignard wrote:
> Add validate_trigger function in iio_trigger_ops to be able to accept
> triggers as parents.
> 
> Because the hardware have 8 different ways to use parent levels and
> edges, this patch introduce "slave_mode" sysfs attribute for stm32
> triggers.
I wonder if we can't come up with a more generic way of describing thes
modes...

Only some of these modes fit into what one might conventionally consider
a trigger tree. The others are more just fancy ways of controlling
a single trigger.

Anyhow, basically the docs need more detail, perhaps some examples would
help.  Right now it's a little hard to envision what the slave_modes
actually are.

A couple correspond to what I'd expect to see in a conventional
trigger tree setup as we discussed earlier, others really don't
- basically any of the ones that are not simply gating or resetting
the trigger.

I'll think some more on this.  Getting dragged out shopping now!

Jonathan
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-timer-stm32          |  26 ++++++
>  drivers/iio/trigger/stm32-timer-trigger.c          | 104 +++++++++++++++++++++
>  2 files changed, 130 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> index 6534a60..ce974f7 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> @@ -27,3 +27,29 @@ Description:
>  		Reading returns the current sampling frequency.
>  		Writing an value different of 0 set and start sampling.
>  		Writing 0 stop sampling.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/slave_mode_available
This is introducing it for the device...

> +KernelVersion:	4.12
> +Contact:	benjamin.gaignard@st.com
> +Description:
This doc only works if you have the datasheet in front of you.  As such, it's not
sufficient to my mind.

> +		Reading returns the list possible slave modes which are:
> +		- "disabled"  : The prescaler is clocked directly by the internal clock.
There are a lot of reference to counters in here.  I'm not sure that term is clear.
What is this counter?  What does it have to do with the device at all?

These need describing in terms of what they do to the trigger in question.

This I think is about the triggers internal counter (on which we have a threshold set to
cause a trigger) counting up.  These next few are about handling quadrature encoders.

> +		- "encoder_1" : Counter counts up/down on TI2FP1 edge depending on TI1FP2 level.
TI1FP2 etc are?
So the trigger we are dealing with (rather than the parent) will fire when this counter reaches
a particular value?  That's what you need to describe.


> +		- "encoder_2" : Counter counts up/down on TI1FP2 edge depending on TI2FP1 level.
> +		- "encoder_3" : Counter counts up/down on both TI1FP1 and TI2FP2 edges depending
> +				on the level of the other input.
> +		- "reset"     : Rising edge of the selected trigger input reinitializes the counter
> +				and generates an update of the registers.
So trigger is free running, except that the counter used is slammed to 0 when the parent trigger fires.

> +		- "gated"     : The counter clock is enabled when the trigger input is high.
> +				The counter stops (but is not reset) as soon as the trigger becomes low.
> +				Both start and stop of the counter are controlled.
This one is the simple trigger tree case of gating - trigger only fires when it's parent is on
(the fine details of how the counter is involved don't matter form a birds eye viewpoint).

> +		- "trigger"   : The counter starts at a rising edge of the trigger TRGI (but it is not
> +				reset). Only the start of the counter is controlled.
How is it ever reset? Will it run for a fixed number of cycles, or for ever?

> +		- "external_clock": Rising edges of the selected trigger (TRGI) clock the counter.
This one is effectively a pass through of the clock.  So acts as a trigger subsampler.  Fire the
child trigger every 'n' times the parent trigger fires? Here we should also say what controls n.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/slave_mode
> +KernelVersion:	4.12
> +Contact:	benjamin.gaignard@st.com
> +Description:
> +		Reading returns the current slave mode.
> +		Writing set the slave mode
> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> index 994b96d..d1ffe49 100644
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
> +	{ TIM5_TRGO, TIM2_TRGO, TIM4_TRGO, TIM3_TRGO,},
> +	{ TIM1_TRGO, TIM8_TRGO, TIM3_TRGO, TIM4_TRGO,},
> +	{ TIM1_TRGO, TIM8_TRGO, TIM5_TRGO, TIM4_TRGO,},
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
> @@ -221,10 +239,65 @@ static IIO_DEVICE_ATTR(master_mode, 0660,
>  		       stm32_tt_store_master_mode,
>  		       0);
>  
> +static char *slave_mode_table[] = {
> +	"disabled",
> +	"encoder_1",
> +	"encoder_2",
> +	"encoder_3",
> +	"reset",
> +	"gated",
> +	"trigger",
> +	"external_clock",
> +};
> +
> +static ssize_t stm32_tt_show_slave_mode(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
> +	u32 smcr;
> +
> +	regmap_read(priv->regmap, TIM_SMCR, &smcr);
> +	smcr &= TIM_SMCR_SMS;
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n", slave_mode_table[smcr]);
> +}
> +
> +static ssize_t stm32_tt_store_slave_mode(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(slave_mode_table); i++) {
> +		if (!strncmp(slave_mode_table[i], buf,
> +			     strlen(slave_mode_table[i]))) {
> +			regmap_update_bits(priv->regmap,
> +					   TIM_SMCR, TIM_SMCR_SMS, i);
> +			return len;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static IIO_CONST_ATTR(slave_mode_available,
> +"disabled encoder_1 encoder_2 encoder_3 reset gated trigger external_clock");
> +
> +static IIO_DEVICE_ATTR(slave_mode, 0660,
> +		       stm32_tt_show_slave_mode,
> +		       stm32_tt_store_slave_mode,
> +		       0);
> +
>  static struct attribute *stm32_trigger_attrs[] = {
>  	&iio_dev_attr_sampling_frequency.dev_attr.attr,
>  	&iio_dev_attr_master_mode.dev_attr.attr,
>  	&iio_const_attr_master_mode_available.dev_attr.attr,
> +	&iio_dev_attr_slave_mode.dev_attr.attr,
> +	&iio_const_attr_slave_mode_available.dev_attr.attr,
>  	NULL,
>  };
>  
> @@ -237,8 +310,38 @@ static IIO_DEVICE_ATTR(master_mode, 0660,
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
> @@ -312,6 +415,7 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
>  	priv->clk = ddata->clk;
>  	priv->max_arr = ddata->max_arr;
>  	priv->triggers = triggers_table[index];
> +	priv->valids = valids_table[index];
>  
>  	ret = stm32_setup_iio_triggers(priv);
>  	if (ret)
> 

