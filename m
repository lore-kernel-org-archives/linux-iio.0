Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EBF329C7B
	for <linux-iio@vger.kernel.org>; Sat,  1 Aug 2026 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785608253; cv=none; b=oKEvpsr2THsoa0hdauOg6k1lV0Wt9u2IV66nobd7HLoBAXs41VN2zgBRVCJyqGyNp2KVQ5oWNGPTHVTOo+pcSjqJS+7L13PmbzMxKvjKZsjbZlASiVC6sTDBSBxkx+3KWOeGRixulbRxuRGvjL5jN+dHSD/ZN6b1Qj8hd/YPBEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785608253; c=relaxed/simple;
	bh=BE3sBgcXuRPtsWyaoDadSHaXgK9slmsINMGJrbqvves=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+KAwOYgHHuAC9oBYWIfCdeieQPZsuiXNW/JsvVMMqAoPS1kr8CTxxEjje9ruqotewxIaKHNcudCS7i0pyWjTdq54jOn4tQugkBO5AH5JWrxkTImMqZjwQvg9/XKvq49Xt458r5X1WLiujVL31h/WeajXfq2jao1Ci4iTVYYDNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=gdM8Mkmq; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="gdM8Mkmq"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-459281bc13bso163858fac.2
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2026 11:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785608248; x=1786213048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lf3hKcziYJSlCgCjLgeIDGrm/DPQJaMBzhd/3KbQxkY=;
        b=gdM8MkmqmyWjyQFQd6zzhxv9UInNb7tAlQz0YnhZWOuRhK4T/5Pwa1RUnwIRaO7UDy
         hngtbUHWvWnMem9YgtFsPJoF+JjdAYktGOcYM4GyCbnAfvcDGjboVwWn4wgyaqjsx12r
         ZSDlNlSzGM85RBc3pLAYK6Wf4L/H13LBxOy0IPGYlKlfaGtH9JLIhL9ayyR/EXDPzHWG
         bAtl4aFgBtFzSsofL6RAPJJ6FJ80oEgeMY5ukE+MCCYt/Yx7VIMhjU30nqqxnFn3dXkS
         W9gvIqd34LRlLe34JGb3PQBGTfHp5xQRn2FstDmMvsDAbiUuuBYrC+dC8kjBYLIHs18B
         JFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785608248; x=1786213048;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lf3hKcziYJSlCgCjLgeIDGrm/DPQJaMBzhd/3KbQxkY=;
        b=SNes3QYytNhtK9P20e923vFC4pd83slTbCUNweocvXMLF4ZqLWwzf4UoDDb5fEf2Fj
         sNDsncm+fCHgeHY0ebARS2VOans7HWwjKqfmrCovwX+DOyzQbIqgpvD0LyQ1deHrUFFq
         rseua5PN9l8trCaP0eDmDmFdEbsUBI1Kfjh58O9pa79Fbrl0SFAxHnv8hpGZ6YWQaMGJ
         pqxP7FWJYfGrmFvJQeYS7DH9QFwWGoUR05nRkdyS2GlbtYgqaBpxcY5lQSMiZNgfOnZ1
         ICbIRGg1PuJrCa1J1ng3KWBM9wcV/tQz9dA5hvSVyjnSG+v7mFE3hby+P05UoBs+1zb+
         Q45A==
X-Gm-Message-State: AOJu0YyRLt9CdmG/wN1Fv4PxqKl4PcI7q+J1cPGXIwkSq4uF4cKh5q1Q
	ILlrsjHEfXHsMQRhivDk53ydhpkTZPSjm3NzG8kl7cuFR4EZlo7IYHedad77WkOHinY=
X-Gm-Gg: AR+sD12lbFj/LCxSYMrQMYRag66v9WFsxfmFCzTyc7sdGAPHwU0JU8IzRzGmapFlFJF
	JAWyvlu9HRcWbrxC5O8LlLGSvJDYOcnUdyb08GRDsD2X/TDnRgdtKCFPisT1o4KRYdfIrr19xl2
	il9z/ww8zw5aZHCkgo9srariZjA1fJ+w+awXPp3R7YdAx9KH3dS9elOuofeIS1w4DX8oLHWVbMr
	dx0P9yUhjkM3cPDUjuikE1SCnmn/Hd+pSQJmhI4WuOrgH+S/EkrctjtNgBwkAuk8j+ITp1JDfO8
	YX9YLQQBm8hFYgBkGaOFdwxtDE8aJFTKEE4ANW/ei8dKXd/WT9+rU8a7PBwOmdkcWshaGDj3eYE
	7gpaRe2Hixw1YQkqSB60vRIH1OQS8UW4y4WeAswIW8ogLiwltABYjlJd2AIelxooobDNYZhp63K
	j8bmmWmG5d/JcL4JAqv/PlaT74DJxT9iPA4iBOyo7zvGEdafE7A3H5HrVu1e7hFDJ2tM+7S0KVG
	7QJ7L7pzmSyrW7CAIeEp28jSwj5JLlGHT7Ku8s=
X-Received: by 2002:a05:6820:f026:b0:6a3:f522:7656 with SMTP id 006d021491bc7-6ae432c9106mr7813531eaf.20.1785608247950;
        Sat, 01 Aug 2026 11:17:27 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:359b:17f1:d4f9:4949? ([2600:8803:e7e4:500:359b:17f1:d4f9:4949])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae3a31d93esm3445424eaf.14.2026.08.01.11.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 11:17:26 -0700 (PDT)
Message-ID: <58aded5f-eec8-46fa-b158-e4c9d4ea3377@baylibre.com>
Date: Sat, 1 Aug 2026 13:17:24 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: add support for PAC1711
To: Ariana Lazar <ariana.lazar@microchip.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260728-pac1711-v2-0-609bc026093c@microchip.com>
 <20260728-pac1711-v2-2-609bc026093c@microchip.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260728-pac1711-v2-2-609bc026093c@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/26 7:03 AM, Ariana Lazar wrote:
> This is the iio driver for Microchip PAC1711, PAC1721, PAC1811 and
> PAC1821 single-channel power monitors with accumulator. The PAC1711 and
> PAC1721 devices use 12-bit resolution for voltage and current measurements
> and 24 bits for power calculations, while PAC1811 and PAC1821 have 16-bit
> resolution and use 32 bits for power calculations. The 56-bit accumulator
> register accumulates power (energy) or current (Coulomb counter).
> 
> PAC1711 and PAC1811 measure up to 42V Full-Scale Range, respectively 9V for
> PAC1721 and PAC1821.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-adc-pac1711          |   24 +
>  MAINTAINERS                                        |    2 +
>  drivers/iio/adc/Kconfig                            |   11 +
>  drivers/iio/adc/Makefile                           |    1 +
>  drivers/iio/adc/pac1711.c                          | 1274 ++++++++++++++++++++

This is a bit big to review all at once. Maybe we could split this up?
Like moving the accumulator stuff to a separate patch.

>  5 files changed, 1312 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1711 b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1711
> new file mode 100644
> index 0000000000000000000000000000000000000000..88e8aecbc42cfa9159d07a3c05705f728b824b69
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1711
> @@ -0,0 +1,24 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_coulomb_counter_raw

It seems like charge would be a generic name and this could go in the
standard bindings.

> +KernelVersion:	6.16

Likely this will land in 7.4.

> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute is used to read the accumulated voltage
> +		measured on the shunt resistor (Coulomb counter). Units
> +		after application of scale are Coulombs. X is the IIO index
> +		of the device.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_coulomb_counter_scale
> +KernelVersion:	6.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		If known for a device, scale to be applied to
> +		in_coulomb_counter_raw in order to obtain the measured
> +		value in Coulombs. X is the IIO index of the device.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_coulomb_counter_en
> +KernelVersion:	6.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute, if available, is used to enable digital
> +		accumulation of VSENSE measurements. X is the IIO index of
> +		the device.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 399da37f79fd9768f29cc60aa5384a1ba9fe8afc..c41cb5878e62297d14e5b9710a6f1210b6bd8ea1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16341,7 +16341,9 @@ MICROCHIP PAC1711 POWER/CURRENT MONITOR DRIVER
>  M:	Ariana Lazar <ariana.lazar@microchip.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
> +F:	Documentation/ABI/testing/sysfs-bus-iio-adc-pac1711
>  F:	Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml
> +F:	drivers/iio/adc/pac1711.c
>  
>  MICROCHIP PAC1921 POWER/CURRENT MONITOR DRIVER
>  M:	Matteo Martelli <matteomartelli3@gmail.com>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index ea3ba139739281de82848e25fd2b6ca479a939dc..bc4d606132089515a4d6b01f0602ce7ff4f872c8 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1125,6 +1125,17 @@ config NPCM_ADC
>  	  This driver can also be built as a module. If so, the module
>  	  will be called npcm_adc.
>  
> +config PAC1711
> +	tristate "Microchip Technology PAC1711 driver"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for Microchip Technology's PAC1711,
> +	  PAC1721, PAC1811 and PAC1821 Single-Channel Power Monitors with
> +	  Accumulator.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called pac1711.
> +
>  config PAC1921
>  	tristate "Microchip Technology PAC1921 driver"
>  	depends on I2C
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 09ae6edb26504991f011def6618efc3f4cf4df4c..d039a23cde02d442b161730ad2c939c7d035a4c6 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -101,6 +101,7 @@ obj-$(CONFIG_MXS_LRADC_ADC) += mxs-lradc-adc.o
>  obj-$(CONFIG_NAU7802) += nau7802.o
>  obj-$(CONFIG_NCT7201) += nct7201.o
>  obj-$(CONFIG_NPCM_ADC) += npcm_adc.o
> +obj-$(CONFIG_PAC1711) += pac1711.o
>  obj-$(CONFIG_PAC1921) += pac1921.o
>  obj-$(CONFIG_PAC1934) += pac1934.o
>  obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
> diff --git a/drivers/iio/adc/pac1711.c b/drivers/iio/adc/pac1711.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..ee6adee31524e73371450d04bd501c545bd682b6
> --- /dev/null
> +++ b/drivers/iio/adc/pac1711.c
> @@ -0,0 +1,1274 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * IIO driver for PAC1711 Single-Channel DC Power/Energy Monitor
> + *
> + * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Ariana Lazar <ariana.lazar@microchip.com>
> + *
> + * Datasheet links:
> + * [PAC1711]: https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/PAC1711-Data-Sheet-DS20007058.pdf
> + * [PAC1721]: https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/PAC1721-Single-Channel-Power-Monitor-with-Accumulator-DS20007088.pdf
> + * [PAC1811]: https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC1811-Data-Sheet-DS20007066.pdf
> + * [PAC1821]: https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC1821-Data-Sheet-DS20007097.pdf
> + */
> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/byteorder/generic.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/math64.h>
> +#include <linux/mutex.h>
> +#include <linux/overflow.h>
> +#include <linux/property.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +#include <linux/workqueue.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +/*
> + * Maximum accumulation time should be 1,165 hours at 1,024 sps

								SPS

> + * till PAC1711 accumulation registers starts to saturate
> + */
> +#define PAC1711_MAX_RFSH_LIMIT_MS		60000
> +/* 50msec is the timeout for validity of the cached registers */
> +#define PAC1711_MIN_POLLING_TIME_MS		50
> +/*
> + * 1000usec is the minimum wait time for normal conversions when sample
> + * rate doesn't change
> + */
> +#define PAC1711_MIN_UPDATE_WAIT_TIME_US		1000
> +
> +/* 42000mV */
> +#define PAC1711_VOLTAGE_MILLIVOLTS_MAX	42000
> +#define PAC1721_VOLTAGE_MILLIVOLTS_MAX	9000
> +
> +/* Maximum power-product value - 42 V * 0.1 V */
> +#define PAC1711_PRODUCT_VOLTAGE_PV_FSR		4200000000000UL
> +#define PAC1721_PRODUCT_VOLTAGE_PV_FSR		900000000000UL

Too many 0s. Use NANO macro.

Or e.g. (PAC1711_VOLTAGE_MILLIVOLTS_MAX * (PICO / MILLI)) if there
is a relation here.

> +
> +/* I2C address map */
> +#define PAC1711_REFRESH_REG_ADDR		0x00
> +#define PAC1711_ACC_COUNT_REG_ADDR		0x02
> +#define PAC1711_VACC_REG_ADDR			0x03
> +#define PAC1711_VBUS_REG_ADDR			0x04
> +#define PAC1711_VSENSE_REG_ADDR			0x05
> +#define PAC1711_VPOWER_REG_ADDR			0x08
> +#define PAC1711_CTRL_LAT_REG_ADDR		0x0F
> +#define PAC1711_SLOW_REG_ADDR			0x16
> +#define PAC1711_CTRL_ACT_REG_ADDR		0x17
> +
> +#define PAC1711_NEG_PWR_FSR_REG_ADDR		0x13
> +#define PAC1711_NEG_PWR_FSR_VS_MASK		GENMASK(3, 2)
> +#define PAC1711_NEG_PWR_FSR_VB_MASK		GENMASK(1, 0)
> +
> +#define PAC1711_CTRL_REG_ADDR			0x01
> +#define PAC1711_CTRL_SAMPLE_MODE_MASK		GENMASK(15, 12)
> +#define PAC1711_CTRL_ACC_MODE_MASK		GENMASK(3, 2)

Prefer to put the register fields under each register they belong
too with a little indent.

> +
> +#define PAC1711_PID_REG_ADDR			0xFD
> +
> +/* Dimension of each register in bytes */
> +#define PAC1711_ACC_REG_LEN			4
> +#define PAC1711_VACC_REG_LEN			7
> +#define PAC1711_VBUS_SENSE_REG_LEN		2
> +
> +/*
> + * The sum of the measurement registers' dimensions in bytes - from ACC_COUNT to
> + * VPOWER in datasheet register description.
> + */
> +#define PAC1711_MEAS_REG_SNAPSHOT_LEN		23
> +
> +#define PAC1711_ACC_VPOWER_STR			"vpower"
> +#define PAC1711_ACC_VSENSE_STR			"vsense"
> +
> +#define PAC1711_PRODUCT_ID_1711			0x80
> +#define PAC1711_PRODUCT_ID_1721			0x81
> +#define PAC1711_PRODUCT_ID_1811			0x84
> +#define PAC1711_PRODUCT_ID_1821			0x85
> +
> +#define PAC1711_DEV_ATTR(name)			(&iio_dev_attr_##name.dev_attr.attr)
> +
> +enum pac1711_ch_idx {
> +	PAC1711_CH_POWER,
> +	PAC1711_CH_VOLTAGE,
> +	PAC1711_CH_CURRENT,
> +};
> +
> +enum pac1711_acc_mode {
> +	PAC1711_ACCMODE_VPOWER = 0,
> +	PAC1711_ACCMODE_VSENSE = 1,
> +};
> +
> +enum pac1711_fsr {
> +	PAC1711_FULL_RANGE_UNIPOLAR = 0,
> +	PAC1711_FULL_RANGE_BIPOLAR = 1,
> +	PAC1711_HALF_RANGE_BIPOLAR = 2,
> +};
> +
> +enum pac1711_voltage_range_idx {
> +	PAC1711_VOLTAGE_RANGE_IDX = 0,
> +	PAC1721_VOLTAGE_RANGE_IDX = 1,
> +};

These can be anonymous enums. Or just #define if we are going to
give each value anyway.

