Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C006197A7D
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778945333; cv=none; b=f7pgoF44NIsoa4OlPmyMLYrNLXXQUq1i9DfRZIqjFAwtNIvgHdmoiNNlvYaNDIY8exKMLe528AUCyKJNoZ9o0cSgcPI8gk2rJp/H5FNLgX4Pb8VKUpt74qLi1cNi1CYv+L08ijl4EVVtcmfrCn2ulPP0q4qlS10iKzUGIG1BPVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778945333; c=relaxed/simple;
	bh=Z4awxBYNctWlHaOc9izj+wLo5UkRR9LmtdaNeBqKpBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JGQfoYq3WFa8z929fjXKqgPGuuPQ+eaXNtizknr0wJYm1ncVmos9s/0GGdrjQ64DRLpN/wDFSGhRaD2tzaU1JrGOkBws9CXtCxrvrHWN9f+jXZFzQKjaP0w4/ZLt7jATiRi5pG6vFeG0QJ1sTXoUc9Noh+OzDtr1Lc8bDhdmJEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=aVY411f2; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="aVY411f2"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7de44ed7a11so1014866a34.1
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 08:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778945329; x=1779550129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z2b/XNBV0AV6S2OMxWpq08BnvRXx1NBAzVatQVQQnjk=;
        b=aVY411f2fYV49b4rB1O2vuTWt3v1DmXCqZCLxW6CcI808u0h1tKLdnVrQYLfqbikOI
         t6eleNVSgTOzLIwxrzCwv14DAKF+HL+nHBl6fr0KghzopsE1op/zfq3tT5WPvOJKgOz+
         +gb9HdyOScefkDnpbOd2DSmSQkeeEPxMXOWXjVV0lEw+Be1PKxwa6oOWjz1nmjb1UeNS
         ellm3is9OnLSDfOlYoc76MVj+KdNG487TQYDdQ75oXFV5iz5eeFuxz2UBtBas+yitFux
         yuenbL3B4APnp7MD67FffT8ypHlXc9RL7p6PM1AE9uDZ3jNU+z3aSXBNG9WwGH6hrM94
         RLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778945329; x=1779550129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2b/XNBV0AV6S2OMxWpq08BnvRXx1NBAzVatQVQQnjk=;
        b=smohV0M1lYokGm/HD/smZeBZdo6sXzEhys3eeoxx605gZOn6rp/wU3RzHWcagRRf9N
         mEya23hRmg7HYP3HPCljmyjbKRBG+7fxrsLgPoz0+/hJ0uoqiNJHbdzDlmiK7hAJ6UVp
         VMfByW/1jvh3K/8nhcEMULBIjQ8KGkGsNouMm1ICZk4FKL8uNfIdzRNzvFQznPT+BOiy
         0Dnq8TUyPUHDs2BemXV3lItSp8/tMNOWkecR4KkXZJSgIGnwwRLZIY4CUyIJo4mq4ZuW
         VzW4+04Bzu1WxYGQhTbzoEnCUm/gsCnullJdhale88HZdQbdzd+uExXMTAyVQHE9cWLc
         c36g==
X-Forwarded-Encrypted: i=1; AFNElJ/9iLew4hPZk0rs4Svu8SFMD86cNkcCd6saWH0FngDn4xuUa1qLjBBkfAJ0q1TG468uB/WobWTjZjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxEidKXFnEDVBRUh+b2L+ua5H/UvDhniEIBRijj8X2crMxu+2J
	KGfy0knpqPYhyYYmezBbfZDFl6wphFnWwJhTPK1CTbQLalBb5YdYlxh2ufx1szng3IoWsMhZoCQ
	QiuL+W/Q=
