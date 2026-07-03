Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106BF283FCE
	for <linux-iio@vger.kernel.org>; Fri,  3 Jul 2026 21:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783112659; cv=none; b=Q2+AlOrZcDRZCvGLYyPrhTfDncmt1NGRvca/jkCj7ktv4OnvWZNU7UV36TCVnkpesWPX3MBEGFf6EJRzHK2T9BpdzDJ1EOySt92+LmbYBQrkCeY5o13ZlHOr/efxDKBusOXLmcjcCCBURLTBln1hxTsbAJ9j37i+hNPD7T5S74k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783112659; c=relaxed/simple;
	bh=MQy31eRIJfry7Mo9HLrWsPnb0wqDDcV/DtFzKv2+j7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Is+VssoGlNgFKLeTml7k+h40XqeBJIHJipemK6hpN38uCsU20ZEsfhllHTbtk4NDXn+7FPumjKOphtcVw6SNMWOa7uJ2Ibvd5+/34INNEKu29YbT/McZ9Z8k/FGga1MZHGE2kCAujHPMG9qdotF8Cbq9sLCcdT86C3HQcEeYi50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=S2Y1tGNU; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="S2Y1tGNU"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4876d5335b2so565498b6e.1
        for <linux-iio@vger.kernel.org>; Fri, 03 Jul 2026 14:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783112656; x=1783717456; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BLvAnZoezxC+9vK/RWbW1DG6Jw4oqR7pajbloqOy9bs=;
        b=S2Y1tGNUMnKdnQfMqQZJklgskkJfEM2wmhYmXs4ZwxBYMRlIkvXIV1xCHDufJ8cuOi
         HX8wuDsSXC8yBHPZD0ou32r/ZMo94c4ftaCOntNPujVPQ68qgkWYPy3ZIkzVpajULx4u
         jV5qjRNEII2yF+WV3uHDMdr1bYzmlCoRBBqUzNygXa3a922fnd8oDI7wps/Gc0S3BAGX
         cngpQZggZ2p6cf9rO7oHcY7gI0B0joPA/dihoVqUpz80CGJj/KAgAIOp5BIMSYRD4x5B
         COgdWPzuatsDJg9O8V1wAhkfUv1X/NVa2TWQupeiBYAk/CRZ0ngqkn0b0SLlpBmLqB71
         TzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783112656; x=1783717456;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BLvAnZoezxC+9vK/RWbW1DG6Jw4oqR7pajbloqOy9bs=;
        b=dz6h6YbAIhO5RpmtilSFn5pu5CL1fnn92xvUOTiQJSTW9m1pebKo5I7nCAnaCDJRKJ
         kH3HP5DyHa/Lq9LM4GMp2g1aVV4/QcYHk8tNvruXY/Z4T9JzoXYzHfRTVpigxkqu9wQe
         P7djPjZxFpdH8et32D7sB3lyHv5f1Fzq7R7Lt/C6fZxMo3VTq2yLH99FqfHMmjbxiFxD
         ib/UkYkefswue/gjbzFleWcj1CEPBw2/n/oLdhiw4j6p/tGICXIb8Pw1gb06Tg43JriG
         38XXifJh+C8E8B7S/nyfyobhBym5LufsT/QyN7j6f6vXE8KM8WjjXmI52pr9pAUCwe0C
         J1EA==
X-Forwarded-Encrypted: i=1; AFNElJ8faMRzeJfp1lUk/iywYFwrfKj/0iC5S6k8Irz6jIXlEv2XL5TCJEFwSKcxVoVu5Wv6lsdZIgk5syM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEK4GrYywqN5HaTT2LXg4HKYq4VZHMbO2iyCm4lxZKpqriABCj
	WmwfQPgP0peCMoWOEp2G+BkTpvAzTXxIBpoC4YYCttev9R1JvI18T6M3sHs3hNblouc=
X-Gm-Gg: AfdE7cltgIbTNYIUakcxFMcWZfO7UUWVYucYnWIlB8q/ST4jLye4QRIuKfvaCdgPLsg
	6CAH7XJjnBwCRmVb5BvVRBJ9Kw8+0JJ4kCu0UwaEg6N7JFi8+B6otzi7v88+BBu8pjv8Bt2h5rs
	sEPHu33Q8tQk13xgWg3B6rsEYGSPB7agNd+eEA5M/uB/OA+4YUGRKzyRWH2NDC/9rBnKEKZgxY5
	HS42ugkngWPaFkizGNbkGvPyJStRsKOCZ4d7DnCpZmf6z7tes33vb/S3ZnsImsxE9Ita5yhNTZo
	3EfiPX/EV29Jf++qSvIizxf36Kz6JOVS+CWJ9z4150CnuSFqFKnnhzLJyjzVu07DXJFw2mdt8wN
	wwWKbxuivpe+WV7MPQ4IfFSeGEfIqhJon3ctyOmWwp525CO0H+zvUsWAVMnnsr6Ib5iM9gtjWNe
	y2W4tQre28E4Yist3x+OvAwRXjQuv5XOk5bi1eCxuumukP9+1Q3Wk3wNVPzoIhGXA=
