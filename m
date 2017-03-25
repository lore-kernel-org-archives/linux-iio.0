Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44130 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751511AbdCYSaE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Mar 2017 14:30:04 -0400
Subject: Re: [PATCH v2 2/2] iio: stm32 trigger: Add counter enable modes
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        vilhelm.gray@gmail.com
References: <1490364043-16339-1-git-send-email-benjamin.gaignard@st.com>
 <1490364043-16339-3-git-send-email-benjamin.gaignard@st.com>
Cc: fabrice.gasnier@st.com, linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Michael Welling <mwelling@ieee.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <31b4d14b-b900-b6ac-0e3b-4f10433385da@kernel.org>
Date: Sat, 25 Mar 2017 18:29:18 +0000
MIME-Version: 1.0
In-Reply-To: <1490364043-16339-3-git-send-email-benjamin.gaignard@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/03/17 14:00, Benjamin Gaignard wrote:
> Device counting could be controlled by the level or the edges of
> a trigger.
> in_count0_enable_mode attibute allow to set the control mode.
Thanks for separating this out from the more 'obvious' driver elements
in the previous patch.  Makes it into nice bite sized units!.

Looks good to me - again, feedback from others welcome so we should
let this sit for a week or so and see what people come back with.

Thanks,

Jonathan
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-timer-stm32          | 23 +++++++
>  drivers/iio/trigger/stm32-timer-trigger.c          | 70 ++++++++++++++++++++++
>  2 files changed, 93 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> index fbdee4f..1886f2c 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> @@ -59,3 +59,26 @@ Description:
>  		quadrature:
>  			Encoder A and B inputs are mixed to get direction
>  			and count with a scale of 0.25.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_count_enable_mode_available
> +KernelVersion:	4.12
> +Contact:	benjamin.gaignard@st.com
> +Description:
> +		Reading returns the list possible enable modes.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_count0_enable_mode
> +KernelVersion:	4.12
> +Contact:	benjamin.gaignard@st.com
> +Description:
> +		Configure the device counter enable modes, in all case
> +		counting direction is set by in_count0_count_direction
> +		attribute and the counter is clocked by the internal clock.
> +		always:
> +			Counter is always ON.
> +
> +		gated:
> +			Counting is enabled when connected trigger signal
> +			level is high else counting is disabled.
> +
> +		triggered:
> +			Counting start on rising edge of the connected trigger.
I'm happy for now with these remaining device specific. Will be interesting
to see how this stuff develops.

> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> index 48d2bf9..8a87810 100644
> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> @@ -353,6 +353,74 @@ static int stm32_trigger_write_raw(struct iio_dev *indio_dev,
>  	.write_raw = stm32_trigger_write_raw
>  };
>  
> +static const char *const stm32_enable_modes[] = {
> +	"always",
> +	"gated",
> +	"triggered",
> +};
> +
> +static int stm32_enable_mode2sms(int mode)
> +{
> +	switch (mode) {
> +	case 0:
> +		return 0;
> +	case 1:
> +		return 5;
> +	case 2:
> +		return 6;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int stm32_set_enable_mode(struct iio_dev *indio_dev,
> +				 const struct iio_chan_spec *chan,
> +				 unsigned int mode)
> +{
> +	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
> +	int sms = stm32_enable_mode2sms(mode);
> +
> +	if (sms < 0)
> +		return sms;
> +
> +	regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS, sms);
> +
> +	return 0;
> +}
> +
> +static int stm32_sms2enable_mode(int mode)
> +{
> +	switch (mode) {
> +	case 0:
> +		return 0;
> +	case 5:
> +		return 1;
> +	case 6:
> +		return 2;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int stm32_get_enable_mode(struct iio_dev *indio_dev,
> +				 const struct iio_chan_spec *chan)
> +{
> +	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
> +	u32 smcr;
> +
> +	regmap_read(priv->regmap, TIM_SMCR, &smcr);
> +	smcr &= TIM_SMCR_SMS;
> +
> +	return stm32_sms2enable_mode(smcr);
> +}
> +
> +static const struct iio_enum stm32_enable_mode_enum = {
> +	.items = stm32_enable_modes,
> +	.num_items = ARRAY_SIZE(stm32_enable_modes),
> +	.set = stm32_set_enable_mode,
> +	.get = stm32_get_enable_mode
> +};
> +
>  static const char *const stm32_quadrature_modes[] = {
>  	"channel_A",
>  	"channel_B",
> @@ -466,6 +534,8 @@ static ssize_t stm32_count_set_preset(struct iio_dev *indio_dev,
>  	IIO_ENUM_AVAILABLE("count_direction", &stm32_count_direction_enum),
>  	IIO_ENUM("quadrature_mode", IIO_SEPARATE, &stm32_quadrature_mode_enum),
>  	IIO_ENUM_AVAILABLE("quadrature_mode", &stm32_quadrature_mode_enum),
> +	IIO_ENUM("enable_mode", IIO_SEPARATE, &stm32_enable_mode_enum),
> +	IIO_ENUM_AVAILABLE("enable_mode", &stm32_enable_mode_enum),
>  	{}
>  };
>  
> 

