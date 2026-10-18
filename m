Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62C13BAD81;
	Sun, 18 Oct 2026 03:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792294145; cv=none; b=WMLt/LHNP5vYFOzN/qetlQE/C/DBxIly3yo6GOHuZPImTQSlrsqdlGd0AMEpWnaafrUs5+Znx1TseqQo5HlUITKgv6YmOs3DRlkl5Cnjl2IkceZW9JA+XzpnM6nG9u8MXQnp3iDyDjC3ZvuTgrBHnIN/dVxQAxW9FwQD/J8MVLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792294145; c=relaxed/simple;
	bh=1tll22J59xsF/c7AE3QmrA+McfvyvyxYVZiQgx9gxNE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ayzZ3yRL5ODJtmn7GvY2iQTy6WGIHG/tsE7ffpaA5871w0mofpwP9JHe0tenfkpgtV120Sw9kHR/Eje7ENfZ4j2WRoIMFp2W5evBk5HSA1P0RPSLoJRCqZRKmH657mKNPCIrSkXShvmHk48uHXwCKtMQzkDvYTmcSRRRYNXuiUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jtn3lQI3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jtn3lQI3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48F01F000C5;
	Sun, 18 Oct 2026 03:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792294141;
	bh=osv9pyDkowGvTx/I0/emUosd7vDDhGqa7XKl5MfoodA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Jtn3lQI3miAG11KaQHszY+kWwis8P6IHUPDwDyqXtzjDSkCZiIWn2gTbsv2aWY+O9
	 Lf0+mNhSkO4j1bFNxcmhqlbaYhmA+EI+LF8dFEwBXDG0sXYblFSv02Lv22BTCD6ds5
	 POMggDtPw7i8+SRU6DUj6bF71G5/m+odF2EFBnJFf/Q/H32xgc8+PpVqEu3OA9VvvB
	 UJ7+Fiu/GAV1LdRybqSJgu7YEBQjgY6k+CgibudLKGUg8ITXHSg6bMMAdCr5ILTZ8+
	 Wi6Iwt71/kGDbpN6O+Q7BZapO5dlB2EHPC6M/n76iHk1itFaza0JqmagjFADTcLXfp
	 iqs9jQlCKcztg==
Date: Sun, 18 Oct 2026 04:28:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrei Stancovici via B4 Relay
 <devnull+andrei.stancovici.analog.com@kernel.org>
Cc: andrei.stancovici@analog.com, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] iio: adc: ltc2497: add FA/FB line-frequency
 rejection selection
Message-ID: <20261018042854.00c0d6a1@jic23-hlaptop>
In-Reply-To: <20261009-submission-ltc2493-support-v1-v1-5-3dad1d4b152a@analog.com>
References: <20261009-submission-ltc2493-support-v1-v1-0-3dad1d4b152a@analog.com>
	<20261009-submission-ltc2493-support-v1-v1-5-3dad1d4b152a@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 09 Oct 2026 11:43:38 +0300
Andrei Stancovici via B4 Relay <devnull+andrei.stancovici.analog.com@kernel.org> wrote:

> From: Andrei Stancovici <andrei.stancovici@analog.com>
> 
> The LTC2499 can suppress mains interference at 50Hz, 60Hz, or
> simultaneously at both (the power-up default). Expose it through
> filter_mode and filter_mode_available on the voltage channels.
> 
> The conversion time also depends on the rejection mode: 50Hz-only is the
> longest at 163.5 ms (1x). The previous 150 ms budget was 13.5 ms short,
> risking a mid-conversion reprogram in 50Hz-only 1x mode.
> 
> Tested on live LTC2499 hardware connected through an IIO network backend:
> all three modes are selectable and readable; voltage reads succeed in each
> mode; conversion times are respected; temperature reads honour the
> rejection selection.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/2499fa.pdf
> Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
> ---
>  drivers/iio/adc/ltc2497-core.c | 159 +++++++++++++++++++++++++++++++++--------
>  drivers/iio/adc/ltc2497.c      |  50 +++++++++----
>  drivers/iio/adc/ltc2497.h      |  44 +++++++++---
>  3 files changed, 200 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
> index 816312bf0e90..e5a8ab568128 100644
> --- a/drivers/iio/adc/ltc2497-core.c
> +++ b/drivers/iio/adc/ltc2497-core.c

> +
> +static int ltc2497core_set_filter_mode(struct iio_dev *indio_dev,
> +				       const struct iio_chan_spec *chan,
> +				       unsigned int val)
> +{
> +	struct ltc2497core_driverdata *ddata = iio_priv(indio_dev);
> +
> +	mutex_lock(&ddata->lock);

Can use a guard() here as well as below.

Maybe look more generally at making use of that newer stuff
in the driver (not as part of this series though!)

> +	ddata->rejection = val;
> +	/*
> +	 * The new rejection mode only takes effect once the second command byte
> +	 * is reprogrammed, so force the next read to reprogram rather than reuse
> +	 * the value already latched for this address.  LTC2497_CONFIG_DEFAULT is
> +	 * not a valid channel/temperature address, so it is a safe re-arm
> +	 * sentinel (as used at probe).
> +	 *
> +	 * A conversion started under the old rejection mode may still be in
> +	 * flight; its own duration (conv_time_prev), not the new mode's, still
> +	 * gates the next reprogram, so the timing state is left untouched here.
> +	 */
> +	ddata->addr_prev = LTC2497_CONFIG_DEFAULT;
> +	mutex_unlock(&ddata->lock);
> +
> +	return 0;
> +}
> +
> +static int ltc2497core_get_filter_mode(struct iio_dev *indio_dev,
> +				       const struct iio_chan_spec *chan)
> +{
> +	struct ltc2497core_driverdata *ddata = iio_priv(indio_dev);
> +	enum ltc2497_rejection rejection;
> +
> +	mutex_lock(&ddata->lock);
Consider if worth doing:
	guard(mutex)(&data->lock);

	return ddata->rejection;

Trade off is looks different from existing code (unless you fancy
updating that as well).

> +	rejection = ddata->rejection;
> +	mutex_unlock(&ddata->lock);
> +
> +	return rejection;
> +}

