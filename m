Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699586;
	b=FIuQ3A8CM4kzA/gJEm8ymhrE2dng9tNyscPvCwc7vSBxrfuJvzCOs68Kxz+O/3SZ5/AK
	 r2IDC2zSvDNpPQvUQjsMgazq9YLQkYTn9HfYBc7S+05Z70V7HRzngE+83T19r7DsIaEsG
	 VuJpcFEZTTSPTKXPiZriekS2L5YkTiVqPOsp7shpdFDG1C3gAuUw7N/WIEJ39WF8qPbIt
	 Rx8sxHy01xbyEDPrHudQfKNJVAYkGqa2rxyHqgLiCuB6ZLRgWLH7Ma64idf6r9FqffvzJ
	 SXT21F7yLu0D0oXWB97MZMekhuW//eRT/vlcUkdEKiiFLli7EmPRC8n6d9FEcgM6Uqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699586;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=yky9Xf7/wTx7/9hLagy1jyeJg6sk7XbvlfQjIN5eVF0=;
	b=VYopnKCJvWRH3OpSJqtZyRj0V1VBMJzX9eCZQ7a2MTChnX6KeUyF+axbkjEhoj6yzWWg
	 NuvSR7HB+fDiMc5A1zw6aT+DNw5VHk5bDcF94ef2W9m1tUCxL2Fo5ICt/M2GvS0yZ4O2g
	 EelR8uya+Zccw+0IhEbUfnbqC1H5HYda4NXBgEb8hfTZP5IuPIJt4rW8MJRPdu4mJD43S
	 GACuwanAKjAqXEKtT2s2NpwP1+6S7KJ+lgxZOGfteDt/YgvU5gdXei7DYSxaNHmJcu8qx
	 9OZWSapEflqzj3Xtpd8GiXwIPDGRG8mbXLsQ8MCOFm7TBSMBopnM9YFMQIPVzYYR3/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ORZkhUY9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB89606A31C;
	Thu, 26 Nov 2026 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ORZkhUY9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F6E1F000D0;
	Thu, 26 Nov 2026 13:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795699586;
	bh=yky9Xf7/wTx7/9hLagy1jyeJg6sk7XbvlfQjIN5eVF0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ORZkhUY9nf4bW5o3FL4YaIKIbaFUaVRkP5vNFTA+jAKxP43wqfUrhdgVeMglYjbX2
	 4bXb5/faL0079qpYvgxFks1XFFCEdjbflo/aHrTbd+yi0b50jLWE7wG729wP6eXzC9
	 zcI4MgiraHLJB4XwlYSCd4tY1IZ9c3lfYDDRb0gPVAUiwOXzc3Tdgf7knb/6XYDCtd
	 xMG/5X4JghijNA/fCBnXEFi8lKia1JTNheeERGs4RU4VgDMuJjSbV0WaWOYhm4aM/I
	 RQ5X/VgnzTMTN4UgRplDyPanln6hSfPC5WL6FJgO1GGaZ/+oGede+PoNUqy7VPUN3N
	 tfJ5E27vMN3qQ==
Message-ID: <0a01f11c-86d3-437d-977f-dd5978542b86@kernel.org>
Date: Thu, 26 Nov 2026 14:26:21 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/2] iio: adc: palmas_gpadc: Use guard(mutex) to manage
 locks
To: Vaibhav Chahar <vaibhav.chahar26@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Marius Cristea <marius.cristea@microchip.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261126114433.20674-1-vaibhav.chahar26@gmail.com>
 <20261126114433.20674-3-vaibhav.chahar26@gmail.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261126114433.20674-3-vaibhav.chahar26@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26-Nov-26 12:44, Vaibhav Chahar wrote:
