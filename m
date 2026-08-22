Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BE43EFFD7
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787419818; cv=none; b=MDAaKViYrGaCufDwbpd4CBZn7dJy0DgbyaBOrh+F+gfni3jn4kBRL7VhUO/8fspiEXbni5l1xZPBFTsuLoCiSctl8dhe00xHG+YU1YU5fudYufGsYY5EbCOyYqp22V24xnDBLimfvWEuqiBaIJ1Mik/0QILFq74UygTnugj8oGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787419818; c=relaxed/simple;
	bh=LrPkDgPwAg03GY6vuI/OZRBsk6ZXgSt63XDC6R6nDIo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JchID6JvKun9u3DUOmpq9gINIH1PahkQp2laV7aGXze8FhmtMyiO5IVug+eXtmH7l2iJw/Y6ixoWu/aXkqxRJzXHghjgXHIkFsjKCzHlgZo5IPaYn/z2Ws59QE3ZjYHPyyMJ4PlTdoRMlFX8vnEJYYFh2uS9L5fO4Nxbqxsf6ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=nzwrRjSE; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="nzwrRjSE"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4a475409044so1041507b6e.1
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 10:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787419809; x=1788024609; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0mlLoNQAh3NAtRrNYPhY0/IR/oTGbQizKawvZm0fdPQ=;
        b=nzwrRjSE41BAwAph6uyCyIix7BKKFkiVhRVzJjkqOxNtq8I0MHeDnKhSComfYT4287
         dWFWRwPBPlKMBYvy9YWV9xI+OceWFYjaCr+FUu47gCJX0QesHlnwx4CkzXHaAaSiQNIq
         WePgixUmNl7jzj7rH1YshcRMTFzHVtz8Dkqhn6FKapYc6P2vGMkfP+z9HpwjhmYZM3RC
         MzjN2P3EKwgYxMjHkIunkeK2mqk2Nj6lupV3ylDosu8PhcTjKtoHMrZeD8GFEh6DPx94
         glvbHoHjoLfPoulwhVabrcutk3DtRGWzpf2QVsGc/4alnmOwLojNhRHwjH7fs3oRZSHQ
         n/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787419809; x=1788024609;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0mlLoNQAh3NAtRrNYPhY0/IR/oTGbQizKawvZm0fdPQ=;
        b=VgOTzzZ+i/gRtglTjPG6KMI8pTKMSn1dnkoE2rMbumUvZHprBomS23v0DUkfT5URJo
         IyiXk1V+guWI18YBz/WdWA5X0gE9FnQJpb1mSzNGeJpYqiDMKDuBNePkPWP81ls9H+D4
         yPD+4zPtCvva0iva3imutZJa460aqR/t9csQTemfU4og325Yy7Q3ta6CFXz2gjbRrecn
         WZCi4qdr0aLnrolp7JDW8mBDLe2Q2guyVlJYoU0W5b6u24S7qrmLcYHpegpwgG6hopHT
         WZp+82bjBIdIqNyp/Gk2/6yY+shDbaOk5DCVLIOhsigloMvv+psdh5zA75yleUMU/XKL
         mMDA==
X-Forwarded-Encrypted: i=1; AHgh+RoHqKuRAg1MqS/fHd/hfwGEOM7ky91rIXUxQgfvrLpM5fpTakEnyMH9waBNT67HL45U/VkIkuonaUw=@vger.kernel.org
X-Gm-Message-State: AFuF++nbBKBjjVeXb2EY1cCVnB+3vugqkizeNltNXLi9KtYSIHHSe6Nf
	GPScvJkWT95CdBuXNnEoSiSNDXrqIXhkRJsuA6GqJQoudIba/3BCkXPeCM2AIR5+nDQ=
X-Gm-Gg: AR+sD13CrZYFefjfqIw5CTr44u7WgA0QWKik1AKeCvD7RX5WaPvQcEaP0f1Ll88gh+3
	7nTxXMGj3nhUS6E0zXFK2rdDw/A6LDAlW9F6aRlX4U02eJDTpB13QZsczXdXF5q+nxBL7MkUt6c
	1QNzTJQQ4o0clgPlAhZGgGnIeyYGixaX4YuxaPy4lDauXV26Zp/j0to/lbUJKBqqeC+kC6yJ3B0
	iqstQVM2QuFDre5IeQEIqp5J1wZyZxT2iYUPaz4kwhaUi97vkyKDmjUfvuyGHwOf0FQzzjWixzS
	1FmAUzmJ30Sj4SLy32QevswnIZVIKZKYYIEBWapfuBVU6PmSHeRjBUJQ0mFrfUm5sa04H4zW5Pp
	/JwJLK4ZK3lQx/7wOz/VI+B6nNNmo34iRBUlDWuNtzgtvvaBQMVzHBj6SHZgsL+HOBS1Dyx5rQ6
	j6f09dXGcFNclVDS1kVCYp1z70Uf8bOQcXrnvtvP+FxPHRiBhhNYRp8cSfP/vMEZ464d3eM1k+t
	TD6euI9IfeMIRZ1mADHwRI5Z4mIbngUkXveT4s=
