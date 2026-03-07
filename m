Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383ED21FF23
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772903840; cv=none; b=KIDxYZD8kwBAGil6XZOneNXgfwbM76vamutiPcUroRj6A8kdLWCRjnZxUJJMftdK4p9/UJFx0vcauE9aO0E2t8GR2+CfpDeaX3k3NbrU41+Mg0WCY9PKNj+yq/dV3E8c/zh7KnXgR4WIR4hzMQSzhYt1tMnnYRF1TJQjSb6GNQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772903840; c=relaxed/simple;
	bh=q2HQcfiT/KoQa7CVQjSe9h4G+/m15DVdnGvuTp+vQTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6MhbWwp29y+KcxN6Bb/JQPeY4xqIYLAOpv41AOsbmgtTBtffg+47mYReRCHvDimiXa55oH+i2DHzZ3rY7o3llV5LlR14tdpS4ZI7C3ExJ2oDySyKZuPU5p8MK1l+yURgHzLLG++a/dRoLrCQ/GLY65zGncgCx0olC6qeOPYPd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BXDUau7i; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BXDUau7i"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45f053b7b90so6756373b6e.0
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 09:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772903837; x=1773508637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uLqbBF+LpizOINU7hVvdD1525Ju0a1AaHblaI6jxaPo=;
        b=BXDUau7irOnfFiTavMo2iTXcArn411Bc0S6cLgYkwFoZ8v0KG2gsZRXLB9T+RW8mGS
         3g7FCsqytpsc9BIilmZ8POvmKEnGaLKeku1I5OPBw81gNjTUcKueXJpUjN+by807qHGT
         ZSRcS7WByOgZyA11hJKDnykgjroRzVYyZ7A94WKCinj3BDuAMFsl6/sGNSRhkWYvdtKa
         exy076ci+ByJhRsSUE8i3weYW4FcFAkHOPNE9MKTiVRQYJK0gKkZpDPGAehnrqp6I7PB
         ru8wsuARRnGGTO+jp+N48K99OjQEtG7SYMalohLEI1zQxTKP6/01mx+6JCfTw4Isj5xY
         UNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772903837; x=1773508637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uLqbBF+LpizOINU7hVvdD1525Ju0a1AaHblaI6jxaPo=;
        b=OQoB8WC2zPIp+iSMgT06zxPqSMLi6Hq5JYl0XUkZpoDsmu1xV0G5vOLgXBjqBJrkt8
         600uXlGXPeLp7CwpyibtML0HeBAyHv2EzB2+aiMPOTIKlVnRSGScz3EoPpiuvcdvTMlj
         l/jpnTNoETg5hSC6BscZCxj6d39kCoBFPHBWRSbqBsnAneiHthrqnQ8MI8tA4B0jjJ49
         6qdUr9PQnbziTV7xh+d6udCNTJ0/urGd1wr0WDZDYPeO4MUwu793NRCCW6oJM1aAJ8tI
         v5sjNFjjYrPe20rt0Rn56B+DZM/YoYCBgqWUe3AetwiYHyjmAUiGtR3VtrXTbAmPW9z3
         dAOA==
X-Forwarded-Encrypted: i=1; AJvYcCXmE3z705ALIj6ZcbjayXF0q6sdY9pKJWNMo+pqqWRU+8knh3Xg/O5opWA4hf6mqZG+bopDusvSTa0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8qK62VfjxV3NjpCE91dSIZl0ASjtEa9gkQNy0XWIMYlnqDPqU
	/Ow3KwXjgO0WYa5B+e6EQUkbpwfGLbBYt5Wp/cJGrYyj8IgGUqROju63TFgkHWRbNHU=
X-Gm-Gg: ATEYQzxhSK4UswvtzuJhBI3n98Rp/Zu1jpUkvRFeGMYnjXJ4oJrhCjBfcYts9MN1iae
	LTndYO93oZ0YBXi6ZSRVbwZlhnXhfbvnKINE1ObnFIFBOis1LaHN22LU//qnA8BV+bMEaOWCXRE
	txtewmUklJvPdZeGHjwTL00wt+vrIV6+prBo8WIzQV09Y/p58gJXKTKJb79E7k9iNMzR9u8GRee
	KNJZV8KWY6eYeNcCV4xlpjiQXdA502GyYyKMfTKis4s74/VmldPF0euK7V+hodDeyiZf2le7BHu
	54a/ixR4q1ypyr7sfZhGEYhK3eifUOgzI21l9x7w7Rnr1+d6owZFS+ojdFsHdbaJE6DdLtDlXaF
	TmejJlihRgGD33kJbYRJ/x3TbvKvtfscKQrqkxwIIgu4fPs7RPWq6A6yEywFY2mg0QWXMKfdetR
	aQwultwD3MmiNccZ/qh0u02UDPzKd1KZIB7CsuvuYReSINT1b4iJ5n3MIkhksiGTtd4uKJWXXNy
	Q==
