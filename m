Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3642AD37;
	Mon,  7 Sep 2026 01:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788744138; cv=none; b=WMpz+w5CeoWBH5DXuqmhltxelebeuPo2tP4Gzv4u786SlW7Bc6hLi72KYL7WDKB0974P+EaYUjrm9yyJ2sx36MqTG4dJP62Wvs99QDp4niAm65pLOn4zG+B+1L6Va/sCGHpISfaQvcThQWl8OG+it/eVaJKe63hA3hlN9ugBcOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788744138; c=relaxed/simple;
	bh=MDYKyQ0f29Ve6rVSBm30ZRvbIwbnenY+ZRdB2kJlQNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTu7IZ6Rpo4TKzckf94G7uJe/zoylWDQhZCPb3qmsq1K0+9MvLFghhw7p9ZZmpTveliEGse9c9QlfyhIWJtYD1ZsWBY2qPNo0x5zxgnF044gfv+LI+wNyYMCfOemWwSSZpzC9j4kjeDKGnxVqPxGNBjer+1KH3jSlZ01qmeB2ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0ELCv0C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0ELCv0C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E231F00A3A;
	Mon,  7 Sep 2026 01:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788744137;
	bh=RPNMUoYPJkgGET1jnQ70Ai0lnYagTYostkXavaOTy44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U0ELCv0COasA/HNJjTlHkkRjokWyAlWKtpdl8qz/GYIp3XpTFXTXgh6l4jE0XU+iz
	 2BCmgcPAmd2zsNU+Qk31z7W9vtcsGSsrR1I2GX/l8qQNrmgTTrG97jiPIUNTzH0DWC
	 JIkTELLaWkJU2OyD1lzneVSi+T2bErDVlKjIboFyeV7PunjZTj8eL3DCyzlFuvSs6P
	 1Fhz/bd2n6lWdrprok9U5hdhR+dWjVnc5YGs3GjIEJ3/7TjKRL/xN8NYO2ukvwfAhR
	 zxu1mTLy2Gwk/ASG+KpLCNkwrtYZtqCg3crp37dkh3GNzSy3bXN4mmqsGa4IDluLRs
	 DMmQh0Ax6CV5w==
Date: Mon, 7 Sep 2026 02:22:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrei Stancovici <andrei.stancovici@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, "Rob Herring" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>,
 <linux@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] iio: adc: ltc2497: add 2x conversion speed mode
Message-ID: <20260907022212.3f5d3d2a@jic23-huawei>
In-Reply-To: <20260902064415.132588-4-andrei.stancovici@analog.com>
References: <20260902064415.132588-1-andrei.stancovici@analog.com>
	<20260902064415.132588-4-andrei.stancovici@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Sep 2026 09:44:12 +0300
Andrei Stancovici <andrei.stancovici@analog.com> wrote:

> The LTC2499 supports a 2x output rate (SPD bit in the second
> configuration byte).  In 2x mode the offset auto-calibration is
> disabled, roughly doubling the conversion rate (~13.6Hz vs ~6.8Hz in
> simultaneous 50/60Hz rejection) while leaving linearity and full-scale
> errors unchanged (datasheet).  During a temperature measurement the part
> always converts at 1x regardless of SPD.
> 
> Expose the rate through the standard sampling_frequency /
> sampling_frequency_available ABI on the voltage channels only: SPD is
> ignored for temperature conversions, so the temperature channel
> deliberately carries no SAMP_FREQ attribute.  A new has_speed_mode
> capability flag gates the feature (LTC2499); the two-byte command path
> is now taken for has_temp || has_speed_mode, since both features need the
> second config byte.
> 
> The conversion-time wait becomes mode dependent: 150ms at 1x, 76ms at 2x
> (datasheet t_CONV max, simultaneous rejection, rounded up).  The wait is
> keyed on the conversion currently in flight, whose duration is fixed by
> the mode that was active when it started - not by the newly selected
> mode.  This matters on a 1x->2x switch: a 1x conversion may still be
> running when the first 2x read arrives, and reprogramming the device
> before it finishes would be NACKed with -EIO.  Timing is centralized in
> ltc2497core_conv_time_ms() so a future FA/FB rejection-mode selection
> can extend it into a [rejection][speed] lookup without touching callers.
> 
> LTC2496/LTC2497 (no speed mode) keep the single-byte path and the
> unchanged 150ms wait.
> 
> Validated on a live LTC2499: 20 reads take ~3.1s at 1x and ~1.6s at 2x
> (~0.5x, no -EIO), voltage and temperature readings stay sane in both
> modes, and the temperature/voltage interleave (sticky-PTAT) regression
> still passes at 1x and 2x.
> 
> Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
Similar to what Andy mentioned for the patch description being too verbose
/ detailed applies to a number of comments in the code.  Take another look
at those and see if the information provided is actually useful in providing
info someone can't see quickly from the code.

