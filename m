Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68910380FF7;
	Wed, 27 May 2026 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904462; cv=none; b=pr6ZO8nBpWa58/rEQd0lvjY07E4sQR7YOrE7YcxjgORTBgy3HEBgSuVMSAQzdZ2M/qNj5WLkOTqTdg/qadWTKCq4HtOn/S8puPFQHTjNe7FwSrCUQ6Av9h4ohTeO8Ivr/E3rz81OTS+3bKaaiEz4WZnFtnzR0J+LykOPri0oX/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904462; c=relaxed/simple;
	bh=Q2vFQqEks3gmFmel0IA4LQRZysPVAUbq7VtowAki3sU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YLCkdOGa4ocqNjxw6lSqg6oXBiLS0UIn67aS03UURdSY2BrvVhAiJoRP8R3ubT1utR6t6m2xDoEtR/wslXk8xTUHwjCVM7yQvd38BPf8KWVGBds8X+KuES3D6uYDEyVSY5o6M6Vq3313mNanVVx8LkopegpzL01oIoBUMc7Rvzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6Qev1hg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6Qev1hg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056A71F000E9;
	Wed, 27 May 2026 17:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779904461;
	bh=sQOQV/UpogjC8CSIq9749AVZ/yL94/meEozKfM3YSIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=i6Qev1hgLnRG10RkXrrlZtRIhGR9jCdZAIEy1sxkAeilrW78GALjxGoU/t8fC3cin
	 N7/GdHA0LXggPdIpBnbykTeSZpDejfA6Obri0f0tTp8YhJBObUb/+0xxIoaz6nePou
	 I7WczOUo3eliHU2Yst1l2YW6fd4OHiSAOKr7zMZ7iqwS9TvPN7OLeSx+gzqsg0aakb
	 P28gZegfTtSDVGZnnIbvVwEZw6lcAiAkjTaFb5dhvICClo6legDUNKAMqHZMCdeQlz
	 EW/wsrrYJfLR2b/05M/sOyuIJPTIvo3oHEWYMSnL8vfKUv8hC3y0UH52BLZuCAsaF1
	 9FMFiwXvqDHpA==
Date: Wed, 27 May 2026 18:54:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ak@it-klinger.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, dlechner@baylibre.com
Subject: Re: [PATCH v10 11/11] iio: adc: hx711: add support for HX710B
Message-ID: <20260527185411.7ead3a7e@jic23-huawei>
In-Reply-To: <20260525105127.180156-12-piyushpatle228@gmail.com>
References: <20260525105127.180156-1-piyushpatle228@gmail.com>
	<20260525105127.180156-12-piyushpatle228@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 16:21:27 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> Add support for the AVIA HX710B ADC, which shares the HX711 GPIO
> interface but uses trailing PD_SCK pulses to select the active mode.
> 
> Model the HX710B with variant-specific channel tables and IIO info,
> track the active channel across conversions, and use the fixed gain
> value when computing scale.
> 
> Also update the adjacent Kconfig text, file header, and module
> description so the driver text matches the newly supported variant.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Hi

A few small things in here seeing as you are going to be doing a v11 for
the patch description updates on the dt patches.

