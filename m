Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65943E1688
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844360; cv=none; b=UKxs43+GN1VL1RxAzKl4HjvIV/F1JLMtVdVgrbST1PmlFBuNsQLjmZJSX/WLN0OFHPTozFytTjBR8yHdvLO0ajMZOQQ4r5FD7hqFMoURVx4fWtN/4zUbWfGDnryoDr+TSVehE+mLpUx4IU7xJtrNchS3fnrLzMTmRwdq+zROIHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844360; c=relaxed/simple;
	bh=kAqvTdLuMioonjY0C2caG7laYTKYm86k4OxJV9+YHoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XABfG8p9yXkEvU9zxNiM8FttmR1P0un37ez3OtpOMZSdypgrqEyXeRRBWWbU3qsfI5r6VimbJ9e2Mqwo/YKAFbh3Apb+vOJBjZjt7QnuqA4jgfICR2cYVrU/BGafKGoWFu/1Aol3YNSxoTToVXJ0MeLlbrz+bXF/Rt7JwqLq7Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=DCkKByV+; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="DCkKByV+"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e94b0aeaa1so2388408a34.0
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 11:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782844356; x=1783449156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s78fpSiarTPyZWyoM0/a10bvvp2HRphUlPqEYFibNnc=;
        b=DCkKByV+00ukJk2DbiGJy5ZrhS0BoSzjP3TZchFKnBt2if9icv8EKKARw3uGVsYpZ7
         qeVBKw2tsWoTwqy64YQ3vW0QMAXHFg0d8dvMNB0k53+/s97pSHNBHVV9KucT8mCCYUuW
         rV1/ngjnFv4kcRb7M1XeZcym5dFJlnQNgNG106dvv9jHhnBmdc4kXF6vYOaU7MiQ9TRm
         fMYeuiBBkT+FqcHgI8itlRgtrKZAwMHCFXWpFZOZj8kaSu0+Dq0evA/cCguDUA9w4ApW
         mPmDFduX9RPa3p3SULPzANYfDlQDhCXKNkvoqUEQD0dD+F71Opa27QEuaIEmZViVsLgT
         E7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782844356; x=1783449156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s78fpSiarTPyZWyoM0/a10bvvp2HRphUlPqEYFibNnc=;
        b=D1IGD84qvxBqssKmz+gq6dCMSNX9kO/5692ku6UMxUorKkA5olZeFesPmpNJh+POhf
         VeJah3U1ZhVRO8HxYufDFFUqglglxFBF3lVdS8HghFRN6gzGgkXg/AHIc7N6OkhmTf5c
         Bhf3m3T9xTux4gHS/5U3qvSllSAYrD/ZPnSupKnQ8cVN1cxVPXqpghJ0M+jH22KTwi8j
         Toa77CORcoomLpBZgkd1pMSnFXB851P0j6gxrXiLhDFXMrnEOC77BGCjTamiSnBOqU/u
         jUSPNA++YRBLgpWPkw9O/K6XepyHXBLPbB2sgIbhgqRm/i345HuEgNjGhXAd0T5ag8Ma
         TayQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1f1+cDX4e5dCG8awE2OyPTN4l3A4Eu8G8WeFgF9bTq3X+2O4RFWfMIeaR7DPEz71Ycoo5bz2TjI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6rjBYx2NeNKdENEF6eIUzFAVVdk4uI3IKNoZQQv9svibVqBGt
	CPtpLaAvq2b46r7xZqeSfamjfTu/YKhdOm+DPneUabCGlZu/MKtZomEaSMlq5Ylj7DU=
