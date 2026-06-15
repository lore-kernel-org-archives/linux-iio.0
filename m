Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AECB3B6378
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 22:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781562562; cv=none; b=AYFWI/BP3W9ek/HDanI3L/AfdAfsV4XjIlR3pfz5OG6EYt+EihXGdVkiP11CQobKn79Am9EdgvjOhSikcGfo9dAUBYpR3d3x092k6jkcIpsTyNJpaBY1WX8c7cpcGqhHce53lxn64JbJRyXrbCSV2GtLPBipc9ttvP6bGK5AiVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781562562; c=relaxed/simple;
	bh=SDIcYr0/7zjy66LwZj54h4fD7eOpoSZGfTvkDLmuiio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWr8vB7SzAUnBMRi87Nue/2kCFTEPkvZihiFmVJqKHjLPsMwfVeHAXVn3COkYwRGuKaegluIuWwFNKq4mvAVAAwGZbkwbeH1oCePiAenGtLLZ4I15TJFkOvQKFrCUNjLrzK6cg3chFpkN5bukdCUkBT7+BNaQFlcn4Iol9w8qLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ZVHlnrlF; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ZVHlnrlF"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-441b5b4af7aso1964138fac.3
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 15:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781562558; x=1782167358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MesfrNOd0xibom5kaxHtFnx8Ss4DUhvxevOz19gTSL0=;
        b=ZVHlnrlF4arT1jrWSY0l371R+P8RLD2Ay2DVtmkrD9pkfP33V7B4fo2Il3q/+Tvopo
         3dCrQZW4IJAzPzhrF+In8mYNO64PEa7faE5vBTuogZPf0CHmq/+AVmiXBjqtkHrsFuQq
         2GQsVVKoNI7utaMM4SI9z1ZywSe7YXzOGvqfoMjsFfv01kbnyDg1R2sfZH3hphKUMx37
         mBvD/KcJ+RYyIg5Rz5uVbesdHPOSPm46dO3/4gfyuNYDgZaVoXmtarW7rCduPJCNke3G
         IDkYm/BE5MlNZ4IhmTmSE8V99GsZPTc5AuPuX8yXEXD7fZtMqglooFCybnOPgTqdop2B
         HN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781562558; x=1782167358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MesfrNOd0xibom5kaxHtFnx8Ss4DUhvxevOz19gTSL0=;
        b=VNQktLwgRnIcA0zs/QOyXfiTRH1vXtA6QT04em8OhI/5gHavZi4g1kru9GGniaG9J2
         ucLCPlpwixXNEFjakt0cQuq0dG3/i12jkOsD6de7lC7SoAxQ3yik4ACiRCO6pQfaKaRS
         hHT/beS1SXGvToykQSijbG4+fVFtHcMiGFRBOhjqFKqoqfpu8k7JedE5u4rjcuFjpc0m
         RX3voLFpjsfC80HJ1DqQiL8ZS0P26v8iqWGNug8xxysJ3WnYvL/kjYEmdhhEN6+YQj5+
         bdEFR0ZGR4oUZ9in6nAySkHzoac+prkc25aGj8/k1XnEOdZ1fu9vciULvm1E/yTSZJyj
         SsCA==
X-Forwarded-Encrypted: i=1; AFNElJ9RgfANW6XM2NlVLKemFtP2imwoUUnJCPfTQHjNf//ZyK7x2qQAspYHaYgL9R4to7h4sEqgsAFIrAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFpHfLsCJF2hwPB7Gyj3ejJABTFczHWXrn08bYAp4qsH11K5br
	oksrdggvImpfmtBZW8mV7xNb6yF5XR2hapro5w25PYjb66qxvC5OQCYoFSVzON8hDdw=
X-Gm-Gg: Acq92OFGpeSCVjeipMwakUR/kJX2gDIFmPnyeeaQxiS3L273QPkVMGCVFVs9w5D60AM
	5KtKCzMlP0gu5sTXYVIPaa6i6HQmPCc+u0X4av+ScTJc8rC6pkAHj5OCMrW8R4U6+j2VeiY9hcY
	VarphIMHzzSewlyhCT6UQQ+AxPeiCgvJFtQSDimd78/15OYhw8M+qlWoPPnz5SbNgxjTcuUKC0h
	QUrWbVrfCpMpUNY0LJJ9HThmlpR+vooH0YTdyUQa92ALNDbpw4U+zLu6XrkXQtcxR648g+XIuCw
	Rxk3SE8jXDrSxRbsBByzwsjyEMLgcDjxZKcIXUJRb3EKqYqqBqJJdQ/sxHm6nTv1TZ/4zuJrU9y
	eIq7obrZubwwXo0HKdUx36wpJNOQDYy08Mi47gNJtXdoHdA7SOjKHSobIM54x2H7ZoLD/lcSB19
	EhBjfgAee5Y8PnAjiz/UD2/76CcVjiaunA6MLHQzcyyuEx07h0yquUAhQzZFv3lUkM2oy2cGqkk
	A==