X-Received: by 2002:a05:6808:bd3:b0:495:e16d:5d03 with SMTP id 5614622812f47-4b309ca1450mr7517424b6e.21.1787419808924;
        Sat, 22 Aug 2026 10:30:08 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e0ca:316a:4629:d835? ([2600:8803:e7e4:500:e0ca:316a:4629:d835])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2d68769e1sm7807505b6e.8.2026.08.22.10.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 10:30:08 -0700 (PDT)
Message-ID: <10d575af-2a2c-484b-82b0-0a00de1c50be@baylibre.com>
Date: Sat, 22 Aug 2026 12:30:05 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v4 05/14] iio: adc: Add AD7768 and AD7768-4 core support
To: Janani Sunil <janani.sunil@analog.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>
Cc: linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org, jananisunil.dev@gmail.com,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
 <20260821-ad7768-driver-v4-5-bb8fbd06d4eb@analog.com>
Content-Language: en-US
In-Reply-To: <20260821-ad7768-driver-v4-5-bb8fbd06d4eb@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/21/26 9:06 AM, Janani Sunil wrote:
> Add core support for the AD7768 and AD7768-4 simultaneous sampling ADCs.
> Configure supplies, clock and reset, use a custom regmap bus for the SPI
> protocol, and parse the enabled channels and input buffer settings from
> devicetree.
> 
> Connect the converter to an IIO backend for buffered capture with CRC,
> provide a fixed safe wideband sampling configuration and add runtime
> power management.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
>  MAINTAINERS              |   1 +
>  drivers/iio/adc/Kconfig  |  14 +
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/ad7768.c | 920 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 936 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d667a0411f28..dc94e7803a7c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1639,6 +1639,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml
> +F:	drivers/iio/adc/ad7768.c
>  
>  ANALOG DEVICES INC AD7780 DRIVER
>  M:	Michael Hennerich <Michael.Hennerich@analog.com>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index d1b198cb8a80..48bb108382b5 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -429,6 +429,20 @@ config AD7766
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad7766.
>  
> +config AD7768
> +	tristate "Analog Devices AD7768/AD7768-4 ADC driver"
> +	depends on SPI
> +	depends on REGULATOR || COMPILE_TEST
> +	select IIO_BUFFER
> +	select IIO_BACKEND
> +	select REGMAP
> +	help
> +	  Say yes here to build support for Analog Devices AD7768 and AD7768-4
> +	  SPI analog to digital converters.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ad7768.
> +
>  config AD7768_1
>  	tristate "Analog Devices AD7768-1 ADC driver"
>  	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 0f90b75577ff..3e896c8aa7c3 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -39,6 +39,7 @@ obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
>  obj-$(CONFIG_AD7606) += ad7606.o
>  obj-$(CONFIG_AD7625) += ad7625.o
>  obj-$(CONFIG_AD7766) += ad7766.o
> +obj-$(CONFIG_AD7768) += ad7768.o
>  obj-$(CONFIG_AD7768_1) += ad7768-1.o
>  obj-$(CONFIG_AD7779) += ad7779.o
>  obj-$(CONFIG_AD7780) += ad7780.o
> diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
> new file mode 100644
> index 000000000000..34233ad6cfca
> --- /dev/null
> +++ b/drivers/iio/adc/ad7768.c
> @@ -0,0 +1,920 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Analog Devices AD7768 ADC driver
> + *
> + * Copyright 2018-2026 Analog Devices Inc.
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/cleanup.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/math.h>
> +#include <linux/minmax.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +
> +#include <linux/iio/backend.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +

I think we can add one more tab to the right-hand column without getting too
long. Should help with the longer names.