X-Received: by 2002:a05:6808:838b:b0:466:efb5:9434 with SMTP id 5614622812f47-466efb59cc0mr768015b6e.31.1772903837147;
        Sat, 07 Mar 2026 09:17:17 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:cccf:5174:fa72:c520? ([2600:8803:e7e4:500:cccf:5174:fa72:c520])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466df93e85fsm2677663b6e.2.2026.03.07.09.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 09:17:15 -0800 (PST)
Message-ID: <3181de17-d3f6-479e-9500-f5d552bb4151@baylibre.com>
Date: Sat, 7 Mar 2026 11:17:15 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: proximity: add driver for ST VL53L1X ToF sensor
To: Siratul Islam <email@sirat.me>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
References: <20260303090253.42076-1-email@sirat.me>
 <20260303090253.42076-3-email@sirat.me>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260303090253.42076-3-email@sirat.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/3/26 3:02 AM, Siratul Islam wrote:
> Add support for the STMicroelectronics VL53L1X Time-of-Flight
> ranging sensor with I2C interface.
> 

...

> +static int vl53l1x_set_distance_mode(struct vl53l1x_data *data,
> +				     enum vl53l1x_distance_mode mode)
> +{
> +	int ret;
> +
> +	switch (mode) {
> +	case VL53L1X_SHORT:
> +		ret = regmap_write(data->regmap,
> +				   VL53L1X_PHASECAL_CONFIG__TIMEOUT_MACROP,
> +				   0x14);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap,
> +				   VL53L1X_RANGE_CONFIG__VCSEL_PERIOD_A, 0x07);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap,
> +				   VL53L1X_RANGE_CONFIG__VCSEL_PERIOD_B, 0x05);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap,
> +				   VL53L1X_RANGE_CONFIG__VALID_PHASE_HIGH,
> +				   0x38);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap, VL53L1X_SD_CONFIG__WOI_SD0,
> +				   0x07);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap, VL53L1X_SD_CONFIG__WOI_SD1,
> +				   0x05);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap,
> +				   VL53L1X_SD_CONFIG__INITIAL_PHASE_SD0, 6);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap,
> +				   VL53L1X_SD_CONFIG__INITIAL_PHASE_SD1, 6);

Maybe worth using regmap_multi_reg_write() above and below?

> +		break;
> +	case VL53L1X_LONG:
> +		ret = regmap_write(data->regmap,
> +				   VL53L1X_PHASECAL_CONFIG__TIMEOUT_MACROP,
> +				   0x0A);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap,
> +				   VL53L1X_RANGE_CONFIG__VCSEL_PERIOD_A, 0x0F);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap,
> +				   VL53L1X_RANGE_CONFIG__VCSEL_PERIOD_B, 0x0D);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap,
> +				   VL53L1X_RANGE_CONFIG__VALID_PHASE_HIGH,
> +				   0xB8);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap, VL53L1X_SD_CONFIG__WOI_SD0,
> +				   0x0F);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap, VL53L1X_SD_CONFIG__WOI_SD1,
> +				   0x0D);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap,
> +				   VL53L1X_SD_CONFIG__INITIAL_PHASE_SD0, 14);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(data->regmap,
> +				   VL53L1X_SD_CONFIG__INITIAL_PHASE_SD1, 14);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (ret)
> +		return ret;
> +
> +	data->distance_mode = mode;
> +	return 0;
> +}
> +

...