> Use guard(mutex) instead of manual mutex_lock() and mutex_unlock()
> calls to modernize the driver and simplify error handling paths.
> 
> Made a new palmas_gpadc_read_raw_locked() helper function which
> calls palmas_gpadc_read_done() on all exit paths before
> returning to palmas_gpadc_read_raw() where the mutex is unlocked,
> allowing the removal of unlock goto labels safely.
> 
> Signed-off-by: Vaibhav Chahar <vaibhav.chahar26@gmail.com>
> ---
>  drivers/iio/adc/palmas_gpadc.c | 126 ++++++++++++++-------------------
>  1 file changed, 53 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
> index f777986a6..fa1526e31 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -16,6 +16,7 @@
>  #include <linux/delay.h>
>  #include <linux/pm.h>
>  #include <linux/mfd/palmas.h>
> +#include <linux/cleanup.h>
>  #include <linux/completion.h>
>  #include <linux/of.h>
>  #include <linux/iio/events.h>
> @@ -538,50 +539,50 @@ static int palmas_gpadc_get_low_threshold_raw(struct palmas_gpadc *adc,
>  						     min_offset_error);
>  }
>  
> +static int palmas_gpadc_read_raw_locked(struct palmas_gpadc *adc, int adc_chan,
> +					int *val, long mask)
> +{
> +	int ret;
> +
> +	ret = palmas_gpadc_read_prepare(adc, adc_chan);
> +	if (ret < 0)
> +		goto done;
> +
> +	ret = palmas_gpadc_start_conversion(adc, adc_chan);
> +	if (ret < 0) {
> +		dev_err(adc->dev, "ADC start conversion failed\n");
> +		goto done;
> +	}
> +
> +	if (mask == IIO_CHAN_INFO_PROCESSED)
> +		ret = palmas_gpadc_get_calibrated_code(adc, adc_chan, ret);
> +
> +	*val = ret;
> +	ret = IIO_VAL_INT;
> +
> +done:
> +	palmas_gpadc_read_done(adc, adc_chan);
> +	return ret;
> +}
> +
>  static int palmas_gpadc_read_raw(struct iio_dev *indio_dev,
>  	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
>  {
>  	struct  palmas_gpadc *adc = iio_priv(indio_dev);
>  	int adc_chan = chan->channel;
> -	int ret = 0;
>  
>  	if (adc_chan >= PALMAS_ADC_CH_MAX)
>  		return -EINVAL;
>  
> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  	case IIO_CHAN_INFO_PROCESSED:
> -		ret = palmas_gpadc_read_prepare(adc, adc_chan);
> -		if (ret < 0)
> -			goto out;
> -
> -		ret = palmas_gpadc_start_conversion(adc, adc_chan);
> -		if (ret < 0) {
> -			dev_err(adc->dev,
> -			"ADC start conversion failed\n");
> -			goto out;
> -		}
> -
> -		if (mask == IIO_CHAN_INFO_PROCESSED)
> -			ret = palmas_gpadc_get_calibrated_code(
> -							adc, adc_chan, ret);
> -
> -		*val = ret;
> -
> -		ret = IIO_VAL_INT;
> -		goto out;
> +		return palmas_gpadc_read_raw_locked(adc, adc_chan, val, mask);
>  	}
>  
> -	mutex_unlock(&adc->lock);
> -	return ret;
> -
> -out:
> -	palmas_gpadc_read_done(adc, adc_chan);
> -	mutex_unlock(&adc->lock);
> -
> -	return ret;
> +	return 0;
>  }
>  
>  static int palmas_gpadc_read_event_config(struct iio_dev *indio_dev,
> @@ -591,19 +592,16 @@ static int palmas_gpadc_read_event_config(struct iio_dev *indio_dev,
>  {
>  	struct palmas_gpadc *adc = iio_priv(indio_dev);
>  	int adc_chan = chan->channel;
> -	int ret = 0;
>  
>  	if (adc_chan >= PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
>  		return -EINVAL;
>  
> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
>  
>  	if (palmas_gpadc_get_event(adc, adc_chan, dir))
> -		ret = 1;
> +		return 1;
>  
> -	mutex_unlock(&adc->lock);
> -
> -	return ret;
> +	return 0;
>  }
>  
>  static int palmas_adc_configure_events(struct palmas_gpadc *adc);
> @@ -680,21 +678,16 @@ static int palmas_gpadc_write_event_config(struct iio_dev *indio_dev,
>  {
>  	struct palmas_gpadc *adc = iio_priv(indio_dev);
>  	int adc_chan = chan->channel;
> -	int ret;
>  
>  	if (adc_chan >= PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
>  		return -EINVAL;
>  
> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
>  
>  	if (state)
> -		ret = palmas_gpadc_enable_event_config(adc, chan, dir);
> -	else
> -		ret = palmas_gpadc_disable_event_config(adc, chan, dir);
> +		return palmas_gpadc_enable_event_config(adc, chan, dir);
>  
> -	mutex_unlock(&adc->lock);
> -
> -	return ret;
> +	return palmas_gpadc_disable_event_config(adc, chan, dir);
>  }
>  
>  static int palmas_gpadc_read_event_value(struct iio_dev *indio_dev,
> @@ -706,28 +699,21 @@ static int palmas_gpadc_read_event_value(struct iio_dev *indio_dev,
>  {
>  	struct palmas_gpadc *adc = iio_priv(indio_dev);
>  	int adc_chan = chan->channel;
> -	int ret;
>  
>  	if (adc_chan >= PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
>  		return -EINVAL;
>  
> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
>  
>  	switch (info) {
>  	case IIO_EV_INFO_VALUE:
>  		*val = (dir == IIO_EV_DIR_RISING) ?
>  			adc->thresholds[adc_chan].high :
>  			adc->thresholds[adc_chan].low;
> -		ret = IIO_VAL_INT;
> -		break;
> +		return IIO_VAL_INT;
>  	default:
> -		ret = -EINVAL;
> -		break;
> +		return -EINVAL;
>  	}
> -
> -	mutex_unlock(&adc->lock);
> -
> -	return ret;
>  }
>  
>  static int palmas_gpadc_write_event_value(struct iio_dev *indio_dev,
> @@ -739,19 +725,18 @@ static int palmas_gpadc_write_event_value(struct iio_dev *indio_dev,
>  {
>  	struct palmas_gpadc *adc = iio_priv(indio_dev);
>  	int adc_chan = chan->channel;
> -	int old;
> -	int ret;
>  
>  	if (adc_chan >= PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
>  		return -EINVAL;
>  
> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
> +
>  	switch (info) {
> -	case IIO_EV_INFO_VALUE:
> -		if (val < 0 || val > 0xFFF) {
> -			ret = -EINVAL;
> -			goto out_unlock;
> -		}
> +	case IIO_EV_INFO_VALUE: {
> +		int old;
> +
> +		if (val < 0 || val > 0xFFF)
> +			return -EINVAL;

Not introduced by this patch (I sound like Sashiko :) ), but -ERANGE is preferred.

This could be tweaked whilst applying though.

-- 
Kind regards,
Joshua Crofts