> +#define AD7768_REG_CH_STANDBY			0x00
> +
> +#define AD7768_REG_CH_MODE(x)			(0x01 + (x))
> +#define   AD7768_CH_MODE_FILTER_TYPE_MSK	BIT(3)
> +#define     AD7768_CH_MODE_FILTER_TYPE_WIDEBAND	0x0
> +#define   AD7768_CH_MODE_DEC_RATE_MSK		GENMASK(2, 0)
> +#define     AD7768_CH_MODE_DEC_RATE_64		0x1
> +
> +#define AD7768_REG_CH_MODE_SEL			0x03
> +
> +#define AD7768_REG_POWER_MODE			0x04
> +#define   AD7768_SLEEP_MODE_MSK			BIT(7)
> +#define   AD7768_POWER_MODE_POWER_MODE_MSK	GENMASK(5, 4)
> +#define     AD7768_POWER_MODE_POWER_MODE_LOW	0x0
> +#define     AD7768_POWER_MODE_POWER_MODE_MEDIAN	0x2
> +#define     AD7768_POWER_MODE_POWER_MODE_FAST	0x3
> +#define   AD7768_POWER_MODE_LVDS_ENABLE		BIT(3)
> +#define   AD7768_POWER_MODE_MCLK_DIV_MSK	GENMASK(1, 0)
> +
> +#define AD7768_REG_GENERAL_CONFIG		0x05
> +
> +#define AD7768_REG_DATA_CONTROL			0x06
> +#define   AD7768_DATA_CONTROL_SPI_RESET_1	0x03
> +#define   AD7768_DATA_CONTROL_SPI_RESET_2	0x02
> +#define   AD7768_DATA_CONTROL_SPI_SYNC		BIT(7)
> +
> +#define AD7768_REG_INTERFACE_CFG		0x07
> +#define   AD7768_INTERFACE_CFG_CRC_SELECT_MSK	GENMASK(3, 2)
> +/*
> + * Hardware supports CRC every 4 or 16 samples; the backend supports only
> + * 4-sample CRC.

This comment might be better placed where we actually use the macro.

> + */
> +#define     AD7768_INTERFACE_CFG_CRC_SELECT_4	0x1
> +#define   AD7768_INTERFACE_CFG_DCLK_DIV_MSK	GENMASK(1, 0)
> +#define     AD7768_INTERFACE_CFG_DCLK_DIV(x)	(4 - ffs(x))
> +
> +#define AD7768_REG_REV_ID			0x0A
> +#define   AD7768_REV_ID_VAL			0x06
> +
> +#define AD7768_REG_GPIO_CONTROL			0x0E
> +#define   AD7768_GPIO_UGPIO_ENABLE		BIT(7)
> +#define   AD7768_GPIO4_OUTPUT_ENABLE		BIT(4)
> +
> +#define AD7768_REG_GPIO_WRITE			0x0F
> +
> +#define AD7768_REG_PRECHARGE_BUF1		0x11
> +#define AD7768_REG_PRECHARGE_BUF2		0x12
> +#define   AD7768_PREBUF_POS_EN(ch)		BIT((ch) * 2)
> +#define   AD7768_PREBUF_NEG_EN(ch)		BIT(((ch) * 2) + 1)
> +
> +#define AD7768_REG_REFP_BUF			0x13
> +#define AD7768_REG_REFN_BUF			0x14
> +
> +#define AD7768_REG_OFFSET_BASE			0x1E
> +#define AD7768_REG_GAIN_BASE			0x36
> +#define AD7768_REG_PHASE_BASE			0x4E
> +#define AD7768_REG_OFFSET(ch) \
> +	(AD7768_REG_OFFSET_BASE + (3 * (ch)))
> +#define AD7768_REG_GAIN(ch) \
> +	(AD7768_REG_GAIN_BASE + (3 * (ch)))
> +#define AD7768_REG_PHASE(ch)			((AD7768_REG_PHASE_BASE + (ch)))
> +#define __AD7768_4_REG_MAP(ch)		((ch) < 2 ? (ch) : ((ch) + 2))
> +#define AD7768_4_REG_OFFSET(ch) \
> +	(AD7768_REG_OFFSET_BASE + (3 * __AD7768_4_REG_MAP(ch)))
> +#define AD7768_4_REG_GAIN(ch) \
> +	(AD7768_REG_GAIN_BASE + (3 * __AD7768_4_REG_MAP(ch)))
> +#define AD7768_4_REG_PHASE(ch) \
> +	(AD7768_REG_PHASE_BASE + __AD7768_4_REG_MAP(ch))
> +
> +#define AD7768_REG_DIAGNOSTIC_RX		0x56
> +
> +#define AD7768_REG_CHOP_CTRL			0x59
> +
> +#define AD7768_SPI_READ_CMD			BIT(15)
> +#define AD7768_SPI_REG_MASK			GENMASK(14, 8)
> +#define AD7768_SPI_DATA_MASK			GENMASK(7, 0)
> +
> +#define AD7768_SAMPLE_SIZE			32
> +#define AD7768_MAX_DCLK_DIV			8
> +#define AD7768_MAX_CHANNEL			8
> +
> +enum ad7768_clock_source {
> +	AD7768_CLOCK_SOURCE_MCLK,
> +	AD7768_CLOCK_SOURCE_XTAL,
> +	AD7768_CLOCK_SOURCE_LVDS,
> +};
> +
> +struct ad7768_precharge_config {
> +	bool prebufp_en;
> +	bool prebufn_en;
> +	bool refbufp;
> +	bool refbufn;
> +};
> +
> +struct ad7768_chip_info {
> +	const char *name;
> +	unsigned int num_channels;
> +	const struct regmap_config *regmap_config;
> +	const unsigned int *available_datalines;
> +	unsigned int num_datalines;
> +	const u8 *chan_map;
> +	u8 prebuf_split;
> +};
> +
> +struct ad7768_state {
> +	struct regmap *regmap;
> +	/* Protects device register access and configuration. */
> +	struct mutex lock;
> +	struct clk *mclk;
> +	unsigned int datalines;
> +	enum ad7768_clock_source clock_source;
> +	const struct ad7768_chip_info *chip_info;
> +	struct iio_backend *back;
> +
> +	__be16 d16 __aligned(IIO_DMA_MINALIGN);
> +};
> +
> +static const unsigned int ad7768_available_datalines[] = {
> +	1, 2, 8,
> +};
> +
> +static const unsigned int ad7768_4_available_datalines[] = {
> +	1, 4,
> +};
> +
> +static const u8 ad7768_chan_map[] = {
> +	0, 1, 2, 3, 4, 5, 6, 7,
> +};
> +
> +static const u8 ad7768_4_chan_map[] = {
> +	0, 1, 4, 5,
> +};
> +
> +static const char * const ad7768_supply_names[] = {
> +	"avdd2", "iovdd", "ref1p", "ref1n", "ref2p", "ref2n",
> +};
> +
> +static const char * const ad7768_clock_names[] = {
> +	[AD7768_CLOCK_SOURCE_MCLK] = "mclk",
> +	[AD7768_CLOCK_SOURCE_XTAL] = "xtal",
> +	[AD7768_CLOCK_SOURCE_LVDS] = "lvds",
> +};
> +
> +static u8 ad7768_channel_mask(const struct ad7768_state *st, u8 ch)
> +{
> +	return BIT(st->chip_info->chan_map[ch]);
> +}
> +
> +static u8 ad7768_all_standby_mask(const struct ad7768_state *st)
> +{
> +	return GENMASK(st->chip_info->num_channels - 1, 0);
> +}
> +
> +static u8 ad7768_precharge_buf1_mask(const struct ad7768_state *st, u16 val)
> +{
> +	return val & GENMASK(st->chip_info->prebuf_split - 1, 0);
> +}
> +
> +static u8 ad7768_precharge_buf2_mask(const struct ad7768_state *st, u16 val)
> +{
> +	return (val >> st->chip_info->prebuf_split) &
> +	       GENMASK(st->chip_info->prebuf_split - 1, 0);
> +}
> +
> +static int ad7768_regmap_read(void *context, const void *reg_buf,
> +			      size_t reg_size, void *val_buf, size_t val_size)
> +{
> +	struct ad7768_state *st = spi_get_drvdata(context);
> +	struct spi_device *spi = context;
> +	struct spi_transfer t[] = {
> +		{
> +			.tx_buf = &st->d16,
> +			.len = sizeof(st->d16),
> +			.cs_change = 1,
> +		}, {
> +			/*
> +			 * Register responses are delayed by one CS frame. While
> +			 * receiving the response to this read, the device also
> +			 * decodes another command on SDI. Repeat the read
> +			 * command to avoid sending an unspecified dummy
> +			 * command.

Could this have unintended concequences? E.g. register writes that have
size-effects, like reset or clearing status registers.

> +			 */
> +			.tx_buf = &st->d16,
> +			.rx_buf = &st->d16,
> +			.len = sizeof(st->d16),
> +		},
> +	};
> +	u8 *data_val = val_buf;
> +	unsigned int reg;
> +	int ret;
> +
> +	reg = *(const u8 *)reg_buf;
> +
> +	st->d16 = be16_replace_bits(cpu_to_be16(AD7768_SPI_READ_CMD), reg,
> +				    AD7768_SPI_REG_MASK);
> +
> +	ret = spi_sync_transfer(spi, t, ARRAY_SIZE(t));
> +	if (ret)
> +		return ret;
> +
> +	*data_val = be16_get_bits(st->d16, AD7768_SPI_DATA_MASK);
> +
> +	return 0;
> +}
> +
> +static int ad7768_regmap_write(void *context, const void *data, size_t count)
> +{
> +	struct spi_device *spi = context;
> +
> +	return spi_write(spi, data, count);
> +}
> +
> +static const struct regmap_bus ad7768_regmap_bus = {
> +	.read = ad7768_regmap_read,
> +	.write = ad7768_regmap_write,
> +	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
> +	.val_format_endian_default = REGMAP_ENDIAN_BIG,
> +};
> +
> +static bool ad7768_readable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case AD7768_REG_CH_STANDBY ... AD7768_REG_REV_ID:
> +	case AD7768_REG_GPIO_CONTROL ... AD7768_REG_REFN_BUF:
> +		return true;