X-Gm-Gg: AfdE7clerqNnxcYnE1wprpfdayGw3BnpVKwKJEU7winh2kHvfH6AeDfyIE1y3Xf7/Uq
	4NLhmIzr/c0wH8Eq4aJsH0lo3niJva/xWftz/x3K8suGFfK52b1fUIdgd6oWCORNphFog0hZLNv
	RUobxVeTfvVBsEHgOInWx37MfWlLEXonojd1yUyWxDlMj4DtIEbu2WOsIzallhIcivYrGfHO49A
	c7TGgArjH/ZvA3uMdOOUWCEPZuV5xraNccNPd6bMmfqHhVGF6NLb0gWsc7S0+g4+FlKU6RI1sVs
	op19SRQjSLarMwPbOnNutLAkIOld6A75tAqUPlzCAukijNrnzLJwF0AEPU2DDMeuIUVjKHQRj4d
	ZtLoMyTgPLCWOxpcyrT8C1MHrSu3GS0OfxKBIOi+ygqdOy1+Q2oyIZli3kEw/Yqadho6jO9Cze8
	fRDYTImSzn+P+ynbnssz33PpAuNBP2kVMZpI2A9DdwxFsnivfoOzoUMRp2YFpFnvk=
X-Received: by 2002:a05:6830:8283:b0:7e9:dd93:b88 with SMTP id 46e09a7af769-7e9fc17bdabmr1009066a34.27.1782844355823;
        Tue, 30 Jun 2026 11:32:35 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e190:78b2:dd4e:ba94? ([2600:8803:e7e4:500:e190:78b2:dd4e:ba94])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ebf87f22sm2946454a34.2.2026.06.30.11.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 11:32:35 -0700 (PDT)
Message-ID: <752a33ab-41a1-404d-8413-888cc1a8f446@baylibre.com>
Date: Tue, 30 Jun 2026 13:32:34 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: ti-ads1298: add ADS1299 EEG ADC family
 support
To: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mike.looijmans@topic.nl,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260630140311.1473031-1-shofiqtest@gmail.com>
 <20260630140311.1473031-2-shofiqtest@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260630140311.1473031-2-shofiqtest@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Please add a cover letter for multi-patch series.

