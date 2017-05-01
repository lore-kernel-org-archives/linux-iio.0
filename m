Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42427 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764683AbdEAQmn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 May 2017 12:42:43 -0400
Subject: Re: [PATCH 2/2] iio: make stm32 trigger driver use
 INDIO_HARDWARE_TRIGGERED mode
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        vilhelm.gray@gmail.com, mwelling@ieee.org
Cc: fabrice.gasnier@st.com, linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
References: <1493299756-18157-1-git-send-email-benjamin.gaignard@st.com>
 <1493299756-18157-3-git-send-email-benjamin.gaignard@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <22f5c5c2-bab4-a583-108e-11fbaf233eed@kernel.org>
Date: Mon, 1 May 2017 01:50:52 +0100
MIME-Version: 1.0
In-Reply-To: <1493299756-18157-3-git-send-email-benjamin.gaignard@st.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/04/17 14:29, Benjamin Gaignard wrote:
> Add validate function to be use to use the correct trigger.
> Add an attribute to configure device mode like for quadrature and
> enable modes
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Hmm.  I think I quite like this as an approach but have changed my
mind several times over the last few days :)

Hence I'd ideally like some more opinions and will be leaving it
on the list for at least a short time longer.

It's missed the current merge window anyway so plenty of time to
tick off this last element of your support.

I also just checked and our docs for the existing modes is rubbish
(or I can't find it with a quick grep ;)
so we should tidy that up and add some description of this as well.	

Jonathan
> ---
>  .../ABI/testing/sysfs-bus-iio-timer-stm32          | 15 ++++++
>  drivers/iio/trigger/stm32-timer-trigger.c          | 61 ++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> index 230020e..cccdf57 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> @@ -90,3 +90,18 @@ Description:
>  			Counting is enabled on rising edge of the connected
>  			trigger, and remains enabled for the duration of this
>  			selected mode.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_count_trigger_mode_available
> +KernelVersion:	4.13
> +Contact:	benjamin.gaignard@st.com
> +Description:
> +		Reading returns the list possible trigger modes.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_count0_trigger_mode
> +KernelVersion:	4.13
> +Contact:	benjamin.gaignard@st.com
> +Description:
> +		Configure the device counter trigger mode
> +		counting direction is set by in_count0_count_direction
> +		attribute and the counter is clocked by the connected trigger
> +		rising edges.
> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> index 0f1a2cf..7c6e90e 100644
> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> @@ -347,12 +347,70 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> +static int stm32_counter_validate_trigger(struct iio_dev *indio_dev,
> +					  struct iio_trigger *trig)
> +{
> +	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
> +	const char * const *cur = priv->valids;
> +	unsigned int i = 0;
> +
> +	if (!is_stm32_timer_trigger(trig))
> +		return -EINVAL;
> +
> +	while (cur && *cur) {
> +		if (!strncmp(trig->name, *cur, strlen(trig->name))) {
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
>  static const struct iio_info stm32_trigger_info = {
>  	.driver_module = THIS_MODULE,
> +	.validate_trigger = stm32_counter_validate_trigger,
>  	.read_raw = stm32_counter_read_raw,
>  	.write_raw = stm32_counter_write_raw
>  };
>  
> +static const char *const stm32_trigger_modes[] = {
> +	"trigger",
> +};
> +
> +static int stm32_set_trigger_mode(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan,
> +				  unsigned int mode)
> +{
> +	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
> +
> +	regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS, TIM_SMCR_SMS);
> +
> +	return 0;
> +}
> +
> +static int stm32_get_trigger_mode(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan)
> +{
> +	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
> +	u32 smcr;
> +
> +	regmap_read(priv->regmap, TIM_SMCR, &smcr);
> +
> +	return smcr == TIM_SMCR_SMS ? 0 : -EINVAL;
> +}
> +
> +static const struct iio_enum stm32_trigger_mode_enum = {
> +	.items = stm32_trigger_modes,
> +	.num_items = ARRAY_SIZE(stm32_trigger_modes),
> +	.set = stm32_set_trigger_mode,
> +	.get = stm32_get_trigger_mode
> +};
> +
>  static const char *const stm32_enable_modes[] = {
>  	"always",
>  	"gated",
> @@ -536,6 +594,8 @@ static ssize_t stm32_count_set_preset(struct iio_dev *indio_dev,
>  	IIO_ENUM_AVAILABLE("quadrature_mode", &stm32_quadrature_mode_enum),
>  	IIO_ENUM("enable_mode", IIO_SEPARATE, &stm32_enable_mode_enum),
>  	IIO_ENUM_AVAILABLE("enable_mode", &stm32_enable_mode_enum),
> +	IIO_ENUM("trigger_mode", IIO_SEPARATE, &stm32_trigger_mode_enum),
> +	IIO_ENUM_AVAILABLE("trigger_mode", &stm32_trigger_mode_enum),
>  	{}
>  };
>  
> @@ -560,6 +620,7 @@ static struct stm32_timer_trigger *stm32_setup_counter_device(struct device *dev
>  	indio_dev->name = dev_name(dev);
>  	indio_dev->dev.parent = dev;
>  	indio_dev->info = &stm32_trigger_info;
> +	indio_dev->modes = INDIO_HARDWARE_TRIGGERED;
>  	indio_dev->num_channels = 1;
>  	indio_dev->channels = &stm32_trigger_channel;
>  	indio_dev->dev.of_node = dev->of_node;
> 

