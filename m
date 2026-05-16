Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F766381AF
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778951484; cv=none; b=ZIoZktWPi/iCN4535rq5Ph/kOCl6gMPKxnPzolFUbC0Vx++pbydDosQfFEmjRUm31dPxRHEt1Aws7Pow2sF9XYCfCFc30ktHRNRcSGimIUwkXq6sXzBxAbPJbq+oP7O2Z4HL/av8+TYMxpX3gC5yrIq4Z1k49UWLbCH8qsBc+iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778951484; c=relaxed/simple;
	bh=QDcCpH2R75CO3pdZtx9NncX3AJcw9hHHX3fE+5suqA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4OSZkC3ESyCfxD4P27hxbI+kgX41+ZG44RH635tQyefKxr/w4jNNCPUEcfw1T6d29QpJlBoD+SkiV4o95JBJX8vAL7tQJbOCpkK/Kbq4m+BW9MrnZk0lFtHdQRcYgS9hVGl08IAKDWdndhTeef5JFVQJFwl6xMg2l8ntY2cBfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=bEO33Aki; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="bEO33Aki"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dcdca9aa0bso2358826a34.0
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 10:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778951479; x=1779556279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AV1X9shhHnSfJ5+JKZs6jUaJ6gdM+dlaXnG4LN4rYYY=;
        b=bEO33Aki2ukaHUHfgvhm/GibFY0cqsZGw7TX87Z3gYPg7tGpAroV3grRGPuOQkIdUQ
         DwiaJuXkM7B3HQvxbVqATwIqbDu81QRSvEYvxrIAK3z9ukFa4GuNjHjgokvTPJfuZPfW
         sO8rVbcG/gDCVqmeU2oXZGr5DBLYW20bkYdFimf5eA8TJibqaPWUrJg68An0p5Hvge1L
         /YimDkjzLc3DSxyTiyS88UkQaMpMqqS/MatuojVUVGgtUK/aT3Ujf4hzcUrFhEWehbZ4
         Ch6qmO+hsPdHN1FXFezJI5pfVA09kf0DGc1lnMNTP9HZerW1hWj7RMh2xdilMHhT+kAz
         a6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778951479; x=1779556279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AV1X9shhHnSfJ5+JKZs6jUaJ6gdM+dlaXnG4LN4rYYY=;
        b=TaTJKlHUnMzknVgXVYzq78qQva/mMVV+TwK0eVIHlnKi4GORSEKPg0dXL6RhO6otrv
         IUH7jqnOTsWk15Zlz10EOWIt+CkLvGSRJGosfG5eWXua5heycBxCf8Le3MpT6bNY0fUb
         VkRO45+lb1I+N14pH+nxlIccMkahftDW2BIkOwkZ5YSZeGzWnTsXzFeHjPbLmuIB5mBS
         ToKWbRtcZTAn/FLTd5LjLo4lUH+7FxwQKsak99apunWMem0R+zfq6TLu0ufR67YsMIN+
         IlzxenaCSUunRJZoFuqCa93mP7Sou0HdAC1tx0aQbTdxdGRk4UhX7VYDEOI641SnCT5Y
         BHOQ==
X-Gm-Message-State: AOJu0YzL0x5ptaMeZNs+w21AdwGWbuvqqhglvlYIcJt4MFlfGoXBfgTf
	7Wu9HqY/seBzktaeuQ6epL44ubmzqLIT+2yI/EEI2b9X7ZR9t/1mRXzt+cVlr2NDvrw=
X-Gm-Gg: Acq92OGTAgOKoAqJYcxmZiy0/FBQltxHNSWHKMZntnpvrNQqB/pgnlAXSybxM2uwOUw
	z6Mm/SoCmB2GQjsZNywIuk47+TiVuH89Ymcz7MEAFksI8WH3vvaq4jflre3WBt1aQ1JeazqR8uP
	x7/Dbw+Twg4F+x2GaZhMvlDXiv2YCvD73mH/Mdf5lTwh/ptuAW3YnIkbLZSDHH0VWGizmce2IaB
	GAumqwHDKVj4F+Q9V8jLnl9losWxV2nLbbIFGV4Rzzd/TqROniBPFxGi2LhO2s6XDrIBt1tPcwb
	cPPfXtkfXRp+iSqJluxe4zY6Uq4sknus9OpcnrMJ01KqlcUo09kO3XMnpZkFBxX5hr6TO1D+a3t
	Lt/5IolI++cAy/QXNkCpShL1cY7EdWjSHOwHN60eJ4+2JLdOg6yw5COohb/0S7MQoarlFKc2BlT
	9V8YV65l6xdStXG5XGMxzcK9Rfxh1L6A97Nyw+oFOIN1nEhN/sGYzcc5jTVbaRgiCN+gIX+Yu/O
	w==
