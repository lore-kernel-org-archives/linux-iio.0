Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F51239E88
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772463984; cv=none; b=sktOtt28qc+PE111sAMGZSeIEWCLo2uCnEUVP2nDl6BN81j/ioA68x1NX3afH1XcjXyK4va7SbpBSdtkYhlNtTeHhfoU4ZkvMLun23lCDBHfMVnQra1lgVRqRIqH5GVu4do1akdk2gft3zjjErp38Ugf6+Y5KgY8UfzU/sFkZ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772463984; c=relaxed/simple;
	bh=qhAHjBGkE+JeH6IYxVCgqsgYRL7eEW6+sfjSBNeuT/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJ9x0t3G/qAnE2t/hVfQGjXsHHR2uy+Tx7gwIkmtfjGQgduDIDt+GEMw9cZ7JNBWI52bFFZhycYNPDy7gzV55P60mGa1JgBdlS0CwYZML9jXeWNM0n7cjVy6Jek4ZZLVZ17dE1+t0YBVpvB98TyNGibq1tEUCo7Fs/7CMX++ULw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=l8N3OGpz; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l8N3OGpz"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d1872504cbso2138646a34.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 07:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772463980; x=1773068780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xqFfbJg5rJlqHJNSZES7G7/qXyFNEOZUiZp55YHJH9s=;
        b=l8N3OGpzRUGpvS/M6RNYf1Vioe6jTvdanviFaGqRtBe3+45CUCSzk+Vnxcgkp4sg07
         0SvGrcCWoFqEP25a9vKMhlyxOJvUtSxgVQn3KVbP4ugnte+xreyW6fJOSByElUj8iBJu
         m1ni0F6dyEUAVOdugdP6PEn7l1RdnOF8qS7t/38nmvUpVNjSIqdSkzNxW8BvSieSrogQ
         WcSwxfZjFypXfYVJwW8+1Y6LyHdPBLlAvQp72mWm721ep4Zxa3M6V10DIdBMUzXzOTyJ
         FfMddVt9ic7ehwwGgCB3qU9KWdcsSUYdL5t51MzDAXJXdFxL9jc6dsXVFEHga4045puE
         7Z4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772463980; x=1773068780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xqFfbJg5rJlqHJNSZES7G7/qXyFNEOZUiZp55YHJH9s=;
        b=GyXV4g5BaY/glJ4MyzBcXpjBI+YzSzpH7Mi6U0xc99C31/tM19gIPGlQO/I2T7ajaj
         Y/wgc21WeSg0drE4Iw721t6x6GAOJyVb0EWvc88jIDYngJkKlxqebp7R11Uttc2H4ePt
         bX5m4ywEkz+v8TjRdvQbKWD3UtcAdiZr9FuS72guGZ4RH7BZGrf//ktvTzG3nJrhc3ND
         JNIpXJlBmKHXsD2G0n9ex7fu5afPvQzZTstZLmfgLsGoxjqew8dqGBJxjYUtZlKIGkGs
         CBygNASRUnu2RazF3EfcfJUrUCLG7VTLedsLKl4ticHkyzJ2NJJs91M4rjpgTkhA7weP
         IbVA==
X-Forwarded-Encrypted: i=1; AJvYcCWX2fga+dXOzCo3i146yllH7J7Yp2aJGj1/Qyq04a6gKHAu699vlTYr+liEMY2W+6xaeGM75M6sHDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFopc7zde+3y1fICr7yy00HMZF+6th+b4AMqKYOrTE3iA346AK
	jSWJotAkBaUuFej+8HQLR8aoHO29UtGAKa9na0GyRDLYnrRgfonyajRHAZukoBwHDoE=
X-Gm-Gg: ATEYQzyql57YbM06Q66mXMtz6qPHpHuR7mHxD/Xk4p8zCS+zxerN+hymlTBaW505CzO
	rZvSG72y5Mu7p2/MqkRD5aa5ahk1yvgTImipP2Sm4umZJsqLDkYegou2QGnWIi+2qIcxO5wn0mq
	mQoNoKq07BP4HXpNSyUyb6WOyJMdQsoBkYyva4oHgTkImYZrV98VHkq7QQ6AAGZb9agPEk5bfpu
	u90Mg8wI0rkAIS0ZMSfzxE1zIk7/51JbL6wx/Blbscyfv9ySXmnN498L47uVkCdFR7FKK190ixr
	ObGeF6LSvTj6ad2Rzhvs04kkVoZHu2Vxm4cTIppkhcP+pXOw169JHVV7O2FwF0sCMPaIKQAvlwB
	oNLWA6xgxMRI++laxyT+kdvSQNveA9qqTIkFMeN15XrPbDKbM7PaZMiIrZ3Wvw8TC4NhiBLCSlP
	+O966zS42yqZQUcbpQc5Gu1eOwbAsvA4viNawQ28M9lEkIWyHWHMwVh6aq3k9L/hGlo+FoJFx6i
	Q==
