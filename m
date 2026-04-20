Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1165D1E5724
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776718836; cv=none; b=GhNsJZldEqyY8A+ymDo76GfnzJQLayMg0YDpKImuSrDUKMUCo3qxW14wB0LvSHfxkwnX2wx6K/u+J6+DslGsfuB5b8dgsRQKrJQKKEYSc9x26Er9HQG7fXO4HFpjx8FEX1Yg8ALan7xv4oQEHFq8Avd6vghu0zu7C1YnIS84+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776718836; c=relaxed/simple;
	bh=XKR2lk7zr4HQiraJN6Bw/X/+LzT8sCignNs0wY6dRWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XqU3m9EMrEw7QtiOAhw5ztA8VZdLFtvvp/VWOezQdDAQl1pgdA/Jzd6eV45qHPlXZq6F2fR3TK9SnY76njqxiKL3+yHGjxY/oZgWhistbq0SvzfJPD3M4WT3NBWDeMNbli98iD2aqCzDVbEvXMhNSrtuegXauIod1BzcSdmMsuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=O29nd82V; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="O29nd82V"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-409de4132b5so2201886fac.1
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 14:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776718833; x=1777323633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zNz6rDdwfLQZgTV2/unumMktA67Lz634Z8Ok1nd1/uA=;
        b=O29nd82VC9MEjsV+qivwF4Rx58t0i9bRtONkbPfhaHz/B0tovZhtIT6Tx2DvcEHrjY
         sP95MsdGIE+xVfZFkWMzzjB9qqxXm/K8AZuYdr8qtUMsnXaTOY+3kPdyAjaZ2WvHxNaJ
         fEBACJlRe4RZ/tmE4U8seTIlzYSm7/U1cXMuHie3lJrnc7mTKk/Lajk3zOZFPCuznSX7
         OxQNYAt/fJyMWPv3f9r8XwUUOiLB+6zMg+YLzJpilUUuMZ7dLYEIq57HTnyFjFDb46+3
         mxhyu8EfQJXfnrblhV/A6jMYxSTOpsHbGq/aexJuTMwlh7F2pYMrK/sisYmUfH+9xhE4
         7Ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776718833; x=1777323633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zNz6rDdwfLQZgTV2/unumMktA67Lz634Z8Ok1nd1/uA=;
        b=rprHvEut49kfVoSZna4uOMACnN8jfx5AB75IeLDY6OGi6rsOTluhBz39paN2aY2jvJ
         N37I8vL8m6GyE0NROs1jDNaw2IaVnad44u18cjyojeVStvOGlOBwa3fgHfHdkBsNRDkt
         ff/7wiWw1SRBfTawFK2sm7ZyjcE7i3/VIGfRX7qNp0OjW6R838iLUqj2Wk9cfoDjnvag
         aKtlaY0zLCHiNSYsFhv0Lset+NTfTOjj2zvK7zz7wr1HzpwBRTxi0Zu1+S9d5J3/Hb6d
         giD//5nSSIfumFsySMG47y0nJ4G5BaoFGFw7l6gHI4y7wGjDYMVJTpQcemaa60aaba0R
         sw9w==
X-Forwarded-Encrypted: i=1; AFNElJ/2y26dnGFMFMglwhxfD4VFTshvSbsStP+P/wzK25JmwaWe0xkqIgo1wl5+g2zs+1wrzGzCaWeQJec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmKIWJIAweUHqImM8iqEt53s8ZvnjxYCvgOx0ZA1h1Bkb9mTZI
	CQbOsWxTTltlLvBBmYgyharISitiZl7y/mh5wSkdz6YwmziALr/PuDIXvhkZMv3H5zA=
X-Gm-Gg: AeBDietqYqwayscpzH6X3EzyvIfpFGLH7l8Pa0ngtiqDEKw44QQPPo/3pdPWwtGkd0Y
	eaUOqhxt4bn92d6hRRHml6gTZsR0f7WcRK+N44ycwwiuyuvm3ftldp80hROAAVDU8xiDGzzUpFJ
	W1GFEZYnByAPL+5ARUpLW/ORI4eZutbHzraIdnaXWkSmLR+CCkEhJLKw6Bvz02tU2FU79IvE4Fr
	rIe1ayo802BJNe4bnLliEFC1aPGZM81imjtYbD4PM4Hb3ckz3xbKWNtZmJEUwCH0Ky9KwZMVDF9
	FT+6i3i4x0L8+Dz4QLfg/sR9bl2mEfk0wGp2SpAjG0J1B7377ASzVO1ncV4zGJ00sJuuW1Rzd9D
	DrwV883aHRR1dPX9lObSOPDxZGxZefYqJlaHtpQ0E+YJ5qKvfWioVMFQEjOjhzCc8/uioyexBUw
	PosVsB4kSkc4K+BcHvQC9nVvEjYWeHk/o4bfeOE1e3vWqSZFMQJ9//4Qu8+D2+SLXeELmPk00fz
	CE0ZocdfVst