X-Gm-Gg: Acq92OGMEaGird+wXJpTeFj/dpVBnTYsLmif6IcbJZsM5FhGkJ863YfLFbxVp1ySu4F
	GlU+gzYl68w9qS8jOwZHOCXBIGus2lb9ACQ6TfxsOc+2+hMmrYFDibDi0j+FDPsu4pDcK0N8VgP
	D7d9XCONjI+43iEmI/ZrgvwxGH5qTmWZ92ia6qW0EHaCfIif+MkGCtMCBszHix/M8XvlcPHqO6v
	QJc6gAA/0nmQw5sBpXq7EwoGRcFnE65J/e5ol+fV6cFXiifwZuZEbF4vLGA8Jh8/Fsr376oOn0q
	HjRwiVd18ORxlK6LLicNAFARnzaJ6rGxnL0IbQfV+ijSXlAiqhwSXJaqnl6hVrypkcNaayzunlD
	2Ceae0zTTujVhaCoa5ywNsPE5nA3wzPUwg3mNpPgnAa8oP7IizXGq10Gt1E3KJvpbasfKHkSOZQ
	03S/pREiUMpQh7CA1MgYiBPPs/O2+UF78Mz0/j/d9fMJMTFuNVnacAR7M/hhwZUO+4fUSA5jxoU
	w==