Can drop this return.

> +	case AD7768_REG_OFFSET(0) ... AD7768_REG_OFFSET(7) + 2:
> +	case AD7768_REG_GAIN(0) ... AD7768_REG_GAIN(7) + 2:
> +	case AD7768_REG_PHASE(0) ... AD7768_REG_PHASE(7):
> +	case AD7768_REG_DIAGNOSTIC_RX ... AD7768_REG_CHOP_CTRL:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool ad7768_4_readable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case AD7768_REG_CH_STANDBY ... AD7768_REG_REV_ID:
> +	case AD7768_REG_GPIO_CONTROL ... AD7768_REG_REFN_BUF:
> +		return true;

Can drop this return.

> +	case AD7768_4_REG_OFFSET(0) ... AD7768_4_REG_OFFSET(1) + 2:
> +	case AD7768_4_REG_OFFSET(2) ... AD7768_4_REG_OFFSET(3) + 2:
> +	case AD7768_4_REG_GAIN(0) ... AD7768_4_REG_GAIN(1) + 2:
> +	case AD7768_4_REG_GAIN(2) ... AD7768_4_REG_GAIN(3) + 2:
> +	case AD7768_4_REG_PHASE(0) ... AD7768_4_REG_PHASE(1):
> +	case AD7768_4_REG_PHASE(2) ... AD7768_4_REG_PHASE(3):
> +	case AD7768_REG_DIAGNOSTIC_RX ... AD7768_REG_CHOP_CTRL:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config ad7768_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = AD7768_REG_CHOP_CTRL,
> +	.use_single_read = true,
> +	.use_single_write = true,
> +	.readable_reg = ad7768_readable_reg,
> +};
> +
> +static const struct regmap_config ad7768_4_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = AD7768_REG_CHOP_CTRL,
> +	.use_single_read = true,
> +	.use_single_write = true,
> +	.readable_reg = ad7768_4_readable_reg,
> +};
> +
> +static int ad7768_reg_access(struct iio_dev *indio_dev,
> +			     unsigned int reg,
> +			     unsigned int writeval,
> +			     unsigned int *readval)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(regmap_get_device(st->regmap), pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	if (readval)
> +		return regmap_read(st->regmap, reg, readval);
> +
> +	return regmap_write(st->regmap, reg, writeval);
> +}
> +
> +static int ad7768_sync(struct ad7768_state *st)
> +{
> +	int ret;
> +
> +	ret = regmap_clear_bits(st->regmap, AD7768_REG_DATA_CONTROL,
> +				AD7768_DATA_CONTROL_SPI_SYNC);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_set_bits(st->regmap, AD7768_REG_DATA_CONTROL,
> +			       AD7768_DATA_CONTROL_SPI_SYNC);
> +}
> +
> +static int ad7768_configure_capture(struct ad7768_state *st)

