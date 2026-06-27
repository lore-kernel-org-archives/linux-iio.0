Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2012F1FFC
	for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782600184; cv=none; b=inbdEM1sgkSTCO27BsfNH3gu/wRuI420O+S0Rr50AWOAvVIzqcdqd0+sHk+GPsd76BVxzDwT+SoQJP4YGmc85L8nWuMRXKrLjugMDmIUIKTQ/xYTzjrNrjcOlejEWSpUmcz4fe5JgHvvp+qckjx/u2Q4CXnBjsCn73l0QUhe8F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782600184; c=relaxed/simple;
	bh=Nd7uT9eCfAFbckVTmvNzRRxLWSvAEC/u8vSKwbm4AA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOnoZfM8mcDDZAVupQVXNJykixHv4eMmgxUq+rBT7p4AL1wRU8Kdu0Aw0KtMf7XqsWEftWib6sfRTNqIavAOnYSutTcbXp/WuV0vHaGCC9e86Yxsg0dB7Cl3elYOmpT9j8taozbrkneFO1+sbC9mKz4TbE5LSv9dMGQb5ZBqaYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=kCGUbid2; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="kCGUbid2"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e6d991991dso1826033a34.3
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 15:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782600181; x=1783204981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BNkcfVqDQjtHxo1LcdUQOAnNBv7xJGgrN+6MfB/Vtbo=;
        b=kCGUbid2qsZ5gor/9iQ8zr66ifH9snJhDGxmyvz53dEtZ0W8T4ubgFuPTHglEUgN5o
         bJn7dwZoOWwypnKBJhysHcSEjAe5u9N/iQFXeQGezyRDVi+Uwiy9Gc8K3Ae45YLaa0FQ
         qoyyesB2yBfdK7J5F//P9lSUn0kUTf3wW0d7h5UpScyHTYxnzVobtXyRFuuep3N4Svw2
         mQ6KVUycqvwiiDOwnHGE2y2mqlrakJk3aISIUv8eu+ivOOKQShYpYymQBaRSLpN9i0S/
         nX0OvQsgcqr2t2ZIJiT0OZJp1Yps++whrHoe1eZ3LWsjDKcjfZ/JX9P1Sqv9yS16gBCW
         Y7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782600181; x=1783204981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNkcfVqDQjtHxo1LcdUQOAnNBv7xJGgrN+6MfB/Vtbo=;
        b=rGtFWIhmo52vEQf0I4rw0w+77QaD7U4zCAe3VEcduMCOU9yDqNwBe4VHidUrB6ePjb
         qhkpmEfF26lhTP2jzHZgT1ZsGjzmkbe2OZhDhd4a2LP3SiLoxnM6zxluAv6N8PQV49R/
         WYgiRS2RE6n+VocT1HkkQ9/uTu65a2CZrFOC2eiqRK3uQWISr/TL5flKN6M11t5O3mWN
         jP3pHsDAz8uiUMirWd2g4TNW3beX0JGXJt5VgcdAn6F4OdKCWyBmt1NZDohX5VEf1bTT
         QNnr4CvxR9tIc9fkb3k/9q87hZbpS3H5OibNX4INt3xTGYiompU+Q/FlE8+Bl2INQWVu
         n0+w==
X-Forwarded-Encrypted: i=1; AFNElJ+iYiwGBi9kEsV65QPmImJhNYN4NmZ+qF99LsdDD6e5qgzuhrXdTvSYV1IQLefsaTkUH1o1X6JUuUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmLUfGuswqZY3YyBxcMdLPeaAGW4/PBWU7WyzKTa7Ah4g6QIFG
	LCIeBAVxaIwvSMZUhnD9jH9xFOk4hgYWWQoUSrKQLL7zXK9cvawGZAirZKnEwnmwjlM=
