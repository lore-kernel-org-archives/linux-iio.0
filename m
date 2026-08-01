Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE1B3A874A
	for <linux-iio@vger.kernel.org>; Sat,  1 Aug 2026 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785602525; cv=none; b=q+rc2TgPqQD2PTk2XFj7TtmXe7tdZIowcqZxzHv4ZFDepDYb/FhtoOChPMtLVm9X+CPm0OV3VlGoH5YEMlQJS24F+YcXqJVveHUFemualbnMI9peCEYmWKWs3xCUUz7OlwtAnqR1OgeX5q+3bhr1iC+GXbpNsi/UrTlAAXqua1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785602525; c=relaxed/simple;
	bh=8W4ZSqDWaGXltT5HClCxZRiq8VIILVezGC4RtEa8wDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRCX9K4X9ZCVnDmhQ6XRmaH2N94Ye/YoDExiMpvRACjFx2ahU53xy0eK8cwWqQ3Z+PbwKx8mzTHv2FX89/+FqR+18VcTjmXfevsB5PyocZHVz9Lital7k4IW41QGTm7wdyYWsteD+Hh3bgIEV5KvJyXwXDXHwZPzOdYETwUv8Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=T1Wcj7yP; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="T1Wcj7yP"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-448cf99c133so3542259fac.1
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2026 09:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785602519; x=1786207319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jy42D8iEKVBLHhWyu1QP32elidL6jWwQTk9frttBMM0=;
        b=T1Wcj7yPEN8MWyB85vs/hC+1kSdqUZ4QW0LJ9G9gFw4bYdiaM2lA4evN4rwxhiNT2x
         wHnoqLZYGesJK7pDW/CCAbrZmiWku5SXhW+EhEGOoVmlGbOwIDP1BgnKXW/u+x5hdMF8
         +B8rH683FQr435sTpW/i5DStQVqrOXbmqYy+hXL84viQZjGRBwu92sLYSl1uNsTI22k1
         ZCAG22fzsMILAcmoO4+AD5WDmbmTcZYCbHpNYrL9odUtXgDnGn8qCRaetU4HKXBFopg0
         FVapoJkbEDCwbVEM/swKxYmbDR4yX6Ay75073WHa77b6UwkVGFeIdxVOCDOtXujcUQ8t
         /OxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785602519; x=1786207319;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jy42D8iEKVBLHhWyu1QP32elidL6jWwQTk9frttBMM0=;
        b=eTuqJWu/a5dBoqrRBmv85xvLucIW5zRUEB9uJXXV2HrR9UnwpLx8Q6UdoHH5jwE3RY
         x1oVh2D4Exd9ueyqXa/p57EtvpuHgH9pzcNtghA0xKt/T6ZUiGtkX9pVHS2YiEJlTDmM
         ZqSbWRLe1I8BkMHS0xNdXBjZdmEi4l9qFKFKVgqgoDRoKMqExUAx+MDBeyJvV02j6cWb
         OtbFsGwGBYC3sPbgjozfDQ70t8tMxylEHYCa2Nq+X9gkxHcAqDuL32VwMPY1pO6bQ/2Y
         z9ZyWMVj85nZ+wL9ChegBrR5dggiOaMPEccAAvY/t3IbqTc/a9l4Cnc9LE112on0rOkh
         6SVw==
X-Gm-Message-State: AOJu0YzXYkD3ip1XGwJwTWq7S936JhKXmPrelFQYM5+P32F6zC28fF1q
	JpIvewgvmd9cEc3UBqXisU+9cprCGSgvgdIw0CTpfWfLo+0KLppI/LdyipbSIZUmK6k=
X-Gm-Gg: AR+sD11WZHxguTC7UNFkyolhGiqKCJ4KhXRm1coKJxyhVg/9tOxRT/e+MEteAEyJnic
	ImD4SnPoJ7Swr7jJohEWsU8ZatWqlotgjecS8jGKmCzC/gjIbpTPfbAxshrAZMpoAQICILDBxk1
	50SYWK2IFWD38Ce2R2ux0ERRL6WznpBUHpFKQU3CF9Wn84Qr03sY+KROBhLK0SQEeAcvSMDHtPX
	ih5jiiXb+jDewyWW6WXSNTRP97MzcRxWmpYI5d6Pp65WyQ1TD/Aj7avGhFZRmd9xs3/KmbtekUR
	D6AX0kpoo2VhBGmMp8VY/g0s/LRUXP/+SZrT1QtVff3fjEgKVbgf7yEjPnYnu8lXj4wrIJDx6eX
	D6+vPz8xYGeS9coXI3tRDPrBHWYZp+RGCsQYoiySsUsFSJbfcBQ8fKNtn9iJ8cYD+WMKhRKvK8O
	BlkqIfL7JLApOKHakdmRib5lUBzx7QO6yo6BN4YxSV++VIswBAL5/tT7Xw3lMlQUbG2UZvbQO+S
	88vY+D5Zn3UJCTVGGnm++NE2lzy0Gy/Lxo8ebI=