On 6/30/26 9:03 AM, Md Shofiqul Islam wrote:
> The ADS1299, ADS1299-4 and ADS1299-6 are 8/4/6-channel, 24-bit
> biopotential (EEG) ADCs from Texas Instruments.  They share the same
> SPI interface, command set and register map as the ADS1298 ECG family,
> making it straightforward to support them in this driver.
> 
> Key differences from the ADS1298:
> - PGA gain range is 1/2/4/6/8/12/24 (vs 6/1/2/3/4/8/12 for ADS1298)
> - Internal voltage reference is always 2.4V (no 4V option)
> - Channel count is encoded differently in the ID register: bits [4:3]
>   identify the ADS1299 family (both bits set), bits [1:0] encode the
>   channel count as (bits + 2) * 2
> 
> Detect the chip family in ads1298_init() by checking bits [4:3] of
> the ID register.  Store the result in the is_ads1299 flag and use it
> to select the correct PGA table in ads1298_get_scale() and to skip
> the 4V reference option in the CONFIG3 initialisation.
> 
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> ---
>  drivers/iio/adc/ti-ads1298.c | 88 ++++++++++++++++++++++++++++--------
>  1 file changed, 69 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
> index 579200e06cbd..8c48a72e6c61 100644
> --- a/drivers/iio/adc/ti-ads1298.c
> +++ b/drivers/iio/adc/ti-ads1298.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/* TI ADS1298 chip family driver
> +/* TI ADS1298/ADS1299 biopotential ADC driver
>   * Copyright (C) 2023 - 2024 Topic Embedded Products
> + * Copyright (C) 2026 Md Shofiqul Islam <shofiqtest@gmail.com>
>   */
>  
>  #include <linux/bitfield.h>
> @@ -43,6 +44,20 @@
>  #define ADS1298_MASK_ID_CHANNELS		GENMASK(2, 0)
>  #define ADS1298_ID_FAMILY_ADS129X		0x90
>  #define ADS1298_ID_FAMILY_ADS129XR		0xd0
> +/*
> + * ADS1299 family is identified by bits [4:3] = 0b11.  Bits [7:5] encode
> + * the silicon revision and vary between production lots, so only bits [4:3]
> + * are checked for family identification.
> + */
> +#define ADS1299_MASK_ID_FAMILY			GENMASK(4, 3)
> +#define ADS1299_ID_FAMILY_EEG			GENMASK(4, 3)
> +/*
> + * ADS1299 channel count is encoded in bits [1:0] of the ID register:
> + * 00 -> 4 channels (ADS1299-4)
> + * 01 -> 6 channels (ADS1299-6)
> + * 10 -> 8 channels (ADS1299)
> + */
> +#define ADS1299_MASK_ID_CHANNELS		GENMASK(1, 0)
>  
>  #define ADS1298_REG_CONFIG1	0x01
>  #define ADS1298_MASK_CONFIG1_HR			BIT(7)
> @@ -101,6 +116,7 @@
>  struct ads1298_private {
>  	const struct ads1298_chip_info *chip_info;
>  	struct spi_device *spi;
> +	bool is_ads1299;

This is not how we handle chip-specific differences in IIO. Instead we
should add a new chip info struct and pass that as the data in the
module device tables.

This new struct should have a flag, e.g. `bool is_fixed_internal_ref` and
`const u8 *pga_settings` that is a pointer to the appropriate array.

>  	struct regulator *reg_avdd;
>  	struct regulator *reg_vref;
>  	struct clk *clk;
> @@ -276,7 +292,10 @@ static int ads1298_set_samp_freq(struct ads1298_private *priv, int val)
>  				  cfg);
>  }
>  
> +/* ADS1298 PGA: register bits [6:4] -> gain (000=6, 001=1, 010=2, ...) */
>  static const u8 ads1298_pga_settings[] = { 6, 1, 2, 3, 4, 8, 12 };
> +/* ADS1299 PGA: register bits [6:4] -> gain (000=1, 001=2, 010=4, ...) */
> +static const u8 ads1299_pga_settings[] = { 1, 2, 4, 6, 8, 12, 24 };
>  
>  static int ads1298_get_scale(struct ads1298_private *priv,
>  			     int channel, int *val, int *val2)
> @@ -291,12 +310,15 @@ static int ads1298_get_scale(struct ads1298_private *priv,
>  			return ret;
>  
>  		*val = ret / MILLI; /* Convert to millivolts */
> +	} else if (priv->is_ads1299) {

So this would change to:

	} else if (priv->info->is_fixed_internal_ref) {

> +		/* ADS1299 internal reference is always 2.4V */
> +		*val = 2400;
>  	} else {
>  		ret = regmap_read(priv->regmap, ADS1298_REG_CONFIG3, &regval);
>  		if (ret)
>  			return ret;
>  
> -		/* Reference in millivolts */
> +		/* ADS1298 reference in millivolts: 2.4V or 4V */
>  		*val = regval & ADS1298_MASK_CONFIG3_VREF_4V ? 4000 : 2400;
>  	}
>  
> @@ -304,7 +326,8 @@ static int ads1298_get_scale(struct ads1298_private *priv,
>  	if (ret)
>  		return ret;
>  
> -	gain = ads1298_pga_settings[FIELD_GET(ADS1298_MASK_CH_PGA, regval)];
> +	gain = (priv->is_ads1299 ? ads1299_pga_settings : ads1298_pga_settings)
> +		[FIELD_GET(ADS1298_MASK_CH_PGA, regval)];

And this would be:

	gain = priv->info->pga_settings[FIELD_GET(ADS1298_MASK_CH_PGA, regval)];

>  	*val /= gain; /* Full scale is VREF / gain */
>  
>  	*val2 = ADS1298_BITS_PER_SAMPLE - 1; /* Signed, hence the -1 */
> @@ -600,20 +623,39 @@ static int ads1298_init(struct iio_dev *indio_dev)
>  	if (ret)
>  		return ret;
>  
> -	/* Fill in name and channel count based on what the chip told us */
> -	indio_dev->num_channels = 4 + 2 * (val & ADS1298_MASK_ID_CHANNELS);
> -	switch (val & ADS1298_MASK_ID_FAMILY) {
> -	case ADS1298_ID_FAMILY_ADS129X:
> -		suffix = "";
> -		break;
> -	case ADS1298_ID_FAMILY_ADS129XR:
> -		suffix = "r";
> -		break;
> -	default:
> -		return dev_err_probe(dev, -ENODEV, "Unknown ID: 0x%x\n", val);
> +	/*
> +	 * Detect chip family from the ID register.  The ADS1299 EEG family
> +	 * is identified by bits [4:3] = 0b11; the ADS1298 ECG family uses
> +	 * bits [7:3] for family identification.
> +	 */
> +	if (FIELD_GET(ADS1299_MASK_ID_FAMILY, val) == ADS1299_ID_FAMILY_EEG) {
> +		/*
> +		 * ADS1299 family: channel count from bits [1:0].
> +		 * 00 -> 4ch, 01 -> 6ch, 10 -> 8ch.
> +		 */
> +		priv->is_ads1299 = true;
> +		indio_dev->num_channels =
> +			(FIELD_GET(ADS1299_MASK_ID_CHANNELS, val) + 2) * 2;

Number of channels should come from the new chip info based on the compatible
string as well.

> +		indio_dev->name = devm_kasprintf(dev, GFP_KERNEL, "ads1299%s",
> +			indio_dev->num_channels == 4 ? "-4" :
> +			indio_dev->num_channels == 6 ? "-6" : "");

Generally, we put the chip name in the chip info as well.

> +	} else {
> +		/* ADS1298 family: channel count from bits [2:0], name from family */
> +		indio_dev->num_channels = 4 + 2 * (val & ADS1298_MASK_ID_CHANNELS);
> +		switch (val & ADS1298_MASK_ID_FAMILY) {
> +		case ADS1298_ID_FAMILY_ADS129X:
> +			suffix = "";
> +			break;
> +		case ADS1298_ID_FAMILY_ADS129XR:
> +			suffix = "r";
> +			break;
> +		default:
> +			return dev_err_probe(dev, -ENODEV,
> +					     "Unknown ID: 0x%x\n", val);
> +		}
> +		indio_dev->name = devm_kasprintf(dev, GFP_KERNEL, "ads129%u%s",
> +						 indio_dev->num_channels, suffix);
>  	}
> -	indio_dev->name = devm_kasprintf(dev, GFP_KERNEL, "ads129%u%s",
> -					 indio_dev->num_channels, suffix);
>  	if (!indio_dev->name)
>  		return -ENOMEM;
>  
> @@ -621,8 +663,9 @@ static int ads1298_init(struct iio_dev *indio_dev)
>  	if (!priv->reg_vref) {
>  		/* Enable internal reference */
>  		val |= ADS1298_MASK_CONFIG3_PWR_REFBUF;
> -		/* Use 4V VREF when power supply is at least 4.4V */
> -		if (regulator_get_voltage(priv->reg_avdd) >= 4400000)
> +		/* ADS1298 only: use 4V VREF when supply is at least 4.4V */
> +		if (!priv->is_ads1299 &&

And of course use priv->info->is_fixed_internal_ref here too.

> +		    regulator_get_voltage(priv->reg_avdd) >= 4400000)
>  			val |= ADS1298_MASK_CONFIG3_VREF_4V;
>  	}
>  	return regmap_write(priv->regmap, ADS1298_REG_CONFIG3, val);
> @@ -739,12 +782,18 @@ static int ads1298_probe(struct spi_device *spi)
>  
>  static const struct spi_device_id ads1298_id[] = {
>  	{ "ads1298" },
> +	{ "ads1299" },
> +	{ "ads1299-4" },
> +	{ "ads1299-6" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, ads1298_id);
>  
>  static const struct of_device_id ads1298_of_table[] = {
>  	{ .compatible = "ti,ads1298" },
> +	{ .compatible = "ti,ads1299" },
> +	{ .compatible = "ti,ads1299-4" },
> +	{ .compatible = "ti,ads1299-6" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ads1298_of_table);
> @@ -760,5 +809,6 @@ static struct spi_driver ads1298_driver = {
>  module_spi_driver(ads1298_driver);
>  
>  MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
> -MODULE_DESCRIPTION("TI ADS1298 ADC");
> +MODULE_AUTHOR("Md Shofiqul Islam <shofiqtest@gmail.com>");
> +MODULE_DESCRIPTION("TI ADS1298/ADS1299 biopotential ADC");
>  MODULE_LICENSE("GPL");

