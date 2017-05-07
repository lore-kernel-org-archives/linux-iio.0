Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57579 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbdEGWQC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2017 18:16:02 -0400
Subject: Re: [PATCH v2] iio: stm32 trigger: Add support for TRGO2 triggers
To: Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-iio@vger.kernel.org, lars@metafoo.de, knaack.h@gmx.de,
        pmeerw@pmeerw.net
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        benjamin.gaignard@linaro.org, benjamin.gaignard@st.com
References: <1493728425-21278-1-git-send-email-fabrice.gasnier@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7c633c3e-5d93-0f56-1982-4a39b7f5658e@kernel.org>
Date: Sun, 7 May 2017 16:07:28 +0100
MIME-Version: 1.0
In-Reply-To: <1493728425-21278-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/05/17 13:33, Fabrice Gasnier wrote:
> Add support for TRGO2 trigger that can be found on STM32F7.
> Add additional master modes supported by TRGO2.
> Register additional "tim[1/8]_trgo2" triggers for timer1 & timer8.
> Detect TRGO2 timer capability (master mode selection 2).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
This definitely strikes me a stuff we may want to revisit sometime
in the future once we have a few similar bits of hardware supported.

I don't see this particularly interface being hard to support
even if we add something more general so:

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> Changes in v2:
> - Improve ABI documentation by adding ascii art
> ---
>  .../ABI/testing/sysfs-bus-iio-timer-stm32          |  48 +++++++++
>  drivers/iio/trigger/stm32-timer-trigger.c          | 113 ++++++++++++++++++---
>  include/linux/iio/timer/stm32-timer-trigger.h      |   2 +
>  include/linux/mfd/stm32-timers.h                   |   2 +
>  4 files changed, 151 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> index 230020e..deb0159 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> @@ -16,6 +16,54 @@ Description:
>  		- "OC2REF"    : OC2REF signal is used as trigger output.
>  		- "OC3REF"    : OC3REF signal is used as trigger output.
>  		- "OC4REF"    : OC4REF signal is used as trigger output.
> +		Additional modes (on TRGO2 only):
> +		- "OC5REF"    : OC5REF signal is used as trigger output.
> +		- "OC6REF"    : OC6REF signal is used as trigger output.
> +		- "compare_pulse_OC4REF":
> +		  OC4REF rising or falling edges generate pulses.
> +		- "compare_pulse_OC6REF":
> +		  OC6REF rising or falling edges generate pulses.
> +		- "compare_pulse_OC4REF_r_or_OC6REF_r":
> +		  OC4REF or OC6REF rising edges generate pulses.
> +		- "compare_pulse_OC4REF_r_or_OC6REF_f":
> +		  OC4REF rising or OC6REF falling edges generate pulses.
> +		- "compare_pulse_OC5REF_r_or_OC6REF_r":
> +		  OC5REF or OC6REF rising edges generate pulses.
> +		- "compare_pulse_OC5REF_r_or_OC6REF_f":
> +		  OC5REF rising or OC6REF falling edges generate pulses.
> +
> +		+-----------+   +-------------+            +---------+
> +		| Prescaler +-> | Counter     |        +-> | Master  | TRGO(2)
> +		+-----------+   +--+--------+-+        |-> | Control +-->
> +		                   |        |          ||  +---------+
> +		                +--v--------+-+ OCxREF ||  +---------+
> +		                | Chx compare +----------> | Output  | ChX
> +		                +-----------+-+         |  | Control +-->
> +		                      .     |           |  +---------+
> +		                      .     |           |    .
> +		                +-----------v-+ OC6REF  |    .
> +		                | Ch6 compare +---------+>
> +		                +-------------+
> +
> +		Example with: "compare_pulse_OC4REF_r_or_OC6REF_r":
> +
> +		                X
> +		              X   X
> +		            X .   . X
> +		          X   .   .   X
> +		        X     .   .     X
> +		count X .     .   .     . X
> +		        .     .   .     .
> +		        .     .   .     .
> +		        +---------------+
> +		OC4REF  |     .   .     |
> +		      +-+     .   .     +-+
> +		        .     +---+     .
> +		OC6REF  .     |   |     .
> +		      +-------+   +-------+
> +		        +-+   +-+
> +		TRGO2   | |   | |
> +		      +-+ +---+ +---------+
>  
>  What:		/sys/bus/iio/devices/triggerX/master_mode
>  KernelVersion:	4.11
> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> index 0f1a2cf..a0031b7 100644
> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> @@ -14,19 +14,19 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  
> -#define MAX_TRIGGERS 6
> +#define MAX_TRIGGERS 7
>  #define MAX_VALIDS 5
>  
>  /* List the triggers created by each timer */
>  static const void *triggers_table[][MAX_TRIGGERS] = {
> -	{ TIM1_TRGO, TIM1_CH1, TIM1_CH2, TIM1_CH3, TIM1_CH4,},
> +	{ TIM1_TRGO, TIM1_TRGO2, TIM1_CH1, TIM1_CH2, TIM1_CH3, TIM1_CH4,},
>  	{ TIM2_TRGO, TIM2_CH1, TIM2_CH2, TIM2_CH3, TIM2_CH4,},
>  	{ TIM3_TRGO, TIM3_CH1, TIM3_CH2, TIM3_CH3, TIM3_CH4,},
>  	{ TIM4_TRGO, TIM4_CH1, TIM4_CH2, TIM4_CH3, TIM4_CH4,},
>  	{ TIM5_TRGO, TIM5_CH1, TIM5_CH2, TIM5_CH3, TIM5_CH4,},
>  	{ TIM6_TRGO,},
>  	{ TIM7_TRGO,},
> -	{ TIM8_TRGO, TIM8_CH1, TIM8_CH2, TIM8_CH3, TIM8_CH4,},
> +	{ TIM8_TRGO, TIM8_TRGO2, TIM8_CH1, TIM8_CH2, TIM8_CH3, TIM8_CH4,},
>  	{ TIM9_TRGO, TIM9_CH1, TIM9_CH2,},
>  	{ }, /* timer 10 */
>  	{ }, /* timer 11 */
> @@ -56,9 +56,16 @@ struct stm32_timer_trigger {
>  	u32 max_arr;
>  	const void *triggers;
>  	const void *valids;
> +	bool has_trgo2;
>  };
>  
> +static bool stm32_timer_is_trgo2_name(const char *name)
> +{
> +	return !!strstr(name, "trgo2");
> +}
> +
>  static int stm32_timer_start(struct stm32_timer_trigger *priv,
> +			     struct iio_trigger *trig,
>  			     unsigned int frequency)
>  {
>  	unsigned long long prd, div;
> @@ -102,7 +109,12 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
>  	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, TIM_CR1_ARPE);
>  
>  	/* Force master mode to update mode */
> -	regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS, 0x20);
> +	if (stm32_timer_is_trgo2_name(trig->name))
> +		regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS2,
> +				   0x2 << TIM_CR2_MMS2_SHIFT);
> +	else
> +		regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS,
> +				   0x2 << TIM_CR2_MMS_SHIFT);
>  
>  	/* Make sure that registers are updated */
>  	regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
> @@ -150,7 +162,7 @@ static ssize_t stm32_tt_store_frequency(struct device *dev,
>  	if (freq == 0) {
>  		stm32_timer_stop(priv);
>  	} else {
> -		ret = stm32_timer_start(priv, freq);
> +		ret = stm32_timer_start(priv, trig, freq);
>  		if (ret)
>  			return ret;
>  	}
> @@ -183,6 +195,9 @@ static IIO_DEV_ATTR_SAMP_FREQ(0660,
>  			      stm32_tt_read_frequency,
>  			      stm32_tt_store_frequency);
>  
> +#define MASTER_MODE_MAX		7
> +#define MASTER_MODE2_MAX	15
> +
>  static char *master_mode_table[] = {
>  	"reset",
>  	"enable",
> @@ -191,7 +206,16 @@ static IIO_DEV_ATTR_SAMP_FREQ(0660,
>  	"OC1REF",
>  	"OC2REF",
>  	"OC3REF",
> -	"OC4REF"
> +	"OC4REF",
> +	/* Master mode selection 2 only */
> +	"OC5REF",
> +	"OC6REF",
> +	"compare_pulse_OC4REF",
> +	"compare_pulse_OC6REF",
> +	"compare_pulse_OC4REF_r_or_OC6REF_r",
> +	"compare_pulse_OC4REF_r_or_OC6REF_f",
> +	"compare_pulse_OC5REF_r_or_OC6REF_r",
> +	"compare_pulse_OC5REF_r_or_OC6REF_f",
>  };
>  
>  static ssize_t stm32_tt_show_master_mode(struct device *dev,
> @@ -199,10 +223,15 @@ static ssize_t stm32_tt_show_master_mode(struct device *dev,
>  					 char *buf)
>  {
>  	struct stm32_timer_trigger *priv = dev_get_drvdata(dev);
> +	struct iio_trigger *trig = to_iio_trigger(dev);
>  	u32 cr2;
>  
>  	regmap_read(priv->regmap, TIM_CR2, &cr2);
> -	cr2 = (cr2 & TIM_CR2_MMS) >> TIM_CR2_MMS_SHIFT;
> +
> +	if (stm32_timer_is_trgo2_name(trig->name))
> +		cr2 = (cr2 & TIM_CR2_MMS2) >> TIM_CR2_MMS2_SHIFT;
> +	else
> +		cr2 = (cr2 & TIM_CR2_MMS) >> TIM_CR2_MMS_SHIFT;
>  
>  	return snprintf(buf, PAGE_SIZE, "%s\n", master_mode_table[cr2]);
>  }
> @@ -212,13 +241,25 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
>  					  const char *buf, size_t len)
>  {
>  	struct stm32_timer_trigger *priv = dev_get_drvdata(dev);
> +	struct iio_trigger *trig = to_iio_trigger(dev);
> +	u32 mask, shift, master_mode_max;
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(master_mode_table); i++) {
> +	if (stm32_timer_is_trgo2_name(trig->name)) {
> +		mask = TIM_CR2_MMS2;
> +		shift = TIM_CR2_MMS2_SHIFT;
> +		master_mode_max = MASTER_MODE2_MAX;
> +	} else {
> +		mask = TIM_CR2_MMS;
> +		shift = TIM_CR2_MMS_SHIFT;
> +		master_mode_max = MASTER_MODE_MAX;
> +	}
> +
> +	for (i = 0; i <= master_mode_max; i++) {
>  		if (!strncmp(master_mode_table[i], buf,
>  			     strlen(master_mode_table[i]))) {
> -			regmap_update_bits(priv->regmap, TIM_CR2,
> -					   TIM_CR2_MMS, i << TIM_CR2_MMS_SHIFT);
> +			regmap_update_bits(priv->regmap, TIM_CR2, mask,
> +					   i << shift);
>  			/* Make sure that registers are updated */
>  			regmap_update_bits(priv->regmap, TIM_EGR,
>  					   TIM_EGR_UG, TIM_EGR_UG);
> @@ -229,8 +270,31 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
>  	return -EINVAL;
>  }
>  
> -static IIO_CONST_ATTR(master_mode_available,
> -	"reset enable update compare_pulse OC1REF OC2REF OC3REF OC4REF");
> +static ssize_t stm32_tt_show_master_mode_avail(struct device *dev,
> +					       struct device_attribute *attr,
> +					       char *buf)
> +{
> +	struct iio_trigger *trig = to_iio_trigger(dev);
> +	unsigned int i, master_mode_max;
> +	size_t len = 0;
> +
> +	if (stm32_timer_is_trgo2_name(trig->name))
> +		master_mode_max = MASTER_MODE2_MAX;
> +	else
> +		master_mode_max = MASTER_MODE_MAX;
> +
> +	for (i = 0; i <= master_mode_max; i++)
> +		len += scnprintf(buf + len, PAGE_SIZE - len,
> +			"%s ", master_mode_table[i]);
> +
> +	/* replace trailing space by newline */
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(master_mode_available, 0444,
> +		       stm32_tt_show_master_mode_avail, NULL, 0);
>  
>  static IIO_DEVICE_ATTR(master_mode, 0660,
>  		       stm32_tt_show_master_mode,
> @@ -240,7 +304,7 @@ static IIO_DEVICE_ATTR(master_mode, 0660,
>  static struct attribute *stm32_trigger_attrs[] = {
>  	&iio_dev_attr_sampling_frequency.dev_attr.attr,
>  	&iio_dev_attr_master_mode.dev_attr.attr,
> -	&iio_const_attr_master_mode_available.dev_attr.attr,
> +	&iio_dev_attr_master_mode_available.dev_attr.attr,
>  	NULL,
>  };
>  
> @@ -264,6 +328,12 @@ static int stm32_setup_iio_triggers(struct stm32_timer_trigger *priv)
>  
>  	while (cur && *cur) {
>  		struct iio_trigger *trig;
> +		bool cur_is_trgo2 = stm32_timer_is_trgo2_name(*cur);
> +
> +		if (cur_is_trgo2 && !priv->has_trgo2) {
> +			cur++;
> +			continue;
> +		}
>  
>  		trig = devm_iio_trigger_alloc(priv->dev, "%s", *cur);
>  		if  (!trig)
> @@ -277,7 +347,7 @@ static int stm32_setup_iio_triggers(struct stm32_timer_trigger *priv)
>  		 * should only be available on trgo trigger which
>  		 * is always the first in the list.
>  		 */
> -		if (cur == priv->triggers)
> +		if (cur == priv->triggers || cur_is_trgo2)
>  			trig->dev.groups = stm32_trigger_attr_groups;
>  
>  		iio_trigger_set_drvdata(trig, priv);
> @@ -584,6 +654,20 @@ bool is_stm32_timer_trigger(struct iio_trigger *trig)
>  }
>  EXPORT_SYMBOL(is_stm32_timer_trigger);
>  
> +static void stm32_timer_detect_trgo2(struct stm32_timer_trigger *priv)
> +{
> +	u32 val;
> +
> +	/*
> +	 * Master mode selection 2 bits can only be written and read back when
> +	 * timer supports it.
> +	 */
> +	regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS2, TIM_CR2_MMS2);
> +	regmap_read(priv->regmap, TIM_CR2, &val);
> +	regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS2, 0);
> +	priv->has_trgo2 = !!val;
> +}
> +
>  static int stm32_timer_trigger_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -614,6 +698,7 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
>  	priv->max_arr = ddata->max_arr;
>  	priv->triggers = triggers_table[index];
>  	priv->valids = valids_table[index];
> +	stm32_timer_detect_trgo2(priv);
>  
>  	ret = stm32_setup_iio_triggers(priv);
>  	if (ret)
> diff --git a/include/linux/iio/timer/stm32-timer-trigger.h b/include/linux/iio/timer/stm32-timer-trigger.h
> index 55535ae..fa7d786 100644
> --- a/include/linux/iio/timer/stm32-timer-trigger.h
> +++ b/include/linux/iio/timer/stm32-timer-trigger.h
> @@ -10,6 +10,7 @@
>  #define _STM32_TIMER_TRIGGER_H_
>  
>  #define TIM1_TRGO	"tim1_trgo"
> +#define TIM1_TRGO2	"tim1_trgo2"
>  #define TIM1_CH1	"tim1_ch1"
>  #define TIM1_CH2	"tim1_ch2"
>  #define TIM1_CH3	"tim1_ch3"
> @@ -44,6 +45,7 @@
>  #define TIM7_TRGO	"tim7_trgo"
>  
>  #define TIM8_TRGO	"tim8_trgo"
> +#define TIM8_TRGO2	"tim8_trgo2"
>  #define TIM8_CH1	"tim8_ch1"
>  #define TIM8_CH2	"tim8_ch2"
>  #define TIM8_CH3	"tim8_ch3"
> diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
> index 4a0abbc..ce7346e 100644
> --- a/include/linux/mfd/stm32-timers.h
> +++ b/include/linux/mfd/stm32-timers.h
> @@ -34,6 +34,7 @@
>  #define TIM_CR1_DIR	BIT(4)  /* Counter Direction	   */
>  #define TIM_CR1_ARPE	BIT(7)	/* Auto-reload Preload Ena */
>  #define TIM_CR2_MMS	(BIT(4) | BIT(5) | BIT(6)) /* Master mode selection */
> +#define TIM_CR2_MMS2	GENMASK(23, 20) /* Master mode selection 2 */
>  #define TIM_SMCR_SMS	(BIT(0) | BIT(1) | BIT(2)) /* Slave mode selection */
>  #define TIM_SMCR_TS	(BIT(4) | BIT(5) | BIT(6)) /* Trigger selection */
>  #define TIM_DIER_UIE	BIT(0)	/* Update interrupt	   */
> @@ -60,6 +61,7 @@
>  
>  #define MAX_TIM_PSC		0xFFFF
>  #define TIM_CR2_MMS_SHIFT	4
> +#define TIM_CR2_MMS2_SHIFT	20
>  #define TIM_SMCR_TS_SHIFT	4
>  #define TIM_BDTR_BKF_MASK	0xF
>  #define TIM_BDTR_BKF_SHIFT	16
> 

