Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58263EFFCE
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111177; cv=none; b=tdcs380rPAVK2y7Y5GG7ep+Wn1avPxCg38uyYqR7MaCsuepQlhrAE4WUjMw7MLRhCHChFb+yiUnF52vwxoVxhGP6vDwj6TiBEEAboG32ocx3xwtLpAuF3QKlRbFBL/9sUPxQ8n59cR45kEcOuKfmIwTVo6xTbE4e9nhpUfGTASc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111177; c=relaxed/simple;
	bh=tIO0FwL6Rf+Gh5rHDXFh8Lu03ijsVNx56h8Ri692Fus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prPh8G59VIopYZ0Ihx+EpGGPy5uqD40gmptW2NbDgKUMo8ddDUQO4fHgR/GLzTtJi71VO2CeSaWqoCHdQSKUDkdiZBVuqwAaAofUqsYhkSfnC4qmdyLSZ7HWQbUNLS4Ovb5YNxHHu+3LJBb7h49gqmnCxItkXMFqQc9ip8dSlvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pLO2vSfj; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLO2vSfj"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a884815606so2732970e87.0
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 06:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779111174; x=1779715974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b2hnj4S14R2EgiswMqZCyq8YIJqNclQ6RbOweMiuRYU=;
        b=pLO2vSfj5zQJRu9AMYc6pbB/oXrLvQDI0/Hyew9HskQiL5sTuezurmefwwpW30iU/m
         BuEeVy/fv814FZ5IUg8TVLrV3WCOZ0VCNwx70nvsNL/guq4qGPWKIr3Tj/PU60eC3sj9
         rKKQttJ55kex4G4uANaQg+wAvdMmIVnLlG6n+AG6qUz/TaLHnBNZ54DqqIANqj0jQdxd
         seleBJkLJWLH1ZDaUp2dGzXpRZUnWwORKlyhJ7f8Tztm6JRAhqWF9ZpLAtcyi3JiZuHS
         CyQwsEk3wESR3bpx5pdpnroDqydbyv02cbcN4mxE7ic2H6qwoYnQuFg0dfF+yauEb0dN
         wtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779111174; x=1779715974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b2hnj4S14R2EgiswMqZCyq8YIJqNclQ6RbOweMiuRYU=;
        b=B+U1yQDu4YrmE+FYUZsRMGcb0/IloKdr9GKdNZsOLCebpq9UP44Pl8n4uF6Ohgi3IL
         0hF7OYIE0oomfj7saQqYzrLODkJ4uCuKdADti9T58Ap1YOCb9++tSd61+cu1tQjFNe9k
         KFCVqOAJL1ofNy1jc6UIAF9pXSjShFXRyiSjuKmLYS1VQxyNy7j6DgCBkCEuThTVNJHD
         AFxC8l21z+CRLqyDn/WtpwU2Rdps1oIzAU/I/zo0505P3V9z/rT1AWTPlbYedsmf7mhA
         4rjy8Ai/YkAPnErasHWnS7J2t1VGKJoi8uaO2KiZ+YDROnKwBZzD/rJmOuutcGrgwpyq
         Tafg==
X-Gm-Message-State: AOJu0YzqOWXQp5JnqT+5vSc+NZDteZo9JJdjvpY/uf0JDymaa2w2qvWk
	csYYkP5j9vCUA508OGi+opsS56qQxk9jBDRs4SJ7VNLn6GOc9x/gnLCM
X-Gm-Gg: Acq92OFiv9zxHV/Xf1dUHtC8ljbn53x01pzyeziUm5NbphgerMB7Y0MY5UPLJHpxtnU
	p6uzAYy3zjWl0xBzERWXb0OLJ/8nwZPMT/4hqIOr0W//Vpvj5dE1qj7RJ5K4+m1jWQytPInAW95
	bRVQG5BWFKe+wSTqM51J0vtVcT3IxA5K1OyyUdcpKxEFOuWeEK2bkgMRROkyYb//OTS5gdE1x1t
	2wcq3tbVYgmg6av7CgPHIcTU7HPzNmAOTjEhMBetdD3kb1GIMt7Ss5r605UbvAlAaQcdgnQygZa
	R3i6x4DncBaRcUJ5eaD7ke6DifWk7MvdYLXSuTVE93DVITuoxE/L+rG4GyCuw/ywfgn068Hqf4Q
	36jy/y4tFS83sK3tXmmw1G9xVXw+s9VTFltOSdIfxJp4TIyigbF0kGewokahkNCZqIHG1ecx4cX
	iAxuiY4PCKb1GuQ+m60xxWDg5ZXCvlqTrhtOnWlPxS6lg=
X-Received: by 2002:a05:6512:1594:b0:5a8:9756:f6b8 with SMTP id 2adb3069b0e04-5aa0e7429a9mr4641107e87.35.1779111173600;
        Mon, 18 May 2026 06:32:53 -0700 (PDT)