X-Received: by 2002:a05:6808:c1f5:b0:49a:7714:ed25 with SMTP id 5614622812f47-4ae3188b047mr11032582b6e.3.1785602518709;
        Sat, 01 Aug 2026 09:41:58 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:359b:17f1:d4f9:4949? ([2600:8803:e7e4:500:359b:17f1:d4f9:4949])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458f664d884sm4300209fac.12.2026.08.01.09.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 09:41:57 -0700 (PDT)
Message-ID: <380b864f-6266-40fb-87a4-027afb422885@baylibre.com>
Date: Sat, 1 Aug 2026 11:41:56 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] iio: proximity: add driver for Sharp GP2AP070S
 proximity sensor
To: Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Griffin
 <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20260731-gp2ap070s-v3-0-d1f5cecf9fe7@disroot.org>
 <20260731-gp2ap070s-v3-2-d1f5cecf9fe7@disroot.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260731-gp2ap070s-v3-2-d1f5cecf9fe7@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/26 3:07 PM, Kaustabh Chakraborty wrote:
> The GP2AP070S is a proximity sensor designed and manufactured by Sharp
> Corporation. This sensor is used in mobile devices, including, but not
> limited to - the Samsung Galaxy J6.
> 
> The driver has been adopted from Samsung's downstream kernel
> implementation [1]. Due to the lack of public documentation about the
> schematics of this device. The downstream driver acts as the secondary
> source of information. Driver clarity has also been improved with the
> help of the GP2AP* drivers in iio/light.
> 
> Link: https://github.com/Exynos7870/android_kernel_samsung_universal7870/blob/lineage-16.0/drivers/sensors/gp2ap070s.c [1]
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  drivers/iio/proximity/Kconfig     |  11 +
>  drivers/iio/proximity/Makefile    |   1 +
>  drivers/iio/proximity/gp2ap070s.c | 505 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 517 insertions(+)
> 
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index bb77fad2a1b3..39db19e59650 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -41,6 +41,17 @@ config D3323AA
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called d3323aa.
>  
> +config GP2AP070S
> +	tristate "Sharp GP2AP070S proximity sensor"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Say Y here to build a driver for the Sharp GP2AP070S proximity
> +	  sensor.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called gp2ap070s.
> +
>  config HX9023S
>  	tristate "TYHX HX9023S SAR sensor"
>  	select IIO_BUFFER
> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> index 4352833dd8a4..627ffb04acb2 100644
> --- a/drivers/iio/proximity/Makefile
> +++ b/drivers/iio/proximity/Makefile
> @@ -7,6 +7,7 @@
>  obj-$(CONFIG_AS3935)		+= as3935.o
>  obj-$(CONFIG_CROS_EC_MKBP_PROXIMITY) += cros_ec_mkbp_proximity.o
>  obj-$(CONFIG_D3323AA)		+= d3323aa.o
> +obj-$(CONFIG_GP2AP070S)		+= gp2ap070s.o
>  obj-$(CONFIG_HX9023S)		+= hx9023s.o
>  obj-$(CONFIG_IRSD200)		+= irsd200.o
>  obj-$(CONFIG_ISL29501)		+= isl29501.o
> diff --git a/drivers/iio/proximity/gp2ap070s.c b/drivers/iio/proximity/gp2ap070s.c
> new file mode 100644
> index 000000000000..98fc12e5ccd5
> --- /dev/null
> +++ b/drivers/iio/proximity/gp2ap070s.c
> @@ -0,0 +1,505 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * IIO driver for Sharp GP2AP070S proximity sensor.
> + *
> + * Based on Samsung G610FXXU1CRI4 kernel driver - drivers/sensors/gp2ap070s.c
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + * Copyright (c) 2026 Kaustabh Chakraborty <kauschluss@disroot.org>
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>
> +
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +
> +#define GP2AP070S_REG_COM1		0x80
> +#define   GP2AP070S_COM1_WKUP		BIT(7)
> +#define   GP2AP070S_COM1_EN		BIT(5)
> +
> +#define GP2AP070S_REG_COM2		0x81
> +
> +#define GP2AP070S_REG_COM3		0x82
> +#define   GP2AP070S_COM3_INT_PULSE	BIT(1)
> +
> +#define GP2AP070S_REG_COM4		0x83
> +#define   GP2AP070S_COM4_BLINK		GENMASK(2, 0)	/* LED Blink Interval */
> +#define     GP2AP070S_COM4_BLINK_0ms	0
> +#define     GP2AP070S_COM4_BLINK_2ms	1
> +#define     GP2AP070S_COM4_BLINK_8ms	2
> +#define     GP2AP070S_COM4_BLINK_33ms	3
> +#define     GP2AP070S_COM4_BLINK_66ms	4
> +#define     GP2AP070S_COM4_BLINK_131ms	5
> +#define     GP2AP070S_COM4_BLINK_262ms	6
> +#define     GP2AP070S_COM4_BLINK_524ms	7
> +
> +#define GP2AP070S_REG_PS1		0x85
> +#define   GP2AP070S_PS1_RESOL		GENMASK(5, 4)	/* Resolution */
> +#define     GP2AP070S_PS1_RESOL_14ms	0
> +#define     GP2AP070S_PS1_RESOL_12ms	1
> +#define     GP2AP070S_PS1_RESOL_10ms	2
> +#define     GP2AP070S_PS1_RESOL_8ms	3
> +
> +#define GP2AP070S_REG_PS2		0x86
> +#define   GP2AP070S_PS2_IOUT		GENMASK(6, 4)	/* Current Output */
> +#define     GP2AP070S_PS2_IOUT_0mA	0
> +#define     GP2AP070S_PS2_IOUT_24mA	1
> +#define     GP2AP070S_PS2_IOUT_89mA	2
> +#define     GP2AP070S_PS2_IOUT_130mA	3
> +#define     GP2AP070S_PS2_IOUT_190mA	4
> +#define   GP2AP070S_PS2_SUM32		BIT(2)
> +
> +#define GP2AP070S_REG_PS3		0x87
> +#define   GP2AP070S_PS3_PRST		GENMASK(6, 4)	/* Repeating Measurements */
> +
> +#define GP2AP070S_REG_PS_THD_LO_LE16	0x88
> +#define GP2AP070S_REG_PS_THD_HI_LE16	0x8a
> +#define GP2AP070S_REG_D0_LE16		0x90
> +
> +struct gp2ap070s_drvdata {
> +	struct regmap *regmap;
> +	struct mutex mutex;
> +	u32 near_level;
> +};
> +
> +static bool gp2ap070s_regmap_volatile(struct device *dev, unsigned int reg)
> +{
> +	return reg == GP2AP070S_REG_D0_LE16;
> +}
> +
> +static const struct regmap_config gp2ap070s_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.volatile_reg = gp2ap070s_regmap_volatile,