X-Received: by 2002:a05:6820:1c8c:b0:694:7051:6fef with SMTP id 006d021491bc7-69c5d3b8b3bmr4812159eaf.4.1778951478872;
        Sat, 16 May 2026 10:11:18 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b36d:bd18:7c02:29e2? ([2600:8803:e7e4:500:b36d:bd18:7c02:29e2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d04911744sm2841986eaf.12.2026.05.16.10.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 10:11:17 -0700 (PDT)
Message-ID: <0696b662-f478-4d1a-95e0-0338bbdb719e@baylibre.com>
Date: Sat, 16 May 2026 12:11:16 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/6] iio: adc: ad4691: add initial driver for AD4691
 family
To: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260515-ad4692-multichannel-sar-adc-driver-v11-0-eab27d852ac2@analog.com>
 <20260515-ad4692-multichannel-sar-adc-driver-v11-2-eab27d852ac2@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260515-ad4692-multichannel-sar-adc-driver-v11-2-eab27d852ac2@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/15/26 8:31 AM, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add support for the Analog Devices AD4691 family of high-speed,
> low-power multichannel SAR ADCs: AD4691 (16-ch, 500 kSPS),
> AD4692 (16-ch, 1 MSPS), AD4693 (8-ch, 500 kSPS) and
> AD4694 (8-ch, 1 MSPS).
> 
> The driver implements a custom regmap layer over raw SPI to handle the
> device's mixed 1/2/3/4-byte register widths and uses the standard IIO
> read_raw/write_raw interface for single-channel reads.
> 
> The chip idles in Autonomous Mode so that single-shot read_raw can use
> the internal oscillator without disturbing the hardware configuration.
> 
> Three voltage supply domains are managed: avdd (required), vio, and a
> reference supply on either the REF pin (ref-supply, external buffer)
> or the REFIN pin (refin-supply, uses the on-chip reference buffer;
> REFBUF_EN is set accordingly). Hardware reset is performed via
> the reset controller framework; a software reset through SPI_CONFIG_A
> is used as fallback when no hardware reset is available.
> 
> Accumulator channel masking for single-shot reads uses ACC_MASK_REG via
> an ADDR_DESCENDING SPI write, which covers both mask bytes in a single
> 16-bit transfer.
> 
> IIO_CHAN_INFO_SAMP_FREQ is exposed as info_mask_separate. The oscillator
> is shared hardware — writing any channel's sampling_frequency attribute
> sets it for all others — but per-channel attributes are used throughout
> the series to avoid an ABI change when per-channel oversampling ratios
> are introduced in a later commit, at which point the effective output
> rate (osc_freq / osr[N]) becomes genuinely per-channel.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
>  MAINTAINERS              |   1 +
>  drivers/iio/adc/Kconfig  |  12 +
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/ad4691.c | 756 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 770 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 438ca850fa1c..24e4502b8292 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1490,6 +1490,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
> +F:	drivers/iio/adc/ad4691.c
>  
>  ANALOG DEVICES INC AD4695 DRIVER
>  M:	Michael Hennerich <michael.hennerich@analog.com>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 60038ae8dfc4..5e601a87e5f3 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -139,6 +139,18 @@ config AD4170_4
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad4170-4.
>  
> +config AD4691
> +	tristate "Analog Devices AD4691 Family ADC Driver"
> +	depends on SPI
> +	depends on REGULATOR || COMPILE_TEST
> +	select REGMAP
> +	help
> +	  Say yes here to build support for Analog Devices AD4691 Family MuxSAR
> +	  SPI analog to digital converters (ADC).
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ad4691.
> +
>  config AD4695
>  	tristate "Analog Device AD4695 ADC Driver"
>  	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index c76550415ff1..4ac1ea09d773 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_AD4080) += ad4080.o
>  obj-$(CONFIG_AD4130) += ad4130.o
>  obj-$(CONFIG_AD4134) += ad4134.o
>  obj-$(CONFIG_AD4170_4) += ad4170-4.o
> +obj-$(CONFIG_AD4691) += ad4691.o
>  obj-$(CONFIG_AD4695) += ad4695.o
>  obj-$(CONFIG_AD4851) += ad4851.o
>  obj-$(CONFIG_AD7091R) += ad7091r-base.o
> diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
> new file mode 100644
> index 000000000000..ba77e1bfef16
> --- /dev/null
> +++ b/drivers/iio/adc/ad4691.c
> @@ -0,0 +1,756 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024-2026 Analog Devices, Inc.
> + * Author: Radu Sabau <radu.sabau@analog.com>
> + */
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/device/devres.h>
> +#include <linux/err.h>
> +#include <linux/limits.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
> +#include <linux/spi/spi.h>
> +#include <linux/units.h>
> +#include <linux/unaligned.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define AD4691_VREF_uV_MIN			2400000
> +#define AD4691_VREF_uV_MAX			5250000
> +#define AD4691_VREF_2P5_uV_MAX			2750000
> +#define AD4691_VREF_3P0_uV_MAX			3250000
> +#define AD4691_VREF_3P3_uV_MAX			3750000
> +#define AD4691_VREF_4P096_uV_MAX		4500000
> +
> +#define AD4691_SPI_CONFIG_A_REG			0x000
> +#define AD4691_SW_RESET				(BIT(7) | BIT(0))
> +
> +#define AD4691_STATUS_REG			0x014
> +#define AD4691_CLAMP_STATUS1_REG		0x01A
> +#define AD4691_CLAMP_STATUS2_REG		0x01B
> +#define AD4691_DEVICE_SETUP			0x020
> +#define AD4691_LDO_EN				BIT(4)
> +#define AD4691_REF_CTRL				0x021
> +#define AD4691_REF_CTRL_MASK			GENMASK(4, 2)
> +#define AD4691_REFBUF_EN			BIT(0)
> +#define AD4691_OSC_FREQ_REG			0x023
> +#define AD4691_OSC_FREQ_MASK			GENMASK(3, 0)
> +#define AD4691_STD_SEQ_CONFIG			0x025
> +#define AD4691_SPARE_CONTROL			0x02A
> +
> +#define AD4691_OSC_EN_REG			0x180
> +#define AD4691_STATE_RESET_REG			0x181
> +#define AD4691_STATE_RESET_ALL			0x01
> +#define AD4691_ADC_SETUP			0x182
> +#define AD4691_ADC_MODE_MASK			GENMASK(1, 0)
> +#define AD4691_AUTONOMOUS_MODE			0x02
> +/*
> + * ACC_MASK_REG covers both mask bytes via ADDR_DESCENDING SPI: writing a
> + * 16-bit BE value to 0x185 auto-decrements to 0x184 for the second byte.
> + */
> +#define AD4691_ACC_MASK_REG			0x185
> +#define AD4691_ACC_DEPTH_IN(n)			(0x186 + (n))
> +#define AD4691_GPIO_MODE1_REG			0x196
> +#define AD4691_GPIO_MODE2_REG			0x197
> +#define AD4691_GPIO_READ			0x1A0
> +#define AD4691_ACC_STATUS_FULL1_REG		0x1B0
> +#define AD4691_ACC_STATUS_FULL2_REG		0x1B1
> +#define AD4691_ACC_STATUS_OVERRUN1_REG		0x1B2
> +#define AD4691_ACC_STATUS_OVERRUN2_REG		0x1B3
> +#define AD4691_ACC_STATUS_SAT1_REG		0x1B4
> +#define AD4691_ACC_STATUS_SAT2_REG		0x1BE
> +#define AD4691_ACC_SAT_OVR_REG(n)		(0x1C0 + (n))
> +#define AD4691_AVG_IN(n)			(0x201 + (2 * (n)))
> +#define AD4691_AVG_STS_IN(n)			(0x222 + (3 * (n)))
> +#define AD4691_ACC_IN(n)			(0x252 + (3 * (n)))
> +#define AD4691_ACC_STS_DATA(n)			(0x283 + (4 * (n)))
> +
> +static const char * const ad4691_supplies[] = { "avdd", "vio" };
> +
> +enum ad4691_ref_ctrl {
> +	AD4691_VREF_2P5   = 0,
> +	AD4691_VREF_3P0   = 1,
> +	AD4691_VREF_3P3   = 2,
> +	AD4691_VREF_4P096 = 3,
> +	AD4691_VREF_5P0   = 4,

nit: when I see explicit values, I expect a gap or something odd.
When don't find any, I wasted my time reading what are the default
implicit values anyway.

> +};
> +
> +struct ad4691_channel_info {
> +	const struct iio_chan_spec *channels __counted_by_ptr(num_channels);
> +	unsigned int num_channels;
> +};
> +
> +struct ad4691_chip_info {
> +	const char *name;
> +	unsigned int max_rate;
> +	const struct ad4691_channel_info *sw_info;
> +};
> +
> +#define AD4691_CHANNEL(ch)						\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)		\
> +				    | BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +		.info_mask_separate_available =				\
> +				      BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.channel = ch,						\
> +		.scan_index = ch,					\
> +		.scan_type = {						\
> +			.sign = 'u',					\

FYI, this has a new name now, .format.

> +			.realbits = 16,					\
> +			.storagebits = 16,				\
> +		},							\
> +	}
> +
> +static const struct iio_chan_spec ad4691_channels[] = {
> +	AD4691_CHANNEL(0),
> +	AD4691_CHANNEL(1),
> +	AD4691_CHANNEL(2),
> +	AD4691_CHANNEL(3),
> +	AD4691_CHANNEL(4),
> +	AD4691_CHANNEL(5),
> +	AD4691_CHANNEL(6),
> +	AD4691_CHANNEL(7),
> +	AD4691_CHANNEL(8),
> +	AD4691_CHANNEL(9),
> +	AD4691_CHANNEL(10),
> +	AD4691_CHANNEL(11),
> +	AD4691_CHANNEL(12),
> +	AD4691_CHANNEL(13),
> +	AD4691_CHANNEL(14),
> +	AD4691_CHANNEL(15),
> +};
> +
> +static const struct iio_chan_spec ad4693_channels[] = {
> +	AD4691_CHANNEL(0),
> +	AD4691_CHANNEL(1),
> +	AD4691_CHANNEL(2),
> +	AD4691_CHANNEL(3),
> +	AD4691_CHANNEL(4),
> +	AD4691_CHANNEL(5),
> +	AD4691_CHANNEL(6),
> +	AD4691_CHANNEL(7),
> +};
> +
> +/*
> + * Internal oscillator frequency table. Index is the OSC_FREQ_REG[3:0] value.
> + * Index 0 (1 MHz) is only valid for AD4692/AD4694; AD4691/AD4693 support
> + * up to 500 kHz and use index 1 as their highest valid rate.
> + */
> +static const int ad4691_osc_freqs_Hz[] = {
> +	[0x0] = 1000000,
> +	[0x1] = 500000,
> +	[0x2] = 400000,
> +	[0x3] = 250000,
> +	[0x4] = 200000,
> +	[0x5] = 167000,
> +	[0x6] = 133000,
> +	[0x7] = 125000,
> +	[0x8] = 100000,
> +	[0x9] = 50000,
> +	[0xA] = 25000,
> +	[0xB] = 12500,
> +	[0xC] = 10000,
> +	[0xD] = 5000,
> +	[0xE] = 2500,
> +	[0xF] = 1250,
> +};
> +
> +static const struct ad4691_channel_info ad4691_sw_info = {
> +	.channels = ad4691_channels,
> +	.num_channels = ARRAY_SIZE(ad4691_channels),
> +};
> +
> +static const struct ad4691_channel_info ad4693_sw_info = {
> +	.channels = ad4693_channels,
> +	.num_channels = ARRAY_SIZE(ad4693_channels),
> +};
> +
> +static const struct ad4691_chip_info ad4691_chip_info = {
> +	.name = "ad4691",
> +	.max_rate = 500 * HZ_PER_KHZ,
> +	.sw_info = &ad4691_sw_info,
> +};
> +
> +static const struct ad4691_chip_info ad4692_chip_info = {
> +	.name = "ad4692",
> +	.max_rate = 1 * HZ_PER_MHZ,
> +	.sw_info = &ad4691_sw_info,
> +};
> +
> +static const struct ad4691_chip_info ad4693_chip_info = {
> +	.name = "ad4693",
> +	.max_rate = 500 * HZ_PER_KHZ,
> +	.sw_info = &ad4693_sw_info,
> +};
> +
> +static const struct ad4691_chip_info ad4694_chip_info = {
> +	.name = "ad4694",
> +	.max_rate = 1 * HZ_PER_MHZ,
> +	.sw_info = &ad4693_sw_info,
> +};
> +
> +struct ad4691_state {
> +	const struct ad4691_chip_info *info;
> +	struct regmap *regmap;
> +	int vref_uV;
> +	bool refbuf_en;
> +	bool ldo_en;
> +	/*
> +	 * Synchronize access to members of the driver state, and ensure
> +	 * atomicity of consecutive SPI operations.
> +	 */
> +	struct mutex lock;
> +};
> +
> +static int ad4691_reg_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct spi_device *spi = context;
> +	u8 tx[2], rx[4];
> +	int ret;
> +
> +	/* Set bit 15 to mark the operation as READ. */