Received: from [10.38.18.54] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f10c944sm3424294e87.6.2026.05.18.06.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 06:32:53 -0700 (PDT)
Message-ID: <3887db1c-235e-4398-8310-39bb1c93820f@gmail.com>
Date: Mon, 18 May 2026 16:32:51 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iio: light: add support for veml6031x00 ALS series
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
 <20260513-veml6031x00-v2-4-4703ca661a1d@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260513-veml6031x00-v2-4-4703ca661a1d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/05/2026 07:49, Javier Carrasco wrote:
> These sensors provide two light channels (ALS and IR), I2C communication
> and a multiplexed interrupt line to signal data ready and configurable
> threshold alarms.

Thanks for the patch! I did only a very quick review, sorry for that. 
Overall this looks nice! I think Jonathan already asked about the 
atomics - I agree it looks like locking might be needed.

Anyways, the GTS usage (at a glance) looked nice! :) Just very minor 
questions below.

Yours,
	-- Matti

> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>   MAINTAINERS                     |    6 +
>   drivers/iio/light/Kconfig       |   14 +
>   drivers/iio/light/Makefile      |    1 +
>   drivers/iio/light/veml6031x00.c | 1193 +++++++++++++++++++++++++++++++++++++++
>   4 files changed, 1214 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2fb1c75afd16..47da46717c16 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -28381,6 +28381,12 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml
>   F:	drivers/iio/light/veml6046x00.c
>   
> +VISHAY VEML6031X00 AMBIENT LIGHT SENSOR DRIVER
> +M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml

Is this needed? I was (once upon a time) asked to drop the binding doc 
file from the MAINTAINERS because the binding doc contains the 
maintainer information. Not sure if it is used by the get_maintainer.pl 
though, so maybe this is Ok?