X-Gm-Gg: AfdE7cnD5wtuP3OTOCecb1PUHJB7x8+1AQqWXdxe2X/FF6y8V8vy4a3i/2LxpkR58/N
	P9Ae/Y/2mJ3AqoF+MOeXDsB6AR1YdrbHKdTLokBhyzN1waNjwqECZ9oFQqbQAuI/e+4gOzcBkM5
	7WhqCiXcaDenQuRguXS/Hvz61nF8LsTQ7FKC86LU2K3O8SXuDTAC5uJy7tZLh4z2z94C9m7uKvC
	8N3SuuXrDaPzu5xdphHuRknyWOzTL8BCPX95Tbx/heThhgWO8lkPcJpY0JCCldVEeGH/43xDVVd
	Vp4z/Zgp/diaSltaOkLYHKx7GdRwxVD4eE5AxR5pw7S5+3SCEiuGRyBLB5iCI0CYjymHWMoOSPt
	+CZyS4UnZm0COx8byAGzBSEXUaMoYNb8TosS6/0glPteWMMsCEeH6Cf797jYptjU4SyfTv/hmWS
	JjtqYEnbDcFDqCxMobrim8UAWY1Z2VgWpIv2xX7hdmiALwDHOr/A/I9Io5dpQ+8sw=
X-Received: by 2002:a05:6830:2808:b0:7e3:d199:3164 with SMTP id 46e09a7af769-7e99c35cd36mr9333196a34.11.1782600180685;
        Sat, 27 Jun 2026 15:43:00 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:f242:ecd6:f61e:d764? ([2600:8803:e7e4:500:f242:ecd6:f61e:d764])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9c1e5a9e1sm2118987a34.5.2026.06.27.15.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2026 15:43:00 -0700 (PDT)
Message-ID: <1d038a77-6b4e-4f5c-82d5-fddfe92d1a6a@baylibre.com>
Date: Sat, 27 Jun 2026 17:42:59 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] iio: adc: Add ti-ads1110 support to ti-ads1100
 driver
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org
Cc: andy@kernel.org, antoniu.miclaus@analog.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, duje@dujemihanovic.xyz, jic23@kernel.org,
 jishnu.prakash@oss.qualcomm.com, jorge.marques@analog.com,
 joshua.crofts1@gmail.com, krzk+dt@kernel.org, linusw@kernel.org,
 linux-kernel@vger.kernel.org, marcelo.schmitt@analog.com,
 mazziesaccount@gmail.com, mike.looijmans@topic.nl, nuno.sa@analog.com,
 robh@kernel.org, sakari.ailus@linux.intel.com, wens@kernel.org
References: <20260622221550.374235-1-jakubszczudlo40@gmail.com>
 <20260622221550.374235-4-jakubszczudlo40@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260622221550.374235-4-jakubszczudlo40@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/26 5:15 PM, Jakub Szczudlo wrote:
