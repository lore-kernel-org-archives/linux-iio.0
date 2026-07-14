Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8291427FBE
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784060290; cv=none; b=EKP1r9vnzTEHcvZwKqcwur7fHNQEsBJTNY7zglNYFDEyKkH43yg7okFtj8lqqu88esAfYW4gYUztxOtwfdjSKpMb9VORwJpC1zbxMWEy/MJQT7/GZg8AshPbhYj1eXKVD4cUVTUdaV6S+g3wlgbLCnSjMM1CKAVNrN2rnZzIzSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784060290; c=relaxed/simple;
	bh=1uh522gOfYXCGmclQQsWndP0c1MCoCEBe3RmLmZljjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S1cx2ybOe+GHYUTUNl+oW4jzYJcMlXh+mm9tgE/7iA8tehUBhMT6j4upMKCRLBwzvzzX+U/QRuzvhCE/lFYZ9eXMTL9lzh1jnraOLImIbQTj+ou9CFBb91HJN0g5DB/N+SluYTGwTH0gQ77UqG3Uvm01FRWjnS0wSvz7wGK5JiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=OEdXH3UH; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="OEdXH3UH"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7ec3b429a3aso1164249a34.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 13:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784060287; x=1784665087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l/HGW119FoJYPxgSwEibIWfzbjDGKl6W4plwAUPyGL4=;
        b=OEdXH3UHjqlordVXlXTiPqMHTtk7V6SxvEmo2kAWKwdbU3gHpmtxRWXFShMVPws1PK
         PO3cGII8v45wWYR4eiG+Hwt8uMn226jyw8KglYNNErW45aAp0y/awg7omB/4TZ4+Z5OD
         srm/VP0GaGKW1nAotK5xh36ByZHcj8bWBek+y3u2YIVG+93lqpA1syvM3+1gTDdtDvdW
         rek9KUcQ9ZBvE8zqeu9e4cYKpCsO2jyxt9VL6WQl/rdMyD5S8w62RTVf/663ZKPPB0Bp
         E31ByLtMIhLZl8IRgAarW8IbQ/ZSL27ftKSMjG4nUbFsRoGUQKRAJRyjNz2Qmcliaxez
         J0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784060287; x=1784665087;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l/HGW119FoJYPxgSwEibIWfzbjDGKl6W4plwAUPyGL4=;
        b=gfrmuqGYopMf9+MecZkmV9xhTxh9t/4jDT1rNCFUYvMzZe3bdFPxWRb1S0MxrQNoFr
         yHVsgDzr6mhpyKCdY1WbQ7EHAlOsnvzU2dsQkZN5a04ipYCOePlMaJ+jHlOqfF42tQdk
         K2Tl1IG1W3rDJiXtlJEBXEf7TuvSBvniuooq56O7WiM4BcOBryRxjBJjOUNhCO5bj/Xf
         M0owvCc9pL2ljATd+pT8IWsxXGqrQZnC/corms/5Vczh6dkgjSiVEzyQXnt8ezuebIgD
         JA5SyBmV9S+vwmgvIoXrDEfwq0xfqHiQrB8De0ae4QclZ2sdIm4mblvFxeRjTwWhibDb
         LDPQ==
X-Forwarded-Encrypted: i=1; AFNElJ/rlYy0rfmQj9FliuET9p0xYXEqFTSh8qFiMjxuUomsT0n+mZKF+4nKnjwYzs5DDTMaKDj5nDuquMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpgkurPjLxcf9traRZobq6AsKpFrtklpp6cK5R/dADwJUxJPkZ
	rDnZw+zknQ7vKMIyFNlAgnfPbvEm21zYRipxuAKdlhuDuuiMUWRG7uY8AQt5Hz2mvvc=
X-Gm-Gg: AfdE7cnqMy3mVZ8FrL3wNDdWJ0icu2Rd0xGsHHTo5gJNoMRw2gmTGwvsIOdVBtYbWWV
	H585aUXM496rED3wT325HOCn1gyumAg8VrVyhWTBqJRxVcY2zYAOQCuzlNgGC/vIDSzPWvS8joz
	W3n9mXCpTBRUtaKvlyd+ITHmNDcbpPXPgVaAJ+ZEkqtRF0MTfvyRQxFOpH4YWhJByK/tc3N57D1
	yzMdps3eOKeBsxWPJa0Gm/4XlE2HpdHGeVbQNwsAfzIOLtcBWWnskMBRdzo07hdVeBMIadks6El
	CUOpZ6sr51/t3VsnrQRr6KQAYqZla6y0TRCP1wsWgP9zkEsiKla+LZKHptufGBj+X8KFHsYai4C
	QWYiwMxd0X3BGG7rFeAzH0xQTIKucvf/GP1d7wNF6IiZ3fnGQeCiIxYoN7+YIf+EQDURiXrRNk1
	a9xzCHbn5EuAaCG7DI/3OlgAXajQFHZ/8ej05WfqXT2KRLlnJTMB9f6Hh4eCIbuLTkY1+69mPhh
	A==