> +F:	drivers/iio/light/veml6031x00.c
> +
>   VISHAY VEML6075 UVA AND UVB LIGHT SENSOR DRIVER
>   M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
>   S:	Maintained
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index eff33e456c70..b99f4e8d9a70 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -713,6 +713,20 @@ config VEML6030
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called veml6030.
>   
> +config VEML6031X00
> +	tristate "VEML6031X00 ambient light sensor series"
> +	select REGMAP_I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	select IIO_GTS_HELPER
> +	depends on I2C
> +	help
> +	  Say Y here if you want to build a driver for the Vishay VEML6031X00
> +	  ambient light sensor series.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called veml6031x00.
> +
>   config VEML6040
>   	tristate "VEML6040 RGBW light sensor"
>   	select REGMAP_I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index c0048e0d5ca8..a8cc03cfb6c2 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -66,6 +66,7 @@ obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
>   obj-$(CONFIG_VCNL4035)		+= vcnl4035.o
>   obj-$(CONFIG_VEML3235)		+= veml3235.o
>   obj-$(CONFIG_VEML6030)		+= veml6030.o
> +obj-$(CONFIG_VEML6031X00)	+= veml6031x00.o
>   obj-$(CONFIG_VEML6040)		+= veml6040.o
>   obj-$(CONFIG_VEML6046X00)	+= veml6046x00.o
>   obj-$(CONFIG_VEML6070)		+= veml6070.o
> diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
> new file mode 100644
> index 000000000000..c7808768f45a
> --- /dev/null
> +++ b/drivers/iio/light/veml6031x00.c
> @@ -0,0 +1,1193 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * VEML6031X00 Ambient Light Sensor
> + *
> + * Copyright (c) 2026, Javier Carrasco <javier.carrasco.cruz@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/units.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/iio-gts-helper.h>
> +
> +/* Device registers */
> +#define VEML6031X00_REG_CONF0       0x00
> +#define VEML6031X00_REG_CONF1       0x01
> +#define VEML6031X00_REG_WH_L        0x04
> +#define VEML6031X00_REG_WH_H        0x05
> +#define VEML6031X00_REG_WL_L        0x06
> +#define VEML6031X00_REG_WL_H        0x07
> +#define VEML6031X00_REG_ALS_L       0x10
> +#define VEML6031X00_REG_ALS_H       0x11
> +#define VEML6031X00_REG_IR_L        0x12
> +#define VEML6031X00_REG_IR_H        0x13
> +#define VEML6031X00_REG_ID_L        0x14
> +#define VEML6031X00_REG_ID_H        0x15
> +#define VEML6031X00_REG_INT         0x17
> +
> +/* Bit masks for specific functionality */
> +#define VEML6031X00_ALL_CH_MASK     GENMASK(1, 0)
> +#define VEML6031X00_CONF0_SD        BIT(0)
> +#define VEML6031X00_CONF0_AF_TRIG   BIT(2)
> +#define VEML6031X00_CONF0_AF        BIT(3)
> +#define VEML6031X00_CONF1_IR_SD     BIT(7)
> +#define VEML6031X00_INT_TH_H        BIT(1)
> +#define VEML6031X00_INT_TH_L        BIT(2)
> +#define VEML6031X00_INT_DRDY        BIT(3)
> +#define VEML6031X00_INT_MASK        (VEML6031X00_INT_TH_L | \
> +				     VEML6031X00_INT_TH_H | \
> +				     VEML6031X00_INT_DRDY)
> +
> +/* Autosuspend delay */
> +#define VEML6031X00_AUTOSUSPEND_MS  2000
> +
> +enum veml6031x00_scan {
> +	VEML6031X00_SCAN_ALS,
> +	VEML6031X00_SCAN_IR,
> +	VEML6031X00_SCAN_TIMESTAMP,
> +};
> +
> +struct veml6031x00_rf {
> +	struct regmap_field *gain;
> +	struct regmap_field *int_en;
> +	struct regmap_field *it;
> +	struct regmap_field *pd_div4;
> +	struct regmap_field *pers;
> +};
> +
> +struct veml6031x00_chip {
> +	const char *name;
> +	const int part_id;
> +};
> +
> +struct veml6031x00_data {
> +	struct device *dev;
> +	struct iio_gts gts;
> +	struct regmap *regmap;
> +	struct iio_trigger *trig;
> +	struct veml6031x00_rf rf;
> +	const struct veml6031x00_chip *chip;
> +	/* serialize access to irq enable/disable by events and trigger */
> +	struct mutex lock;
> +	atomic_t int_users;
> +	bool ev_en;
> +	bool trig_en;
> +};
> +
> +static const struct iio_itime_sel_mul veml6031x00_it_sel[] = {
> +	GAIN_SCALE_ITIME_US(3125, 0, 1),
> +	GAIN_SCALE_ITIME_US(6250, 1, 2),
> +	GAIN_SCALE_ITIME_US(12500, 2, 4),
> +	GAIN_SCALE_ITIME_US(25000, 3, 8),
> +	GAIN_SCALE_ITIME_US(50000, 4, 16),
> +	GAIN_SCALE_ITIME_US(100000, 5, 32),
> +	GAIN_SCALE_ITIME_US(200000, 6, 64),
> +	GAIN_SCALE_ITIME_US(400000, 7, 128),
> +};
> +
> +/*
> + * The gain selector encodes (PD_D4 << 2) | GAIN to identify each gain setting.
> + * Gains are multiplied by 8 to work with integers. The values in the iio-gts
> + * tables don't need corrections because the maximum value of the scale refers
> + * to GAIN = x1, and the rest of the values are obtained from the resulting
> + * linear function.
> + * TODO: add support for MILLI_GAIN_X165 and MILLI_GAIN_X660
> + */
> +#define VEML6031X00_SEL_MILLI_GAIN_X125  0x07
> +#define VEML6031X00_SEL_MILLI_GAIN_X250  0x04
> +#define VEML6031X00_SEL_MILLI_GAIN_X500  0x03
> +#define VEML6031X00_SEL_MILLI_GAIN_X1000 0x00
> +#define VEML6031X00_SEL_MILLI_GAIN_X2000 0x01
> +static const struct iio_gain_sel_pair veml6031x00_gain_sel[] = {
> +	GAIN_SCALE_GAIN(1,  VEML6031X00_SEL_MILLI_GAIN_X125),
> +	GAIN_SCALE_GAIN(2,  VEML6031X00_SEL_MILLI_GAIN_X250),
> +	GAIN_SCALE_GAIN(4, VEML6031X00_SEL_MILLI_GAIN_X500),
> +	GAIN_SCALE_GAIN(8, VEML6031X00_SEL_MILLI_GAIN_X1000),
> +	GAIN_SCALE_GAIN(16, VEML6031X00_SEL_MILLI_GAIN_X2000),
> +};
> +
> +static IIO_CONST_ATTR(in_illuminance_thresh_either_period_available, "1 2 4 8");
> +
> +static struct attribute *veml6031x00_event_attributes[] = {
> +	&iio_const_attr_in_illuminance_thresh_either_period_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group veml6031x00_event_attr_group = {
> +	.attrs = veml6031x00_event_attributes,
> +};
> +
> +/*
> + * Two shutdown bits (SD and ALS_IR_SD) must be cleared to power on
> + * the device.
> + */
> +static int veml6031x00_als_power_on(struct veml6031x00_data *data)
> +{
> +	int ret;
> +
> +	ret = regmap_clear_bits(data->regmap, VEML6031X00_REG_CONF0,
> +				VEML6031X00_CONF0_SD);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_clear_bits(data->regmap, VEML6031X00_REG_CONF1,
> +				 VEML6031X00_CONF1_IR_SD);
> +}
> +
> +/*
> + * Two shutdown bits (SD and ALS_IR_SD) must be set to power off
> + * the device.
> + */
> +static int veml6031x00_als_shutdown(struct veml6031x00_data *data)
> +{
> +	int ret;
> +
> +	ret = regmap_set_bits(data->regmap, VEML6031X00_REG_CONF0,
> +			      VEML6031X00_CONF0_SD);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_set_bits(data->regmap, VEML6031X00_REG_CONF1,
> +			       VEML6031X00_CONF1_IR_SD);
> +}
> +
> +static void veml6031x00_als_shutdown_action(void *data)
> +{
> +	veml6031x00_als_shutdown(data);
> +}

I wonder if the register values are maintained when the device is 
powered down? If not, then the regmap cache should be invalidated.

Yours,
	-- Matti

---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