Can't we just set read_flag_mask in the regmap config?

> +	put_unaligned_be16(0x8000 | reg, tx);
> +
> +	switch (reg) {
> +	case 0 ... AD4691_OSC_FREQ_REG:
> +	case AD4691_SPARE_CONTROL ... AD4691_ACC_MASK_REG - 1:
> +	case AD4691_ACC_MASK_REG + 1 ... AD4691_ACC_SAT_OVR_REG(15):
> +		ret = spi_write_then_read(spi, tx, sizeof(tx), rx, 1);
> +		if (ret)
> +			return ret;
> +		*val = rx[0];
> +		return 0;
> +	case AD4691_ACC_MASK_REG:
> +	case AD4691_STD_SEQ_CONFIG:
> +	case AD4691_AVG_IN(0) ... AD4691_AVG_IN(15):
> +		ret = spi_write_then_read(spi, tx, sizeof(tx), rx, 2);
> +		if (ret)
> +			return ret;
> +		*val = get_unaligned_be16(rx);
> +		return 0;
> +	case AD4691_AVG_STS_IN(0) ... AD4691_AVG_STS_IN(15):
> +	case AD4691_ACC_IN(0) ... AD4691_ACC_IN(15):
> +		ret = spi_write_then_read(spi, tx, sizeof(tx), rx, 3);
> +		if (ret)
> +			return ret;
> +		*val = get_unaligned_be24(rx);
> +		return 0;
> +	case AD4691_ACC_STS_DATA(0) ... AD4691_ACC_STS_DATA(15):
> +		ret = spi_write_then_read(spi, tx, sizeof(tx), rx, 4);
> +		if (ret)
> +			return ret;
> +		*val = get_unaligned_be32(rx);
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4691_reg_write(void *context, unsigned int reg, unsigned int val)
> +{
> +	struct spi_device *spi = context;
> +	u8 tx[4];
> +
> +	put_unaligned_be16(reg, tx);
> +
> +	switch (reg) {
> +	case 0 ... AD4691_OSC_FREQ_REG:
> +	case AD4691_SPARE_CONTROL ... AD4691_ACC_MASK_REG - 1:
> +	case AD4691_ACC_MASK_REG + 1 ... AD4691_GPIO_MODE2_REG:
> +		if (val > U8_MAX)
> +			return -EINVAL;
> +		tx[2] = val;
> +		return spi_write_then_read(spi, tx, 3, NULL, 0);
> +	case AD4691_ACC_MASK_REG:
> +	case AD4691_STD_SEQ_CONFIG:
> +		if (val > U16_MAX)
> +			return -EINVAL;
> +		put_unaligned_be16(val, &tx[2]);
> +		return spi_write_then_read(spi, tx, 4, NULL, 0);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static bool ad4691_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case AD4691_STATUS_REG:
> +	case AD4691_CLAMP_STATUS1_REG:
> +	case AD4691_CLAMP_STATUS2_REG:
> +	case AD4691_GPIO_READ:
> +	case AD4691_ACC_STATUS_FULL1_REG ... AD4691_ACC_STATUS_SAT2_REG:
> +	case AD4691_ACC_SAT_OVR_REG(0) ... AD4691_ACC_SAT_OVR_REG(15):
> +		return true;
> +	default:
> +		break;
> +	}
> +
> +	/*
> +	 * Multi-byte registers have non-unit strides; only accept base
> +	 * addresses to prevent debugfs from triggering reads that cross
> +	 * register boundaries.
> +	 */
> +	if (reg >= AD4691_AVG_IN(0) && reg <= AD4691_AVG_IN(15))
> +		return (reg - AD4691_AVG_IN(0)) % 2 == 0;
> +	if (reg >= AD4691_AVG_STS_IN(0) && reg <= AD4691_AVG_STS_IN(15))
> +		return (reg - AD4691_AVG_STS_IN(0)) % 3 == 0;
> +	if (reg >= AD4691_ACC_IN(0) && reg <= AD4691_ACC_IN(15))
> +		return (reg - AD4691_ACC_IN(0)) % 3 == 0;
> +	if (reg >= AD4691_ACC_STS_DATA(0) && reg <= AD4691_ACC_STS_DATA(15))
> +		return (reg - AD4691_ACC_STS_DATA(0)) % 4 == 0;
> +
> +	return false;
> +}
> +
> +static bool ad4691_readable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case 0 ... AD4691_OSC_FREQ_REG:
> +	case AD4691_SPARE_CONTROL ... AD4691_ACC_SAT_OVR_REG(15):
> +	case AD4691_STD_SEQ_CONFIG:
> +		return true;
> +	default:
> +		break;
> +	}
> +
> +	/* Multi-byte registers: only accept base addresses (see volatile_reg). */
> +	if (reg >= AD4691_AVG_IN(0) && reg <= AD4691_AVG_IN(15))
> +		return (reg - AD4691_AVG_IN(0)) % 2 == 0;
> +	if (reg >= AD4691_AVG_STS_IN(0) && reg <= AD4691_AVG_STS_IN(15))
> +		return (reg - AD4691_AVG_STS_IN(0)) % 3 == 0;
> +	if (reg >= AD4691_ACC_IN(0) && reg <= AD4691_ACC_IN(15))
> +		return (reg - AD4691_ACC_IN(0)) % 3 == 0;
> +	if (reg >= AD4691_ACC_STS_DATA(0) && reg <= AD4691_ACC_STS_DATA(15))
> +		return (reg - AD4691_ACC_STS_DATA(0)) % 4 == 0;
> +
> +	return false;
> +}
> +
> +static bool ad4691_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case 0 ... AD4691_OSC_FREQ_REG:
> +	case AD4691_STD_SEQ_CONFIG:
> +	case AD4691_SPARE_CONTROL ... AD4691_GPIO_MODE2_REG:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config ad4691_regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 32,
> +	.reg_read = ad4691_reg_read,
> +	.reg_write = ad4691_reg_write,
> +	.volatile_reg = ad4691_volatile_reg,
> +	.readable_reg = ad4691_readable_reg,
> +	.writeable_reg = ad4691_writeable_reg,
> +	.max_register = AD4691_ACC_STS_DATA(15),
> +	.cache_type = REGCACHE_MAPLE,
> +};
> +
> +/*
> + * Index 0 in ad4691_osc_freqs_Hz is 1 MHz — valid only for AD4692/AD4694
> + * (max_rate == 1 MHz). AD4691/AD4693 cap at 500 kHz so their valid range
> + * starts at index 1.
> + */
> +static unsigned int ad4691_samp_freq_start(const struct ad4691_chip_info *info)
> +{
> +	return (info->max_rate == 1 * HZ_PER_MHZ) ? 0 : 1;
> +}
> +
> +static int ad4691_get_sampling_freq(struct ad4691_state *st, int *val)
> +{
> +	unsigned int reg_val;
> +	int ret;
> +

No mutex lock here? Maybe without OK since it is a read.

> +	/*
> +	 * AD4691_OSC_FREQ_REG is non-volatile and written during
> +	 * ad4691_config(), so regmap returns the cached value here without
> +	 * touching the SPI bus. No lock is needed.
> +	 */
> +	ret = regmap_read(st->regmap, AD4691_OSC_FREQ_REG, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	*val = ad4691_osc_freqs_Hz[FIELD_GET(AD4691_OSC_FREQ_MASK, reg_val)];
> +	return IIO_VAL_INT;
> +}
> +
> +static int ad4691_set_sampling_freq(struct iio_dev *indio_dev, int freq)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	unsigned int start = ad4691_samp_freq_start(st->info);
> +
> +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> +		return -EBUSY;
> +
> +	for (unsigned int i = start; i < ARRAY_SIZE(ad4691_osc_freqs_Hz); i++) {
> +		if (ad4691_osc_freqs_Hz[i] != freq)
> +			continue;

mutex lock?

> +		return regmap_update_bits(st->regmap, AD4691_OSC_FREQ_REG,
> +					  AD4691_OSC_FREQ_MASK, i);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ad4691_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type,
> +			     int *length, long mask)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	unsigned int start = ad4691_samp_freq_start(st->info);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = &ad4691_osc_freqs_Hz[start];
> +		*type = IIO_VAL_INT;
> +		*length = ARRAY_SIZE(ad4691_osc_freqs_Hz) - start;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4691_single_shot_read(struct iio_dev *indio_dev,
> +				   struct iio_chan_spec const *chan, int *val)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	unsigned int reg_val, osc_idx, period_us;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	/* Use AUTONOMOUS mode for single-shot reads. */
> +	ret = regmap_write(st->regmap, AD4691_STATE_RESET_REG,
> +			   AD4691_STATE_RESET_ALL);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
> +			   BIT(chan->channel));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG,
> +			   ~BIT(chan->channel) & GENMASK(15, 0));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD4691_OSC_FREQ_REG, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4691_OSC_EN_REG, 1);
> +	if (ret)
> +		return ret;
> +
> +	osc_idx = FIELD_GET(AD4691_OSC_FREQ_MASK, reg_val);
> +	/* Wait 2 oscillator periods for the conversion to complete. */
> +	period_us = DIV_ROUND_UP(2UL * USEC_PER_SEC, ad4691_osc_freqs_Hz[osc_idx]);
> +	fsleep(period_us);
> +
> +	ret = regmap_write(st->regmap, AD4691_OSC_EN_REG, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD4691_AVG_IN(chan->channel), &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	*val = reg_val;
> +
> +	ret = regmap_write(st->regmap, AD4691_STATE_RESET_REG, AD4691_STATE_RESET_ALL);
> +	if (ret)
> +		return ret;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int ad4691_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long info)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW: {
> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		return ad4691_single_shot_read(indio_dev, chan, val);
> +	}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad4691_get_sampling_freq(st, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->vref_uV / (MICRO / MILLI);
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4691_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:

Should we aquire direct mode so that we can't change the rate during
buffered read?

> +		return ad4691_set_sampling_freq(indio_dev, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4691_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +			     unsigned int writeval, unsigned int *readval)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +
> +	guard(mutex)(&st->lock);
> +
> +	if (readval)
> +		return regmap_read(st->regmap, reg, readval);
> +
> +	return regmap_write(st->regmap, reg, writeval);
> +}
> +
> +static const struct iio_info ad4691_info = {
> +	.read_raw = &ad4691_read_raw,
> +	.write_raw = &ad4691_write_raw,
> +	.read_avail = &ad4691_read_avail,
> +	.debugfs_reg_access = &ad4691_reg_access,
> +};
> +
> +static int ad4691_regulator_setup(struct ad4691_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	int ret;
> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad4691_supplies),
> +					     ad4691_supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get and enable supplies\n");
> +
> +	/*
> +	 * vdd-supply and ldo-in-supply are mutually exclusive:
> +	 *   vdd-supply present  → external 1.8V VDD; disable internal LDO.
> +	 *   vdd-supply absent   → enable internal LDO fed from ldo-in-supply.
> +	 * Having both simultaneously is strongly inadvisable per the datasheet.
> +	 */
> +	ret = devm_regulator_get_enable_optional(dev, "vdd");
> +	if (ret == -ENODEV) {

After some recent discussions, we've been leaning towards using
if (device_property_present(dev, "vdd-supply") instead of handling
-ENODEV.

I think it reads more nicely in a linear way here:

	if (device_property_present(dev, "vdd-supply") {
		/* do stuff with vdd supply */
	} else if device_property_present(dev, "ldo-in-supply") {
		/* do stuff with ldo-in supply */
	} else {
		return dev_err_probe(dev, -EINVAL, "missing one of vdd-supply, ldo-in-supply\n");
	}

> +		ret = devm_regulator_get_enable(dev, "ldo-in");
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to get and enable LDO-IN\n");
> +		st->ldo_en = true;
> +	} else if (ret) {
> +		return dev_err_probe(dev, ret, "Failed to get and enable VDD\n");
> +	}
> +
> +	st->vref_uV = devm_regulator_get_enable_read_voltage(dev, "ref");
> +	if (st->vref_uV == -ENODEV) {

similar with ref-supply and refin-supply

> +		st->vref_uV = devm_regulator_get_enable_read_voltage(dev, "refin");
> +		st->refbuf_en = true;
> +	}
> +	if (st->vref_uV < 0)
> +		return dev_err_probe(dev, st->vref_uV,
> +				     "Failed to get reference supply\n");
> +
> +	if (st->vref_uV < AD4691_VREF_uV_MIN || st->vref_uV > AD4691_VREF_uV_MAX)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "vref(%d) must be in the range [%u...%u]\n",
> +				     st->vref_uV, AD4691_VREF_uV_MIN,
> +				     AD4691_VREF_uV_MAX);
> +
> +	return 0;
> +}
> +
> +static int ad4691_reset(struct ad4691_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	struct reset_control *rst;
> +
> +	rst = devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(rst))
> +		return dev_err_probe(dev, PTR_ERR(rst), "Failed to get reset\n");
> +
> +	if (rst) {
> +		/*
> +		 * Assert the reset line before sleeping to guarantee a proper
> +		 * reset pulse on every probe, including driver reloads where
> +		 * the line may already be deasserted (reset_control_put() does
> +		 * not re-assert on release).
> +		 * devm_reset_control_get_optional_exclusive_deasserted() cannot
> +		 * be used because it deasserts immediately without delay; the
> +		 * datasheet (Table 5) requires a ≥300 µs reset pulse width
> +		 * before deassertion.
> +		 */
> +		reset_control_assert(rst);
> +		fsleep(300);
> +		return reset_control_deassert(rst);
> +	}
> +
> +	/* No hardware reset available, fall back to software reset. */
> +	return regmap_write(st->regmap, AD4691_SPI_CONFIG_A_REG,
> +			    AD4691_SW_RESET);
> +}
> +
> +static int ad4691_config(struct ad4691_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	enum ad4691_ref_ctrl ref_val;
> +	unsigned int val;
> +	int ret;
> +
> +	switch (st->vref_uV) {
> +	case AD4691_VREF_uV_MIN ... AD4691_VREF_2P5_uV_MAX:
> +		ref_val = AD4691_VREF_2P5;
> +		break;
> +	case AD4691_VREF_2P5_uV_MAX + 1 ... AD4691_VREF_3P0_uV_MAX:
> +		ref_val = AD4691_VREF_3P0;
> +		break;
> +	case AD4691_VREF_3P0_uV_MAX + 1 ... AD4691_VREF_3P3_uV_MAX:
> +		ref_val = AD4691_VREF_3P3;
> +		break;
> +	case AD4691_VREF_3P3_uV_MAX + 1 ... AD4691_VREF_4P096_uV_MAX:
> +		ref_val = AD4691_VREF_4P096;
> +		break;
> +	case AD4691_VREF_4P096_uV_MAX + 1 ... AD4691_VREF_uV_MAX:
> +		ref_val = AD4691_VREF_5P0;
> +		break;
> +	default:
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Unsupported vref voltage: %d uV\n",
> +				     st->vref_uV);
> +	}
> +
> +	val = FIELD_PREP(AD4691_REF_CTRL_MASK, ref_val);
> +	if (st->refbuf_en)
> +		val |= AD4691_REFBUF_EN;
> +
> +	ret = regmap_write(st->regmap, AD4691_REF_CTRL, val);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write REF_CTRL\n");
> +
> +	ret = regmap_assign_bits(st->regmap, AD4691_DEVICE_SETUP,
> +				 AD4691_LDO_EN, st->ldo_en);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write DEVICE_SETUP\n");
> +
> +	/*
> +	 * Set the internal oscillator to the highest rate this chip supports.
> +	 * Index 0 (1 MHz) exceeds the 500 kHz max of AD4691/AD4693, so those
> +	 * chips start at index 1 (500 kHz).
> +	 */
> +	ret = regmap_write(st->regmap, AD4691_OSC_FREQ_REG,
> +			   ad4691_samp_freq_start(st->info));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write OSC_FREQ\n");
> +
> +	ret = regmap_update_bits(st->regmap, AD4691_ADC_SETUP,
> +				 AD4691_ADC_MODE_MASK, AD4691_AUTONOMOUS_MODE);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write ADC_SETUP\n");
> +
> +	return 0;
> +}
> +
> +static int ad4691_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad4691_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->info = spi_get_device_match_data(spi);
> +	if (!st->info)
> +		return -ENODEV;