Always helpful to set .max_register.


> +};
> +
> +static const char *const gp2ap070s_regulator_names[] = {
> +	"vdd",
> +	"vled",
> +};
> +
> +static ssize_t gp2ap070s_iio_read_near_level(struct iio_dev *indio_dev,
> +					     uintptr_t priv,
> +					     const struct iio_chan_spec *chan,
> +					     char *buf)
> +{
> +	struct gp2ap070s_drvdata *drvdata = iio_priv(indio_dev);
> +
> +	return sysfs_emit(buf, "%u\n", drvdata->near_level);
> +}
> +
> +static const struct iio_chan_spec_ext_info gp2ap070s_iio_chan_spec_ext_info[] = {
> +	{
> +		.name = "nearlevel",
> +		.shared = IIO_SEPARATE,
> +		.read = gp2ap070s_iio_read_near_level,
> +	},
> +	{ }
> +};
> +
> +static const struct iio_event_spec gp2ap070s_iio_event_spec[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +static const struct iio_chan_spec gp2ap070s_iio_chan_spec[] = {
> +	{
> +		.type = IIO_PROXIMITY,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.ext_info = gp2ap070s_iio_chan_spec_ext_info,
> +		.event_spec = gp2ap070s_iio_event_spec,
> +		.num_event_specs = ARRAY_SIZE(gp2ap070s_iio_event_spec),
> +	},
> +};
> +
> +static int gp2ap070s_iio_read_raw(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan, int *val,
> +				  int *val2, long mask)
> +{
> +	struct gp2ap070s_drvdata *drvdata = iio_priv(indio_dev);
> +	__le16 value;
> +	int ret;
> +
> +	ret = regmap_bulk_read(drvdata->regmap, GP2AP070S_REG_D0_LE16, &value,
> +			       sizeof(value));
> +	if (ret)
> +		return ret;
> +
> +	*val = le16_to_cpu(value);
> +	return IIO_VAL_INT;
> +}
> +
> +static int gp2ap070s_iio_read_event_value(struct iio_dev *indio_dev,
> +					  const struct iio_chan_spec *chan,
> +					  enum iio_event_type type,
> +					  enum iio_event_direction dir,
> +					  enum iio_event_info info, int *val,
> +					  int *val2)
> +{
> +	struct gp2ap070s_drvdata *drvdata = iio_priv(indio_dev);
> +	__le16 value;
> +	int ret;
> +
> +	if (type != IIO_EV_TYPE_THRESH || info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	guard(mutex)(&drvdata->mutex);
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		ret = regmap_bulk_read(drvdata->regmap,
> +				       GP2AP070S_REG_PS_THD_HI_LE16, &value,
> +				       sizeof(value));
> +		if (ret)
> +			return ret;
> +
> +		*val = le16_to_cpu(value);
> +		return IIO_VAL_INT;
> +	case IIO_EV_DIR_FALLING:
> +		ret = regmap_bulk_read(drvdata->regmap,
> +				       GP2AP070S_REG_PS_THD_LO_LE16, &value,
> +				       sizeof(value));
> +		if (ret)
> +			return ret;
> +
> +		*val = le16_to_cpu(value);
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int gp2ap070s_iio_write_event_value(struct iio_dev *indio_dev,
> +					   const struct iio_chan_spec *chan,
> +					   enum iio_event_type type,
> +					   enum iio_event_direction dir,
> +					   enum iio_event_info info, int val,
> +					   int val2)
> +{
> +	struct gp2ap070s_drvdata *drvdata = iio_priv(indio_dev);
> +	__le16 value;
> +	u16 threshold_other;
> +	int ret;
> +
> +	if (type != IIO_EV_TYPE_THRESH || info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	/* Ensure val is a 16-bit value */
> +	if (val < 0 || val >= (1 << 16))

				BIT(16)

> +		return -EINVAL;
> +
> +	guard(mutex)(&drvdata->mutex);
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		ret = regmap_bulk_read(drvdata->regmap,
> +				       GP2AP070S_REG_PS_THD_LO_LE16, &value,
> +				       sizeof(value));
> +		if (ret)
> +			return ret;
> +
> +		/* Ensure lo_threshold < hi_threshold */
> +		threshold_other = le16_to_cpu(value);
> +		if (threshold_other >= val)
> +			return -EINVAL;
> +
> +		value = cpu_to_le16((u16)val);

Unnecessary cast.

> +		ret = regmap_bulk_write(drvdata->regmap,
> +					GP2AP070S_REG_PS_THD_HI_LE16, &value,
> +					sizeof(value));
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_EV_DIR_FALLING:
> +		ret = regmap_bulk_read(drvdata->regmap,
> +				       GP2AP070S_REG_PS_THD_HI_LE16, &value,
> +				       sizeof(value));
> +		if (ret)
> +			return ret;
> +
> +		/* Ensure hi_threshold > lo_threshold */
> +		threshold_other = le16_to_cpu(value);
> +		if (threshold_other <= val)
> +			return -EINVAL;
> +
> +		value = cpu_to_le16((u16)val);
> +		ret = regmap_bulk_write(drvdata->regmap,
> +					GP2AP070S_REG_PS_THD_LO_LE16, &value,
> +					sizeof(value));
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int gp2ap070s_read_event_config(struct iio_dev *indio_dev,
> +				       const struct iio_chan_spec *chan,
> +				       enum iio_event_type type,
> +				       enum iio_event_direction dir)
> +{
> +	struct gp2ap070s_drvdata *drvdata = iio_priv(indio_dev);
> +	unsigned int value;
> +	int ret;
> +
> +	if (type != IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	guard(mutex)(&drvdata->mutex);
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_EITHER:
> +		ret = regmap_read(drvdata->regmap, GP2AP070S_REG_COM3, &value);
> +		if (ret)
> +			return ret;
> +
> +		return FIELD_GET(GP2AP070S_COM3_INT_PULSE, value);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int gp2ap070s_write_event_config(struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan,
> +					enum iio_event_type type,
> +					enum iio_event_direction dir,
> +					bool state)
> +{
> +	struct gp2ap070s_drvdata *drvdata = iio_priv(indio_dev);
> +
> +	if (type != IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	guard(mutex)(&drvdata->mutex);
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_EITHER:
> +		if (state)
> +			return regmap_set_bits(drvdata->regmap,
> +					       GP2AP070S_REG_COM3,
> +					       GP2AP070S_COM3_INT_PULSE);
> +		else
> +			return regmap_clear_bits(drvdata->regmap,
> +						 GP2AP070S_REG_COM3,
> +						 GP2AP070S_COM3_INT_PULSE);

Can use regmap_assign_bits() to avoid the if statement.

> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info gp2ap070s_iio_info = {
> +	.read_raw = gp2ap070s_iio_read_raw,
> +	.read_event_value = gp2ap070s_iio_read_event_value,
> +	.write_event_value = gp2ap070s_iio_write_event_value,
> +	.read_event_config = gp2ap070s_read_event_config,
> +	.write_event_config = gp2ap070s_write_event_config,
> +};
> +
> +static irqreturn_t gp2ap070s_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	s64 timestamp = iio_get_time_ns(indio_dev);
> +
> +	iio_push_event(indio_dev,
> +		       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0, IIO_EV_TYPE_THRESH,
> +					    IIO_EV_DIR_EITHER),
> +		       timestamp);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int gp2ap070s_reset(struct gp2ap070s_drvdata *drvdata)
> +{
> +	int ret;
> +
> +	ret = regmap_write(drvdata->regmap, GP2AP070S_REG_COM1, 0);
> +	if (ret)
> +		return ret;
> +
> +	regcache_mark_dirty(drvdata->regmap);

Doesn't this cause it to write all of the current cached values
therefore undoing the effects of the reset?

Maybe you meant regmap_reinit_cache()?

Also, gp2ap070s_regmap_config doesn't enable cache, so likely
this has no effect currently.

> +
> +	return 0;
> +}
> +
> +static void gp2ap070s_reset_action(void *private)
> +{
> +	struct gp2ap070s_drvdata *drvdata = private;

Usually, we don't bother with a cast/local variable in these.
The void* can be passed directly as an arg.

> +
> +	gp2ap070s_reset(drvdata);
> +}
> +
> +static int gp2ap070s_probe_hw_register(struct gp2ap070s_drvdata *drvdata)
> +{
> +	struct device *dev = regmap_get_device(drvdata->regmap);
> +	int ret;
> +
> +	ret = gp2ap070s_reset(drvdata);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to reset sensor\n");
> +
> +	ret = regmap_write(drvdata->regmap, GP2AP070S_REG_COM2, 0);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable interrupts\n");
> +
> +	ret = regmap_set_bits(drvdata->regmap, GP2AP070S_REG_COM3,
> +			      GP2AP070S_COM3_INT_PULSE);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to unmask interrupts\n");
> +
> +	ret = regmap_write_bits(drvdata->regmap, GP2AP070S_REG_COM4,
> +				GP2AP070S_COM4_BLINK,
> +				FIELD_PREP_CONST(GP2AP070S_COM4_BLINK,
> +						 GP2AP070S_COM4_BLINK_33ms));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set LED blink timing\n");
> +
> +	ret = regmap_write_bits(drvdata->regmap, GP2AP070S_REG_PS1,
> +				GP2AP070S_PS1_RESOL,
> +				FIELD_PREP_CONST(GP2AP070S_PS1_RESOL,
> +						 GP2AP070S_PS1_RESOL_10ms));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set resolution\n");
> +
> +	ret = regmap_write_bits(drvdata->regmap, GP2AP070S_REG_PS2,
> +				GP2AP070S_PS2_IOUT | GP2AP070S_PS2_SUM32,
> +				FIELD_PREP_CONST(GP2AP070S_PS2_IOUT,
> +						 GP2AP070S_PS2_IOUT_89mA) |
> +				GP2AP070S_PS2_SUM32);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set current output\n");
> +
> +	ret = regmap_write_bits(drvdata->regmap, GP2AP070S_REG_PS3,
> +				GP2AP070S_PS3_PRST,
> +				FIELD_PREP_CONST(GP2AP070S_PS3_PRST, 3));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set measurement repetitions\n");
> +
> +	ret = regmap_set_bits(drvdata->regmap, GP2AP070S_REG_COM1,
> +			      GP2AP070S_COM1_WKUP | GP2AP070S_COM1_EN);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable sensor\n");
> +
> +	return 0;
> +}
> +
> +static int gp2ap070s_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct gp2ap070s_drvdata *drvdata;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*drvdata));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	drvdata = iio_priv(indio_dev);
> +	drvdata->regmap = devm_regmap_init_i2c(client, &gp2ap070s_regmap_config);
> +	if (IS_ERR(drvdata->regmap))
> +		return dev_err_probe(dev, PTR_ERR(drvdata->regmap), "Failed to create regmap\n");
> +
> +	ret = devm_mutex_init(dev, &drvdata->mutex);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to initialize mutex\n");

Don't print here, just return ret.

> +
> +	ret = devm_regulator_bulk_get_enable(dev,
> +					     ARRAY_SIZE(gp2ap070s_regulator_names),
> +					     gp2ap070s_regulator_names);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get and enable regulators\n");
> +
> +	fsleep(10000);

We've been writing this like:

	fsleep(10 * (MICRO / MILLI));

Makes it a bit more obvious this is 10 ms.

> +
> +	indio_dev->name = "gp2ap070s";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = gp2ap070s_iio_chan_spec;
> +	indio_dev->num_channels = ARRAY_SIZE(gp2ap070s_iio_chan_spec);
> +	indio_dev->info = &gp2ap070s_iio_info;
> +
> +	if (device_property_present(dev, "proximity-near-level")) {
> +		ret = device_property_read_u32(dev, "proximity-near-level",
> +					       &drvdata->near_level);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to get value for proximity-near-level\n");
> +	}
> +
> +	ret = gp2ap070s_probe_hw_register(drvdata);
> +	if (ret)
> +		goto hw_reset;

gp2ap070s_probe_hw_register() needs to clean up after itself on
failure so we can return directly here.

> +
> +	ret = devm_add_action_or_reset(dev, gp2ap070s_reset_action, drvdata);
> +	if (ret) {
> +		ret = dev_err_probe(dev, ret, "Failed to schedule reset on driver removal\n");

We don't print error here because only error is -ENOMEM.

The reset action is also called on failure, so return error directly here.

> +		goto hw_reset;
> +	}
> +
> +	ret = devm_request_threaded_irq(dev, client->irq, NULL,
> +					gp2ap070s_irq_handler, IRQF_ONESHOT,
> +					"gp2ap070s-irq", indio_dev);
> +	if (ret)
> +		goto hw_reset;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		goto hw_reset;
> +
> +	return 0;
> +
> +hw_reset:
> +	gp2ap070s_reset(drvdata);

The callback registered by devm_add_action_or_reset() will
already call this on error return.

> +
> +	return ret;
> +}
> +
> +static const struct of_device_id gp2ap070s_of_device_id[] = {
> +	{ .compatible = "sharp,gp2ap070s" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, gp2ap070s_of_device_id);
> +
> +static const struct i2c_device_id gp2ap070s_i2c_device_id[] = {
> +	{ .name = "gp2ap070s" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, gp2ap070s_i2c_device_id);
> +
> +static struct i2c_driver gp2ap070s_i2c_driver = {
> +	.driver = {
> +		.name = "gp2ap070s",
> +		.of_match_table = gp2ap070s_of_device_id,
> +	},
> +	.probe = gp2ap070s_probe,
> +	.id_table = gp2ap070s_i2c_device_id,
> +};
> +module_i2c_driver(gp2ap070s_i2c_driver);
> +
> +MODULE_AUTHOR("Kaustabh Chakraborty <kauschluss@disroot.org>");
> +MODULE_DESCRIPTION("Sharp GP2AP070S Proximity Sensor");
> +MODULE_LICENSE("GPL");
> 