X-Received: by 2002:a05:6808:1510:b0:496:a36:b5e5 with SMTP id 5614622812f47-499b79f805dmr422098b6e.17.1783112655990;
        Fri, 03 Jul 2026 14:04:15 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6af9:a9d7:17b5:2644? ([2600:8803:e7e4:500:6af9:a9d7:17b5:2644])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-497d1af5a51sm4927539b6e.10.2026.07.03.14.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 14:04:15 -0700 (PDT)
Message-ID: <d78d5f30-7f32-4998-8dc4-f17c61a5f81b@baylibre.com>
Date: Fri, 3 Jul 2026 16:04:14 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
To: Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ciprian Hegbeli <ciprian.hegbeli@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260703102941.1141341-1-stefan.popa@analog.com>
 <20260703102941.1141341-3-stefan.popa@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260703102941.1141341-3-stefan.popa@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/26 5:29 AM, Stefan Popa wrote:
> The MAX40080 is a bidirectional current-sense amplifier with an
> integrated 12-bit ADC and an I2C/SMBus interface. It measures the
> voltage across an external shunt resistor and the input bus voltage,
> storing the results in an internal FIFO.
> 
> Add a direct-mode IIO driver exposing the current and voltage channels
> with raw, scale and hardware-gain attributes, a configurable

Patch does not implemnt hardware-gain attribute (which is correct,
so just fix the commit message).

> oversampling (digital averaging) ratio, and PEC-protected register
> access. The current scale is derived from the shunt resistor value
> described in the device tree.
> 
> +static int max40080_update_bits(struct max40080_state *st, u8 reg,
> +				u16 mask, u16 val)
> +{
> +	int ret;
> +	int tmp;
> +
> +	guard(mutex)(&st->lock);

Usually we don't want the lock at this level in case anything needs to
update more than one register in an atomic operation.

> +
> +	tmp = i2c_smbus_read_word_data(st->client, reg);
> +	if (tmp < 0)
> +		return tmp;
> +
> +	tmp &= ~mask;
> +	tmp |= val & mask;
> +
> +	ret = i2c_smbus_write_word_data(st->client, reg, tmp);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +

...

> +static int max40080_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val,
> +			     int *val2,
> +			     long mask)
> +{
> +	struct max40080_state *st = iio_priv(indio_dev);
> +	unsigned int range;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->type == IIO_CURRENT) {
> +			ret = max40080_get_current(st, val);
> +			if (ret)
> +				return ret;
> +		} else if (chan->type == IIO_VOLTAGE) {
> +			ret = max40080_get_voltage(st, val);
> +			if (ret)
> +				return ret;
> +		}

Se usually use switch statement in IIO instead of else if.

> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_CURRENT) {
> +			/*
> +			 * The selectable current-sense range is exposed through
> +			 * scale: each RANGE setting has its own precomputed
> +			 * mA-per-code value. Userspace picks the range by writing
> +			 * the matching scale.
> +			 */
> +			ret = max40080_get_range(st, &range);
> +			if (ret)
> +				return ret;
> +
> +			*val = st->current_scale[range][0];
> +			*val2 = st->current_scale[range][1];
> +			return IIO_VAL_INT_PLUS_NANO;
> +		}
> +		/* voltage[mV] = raw * Vref[mV] * buffer_gain / ADC_RES */
> +		*val = MAX40080_INTER_VREF_MV * MAX40080_V_BUFF_GAIN;
> +		*val2 = MAX40080_ADC_RES;
> +		return IIO_VAL_FRACTIONAL;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		ret = max40080_get_oversampling_ratio(st, val);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

...

> +static int max40080_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct max40080_state *st;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_WORD_DATA |
> +				     I2C_FUNC_SMBUS_I2C_BLOCK |
> +				     I2C_FUNC_SMBUS_QUICK))
> +		return -EOPNOTSUPP;
> +
> +	client->flags |= I2C_CLIENT_PEC;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	st = iio_priv(indio_dev);
> +	st->client = client;
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	if (device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> +				     &st->shunt_resistor_uohm))
> +		st->shunt_resistor_uohm = 1000000; /* default 1 ohm */
> +
> +	if (!st->shunt_resistor_uohm)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "shunt-resistor-micro-ohms must be non-zero\n");
> +
> +	max40080_calc_current_scale(st);
> +
> +	indio_dev->name = "max40080";
> +	indio_dev->info = &max40080_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = max40080_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max40080_channels);
> +
> +	/* No averaging by default; configurable at runtime via sysfs. */
> +	ret = max40080_init(st, 1);

Why have a paramter if it is always the same value? Can just move
this comment into the init function and drop the arg.

> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id max40080_i2c_ids[] = {
> +	{ "max40080" },

Include `.name = `

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max40080_i2c_ids);
> +