Would be more logical to put this closer to other init/probe functions.

> +{
> +	unsigned int dclk_div_reg;
> +	unsigned int mode_config;
> +	unsigned int dclk_div;
> +	int ret;
> +
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_POWER_MODE,
> +				 AD7768_POWER_MODE_POWER_MODE_MSK |
> +				 AD7768_POWER_MODE_MCLK_DIV_MSK,
> +				 FIELD_PREP(AD7768_POWER_MODE_POWER_MODE_MSK,
> +					    AD7768_POWER_MODE_POWER_MODE_FAST) |
> +				 FIELD_PREP(AD7768_POWER_MODE_MCLK_DIV_MSK,
> +					    AD7768_POWER_MODE_POWER_MODE_FAST));
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Start with the wideband filter and a decimation rate of 64. This
> +	 * supports every valid data-line configuration at the maximum MCLK.
> +	 */
> +	mode_config = FIELD_PREP(AD7768_CH_MODE_FILTER_TYPE_MSK,
> +				 AD7768_CH_MODE_FILTER_TYPE_WIDEBAND);
> +	mode_config |= FIELD_PREP(AD7768_CH_MODE_DEC_RATE_MSK,
> +				  AD7768_CH_MODE_DEC_RATE_64);
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_CH_MODE(0),
> +				 AD7768_CH_MODE_FILTER_TYPE_MSK |
> +				 AD7768_CH_MODE_DEC_RATE_MSK,
> +				 mode_config);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD7768_REG_CH_MODE_SEL, 0);
> +	if (ret)
> +		return ret;
> +
> +	dclk_div = 8 * st->datalines / st->chip_info->num_channels;
> +	dclk_div_reg = AD7768_INTERFACE_CFG_DCLK_DIV(dclk_div);
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_INTERFACE_CFG,
> +				 AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
> +				 FIELD_PREP(AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
> +					    dclk_div_reg));
> +	if (ret)
> +		return ret;
> +
> +	return ad7768_sync(st);
> +}
> +
> +static int ad7768_update_scan_mode(struct iio_dev *indio_dev,
> +				   const unsigned long *scan_mask)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	unsigned int channel_mask;
> +	unsigned int standby_mask;
> +	int ret;
> +
> +	channel_mask = ad7768_all_standby_mask(st);
> +	standby_mask = channel_mask;

Would be helpful to have some comments to explain why XTAL gets special
handling so that we don't have to look at the datasheet. (I see something
similar later in the patch too.)

