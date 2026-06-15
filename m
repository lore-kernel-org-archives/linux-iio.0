Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708683845CE
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563100; cv=none; b=MyuYvapUC1YqJKoE0ypBdNA8wvvroa90+jtCv2f9RCr3jpkC2S6laQ+q1QwX5CTRmmhjldaEE830+mdM6Z/yMLx+zxlxVQgN8uydu1b83RhHqpK2k9gMKOpZF1sFiFYtC1V61kKMP/kccyUYrpVf5IUmAH6GZHim4jP8wJJdMSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563100; c=relaxed/simple;
	bh=zmh/9/I+Ra5L4aazE3efwtz83X4risHFng4evJxdkUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQdv86Rwj7/+vawheT9bVJTeo6IiParJbNoIpyi2e0iVuKRo07uho4/6UivJnzuWkOyhRCieu4gJs3pOBBhBrY0xWKrgut+W1J5CFWJr7H67+f7iIpRyZWpaT3WpVD5dfXEK2NCqWjFPTOzOrysM8coLtC2fQTT+PknEM813UFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=PI8hpePX; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="PI8hpePX"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-69e4af5a411so2778111eaf.1
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 15:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781563097; x=1782167897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J4mjjwj3awSpNfiOcNaXS7as/d7nNuOZ0XR39U0Vdf0=;
        b=PI8hpePX/od6rFqYwZJD0h08MCQREHmXS55r0az/ST3+7MXW+gXwHbFVUA+uGdP4PZ
         gR3+eWWGg8xzhipy2anFXl+CFz1Iz901v3vVtYYMmEYzwcNUOqRtGi35mDUABW5gcUXL
         UIUPi0D57PVFXhoeh9apaIXNb7N/GPQtJ6xzHKmDKJCqmPKc4cuDNXguzQaKsESfMRIA
         RAUfYYkPTmFKPWrNrQPWeMEdyRwhserI0j+vPOaQPu0pqBxFVeoYXWOVO/0rU1ddDcuC
         ExhS1Z/wJm/HBlNytSTLlJaxGTOAn9ipRtMMQAJDu8XDT6t7vECMlHfGaWQABLdu/QM2
         fX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781563097; x=1782167897;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4mjjwj3awSpNfiOcNaXS7as/d7nNuOZ0XR39U0Vdf0=;
        b=YL1CAwerEtiJexD0TBJJTIl7JS0JQsjI5FlZ8Wdn0DR74WoXVX0hPzHiA5ntHrn02s
         IHjp+sNeJX2fEUjzfoa9QFtYFKOA5VV8nVxGXSrKJ+nOO50OjLYgZTu/UK/rRsWyfWwm
         6ruFKGiV6hbpKAy3nUkMeXLmya0c7sOQ9OtfXc/9CvUtCVQkBxjAP9ILqQX91XwHtDEd
         ZbN1URm71MmH0ITH82XTHve93Ka+QpplseQ5JWAX0zHmQ7mwIHBfMVgh3fLanuf394Zw
         siJu342Ho23mVdqWf14X0ymO+pQggSZEY1UDegc3FQlWXc4/G51sByVOnW6C45ku7uUs
         TSyw==
X-Forwarded-Encrypted: i=1; AFNElJ+hk+8V3a/Qd9Kxl2OODmxHmI2dN9RY6FKKc4PgxhIOV6T2Q/dSwW8H51ycFGS7bu5iwV5SM4daZAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOuB+KFZpK+Bl0Juz2vBqDdfO7Qf2eB/+AJSbRmJjlsMsE5+9D
	mInUnEGLwwRteR9CxL3mpeW4IrSL6Tbdn0K3uet+/4/e5HPapqb8ByR01wdkmUMKN/A=
X-Gm-Gg: Acq92OG6YAjhH8k4C6e7UlWOm9dPklgzF96ITyoh4rgrAHwcug7B6SbrG107AZV/Y1e
	1q/Q/o1NzoRhdcflC3YmVc3Dr9FSBh6wDK9ql14VDOSMAMHS38Zb4hp17Lv0gxSDAv53ftayw9O
	UrOiU0I/3KQJoDNSENoNwvMw7TfuMxBlM87IM/e089x7tKZTsdMr38BHl9vjs9rFD6jZKwV4WmX
	emW5J2VSKHlXhtJe5aMz2FsBU+cGkOEF9/nx8cTxHWqaG3omKuTpgtrRoYWwtppCoiElT5VuYs4
	o0ufbLmmweEY68zZWk3L+qse1gDjAs6F67V99ESSbvb6Ilwz2f1F/4dFsMdH/PZZKwcWNfk6puS
	VDvNIAe9xtXXS+236CgoI8+uC0gzLb3Dgbg7/Ad48mLZYQJcnIOc8y1fvhVPXYDidAbN5CCdfnf
	HIPS60DVqAky7XQ3tJJ01T3Aq1092S2Cr1evmU8i1AIaYirgQt4KoCMBPT9MUKtoQ8UdiMiaYrm
	Q==