> Add ADS1110 support that have faster datarate than ADS1100, it also uses
> internal voltage reference of 2.048V for measurement.
> 
> Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
> ---
>  drivers/iio/adc/Kconfig      |  6 +--
>  drivers/iio/adc/ti-ads1100.c | 81 +++++++++++++++++++++++++++---------
>  2 files changed, 64 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 1c663c98c6c9..30198335c63b 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1765,11 +1765,11 @@ config TI_ADS1018
>           called ti-ads1018.
>  
>  config TI_ADS1100
> -	tristate "Texas Instruments ADS1100 and ADS1000 ADC"
> +	tristate "Texas Instruments ADS1100 and similar single channel I2C ADC"
>  	depends on I2C
>  	help
> -	  If you say yes here you get support for Texas Instruments ADS1100 and
> -	  ADS1000 ADC chips.
> +	  If you say yes here you get support TI ADS1100 and similar single
> +	  channel I2C Analog to Digital Converters.
>  
>  	  This driver can also be built as a module. If so, the module will be
>  	  called ti-ads1100.
> diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
> index e3c801381434..ec79a89464fb 100644
> --- a/drivers/iio/adc/ti-ads1100.c
> +++ b/drivers/iio/adc/ti-ads1100.c
> @@ -5,7 +5,7 @@
>   * Copyright (c) 2023, Topic Embedded Products
>   *
>   * Datasheet: https://www.ti.com/lit/gpn/ads1100
> - * IIO driver for ADS1100 and ADS1000 ADC 16-bit I2C
> + * IIO driver for ADS1100 and similar single channel ADC 16-bit I2C
>   */
>  
>  #include <linux/bitfield.h>
> @@ -40,20 +40,44 @@
>  #define	ADS1100_SINGLESHOT	ADS1100_CFG_SC
>  
>  #define ADS1100_SLEEP_DELAY_MS	2000
> +#define ADS1110_INTERNAL_REF_mV 2048
>  
>  static const int ads1100_data_rate[] = { 128, 32, 16, 8 };
> +static const int ads1110_data_rate[] = { 240, 60, 30, 15 };
>  static const int ads1100_data_rate_bits[] = { 12, 14, 15, 16 };
>  
>  /* Timeout based on the minimum sample rate of 8 SPS (7.5s) */
>  #define ADS1100_MAX_DRDY_TIMEOUT_US	7500000
>  
> +struct ads1100_config {
> +	const char *name;
> +	const int *data_rate;

Usually, we would call an array like this available_data_rate_hz, otherwise
it sounds like a single value. And having units is always helpful.

> +	const int data_rate_count;
> +	bool has_internal_vref_only;
> +};
> +
> +static const struct ads1100_config ads1100_config = {
> +	.name = "ads1100",
> +	.data_rate = ads1100_data_rate,
> +	.data_rate_count = ARRAY_SIZE(ads1100_data_rate),
> +	.has_internal_vref_only = false,
> +};
> +
> +static const struct ads1100_config ads1110_config = {
> +	.name = "ads1110",
> +	.data_rate = ads1110_data_rate,
> +	.data_rate_count = ARRAY_SIZE(ads1110_data_rate),
> +	.has_internal_vref_only = true,
> +};
> +
>  struct ads1100_data {
>  	struct i2c_client *client;
>  	struct regulator *reg_vdd;
>  	struct mutex lock;
>  	int scale_avail[2 * 4]; /* 4 gain settings */
> +	const struct ads1100_config *ads_config;
>  	u8 config;
> -	bool supports_data_rate; /* Only the ADS1100 can select the rate */
> +	bool supports_data_rate;
>  };
>  
>  static const struct iio_chan_spec ads1100_channel = {
> @@ -89,6 +113,14 @@ static int ads1100_set_config_bits(struct ads1100_data *data, u8 mask, u8 value)
>  	return 0;
>  };
>  
> +static int ads1100_get_vref_milivolts(struct ads1100_data *data)
> +{
> +	if (data->ads_config->has_internal_vref_only)
> +		return ADS1110_INTERNAL_REF_mV;
> +
> +	return regulator_get_voltage(data->reg_vdd) / MILLI;

Technically, regulator_get_voltage() can return a negative error
which would be corrupted by dividing it.

> +}
> +

Usually, we just do this during probe and store vref_mV in the
private data struct as the regulator voltage doesn't typically
change at runtime. Could clean that up as a preliminary patch to
make this patch simpler.