> +	if (st->clock_source == AD7768_CLOCK_SOURCE_XTAL)
> +		standby_mask &= ~BIT(st->chip_info->num_channels / 2);
> +
> +	for (unsigned int c = 0; c < st->chip_info->num_channels; c++) {
> +		if (test_bit(c, scan_mask))
> +			standby_mask &= ~BIT(c);
> +	}
> +
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_CH_STANDBY,
> +				 channel_mask, standby_mask);
> +	if (ret)
> +		return ret;
> +
> +	for (unsigned int c = 0; c < st->chip_info->num_channels; c++) {
> +		if (test_bit(c, scan_mask))
> +			ret = iio_backend_chan_enable(st->back, c);
> +		else
> +			ret = iio_backend_chan_disable(st->back, c);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct ad7768_chip_info ad7768_chip_info = {
> +	.name = "ad7768",
> +	.num_channels = 8,
> +	.regmap_config = &ad7768_regmap_config,
> +	.available_datalines = ad7768_available_datalines,
> +	.num_datalines = ARRAY_SIZE(ad7768_available_datalines),
> +	.chan_map = ad7768_chan_map,
> +	.prebuf_split = 8,
> +};
> +
> +static const struct ad7768_chip_info ad7768_4_chip_info = {
> +	.name = "ad7768-4",
> +	.num_channels = 4,
> +	.regmap_config = &ad7768_4_regmap_config,
> +	.available_datalines = ad7768_4_available_datalines,
> +	.num_datalines = ARRAY_SIZE(ad7768_4_available_datalines),
> +	.chan_map = ad7768_4_chan_map,
> +	.prebuf_split = 4,
> +};
> +
> +static int ad7768_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +
> +	return pm_runtime_resume_and_get(regmap_get_device(st->regmap));
> +}
> +
> +static int ad7768_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +
> +	pm_runtime_put_autosuspend(regmap_get_device(st->regmap));
> +	return 0;
> +}
> +
> +static const struct iio_buffer_setup_ops ad7768_buffer_ops = {
> +	.preenable = ad7768_buffer_preenable,
> +	.postdisable = ad7768_buffer_postdisable,
> +};
> +
> +static const struct iio_info ad7768_info = {
> +	.debugfs_reg_access = ad7768_reg_access,
> +	.update_scan_mode = ad7768_update_scan_mode,
> +};
> +
> +static int ad7768_configure_precharge_buffers(struct iio_dev *indio_dev,
> +					      struct ad7768_precharge_config *precharge_cfg)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	u8 prebuf1_val, prebuf2_val;
> +	u16 prebuf_mask = 0;
> +	u8 refbufp_val = 0;
> +	u8 refbufn_val = 0;
> +	int ret;
> +
> +	for (u8 ch = 0; ch < indio_dev->num_channels; ch++) {
> +		u8 channel = indio_dev->channels[ch].channel;
> +
> +		if (precharge_cfg[channel].prebufp_en)
> +			prebuf_mask |= AD7768_PREBUF_POS_EN(channel);
> +
> +		if (precharge_cfg[channel].prebufn_en)
> +			prebuf_mask |= AD7768_PREBUF_NEG_EN(channel);
> +
> +		if (precharge_cfg[channel].refbufp)
> +			refbufp_val |= ad7768_channel_mask(st, channel);
> +
> +		if (precharge_cfg[channel].refbufn)
> +			refbufn_val |= ad7768_channel_mask(st, channel);
> +	}
> +
> +	prebuf1_val = ad7768_precharge_buf1_mask(st, ~prebuf_mask);
> +	prebuf2_val = ad7768_precharge_buf2_mask(st, ~prebuf_mask);
> +
> +	ret = regmap_write(st->regmap, AD7768_REG_PRECHARGE_BUF1, prebuf1_val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD7768_REG_PRECHARGE_BUF2, prebuf2_val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD7768_REG_REFP_BUF, refbufp_val);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, AD7768_REG_REFN_BUF, refbufn_val);
> +}
> +
> +static int ad7768_parse_config(struct iio_dev *indio_dev,
> +			       struct device *dev)
> +{
> +	struct ad7768_precharge_config precharge_cfg[AD7768_MAX_CHANNEL] = { };
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	const unsigned int *available_datalines;
> +	struct iio_chan_spec *chan;
> +	unsigned int num_channels;
> +	unsigned int standby_mask;
> +	unsigned int i, len;
> +	int chan_idx = 0;
> +	int ret;
> +
> +	num_channels = 0;
> +	device_for_each_named_child_node_scoped(dev, child, "channel")
> +		num_channels++;
> +
> +	if (!num_channels || num_channels > st->chip_info->num_channels)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid number of channels\n");
> +
> +	chan = devm_kcalloc(indio_dev->dev.parent, num_channels,
> +			    sizeof(*chan), GFP_KERNEL);
> +	if (!chan)
> +		return -ENOMEM;
> +
> +	indio_dev->channels = chan;
> +	indio_dev->num_channels = num_channels;
> +
> +	standby_mask = ad7768_all_standby_mask(st);
> +	if (st->clock_source == AD7768_CLOCK_SOURCE_XTAL)
> +		standby_mask &= ~BIT(st->chip_info->num_channels / 2);
> +
> +	ret = regmap_write(st->regmap, AD7768_REG_CH_STANDBY, standby_mask);
> +	if (ret)
> +		return ret;
> +
> +	device_for_each_named_child_node_scoped(dev, child, "channel") {
> +		unsigned int channel;

u32

> +
> +		ret = fwnode_property_read_u32(child, "reg", &channel);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to parse reg of %pfwP\n",
> +					     child);
> +
> +		if (channel >= st->chip_info->num_channels)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid channel %u in firmware\n",
> +					     channel);
> +
> +		ret = regmap_clear_bits(st->regmap, AD7768_REG_CH_STANDBY,
> +					BIT(channel));
> +		if (ret)
> +			return ret;
> +
> +		precharge_cfg[channel].prebufp_en =
> +			fwnode_property_read_bool(child,
> +						  "adi,prechargebuf-pos-enable");
> +		precharge_cfg[channel].prebufn_en =
> +			fwnode_property_read_bool(child,
> +						  "adi,prechargebuf-neg-enable");
> +		precharge_cfg[channel].refbufp =
> +			fwnode_property_read_bool(child,
> +						  "adi,refbuf-pos-enable");
> +		precharge_cfg[channel].refbufn =
> +			fwnode_property_read_bool(child,
> +						  "adi,refbuf-neg-enable");
> +
> +		chan[chan_idx] = (struct iio_chan_spec) {
> +			.type = IIO_VOLTAGE,
> +			.indexed = 1,
> +			.address = channel,

Not much sense in setting address when we already have the same value 2
other places.

> +			.channel = channel,
> +			.scan_index = channel,

I guess this is OK, but normally we would make scan_index = chan_idx.

> +			.scan_type = {
> +				.sign = 's',
> +				.realbits = 24,
> +				.storagebits = 32,
> +			},

We should still have SCALE here so userspace knows how to interpret the
raw data.

> +		};
> +		chan_idx++;
> +	}
> +
> +	ret = ad7768_configure_precharge_buffers(indio_dev, precharge_cfg);
> +	if (ret)
> +		return ret;
> +
> +	available_datalines = st->chip_info->available_datalines;
> +	len = st->chip_info->num_datalines;
> +	st->datalines = available_datalines[len - 1];
> +	ret = device_property_read_u32(dev, "adi,data-lines-number",
> +				       &st->datalines);
> +	if (ret && ret != -EINVAL)
> +		return dev_err_probe(dev, ret,
> +				     "Invalid %s property\n",
> +				     "adi,data-lines-number");
> +
> +	for (i = 0; i < len; i++) {
> +		if (available_datalines[i] == st->datalines)
> +			break;
> +	}
> +
> +	if (i == len)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid data-lines-number %d for %s\n",
> +				     st->datalines, st->chip_info->name);
> +
> +	return ad7768_configure_capture(st);
> +}
> +
> +static int ad7768_reset(struct ad7768_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	struct reset_control *reset_ctrl;
> +	unsigned long reset_low_us;
> +	unsigned long mclk;
> +	int ret;
> +
> +	reset_ctrl = devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(reset_ctrl))
> +		return PTR_ERR(reset_ctrl);
> +
> +	if (reset_ctrl) {
> +		mclk = clk_get_rate(st->mclk);
> +		if (!mclk)
> +			return -EINVAL;
> +
> +		/*
> +		 * Minimum RESET low pulse width: 2 x tMCLK
> +		 * (datasheet Table 1).
> +		 */
> +		reset_low_us = DIV_ROUND_UP_ULL(2ULL * USEC_PER_SEC, mclk);
> +
> +		ret = reset_control_assert(reset_ctrl);
> +		if (ret)
> +			return ret;
> +
> +		fsleep(max_t(unsigned long, 1, reset_low_us));

Use max() with 1UL if we need to make the types exactly match.

> +
> +		ret = reset_control_deassert(reset_ctrl);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = regmap_write(st->regmap, AD7768_REG_DATA_CONTROL,
> +				   AD7768_DATA_CONTROL_SPI_RESET_1);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(st->regmap, AD7768_REG_DATA_CONTROL,
> +				   AD7768_DATA_CONTROL_SPI_RESET_2);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* ADC start-up time after reset: 1.66 ms max (datasheet Table 1) */
> +	fsleep(2000);
> +
> +	return 0;
> +}
> +
> +static void ad7768_disable_clk(void *clk)
> +{
> +	clk_disable_unprepare(clk);
> +}
> +
> +static int ad7768_configure_xtal_clock(struct ad7768_state *st)
> +{
> +	int ret;
> +
> +	ret = regmap_set_bits(st->regmap, AD7768_REG_GPIO_WRITE, BIT(4));
> +	if (ret)
> +		return ret;
> +
> +	return regmap_set_bits(st->regmap, AD7768_REG_GPIO_CONTROL,
> +			       AD7768_GPIO_UGPIO_ENABLE |
> +			       AD7768_GPIO4_OUTPUT_ENABLE);
> +}
> +
> +static int ad7768_enable_lvds_clock(struct ad7768_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	int ret;
> +
> +	ret = regmap_clear_bits(st->regmap, AD7768_REG_GPIO_WRITE, BIT(4));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(st->regmap, AD7768_REG_GPIO_CONTROL,
> +			      AD7768_GPIO_UGPIO_ENABLE |
> +			      AD7768_GPIO4_OUTPUT_ENABLE);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(st->regmap, AD7768_REG_POWER_MODE,
> +			      AD7768_POWER_MODE_LVDS_ENABLE);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(st->mclk);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, ad7768_disable_clk, st->mclk);
> +}
> +
> +static int ad7768_probe(struct spi_device *spi)
> +{
> +	unsigned int spi_readback, rev_id;
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad7768_state *st;
> +	unsigned int num_clocks;
> +	const char *clock_name;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	spi_set_drvdata(spi, st);
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	st->chip_info = spi_get_device_match_data(spi);
> +	if (!st->chip_info)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Failed to get match data\n");
> +
> +	ret = devm_regulator_get_enable_optional(dev, "avss");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable AVSS supply\n");
> +
> +	ret = devm_regulator_get_enable(dev, "avdd1");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable AVDD1 supply\n");
> +
> +	ret = devm_regulator_bulk_get_enable(dev,
> +					     ARRAY_SIZE(ad7768_supply_names),
> +					     ad7768_supply_names);
> +	if (ret)
> +		return ret;
> +
> +	if (device_property_present(dev, "clock-names")) {
> +		num_clocks = ARRAY_SIZE(ad7768_clock_names);
> +		ret = device_property_match_property_string(dev, "clock-names",
> +							    ad7768_clock_names,
> +							    num_clocks);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "Invalid clock source\n");
> +
> +		st->clock_source = ret;
> +	}
> +
> +	clock_name = ad7768_clock_names[st->clock_source];
> +	if (st->clock_source == AD7768_CLOCK_SOURCE_LVDS)
> +		st->mclk = devm_clk_get(dev, clock_name);

