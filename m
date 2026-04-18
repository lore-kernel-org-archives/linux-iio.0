Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE492AEE1
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 22:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776549951; cv=none; b=Qh/z5Iose7W2ijhTmvcU4mvLn6WVN5T8cJF/kte6A3ZUTTOMGOUMOSCkNXeS4iBleBRenXVcNyI1idLKTWB67v2Vuk/unm95tc2U0Eup9RKaIrgyf9Mu3jYiwWK+2/AAAPxq3U0p66/HQPusijxoe0yXjYIvb7duv4Db9Q5aSEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776549951; c=relaxed/simple;
	bh=fblD8o1NqgZgfdWtPKKaVyG/qp7MYzJ8nDg2L63yEv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqm4aBha52+kRpUn2Eonv/qpltua6DzDjKcf7jZWJgwgx/aI+UUW71fYaAQfiCGptQPEGtlShkti0RIfHwLZDnz4YaU5g6dDyHvC/mrzqCUaZPtQ4Hb4pjGWvfWA69Aze77cb4cPI34A7nhqNZN0cqcCj4KZdykMQgcbrcWkNtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=i4CozyIJ; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="i4CozyIJ"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7dc35728a57so1526786a34.0
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 15:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776549948; x=1777154748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yCKo/j4d0rTXUo1iFpBfxuIFETIQAFbf4KDMXPBR6fI=;
        b=i4CozyIJnnkmpqRrARc0JBvoLxOJ+Qo9/nm6FIA2ZdPDZS7Ueb8wXjUm9zF15R8JMw
         5M7/1ocPrhB6x6B0A61I8ds0WLY6FelNXCtHvjDivVGrVh9H3Czg7Izedfiolh4XQkoZ
         dS16G8sx2X3z4NfIUMqlgWW0en0IkFhSSBTKYtQthVlBiikj66MRMQDjudWxsKG8i5Kp
         tsXeeKGVY6rmh+3rlYZoFegasKbqHsfNwsFyAwGy/P0oIJkpX1qXYu7rIakUCbsy4oj2
         rUQHQkCNWUyD7yVL3x+ddxaw88OkwTzBRTGkq/pS1fVgbhnKZVF4FMlPYqOizpCeUoCx
         GeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776549948; x=1777154748;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCKo/j4d0rTXUo1iFpBfxuIFETIQAFbf4KDMXPBR6fI=;
        b=o5Hu/Cy1ITbCc0QGYCu9/yhQqc/MehqEgZ3p3fbiz6+gREzIdlXx5J5Hraj9R2pnuR
         hL0mIkmVE/H50CbtiWAApDlf64QtUBmrztlkU3DovEi3mGtejLLdsAR6Dwu9oZx65QgO
         b+0Sonuhke0yd+eQWiTaaFONMteFk95jGLJWQH3QN/OkAEcK16Ze/bTPsbiXYthSuaNq
         PVbzBx1KwyRJcRpYb3Ll2WLx2bKIcaidij7TYgSdxl29iAnpwuv1Qpwc+nyk+gS+6X3c
         Icu81O3h4hWcft8+M5cXpGPOLmLRCsTqj6zEct+IrPGk4fK4R62XM99ZdEOybrdBkgxl
         7lng==
X-Forwarded-Encrypted: i=1; AFNElJ88h5Vots7q9pvM34AJLRCo1b1fHsmWWuaZJnr9pPWod2FN7Yh4EyPg+nUiH8Gj6hh77GEbot6fJj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYCORc68DjxkjZ7HVUFppIAeACgwfsR9D9emHY9nbrlAzIkgxj
	pXAGQ6u4b1AYUnOUTHpXEo1ElXE8ZpMFXzqMKV2FQvRt/ealJPYuypC1Be+kc4lm230=
X-Gm-Gg: AeBDies9+uD2rJUfft2siSpjdz3cYOOfBOMW+PTOkXov8N8fjnTwSz4AhxZfj9Ct5Yy
	vhE6wdA6Immt4R++1XZS2bt8U6ldoAJoMg+a8b3EKinrWLIcx6HJQln0/tdO57wWftv//kgGAdv
	+RwQFNbCO9ehblyfvYWX1hw7UEaSr9ZLG5XKoV86nvr7Wh+gNFxrGVlEBNG4966qPQ+SYucsxe5
	w6ulJFo9LR8uPTZ5Jh3rZagOHle//Flf2+FH6yR/D+m/rwRCDQlpnboilrlZQgb3UhZxRh7z5My
	wmdF3iO0f6XwFvKF9OX3T4D9C5Io6BJoRSUFftJNzasAOTTullXF0weTG6lwLbjoivLxdavnlVG
	7Sa49iCmh/peUG3rUVYGnVZWUgfphwUyTXMbKqDmv6/hZY90RsmNcMgalbCQF/lTX5iYCEOYC/l
	gVFkGVpCOYFCFVgU908xlvz4sMCkZ/DjaEca57M6A0FCu+5WQ7wqXfFOqw768k6pcYzjgu1y79G
	978Ab21SpDvq4TDgmN6Lts=