> +
> +static const int pac1711_vbus_range_tbl[2][3][2] = {
> +	[PAC1711_VOLTAGE_RANGE_IDX] = {
> +		[PAC1711_FULL_RANGE_UNIPOLAR] = { 0, 42000000 },
> +		[PAC1711_FULL_RANGE_BIPOLAR]  = { -42000000, 42000000 },
> +		[PAC1711_HALF_RANGE_BIPOLAR]  = { -21000000, 21000000 },
> +	},
> +	[PAC1721_VOLTAGE_RANGE_IDX] = {
> +		[PAC1711_FULL_RANGE_UNIPOLAR] = { 0, 9000000 },
> +		[PAC1711_FULL_RANGE_BIPOLAR]  = { -9000000, 9000000 },
> +		[PAC1711_HALF_RANGE_BIPOLAR]  = { -4500000, 4500000 },
> +	},
> +};
> +
> +static const int pac1711_vsense_range_tbl[3][2] = {
> +	[PAC1711_FULL_RANGE_UNIPOLAR] = { 0, 100000 },
> +	[PAC1711_FULL_RANGE_BIPOLAR] = { -100000, 100000 },
> +	[PAC1711_HALF_RANGE_BIPOLAR] = { -50000, 50000 },
> +};
> +
> +enum pac1711_samps {
> +	PAC1711_SAMP_8192SPS = 0,
> +	PAC1711_SAMP_4096SPS = 1,
> +	PAC1711_SAMP_1024SPS = 2,
> +	PAC1711_SAMP_256SPS = 3,
> +	PAC1711_SAMP_64SPS = 4,
> +	PAC1711_SAMP_8SPS = 5,
> +};
> +
> +static const int pac1711_samp_rate_map_tbl[] = {
> +	[PAC1711_SAMP_8192SPS] = 8192,
> +	[PAC1711_SAMP_4096SPS] = 4096,
> +	[PAC1711_SAMP_1024SPS] = 1024, /* Default */
> +	[PAC1711_SAMP_256SPS] = 256,
> +	[PAC1711_SAMP_64SPS] = 64,
> +	[PAC1711_SAMP_8SPS] = 8,
> +};
> +
> +/**
> + * struct pac1711_features - features of a pac1711 instance
> + * @name: chip's name
> + * @prod_id: hardware ID
> + */
> +struct pac1711_features {
> +	const char *name;
> +	u8 prod_id;
> +};
> +
> +static const struct pac1711_features pac1711_chip_features = {
> +	.name = "pac1711",
> +	.prod_id = PAC1711_PRODUCT_ID_1711,
> +};
> +
> +static const struct pac1711_features pac1721_chip_features = {
> +	.name = "pac1721",
> +	.prod_id = PAC1711_PRODUCT_ID_1721,
> +};
> +
> +static const struct pac1711_features pac1811_chip_features = {
> +	.name = "pac1811",
> +	.prod_id = PAC1711_PRODUCT_ID_1811,
> +};
> +
> +static const struct pac1711_features pac1821_chip_features = {
> +	.name = "pac1821",
> +	.prod_id = PAC1711_PRODUCT_ID_1821,
> +};
> +
> +/**
> + * struct reg_data - data from the registers
> + * @vacc:		accumulated vpower value
> + * @acc_val:		accumulated values per second
> + * @vpower:		vpower registers
> + * @vsense:		vsense registers
> + * @vbus:		vbus registers
> + * @acc_count:		the acc_count register
> + * @total_samples_nr:	total number of samples
> + * @jiffies_tstamp:	timestamp
> + * @ctrl_act_reg:	the ctrl_act register
> + * @ctrl_lat_reg:	the ctrl_lat register
> + * @meas_regs:		snapshot of raw measurements registers
> + */
> +struct reg_data {
> +	s64	vacc;
> +	s64	acc_val;
> +	s64	vpower;
> +	s32	vsense;
> +	s32	vbus;
> +	u32	acc_count;
> +	u32	total_samples_nr;
> +	unsigned long jiffies_tstamp;
> +	u16	ctrl_act_reg;
> +	u16	ctrl_lat_reg;
> +	u8	meas_regs[PAC1711_MEAS_REG_SNAPSHOT_LEN];
> +};
> +
> +/**
> + * struct pac1711_chip_info - information about the chip
> + * @chip_reg_data:	measurement/control/accumulator output device registers
> + * @iio_info:		device information
> + * @client:		the i2c-client attached to the device
> + * @work_chip_rfsh:	work queue used for refresh commands
> + * @lock:		synchronize access to driver's state members
> + * @shunt:		shunt resistor value
> + * @vbus_mode:		Full Scale Range (FSR) mode for VBus
> + * @vsense_mode:	Full Scale Range (FSR) mode for VSense
> + * @accumulation_mode:	accumulation mode for hardware accumulator
> + * @sample_rate_idx:	sampling frequency index
> + * @chip_variant:	chip variant
> + * @voltage_range_idx:	Voltage range based on part number
> + * @enable_acc:		true means that accumulation channel is measured
> + * @is_pac18x1_family:	true if device is part of the PAC18x1 family

Can we give this a more specific name of what the actual
difference is? Or even multiple fields if there are multiple
differences.

> + */
> +struct pac1711_chip_info {
> +	struct reg_data		chip_reg_data;
> +	struct iio_info		iio_info;
> +	struct i2c_client	*client;
> +	struct delayed_work	work_chip_rfsh;
> +	/* Prevents concurrent writes into control, voltage measurement or accumulator registers. */
> +	struct mutex		lock;
> +	u32			shunt;
> +	u8			vbus_mode;
> +	u8			vsense_mode;
> +	u8			accumulation_mode;
> +	u8			sample_rate_idx;
> +	u8			chip_variant;
> +	u8			voltage_range_idx;
> +	bool			enable_acc;
> +	bool			is_pac18x1_family;
> +};
> +
> +static inline u64 pac1711_get_unaligned_be56(u8 *p)
> +{
> +	return (u64)p[0] << 48 | (u64)p[1] << 40 | (u64)p[2] << 32 |
> +		(u64)p[3] << 24 | p[4] << 16 | p[5] << 8 | p[6];
> +}

Probably would be ok to add this to linux/unaligned.h.