This needs an explanation why we don't enable the LVDS clock right away.

> +	else if (device_property_present(dev, "clock-names"))
> +		st->mclk = devm_clk_get_enabled(dev, clock_name);
> +	else
> +		st->mclk = devm_clk_get_enabled(dev, NULL);

The NULL option should work in all cases since there should only be one clock.

> +	if (IS_ERR(st->mclk))
> +		return dev_err_probe(dev, PTR_ERR(st->mclk),
> +				     "Failed to get master clock\n");
> +
> +	st->regmap = devm_regmap_init(dev, &ad7768_regmap_bus, spi,
> +				      st->chip_info->regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return PTR_ERR(st->regmap);
> +
> +	ret = ad7768_reset(st);
> +	if (ret)
> +		return ret;
> +
> +	/* Discard the reset response with a dummy SPI register read. */
> +	ret = regmap_read(st->regmap, AD7768_REG_REV_ID, &spi_readback);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD7768_REG_REV_ID, &rev_id);
> +	if (ret)
> +		return ret;
> +
> +	if (rev_id != AD7768_REV_ID_VAL)
> +		dev_info(dev, "Unexpected revision ID 0x%02x\n", rev_id);
> +
> +	if (st->clock_source == AD7768_CLOCK_SOURCE_XTAL) {
> +		ret = ad7768_configure_xtal_clock(st);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to configure crystal clock\n");
> +	} else if (st->clock_source == AD7768_CLOCK_SOURCE_LVDS) {
> +		ret = ad7768_enable_lvds_clock(st);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to enable LVDS clock\n");
> +	}