X-Received: by 2002:a05:6830:2a11:b0:7e3:d29b:fea4 with SMTP id 46e09a7af769-7ec423642f7mr3015936a34.22.1784060286612;
        Tue, 14 Jul 2026 13:18:06 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:280e:69fd:7612:d5a9? ([2600:8803:e7e4:500:280e:69fd:7612:d5a9])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ec2183a28fsm6785939a34.24.2026.07.14.13.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 13:18:06 -0700 (PDT)
Message-ID: <741bb99e-e9bf-40ef-9eeb-b736e31b980c@baylibre.com>
Date: Tue, 14 Jul 2026 15:18:04 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] iio: adc: ti-ads1100: Add ti-ads1110 support to
 ti-ads1100 driver
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 marcelo.schmitt@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mike.looijmans@topic.nl, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, jorge.marques@analog.com,
 antoniu.miclaus@analog.com, mazziesaccount@gmail.com,
 jishnu.prakash@oss.qualcomm.com, duje@dujemihanovic.xyz, wens@kernel.org,
 sakari.ailus@linux.intel.com, linusw@kernel.org
References: <20260714195528.597753-1-jakubszczudlo40@gmail.com>
 <20260714195528.597753-4-jakubszczudlo40@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260714195528.597753-4-jakubszczudlo40@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/26 2:55 PM, Jakub Szczudlo wrote:
> Add ADS1110 support that have faster datarate than ADS1100, it also uses
> internal voltage reference of 2.048V for measurement.
> 
> Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
> ---
>  drivers/iio/adc/Kconfig      |  9 ++--
>  drivers/iio/adc/ti-ads1100.c | 87 +++++++++++++++++++++++++++---------
>  2 files changed, 71 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 3755a81c1efd..49a9ac3bf43d 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1768,11 +1768,14 @@ config TI_ADS1018
>           called ti-ads1018.
>  
>  config TI_ADS1100
> -	tristate "Texas Instruments ADS1100 and ADS1000 ADC"
> +	tristate "Texas Instruments ADS1100 and similar single channel I2C ADC"
>  	depends on I2C
>  	help
> -	  If you say yes here you get support for Texas Instruments ADS1100 and
> -	  ADS1000 ADC chips.
> +	  If you say yes here you get support for TI single channel I2C Analog
> +	  Devices.
> +	  * ADS1000 12-Bit, 128 SPS Analog-to-Digital Converter
> +	  * ADS1100 16-Bit, 128 SPS Analog-to-Digital Converter
> +	  * ADS1110 16-Bit, 240 SPS Analog-to-Digital Converter
>  
>  	  This driver can also be built as a module. If so, the module will be
>  	  called ti-ads1100.
> diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
> index f0a30ae139af..5d798bfcc74e 100644
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
> @@ -41,20 +41,44 @@
>  #define	ADS1100_SINGLESHOT	ADS1100_CFG_SC
>  
>  #define ADS1100_SLEEP_DELAY_MS	2000
> +#define ADS1110_INTERNAL_REF_mV 2048

Maybe the diff is messing with the tabs, but I hope the
numbers are vertically aligned.