X-Received: by 2002:a05:6830:6305:b0:7d1:9183:c683 with SMTP id 46e09a7af769-7d591ec7023mr8043248a34.16.1772463979769;
        Mon, 02 Mar 2026 07:06:19 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7? ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586474d4csm12167797a34.9.2026.03.02.07.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 07:06:19 -0800 (PST)
Message-ID: <9fe26547-0d1e-4701-8212-06d23cc1fbd2@baylibre.com>
Date: Mon, 2 Mar 2026 09:06:17 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: ad799x: convert to fully managed resources
To: Archit Anant <architanant5@gmail.com>, jic23@kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260302052559.19494-1-architanant5@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260302052559.19494-1-architanant5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/1/26 11:25 PM, Archit Anant wrote:
> Refactor the driver to use device-managed allocations and actions,
> allowing for the complete removal of the ad799x_remove() function
> and simplifying the error paths in probe().
> 
> Key changes:
> - Replace the dynamic rx_buf allocation with a fixed-size, DMA-safe
>   buffer using IIO_DECLARE_DMA_BUFFER_WITH_TS() in the state struct.
>   This avoids memory leaks during scan mode updates and removes the
>   need for manual kfree().

I agree with Andy tht this first change should be split out to a
separate patch.

> - Cache the VCC and VREF voltages in the state structure during probe()
>   to avoid querying the regulator API during fast-path read_raw() calls.
> - Use devm_add_action_or_reset() to register regulator_disable()
>   callbacks for both VCC and VREF regulators.

And regulator stuff as another patch.

