Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56019 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbcCEPQJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Mar 2016 10:16:09 -0500
Subject: Re: [PATCH 3/3] iio:adc:at91-sama5d2: add support for signed
 conversion
To: Ludovic Desroches <ludovic.desroches@atmel.com>
References: <1457021355-23898-1-git-send-email-ludovic.desroches@atmel.com>
 <1457021355-23898-4-git-send-email-ludovic.desroches@atmel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56DAF836.801@kernel.org>
Date: Sat, 5 Mar 2016 15:16:06 +0000
MIME-Version: 1.0
In-Reply-To: <1457021355-23898-4-git-send-email-ludovic.desroches@atmel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/03/16 16:09, Ludovic Desroches wrote:
> The at91-sama5d2 ADC controller can achieve unsigned and signed
> conversion. For each channel, a signed and an unsigned variant are
> created.
> We can't set the sign mode for each channel. For that reason, the
> controller has to be configured upon conversion requests.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Hmm. This should have a documentation patch as well as it breaks with
standard ABI.  I really don't like using the extended name for this.
Firstly, doing so changes the presented ABI to userspace and makes
it non standard and secondly the channels are only differentiated at
some levels (sysfs attribute naming for example.)  This really isn't
a generic enough approach.

I'd argue that we need a cleaner way of supporting this. Easy enough to add
an infomask element for this (I thought about an enum but _singed is clear
enough).

In this driver, that is all that would be needed.  Gets more interesting
for buffered drivers, where we'd need to provide an alternative to how
the channel type readback works (probably an optional callback in iio_info).
(was envisioning this from the first, but have never implemented it).

Anyhow, I guess we need to do this generically at somepoint.  Right now
all we need is the ABI for configuring on non buffered devices.

in_voltageX_signed with 1 and 0 as possible values should do the job I think...

