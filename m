Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE76A1DF25C
	for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771695279; cv=none; b=A9uHKzh6reUi1cCNyN3gK7i6HNWifjjoLilsyOrBxxZGabQndDfuUDgxMw0Rv1fj05cyCLeR0oKHCA9JLCsdRSKGhNg9qVgf378TTIBBd5g6/S9SiiGkWp6JdKcQr3xe7eUZbKKGhyrjPxiKQCVycB3+bqWx8dBYmjUXGq/OzVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771695279; c=relaxed/simple;
	bh=8DFbuxXlD6z0qNEdWTHytsSIfG8aOT+FPC40zi222as=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J1BKuT4TDlcPJe8kH27bpkuiKbX7ekKacYO6cZPgPBIFfMheJ9EPprI1FsrTTksXu7ZMpAE2KVqN0LmzHOrrhd9+JjZAvC7hrZ9xoK4q5bVcDsnKmih+sbufMfhZjnWG84pUAoFgO+/OuqKPFTa4+dOJN4dQH2Z6wLyhC5ulNaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LM1nNJse; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LM1nNJse"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d4c9537f90so2066356a34.0
        for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 09:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771695275; x=1772300075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4NKhKWGEDkDoAduIGils44kzoIDiw/7usM5aB+9rdUI=;
        b=LM1nNJseZvBpfR0w6MCnp8n2+IeVp4kL0P4GVbKmAf56qVJAeZg3zpFAxuyzF/48s3
         uZ19UJhN8Q1lrqajfqJwve7wTPmEF7TDccyBZ4rCsiOO1YPJWkTGqrhoGjjV+12TntoG
         p2pJc5DfMxdArI1Wz+wBQz1MFAPyV0hIk5cbahsGzQQtxDGhaX1nB+YR3R55qs2ok2gB
         4x0aGuYz9UcJee7ODt2gYZjBQibo2WvCHfr4uN/rfjXJExA/uv/EpwGzDJU7VTEkg3ZU
         s69Bky121fhzgsJgoyg0w63Vd60ANeMiME5rFASuMgbPFEeUvBOO6vYCxbueirhWmQaZ
         rTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771695275; x=1772300075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4NKhKWGEDkDoAduIGils44kzoIDiw/7usM5aB+9rdUI=;
        b=RgavX99ValnNIUOSb6TTQgD9t8hSr4wq9JTLcoA1EH9buFzKJB1Cj8z7MXWvIkoXrS
         DGhwCll4H5PMCCtHTEj7+R+vmcYWLURt97uET8l2Bik+Hd9/4jkVtU9ThOJQbXvvSzBJ
         tjSHV6q03ce1xLCzyD+QNS/IHK0C6dTeNFsW2zwTAzreUlwUOF/tbC56l1TZ8SyINyFH
         4DMByYz7hE1tJ00f2F9X0xbDl3nVS4PC8WeWAuDqSzQUyjbuUUVoriG+NFY4IYzjzFf7
         nsi1QNv3PiqyNWEs0TgnmNjwhruaQMb4kwMvI+saDURZP/i2PQ60OZGBzd3Z5G+FIn+M
         lNqA==
X-Forwarded-Encrypted: i=1; AJvYcCUNTD0GiulBuNnzeEKTIymV9GPh88laTsQrjJZRvSsEe1k8XRiekloSX8ohVb6q9eBkq3bP9yNbFiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzQeR5VqpZEtogR7cw8Vfyh+Vq36o0CX2uS8TXtJxLL2uEHQwC
	RiZO0Bj3oC8JvTJl/2XQw3BZ1pkEr+2WrVC17v/VMgz43kVv/ycOpMXTZQoWiVQQBb0=
X-Gm-Gg: AZuq6aLygE83Qe4eLMoOosdV2iRPG66XB/nqtTaI6sCLz/EV1lqAFcaUoI/x81I39pq
	3hOUu1Y4/6BtEYT9PxnGMtKKjIc0ft7CLnJ98nQ+qDoRpYVi+Lr5U+yCPyrPNOSei0SeExPVUVi
	HevjnEQOfT+4kgXYTnurwXgCLzZVXX6FSKxOLX+yWygxnT7DgmkruMgFa/wOoaD6Ymz7LRsJ2pS
	7hBcFdpeeOD0jUXgJb4bsej2Lh9tL5NEm7ap4V7PNsWo5EgawKRVA5vXMAxfWFZn3TpEInehP0O
	invl3qLcNt2pdeR7vkLhqWBXQU03PG+GZMuzIQTEwj1tmXycpcC+1QptzAxNRsrR5jI1xuaMaDO
	HtbLauNixdaYNakDA2t11GwptKc/8iC18jtIftEIt558GL9tyjdRmv8nrJVuP9tV0CIy19uoWeN
	8JJy3oSGuI0RG5N4GYZNuppt4n4rpmGzFHgyd8xu8CgSgomvu3Hci4babS+NqFdrmK+dAsRA==