We've recently standardized on not checking return value
of spi_get_device_match_data().

> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	st->regmap = devm_regmap_init(dev, NULL, spi, &ad4691_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "Failed to initialize regmap\n");
> +
> +	ret = ad4691_regulator_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4691_reset(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4691_config(st);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = st->info->name;
> +	indio_dev->info = &ad4691_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	indio_dev->channels = st->info->sw_info->channels;
> +	indio_dev->num_channels = st->info->sw_info->num_channels;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id ad4691_of_match[] = {
> +	{ .compatible = "adi,ad4691", .data = &ad4691_chip_info },
> +	{ .compatible = "adi,ad4692", .data = &ad4692_chip_info },
> +	{ .compatible = "adi,ad4693", .data = &ad4693_chip_info },
> +	{ .compatible = "adi,ad4694", .data = &ad4694_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad4691_of_match);
> +
> +static const struct spi_device_id ad4691_id[] = {
> +	{ "ad4691", (kernel_ulong_t)&ad4691_chip_info },
> +	{ "ad4692", (kernel_ulong_t)&ad4692_chip_info },
> +	{ "ad4693", (kernel_ulong_t)&ad4693_chip_info },
> +	{ "ad4694", (kernel_ulong_t)&ad4694_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ad4691_id);
> +
> +static struct spi_driver ad4691_driver = {
> +	.driver = {
> +		.name = "ad4691",
> +		.of_match_table = ad4691_of_match,
> +	},
> +	.probe = ad4691_probe,
> +	.id_table = ad4691_id,
> +};
> +module_spi_driver(ad4691_driver);
> +
> +MODULE_AUTHOR("Radu Sabau <radu.sabau@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD4691 Family ADC Driver");
> +MODULE_LICENSE("GPL");
> 