X-Received: by 2002:a05:6820:1797:b0:68c:3d8e:7911 with SMTP id 006d021491bc7-69462f34df7mr4681911eaf.44.1776549947728;
        Sat, 18 Apr 2026 15:05:47 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b1f8:aabe:74d7:21ba? ([2600:8803:e7e4:500:b1f8:aabe:74d7:21ba])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69464e5e732sm3450923eaf.3.2026.04.18.15.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2026 15:05:46 -0700 (PDT)
Message-ID: <c90e4aa8-528d-4951-9f80-80612d013591@baylibre.com>
Date: Sat, 18 Apr 2026 17:05:44 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: adc: hx711: add support for HX710B
To: Piyush Patle <piyushpatle228@gmail.com>, jic23@kernel.org,
 ak@it-klinger.de
Cc: nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260418170610.312523-1-piyushpatle228@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260418170610.312523-1-piyushpatle228@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

When there is more than one patch in a series, add a cover letter to
keep the patches together.

On 4/18/26 12:06 PM, Piyush Patle wrote:
> Refactor the driver around per-chip configuration so HX711 and HX710B
> can share the same core.
> 
> Add HX710B channel definitions, pulse-count based channel selection, a

Can you explain this difference a bit more? It seems like the two chips
are quite different in this regard.