>  
>  static const int ads1100_data_rate[] = { 128, 32, 16, 8 };
> +static const int ads1110_data_rate[] = { 240, 60, 30, 15 };
>  static const int ads1100_data_rate_bits[] = { 12, 14, 15, 16 };
>  
>  /* Timeout based on the minimum sample rate of 8 SPS (7500ms) */
>  #define ADS1100_MAX_DRDY_TIMEOUT_US	(7500 * USEC_PER_MSEC)
>  
> +struct ads1100_config {
> +	const char *name;
> +	const int *available_data_rate_hz;
> +	const int data_rate_count;
> +	bool has_internal_vref_only;
> +};
> +
> +static const struct ads1100_config ads1100_config = {
> +	.name = "ads1100",
> +	.available_data_rate_hz = ads1100_data_rate,
> +	.data_rate_count = ARRAY_SIZE(ads1100_data_rate),
> +	.has_internal_vref_only = false,
> +};
> +
> +static const struct ads1100_config ads1110_config = {
> +	.name = "ads1110",
> +	.available_data_rate_hz = ads1110_data_rate,
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

The name ads_config could be a bit confusing since the is already a
.config field. We usually call these chip_info if you want a different
name.

>  	u8 config;
> -	bool supports_data_rate; /* Only the ADS1100 can select the rate */
> +	bool supports_data_rate;
>  };
>  
>  static const struct iio_chan_spec ads1100_channel = {
> @@ -90,6 +114,20 @@ static int ads1100_set_config_bits(struct ads1100_data *data, u8 mask, u8 value)
>  	return 0;
>  };
>  
> +static int ads1100_get_vref_millivolts(struct ads1100_data *data)
> +{
> +	int voltage_uV;
> +
> +	if (data->ads_config->has_internal_vref_only)
> +		return ADS1110_INTERNAL_REF_mV;
> +
> +	voltage_uV = regulator_get_voltage(data->reg_vdd);
> +	if (voltage_uV < 0)
> +		return voltage_uV;
> +
> +	return voltage_uV / (MICRO / MILLI);
> +}
> +
>  static int ads1100_data_bits(struct ads1100_data *data)
>  {
>  	return ads1100_data_rate_bits[FIELD_GET(ADS1100_DR_MASK, data->config)];
> @@ -144,7 +182,8 @@ static int ads1100_new_data_is_ready(struct ads1100_data *data)
>  
>  static int ads1100_poll_data_ready(struct ads1100_data *data)
>  {
> -	int data_rate_Hz = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK, data->config)];
> +	int data_rate_index = FIELD_GET(ADS1100_DR_MASK, data->config);
> +	int data_rate_Hz = data->ads_config->available_data_rate_hz[data_rate_index];
>  	/* To be sure we wait 5 times more than data rate */
>  	unsigned long wait_time_us = DIV_ROUND_CLOSEST(USEC_PER_SEC, 5 * data_rate_Hz);
>  	int data_ready;
> @@ -185,7 +224,7 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
>  	if (ret)
>  		return ret;
>  
> -	microvolts = regulator_get_voltage(data->reg_vdd);
> +	microvolts = ads1100_get_vref_millivolts(data) * (MICRO / MILLI);
>  	/*
>  	 * val2 is in 'micro' units, n = val2 / 1000000
>  	 * result must be millivolts, d = microvolts / 1000
> @@ -208,9 +247,9 @@ static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
>  	unsigned int size;
>  	int ret;
>  
> -	size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;
> +	size = data->supports_data_rate ? data->ads_config->data_rate_count : 1;
>  	for (i = 0; i < size; i++) {
> -		if (ads1100_data_rate[i] == rate)
> +		if (data->ads_config->available_data_rate_hz[i] == rate)
>  			break;
>  	}
>  
> @@ -230,14 +269,9 @@ static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
>  	return ads1100_poll_data_ready(data);
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
> +	int millivolts = ads1100_get_vref_millivolts(data);
>  	unsigned int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(data->scale_avail) / 2; i++) {
> @@ -259,9 +293,9 @@ static int ads1100_read_avail(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		*type = IIO_VAL_INT;
> -		*vals = ads1100_data_rate;
> +		*vals = data->ads_config->available_data_rate_hz;
>  		if (data->supports_data_rate)
> -			*length = ARRAY_SIZE(ads1100_data_rate);
> +			*length = data->ads_config->data_rate_count;
>  		else
>  			*length = 1;
>  		return IIO_AVAIL_LIST;
> @@ -280,6 +314,7 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
>  			    int *val2, long mask)
>  {
>  	int ret;
> +	int data_rate_index;
>  	struct ads1100_data *data = iio_priv(indio_dev);
>  
>  	guard(mutex)(&data->lock);
> @@ -296,12 +331,12 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		/* full-scale is the supply voltage in millivolts */
> -		*val = ads1100_get_vdd_millivolts(data);
> +		*val = ads1100_get_vref_millivolts(data);
>  		*val2 = 15 + FIELD_GET(ADS1100_PGA_MASK, data->config);
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		*val = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK,
> -						   data->config)];
> +		data_rate_index = FIELD_GET(ADS1100_DR_MASK, data->config);
> +		*val = data->ads_config->available_data_rate_hz[data_rate_index];
>  		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
> @@ -381,7 +416,6 @@ static int ads1100_probe(struct i2c_client *client)
>  	data->client = client;
>  	mutex_init(&data->lock);
>  
> -	indio_dev->name = "ads1100";
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = &ads1100_channel;
>  	indio_dev->num_channels = 1;
> @@ -401,6 +435,13 @@ static int ads1100_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> +	data->ads_config = i2c_get_match_data(client);
> +	if (!data->ads_config)
> +		return dev_err_probe(dev, -EINVAL,

Andy has been pushing to use ENODEV for these. Current situation
is about equal numbers of EINVAL and ENODEV in existing drivers.
Would be good to pick one and stick with it for new code.

> +				     "Can't get device data from firmware\n");
> +
> +	indio_dev->name = data->ads_config->name;

I would move all of this earlier so we don't have to move
setting the name away from the block of other indio_dev->.

> +
>  	ret = ads1100_setup(data);
>  	if (ret)
>  		return dev_err_probe(dev, ret,