X-Received: by 2002:a05:6808:c1e3:b0:486:498d:f500 with SMTP id 5614622812f47-4872f380b4dmr11188519b6e.18.1781562558216;
        Mon, 15 Jun 2026 15:29:18 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:16b0:5133:47b1:a939? ([2600:8803:e7e4:500:16b0:5133:47b1:a939])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f6dfde9sm5216119a34.24.2026.06.15.15.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 15:29:17 -0700 (PDT)
Message-ID: <43e4c4f4-0b13-4331-80ce-7353408c78f5@baylibre.com>
Date: Mon, 15 Jun 2026 17:29:17 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] iio: adc: Add ti-ads1110 support to ti-ads1100
 driver
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org
Cc: andy@kernel.org, antoniu.miclaus@analog.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, duje@dujemihanovic.xyz, jic23@kernel.org,
 jishnu.prakash@oss.qualcomm.com, jorge.marques@analog.com,
 krzk+dt@kernel.org, linusw@kernel.org, linux-kernel@vger.kernel.org,
 marcelo.schmitt@analog.com, mazziesaccount@gmail.com,
 mike.looijmans@topic.nl, nuno.sa@analog.com, robh@kernel.org,
 sakari.ailus@linux.intel.com, wens@kernel.org, joshua.crofts1@gmail.com
References: <20260613190957.654798-1-jakubszczudlo40@gmail.com>
 <20260613190957.654798-3-jakubszczudlo40@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260613190957.654798-3-jakubszczudlo40@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/26 2:09 PM, Jakub Szczudlo wrote:
> Add ADS1110 support that have faster datarate than ADS1100, it also uses
> internal voltage reference of 2.048V for measurement.
> 
> Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
> ---
>  drivers/iio/adc/Kconfig      |  6 +--
>  drivers/iio/adc/ti-ads1100.c | 83 +++++++++++++++++++++++++++---------
>  2 files changed, 65 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index a9dedbb8eb46..54a0149a3838 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1747,11 +1747,11 @@ config TI_ADS1018
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
> +	  channel I2C Analog to Digital Converters
>  
>  	  This driver can also be built as a module. If so, the module will be
>  	  called ti-ads1100.
> diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
> index aa8946063c7d..76de2466dc53 100644
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
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/i2c.h>
> +#include <linux/iopoll.h>
>  #include <linux/mutex.h>
>  #include <linux/property.h>
>  #include <linux/pm_runtime.h>
> @@ -39,17 +40,41 @@
>  #define	ADS1100_SINGLESHOT	ADS1100_CFG_SC
>  
>  #define ADS1100_SLEEP_DELAY_MS	2000
> +#define ADS1110_REFERENCE_VOLTAGE_MILIVOLTS 2048

maybe a better name?

ADS1110_INTERNAL_REF_mV

> +
> +/* Timeout based on the minimum sample rate of 8 SPS (7500000us) */

I would make the value in the comment an easier to read number, e.g.
7.5 s


> +#define ADS1100_MAX_DRDY_TIMEOUT	7500000

Always nice to include the units in the identifier name.

ADS1100_MAX_DRDY_TIMEOUT_us

>  
>  static const int ads1100_data_rate[] = { 128, 32, 16, 8 };
> +static const int ads1110_data_rate[] = { 240, 60, 30, 15 };
>  static const int ads1100_data_rate_bits[] = { 12, 14, 15, 16 };
>  
> +struct ads1100_config {
> +	const char *name;
> +	const int *data_rate;
> +	bool has_reference_voltage;

It would be helpful if this name was more specific. I think this means
has_internal_vref_only?

> +};
> +
> +static const struct ads1100_config ads1100_config = {
> +	.name = "ads1100",
> +	.data_rate = ads1100_data_rate,
> +	.has_reference_voltage = false,
> +};
> +
> +static const struct ads1100_config ads1110_config = {
> +	.name = "ads1110",
> +	.data_rate = ads1110_data_rate,
> +	.has_reference_voltage = true,
> +};
> +
>  struct ads1100_data {
>  	struct i2c_client *client;
>  	struct regulator *reg_vdd;
>  	struct mutex lock;
>  	int scale_avail[2 * 4]; /* 4 gain settings */
> +	struct ads1100_config *ads_config;
>  	u8 config;
> -	bool supports_data_rate; /* Only the ADS1100 can select the rate */
> +	bool supports_data_rate; /* Only the ADS1100/ADS1110 can select the rate */

I would just drop this comment since it is runtime detected.
Otherwise, it makes it sound like this belongs in struct ads1100_config.

>  };
>  
>  static const struct iio_chan_spec ads1100_channel = {
> @@ -85,6 +110,19 @@ static int ads1100_set_config_bits(struct ads1100_data *data, u8 mask, u8 value)
>  	return 0;
>  };
>  
> +static int ads1100_get_voltage_milivolts(struct ads1100_data *data)

