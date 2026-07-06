Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BD9395AF7
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355466; cv=none; b=R8Lf20WEK0kqbwj7dDBHmQOlzFEJwVJh6kBTjt4sMynhGljZUhbqDaiX3ukKrgGaF8fKIb0EVDF//rVnnNT8mqjFxQGjYKioMp/mUmqfB+3Y1fKE2uX44IGnMu8mZtyLaNAky9CiAZwsewRgv3+oAwdoPnPy75qD8eqnUn903Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355466; c=relaxed/simple;
	bh=I8QYJk3LG6/dJj76RH/oHg/uN7TFDxpmKPIrctEJj+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mXcjD4EODKwf5+Hd+Rur9JifXcS9H0V4LP9vLoN2P44cUhPLrkvZXHXVLYLTL5EpnsouWt1L72x6bDb3ZSZcT3vcLpz6LpL/zqOnN6vbmXpR4dgjAToc2jgupXjWhFVSdaa209QSgrPrtbnsDtuB9Kt/xVgs3H7R0sircUCQQ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=UikVDqbG; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="UikVDqbG"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso2847784a34.3
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 09:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783355463; x=1783960263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W2JVlXDnAv223HzjjuMC/qjZn6HcPUW70uXnl4N1Zws=;
        b=UikVDqbG0f5sMQnliCFbyMFW3FWVKrgEOpjHQ7aAxDIOZ118+KHyw0Dr8EoaQ4lno3
         VXvM0OCPEcxydyxm0ty9m2BI72ujajqrbFQ4rw3/Jbrw1ge9dI9CDuseV6y2UA0CK6ev
         5Z4leQwRbzf82f4ZfMqDLFwF8V59CAV8RvQhLWYuosHZPIX/ArtRek3JRN2LzQSgNrD5
         GudP4qOBppEALw0VnX1iXToxmXQ5HN/LQKh541tlWvYZZ25sIyhvRg6dtXfrxrogxGi7
         Z0MYGH5ARvNi7iIkuGW4Ri4NZ/Ocisx4+xquAQlgFsZEiVhGT7+e/bihkvaIQB5jCIAk
         /Shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783355463; x=1783960263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2JVlXDnAv223HzjjuMC/qjZn6HcPUW70uXnl4N1Zws=;
        b=iohhGv6+Fv3pzsM263298vOpCe5mceutkTuAEq/afV8lCDD8/E82v63qBl/vYM8d67
         HpkfFK2uM2Ee0oUO2fBX7qpRIJBHGQEGAeNSWr0SpEZQkw91pcASIz/BYsng8b8Hx12R
         /yFvVzB4jCQ1ktaxRUZoLU/e/F2Dz+HoHvysIrNVfEXN1BAGokgpxAwWHlx8c4OMxOQo
         d/XO5/7DSXwocPU8i09PlmVgj/GuGl5DFNiTAwol1VUO9fZtWDdUpsZBz4umsujlaY2L
         YhV4zZIgGUCLM75vdBnC7J89rrhOH9SO8ILnZkzK8ktXTkXJXerZm7iSIXOK2fJkYdm0
         qLZw==
X-Forwarded-Encrypted: i=1; AFNElJ/1pZGjtTm6/wMhfdqJqMFGGMMNV2RWj/GETgMPBbwnJucJnO0zT9+KtGPq3w2xYqbQiLf8NevxBHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypk4ZYgo5epgYIWeC0pWY5kIYLYvbURtiu4nXBoYePNLrs25xX
	Sg4hAgPGACAcmXWvk9NuVMaGrhk0sy6/TLDXHLUoctzRuMS4IONCCMBh9f12Sf5d6gM=
X-Gm-Gg: AfdE7ckiMkvsorRnnXSRAwpY1rXIGB5SZ9S5hUaGs4/MlFLcHIkEpe4quxHHDtAzj6z
	EJYMtOFtxIq7CR5Dv1SkvaDfpyuB83NgolgJg/Z6Hc/CL+dD1PLaCYR9br3QxWmun4SuAAbAxEc
	v58+Gc2MzW0WqpIuhqsKhEZZkLWa9sKAz0zkFttQLY1+SykZhqs7zcGz7o3DOw5U2VW6B3tTiaS
	w99WMYuZGQTYo9aQVqLCt64zE5Wz96onlcKNhKnvZtA6q4KKC14N8fP9x7InqWT1bKma4bszfNX
	WE5sMvhMHj7/mR3jhgU1rzB1NJzM49++k19Je7ZARlIkLjuFyX4pSOyayu6d2nFD7yuB/W6azCa
	aRGnyYJQf4AgNZy6Azi2Rt9NsMy3SxIogb+GaCNfOt+5UVdebUlQKeDTYok9QLbQGyMk7Y7wfIZ
	aRwzQxMvV79T2CjJ1w78qV38UtDpXcPv61L5v5ZBfoLNk/2LTVNH8hBudiwyLp7Mc=
X-Received: by 2002:a05:6830:8284:b0:7e6:efb8:fe66 with SMTP id 46e09a7af769-7ebb2240ca0mr792160a34.12.1783355461431;
        Mon, 06 Jul 2026 09:31:01 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a38a:a0af:ed1d:5c77? ([2600:8803:e7e4:500:a38a:a0af:ed1d:5c77])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb544a2706sm11448740a34.17.2026.07.06.09.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 09:30:59 -0700 (PDT)
Message-ID: <867d2cb8-a1f3-49e9-a8a2-04e232f404ab@baylibre.com>
Date: Mon, 6 Jul 2026 11:30:59 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] iio: ti-ads7138: Disable STATS_EN bit while reading
 conversion results