>  #define LTC2497_CHAN(_chan, _addr, _ds_name, _extra_mask) { \
>  	.type = IIO_VOLTAGE, \
>  	.indexed = 1, \
> @@ -404,6 +484,27 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
>  	if (!ddata->chip_info->has_temp)
>  		indio_dev->num_channels--;
>  
> +	if (ddata->chip_info->has_rejection_mode) {
> +		struct iio_chan_spec *channels;
> +		unsigned int i;
> +
> +		/*
> +		 * Rejection applies to every channel; ext_info is attached at
> +		 * probe because a const table would expose filter_mode on all
> +		 * parts unconditionally.

You could have a bonus set of channels to pick instead of using a copy
and update approach.  As such I'd drop this comment as somewhat confusing.
The implementation is fine.

> +		 */
> +		channels = devm_kmemdup(dev, indio_dev->channels,
> +					indio_dev->num_channels * sizeof(*channels),
> +					GFP_KERNEL);
> +		if (!channels)
> +			return -ENOMEM;
> +
> +		for (i = 0; i < indio_dev->num_channels; i++)
> +			channels[i].ext_info = ltc2497core_ext_info;
> +
> +		indio_dev->channels = channels;
> +	}

> diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> index a655b04e2454..0df2ad9b3243 100644
> --- a/drivers/iio/adc/ltc2497.c
> +++ b/drivers/iio/adc/ltc2497.c
> @@ -38,6 +38,23 @@ struct ltc2497_driverdata {
>  	} data __aligned(IIO_DMA_MINALIGN);
>  };
>  
> +/*
> + * The reserved FA = FB = 1 combination is not reachable: the enum has no
> + * enumerator for it.
> + */
> +static u8 ltc2497_rejection_bits(enum ltc2497_rejection rejection)
> +{
> +	switch (rejection) {
> +	case LTC2499_REJECT_50:
> +		return LTC2499_FB;
> +	case LTC2499_REJECT_60:
> +		return LTC2499_FA;

As mentioned below, I'd use values 0 1 and 2 rather than the bit
values. That avoids the oddity of REJECT_50_60 not being b11 which
you'd expect if the bits were independent things.

> +	case LTC2499_REJECT_50_60:
> +	default:
> +		return 0;
> +	}
> +}

> diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
> index 219f7d49854b..34ea62c2a4bc 100644
> --- a/drivers/iio/adc/ltc2497.h
> +++ b/drivers/iio/adc/ltc2497.h

>  /*
>   * Sentinel passed as `address` to result_and_measure() to request a
> @@ -24,13 +28,29 @@
>  /* Second config-byte bits (LTC2499 / LTC2493 only) */
>  #define LTC2499_EN2			BIT(7)	/* enable second config byte */
>  #define LTC2499_IM			BIT(6)	/* 1 = measure internal temp sensor */
> +#define LTC2499_FA			BIT(5)	/* line-rejection select bit A */
> +#define LTC2499_FB			BIT(4)	/* line-rejection select bit B */
Hmm. Next to each other. Given reject both is b00 I'd just make these
a 2 bit field and have the values as 0, 1, 2
>  #define LTC2499_SPD			BIT(3)	/* 1 = 2x output rate (offset cal off) */
>  
> +/*
> + * Line-frequency rejection modes selected by FA/FB in the second config byte.
> + * The datasheet's fourth combination (FA = FB = 1) is reserved, so it is not
> + * given an enumerator and is unreachable through this driver.

I'd drop this bit. Not a detail we need to call out in the driver. If anyone
wonders, they can go look at the datasheet. If we called out every reserved
value we'd end up with a lot of boring docs!

>  Applies to both
> + * voltage and temperature conversions (unlike SPD, which the part ignores while
> + * measuring temperature).
> + */
> +enum ltc2497_rejection {
> +	LTC2499_REJECT_50_60,	/* FA=0 FB=0: simultaneous 50/60Hz (default) */
> +	LTC2499_REJECT_50,	/* FA=0 FB=1: 50Hz only */
> +	LTC2499_REJECT_60,	/* FA=1 FB=0: 60Hz only */
> +};

>  
> @@ -41,8 +61,14 @@ struct ltc2497core_driverdata {
>  	struct mutex lock;
>  	const struct ltc2497_chip_info	*chip_info;
>  	u8 addr_prev;
> -	bool speed_2x;	/* SPD: false = 1x (default), true = 2x */
> -	/* Conversion time (ms) of the conversion currently in flight. */
> +	bool speed_2x;		/* SPD: false = 1x (default), true = 2x */

I'm not seeing a clear advantage in changing that indent. So put it back
to reduce the noise in the patch.

> +	enum ltc2497_rejection rejection;	/* FA/FB line-rejection select */
> +	/*
> +	 * Conversion time (ms) of the conversion currently in flight.  It is
> +	 * fixed by the mode active when that conversion was started, which
> +	 * differs from the newly selected mode for the first read after a
> +	 * sampling_frequency or filter_mode change.
> +	 */
>  	unsigned int conv_time_prev;
>  	int (*result_and_measure)(struct ltc2497core_driverdata *ddata,
>  				  u8 address, int *val);
> 