X-Received: by 2002:a05:6830:40c4:b0:7cf:d2f3:af8a with SMTP id 46e09a7af769-7d52bf5283amr3020274a34.28.1771695274820;
        Sat, 21 Feb 2026 09:34:34 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:611:96af:f385:64bf? ([2600:8803:e7e4:500:611:96af:f385:64bf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52cf7c4d5sm2827794a34.4.2026.02.21.09.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 09:34:34 -0800 (PST)
Message-ID: <0b9e1c9d-9bee-4fc3-ac19-28d969f65ef2@baylibre.com>
Date: Sat, 21 Feb 2026 11:34:33 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] iio: adc: ti-ads7950: switch to using guard()
 notation
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20260219022929.3558081-1-dmitry.torokhov@gmail.com>
 <20260219022929.3558081-4-dmitry.torokhov@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260219022929.3558081-4-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/18/26 8:29 PM, Dmitry Torokhov wrote:
> guard() notation allows early returns when encountering errors, making
> control flow more obvious. Use it.
> 
> Also variables that now only hold error codes (or 0) are renamed to
> "error" to make their purpose clearer.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/iio/adc/ti-ads7950.c | 105 ++++++++++++++++-------------------
>  1 file changed, 48 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> index 2a7d4a1d9fa9..d31397f37ec4 100644
> --- a/drivers/iio/adc/ti-ads7950.c
> +++ b/drivers/iio/adc/ti-ads7950.c
> @@ -306,18 +306,17 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct ti_ads7950_state *st = iio_priv(indio_dev);
> -	int ret;
> +	int error;
>  
> -	mutex_lock(&st->slock);
> -	ret = spi_sync(st->spi, &st->ring_msg);
> -	if (ret < 0)
> -		goto out;
> +	scoped_guard(mutex, &st->slock) {
> +		error = spi_sync(st->spi, &st->ring_msg);
> +		if (error)
> +			break;

I'm not a fan of scoped_guard() because of the hidden for loop in it.
It hides the fact that the break; is breaking out of that for loop.

It would be more clear/obvious written as:

	do {
		guard(mutex)(&st->slock);

		ret = spi_sync(st->spi, &st->ring_msg);
		if (ret)
			break;

		iio_push_to_buffers_with_timestamp(indio_dev, &st->rx_buf[2],
						   iio_get_time_ns(indio_dev));
	} while (0);

>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, &st->rx_buf[2],
> -					   iio_get_time_ns(indio_dev));
> +		iio_push_to_buffers_with_timestamp(indio_dev, &st->rx_buf[2],
> +						   iio_get_time_ns(indio_dev));
> +	}
>  
> -out:
> -	mutex_unlock(&st->slock);
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
> @@ -326,22 +325,19 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
>  static int ti_ads7950_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
>  {
>  	struct ti_ads7950_state *st = iio_priv(indio_dev);
> -	int ret, cmd;
> +	int error;
> +	int cmd;
> +
> +	guard(mutex)(&st->slock);
>  
> -	mutex_lock(&st->slock);
>  	cmd = TI_ADS7950_MAN_CMD(TI_ADS7950_CR_CHAN(ch));
>  	st->single_tx = cmd;
>  
> -	ret = spi_sync(st->spi, &st->scan_single_msg);
> -	if (ret)
> -		goto out;
> -
> -	ret = st->single_rx;
> -
> -out:
> -	mutex_unlock(&st->slock);
> +	error = spi_sync(st->spi, &st->scan_single_msg);
> +	if (error)
> +		return error;
>  
> -	return ret;
> +	return st->single_rx;
>  }
>  
>  static int ti_ads7950_get_range(struct ti_ads7950_state *st)
> @@ -407,9 +403,9 @@ static int ti_ads7950_set(struct gpio_chip *chip, unsigned int offset,
>  			  int value)
>  {
>  	struct ti_ads7950_state *st = gpiochip_get_data(chip);
> -	int ret;
> +	int error;
>  
> -	mutex_lock(&st->slock);
> +	guard(mutex)(&st->slock);
>  
>  	if (value)
>  		st->cmd_settings_bitmask |= BIT(offset);
> @@ -417,47 +413,44 @@ static int ti_ads7950_set(struct gpio_chip *chip, unsigned int offset,
>  		st->cmd_settings_bitmask &= ~BIT(offset);
>  
>  	st->single_tx = TI_ADS7950_MAN_CMD_SETTINGS(st);
> -	ret = spi_sync(st->spi, &st->scan_single_msg);
> -
> -	mutex_unlock(&st->slock);
> +	error = spi_sync(st->spi, &st->scan_single_msg);
> +	if (error)
> +		return error;
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
>  {
>  	struct ti_ads7950_state *st = gpiochip_get_data(chip);
> -	int ret = 0;
>  	bool state;
> +	int error;
>  
> -	mutex_lock(&st->slock);
> +	guard(mutex)(&st->slock);
>  
>  	/* If set as output, return the output */
>  	if (st->gpio_cmd_settings_bitmask & BIT(offset)) {
>  		state = st->cmd_settings_bitmask & BIT(offset);
> -		goto out;
> +		return state;

This can return directly instead of using local variable.

>  	}
>  
>  	/* GPIO data bit sets SDO bits 12-15 to GPIO input */
>  	st->cmd_settings_bitmask |= TI_ADS7950_CR_GPIO_DATA;
>  	st->single_tx = TI_ADS7950_MAN_CMD_SETTINGS(st);
> -	ret = spi_sync(st->spi, &st->scan_single_msg);
> -	if (ret)
> -		goto out;
> +	error = spi_sync(st->spi, &st->scan_single_msg);
> +	if (error)
> +		return error;
>  
>  	state = (st->single_rx >> 12) & BIT(offset);
>  
>  	/* Revert back to original settings */
>  	st->cmd_settings_bitmask &= ~TI_ADS7950_CR_GPIO_DATA;
>  	st->single_tx = TI_ADS7950_MAN_CMD_SETTINGS(st);
> -	ret = spi_sync(st->spi, &st->scan_single_msg);
> -	if (ret)
> -		goto out;
> -
> -out:
> -	mutex_unlock(&st->slock);
> +	error = spi_sync(st->spi, &st->scan_single_msg);
> +	if (error)
> +		return error;
>  
> -	return ret ?: state;
> +	return state;
>  }
>  
>  static int ti_ads7950_get_direction(struct gpio_chip *chip,
> @@ -473,9 +466,9 @@ static int _ti_ads7950_set_direction(struct gpio_chip *chip, int offset,
>  				     int input)
>  {
>  	struct ti_ads7950_state *st = gpiochip_get_data(chip);
> -	int ret = 0;
> +	int error;
>  
> -	mutex_lock(&st->slock);
> +	guard(mutex)(&st->slock);
>  
>  	/* Only change direction if needed */
>  	if (input && (st->gpio_cmd_settings_bitmask & BIT(offset)))
> @@ -483,15 +476,14 @@ static int _ti_ads7950_set_direction(struct gpio_chip *chip, int offset,
>  	else if (!input && !(st->gpio_cmd_settings_bitmask & BIT(offset)))
>  		st->gpio_cmd_settings_bitmask |= BIT(offset);
>  	else
> -		goto out;
> +		return 0;
>  
>  	st->single_tx = TI_ADS7950_GPIO_CMD_SETTINGS(st);
> -	ret = spi_sync(st->spi, &st->scan_single_msg);
> +	error = spi_sync(st->spi, &st->scan_single_msg);

Can just return directly here now.

> +	if (error)
> +		return error;
>  
> -out:
> -	mutex_unlock(&st->slock);
> -
> -	return ret;
> +	return 0;
>  }
>  
>  static int ti_ads7950_direction_input(struct gpio_chip *chip,
> @@ -514,27 +506,26 @@ static int ti_ads7950_direction_output(struct gpio_chip *chip,
>  
>  static int ti_ads7950_init_hw(struct ti_ads7950_state *st)
>  {
> -	int ret = 0;
> +	int error;
>  
> -	mutex_lock(&st->slock);
> +	guard(mutex)(&st->slock);
>  
>  	/* Settings for Manual/Auto1/Auto2 commands */
>  	/* Default to 5v ref */
>  	st->cmd_settings_bitmask = TI_ADS7950_CR_RANGE_5V;
>  	st->single_tx = TI_ADS7950_MAN_CMD_SETTINGS(st);
> -	ret = spi_sync(st->spi, &st->scan_single_msg);
> -	if (ret)
> -		goto out;
> +	error = spi_sync(st->spi, &st->scan_single_msg);
> +	if (error)
> +		return error;
>  
>  	/* Settings for GPIO command */
>  	st->gpio_cmd_settings_bitmask = 0x0;
>  	st->single_tx = TI_ADS7950_GPIO_CMD_SETTINGS(st);
> -	ret = spi_sync(st->spi, &st->scan_single_msg);
> -
> -out:
> -	mutex_unlock(&st->slock);
> +	error = spi_sync(st->spi, &st->scan_single_msg);

And can return directly here.

> +	if (error)
> +		return error;
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int ti_ads7950_probe(struct spi_device *spi)