Thanks

Jonathan

> ---
>  drivers/iio/adc/ltc2497-core.c | 177 +++++++++++++++++++++++++++++++--
>  drivers/iio/adc/ltc2497.c      |  28 ++++--
>  drivers/iio/adc/ltc2497.h      |  34 ++++++-
>  3 files changed, 220 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
> index 6df9c72bd8cf..3589cabd3c8e 100644
> --- a/drivers/iio/adc/ltc2497-core.c
> +++ b/drivers/iio/adc/ltc2497-core.c
> @@ -7,6 +7,8 @@
>   */
>  
>  #include <linux/delay.h>
> +#include <linux/device/devres.h>
> +#include <linux/gfp.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/driver.h>
>  #include <linux/math64.h>
> @@ -21,24 +23,57 @@
>  #define LTC2497_DIFF			0
>  #define LTC2497_SIGN			BIT(3)
>  
> -static int ltc2497core_wait_conv(struct ltc2497core_driverdata *ddata)
> +/*
> + * Output-rate modes, indexed by ltc2497core_driverdata.sped_2x
> + * (0 = 1x, the power-on default; 1 = 2x, LTC2499 only).  The advertised
> + * sampling_frequency and the conversion-time budget are two views of the same
> + * mode, so they are kept in lock-step here and can never drift apart.  Only the
> + * two simultaneous 50/60Hz rejection rates are reachable today; adding FA/FB
> + * rejection selection later turns this into a [rejection][speed] lookup without
> + * changing any caller.
> + */
> +static const int ltc2497core_samp_freq_avail[] = {
> +	6, 800000,	/* 1x: ~6.8 Hz  (1 / t_CONV_1 typ 146.9ms) */
> +	13, 600000,	/* 2x: ~13.6 Hz (1 / t_CONV_2 typ  73.6ms) */
> +};

...

> @@ -235,6 +368,34 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
>  	else
>  		indio_dev->num_channels = ARRAY_SIZE(ltc2497core_channel) - 1;
>  
> +	/*
> +	 * Parts with a speed mode expose in_voltage_sampling_frequency and
> +	 * in_voltage_sampling_frequency_available on the voltage channels only.
> +	 * SPD is ignored during a temperature measurement, so the temperature
> +	 * channel deliberately carries no SAMP_FREQ attribute.  Patch a private
> +	 * copy of the shared channel array so parts without a speed mode stay
> +	 * untouched.
> +	 */

This is probably unnecessary info. Can see it easily enough by looking at what the
code does.

> +	if (ddata->chip_info->has_speed_mode) {
> +		struct iio_chan_spec *channels;
> +
> +		channels = devm_kmemdup(dev, ltc2497core_channel,
> +					sizeof(ltc2497core_channel), GFP_KERNEL);

Where there are only a small number of choices, we tend to prefer just
picking between static const data rather than doing dynamic changes.
Tends to end up simpler.  Any reason not to do that here (and I may
well have forgotten earlier discussion on this!)

> +		if (!channels)
> +			return -ENOMEM;
> +
> +		for (unsigned int i = 0; i < indio_dev->num_channels; i++) {
> +			if (channels[i].type != IIO_VOLTAGE)
> +				continue;
> +			channels[i].info_mask_shared_by_type |=
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ);
> +			channels[i].info_mask_shared_by_type_available |=
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ);
> +		}
> +
> +		indio_dev->channels = channels;
> +	}
...