> ---
>  drivers/iio/adc/Kconfig |   8 +-
>  drivers/iio/adc/hx711.c | 230 ++++++++++++++++++++++++++++++++++++----
>  2 files changed, 212 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index a9dedbb8eb46..38ba8cae13f1 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -791,13 +791,15 @@ config HI8435
>  	  called hi8435.
>  
>  config HX711
> -	tristate "AVIA HX711 ADC for weight cells"
> +	tristate "AVIA HX711 and compatible ADCs"
As below - and similar (not and compatible because they aren't quite).
>  	depends on GPIOLIB
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> -	  If you say yes here you get support for AVIA HX711 ADC which is used
> -	  for weigh cells
> +	  If you say Y here you get support for the following AVIA ADCs:
> +	    - HX710B
> +	    - HX711
> +	  which are used for bridge sensors such as weigh cells.
>  
>  	  This driver uses two GPIOs, one acts as the clock and controls the
>  	  channel selection and gain, the other one is used for the measurement
> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> index fde95758b9a0..32a35f644834 100644
> --- a/drivers/iio/adc/hx711.c
> +++ b/drivers/iio/adc/hx711.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * HX711: analog to digital converter for weight sensor module
> + * HX711 and compatible ADCs driver for weigh sensor modules

Never use 'and compatible' when the driver needs to handle things differently
for each part.  'and similar' is the most common weasel words for this.

> +
> +/*
> + * Switch the HX710B to the requested channel for the next conversion.
> + * channel_set tracks the trailing pulse count that was last sent to the
> + * chip; it is updated immediately after hx711_read() commits the new
> + * mode in hardware, before waiting for the chip to be ready again.
> + */
> +static int hx711_set_hx710b_channel(struct hx711_data *hx711_data,
> +				    const struct iio_chan_spec *chan)
> +{
> +	int trailing_pulses = hx710b_trailing_pulses(hx711_data, chan);
> +	int ret;
> +
> +	if (hx711_data->channel_set == trailing_pulses)
> +		return 0;
> +
> +	ret = hx711_read(hx711_data, trailing_pulses);
> +	if (ret < 0)
> +		return ret;
> +
> +	hx711_data->channel_set = trailing_pulses;
> +
> +	ret = hx711_wait_for_ready(hx711_data);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

	return hx711_wait_for_read(hx711_data);
doesn't obviously hurt readability here and saves us a few lines of code.

> +}
> +
>  static int hx711_reset_read(struct hx711_data *hx711_data,
>  			    const struct iio_chan_spec *chan)
>  {
> +	const struct hx711_chip_info *info = hx711_data->chip_info;
>  	int trailing_pulses;
>  	int ret;
>  
> @@ -298,9 +352,16 @@ static int hx711_reset_read(struct hx711_data *hx711_data,
>  		return -EIO;
>  	}
>  
> -	ret = hx711_set_hx711_channel(hx711_data, chan, &trailing_pulses);
> -	if (ret < 0)
> -		return ret;
> +	if (info->has_fixed_gain) {
> +		ret = hx711_set_hx710b_channel(hx711_data, chan);
> +		if (ret < 0)
> +			return ret;
> +		trailing_pulses = hx710b_trailing_pulses(hx711_data, chan);
> +	} else {
> +		ret = hx711_set_hx711_channel(hx711_data, chan, &trailing_pulses);
> +		if (ret < 0)
> +			return ret;
> +	}
>  
>  	return hx711_read(hx711_data, trailing_pulses);
>  }
> @@ -322,6 +383,9 @@ static int hx711_read_raw(struct iio_dev *indio_dev,
>  		if (*val < 0)
>  			return *val;
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = hx711_data->samp_freq;
> +		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 0;
>  		mutex_lock(&hx711_data->lock);
> @@ -399,20 +463,26 @@ static irqreturn_t hx711_trigger(int irq, void *p)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct hx711_data *hx711_data = iio_priv(indio_dev);
>  	int i, j = 0;
> +	int ret;
>  
>  	mutex_lock(&hx711_data->lock);
>  
>  	memset(&hx711_data->buffer, 0, sizeof(hx711_data->buffer));
>  
>  	iio_for_each_active_channel(indio_dev, i) {
> -		hx711_data->buffer.channel[j] =
> -			hx711_reset_read(hx711_data, &indio_dev->channels[i]);
> -		j++;
> +		ret = hx711_reset_read(hx711_data, &indio_dev->channels[i]);
> +		if (ret < 0) {
> +			dev_err_ratelimited(hx711_data->dev,
> +					    "read failed: %d\n", ret);
> +			goto out_unlock;
> +		}
> +		hx711_data->buffer.channel[j++] = ret;
>  	}
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, &hx711_data->buffer,
> -							pf->timestamp);
> +					   pf->timestamp);

This an unrelated change so should not be in a patch doing anything
significant like this one is.

>  
> +out_unlock:
>  	mutex_unlock(&hx711_data->lock);
>  
>  	iio_trigger_notify_done(indio_dev->trig);
> @@ -462,6 +532,54 @@ static const struct iio_info hx711_iio_info = {
>  	.attrs			= &hx711_attribute_group,
>  };