X-Received: by 2002:a05:6830:d8a:b0:7df:616:77fc with SMTP id 46e09a7af769-7e4ea17d201mr5768179a34.6.1778945329265;
        Sat, 16 May 2026 08:28:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b36d:bd18:7c02:29e2? ([2600:8803:e7e4:500:b36d:bd18:7c02:29e2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bc4b0adsm3896885a34.25.2026.05.16.08.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 08:28:48 -0700 (PDT)
Message-ID: <d98bcb3d-21ae-4b62-af63-48fad4301f70@baylibre.com>
Date: Sat, 16 May 2026 10:28:47 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/2] iio: light: add support for APDS9999 sensor
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>
References: <cover.1778659152.git.azpijr@gmail.com>
 <f389419972fc790a25b6041f1212e15f155804e2.1778659152.git.azpijr@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <f389419972fc790a25b6041f1212e15f155804e2.1778659152.git.azpijr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/26 3:10 AM, Jose A. Perez de Azpillaga wrote:
> Add IIO driver for Broadcom APDS9999 ambient light sensor.
> 
> The APDS9999 is a digital proximity and RGB sensor with ALS
> capability. This driver implements the ALS/Lux functionality using
> the green channel, which uses optical coating technology to
> approximate the human eye spectral response.
> 
> Proximity (PS) and RGB color features are not yet implemented.
> 



> +enum apds9999_gain {
> +	APDS9999_GAIN_1X = 0,
> +	APDS9999_GAIN_3X = 1,
> +	APDS9999_GAIN_6X = 2,
> +	APDS9999_GAIN_9X = 3,
> +	APDS9999_GAIN_18X = 4,
> +};

Giving the natural values of enum explicitly just seems like noise
IMHO. I wasted time looking for an anomaly.

> +
> +static const int apds9999_gains[] = {
> +	[APDS9999_GAIN_1X]  = 1,
> +	[APDS9999_GAIN_3X]  = 3,
> +	[APDS9999_GAIN_6X]  = 6,
> +	[APDS9999_GAIN_9X]  = 9,
> +	[APDS9999_GAIN_18X] = 18,
> +};
> +
> +enum apds9999_resolution {
> +	APDS9999_RES_20BIT = 0,	/* 400 ms */
> +	APDS9999_RES_19BIT = 1,	/* 200 ms */
> +	APDS9999_RES_18BIT = 2,	/* 100 ms (default) */
> +	APDS9999_RES_17BIT = 3,	/*  50 ms */
> +	APDS9999_RES_16BIT = 4,	/*  25 ms */
> +	APDS9999_RES_13BIT = 5,	/*  3.125 ms */
> +	APDS9999_RES_NUM
> +};

Comments seems redundant since we have the table below.

> +
> +static const int apds9999_itimes_us[APDS9999_RES_NUM] = {
> +	[APDS9999_RES_20BIT] = 400000,

Can be written as 400 * USEC_PER_MSEC to make it easier to understand.

> +	[APDS9999_RES_19BIT] = 200000,
> +	[APDS9999_RES_18BIT] = 100000,
> +	[APDS9999_RES_17BIT] =  50000,
> +	[APDS9999_RES_16BIT] =  25000,
> +	[APDS9999_RES_13BIT] =   3125,
> +};
> +
> +enum apds9999_rate {
> +	APDS9999_RATE_25_MS = 0,
> +	APDS9999_RATE_50_MS = 1,
> +	APDS9999_RATE_100_MS = 2,
> +	APDS9999_RATE_200_MS = 3,
> +	APDS9999_RATE_500_MS = 4,
> +	APDS9999_RATE_1000_MS = 5,
> +	APDS9999_RATE_2000_MS = 6,

again, values are distracting.

> +};
> +
> +struct apds9999_data {
> +	struct i2c_client *client;
> +	/* lock: protects als_gain_idx, als_res, als_rate */
> +	struct mutex lock;
> +	int als_gain_idx;
> +	int als_res;
> +	int als_rate;
> +};
> +
> +static void apds9999_standby(void *client)
> +{
> +	i2c_smbus_write_byte_data(client, APDS9999_REG_MAIN_CTRL, 0);
> +}
> +
> +static int apds9999_init(struct apds9999_data *data)
> +{
> +	struct device *dev = &data->client->dev;
> +	struct i2c_client *client = data->client;
> +	u8 reg;
> +	int ret;
> +
> +	ret = devm_add_action_or_reset(dev, apds9999_standby, client);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	reg = FIELD_PREP(APDS9999_LS_RES_MASK, APDS9999_RES_18BIT) |
> +	      FIELD_PREP(APDS9999_LS_RATE_MASK, APDS9999_RATE_100_MS);
> +	ret = i2c_smbus_write_byte_data(client, APDS9999_REG_LS_MEAS_RATE, reg);
> +	if (ret)
> +		return ret;


> +	data->als_res = APDS9999_RES_18BIT;
> +	data->als_rate = APDS9999_RATE_100_MS;

Can we get a comment explaining why these are the default?

> +
> +	ret = i2c_smbus_write_byte_data(client, APDS9999_REG_LS_GAIN,
> +					APDS9999_GAIN_3X);
> +	if (ret)
> +		return ret;
> +	data->als_gain_idx = APDS9999_GAIN_3X;
> +
> +	ret = i2c_smbus_write_byte_data(client, APDS9999_REG_MAIN_CTRL,
> +					APDS9999_MAIN_CTRL_LS_EN);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int apds9999_read_channel(struct apds9999_data *data, u8 reg, u32 *counts)
> +{
> +	struct i2c_client *client = data->client;
> +	u8 buf[3];
> +	int ret, tries;
> +
> +	guard(mutex)(&data->lock);
> +
> +	/*
> +	 * Poll MAIN_STATUS for new data.  Timeout: ~2 integration periods
> +	 * plus margin.  Each try sleeps 20 ms.
> +	 */
> +	tries = max(2, (apds9999_itimes_us[data->als_res] * 2) / 20000);
> +
> +	while (tries--) {
> +		ret = i2c_smbus_read_byte_data(client,
> +						APDS9999_REG_MAIN_STATUS);
> +		if (ret < 0)
> +			return ret;
> +		if (ret & APDS9999_MAIN_STATUS_LS_DATA)
> +			break;
> +		fsleep(20000);
> +	}
> +
> +	if (tries < 0)
> +		return -ETIMEDOUT;
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, reg, sizeof(buf), buf);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(buf))
> +		return -EIO;
> +
> +	*counts = get_unaligned_le24(buf) & GENMASK(19, 0);
> +	return 0;
> +}
> +
> +static int apds9999_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct apds9999_data *data = iio_priv(indio_dev);
> +	int gain, itime_us;
> +	u64 scale_nano;
> +	u32 counts;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			ret = apds9999_read_channel(data,
> +						    APDS9999_REG_LS_DATA_GREEN_0,
> +						    &counts);
> +			break;
> +		case IIO_INTENSITY:
> +			ret = apds9999_read_channel(data, chan->address,
> +						    &counts);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		if (ret)
> +			return ret;
> +		*val = (int)counts;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		/*
> +		 * Scale (lux per count) = 54 / (gain * integration_time_ms)
> +		 *
> +		 * The constant 54 is derived from the datasheet table:
> +		 *   at gain = 3x, itime = 100 ms -> 0.180 lux/count
> +		 *   -> C = 0.180 * 3 * 100 = 54
> +		 *
> +		 * Expressed as IIO_VAL_INT_PLUS_NANO.
> +		 */
> +		gain = apds9999_gains[data->als_gain_idx];
> +		itime_us = apds9999_itimes_us[data->als_res];
> +
> +		/* scale_nano = 54e12 / (gain * itime_us) nano-lux/count */
> +		scale_nano = div_u64(54000000000000ULL, (u32)(gain * itime_us));
> +		*val = (int)(scale_nano / NSEC_PER_SEC);
> +		*val2 = (int)(scale_nano % NSEC_PER_SEC);
> +		return IIO_VAL_INT_PLUS_NANO;
> +
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*val = 0;
> +		*val2 = apds9999_itimes_us[data->als_res];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_chan_spec apds9999_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),