>  
> diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> index 79c87bac05e1..3cd30545da2e 100644
> --- a/drivers/iio/adc/ltc2497.c
> +++ b/drivers/iio/adc/ltc2497.c
> @@ -85,18 +85,21 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
>  	}
>  
>  	/*
> -	 * Parts with the internal PTAT sensor (LTC2499) latch their converter
> -	 * configuration via a second command byte and only re-evaluate it when
> -	 * that byte has EN2 set; a single byte, or a second byte with EN2 = 0,
> -	 * means "keep previous".  A one-byte channel select therefore cannot pull
> -	 * the device back out of temperature mode, so a voltage read after a
> -	 * temperature read would keep returning the PTAT result.  Always drive the
> -	 * second byte with EN2 set on these parts: IM = 1 for a temperature read,
> -	 * EN2 alone (IM = 0) to (re)select an external input.  FA = FB = 0 keeps
> -	 * the power-on simultaneous 50/60Hz rejection, whose worst-case
> -	 * conversion time the driver's wait already covers.
> +	 * Parts with a second config byte (LTC2499: internal PTAT sensor and/or
> +	 * the 2x speed mode) latch their converter configuration from that byte
> +	 * and only re-evaluate it when EN2 is set; a single byte, or a second
> +	 * byte with EN2 = 0, means "keep previous".  A one-byte channel select
> +	 * therefore cannot pull the device back out of temperature mode, so a
> +	 * voltage read after a temperature read would keep returning the PTAT
> +	 * result.  Always drive the second byte with EN2 set on these parts:
> +	 *   - temperature read: IM = 1 (SPD is ignored by the part in
> +	 *     temperature mode and is left 0 here);
> +	 *   - voltage read: IM = 0 (external input), plus SPD when 2x is
> +	 *     selected.
> +	 * FA = FB = 0 keeps the power-on simultaneous 50/60Hz rejection, whose
> +	 * worst-case conversion time the driver's wait already covers.
>  	 */
> -	if (ddata->chip_info->has_temp) {
> +	if (ddata->chip_info->has_temp || ddata->chip_info->has_speed_mode) {

>  
> diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
> index 71fa4ad408ee..83bc27a0de0b 100644
> --- a/drivers/iio/adc/ltc2497.h
> +++ b/drivers/iio/adc/ltc2497.h
> @@ -2,7 +2,29 @@
>  
>  #define LTC2497_ENABLE			0xA0
>  #define LTC2497_CONFIG_DEFAULT		LTC2497_ENABLE
> -#define LTC2497_CONVERSION_TIME_MS	150ULL
> +
> +/*
> + * Conversion-time bounds used to gate reads.  Each value is the datasheet
> + * t_CONV maximum, rounded UP to the next whole millisecond. 
This is fine.
> Rounding is
> + * always towards +inf (a ceiling), never to nearest: the number is only used
> + * as a *minimum* wait - the argument to msleep_interruptible() and the
> + * threshold compared against ktime_ms_delta() - so it must never fall below
> + * the true worst case, or a read can be issued before the result is ready and
> + * return -EIO. 

This definitely isn't needed.   Obvious that a wait time must be rounded up
or bad things may happen.

> Both of those APIs operate in whole milliseconds (msleep also
> + * rounds up to the next jiffy, typically 1-10 ms), so storing sub-millisecond
> + * precision would not change the actual wait; the whole-ms ceiling is exact
> + * for this purpose.

Also not detail we care about.

> + *
> + * The driver only ever programs simultaneous 50/60Hz rejection (FA/FB
> + * selection is not implemented), so only those two rates are listed.  The 1x
> + * value also covers the LTC2496/LTC2497, which have no speed mode.

Not sure we need this eitehr.

> + *
> + * The 2x mode (LTC2499_SPD, LTC2499 only) disables the offset auto-calibration
> + * to roughly double the output rate; adding the 2x wait time is what makes the
> + * SPD control actually faster.

This last paragraph is useful to have.

> + */
> +#define LTC2497_CONV_TIME_1X_MS		150ULL	/* ceil(t_CONV_1 simult. max 149.9) */
> +#define LTC2499_CONV_TIME_2X_MS		76ULL	/* ceil(t_CONV_2 simult. max  75.1) */

...

>  
> @@ -28,6 +52,14 @@ struct ltc2497core_driverdata {
>  	struct mutex lock;
>  	const struct ltc2497_chip_info	*chip_info;
>  	u8 addr_prev;
> +	bool sped_2x;	/* SPD: false = 1x (default), true = 2x */

Speed in places, sped here and SPD in yet more.  Good to pick a naming
convention then use it throughout.


> +	/*
> +	 * Conversion time (ms) of the conversion currently in flight.  It is
> +	 * fixed by the mode active when that conversion was started, which
> +	 * differs from the newly selected mode for the first read after a
> +	 * sampling_frequency change.

I think only the 1st sentence is really useful.  The rest of the comment
pretty much follows through from that.

> +	 */
> +	unsigned int conv_time_prev;
>  	int (*result_and_measure)(struct ltc2497core_driverdata *ddata,
>  				  u8 address, int *val);
>  };

