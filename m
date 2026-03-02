Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F530430BB2
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469307; cv=none; b=cNgzWvFI3FHty7xkEOURJLGzxYlRroczKQ9vl0bcBgBUoI+yW+Dqm7GbXZ1haTybUQD8FSjfxnvrs4jOkXD9L54oNltAMk3y6EnIpeIwJT8eD2tqdHO6ZueNX2EnjUM21Iy9gzw0LvywVeNjTCa4XYrYxYEE4spMXt/GMWbLNok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469307; c=relaxed/simple;
	bh=K7uprXXlXGpNCGWNs7Gc9Im+4V02iJz8B2O2SMn99E0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzSHu2k51/rWL+mSQfkgCPz8UuVpFJ4ftQPNhciz2WtX1zS81nCxbjxCE7v9FuLYSm/+9GyOE55Od5hhSTPPj4NvmFw7zZuwDeeH69nvWeMXRtonqZ93Z2RhZ3aFFqwVPN32n0L4lUWjB0FhCKI9xoZgKErZQME3PHI5/KYV8gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IfQE02sy; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IfQE02sy"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79885f4a900so23083977b3.2
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 08:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772469305; x=1773074105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ud7Y6aRnupm7jEop+gG3tOaVzAIasZQEESUFcqBrW9Q=;
        b=IfQE02syzSAEPuCG2xzPM73O3rqlewM/XFt/fxaSWjFB9mq4RZ/oLkdnfpdJp4cCX7
         HIIFvgofCaxYxTGg7bcTLz7rDGKG4otJ1TvLfeIjIN4rKhODbeQ9hyX3y8E15kxTVIbt
         xofQ/sXf41dndOW3qaC8PKLZRSi1onLCAO0pTHfdEWpTtugGd5ATRFgZrJ/a6hTq2vAr
         FAd9/gTWntkLdpvs7DLBkHDwuuuBVK30YlnQXDkkuQf8C82XJ8u0YTSvdz1DL5oFtxWp
         l5z2S8T+9ancRZjh9GtYNd7Tyk82mWBzVT8s37AKuS8DChCuWeomgGimTJADQcXzsj6P
         nM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772469305; x=1773074105;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ud7Y6aRnupm7jEop+gG3tOaVzAIasZQEESUFcqBrW9Q=;
        b=daCAur+Fv2S0sm6yGMl6tcW8McWd1ALSfh5IKLakMOtWqZnGeufRhl5sb3WS4zNAcp
         wejefYhCS2T+X3mgc8jFcKVT1OpulJrtWV3imbsGALQHjI/K1ohfXcahwcgcuxDzUzFF
         GlfxMKXk7f+qOuAzfzFdy6o3TKuVsF6fHjLDzHfTXUdcgUF8K+DaQcunRphijx6edIGa
         NpzOqrMWSgEYAFJrkAfzZWrkxxgCF0qrXKdLNuhOWOYRB4b1RHkt9NZooapuS2q+aKJD
         9C7bswzZAYGiLJLNRkcXRDhV+EMY7BzSPOj4T9kDp55Oqvd7Mm1iIMnrKDCPAvG1QSEK
         XMqw==
X-Forwarded-Encrypted: i=1; AJvYcCVc+Yur5ba/VMmuBtqroVVE537/rptkYrigGW9Wh6Rg3yL30AnlNeA4Mtg16wVN2KnGZxhVabuGjrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAf8euyd4+p7bC5VUd5CaZC04T88BdFIukySVyfPvNipB6A6Mb
	cGto3M1cpMgbcH+cLguKrmkCxocfjgarFli7ugS2HzHdJ0HH8H/uNpeE4PEROk8CJq7vyGTYYjh
	DNjBn
X-Gm-Gg: ATEYQzyMplLZPeYJyegd8AFwrY6AL5Pl9sJS7PJpue7qIMkNlGWFcYRo2uKI2pqvf8L
	ppwVsJhg8NATQzf9npDYwM/8aSndVbWzgFUNu3AX96dspeP6yzDZ/U5DGI0QiJFwLRQtFzqI4kC
	hh055iM6FeMKXsuvGwM/WaIEAcWfiMV81qZfVOpB+mWF33aW5OlrZiscozDmEalDr2Jrlbi9C77
	Vhaehbf8CAEYyxB6tdn79kiiGY4hCB7SfJB7HMsOC04N8o68ybP31sT1aSjjQTEICwwOEyUkBSk
	xfE1txKwk1EHFKWgR9/iIocCzuS6oIObvfcbScoyW2FKvc8FxHLT+zJw0pM8Mp2s/nbkFdbU9+6
	NPdjKFsDT4cfywHMq0/tVrB25gjbYjEjwbs6Zgs8C7XuQjk+YAQ3IUWhYXBqgplno6OQxDGQWgc
	EZWRdmTcfeJUgIMN0LjYzB6GqwWfXfVIY+ahfZbh/bnUcrZCBcnkoRZQxICY/okuelfeyj8xBV2
	C6GKVkyQ6E2
X-Received: by 2002:a05:690c:ed6:b0:798:6561:2a5e with SMTP id 00721157ae682-7988549d803mr108812187b3.19.1772469304705;
        Mon, 02 Mar 2026 08:35:04 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7? ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876bf8103sm53735347b3.27.2026.03.02.08.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 08:35:04 -0800 (PST)
Message-ID: <00c53d76-2820-4db3-97f9-ce136f845609@baylibre.com>
Date: Mon, 2 Mar 2026 10:35:03 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] iio: adc: ad799x: use devm_add_action_or_reset for
 regulators
To: Archit Anant <architanant5@gmail.com>, jic23@kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com
Cc: nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260302130632.29144-1-architanant5@gmail.com>
 <20260302130632.29144-4-architanant5@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260302130632.29144-4-architanant5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/2/26 7:06 AM, Archit Anant wrote:
> Convert the manual regulator_disable() handling to use
> devm_add_action_or_reset(). This guarantees that the regulators are
> disabled in the correct reverse order of allocation during device
> teardown or probe failure.
> 
> This removes the need to manually disable the regulators in the
> remove() function.
> 
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Archit Anant <architanant5@gmail.com>
> ---
>  drivers/iio/adc/ad799x.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 35e0589428d0..1a96b5417ecf 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
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
> @@ -818,6 +825,10 @@ static int ad799x_probe(struct i2c_client *client)
>  		goto error_disable_reg;
>  	st->vcc_uv = ret;
>  
> +	ret = devm_add_action_or_reset(&client->dev, ad799x_reg_disable, st->reg);
> +	if (ret)
> +		return ret;
> +
>  	/* check if an external reference is supplied */
>  	if (chip_info->has_vref) {
>  		st->vref = devm_regulator_get_optional(&client->dev, "vref");
> @@ -840,6 +851,11 @@ static int ad799x_probe(struct i2c_client *client)
>  			if (ret < 0)
>  				goto error_disable_vref;
>  			st->vref_uv = ret;
> +
> +			ret = devm_add_action_or_reset(&client->dev, ad799x_reg_disable,
> +							st->vref);
> +			if (ret)
> +				goto error_disable_reg;

This goto and others should be removed in this patch. devm handles it now.

>  		}
>  	}
>  
> @@ -901,9 +917,6 @@ static void ad799x_remove(struct i2c_client *client)
>  	iio_device_unregister(indio_dev);
>  
>  	iio_triggered_buffer_cleanup(indio_dev);
> -	if (st->vref)
> -		regulator_disable(st->vref);
> -	regulator_disable(st->reg);
>  }
>  
>  static int ad799x_suspend(struct device *dev)