Jonathan
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 81 +++++++++++++++++++++++++++++++-------
>  1 file changed, 67 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 5bc038f..d4bf73f 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -105,8 +105,26 @@
>  #define AT91_SAMA5D2_LCCWR	0x38
>  /* Overrun Status Register */
>  #define AT91_SAMA5D2_OVER	0x3c
> +
>  /* Extended Mode Register */
>  #define AT91_SAMA5D2_EMR	0x40
> +/* Sign Mode */
> +#define AT91_SAMA5D2_EMR_SIGNMODE(v)		((v) << 25)
> +/*
> + * Single-Ended channels: Unsigned conversions.
> + * Differential channels: Signed conversions.
> + */
> +#define AT91_SAMA5D2_EMR_SE_UNSG_DF_SIGN	0
> +/*
> + * Single-Ended channels: Signed conversions.
> + * Differential channels: Unsigned conversions.
> + */
> +#define AT91_SAMA5D2_EMR_SE_SIGN_DF_UNSG	1
> +/* All channels: Unsigned conversions */
> +#define AT91_SAMA5D2_EMR_ALL_UNSIGNED		2
> +/* All channels: Signed conversions */
> +#define AT91_SAMA5D2_EMR_ALL_SIGNED		3
> +
>  /* Compare Window Register */
>  #define AT91_SAMA5D2_CWR	0x44
>  /* Channel Gain Register */
> @@ -140,13 +158,14 @@
>  /* Version Register */
>  #define AT91_SAMA5D2_VERSION	0xfc
>  
> -#define AT91_SAMA5D2_CHAN(num, addr)					\
> +#define AT91_SAMA5D2_VOLTAGE_CHANNEL(num, addr, sign_mode)		\
>  	{								\
>  		.type = IIO_VOLTAGE,					\
>  		.channel = num,						\
>  		.address = addr,					\
> +		.extend_name = (sign_mode == 's') ? "signed" : "unsigned",\
>  		.scan_type = {						\
> -			.sign = 'u',					\
> +			.sign = sign_mode,				\
>  			.realbits = 12,					\
>  		},							\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> @@ -156,6 +175,12 @@
>  		.indexed = 1,						\
>  	}
>  
> +#define AT91_SAMA5D2_SIGNED_VOLTAGE_CHANNEL(num, addr)		\
> +	AT91_SAMA5D2_VOLTAGE_CHANNEL(num, addr, 's')
> +
> +#define AT91_SAMA5D2_UNSIGNED_VOLTAGE_CHANNEL(num, addr)	\
> +	AT91_SAMA5D2_VOLTAGE_CHANNEL(num, addr, 'u')
> +
>  #define at91_adc_readl(st, reg)		readl_relaxed(st->base + reg)
>  #define at91_adc_writel(st, reg, val)	writel_relaxed(val, st->base + reg)
>  
> @@ -185,18 +210,30 @@ struct at91_adc_state {
>  };
>  
>  static const struct iio_chan_spec at91_adc_channels[] = {
> -	AT91_SAMA5D2_CHAN(0, 0x50),
> -	AT91_SAMA5D2_CHAN(1, 0x54),
> -	AT91_SAMA5D2_CHAN(2, 0x58),
> -	AT91_SAMA5D2_CHAN(3, 0x5c),
> -	AT91_SAMA5D2_CHAN(4, 0x60),
> -	AT91_SAMA5D2_CHAN(5, 0x64),
> -	AT91_SAMA5D2_CHAN(6, 0x68),
> -	AT91_SAMA5D2_CHAN(7, 0x6c),
> -	AT91_SAMA5D2_CHAN(8, 0x70),
> -	AT91_SAMA5D2_CHAN(9, 0x74),
> -	AT91_SAMA5D2_CHAN(10, 0x78),
> -	AT91_SAMA5D2_CHAN(11, 0x7c),
> +	AT91_SAMA5D2_UNSIGNED_VOLTAGE_CHANNEL(0, 0x50),
> +	AT91_SAMA5D2_UNSIGNED_VOLTAGE_CHANNEL(1, 0x54),
> +	AT91_SAMA5D2_UNSIGNED_VOLTAGE_CHANNEL(2, 0x58),
> +	AT91_SAMA5D2_UNSIGNED_VOLTAGE_CHANNEL(3, 0x5c),
> +	AT91_SAMA5D2_UNSIGNED_VOLTAGE_CHANNEL(4, 0x60),
> +	AT91_SAMA5D2_UNSIGNED_VOLTAGE_CHANNEL(5, 0x64),
> +	AT91_SAMA5D2_UNSIGNED_VOLTAGE_CHANNEL(6, 0x68),
> +	AT91_SAMA5D2_UNSIGNED_VOLTAGE_CHANNEL(7, 0x6c),
> +	AT91_SAMA5D2_UNSIGNED_VOLTAGE_CHANNEL(8, 0x70),
> +	AT91_SAMA5D2_UNSIGNED_VOLTAGE_CHANNEL(9, 0x74),
> +	AT91_SAMA5D2_UNSIGNED_VOLTAGE_CHANNEL(10, 0x78),
> +	AT91_SAMA5D2_UNSIGNED_VOLTAGE_CHANNEL(11, 0x7c),
> +	AT91_SAMA5D2_SIGNED_VOLTAGE_CHANNEL(0, 0x50),
> +	AT91_SAMA5D2_SIGNED_VOLTAGE_CHANNEL(1, 0x54),
> +	AT91_SAMA5D2_SIGNED_VOLTAGE_CHANNEL(2, 0x58),
> +	AT91_SAMA5D2_SIGNED_VOLTAGE_CHANNEL(3, 0x5c),
> +	AT91_SAMA5D2_SIGNED_VOLTAGE_CHANNEL(4, 0x60),
> +	AT91_SAMA5D2_SIGNED_VOLTAGE_CHANNEL(5, 0x64),
> +	AT91_SAMA5D2_SIGNED_VOLTAGE_CHANNEL(6, 0x68),
> +	AT91_SAMA5D2_SIGNED_VOLTAGE_CHANNEL(7, 0x6c),
> +	AT91_SAMA5D2_SIGNED_VOLTAGE_CHANNEL(8, 0x70),
> +	AT91_SAMA5D2_SIGNED_VOLTAGE_CHANNEL(9, 0x74),
> +	AT91_SAMA5D2_SIGNED_VOLTAGE_CHANNEL(10, 0x78),
> +	AT91_SAMA5D2_SIGNED_VOLTAGE_CHANNEL(11, 0x7c),
>  };
>  
>  static unsigned at91_adc_startup_time(unsigned startup_time_min,
> @@ -278,6 +315,7 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
>  			     int *val, int *val2, long mask)
>  {
>  	struct at91_adc_state *st = iio_priv(indio_dev);
> +	u32 emr;
>  	int ret;
>  
>  	switch (mask) {
> @@ -286,6 +324,19 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
>  
>  		st->chan = chan;
>  
> +		/* Read EMR register and clear 'sign mode' field */
> +		emr = at91_adc_readl(st, AT91_SAMA5D2_EMR)
> +		      & AT91_SAMA5D2_EMR_SIGNMODE(0);
> +		/*
> +		 * Check if the user requested a conversion on a signed or
> +		 * unsigned channel.
> +		 */
> +		if (chan->scan_type.sign == 's')
> +			emr |= AT91_SAMA5D2_EMR_SIGNMODE(AT91_SAMA5D2_EMR_ALL_SIGNED);
> +		else
> +			emr |= AT91_SAMA5D2_EMR_SIGNMODE(AT91_SAMA5D2_EMR_ALL_UNSIGNED);
> +
> +		at91_adc_writel(st, AT91_SAMA5D2_EMR, emr);
>  		at91_adc_writel(st, AT91_SAMA5D2_CHER, BIT(chan->channel));
>  		at91_adc_writel(st, AT91_SAMA5D2_IER, BIT(chan->channel));
>  		at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_START);
> @@ -298,6 +349,8 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
>  
>  		if (ret > 0) {
>  			*val = st->conversion_value;
> +			if (chan->scan_type.sign == 's')
> +				*val = sign_extend32(*val, 11);
>  			ret = IIO_VAL_INT;
>  			st->conversion_done = false;
>  		}
> 