X-Received: by 2002:a05:6820:4c05:b0:69b:544f:b2e1 with SMTP id 006d021491bc7-69eec77e4acmr8859005eaf.2.1781563097377;
        Mon, 15 Jun 2026 15:38:17 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:16b0:5133:47b1:a939? ([2600:8803:e7e4:500:16b0:5133:47b1:a939])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69f00edacdasm3753191eaf.11.2026.06.15.15.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 15:38:16 -0700 (PDT)
Message-ID: <a0e19dd9-c2de-489f-a727-dbc42e5b36da@baylibre.com>
Date: Mon, 15 Jun 2026 17:38:15 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] iio: adc: Fix incorrect reading when datarate
 changed in single mode
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org
Cc: andy@kernel.org, antoniu.miclaus@analog.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, duje@dujemihanovic.xyz, jic23@kernel.org,
 jishnu.prakash@oss.qualcomm.com, jorge.marques@analog.com,
 krzk+dt@kernel.org, linusw@kernel.org, linux-kernel@vger.kernel.org,
 marcelo.schmitt@analog.com, mazziesaccount@gmail.com,
 mike.looijmans@topic.nl, nuno.sa@analog.com, robh@kernel.org,
 sakari.ailus@linux.intel.com, wens@kernel.org, joshua.crofts1@gmail.com
References: <20260613190957.654798-1-jakubszczudlo40@gmail.com>
 <20260613190957.654798-4-jakubszczudlo40@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260613190957.654798-4-jakubszczudlo40@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/26 2:09 PM, Jakub Szczudlo wrote:
> When device is suspended and it is in single mode then changing
> datarate doesn't make it actual wait for new measurement, so to

s/actual/actually/

> be sure that read after change is correct functions that changes
> datarate and gain will wait for new data.

s/datarate/data rate/g


The commit message isn't very clear to me. Is the point that the
changes don't actually take effect in the ADC until a conversion
is done?

> 
> Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
> ---
>  drivers/iio/adc/ti-ads1100.c | 55 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 52 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
> index 76de2466dc53..195394665cd1 100644
> --- a/drivers/iio/adc/ti-ads1100.c
> +++ b/drivers/iio/adc/ti-ads1100.c
> @@ -123,6 +123,36 @@ static int ads1100_get_voltage_microvolts(struct ads1100_data *data)
>  	return ads1100_get_voltage_milivolts(data) * MICRO / MILLI;
>  }
>  
> +static bool ads1100_new_data_ready(struct ads1100_data *data)
> +{
> +	int ret;
> +	u8 buffer[3];
> +
> +	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
> +	if (ret < 3) {
> +		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return FIELD_GET(ADS1100_CFG_ST_BSY, buffer[2]);
> +}
> +
> +static int ads1100_poll_data_ready(struct ads1100_data *data)
> +{
> +	u8 buffer[3];
> +	bool data_ready;
> +	int datarate = data->ads_config->data_rate[FIELD_GET(ADS1100_DR_MASK, data->config)];
> +   // To be sure we wait 5 times more than datarate
> +	unsigned long wait_time = DIV_ROUND_CLOSEST(MICRO, 5 * datarate);
> +
> +	/* To be sure that polled value will have value after config change */
> +	i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
> +
> +	return read_poll_timeout(ads1100_new_data_ready, data_ready,
> +				 !data_ready, wait_time,
> +				 ADS1100_MAX_DRDY_TIMEOUT, false, data);
> +}
> +
>  static int ads1100_data_bits(struct ads1100_data *data)
>  {
>  	return ads1100_data_rate_bits[FIELD_GET(ADS1100_DR_MASK, data->config)];
> @@ -165,6 +194,7 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
>  {
>  	int microvolts;
>  	int gain;
> +	int ret;
>  
>  	/* With Vdd between 2.7 and 5V, the scale is always below 1 */
>  	if (val)
> @@ -185,21 +215,40 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
>  	if (gain < BIT(0) || gain > BIT(3))
>  		return -EINVAL;
>  
> +	ret = pm_runtime_resume_and_get(&data->client->dev);
> +	if (ret < 0)
> +		return ret;
> +
>  	ads1100_set_config_bits(data, ADS1100_PGA_MASK, ffs(gain) - 1);
>  
> -	return 0;
> +	ret = ads1100_poll_data_ready(data);
> +
> +	pm_runtime_put_autosuspend(&data->client->dev);
> +
> +	return ret;
>  }
>  
>  static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
>  {
>  	unsigned int i;
>  	unsigned int size;
> +	int ret;
>  
>  	size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;
>  	for (i = 0; i < size; i++) {
> -		if (data->ads_config->data_rate[i] == rate)
> -			return ads1100_set_config_bits(data, ADS1100_DR_MASK,
> +		if (data->ads_config->data_rate[i] != rate)
> +			continue;
> +
> +		ret = pm_runtime_resume_and_get(&data->client->dev);
> +		if (ret < 0)
> +			return ret;
> +
> +		ads1100_set_config_bits(data, ADS1100_DR_MASK,
>  					FIELD_PREP(ADS1100_DR_MASK, i));

Why no longer checking the return value of ads1100_set_config_bits()?

> +		ret = ads1100_poll_data_ready(data);
> +
> +		pm_runtime_put_autosuspend(&data->client->dev);
> +		return ret;
>  	}
>  
>  	return -EINVAL;

