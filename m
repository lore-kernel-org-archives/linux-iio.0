Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6989334F462;
	Sat,  7 Mar 2026 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772884197; cv=none; b=QG6LbHVhoP65Ih7PLxj5nJ5y4pA4oKhucG3VE9bAjNnagVsGexTuvAwuHk8LZTxRAQ2on3iUYJzOPHWYYndydKzKz4h17jI1xgjER+lsvyOCyX5PgYbfeQ9cOeFMoTeRIvpApzcx7KXcLmubaEe+4BNPXGpAkd/mEbXEDfek1Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772884197; c=relaxed/simple;
	bh=JynjclBBtvL7pLsm5oyZKwAMM/QYs8sjtsDmejAf9cY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGTfd80DhdWuqa/qKIYFe4B1ATBv33rhavEybvORWXlcgBFndHeaHCJa9hSsHlbUGlx9/77/woof9LZt0/iD6H8oFjLIcZiy6T68po7yYfqIVr2/DSG2XYXEGXdAZMHGptxoZ6teI2Qd9uis7i7fxKj3XfnlUuZWdRalu1A/yi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omsS2cIn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omsS2cIn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25955C2BC87;
	Sat,  7 Mar 2026 11:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772884197;
	bh=JynjclBBtvL7pLsm5oyZKwAMM/QYs8sjtsDmejAf9cY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=omsS2cInXsbgpIDmSS7sBi922LMmYcZSrjgIf53kbvyenlnqCAsCUlbKcIJuLxEeq
	 rSgFoMTvmHDLknychppO63RR5gwMol3XG6l82gdZ7Gghx1rjsU9FvM1XlMCLgiRjBF
	 LMv/l8+uT9aODGCiru94gYY9AkIIyFw0hyG+JZCJxmTt9MlZSnuN8ytmwT5hOzwrzr
	 qomQ04u4dVc6NS9rfRkNvLgq0SsmWAg7I7DLygU3TiHT3hdPM/ZdhEcJZ+7ftLoHZx
	 sc1DFRswNBD9vPBI6GLdgB3LL26AUDTOlCK5xmWUEtehE+osacCGLUxwMK6GysIMbw
	 FyUpxbeRQF8FA==
Date: Sat, 7 Mar 2026 11:49:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 5/6] iio: adc: ti-ads7950: switch to using
 devm_regulator_get_enable_read_voltage()
Message-ID: <20260307114947.0b946dfb@jic23-huawei>
In-Reply-To: <20260305-ti-ads7950-facelift-v3-5-a23fdd1a079e@gmail.com>
References: <20260305-ti-ads7950-facelift-v3-0-a23fdd1a079e@gmail.com>
	<20260305-ti-ads7950-facelift-v3-5-a23fdd1a079e@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Mar 2026 11:21:56 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> The regulator is enabled for the entire time the driver is bound to the
> device, and we only need to access it to fetch voltage, which can be
> done at probe time.
> 
> Switch to using devm_regulator_get_enable_read_voltage() which
> simplifies probing and unbinding code.
> 
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Hi.

I think this broke the ACPI case (where regulator isn't available).

Jonathan

> ---
>  drivers/iio/adc/ti-ads7950.c | 45 +++++++++++---------------------------------
>  1 file changed, 11 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> index 273c35e03185..847e83baa876 100644
> --- a/drivers/iio/adc/ti-ads7950.c
> +++ b/drivers/iio/adc/ti-ads7950.c
> @@ -341,19 +341,9 @@ static int ti_ads7950_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
>  	return st->single_rx;
>  }
>  
> -static int ti_ads7950_get_range(struct ti_ads7950_state *st)
> +static unsigned int ti_ads7950_get_range(struct ti_ads7950_state *st)
>  {
> -	int vref;
> -
> -	if (st->vref_mv) {
> -		vref = st->vref_mv;
> -	} else {
> -		vref = regulator_get_voltage(st->reg);
> -		if (vref < 0)
> -			return vref;
> -
> -		vref /= 1000;
> -	}
> +	unsigned int vref = st->vref_mv;
>  
>  	if (st->cmd_settings_bitmask & TI_ADS7950_CR_RANGE_5V)
>  		vref *= 2;
> @@ -382,11 +372,7 @@ static int ti_ads7950_read_raw(struct iio_dev *indio_dev,
>  
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		ret = ti_ads7950_get_range(st);
> -		if (ret < 0)
> -			return ret;
> -
> -		*val = ret;
> +		*val = ti_ads7950_get_range(st);
>  		*val2 = (1 << chan->scan_type.realbits) - 1;
>  
>  		return IIO_VAL_FRACTIONAL;
> @@ -580,30 +566,24 @@ static int ti_ads7950_probe(struct spi_device *spi)
>  	spi_message_init_with_transfers(&st->scan_single_msg,
>  					st->scan_single_xfer, 3);
>  
> +	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
> +	if (ret < 0)

I think you need to check for -ENODEV and if you see than then
see if the acpi route below applies.  Otherwise on ACPI this will fail
and we'll fail the probe.


> +		return dev_err_probe(&spi->dev, ret,
> +				     "Failed to get regulator \"vref\"\n");
> +
>  	/* Use hard coded value for reference voltage in ACPI case */
>  	if (ACPI_COMPANION(&spi->dev))
>  		st->vref_mv = TI_ADS7950_VA_MV_ACPI_DEFAULT;
> +	else
> +		st->vref_mv = ret / 1000;