> - Convert iio_triggered_buffer_setup() and iio_device_register() to
>   their devm_ variants, ensuring safe, reverse-order unwinding.
> 
> Signed-off-by: Archit Anant <architanant5@gmail.com>
> ---
> Changes in v2:
> - Refactored entire resource management to eliminate remove() function
>   based on feedback from David Lechner and Jonathan Cameron.
> - Cached voltages to prevent mixing manual regulator disables with
>   devm-managed device unregistration.
> 
>  drivers/iio/adc/ad799x.c | 83 +++++++++++++++++++---------------------
>  1 file changed, 40 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 108bb22162ef..4a3db6f0a8d8 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -39,6 +39,7 @@
>  #include <linux/iio/triggered_buffer.h>
>  
>  #define AD799X_CHANNEL_SHIFT			4
> +#define AD799X_MAX_CHANNELS			8
>  
>  /*
>   * AD7991, AD7995 and AD7999 defines
> @@ -133,8 +134,12 @@ struct ad799x_state {
>  	unsigned int			id;
>  	u16				config;
>  
> -	u8				*rx_buf;
>  	unsigned int			transfer_size;
> +
> +	int				vcc_uv;
> +	int				vref_uv;
> +
> +	IIO_DECLARE_DMA_BUFFER_WITH_TS(__be16, rx_buf, AD799X_MAX_CHANNELS);

See v1 discussion. IIO_DECLARE_DMA_BUFFER_WITH_TS() is not needed
after all since this is I2C. IIO_DECLARE_BUFFER_WITH_TS() can be
used instead.

>  };
>  
>  static int ad799x_write_config(struct ad799x_state *st, u16 val)
> @@ -217,11 +222,11 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
>  	}
>  
>  	b_sent = i2c_smbus_read_i2c_block_data(st->client,
> -			cmd, st->transfer_size, st->rx_buf);
> +			cmd, st->transfer_size, (u8 *)st->rx_buf);
>  	if (b_sent < 0)
>  		goto out;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &st->rx_buf,
>  			iio_get_time_ns(indio_dev));
>  out:
>  	iio_trigger_notify_done(indio_dev->trig);
> @@ -234,11 +239,6 @@ static int ad799x_update_scan_mode(struct iio_dev *indio_dev,
>  {
>  	struct ad799x_state *st = iio_priv(indio_dev);
>  
> -	kfree(st->rx_buf);
> -	st->rx_buf = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> -	if (!st->rx_buf)
> -		return -ENOMEM;
> -
>  	st->transfer_size = bitmap_weight(scan_mask,
>  					  iio_get_masklength(indio_dev)) * 2;
>  
> @@ -307,9 +307,9 @@ static int ad799x_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		if (st->vref)
> -			ret = regulator_get_voltage(st->vref);
> +			ret = st->vref_uv;
>  		else
> -			ret = regulator_get_voltage(st->reg);
> +			ret = st->vcc_uv;
>  
>  		if (ret < 0)
>  			return ret;

It should not be possible for ret < 0 now.

And we should be able to avoid assigning to ret and rather
assign directly to *val now.

> @@ -781,6 +781,13 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>  	},
>  };
>  
> +static void ad799x_reg_disable(void *data)
> +{
> +	struct regulator *reg = data;
> +
> +	regulator_disable(reg);
> +}
> +
>  static int ad799x_probe(struct i2c_client *client)
>  {
>  	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> @@ -813,6 +820,14 @@ static int ad799x_probe(struct i2c_client *client)
>  	ret = regulator_enable(st->reg);
>  	if (ret)
>  		return ret;
> +	ret = devm_add_action_or_reset(&client->dev, ad799x_reg_disable, st->reg);
> +	if (ret)
> +		return ret;
> +
> +	ret = regulator_get_voltage(st->reg);
> +	if (ret < 0)
> +		return ret;
> +	st->vcc_uv = ret;
>  
>  	/* check if an external reference is supplied */
>  	if (chip_info->has_vref) {
> @@ -820,7 +835,7 @@ static int ad799x_probe(struct i2c_client *client)
>  		ret = PTR_ERR_OR_ZERO(st->vref);
>  		if (ret) {
>  			if (ret != -ENODEV)
> -				goto error_disable_reg;
> +				return ret;
>  			st->vref = NULL;
>  			dev_info(&client->dev, "Using VCC reference voltage\n");
>  		}
> @@ -830,7 +845,14 @@ static int ad799x_probe(struct i2c_client *client)
>  			extra_config |= AD7991_REF_SEL;
>  			ret = regulator_enable(st->vref);
>  			if (ret)
> -				goto error_disable_reg;
> +				return ret;
> +			ret = devm_add_action_or_reset(&client->dev, ad799x_reg_disable, st->vref);
> +			if (ret)
> +				return ret;
> +			ret = regulator_get_voltage(st->vref);
> +			if (ret < 0)
> +				return ret;
> +			st->vref_uv = ret;
>  		}
>  	}
>  
> @@ -845,12 +867,12 @@ static int ad799x_probe(struct i2c_client *client)
>  
>  	ret = ad799x_update_config(st, st->chip_config->default_config | extra_config);
>  	if (ret)
> -		goto error_disable_vref;
> +		return ret;
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> +	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
>  		&ad799x_trigger_handler, NULL);
>  	if (ret)
> -		goto error_disable_vref;
> +		return ret;
>  
>  	if (client->irq > 0) {
>  		ret = devm_request_threaded_irq(&client->dev,
> @@ -862,40 +884,16 @@ static int ad799x_probe(struct i2c_client *client)
>  						client->name,
>  						indio_dev);
>  		if (ret)
> -			goto error_cleanup_ring;
> +			return ret;
>  	}
>  
>  	mutex_init(&st->lock);
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&client->dev, indio_dev);

We can just return directly here now.

>  	if (ret)
> -		goto error_cleanup_ring;
> +		return ret;
>  
>  	return 0;
> -
> -error_cleanup_ring:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -error_disable_vref:
> -	if (st->vref)
> -		regulator_disable(st->vref);
> -error_disable_reg:
> -	regulator_disable(st->reg);
> -
> -	return ret;
> -}
> -
> -static void ad799x_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -	struct ad799x_state *st = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -
> -	iio_triggered_buffer_cleanup(indio_dev);
> -	if (st->vref)
> -		regulator_disable(st->vref);
> -	regulator_disable(st->reg);
> -	kfree(st->rx_buf);
>  }
>  
>  static int ad799x_suspend(struct device *dev)
> @@ -965,7 +963,6 @@ static struct i2c_driver ad799x_driver = {
>  		.pm = pm_sleep_ptr(&ad799x_pm_ops),
>  	},
>  	.probe = ad799x_probe,
> -	.remove = ad799x_remove,
>  	.id_table = ad799x_id,
>  };
>  module_i2c_driver(ad799x_driver);