It looks like if we put a .address here, we could simplify the raw read.
(Could also use a comment explaining what was discussed about the green
channel in the cover letter.)

> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_RED,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),

No scale on these?

> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.address = APDS9999_REG_LS_DATA_RED_0,
> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_GREEN,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.address = APDS9999_REG_LS_DATA_GREEN_0,
> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_BLUE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.address = APDS9999_REG_LS_DATA_BLUE_0,
> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_CLEAR,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.address = APDS9999_REG_LS_DATA_IR_0,
> +	},
> +};
> +
> +static const struct iio_info apds9999_info = {
> +	.read_raw = apds9999_read_raw,
> +};

Would be more logical to move this struct right after the function it
references.

> +
> +static int apds9999_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct apds9999_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret, part_id;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +
> +	ret = devm_mutex_init(dev, &data->lock);
> +	if (ret)
> +		return ret;
> +
> +	part_id = i2c_smbus_read_byte_data(client, APDS9999_REG_PART_ID);
> +	if (part_id < 0)
> +		return dev_err_probe(dev, part_id,
> +				     "failed to read PART_ID\n");
> +	if (part_id != APDS9999_PART_ID)
> +		dev_info(dev, "unexpected PART_ID 0x%02x (expected 0x%02x)\n",
> +			 part_id, APDS9999_PART_ID);
> +
> +	ret = apds9999_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to initialize device\n");
> +
> +	indio_dev->name = "apds9999";
> +	indio_dev->info = &apds9999_info;
> +	indio_dev->channels = apds9999_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(apds9999_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to register IIO device\n");
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id apds9999_id[] = {
> +	{ "apds9999" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, apds9999_id);
> +
> +static const struct of_device_id apds9999_of_match[] = {
> +	{ .compatible = "brcm,apds9999" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, apds9999_of_match);
> +
> +static struct i2c_driver apds9999_driver = {
> +	.driver = {
> +		.name = "apds9999",
> +		.of_match_table = apds9999_of_match,
> +	},
> +	.probe = apds9999_probe,
> +	.id_table = apds9999_id,
> +};
> +module_i2c_driver(apds9999_driver);
> +
> +MODULE_AUTHOR("Jose A. Perez de Azpillaga <azpijr@gmail.com>");
> +MODULE_DESCRIPTION("APDS-9999 Lux Light Sensor IIO Driver");
> +MODULE_LICENSE("GPL");