I could call this ads1100_get_vref_milivolts() or
ads1100_get_reference_milivolts().

> +{
> +	if (data->ads_config->has_reference_voltage)
> +		return ADS1110_REFERENCE_VOLTAGE_MILIVOLTS;
> +	else

else is not necessary here

> +		return regulator_get_voltage(data->reg_vdd) / MILLI;

Why not keeping (MICRO / MILLI)?

> +}
> +
> +static int ads1100_get_voltage_microvolts(struct ads1100_data *data)
> +{
> +	return ads1100_get_voltage_milivolts(data) * MICRO / MILLI;

	return ads1100_get_voltage_milivolts(data) * (MICRO / MILLI);

> +}

Although this is only used once, so don't really need the helper function.

> +
>  static int ads1100_data_bits(struct ads1100_data *data)
>  {
>  	return ads1100_data_rate_bits[FIELD_GET(ADS1100_DR_MASK, data->config)];
> @@ -107,9 +145,9 @@ static int ads1100_get_adc_result(struct ads1100_data *data, int chan, int *val)
>  
>  	pm_runtime_put_autosuspend(&data->client->dev);
>  
> -	if (ret < 0) {
> +	if (ret < 2) {
>  		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
> -		return ret;
> +		return -EIO;

I think someone else mentioned this already, but ret < 0 should be propagated
rather than replaced with -EIO.

>  	}
>  
>  	/* Value is always 16-bit 2's complement */
> @@ -135,7 +173,7 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
>  	if (!val2)
>  		return -EINVAL;
>  
> -	microvolts = regulator_get_voltage(data->reg_vdd);
> +	microvolts = ads1100_get_voltage_microvolts(data);
>  	/*
>  	 * val2 is in 'micro' units, n = val2 / 1000000
>  	 * result must be millivolts, d = microvolts / 1000
> @@ -159,22 +197,17 @@ static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
>  
>  	size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;

This is a bit fragile now assuming that all configs have a list the same size
as ads1100_data_rate. It's a bit more verbose, but should probably also include
a size field in the config.

>  	for (i = 0; i < size; i++) {
> -		if (ads1100_data_rate[i] == rate)
> +		if (data->ads_config->data_rate[i] == rate)
>  			return ads1100_set_config_bits(data, ADS1100_DR_MASK,
> -						       FIELD_PREP(ADS1100_DR_MASK, i));
> +					FIELD_PREP(ADS1100_DR_MASK, i));
>  	}
>  
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
> +	int millivolts = ads1100_get_voltage_milivolts(data);
>  	unsigned int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(data->scale_avail) / 2; i++) {
> @@ -196,7 +229,7 @@ static int ads1100_read_avail(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		*type = IIO_VAL_INT;
> -		*vals = ads1100_data_rate;
> +		*vals = data->ads_config->data_rate;
>  		if (data->supports_data_rate)
>  			*length = ARRAY_SIZE(ads1100_data_rate);

Same here about the array size.

>  		else
> @@ -233,12 +266,11 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		/* full-scale is the supply voltage in millivolts */
> -		*val = ads1100_get_vdd_millivolts(data);
> +		*val = ads1100_get_voltage_milivolts(data);
>  		*val2 = 15 + FIELD_GET(ADS1100_PGA_MASK, data->config);
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		*val = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK,
> -						   data->config)];
> +		*val = data->ads_config->data_rate[FIELD_GET(ADS1100_DR_MASK, data->config)];

This line seems a bit long now.

>  		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
> @@ -307,6 +339,7 @@ static int ads1100_probe(struct i2c_client *client)
>  	struct iio_dev *indio_dev;
>  	struct ads1100_data *data;
>  	struct device *dev = &client->dev;
> +	const struct ads1100_config *model;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> @@ -338,6 +371,12 @@ static int ads1100_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> +	model = device_get_match_data(dev);

Should be i2c_get_match_data().

> +	if (!model)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Can't get device data from firmware\n");
> +
> +	data->ads_config = (struct ads1100_config *)model;
>  	ret = ads1100_setup(data);
>  	if (ret)
>  		return dev_err_probe(dev, ret,
> @@ -400,16 +439,18 @@ static DEFINE_RUNTIME_DEV_PM_OPS(ads1100_pm_ops,
>  				 NULL);
>  
>  static const struct i2c_device_id ads1100_id[] = {
> -	{ "ads1100" },
> -	{ "ads1000" },
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