Probably would simplify things to just to unconditional clk_get_enable() here.

> +
> +	ret = ad7768_parse_config(indio_dev, dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_INTERFACE_CFG,
> +				 AD7768_INTERFACE_CFG_CRC_SELECT_MSK,
> +				 FIELD_PREP(AD7768_INTERFACE_CFG_CRC_SELECT_MSK,
> +					    AD7768_INTERFACE_CFG_CRC_SELECT_4));
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = st->chip_info->name;
> +	indio_dev->info = &ad7768_info;
> +
> +	st->back = devm_iio_backend_get(dev, NULL);
> +	if (IS_ERR(st->back))
> +		return PTR_ERR(st->back);
> +
> +	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_backend_num_lanes_set(st->back, st->datalines);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_backend_crc_enable(st->back);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_backend_enable(dev, st->back);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_set_autosuspend_delay(dev, 2000);
> +	pm_runtime_use_autosuspend(dev);
> +	ret = devm_pm_runtime_set_active_enabled(dev);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->setup_ops = &ad7768_buffer_ops;

Would make more sense to group this with other indio_dev-> init.

> +
> +	ret = devm_iio_device_register(dev, indio_dev);

Just return directly here.

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int ad7768_runtime_suspend(struct device *dev)
> +{
> +	struct ad7768_state *st = dev_get_drvdata(dev);
> +
> +	return regmap_set_bits(st->regmap, AD7768_REG_POWER_MODE,
> +			       AD7768_SLEEP_MODE_MSK);
> +}
> +
> +static int ad7768_runtime_resume(struct device *dev)
> +{
> +	struct ad7768_state *st = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = regmap_clear_bits(st->regmap, AD7768_REG_POWER_MODE,
> +				AD7768_SLEEP_MODE_MSK);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The datasheet does not specify a wake-up time. Allow 20 ms for the
> +	 * ADC and digital clocks to restart.
> +	 */
> +	fsleep(20000);
> +
> +	return 0;
> +}
> +
> +static DEFINE_RUNTIME_DEV_PM_OPS(ad7768_pm_ops, ad7768_runtime_suspend,
> +				 ad7768_runtime_resume, NULL);
> +
> +static const struct of_device_id ad7768_of_match[] = {
> +	{ .compatible = "adi,ad7768", .data = &ad7768_chip_info },
> +	{ .compatible = "adi,ad7768-4", .data = &ad7768_4_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad7768_of_match);
> +
> +static const struct spi_device_id ad7768_spi_id[] = {
> +	{ "ad7768", (kernel_ulong_t)&ad7768_chip_info },
> +	{ "ad7768-4", (kernel_ulong_t)&ad7768_4_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ad7768_spi_id);
> +
> +static struct spi_driver ad7768_driver = {
> +	.probe = ad7768_probe,
> +	.driver = {
> +		.name = "ad7768",
> +		.of_match_table = ad7768_of_match,
> +		.pm = pm_ptr(&ad7768_pm_ops),
> +	},
> +	.id_table = ad7768_spi_id,
> +};
> +module_spi_driver(ad7768_driver);
> +
> +MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
> +MODULE_AUTHOR("Janani Sunil <janani.sunil@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD7768 ADC driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_BACKEND");
> 