>  static int ads1100_data_bits(struct ads1100_data *data)
>  {
>  	return ads1100_data_rate_bits[FIELD_GET(ADS1100_DR_MASK, data->config)];
> @@ -114,6 +146,9 @@ static int ads1100_get_adc_result(struct ads1100_data *data, int chan, int *val)
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
>  		return ret;
> +	} else if (ret < 2) {
> +		dev_err(&data->client->dev, "Short I2C read\n");
> +		return -EIO;

As mentioned already, I think this is dead code. Not related to this
patch anyway.

>  	}
>  
>  	/* Value is always 16-bit 2's complement */
> @@ -184,7 +219,7 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
>  	if (ret)
>  		return ret;
>  
> -	microvolts = regulator_get_voltage(data->reg_vdd);
> +	microvolts = ads1100_get_vref_milivolts(data) * (MICRO / MILLI);
>  	/*
>  	 * val2 is in 'micro' units, n = val2 / 1000000
>  	 * result must be millivolts, d = microvolts / 1000
> @@ -209,9 +244,9 @@ static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
>  	unsigned int size;
>  	int ret;
>  
> -	size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;
> +	size = data->supports_data_rate ? data->ads_config->data_rate_count : 1;
>  	for (i = 0; i < size; i++) {
> -		if (ads1100_data_rate[i] != rate)
> +		if (data->ads_config->data_rate[i] != rate)
>  			continue;
>  
>  		PM_RUNTIME_ACQUIRE_AUTOSUSPEND(&data->client->dev, pm);
> @@ -233,14 +268,9 @@ static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
>  	return -EINVAL;
>  }
>  
> -static int ads1100_get_vdd_millivolts(struct ads1100_data *data)
> -{
> -	return regulator_get_voltage(data->reg_vdd) / (MICRO / MILLI);
> -}
> -
>  static void ads1100_calc_scale_avail(struct ads1100_data *data)
>  {
> -	int millivolts = ads1100_get_vdd_millivolts(data);
> +	int millivolts = ads1100_get_vref_milivolts(data);
>  	unsigned int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(data->scale_avail) / 2; i++) {
> @@ -262,9 +292,9 @@ static int ads1100_read_avail(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		*type = IIO_VAL_INT;
> -		*vals = ads1100_data_rate;
> +		*vals = data->ads_config->data_rate;
>  		if (data->supports_data_rate)
> -			*length = ARRAY_SIZE(ads1100_data_rate);
> +			*length = data->ads_config->data_rate_count;
>  		else
>  			*length = 1;
>  		return IIO_AVAIL_LIST;
> @@ -283,6 +313,7 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
>  			    int *val2, long mask)
>  {
>  	int ret;
> +	int data_rate_index;
>  	struct ads1100_data *data = iio_priv(indio_dev);
>  
>  	guard(mutex)(&data->lock);
> @@ -299,12 +330,12 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		/* full-scale is the supply voltage in millivolts */
> -		*val = ads1100_get_vdd_millivolts(data);
> +		*val = ads1100_get_vref_milivolts(data);
>  		*val2 = 15 + FIELD_GET(ADS1100_PGA_MASK, data->config);
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		*val = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK,
> -						   data->config)];
> +		data_rate_index = FIELD_GET(ADS1100_DR_MASK, data->config);
> +		*val = data->ads_config->data_rate[data_rate_index];
>  		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
> @@ -373,6 +404,7 @@ static int ads1100_probe(struct i2c_client *client)
>  	struct iio_dev *indio_dev;
>  	struct ads1100_data *data;
>  	struct device *dev = &client->dev;
> +	const struct ads1100_config *model;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> @@ -404,6 +436,13 @@ static int ads1100_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> +	model = i2c_get_match_data(client);
> +	if (!model)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Can't get device data from firmware\n");
> +
> +	data->ads_config = (struct ads1100_config *)model;

Just assign data->ads_config directly from i2c_get_match_data(). We don't
need local variable (or cast).

> +
>  	ret = ads1100_setup(data);
>  	if (ret)
>  		return dev_err_probe(dev, ret,
> @@ -466,16 +505,18 @@ static DEFINE_RUNTIME_DEV_PM_OPS(ads1100_pm_ops,
>  				 NULL);
>  
>  static const struct i2c_device_id ads1100_id[] = {
> -	{ .name = "ads1100" },
> -	{ .name = "ads1000" },
> +	{ .name = "ads1000", .driver_data = (kernel_ulong_t)&ads1100_config },
> +	{ .name = "ads1100", .driver_data = (kernel_ulong_t)&ads1100_config },
> +	{ .name = "ads1110", .driver_data = (kernel_ulong_t)&ads1110_config },
>  	{ }
>  };
>  
>  MODULE_DEVICE_TABLE(i2c, ads1100_id);
>  
>  static const struct of_device_id ads1100_of_match[] = {
> -	{.compatible = "ti,ads1100" },
> -	{.compatible = "ti,ads1000" },
> +	{ .compatible = "ti,ads1000", .data = &ads1100_config },
> +	{ .compatible = "ti,ads1100", .data = &ads1100_config },
> +	{ .compatible = "ti,ads1110", .data = &ads1110_config },
>  	{ }
>  };
>  