> +	return ret;
> +}
> +
> +static const struct iio_chan_spec vl53l1x_channels[] = {
> +	{
> +		.type = IIO_DISTANCE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +		},
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(1),
> +};
> +
> +static int vl53l1x_read_raw(struct iio_dev *indio_dev,
> +			    const struct iio_chan_spec *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct vl53l1x_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (chan->type != IIO_DISTANCE)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:

What is here is perfectly fine, but I'm sure someone will eventually
want to change it to IIO_DEV_ACQUIRE_DIRECT_MODE().

> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		ret = vl53l1x_read_proximity(data, val);
> +		iio_device_release_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		*val2 = 1000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int vl53l1x_validate_trigger(struct iio_dev *indio_dev,
> +				    struct iio_trigger *trig)
> +{
> +	struct vl53l1x_data *data = iio_priv(indio_dev);
> +
> +	return data->trig == trig ? 0 : -EINVAL;
> +}
> +
> +static const struct iio_info vl53l1x_info = {
> +	.read_raw = vl53l1x_read_raw,
> +	.validate_trigger = vl53l1x_validate_trigger,
> +};
> +
> +static irqreturn_t vl53l1x_trigger_handler(int irq, void *priv)
> +{
> +	struct iio_poll_func *pf = priv;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct vl53l1x_data *data = iio_priv(indio_dev);
> +	struct {
> +		u16 distance;
> +		aligned_s64 timestamp;
> +	} scan = {};
> +	unsigned int range_status;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, VL53L1X_RESULT__RANGE_STATUS,
> +			  &range_status);
> +	if (ret || (range_status & VL53L1X_RANGE_STATUS_MASK) !=

Probably best to use FIELD_GET() here and redefine VL53L1X_RANGE_STATUS_VALID
accrodingly.

> +			   VL53L1X_RANGE_STATUS_VALID)
> +		goto done;
> +
> +	ret = vl53l1x_read_u16(data,
> +			       VL53L1X_RESULT__FINAL_CROSSTALK_CORRECTED_RANGE_MM_SD0,
> +				   &scan.distance);
> +	if (ret)
> +		goto done;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
> +					   iio_get_time_ns(indio_dev));
> +
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	vl53l1x_clear_irq(data);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t vl53l1x_threaded_irq(int irq, void *priv)
> +{
> +	struct iio_dev *indio_dev = priv;
> +	struct vl53l1x_data *data = iio_priv(indio_dev);
> +
> +	if (iio_buffer_enabled(indio_dev))
> +		iio_trigger_poll_nested(indio_dev->trig);
> +	else
> +		complete(&data->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int vl53l1x_configure_irq(struct i2c_client *client,
> +				 struct iio_dev *indio_dev)

Would be more logical to move this function closer to probe.

> +{
> +	struct vl53l1x_data *data = iio_priv(indio_dev);
> +	int irq_flags = irq_get_trigger_type(client->irq);
> +	int ret;
> +
> +	if (!irq_flags)
> +		irq_flags = IRQF_TRIGGER_FALLING;
> +
> +	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +					vl53l1x_threaded_irq,
> +					irq_flags | IRQF_ONESHOT,
> +					indio_dev->name, indio_dev);
> +	if (ret) {
> +		dev_err(&client->dev, "devm_request_irq error: %d\n", ret);


Can use return dev_err_probe() here since this is only called in probe.


> +		return ret;
> +	}
> +
> +	ret = regmap_write(data->regmap, VL53L1X_SYSTEM__INTERRUPT_CONFIG_GPIO,
> +			   VL53L1X_INT_NEW_SAMPLE_READY);
> +	if (ret)
> +		dev_err(&client->dev, "failed to configure IRQ: %d\n", ret);

ditto

> +
> +	return ret;
> +}
> +
> +static int vl53l1x_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct vl53l1x_data *data = iio_priv(indio_dev);
> +
> +	return vl53l1x_start_ranging(data);
> +}
> +
> +static int vl53l1x_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct vl53l1x_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = vl53l1x_stop_ranging(data);
> +	if (ret)
> +		return ret;
> +
> +	reinit_completion(&data->completion);
> +	wait_for_completion_timeout(&data->completion, HZ / 10);
> +
> +	return vl53l1x_clear_irq(data);
> +}
> +
> +static const struct iio_buffer_setup_ops vl53l1x_buffer_setup_ops = {
> +	.postenable = &vl53l1x_buffer_postenable,
> +	.postdisable = &vl53l1x_buffer_postdisable,
> +};

These are not symetric. It either needs to be postenable/predisable
or preenable/postdisable.