> +
> +static int pac1711_send_refresh(struct pac1711_chip_info *info, u8 refresh_cmd,
> +				u32 wait_time)
> +{
> +	struct i2c_client *client = info->client;
> +	int ret;
> +
> +	/* Writing a REFRESH or a REFRESH_V command */
> +	ret = i2c_smbus_write_byte(client, refresh_cmd);
> +	if (ret) {
> +		dev_err(&client->dev, "%s - cannot send Refresh cmd (0x%02X)\n",
> +			__func__, refresh_cmd);
> +		return ret;
> +	}
> +
> +	/* Register data retrieval timestamp */
> +	info->chip_reg_data.jiffies_tstamp = jiffies;
> +
> +	/* Wait till the data is available */
> +	fsleep(wait_time);
> +
> +	return 0;
> +}
> +
> +static int pac1711_reg_snapshot(struct pac1711_chip_info *info, bool do_refresh,
> +				u8 refresh_cmd, u32 wait_time)
> +{
> +	struct i2c_client *client = info->client;
> +	struct device *dev = &client->dev;
> +	s64 tmp_s64;
> +	u8 *offset_reg_data_p;
> +	bool is_bipolar;
> +	__be16 tmp_be16;
> +	u16 tmp_u16;
> +	s64 inc = 0;
> +	u8 shift;
> +	int ret;
> +
> +	guard(mutex)(&info->lock);
> +
> +	if (do_refresh) {
> +		ret = pac1711_send_refresh(info, refresh_cmd, wait_time);
> +		if (ret < 0) {
> +			dev_err(dev, "cannot send refresh\n");
> +			return ret;
> +		}
> +	}
> +
> +	/* Read the ctrl/status registers for this snapshot */
> +	ret = i2c_smbus_read_i2c_block_data(client, PAC1711_CTRL_ACT_REG_ADDR,
> +					    sizeof(tmp_be16), (u8 *)&tmp_be16);
> +	if (ret < 0) {
> +		dev_err(dev, "%s - cannot read regs from 0x%02X\n",
> +			__func__, PAC1711_CTRL_ACT_REG_ADDR);
> +		return ret;
> +	}
> +
> +	info->chip_reg_data.ctrl_act_reg = be16_to_cpu(tmp_be16);
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, PAC1711_CTRL_LAT_REG_ADDR,
> +					    sizeof(tmp_be16), (u8 *)&tmp_be16);
> +	if (ret < 0) {
> +		dev_err(dev, "%s - cannot read regs from 0x%02X\n",
> +			__func__, PAC1711_CTRL_LAT_REG_ADDR);
> +		return ret;
> +	}
> +
> +	info->chip_reg_data.ctrl_lat_reg = be16_to_cpu(tmp_be16);
> +
> +	/* Read the data registers */
> +	ret = i2c_smbus_read_i2c_block_data(client, PAC1711_ACC_COUNT_REG_ADDR,
> +					    PAC1711_MEAS_REG_SNAPSHOT_LEN,
> +					    (u8 *)info->chip_reg_data.meas_regs);
> +	if (ret < 0) {
> +		dev_err(dev, "%s - cannot read regs from 0x%02X\n",
> +			__func__, PAC1711_ACC_COUNT_REG_ADDR);
> +		return ret;
> +	}
> +
> +	offset_reg_data_p = &info->chip_reg_data.meas_regs[0];
> +	info->chip_reg_data.acc_count = get_unaligned_be32(offset_reg_data_p);
> +	offset_reg_data_p += PAC1711_ACC_REG_LEN;
> +
> +	/* skip if the energy accumulation is disabled */
> +	if (info->enable_acc) {
> +		info->chip_reg_data.vacc = pac1711_get_unaligned_be56(offset_reg_data_p);
> +		is_bipolar = false;
> +
> +		switch (info->accumulation_mode) {
> +		case PAC1711_ACCMODE_VPOWER:
> +			if (info->vbus_mode != PAC1711_FULL_RANGE_UNIPOLAR ||
> +			    info->vsense_mode != PAC1711_FULL_RANGE_UNIPOLAR)
> +				is_bipolar = true;
> +			break;
> +		case PAC1711_ACCMODE_VSENSE:
> +			if (info->vsense_mode != PAC1711_FULL_RANGE_UNIPOLAR)
> +				is_bipolar = true;
> +			break;
> +		}
> +
> +		if (is_bipolar)
> +			info->chip_reg_data.vacc = sign_extend64(info->chip_reg_data.vacc, 55);
> +
> +		/*
> +		 * Integrate the accumulated power or current over
> +		 * the elapsed interval.
> +		 */
> +		tmp_u16 = FIELD_GET(PAC1711_CTRL_SAMPLE_MODE_MASK,
> +				    info->chip_reg_data.ctrl_lat_reg);
> +		tmp_s64 = info->chip_reg_data.vacc;
> +
> +		if (tmp_u16 <= PAC1711_SAMP_8SPS) {
> +			shift = ffs(pac1711_samp_rate_map_tbl[tmp_u16]) - 1;
> +			inc = tmp_s64 >> shift;
> +		} else {
> +			dev_err(dev, "Invalid sample rate index: %d!\n", tmp_u16);
> +			return -EINVAL;
> +		}
> +
> +		if (check_add_overflow(info->chip_reg_data.acc_val, inc,
> +				       &info->chip_reg_data.acc_val)) {
> +			if (inc < 0)
> +				info->chip_reg_data.acc_val = S64_MIN;
> +			else
> +				info->chip_reg_data.acc_val = S64_MAX;
> +
> +			dev_err(dev, "Accumulator Overflow detected!\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	offset_reg_data_p += PAC1711_VACC_REG_LEN;
> +
> +	/* VBUS */
> +	info->chip_reg_data.vbus = get_unaligned_be16(offset_reg_data_p);
> +
> +	if (info->vbus_mode != PAC1711_FULL_RANGE_UNIPOLAR)
> +		info->chip_reg_data.vbus = sign_extend32(info->chip_reg_data.vbus, 15);
> +
> +	offset_reg_data_p += PAC1711_VBUS_SENSE_REG_LEN;
> +
> +	/* VSENSE */
> +	info->chip_reg_data.vsense = get_unaligned_be16(offset_reg_data_p);
> +
> +	if (info->vsense_mode != PAC1711_FULL_RANGE_UNIPOLAR)
> +		info->chip_reg_data.vsense = sign_extend32(info->chip_reg_data.vsense, 15);
> +
> +	/* Skip VBUS_AVG and VSENSE_AVG registers */
> +	offset_reg_data_p += PAC1711_VBUS_SENSE_REG_LEN * 3;
> +
> +	/* VPOWER */
> +	info->chip_reg_data.vpower = get_unaligned_be32(offset_reg_data_p);
> +
> +	if (info->vbus_mode != PAC1711_FULL_RANGE_UNIPOLAR ||
> +	    info->vsense_mode != PAC1711_FULL_RANGE_UNIPOLAR)
> +		info->chip_reg_data.vpower = sign_extend64(info->chip_reg_data.vpower, 31);
> +
> +	return 0;
> +}
> +
> +static int pac1711_retrieve_data(struct pac1711_chip_info *info, u32 wait_time)
> +{
> +	int ret = 0;
> +
> +	/*
> +	 * Check if the minimal elapsed time has passed and if so,
> +	 * read again the chip, otherwise use the cached info.
> +	 */
> +	if (time_after(jiffies, info->chip_reg_data.jiffies_tstamp +
> +			msecs_to_jiffies(PAC1711_MIN_POLLING_TIME_MS))) {
> +		ret = pac1711_reg_snapshot(info, true, PAC1711_REFRESH_REG_ADDR,
> +					   wait_time);
> +
> +		/*
> +		 * Re-schedule the work for the read registers timeout
> +		 * (to prevent chip regs saturation)
> +		 */
> +		cancel_delayed_work_sync(&info->work_chip_rfsh);
> +		schedule_delayed_work(&info->work_chip_rfsh,
> +				      msecs_to_jiffies(PAC1711_MAX_RFSH_LIMIT_MS));
> +	}
> +
> +	return ret;
> +}
> +
> +static int pac1711_get_samp_rate_idx(u32 new_samp_rate)
> +{
> +	int cnt;
> +
> +	for (cnt = 0; cnt < ARRAY_SIZE(pac1711_samp_rate_map_tbl); cnt++)
> +		if (new_samp_rate == pac1711_samp_rate_map_tbl[cnt])
> +			return cnt;
> +
> +	return -EINVAL;
> +}
> +
> +static ssize_t pac1711_read_shunt_resistor(struct iio_dev *indio_dev, uintptr_t private,
> +					   const struct iio_chan_spec *ch, char *buf)
> +{
> +	struct pac1711_chip_info *info = iio_priv(indio_dev);
> +
> +	return sysfs_emit(buf, "%u\n", info->shunt);
> +}
> +
> +static ssize_t pac1711_in_power_acc_raw_show(struct device *dev, struct device_attribute *attr,
> +					     char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac1711_chip_info *info = iio_priv(indio_dev);
> +	s64 curr_energy, int_part;
> +	int ret, rem;
> +
> +	ret = pac1711_retrieve_data(info, PAC1711_MIN_UPDATE_WAIT_TIME_US);
> +	if (ret)
> +		return ret;
> +
> +	/* Expresses the 64 bit energy value as a 64 bit integer and a 32 bit nano value */
> +	curr_energy = info->chip_reg_data.acc_val;
> +	int_part = div_s64_rem(curr_energy, 1000000000, &rem);
> +
> +	if (rem < 0)
> +		return sysfs_emit(buf, "-%lld.%09u\n", abs(int_part), -rem);
> +	else
> +		return sysfs_emit(buf, "%lld.%09u\n", int_part, abs(rem));
> +}
> +
> +static ssize_t pac1711_in_power_acc_scale_show(struct device *dev, struct device_attribute *attr,
> +					       char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac1711_chip_info *info = iio_priv(indio_dev);
> +	unsigned int rem;
> +	u64 tmp, ref;

Would prefer more meaningful names for tmp and rem, e.g. val_int and val_nano.
Applies through the patch.

> +
> +	/*
> +	 * For PAC1711/PAC1811 the scale constant = (10^3 * 4.2 * 10^9 / 2^(31 or 23))
> +	 * for mili Watt-second
> +	 *
> +	 * For PAC1721/PAC1821 the scale constant = (10^3 * 0.9 * 10^9 / 2^(31 or 23))
> +	 * for mili Watt-second
> +	 */
> +	switch (info->voltage_range_idx) {
> +	case PAC1711_VOLTAGE_RANGE_IDX:
> +		ref = info->is_pac18x1_family ? (u64)1958 : (u64)500680;
> +		break;
> +	case PAC1721_VOLTAGE_RANGE_IDX:
> +		ref = info->is_pac18x1_family ? (u64)419 : (u64)107288;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if ((info->vsense_mode == PAC1711_FULL_RANGE_UNIPOLAR &&
> +	     info->vbus_mode == PAC1711_FULL_RANGE_UNIPOLAR)  ||
> +	    info->vsense_mode == PAC1711_HALF_RANGE_BIPOLAR ||
> +	    info->vbus_mode == PAC1711_HALF_RANGE_BIPOLAR)
> +		ref = ref >> 1;
> +
> +	tmp = div_u64(ref * 1000000000UL, info->shunt);
> +	rem = do_div(tmp, 1000000000UL);

	tmp = div_u64_rem(ref * NANO, info->shunt, &rem);

> +
> +	return sysfs_emit(buf, "%llu.%09u\n", tmp, rem);
> +}
> +
> +static ssize_t pac1711_in_enable_acc_show(struct device *dev, struct device_attribute *attr,
> +					  char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac1711_chip_info *info = iio_priv(indio_dev);
> +
> +	return sysfs_emit(buf, "%d\n", info->enable_acc);
> +}
> +
> +static ssize_t pac1711_in_enable_acc_store(struct device *dev, struct device_attribute *attr,
> +					   const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac1711_chip_info *info = iio_priv(indio_dev);
> +	bool val;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
> +	scoped_guard(mutex, &info->lock) {

Just use regular guard(mutex).

> +		info->enable_acc = val;
> +		if (!val) {
> +			info->chip_reg_data.acc_val = 0;
> +			info->chip_reg_data.total_samples_nr = 0;
> +		}
> +	}
> +
> +	return count;
> +}
> +
> +static ssize_t pac1711_in_coulomb_counter_raw_show(struct device *dev,
> +						   struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac1711_chip_info *info = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = pac1711_retrieve_data(info, PAC1711_MIN_UPDATE_WAIT_TIME_US);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%lld\n", info->chip_reg_data.acc_val);
> +}
> +
> +static ssize_t pac1711_in_coulomb_counter_scale_show(struct device *dev,
> +						     struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac1711_chip_info *info = iio_priv(indio_dev);
> +	u64 tmp_u64, ref;
> +	unsigned int rem;
> +
> +	if (info->is_pac18x1_family)
> +		/*
> +		 * Calculate the scale for accumulated current/Coulomb counter
> +		 * (100mV * 1000000) / (2^16 * shunt(uOhm)) - depends on the channel's shunt value
> +		 */
> +		ref = (u64)1525878906250ULL;
> +	else
> +		/* (100mV * 1000000) / (2^12 * shunt(uOhm)) */
> +		ref = (u64)24414062500000ULL;
> +
> +	if (info->vsense_mode == PAC1711_FULL_RANGE_BIPOLAR)
> +		ref = ref << 1;
> +
> +	/*
> +	 * Increasing precision
> +	 * (100mV * 1000000 * 1000000000) / 2^(12 or 16))

Too many 0s. can we write it like (100mV * 1M * 1G)?

I don't really understand the comment though.

> +	 */
> +	tmp_u64 = div_u64(ref, info->shunt);
> +	rem = do_div(tmp_u64, 1000000000UL);

Use 1 * NANO.

Also, use of tmp_u64 doesn't look quite right.

> +
> +	return sysfs_emit(buf, "%lld.%09u\n", tmp_u64, rem);
> +}
> +
> +static IIO_DEVICE_ATTR(in_energy_raw, 0444,
> +		       pac1711_in_power_acc_raw_show, NULL, 0);
> +
> +static IIO_DEVICE_ATTR(in_energy_scale, 0444,
> +		       pac1711_in_power_acc_scale_show, NULL, 0);
> +
> +static IIO_DEVICE_ATTR(in_energy_en, 0644,
> +		       pac1711_in_enable_acc_show, pac1711_in_enable_acc_store, 0);
> +
> +static IIO_DEVICE_ATTR(in_coulomb_counter_raw, 0444,
> +		       pac1711_in_coulomb_counter_raw_show, NULL, 0);
> +
> +static IIO_DEVICE_ATTR(in_coulomb_counter_scale, 0444,
> +		       pac1711_in_coulomb_counter_scale_show, NULL, 0);
> +
> +static IIO_DEVICE_ATTR(in_coulomb_counter_en, 0644,
> +		       pac1711_in_enable_acc_show, pac1711_in_enable_acc_store, 0);
> +
> +static struct attribute *pac1711_power_acc_attr[] = {
> +	PAC1711_DEV_ATTR(in_energy_raw),
> +	PAC1711_DEV_ATTR(in_energy_scale),
> +	PAC1711_DEV_ATTR(in_energy_en),
> +	NULL,
> +};
> +
> +static struct attribute *pac1711_coulomb_counter_attr[] = {
> +	PAC1711_DEV_ATTR(in_coulomb_counter_raw),
> +	PAC1711_DEV_ATTR(in_coulomb_counter_scale),
> +	PAC1711_DEV_ATTR(in_coulomb_counter_en),
> +	NULL,
> +};
> +
> +static ssize_t pac1711_write_shunt_resistor(struct iio_dev *indio_dev, uintptr_t private,

The shunt resistor is defined in the devicetree. Why does it
need to be writeable? If there is a good reason, add a comment
to the code.

> +					    const struct iio_chan_spec *ch, const char *buf,
> +					    size_t len)
> +{
> +	struct pac1711_chip_info *info = iio_priv(indio_dev);
> +	struct device *dev = &info->client->dev;
> +	unsigned int sh_val;
> +
> +	if (kstrtouint(buf, 10, &sh_val)) {
> +		dev_err(dev, "Shunt value is not valid\n");
> +		return -EINVAL;
> +	}
> +
> +	if (sh_val == 0)
> +		return -EINVAL;
> +
> +	scoped_guard(mutex, &info->lock)
> +		info->shunt = sh_val;
> +
> +	return len;
> +}
> +
> +static const struct iio_chan_spec_ext_info pac1711_ext_info[] = {
> +	{
> +		.name = "in_shunt_resistor",
> +		.read = pac1711_read_shunt_resistor,
> +		.write = pac1711_write_shunt_resistor,
> +		.shared = IIO_SHARED_BY_ALL,
> +	},
> +	{ }
> +};
> +
> +#define TO_PAC1711_CHIP_INFO(d) container_of(d, struct pac1711_chip_info, work_chip_rfsh)
> +
> +#define PAC1711_VBUS_CHANNEL(_index, _address) {				\
> +	.type = IIO_VOLTAGE,							\
> +	.address = (_address),							\
> +	.indexed = 1,								\
> +	.channel = (_index),							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> +			      BIT(IIO_CHAN_INFO_SCALE),				\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +}
> +
> +#define PAC1711_VSENSE_CHANNEL(_index, _address) {				\
> +	.type = IIO_CURRENT,							\
> +	.address = (_address),							\
> +	.indexed = 1,								\
> +	.channel = (_index),							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> +			      BIT(IIO_CHAN_INFO_SCALE),				\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.ext_info = pac1711_ext_info,						\
> +}
> +
> +#define PAC1711_VPOWER_CHANNEL(_index, _address) {				\
> +	.type = IIO_POWER,							\
> +	.address = (_address),							\
> +	.indexed = 1,								\
> +	.channel = (_index),							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> +			      BIT(IIO_CHAN_INFO_SCALE),				\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +}
> +
> +static int pac1711_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct pac1711_chip_info *info = iio_priv(indio_dev);
> +	u64 tmp = 0;
> +	int ret;
> +
> +	ret = pac1711_retrieve_data(info, PAC1711_MIN_UPDATE_WAIT_TIME_US);
> +	if (ret)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val = info->chip_reg_data.vbus;
> +			return IIO_VAL_INT;
> +		case IIO_CURRENT:
> +			*val = info->chip_reg_data.vsense;
> +			return IIO_VAL_INT;
> +		case IIO_POWER:
> +			*val = (u32)info->chip_reg_data.vpower;
> +			*val2 = (u32)(info->chip_reg_data.vpower >> 32);
> +			return IIO_VAL_INT_64;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->address) {
> +		case PAC1711_VBUS_REG_ADDR:
> +			/* Voltages - scale for millivolts */
> +			switch (info->chip_variant) {
> +			case PAC1711_PRODUCT_ID_1711:
> +			case PAC1711_PRODUCT_ID_1811:
> +				*val = PAC1711_VOLTAGE_MILLIVOLTS_MAX;
> +				break;
> +			case PAC1711_PRODUCT_ID_1721:
> +			case PAC1711_PRODUCT_ID_1821:
> +				*val = PAC1721_VOLTAGE_MILLIVOLTS_MAX;
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +
> +			*val2 = (info->vbus_mode == PAC1711_FULL_RANGE_BIPOLAR) ? 15 : 16;
> +
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		case PAC1711_VSENSE_REG_ADDR:
> +			/*
> +			 * Currents - scale for mA - depends on the channel's shunt value
> +			 * (100mV * 1000000) / (2^16 * shunt(uohm))
> +			 */
> +			*val = 1526;
> +			*val2 = info->shunt;
> +
> +			if (info->vsense_mode == PAC1711_FULL_RANGE_BIPOLAR)
> +				*val = *val << 1;
> +
> +			return IIO_VAL_FRACTIONAL;
> +		case PAC1711_VPOWER_REG_ADDR:
> +			/*
> +			 * Power - uW - it will use the combined scale
> +			 * for current and voltage
> +			 * current(mA) * voltage(mV) = power (uW)
> +			 */
> +			switch (info->chip_variant) {
> +			case PAC1711_PRODUCT_ID_1711:
> +			case PAC1711_PRODUCT_ID_1811:
> +				tmp = PAC1711_PRODUCT_VOLTAGE_PV_FSR;
> +				break;
> +			case PAC1711_PRODUCT_ID_1721:
> +			case PAC1711_PRODUCT_ID_1821:
> +				tmp = PAC1721_PRODUCT_VOLTAGE_PV_FSR;
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +
> +			do_div(tmp, info->shunt);
> +			*val = (int)tmp;
> +
> +			if ((info->vsense_mode == PAC1711_FULL_RANGE_UNIPOLAR &&
> +			     info->vbus_mode == PAC1711_FULL_RANGE_UNIPOLAR)  ||
> +			    info->vsense_mode == PAC1711_HALF_RANGE_BIPOLAR ||
> +			    info->vbus_mode == PAC1711_HALF_RANGE_BIPOLAR)
> +				*val2 = 32;
> +			else
> +				*val2 = 31;
> +
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = pac1711_samp_rate_map_tbl[info->sample_rate_idx];
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int pac1711_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct pac1711_chip_info *info = iio_priv(indio_dev);
> +	struct i2c_client *client = info->client;
> +	struct device *dev = &info->client->dev;
> +	s32 old_samp_rate;
> +	int new_idx, ret;
> +	__be16 tmp_be16;
> +	u16 tmp_u16;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		scoped_guard(mutex, &info->lock) {
> +			old_samp_rate = pac1711_samp_rate_map_tbl[info->sample_rate_idx];
> +			new_idx = pac1711_get_samp_rate_idx(val);
> +			if (new_idx < 0)
> +				return new_idx;
> +
> +			ret = i2c_smbus_read_i2c_block_data(client, PAC1711_CTRL_ACT_REG_ADDR,
> +							    sizeof(tmp_u16), (u8 *)&tmp_be16);
> +			if (ret < 0) {
> +				dev_err(&client->dev, "cannot read regs from 0x%02X\n",
> +					PAC1711_CTRL_ACT_REG_ADDR);
> +				return ret;
> +			}
> +
> +			tmp_u16 = be16_to_cpu(tmp_be16);
> +			tmp_u16 &= ~PAC1711_CTRL_SAMPLE_MODE_MASK;
> +			tmp_u16 |= FIELD_PREP(PAC1711_CTRL_SAMPLE_MODE_MASK, new_idx);
> +			tmp_be16 = cpu_to_be16(tmp_u16);
> +
> +			ret = i2c_smbus_write_word_data(client, PAC1711_CTRL_REG_ADDR, tmp_be16);
> +			if (ret < 0) {
> +				dev_err(&client->dev, "Failed to configure sampling mode\n");
> +				return ret;
> +			}
> +
> +			info->sample_rate_idx = new_idx;
> +			info->chip_reg_data.ctrl_act_reg = tmp_u16;
> +		}
> +
> +		/* Force register snapshot and timestamp update with a refresh. */
> +		info->chip_reg_data.jiffies_tstamp -= msecs_to_jiffies(PAC1711_MIN_POLLING_TIME_MS);
> +		ret = pac1711_retrieve_data(info, (1024 / old_samp_rate) * 1000);
> +		if (ret) {
> +			dev_err(dev, "%s - cannot snapshot ctrl and measurement regs\n", __func__);
> +			return ret;
> +		}
> +
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static void pac1711_work_periodic_rfsh(struct work_struct *work)

Can we spell out refresh? Looks like r-fish to me. :-)

> +{
> +	struct pac1711_chip_info *info = TO_PAC1711_CHIP_INFO((struct delayed_work *)work);
> +	struct device *dev = &info->client->dev;
> +
> +	dev_dbg(dev, "%s - Periodic refresh\n", __func__);
> +
> +	/* Do a REFRESH, then read */
> +	pac1711_reg_snapshot(info, true, PAC1711_REFRESH_REG_ADDR,
> +			     PAC1711_MIN_UPDATE_WAIT_TIME_US);
> +
> +	schedule_delayed_work(&info->work_chip_rfsh,
> +			      msecs_to_jiffies(PAC1711_MAX_RFSH_LIMIT_MS));
> +}
> +
> +static int pac1711_chip_identify(struct iio_dev *indio_dev, struct pac1711_chip_info *info)
> +{
> +	struct i2c_client *client = info->client;
> +	struct device *dev = &client->dev;
> +	u8 chip_rev_info[3];
> +	int ret;
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, PAC1711_PID_REG_ADDR,
> +					    sizeof(chip_rev_info), chip_rev_info);
> +	if (ret < 0) {
> +		dev_info(&client->dev, "cannot read product ID reg\n");
> +		return ret;
> +	}
> +
> +	info->chip_variant = chip_rev_info[0];
> +	switch (info->chip_variant) {
> +	case PAC1711_PRODUCT_ID_1711:
> +		info->is_pac18x1_family = false;
> +		info->voltage_range_idx = PAC1711_VOLTAGE_RANGE_IDX;
> +		indio_dev->name = pac1711_chip_features.name;
> +		break;
> +	case PAC1711_PRODUCT_ID_1721:
> +		info->is_pac18x1_family = false;
> +		info->voltage_range_idx = PAC1721_VOLTAGE_RANGE_IDX;
> +		indio_dev->name = pac1721_chip_features.name;
> +		break;
> +	case PAC1711_PRODUCT_ID_1811:
> +		info->is_pac18x1_family = true;
> +		info->voltage_range_idx = PAC1711_VOLTAGE_RANGE_IDX;
> +		indio_dev->name = pac1811_chip_features.name;
> +		break;
> +	case PAC1711_PRODUCT_ID_1821:
> +		info->is_pac18x1_family = true;
> +		info->voltage_range_idx = PAC1721_VOLTAGE_RANGE_IDX;
> +		indio_dev->name = pac1821_chip_features.name;
> +		break;
> +	default:
> +		dev_info(dev, "product ID (0x%02X, 0x%02X, 0x%02X) not recognized\n",
> +			 chip_rev_info[0], chip_rev_info[1], chip_rev_info[2]);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pac1711_check_range(struct device *dev, s32 *vals, bool is_vbus,
> +			       unsigned int voltage_range_idx)
> +{
> +	int num_ranges = ARRAY_SIZE(pac1711_vbus_range_tbl[PAC1711_VOLTAGE_RANGE_IDX]);
> +	const int (*ranges)[3][2];
> +	int i;
> +
> +	if (is_vbus)
> +		switch (voltage_range_idx) {
> +		case PAC1711_VOLTAGE_RANGE_IDX:
> +			ranges = &pac1711_vbus_range_tbl[PAC1711_VOLTAGE_RANGE_IDX];
> +			break;
> +		case PAC1721_VOLTAGE_RANGE_IDX:
> +			ranges = &pac1711_vbus_range_tbl[PAC1721_VOLTAGE_RANGE_IDX];
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	else
> +		ranges = &pac1711_vsense_range_tbl;
> +
> +	for (i = 0; i < num_ranges; i++) {
> +		if (vals[0] == (*ranges)[i][0] && vals[1] == (*ranges)[i][1])
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int pac1711_init_vbus_vsense_ranges(struct pac1711_chip_info *info, bool is_vbus)
> +{
> +	struct i2c_client *client = info->client;
> +	struct device *dev = &client->dev;
> +	const char *prop_name;
> +	s32 vals[2];
> +	int ret;
> +
> +	if (is_vbus)
> +		prop_name = "microchip,vbus-input-range-microvolt";
> +	else
> +		prop_name = "microchip,vsense-input-range-microvolt";
> +
> +	ret = device_property_read_u32_array(dev, prop_name, vals, 2);
> +	if (ret) {
> +		dev_dbg(dev, "%s property error %X\n", prop_name, ret);
> +		/* Set default range to PAC1711_FULL_RANGE_UNIPOLAR */
> +		ret = PAC1711_FULL_RANGE_UNIPOLAR;
> +	} else {
> +		ret = pac1711_check_range(dev, vals, is_vbus, info->voltage_range_idx);
> +		if (ret < 0)
> +			return dev_err_probe(dev, -EINVAL, "Invalid value %d, %d for prop %s\n",
> +					     vals[0], vals[1], prop_name);
> +	}
> +
> +	if (is_vbus)
> +		info->vbus_mode = ret;
> +	else
> +		info->vsense_mode = ret;
> +
> +	return 0;
> +}
> +
> +static int pac1711_parse_fw(struct i2c_client *client, struct pac1711_chip_info *info)
> +{
> +	struct device *dev = &client->dev;
> +	const char *temp;
> +	int ret = 0;
> +	int tmp;
> +
> +	ret = device_property_read_u32(dev, "shunt-resistor-micro-ohms", &info->shunt);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Shunt resistor property error\n");
> +
> +	if (!info->shunt)
> +		return dev_err_probe(dev, -EINVAL, "Invalid value for shunt resistor\n");
> +
> +	ret = pac1711_init_vbus_vsense_ranges(info, true);
> +	if (ret)
> +		return ret;
> +
> +	ret = pac1711_init_vbus_vsense_ranges(info, false);
> +	if (ret)
> +		return ret;
> +
> +	ret = device_property_read_string(dev, "microchip,accumulation-mode", &temp);
> +	if (ret) {
> +		info->accumulation_mode = PAC1711_ACCMODE_VPOWER;
> +		return 0;
> +	}
> +
> +	if (!strcmp(temp, PAC1711_ACC_VPOWER_STR))
> +		tmp = PAC1711_ACCMODE_VPOWER;
> +	else if (!strcmp(temp, PAC1711_ACC_VSENSE_STR))
> +		tmp = PAC1711_ACCMODE_VSENSE;
> +	else
> +		return dev_err_probe(dev, -EINVAL, "invalid accumulation-mode value %s\n", temp);
> +
> +	dev_dbg(dev, "Accumulation mode set to: %s\n", temp);
> +	info->accumulation_mode = tmp;
> +
> +	return 0;
> +}
> +
> +static void pac1711_cancel_delayed_work(void *dwork)
> +{
> +	cancel_delayed_work_sync(dwork);
> +}
> +
> +static int pac1711_chip_configure(struct pac1711_chip_info *info)
> +{
> +	struct i2c_client *client = info->client;
> +	struct device *dev = &client->dev;
> +	u32 post_refresh_wait;
> +	__be16 tmp_be16;
> +	u32 wait_time;
> +	u16 tmp_u16;
> +	int ret = 0;

Initializing this is dead code.

> +	u8 tmp_u8;

It would be more like existing code to rename all `tmp` to `val` here.
Applies to other places in this patch as well.

> +
> +	/*
> +	 * The current/voltage can be measured unidirectional, bidirectional or half FSR
> +	 * no SLOW triggered REFRESH, clear POR
> +	 */
> +	tmp_u8 = FIELD_PREP(PAC1711_NEG_PWR_FSR_VS_MASK, info->vsense_mode) |
> +		FIELD_PREP(PAC1711_NEG_PWR_FSR_VB_MASK, info->vbus_mode);
> +
> +	ret = i2c_smbus_write_byte_data(client, PAC1711_NEG_PWR_FSR_REG_ADDR, tmp_u8);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "cannot write 0x%02X reg\n",
> +				     PAC1711_NEG_PWR_FSR_REG_ADDR);
> +
> +	ret = i2c_smbus_write_byte_data(client, PAC1711_SLOW_REG_ADDR, 0);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "cannot write 0x%02X reg\n", PAC1711_SLOW_REG_ADDR);
> +
> +	/* Get sampling rate from PAC */
> +	ret = i2c_smbus_read_i2c_block_data(client, PAC1711_CTRL_REG_ADDR,
> +					    sizeof(tmp_u16), (u8 *)&tmp_be16);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "cannot read 0x%02X reg\n", PAC1711_CTRL_REG_ADDR);
> +
> +	tmp_u16 = be16_to_cpu(tmp_be16);
> +	info->sample_rate_idx = FIELD_GET(PAC1711_CTRL_SAMPLE_MODE_MASK, tmp_u16);
> +	if (info->sample_rate_idx >= ARRAY_SIZE(pac1711_samp_rate_map_tbl)) {
> +		/*
> +		 * Use default sample rate in case the chip is configured with an sample
> +		 * rate unsupported by the driver. The Control Register is updated.
> +		 */
> +		info->sample_rate_idx = PAC1711_SAMP_1024SPS;
> +
> +		tmp_u16 &= ~PAC1711_CTRL_SAMPLE_MODE_MASK;
> +		tmp_u16 |= FIELD_PREP(PAC1711_CTRL_SAMPLE_MODE_MASK, info->sample_rate_idx);
> +	}
> +
> +	/* Configure the accumulation mode */
> +	tmp_u16 &= ~PAC1711_CTRL_ACC_MODE_MASK;
> +	tmp_u16 |= FIELD_PREP(PAC1711_CTRL_ACC_MODE_MASK, info->accumulation_mode);
> +
> +	tmp_be16 = cpu_to_be16(tmp_u16);
> +	ret = i2c_smbus_write_word_data(client, PAC1711_CTRL_REG_ADDR, tmp_be16);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "cannot write 0x%02X reg\n", PAC1711_CTRL_REG_ADDR);
> +
> +	/*
> +	 * Sending a REFRESH to the chip, so the new settings take place
> +	 * as well as resetting the accumulators
> +	 */
> +	ret = i2c_smbus_write_byte(client, PAC1711_REFRESH_REG_ADDR);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "cannot write 0x%02X reg\n",
> +				     PAC1711_REFRESH_REG_ADDR);
> +
> +	if (info->sample_rate_idx < ARRAY_SIZE(pac1711_samp_rate_map_tbl) &&
> +	    pac1711_samp_rate_map_tbl[info->sample_rate_idx] > 0)
> +		post_refresh_wait = 1000000 / pac1711_samp_rate_map_tbl[info->sample_rate_idx];
> +	else
> +		post_refresh_wait = 1000;
> +
> +	fsleep(post_refresh_wait);
> +
> +	/*
> +	 * Get the current (in the chip) sampling speed and compute the
> +	 * required timeout based on its value the timeout is 1/sampling_speed
> +	 * wait the maximum amount of time to be on the safe side - the
> +	 * maximum wait time is for 8sps
> +	 */
> +	wait_time = (1024 / pac1711_samp_rate_map_tbl[info->sample_rate_idx]) * 1000;
> +	fsleep(wait_time);
> +

Please include some comments in the code on the reasoning behind needing
a background refresh worker. This is a bit unusual. Usually we would poll
or use and interrupt to find out when data is read.

> +	INIT_DELAYED_WORK(&info->work_chip_rfsh, pac1711_work_periodic_rfsh);
> +	/* Setup the latest moment for reading the regs before saturation */
> +	schedule_delayed_work(&info->work_chip_rfsh,
> +			      msecs_to_jiffies(PAC1711_MAX_RFSH_LIMIT_MS));
> +
> +	return devm_add_action_or_reset(&client->dev, pac1711_cancel_delayed_work,
> +					&info->work_chip_rfsh);
> +}
> +
> +static struct iio_chan_spec pac1711_chan_spec[] = {
> +	PAC1711_VPOWER_CHANNEL(0, PAC1711_VPOWER_REG_ADDR),
> +	PAC1711_VBUS_CHANNEL(0, PAC1711_VBUS_REG_ADDR),
> +	PAC1711_VSENSE_CHANNEL(0, PAC1711_VSENSE_REG_ADDR),
> +};
> +
> +static int pac1711_prep_custom_attributes(struct pac1711_chip_info *info, struct iio_dev *indio_dev)
> +{
> +	struct device *dev = &info->client->dev;
> +	struct attribute_group *pac1711_group;
> +
> +	pac1711_group = devm_kzalloc(dev, sizeof(*pac1711_group), GFP_KERNEL);

If we always use this, why does it need to be dynamically allocated?

> +	if (!pac1711_group)
> +		return -ENOMEM;
> +
> +	switch (info->accumulation_mode) {
> +	case PAC1711_ACCMODE_VPOWER:
> +		pac1711_group->attrs = pac1711_power_acc_attr;
> +		break;
> +	case PAC1711_ACCMODE_VSENSE:
> +		pac1711_group->attrs = pac1711_coulomb_counter_attr;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

Why limit to only one or the other? They both have enable attributes,
so just don't let both be enabled at the same time.

> +
> +	info->iio_info.attrs = pac1711_group;
> +
> +	return 0;
> +}
> +
> +static int pac1711_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *channel,
> +			      const int **vals, int *type, int *length, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*type = IIO_VAL_INT;
> +		*vals = pac1711_samp_rate_map_tbl;
> +		*length = ARRAY_SIZE(pac1711_samp_rate_map_tbl);
> +		return IIO_AVAIL_LIST;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info pac1711_info = {
> +	.read_raw = pac1711_read_raw,
> +	.write_raw = pac1711_write_raw,
> +	.read_avail = pac1711_read_avail,
> +};
> +
> +static int pac1711_probe(struct i2c_client *client)
> +{
> +	const struct pac1711_features *chip;
> +	struct device *dev = &client->dev;
> +	struct pac1711_chip_info *info;
> +	struct iio_dev *indio_dev;
> +	int ret, err;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	info = iio_priv(indio_dev);
> +	info->client = client;
> +
> +	ret = pac1711_chip_identify(indio_dev, info);
> +	if (ret) {
> +		/*
> +		 * If it fails to identify the hardware based on internal
> +		 * registers, use compatible from devicetree.
> +		 */
> +		chip = i2c_get_match_data(client);
> +		if (!chip)
> +			return -EINVAL;
> +
> +		info->chip_variant = chip->prod_id;
> +		indio_dev->name = chip->name;
> +	}
> +
> +	/* Always start with accumulation channels enabled. */
> +	info->enable_acc = true;
> +
> +	err = pac1711_parse_fw(client, info);
> +	if (err)
> +		return dev_err_probe(dev, err, "Error parsing devicetree data\n");
> +
> +	ret = devm_mutex_init(dev, &info->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = pac1711_chip_configure(info);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->num_channels = ARRAY_SIZE(pac1711_chan_spec);
> +	indio_dev->channels = pac1711_chan_spec;
> +	info->iio_info = pac1711_info;
> +	indio_dev->info = &info->iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = pac1711_prep_custom_attributes(info, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Can't configure custom attributes\n");
> +
> +	/* Read what has been accumulated in the chip so far and reset the accumulators. */
> +	ret = pac1711_reg_snapshot(info, true, PAC1711_REFRESH_REG_ADDR,
> +				   PAC1711_MIN_UPDATE_WAIT_TIME_US);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Can't register IIO device\n");
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id pac1711_id[] = {
> +	{ .name = "pac1711", .driver_data = (kernel_ulong_t)&pac1711_chip_features },
> +	{ .name = "pac1721", .driver_data = (kernel_ulong_t)&pac1721_chip_features },
> +	{ .name = "pac1811", .driver_data = (kernel_ulong_t)&pac1811_chip_features },
> +	{ .name = "pac1821", .driver_data = (kernel_ulong_t)&pac1821_chip_features },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, pac1711_id);
> +
> +static const struct of_device_id pac1711_of_match[] = {
> +	{
> +		.compatible = "microchip,pac1711",
> +		.data = &pac1711_chip_features
> +	},
> +	{
> +		.compatible = "microchip,pac1721",
> +		.data = &pac1721_chip_features
> +	},
> +	{
> +		.compatible = "microchip,pac1811",
> +		.data = &pac1811_chip_features
> +	},
> +	{
> +		.compatible = "microchip,pac1821",
> +		.data = &pac1821_chip_features
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, pac1711_of_match);
> +
> +static struct i2c_driver pac1711_driver = {
> +	.driver	 = {
> +		.name = "pac1711",
> +		.of_match_table = pac1711_of_match,
> +	},
> +	.probe = pac1711_probe,
> +	.id_table = pac1711_id,
> +};
> +
> +module_i2c_driver(pac1711_driver);
> +
> +MODULE_AUTHOR("Ariana Lazar <ariana.lazar@microchip.com>");
> +MODULE_DESCRIPTION("IIO driver for PAC1711 DC Power Monitor with Accumulator");
> +MODULE_LICENSE("GPL");
> 