> variant-specific iio_info, and fixed-scale handling at probe. Update the
> Kconfig text and trim comments so the added support stays focused on the
> actual driver behavior.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> ---
>  drivers/iio/adc/Kconfig |   9 +-
>  drivers/iio/adc/hx711.c | 222 ++++++++++++++++++++++++++++++++--------
>  2 files changed, 184 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 60038ae8dfc4..ddf981fa72a2 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -784,18 +784,21 @@ config HI8435
>  	  called hi8435.
>  
>  config HX711
> -	tristate "AVIA HX711 ADC for weight cells"
> +	tristate "AVIA HX711 and HX710B ADC"
>  	depends on GPIOLIB
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> -	  If you say yes here you get support for AVIA HX711 ADC which is used
> -	  for weigh cells
> +	  If you say yes here you get support for AVIA HX711 and HX710B ADCs
> +	  which are used for bridge sensors such as weigh cells.
>  
>  	  This driver uses two GPIOs, one acts as the clock and controls the
>  	  channel selection and gain, the other one is used for the measurement
>  	  data
>  
> +	  The HX710B is a variant with fixed gain and a different channel
> +	  selection scheme.
> +
>  	  Currently the raw value is read from the chip and delivered.
>  	  To get an actual weight one needs to subtract the
>  	  zero offset and multiply by a scale factor.
> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> index 1db8b68a8f64..cd251fa9f6b7 100644
> --- a/drivers/iio/adc/hx711.c
> +++ b/drivers/iio/adc/hx711.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * HX711: analog to digital converter for weight sensor module
> + * HX711/HX710B ADC driver
>   *
>   * Copyright (c) 2016 Andreas Klinger <ak@it-klinger.de>
>   */
> @@ -76,13 +76,34 @@ static int hx711_get_scale_to_gain(int scale)
>  	return -EINVAL;
>  }
>  
> +/**
> + * struct hx711_chip_info - per-variant static configuration
> + * @name: IIO device name
> + * @channels: channel specification
> + * @num_channels: number of channels
> + * @chan_pulse_count: trailing pulse count for fixed-gain variants
> + * @num_chan_pulses: number of pulse-count entries
> + * @reset_channel: default channel after reset
> + */
> +struct hx711_chip_info {
> +	const char			*name;
> +	const struct iio_chan_spec	*channels;
> +	int				num_channels;
> +	const int			*chan_pulse_count;
> +	int				num_chan_pulses;
> +	int				reset_channel;
> +};
> +
>  struct hx711_data {
> -	struct device		*dev;
> -	struct gpio_desc	*gpiod_pd_sck;
> -	struct gpio_desc	*gpiod_dout;
> -	int			gain_set;	/* gain set on device */
> -	int			gain_chan_a;	/* gain for channel A */
> -	struct mutex		lock;
> +	struct device			*dev;
> +	struct gpio_desc		*gpiod_pd_sck;
> +	struct gpio_desc		*gpiod_dout;
> +	int				gain_set;	/* HX711 */
> +	int				gain_chan_a;	/* HX711 channel A gain */
> +	int				channel_set;	/* HX710B */
> +	int				scale;		/* HX710B scale */
> +	const struct hx711_chip_info	*chip_info;
> +	struct mutex			lock;
>  	/*
>  	 * triggered buffer
>  	 * 2x32-bit channel + 64-bit naturally aligned timestamp
> @@ -92,13 +113,10 @@ struct hx711_data {
>  		aligned_s64 timestamp;
>  	} buffer;
>  	/*
> -	 * delay after a rising edge on SCK until the data is ready DOUT
> -	 * this is dependent on the hx711 where the datasheet tells a
> -	 * maximum value of 100 ns
> -	 * but also on potential parasitic capacities on the wiring
> +	 * Delay after SCK rising edge before sampling DOUT.
>  	 */
> -	u32			data_ready_delay_ns;
> -	u32			clock_frequency;
> +	u32				data_ready_delay_ns;
> +	u32				clock_frequency;
>  };
>  
>  static int hx711_cycle(struct hx711_data *hx711_data)
> @@ -139,7 +157,11 @@ static int hx711_cycle(struct hx711_data *hx711_data)
>  	return gpiod_get_value(hx711_data->gpiod_dout);
>  }
>  
> -static int hx711_read(struct hx711_data *hx711_data)
> +/*
> + * Clock out 24 data bits and then send trailing pulses to select the
> + * next channel/gain state.
> + */
> +static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
>  {
>  	int i, ret;
>  	int value = 0;
> @@ -158,7 +180,7 @@ static int hx711_read(struct hx711_data *hx711_data)
>  
>  	value ^= 0x800000;
>  
> -	for (i = 0; i < hx711_get_gain_to_pulse(hx711_data->gain_set); i++)
> +	for (i = 0; i < trailing_pulses; i++)
>  		hx711_cycle(hx711_data);
>  
>  	return value;
> @@ -188,6 +210,7 @@ static int hx711_wait_for_ready(struct hx711_data *hx711_data)
>  
>  static int hx711_reset(struct hx711_data *hx711_data)
>  {
> +	const struct hx711_chip_info *info = hx711_data->chip_info;
>  	int val = hx711_wait_for_ready(hx711_data);
>  
>  	if (val) {
> @@ -206,13 +229,17 @@ static int hx711_reset(struct hx711_data *hx711_data)
>  
>  		val = hx711_wait_for_ready(hx711_data);
>  
> -		/* after a reset the gain is 128 */
> -		hx711_data->gain_set = HX711_RESET_GAIN;
> +		/* Restore variant default after reset. */
> +		if (info->chan_pulse_count)
> +			hx711_data->channel_set = info->reset_channel;
> +		else
> +			hx711_data->gain_set = HX711_RESET_GAIN;
>  	}
>  
>  	return val;
>  }
>  
> +/* Select HX711 channel/gain for the next conversion. */
>  static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
>  {
>  	int ret;
> @@ -221,7 +248,8 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
>  		if (hx711_data->gain_set == 32) {
>  			hx711_data->gain_set = hx711_data->gain_chan_a;
>  
> -			ret = hx711_read(hx711_data);
> +			ret = hx711_read(hx711_data,
> +					 hx711_get_gain_to_pulse(hx711_data->gain_set));
>  			if (ret < 0)
>  				return ret;
>  
> @@ -233,7 +261,8 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
>  		if (hx711_data->gain_set != 32) {
>  			hx711_data->gain_set = 32;
>  
> -			ret = hx711_read(hx711_data);
> +			ret = hx711_read(hx711_data,
> +					 hx711_get_gain_to_pulse(hx711_data->gain_set));
>  			if (ret < 0)
>  				return ret;
>  
> @@ -246,27 +275,52 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
>  	return 0;
>  }
>  
> +/* Select HX710B channel for the next conversion. */
> +static int hx710b_set_channel(struct hx711_data *hx711_data, int chan)
> +{
> +	const struct hx711_chip_info *info = hx711_data->chip_info;
> +	int ret;
> +
> +	if (chan >= info->num_chan_pulses)
> +		return -EINVAL;
> +
> +	if (hx711_data->channel_set == chan)
> +		return 0;
> +
> +	hx711_data->channel_set = chan;
> +
> +	ret = hx711_read(hx711_data, info->chan_pulse_count[chan]);
> +	if (ret < 0)
> +		return ret;
> +
> +	return hx711_wait_for_ready(hx711_data);
> +}
> +
>  static int hx711_reset_read(struct hx711_data *hx711_data, int chan)
>  {
> +	const struct hx711_chip_info *info = hx711_data->chip_info;
> +	int trailing_pulses;
>  	int ret;
> -	int val;
>  
> -	/*
> -	 * hx711_reset() must be called from here
> -	 * because it could be calling hx711_read() by itself
> -	 */
> +	/* Reset first so the read starts from a known chip state. */
>  	if (hx711_reset(hx711_data)) {
>  		dev_err(hx711_data->dev, "reset failed!");
>  		return -EIO;
>  	}
>  
> -	ret = hx711_set_gain_for_channel(hx711_data, chan);
> -	if (ret < 0)
> -		return ret;
> -
> -	val = hx711_read(hx711_data);
> +	if (info->chan_pulse_count) {
> +		ret = hx710b_set_channel(hx711_data, chan);
> +		if (ret < 0)
> +			return ret;
> +		trailing_pulses = info->chan_pulse_count[chan];
> +	} else {
> +		ret = hx711_set_gain_for_channel(hx711_data, chan);
> +		if (ret < 0)
> +			return ret;
> +		trailing_pulses = hx711_get_gain_to_pulse(hx711_data->gain_set);
> +	}
>  
> -	return val;
> +	return hx711_read(hx711_data, trailing_pulses);
>  }
>  
>  static int hx711_read_raw(struct iio_dev *indio_dev,
> @@ -274,6 +328,7 @@ static int hx711_read_raw(struct iio_dev *indio_dev,
>  				int *val, int *val2, long mask)
>  {
>  	struct hx711_data *hx711_data = iio_priv(indio_dev);
> +	const struct hx711_chip_info *info = hx711_data->chip_info;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -290,7 +345,10 @@ static int hx711_read_raw(struct iio_dev *indio_dev,
>  		*val = 0;
>  		mutex_lock(&hx711_data->lock);
>  
> -		*val2 = hx711_get_gain_to_scale(hx711_data->gain_set);
> +		if (info->chan_pulse_count)
> +			*val2 = hx711_data->scale;
> +		else
> +			*val2 = hx711_get_gain_to_scale(hx711_data->gain_set);
>  
>  		mutex_unlock(&hx711_data->lock);
>  
> @@ -332,7 +390,8 @@ static int hx711_write_raw(struct iio_dev *indio_dev,
>  			if (gain != 32)
>  				hx711_data->gain_chan_a = gain;
>  
> -			ret = hx711_read(hx711_data);
> +			ret = hx711_read(hx711_data,
> +					 hx711_get_gain_to_pulse(hx711_data->gain_set));
>  			if (ret < 0) {
>  				mutex_unlock(&hx711_data->lock);
>  				return ret;
> @@ -423,6 +482,10 @@ static const struct iio_info hx711_iio_info = {
>  	.attrs			= &hx711_attribute_group,
>  };
>  
> +static const struct iio_info hx710b_iio_info = {
> +	.read_raw		= hx711_read_raw,
> +};
> +
>  static const struct iio_chan_spec hx711_chan_spec[] = {
>  	{
>  		.type = IIO_VOLTAGE,
> @@ -455,10 +518,69 @@ static const struct iio_chan_spec hx711_chan_spec[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(2),
>  };
>  
> +/* HX710B channels: differential input and DVDD-AVDD measurement. */
> +static const struct iio_chan_spec hx710b_chan_spec[] = {
> +	{
> +		.type = IIO_VOLTAGE,
> +		.channel = 0,
> +		.indexed = 1,

If it is differential, shouldn't we have .differential = 1 and .channel2 = 1?

> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 24,
> +			.storagebits = 32,
> +			.endianness = IIO_CPU,
> +		},
> +	},
> +	{
> +		.type = IIO_VOLTAGE,
> +		.channel = 1,
> +		.indexed = 1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 1,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 24,
> +			.storagebits = 32,
> +			.endianness = IIO_CPU,
> +		},
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(2),
> +};
> +
> +/*
> + * HX710B trailing pulse counts.
> + * 25 selects differential input, 26 selects DVDD-AVDD.
> + */
> +static const int hx710b_pulse_counts[] = {
> +	25,	/* channel 0: differential input, 10 SPS */
> +	26,	/* channel 1: DVDD-AVDD voltage,   40 SPS */

We could store these numbers in the .address field of the channel
instead. It is there for driver-specific things like this.

> +};
> +
> +static const struct hx711_chip_info hx711_chip = {
> +	.name			= "hx711",
> +	.channels		= hx711_chan_spec,
> +	.num_channels		= ARRAY_SIZE(hx711_chan_spec),
> +	.chan_pulse_count	= NULL,
> +};
> +
> +static const struct hx711_chip_info hx710b_chip = {
> +	.name			= "hx710b",
> +	.channels		= hx710b_chan_spec,
> +	.num_channels		= ARRAY_SIZE(hx710b_chan_spec),
> +	.chan_pulse_count	= hx710b_pulse_counts,
> +	.num_chan_pulses	= ARRAY_SIZE(hx710b_pulse_counts),
> +	.reset_channel		= 0,
> +};
> +
>  static int hx711_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct hx711_data *hx711_data;
> +	const struct hx711_chip_info *chip_info;
>  	struct iio_dev *indio_dev;
>  	int ret;
>  	int i;
> @@ -472,6 +594,11 @@ static int hx711_probe(struct platform_device *pdev)
>  
>  	mutex_init(&hx711_data->lock);
>  
> +	chip_info = device_get_match_data(dev);
> +	if (!chip_info)
> +		return -ENODEV;

We recently decided to standardize on not checking for NULL on this.

> +	hx711_data->chip_info = chip_info;
> +
>  	/*
>  	 * PD_SCK stands for power down and serial clock input of HX711
>  	 * in the driver it is an output
> @@ -510,12 +637,20 @@ static int hx711_probe(struct platform_device *pdev)
>  	/* we need 10^-9 mV */
>  	ret *= 100;
>  
> -	for (i = 0; i < HX711_GAIN_MAX; i++)
> -		hx711_gain_to_scale[i].scale =
> -			ret / hx711_gain_to_scale[i].gain / 1678;
> +	if (chip_info->chan_pulse_count) {

Why does chan_pulse_count imply fixed gain? If it is not related, we should
add a new flag to the chip info instead.

We want to avoid assuming any branch of the if statement is a specific chip
in case any more are added in the future.

> +		/* HX710B uses a fixed gain, so compute scale once at probe. */
> +		hx711_data->scale = ret / 128 / 1678;
> +		hx711_data->channel_set = chip_info->reset_channel;
> +		indio_dev->info = &hx710b_iio_info;
> +	} else {
> +		for (i = 0; i < HX711_GAIN_MAX; i++)
> +			hx711_gain_to_scale[i].scale =
> +				ret / hx711_gain_to_scale[i].gain / 1678;
>  
> -	hx711_data->gain_set = 128;
> -	hx711_data->gain_chan_a = 128;
> +		hx711_data->gain_set = 128;
> +		hx711_data->gain_chan_a = 128;
> +		indio_dev->info = &hx711_iio_info;
> +	}
>  
>  	hx711_data->clock_frequency = 400000;
>  	ret = device_property_read_u32(&pdev->dev, "clock-frequency",
> @@ -533,11 +668,10 @@ static int hx711_probe(struct platform_device *pdev)
>  	hx711_data->data_ready_delay_ns =
>  				1000000000 / hx711_data->clock_frequency;
>  
> -	indio_dev->name = "hx711";
> -	indio_dev->info = &hx711_iio_info;
> +	indio_dev->name = chip_info->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = hx711_chan_spec;
> -	indio_dev->num_channels = ARRAY_SIZE(hx711_chan_spec);
> +	indio_dev->channels = chip_info->channels;
> +	indio_dev->num_channels = chip_info->num_channels;
>  
>  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>  					      iio_pollfunc_store_time,
> @@ -554,7 +688,8 @@ static int hx711_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id of_hx711_match[] = {
> -	{ .compatible = "avia,hx711", },
> +	{ .compatible = "avia,hx711",  .data = &hx711_chip  },
> +	{ .compatible = "avia,hx710b", .data = &hx710b_chip },
>  	{ }
>  };
>  
> @@ -571,7 +706,6 @@ static struct platform_driver hx711_driver = {
>  module_platform_driver(hx711_driver);
>  
>  MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
> -MODULE_DESCRIPTION("HX711 bitbanging driver - ADC for weight cells");
> +MODULE_DESCRIPTION("HX711/HX710B GPIO ADC driver");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:hx711-gpio");
> -