X-Received: by 2002:a05:6870:7a16:b0:417:304f:5011 with SMTP id 586e51a60fabf-42abf307da6mr8395753fac.17.1776718832856;
        Mon, 20 Apr 2026 14:00:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:49fb:b337:a968:94e7? ([2600:8803:e7e4:500:49fb:b337:a968:94e7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b9ac6f2a3sm10410463fac.16.2026.04.20.14.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 14:00:32 -0700 (PDT)
Message-ID: <26330121-79bd-4273-b8e4-17efa19454eb@baylibre.com>
Date: Mon, 20 Apr 2026 16:00:31 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: veml6030: Generalize hw_init for veml6030 and
 veml6035
To: Gabriel Braga Lagrotaria <gabrielblo@ime.usp.br>,
 javier.carrasco.cruz@gmail.com, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org
Cc: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>,
 Ellian Carlos <elliancarlos@gmail.com>, linux-iio@vger.kernel.org
References: <20260420201441.18055-1-gabrielblo@ime.usp.br>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260420201441.18055-1-gabrielblo@ime.usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/20/26 3:14 PM, Gabriel Braga Lagrotaria wrote:
> Add a new veml603x_hw_init() function to deduplicate the setup logic
> for veml6030_hw_init() and veml6035_hw_init().
> 
> Additionally, introduce struct veml603x_hw_init_config to store and
> pass the custom configuration values specific to each device variation.
> 
> Signed-off-by: Gabriel Braga Lagrotaria <gabrielblo@ime.usp.br>
> Co-developed-by: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
> Signed-off-by: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
> Co-developed-by: Ellian Carlos <elliancarlos@gmail.com>
> Signed-off-by: Ellian Carlos <elliancarlos@gmail.com>
> ---
>  drivers/iio/light/veml6030.c | 98 +++++++++++++++---------------------
>  1 file changed, 41 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> index 6bcacae38..84a551683 100644
> --- a/drivers/iio/light/veml6030.c
> +++ b/drivers/iio/light/veml6030.c
> @@ -963,19 +963,38 @@ static int veml6030_regfield_init(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> -/*
> - * Set ALS gain to 1/8, integration time to 100 ms, PSM to mode 2,
> - * persistence to 1 x integration time and the threshold
> - * interrupt disabled by default. First shutdown the sensor,
> - * update registers and then power on the sensor.
> - */
> -static int veml6030_hw_init(struct iio_dev *indio_dev, struct device *dev)
> +struct veml603x_hw_init_config {

Generally we try to avoid "x" wildcard in names as it is not particularly
future-proof. We can just use veml6030 since that is the driver name.

> +	const struct iio_gain_sel_pair *gain_sel;
> +	int gain_sel_size;
> +	int gain_max_scale_int;
> +	int gain_max_scale_nano;
> +	unsigned int reg_als_conf_value;
> +};

Would it make sense to add this to the chip info instead of creating
new tables?

> +
> +static const struct veml603x_hw_init_config veml6030_hw_init_config = {
> +	.gain_sel = veml6030_gain_sel,
> +	.gain_sel_size = ARRAY_SIZE(veml6030_gain_sel),
> +	.gain_max_scale_int = 2,
> +	.gain_max_scale_nano = 150400000,
> +	.reg_als_conf_value = 0x1001,
> +};
> +
> +static const struct veml603x_hw_init_config veml6035_hw_init_config = {
> +	.gain_sel = veml6035_gain_sel,
> +	.gain_sel_size = ARRAY_SIZE(veml6035_gain_sel),
> +	.gain_max_scale_int = 0,
> +	.gain_max_scale_nano = 409600000,
> +	.reg_als_conf_value = VEML6035_SENS | VEML6035_CHAN_EN | VEML6030_ALS_SD,
> +};
> +

Or if we want to keep these to avoid duplication...

> +static int veml603x_hw_init(struct iio_dev *indio_dev, struct device *dev,
> +			    const struct veml603x_hw_init_config *cfg)
>  {
>  	int ret, val;
>  	struct veml6030_data *data = iio_priv(indio_dev);
>  
> -	ret = devm_iio_init_iio_gts(dev, 2, 150400000,
> -				    veml6030_gain_sel, ARRAY_SIZE(veml6030_gain_sel),
> +	ret = devm_iio_init_iio_gts(dev, cfg->gain_max_scale_int, cfg->gain_max_scale_nano,
> +				    cfg->gain_sel, cfg->gain_sel_size,
>  				    veml6030_it_sel, ARRAY_SIZE(veml6030_it_sel),
>  				    &data->gts);
>  	if (ret)
> @@ -985,7 +1004,7 @@ static int veml6030_hw_init(struct iio_dev *indio_dev, struct device *dev)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "can't shutdown als\n");
>  
> -	ret = regmap_write(data->regmap, VEML6030_REG_ALS_CONF, 0x1001);
> +	ret = regmap_write(data->regmap, VEML6030_REG_ALS_CONF, cfg->reg_als_conf_value);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "can't setup als configs\n");
>  
> @@ -1019,6 +1038,17 @@ static int veml6030_hw_init(struct iio_dev *indio_dev, struct device *dev)
>  	return ret;
>  }
>  
> +/*
> + * Set ALS gain to 1/8, integration time to 100 ms, PSM to mode 2,
> + * persistence to 1 x integration time and the threshold
> + * interrupt disabled by default. First shutdown the sensor,
> + * update registers and then power on the sensor.
> + */
> +static int veml6030_hw_init(struct iio_dev *indio_dev, struct device *dev)
> +{
> +	return veml603x_hw_init(indio_dev, dev, &veml6030_hw_init_config);
> +}
> +

... then drop these wrapper functions and just put the pointer to the
hw_init_config in the chip info.

>  /*
>   * Set ALS gain to 1/8, integration time to 100 ms, ALS and WHITE
>   * channel enabled, ALS channel interrupt, PSM enabled,

I think this comment and the one a bit above would mame more sense now
on the hw_init_config structs since that is where the actual parameters
are defined.

> @@ -1028,53 +1058,7 @@ static int veml6030_hw_init(struct iio_dev *indio_dev, struct device *dev)
>   */
>  static int veml6035_hw_init(struct iio_dev *indio_dev, struct device *dev)
>  {

...

> +	return veml603x_hw_init(indio_dev, dev, &veml6035_hw_init_config);
>  }
>  
>  static int veml6030_probe(struct i2c_client *client)