To: Paul Geurts <paul.geurts@prodrive-technologies.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, tobias.sperling@softing.com
References: <20260706074803.13624-1-paul.geurts@prodrive-technologies.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260706074803.13624-1-paul.geurts@prodrive-technologies.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/6/26 2:48 AM, Paul Geurts wrote:
> There is a data race in reading the STATS registers, resulting in wrong
> data being read. When the data in the RECENT register switches between
> 0x24F0 and 0x2500, occasionally value 0x2400 or 0x25F0 is read. This
> happens when the value is updated inbetween reading MSB and LSB.
> 
> The datasheet says: "Until a new conversion result is available,
> previous values can be read from the statistics registers. Before
> reading the statistics registers, set STATS_EN to 0 to prevent any
> updates to this register block." As the STATS_EN is currently not
> cleared, the values of the stats registers might change mid read,
> giving faulty values.
> 
> Disable the STATS_EN bit before reading one of the stistics registers to

s/stistics/statistics/

> make sure the device does not update the register mid read. This is
> applicable to registers MAX_CHn_xSB, MIN_CHn_xSB and RECENT_CHn_xSB.
> 
> This means reading one of the statistics registers resets the MAX and
> MIN registers. This is unfortunate, but necessary to get correct data
> from the device.
> 
> Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
> Fixes: 93a39542d3c3 ("iio: adc: Add driver for ADS7128 / ADS7138")
> ---
> 
> V1 -> V2: Checked return values and prefixed iio: in commit msg
> V2 -> V3:
> 	- Clarified commit msg
> 	- Disable STATS_EN for MIN and MAX too
> V3 -> V4:
> 	- Clarified commit msg more
> 	- Reduced code duplication by creating a statistics read wrapper
> 	  around read_block
> 
> v1: https://lore.kernel.org/all/20260619075646.4100193-1-paul.geurts@prodrive-technologies.com/
> v2: https://lore.kernel.org/all/20260619090004.355053-1-paul.geurts@prodrive-technologies.com/
> v3: https://lore.kernel.org/all/20260624080131.3669357-1-paul.geurts@prodrive-technologies.com/
> ---
>  drivers/iio/adc/ti-ads7138.c | 40 ++++++++++++++++++++++++++++--------
>  1 file changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads7138.c b/drivers/iio/adc/ti-ads7138.c
> index af87f5f19a0f..14096bf3373a 100644
> --- a/drivers/iio/adc/ti-ads7138.c
> +++ b/drivers/iio/adc/ti-ads7138.c
> @@ -227,6 +227,25 @@ static int ads7138_osr_to_bits(int osr)
>  	return -EINVAL;
>  }
>  
> +static int ads7138_read_statistics(const struct i2c_client *client, u8 reg,
> +				   u8 *out_values, u8 length)
> +{
> +	int ret;
> +
> +	/* Disable statistics update so the value is not updated mid read */
> +	ret = ads7138_i2c_clear_bit(client, ADS7138_REG_GENERAL_CFG,
> +				    ADS7138_GENERAL_CFG_STATS_EN);
> +	if (ret)
> +		return ret;

Nice to have a blank line here.

> +	ret = ads7138_i2c_read_block(client, reg, out_values, length);
> +	if (ret)
> +		return ret;

And blank line here too.

And should probably restore ADS7138_GENERAL_CFG_STATS_EN on error
here, but if I2C read doesn't work, we probably have bigger problems,
so maybe OK to keep it simple. I don't remember if this came up in
previous discussions.

> +	/* Enable statistics update after read */
> +	ret = ads7138_i2c_set_bit(client, ADS7138_REG_GENERAL_CFG,
> +				  ADS7138_GENERAL_CFG_STATS_EN);

Would be simpler to just return directly.

> +	return ret;
> +}
> +
>  static int ads7138_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan, int *val,
>  			    int *val2, long mask)
> @@ -236,28 +255,31 @@ static int ads7138_read_raw(struct iio_dev *indio_dev,
>  	u8 values[2];
>  
>  	switch (mask) {

IIO style is to have /* on separate line for multi-line comments.

> +	/* Reading the statistics registers reinitializes them. This is unfortunate
> +	 * but necessary to prevent data races
> +	 */
>  	case IIO_CHAN_INFO_RAW:
> -		ret = ads7138_i2c_read_block(data->client,
> -					     ADS7138_REG_RECENT_LSB_CH(chan->channel),
> -					     values, ARRAY_SIZE(values));
> +		ret = ads7138_read_statistics(data->client,
> +					      ADS7138_REG_RECENT_LSB_CH(chan->channel),
> +					      values, ARRAY_SIZE(values));
>  		if (ret)
>  			return ret;
>  
>  		*val = get_unaligned_le16(values);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_PEAK:
> -		ret = ads7138_i2c_read_block(data->client,
> -					     ADS7138_REG_MAX_LSB_CH(chan->channel),
> -					     values, ARRAY_SIZE(values));
> +		ret = ads7138_read_statistics(data->client,
> +					      ADS7138_REG_MAX_LSB_CH(chan->channel),
> +					      values, ARRAY_SIZE(values));
>  		if (ret)
>  			return ret;
>  
>  		*val = get_unaligned_le16(values);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_TROUGH:
> -		ret = ads7138_i2c_read_block(data->client,
> -					     ADS7138_REG_MIN_LSB_CH(chan->channel),
> -					     values, ARRAY_SIZE(values));
> +		ret = ads7138_read_statistics(data->client,
> +					      ADS7138_REG_MIN_LSB_CH(chan->channel),
> +					      values, ARRAY_SIZE(values));
>  		if (ret)
>  			return ret;
>  

Reviewed-by: David Lechner <dlechner@baylibre.com>

If you are lucky, Jonathan might pick this up and tweak it, so wait
a bit before more feedback before sending a v5.
