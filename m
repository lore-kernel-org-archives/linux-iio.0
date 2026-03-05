Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC7A1E531
	for <linux-iio@vger.kernel.org>; Thu,  5 Mar 2026 00:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772672201; cv=none; b=R1mlV/qVpXZfqSk+87cMf1r1udNFY71x/A+yHvxaCwT2pqBscO78RNfFyJtBjEV5cmlPS+ya18Xp9LGNLn9mOd7jFcjB0VJ+5dvufA7oJW8cKm5O3iMVToLTHBjw+2AFhdJhe+b7Ei3yX/TFHKyYYM+/E0vvasTsmvlzvaMImU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772672201; c=relaxed/simple;
	bh=ZRX8nbE+x8RbXbneau5wMXKxKJx0ueeBBG8zpf1Vbgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQEWEHT9NvLCFIYY8OrZHh5hyqRPHhHvcEmM8d4X7iz5LRo8imbLn8dHu1eb7tOEesqciQbMS+Wq31WoU6bVabyWr4QNd73PziQbJt5Zxu02d515SLiYflAAY9wzqauhf8y7YRRrUjXyYFzQ437+j+HwJnYcDgiN1cdt2gur4aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tsdXDOpI; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tsdXDOpI"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-404254ffe8aso1683501fac.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2026 16:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772672197; x=1773276997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YkROOz4Y4uaMWr14APyULcJyq7nxp1o+bzfIJlufAOo=;
        b=tsdXDOpIizTuzfQVBekm9KaSr+r0wuRFs42JGqkEQ+2S+ayWc6PE80WZ7utUo826VW
         Az6XtywdIHybDpSK0FgQkZZ+ZhW+d3rGTB+L8nM/wSjDeO4vbIpwavXxaK2W6toYRfy5
         FOGc0tEXkFWSy8RjIvGfyvRX7nQjt+ff4fSd2OsA/y7F09WN+aPz0CVgFv08Jt/SdqX9
         oUcRxZAN9PzcOKsAj2JtO/hr/GWZpemEK8owEkAeNy4zUWPCBcG6JUV4P04DEN9b/xkN
         wJ+HOO+6qMVUQg3RcBc+RT9UqEvySVgrTASaK4Lh7VUh4ccWoT4K1LyH4OzxUqcd49xR
         98Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772672197; x=1773276997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YkROOz4Y4uaMWr14APyULcJyq7nxp1o+bzfIJlufAOo=;
        b=XfNzOAAL7OesgF49pFEkbDAklx6hm/iWfjYR7sB48qf5A2FmyH8V7a+bdnivWI7taO
         M/T7C/D6TfZoF18H5rV4+mIaejjrtCtiPDWejpRt/VuBatJ+J52RD+6ql0O6SzfyFmwa
         p7SdX3tQeY7vOt4WNjqbxiUbLv1Y9OB32xTYPesjKQu+uzPGRUa8hoIMYrWsq094HPVK
         hQH6B9XBXQRFVcd+R09/es4g8XVzceKP+Y9LPrJTqIWJvjcZyVi8alOFDUPnjoh2BPNK
         tuJFhRPpO2PizVP3myDliBMCkYM808vbmZWYHtts7Xop68Z23zKJyvBAv20q+WqCs8jx
         mBJg==
X-Forwarded-Encrypted: i=1; AJvYcCU2xepiZr6Is6lJBaxzauX2r0PO/XBwghQUHvGfyADM2OqKPDz5CZguDmzl8AO0Twl9SfqFI7Wo6uc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7BS6ub+BGNNaXGyNQGFvw32eOrFrypq+0N+DBVxpE9L2ucQaS
	rWwl2SHX21whorDeve1Vfl38e/+8rb+aCnmcxK42Tnb9MS8+vKwE5DIgcXYiKC9qBEk=
X-Gm-Gg: ATEYQzw6uvoaO5LbGzQNKO3Ic+ADcm9MrMiPZbQXrd/lAxC/xEcjaVNmf0k5MirVDmz
	67Z5/2XR3/2PL0U//uj2GHyXbNgLwpJIeEUcTMMybWumRU413gVqpz9PdL899rE9bvHwu+pZ5OE
	0ciItQZ077h5oq+F9MFEsloj5tmxsbGBlLISONSJ5xV/rQ9n93r7QI6PzlPx+/NdLOuXUkIry9Y
	6n1roud1GMdPnxJm+GUNdyx6Hpz5qq8pbXO8WGDR03G+Hq1OYACKdttIKTcZQKpd+ti9JPW4bmN
	BruypEVpvem6qGTG/AmZfG4Q75DVxxvIYp4q2k0bcfsjUxfhI2q9GcshEtRDwPZpdl7NwxUkTh+
	nLuYx4DjnWcobou2YKJV320GFKk54ngjEOBRlyZyZfUJBD9oTflaKYjyQcFUUavCtC+2+Yitkl1
	H/QG31cZ/Y1TmL9O+bMQL03ao/L8FIqYBlAfx9B4jApmvEi+yAtq42VFc6+VSHN6AxC5emA4eze
	w==
X-Received: by 2002:a05:6871:7287:b0:3f5:b761:5234 with SMTP id 586e51a60fabf-416c3e282c0mr346512fac.28.1772672197356;
        Wed, 04 Mar 2026 16:56:37 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d719:8353:352f:b2e0? ([2600:8803:e7e4:500:d719:8353:352f:b2e0])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d26d9absm20274939fac.16.2026.03.04.16.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 16:56:36 -0800 (PST)
Message-ID: <d6e76e20-9385-4c53-ad1d-c0153fc48cc4@baylibre.com>
Date: Wed, 4 Mar 2026 18:56:36 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: temperature: add support for Analog Devices
 MAX30210
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>,
 linux-iio@vger.kernel.org, jic23@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org, linux-kernel@vger.kernel.org
References: <20260304122509.67931-1-johnerasmusmari.geronimo@analog.com>
 <20260304122509.67931-3-johnerasmusmari.geronimo@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260304122509.67931-3-johnerasmusmari.geronimo@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/4/26 6:25 AM, John Erasmus Mari Geronimo wrote:
> Add support for the Analog Devices MAX30210 I2C temperature
> sensor.
> 
> The driver uses regmap for register access and integrates with
> the IIO framework. It supports:
> 
> - Direct mode temperature conversion
> - Configurable sampling frequency
> - Threshold events
> - FIFO operation with IIO kfifo buffer support
> - Optional interrupt-driven data ready signaling
> 
> The device provides 16-bit signed temperature data and a
> 64-sample FIFO.
> 
> Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
> ---
>  MAINTAINERS                        |   1 +
>  drivers/iio/temperature/Kconfig    |  10 +
>  drivers/iio/temperature/Makefile   |   1 +
>  drivers/iio/temperature/max30210.c | 664 +++++++++++++++++++++++++++++
>  4 files changed, 676 insertions(+)
>  create mode 100644 drivers/iio/temperature/max30210.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 09345b9f32ed..2abdbcf3a8e5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1644,6 +1644,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
> +F:	drivers/iio/temperature/max30210.c
>  
>  ANALOG DEVICES INC ADA4250 DRIVER
>  M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> index 9328b2250ace..b396757eb761 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -184,4 +184,14 @@ config MCP9600
>  	  This driver can also be built as a module. If so, the module
>  	  will be called mcp9600.
>  

Let's keep these in order too. MAX30... goes before MAX31...

> +config MAX30210
> +	tristate "Analog Devices MAX30210 temperature sensor"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for MAX30210 low-power digital
> +	  temperature sensor chip connected via I2C.
> +
> +	  This driver can also be build as a module. If so, the module
> +	  will be called max30210.
> +
>  endmenu
> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> index 07d6e65709f7..e5aad14dc09b 100644
> --- a/drivers/iio/temperature/Makefile
> +++ b/drivers/iio/temperature/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_LTC2983) += ltc2983.o
>  obj-$(CONFIG_HID_SENSOR_TEMP) += hid-sensor-temperature.o
>  obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
>  obj-$(CONFIG_MAX30208) += max30208.o
> +obj-$(CONFIG_MAX30210) += max30210.o
>  obj-$(CONFIG_MAX31856) += max31856.o
>  obj-$(CONFIG_MAX31865) += max31865.o
>  obj-$(CONFIG_MCP9600) += mcp9600.o
> diff --git a/drivers/iio/temperature/max30210.c b/drivers/iio/temperature/max30210.c
> new file mode 100644
> index 000000000000..839ed9830957
> --- /dev/null
> +++ b/drivers/iio/temperature/max30210.c
> @@ -0,0 +1,664 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices MAX30210 I2C Temperature Sensor driver
> + *
> + * Copyright 2026 Analog Devices Inc.
> + */
> +

Looks like we are missing some headers here. We try to include
what is actually used in the file rather than relying on includes
from other includes.

> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/regmap.h>
> +#include <linux/units.h>
> +
> +#define MAX30210_STATUS_REG		0x00
> +#define MAX30210_INT_EN_REG		0x02
> +#define MAX30210_FIFO_DATA_REG		0x08
> +#define MAX30210_FIFO_CONF_1_REG	0x09
> +#define MAX30210_FIFO_CONF_2_REG	0x0A
> +#define MAX30210_SYS_CONF_REG		0x11
> +#define MAX30210_PIN_CONF_REG		0x12
> +#define MAX30210_TEMP_ALM_HI_REG	0x22
> +#define MAX30210_TEMP_ALM_LO_REG	0x24
> +#define MAX30210_TEMP_INC_THRESH_REG	0x26
> +#define MAX30210_TEMP_DEC_THRESH_REG	0x27
> +#define MAX30210_TEMP_CONF_1_REG	0x28
> +#define MAX30210_TEMP_CONF_2_REG	0x29
> +#define MAX30210_TEMP_CONV_REG		0x2A
> +#define MAX30210_TEMP_DATA_REG		0x2B
> +#define MAX30210_TEMP_SLOPE_REG		0x2D
> +#define MAX30210_UNIQUE_ID_REG		0x30
> +#define MAX30210_PART_ID_REG		0xFF
> +
> +#define MAX30210_STATUS_A_FULL_MASK   BIT(7)
> +#define MAX30210_STATUS_TEMP_RDY_MASK BIT(6)
> +#define MAX30210_STATUS_TEMP_DEC_MASK BIT(5)
> +#define MAX30210_STATUS_TEMP_INC_MASK BIT(4)
> +#define MAX30210_STATUS_TEMP_LO_MASK  BIT(3)
> +#define MAX30210_STATUS_TEMP_HI_MASK  BIT(2)
> +#define MAX30210_STATUS_PWR_RDY_MASK  BIT(0)
> +
> +#define MAX30210_FIFOCONF1_FLUSH_FIFO_MASK BIT(4)
> +
> +#define MAX30210_SYSCONF_RESET_MASK		BIT(0)
> +
> +#define MAX30210_PINCONF_EXT_CNV_EN_MASK	BIT(7)
> +#define MAX30210_PINCONF_EXT_CVT_ICFG_MASK	BIT(6)
> +#define MAX30210_PINCONF_INT_FCFG_MASK		GENMASK(3, 2)
> +#define MAX30210_PINCONF_INT_OCFG_MASK		GENMASK(1, 0)
> +
> +#define MAX30210_TEMPCONF1_CHG_DET_EN_MASK	BIT(3)
> +#define MAX30210_TEMPCONF1_RATE_CHG_FILTER_MASK	GENMASK(2, 0)
> +
> +#define MAX30210_TEMPCONF2_TEMP_PERIOD_MASK	GENMASK(3, 0)
> +#define MAX30210_TEMPCONF2_ALERT_MODE_MASK	BIT(7)
> +
> +#define MAX30210_TEMPCONV_AUTO_MASK	BIT(1)
> +#define MAX30210_TEMPCONV_CONV_T_MASK	BIT(0)
> +
> +#define MAX30210_PART_ID		0x45
> +#define MAX30210_FIFO_SIZE		64
> +#define MAX30210_FIFO_INVAL_DATA	GENMASK(23, 0)
> +#define MAX30210_WATERMARK_DEFAULT	(0x40 - 0x1F)
> +
> +#define MAX30210_UNIQUE_ID_LEN		6
> +#define MAX30210_EXT_CVT_FREQ_MIN	1
> +#define MAX30210_EXT_CVT_FREQ_MAX	20
> +
> +struct max30210_state {
> +	struct regmap *regmap;
> +	u8 watermark;
> +	/* Raw FIFO byte buffer (3 bytes per sample) */

This 3 is used a few other places in the code, so might be nice to have
a macro for that.

> +	u8 fifo_buf[3 * MAX30210_FIFO_SIZE];
> +};
> +
> +static const int max30210_samp_freq_avail[][2] = {
> +	{ 0, 15625 },
> +	{ 0, 31250 },
> +	{ 0, 62500 },
> +	{ 0, 125000 },
> +	{ 0, 250000 },
> +	{ 0, 500000 },
> +	{ 1, 0 },
> +	{ 2, 0 },
> +	{ 4, 0 },
> +	{ 8, 0 },
> +};
> +
> +static const struct regmap_config max30210_regmap = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = MAX30210_PART_ID_REG,
> +};
> +
> +static int max30210_read_temp(struct regmap *regmap, unsigned int reg,
> +			      int *temp)
> +{
> +	__be16 val;
> +	int ret;
> +
> +	ret = regmap_bulk_read(regmap, reg, &val, sizeof(val));
> +	if (ret)
> +		return ret;
> +
> +	*temp = sign_extend32(be16_to_cpu(val), 15);
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int max30210_write_temp(struct regmap *regmap, unsigned int reg,
> +			       int temp)
> +{
> +	__be16 val;
> +
> +	val = cpu_to_be16(temp);
> +
> +	return regmap_bulk_write(regmap, reg, &val, sizeof(val));
> +}
> +
> +static void max30210_fifo_read(struct iio_dev *indio_dev)
> +{
> +	struct max30210_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regmap_bulk_read(st->regmap, MAX30210_FIFO_DATA_REG,
> +			       st->fifo_buf, 3 * st->watermark);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Failed to read from fifo.\n");
> +		return;
> +	}
> +
> +	for (unsigned int i = 0; i < st->watermark; i++) {
> +		u32 raw = get_unaligned_be24(&st->fifo_buf[3 * i]);
> +
> +		if (raw == MAX30210_FIFO_INVAL_DATA) {
> +			dev_err_ratelimited(&indio_dev->dev, "Invalid data\n");
> +			continue;
> +		}
> +
> +		s16 temp = (s16)(raw & 0xFFFF);

Can use FIELD_GET().

> +
> +		iio_push_to_buffers(indio_dev, &temp);
> +	}
> +}
> +
> +static irqreturn_t max30210_irq_handler(int irq, void *dev_id)
> +{
> +	struct iio_dev *indio_dev = dev_id;
> +	struct max30210_state *st = iio_priv(indio_dev);
> +	unsigned int status;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, MAX30210_STATUS_REG, &status);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Status read failed\n");
> +		return IRQ_NONE;
> +	}
> +
> +	if (status & MAX30210_STATUS_A_FULL_MASK)
> +		max30210_fifo_read(indio_dev);
> +
> +	if (status & MAX30210_STATUS_TEMP_HI_MASK)
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_RISING),
> +			       iio_get_time_ns(indio_dev));
> +
> +	if (status & MAX30210_STATUS_TEMP_LO_MASK)
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_FALLING),
> +			       iio_get_time_ns(indio_dev));
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int max30210_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +			       unsigned int writeval, unsigned int *readval)
> +{
> +	struct max30210_state *st = iio_priv(indio_dev);
> +
> +	if (!readval)

Usual way is to swap these to avoid the !.

> +		return regmap_write(st->regmap, reg, writeval);
> +
> +	return regmap_read(st->regmap, reg, readval);
> +}
> +
> +static int max30210_read_event(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       enum iio_event_type type,
> +			       enum iio_event_direction dir,
> +			       enum iio_event_info info, int *val, int *val2)
> +{
> +	struct max30210_state *st = iio_priv(indio_dev);
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		switch (type) {
> +		case IIO_EV_TYPE_THRESH:
> +			return max30210_read_temp(st->regmap, MAX30210_TEMP_ALM_HI_REG, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_EV_DIR_FALLING:
> +		switch (type) {
> +		case IIO_EV_TYPE_THRESH:
> +			return max30210_read_temp(st->regmap, MAX30210_TEMP_ALM_LO_REG, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int max30210_write_event(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				enum iio_event_info info, int val, int val2)
> +{
> +	struct max30210_state *st = iio_priv(indio_dev);
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;

No range checking on val?

> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		switch (type) {
> +		case IIO_EV_TYPE_THRESH:
> +			return max30210_write_temp(st->regmap, MAX30210_TEMP_ALM_HI_REG, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_EV_DIR_FALLING:
> +		switch (type) {
> +		case IIO_EV_TYPE_THRESH:
> +			return max30210_write_temp(st->regmap, MAX30210_TEMP_ALM_LO_REG, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int max30210_read_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir)
> +{
> +	struct max30210_state *st = iio_priv(indio_dev);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, MAX30210_INT_EN_REG, &val);
> +	if (ret)
> +		return ret;
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		switch (type) {
> +		case IIO_EV_TYPE_THRESH:
> +			return FIELD_GET(MAX30210_STATUS_TEMP_HI_MASK, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_EV_DIR_FALLING:
> +		switch (type) {
> +		case IIO_EV_TYPE_THRESH:
> +			return FIELD_GET(MAX30210_STATUS_TEMP_LO_MASK, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int max30210_write_event_config(struct iio_dev *indio_dev,
> +				       const struct iio_chan_spec *chan,
> +				       enum iio_event_type type,
> +				       enum iio_event_direction dir, bool state)
> +{
> +	struct max30210_state *st = iio_priv(indio_dev);
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		switch (type) {
> +		case IIO_EV_TYPE_THRESH:
> +			return regmap_assign_bits(st->regmap, MAX30210_INT_EN_REG,
> +						  MAX30210_STATUS_TEMP_HI_MASK, state);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_EV_DIR_FALLING:
> +		switch (type) {
> +		case IIO_EV_TYPE_THRESH:
> +			return regmap_assign_bits(st->regmap, MAX30210_INT_EN_REG,
> +						  MAX30210_STATUS_TEMP_LO_MASK, state);
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int max30210_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	struct max30210_state *st = iio_priv(indio_dev);
> +	unsigned int uval;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 5;
> +		*val2 = 1000;
> +
> +		return IIO_VAL_FRACTIONAL;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = regmap_read(st->regmap, MAX30210_TEMP_CONF_2_REG, &uval);
> +		if (ret)
> +			return ret;
> +
> +		uval = FIELD_GET(MAX30210_TEMPCONF2_TEMP_PERIOD_MASK, uval);
> +

Could use a comment here to explain code below. It makes sense when you
read the datasheet, but looks odd without that context.

> +		if (uval >= ARRAY_SIZE(max30210_samp_freq_avail))
> +			uval = ARRAY_SIZE(max30210_samp_freq_avail) - 1;
> +
> +		*val = max30210_samp_freq_avail[uval][0];
> +		*val2 = max30210_samp_freq_avail[uval][1];
> +
> +		return IIO_VAL_FRACTIONAL;
> +	case IIO_CHAN_INFO_RAW: {

Techicnally, there is a race condition here. We could be exiting buffer mode
here. So this looks like one of those rare cases where we should use
IIO_DEV_GUARD_CURRENT_MODE().

Typically we just don't allow reading raw during buffered read though
unless there is a real-world use case for it.

> +		if (iio_buffer_enabled(indio_dev))
> +			return max30210_read_temp(st->regmap, MAX30210_TEMP_DATA_REG, val);
> +
> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		ret = regmap_write(st->regmap, MAX30210_TEMP_CONV_REG,
> +				   MAX30210_TEMPCONV_CONV_T_MASK);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * Wait until CONVERT_T auto-clears.
> +		 * Datasheet:
> +		 *   tBIAS_WU = 260 µs
> +		 *   tINT     = 8 ms
> +		 *
> +		 * Worst-case conversion ≈ 8.26 ms.
> +		 * Use 10 ms timeout for margin.
> +		 */
> +		ret = regmap_read_poll_timeout(st->regmap, MAX30210_TEMP_CONV_REG, uval,
> +					       !(uval & MAX30210_TEMPCONV_CONV_T_MASK),
> +					       500,          /* poll every 500 µs */
> +					       10000);       /* 10 ms timeout */
> +		if (ret)
> +			return ret;
> +
> +		return max30210_read_temp(st->regmap, MAX30210_TEMP_DATA_REG, val);
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int max30210_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type, int *length,
> +			       long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = &max30210_samp_freq_avail[0][0];
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		*length = ARRAY_SIZE(max30210_samp_freq_avail) * 2;
> +
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int max30210_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int val,
> +			      int val2, long mask)
> +{
> +	struct max30210_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		if (val < 0 || val2 < 0)
> +			return -EINVAL;
> +
> +		for (unsigned int i = 0; i < ARRAY_SIZE(max30210_samp_freq_avail); i++) {
> +			if (val == max30210_samp_freq_avail[i][0] &&
> +			    val2 == max30210_samp_freq_avail[i][1]) {
> +				return regmap_update_bits(st->regmap, MAX30210_TEMP_CONF_2_REG,
> +						MAX30210_TEMPCONF2_TEMP_PERIOD_MASK,
> +						FIELD_PREP(MAX30210_TEMPCONF2_TEMP_PERIOD_MASK, i));
> +			}
> +		}
> +
> +		return -EINVAL;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int max30210_set_watermark(struct iio_dev *indio_dev, unsigned int val)
> +{
> +	struct max30210_state *st = iio_priv(indio_dev);
> +	unsigned int reg;
> +	int ret;
> +
> +	if (val < 1 || val > MAX30210_FIFO_SIZE)
> +		return -EINVAL;
> +


> +	reg = MAX30210_FIFO_SIZE - val;

This looks a bit odd and could use some explanation.

And even if it technically doesn't need it, would still expect a FIELD_PREP()
here since there are some reserved bits.

> +
> +	ret = regmap_write(st->regmap, MAX30210_FIFO_CONF_1_REG, reg);
> +	if (ret)
> +		return ret;
> +
> +	st->watermark = val;
> +
> +	return 0;
> +}
> +
> +static ssize_t hwfifo_watermark_show(struct device *dev,
> +				     struct device_attribute *devattr,
> +				     char *buf)
> +{
> +	struct max30210_state *st = iio_priv(dev_to_iio_dev(dev));
> +
> +	return sysfs_emit(buf, "%d\n", st->watermark);
> +}
> +
> +IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_min, "1");
> +IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_max,
> +			     __stringify(MAX30210_FIFO_SIZE));
> +static IIO_DEVICE_ATTR_RO(hwfifo_watermark, 0);
> +
> +static const struct iio_dev_attr *max30210_fifo_attributes[] = {
> +	&iio_dev_attr_hwfifo_watermark_min,
> +	&iio_dev_attr_hwfifo_watermark_max,
> +	&iio_dev_attr_hwfifo_watermark,
> +	NULL
> +};
> +
> +static int max30210_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct max30210_state *st = iio_priv(indio_dev);
> +	int ret;

The register names are a bit cryptic. I wouldn't mind a high-level comment
explaining the intention here.

> +
> +	ret = regmap_set_bits(st->regmap, MAX30210_INT_EN_REG, MAX30210_STATUS_A_FULL_MASK);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(st->regmap, MAX30210_FIFO_CONF_2_REG,
> +			      MAX30210_FIFOCONF1_FLUSH_FIFO_MASK);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, MAX30210_TEMP_CONV_REG,
> +			    MAX30210_TEMPCONV_AUTO_MASK | MAX30210_TEMPCONV_CONV_T_MASK);
> +}
> +
> +static int max30210_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct max30210_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, MAX30210_TEMP_CONV_REG, 0x0);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(st->regmap, MAX30210_FIFO_CONF_2_REG,
> +			      MAX30210_FIFOCONF1_FLUSH_FIFO_MASK);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_clear_bits(st->regmap, MAX30210_INT_EN_REG,
> +				 MAX30210_STATUS_A_FULL_MASK);
> +}
> +
> +static const struct iio_buffer_setup_ops max30210_buffer_ops = {
> +	.preenable = max30210_buffer_preenable,
> +	.postdisable = max30210_buffer_postdisable,
> +};
> +
> +static const struct iio_info max30210_info = {
> +	.read_raw = max30210_read_raw,
> +	.read_avail = max30210_read_avail,
> +	.write_raw = max30210_write_raw,
> +	.hwfifo_set_watermark = max30210_set_watermark,
> +	.debugfs_reg_access = max30210_reg_access,
> +	.read_event_value = max30210_read_event,
> +	.write_event_value = max30210_write_event,
> +	.write_event_config = max30210_write_event_config,
> +	.read_event_config = max30210_read_event_config,
> +};
> +
> +static const struct iio_event_spec max30210_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_ENABLE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +static const struct iio_chan_spec max30210_channels = {
> +	.type = IIO_TEMP,
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			      BIT(IIO_CHAN_INFO_SCALE) |
> +			      BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	.scan_index = 0,
> +	.event_spec = max30210_events,
> +	.num_event_specs = ARRAY_SIZE(max30210_events),
> +	.scan_type = {
> +		.sign = 's',
> +		.realbits = 16,
> +		.storagebits = 16,
> +		.shift = 0,
> +		.endianness = IIO_CPU,
> +	},
> +};
> +
> +static int max30210_setup(struct max30210_state *st, struct device *dev)
> +{
> +	struct gpio_desc *powerdown_gpio;
> +	unsigned int val;
> +	int ret;
> +
> +	/* Optional hardware reset via powerdown GPIO */
> +	powerdown_gpio = devm_gpiod_get_optional(dev, "powerdown",
> +						 GPIOD_OUT_HIGH);
> +	if (IS_ERR(powerdown_gpio))
> +		return dev_err_probe(dev, PTR_ERR(powerdown_gpio),
> +				     "failed to request powerdown GPIO\n");
> +
> +	if (powerdown_gpio) {
> +		/* Deassert powerdown to power up device */
> +		gpiod_set_value(powerdown_gpio, 0);
> +	} else {
> +		/* Software reset fallback */
> +		ret = regmap_update_bits(st->regmap, MAX30210_SYS_CONF_REG,

regmap_set_bits()

> +					 MAX30210_SYSCONF_RESET_MASK,
> +					 MAX30210_SYSCONF_RESET_MASK);
> +		if (ret)
> +			return ret;
> +	}
> +

Use IIO style multi-line comments:

	/*
	 * Datasheet Figure 6:

> +	/* Datasheet Figure 6:
> +	 * tPU max = 700 µs after power-up or reset before device is ready.
> +	 */
> +	fsleep(700);
> +
> +	/* Clear status byte */
> +	return regmap_read(st->regmap, MAX30210_STATUS_REG, &val);
> +}
> +
> +static int max30210_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct max30210_state *st;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -EOPNOTSUPP;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable vdd regulator.\n");
> +
> +	st->regmap = devm_regmap_init_i2c(client, &max30210_regmap);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "Failed to allocate regmap.\n");
> +
> +	st->watermark = MAX30210_WATERMARK_DEFAULT;
> +
> +	ret = max30210_setup(st, dev);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = &max30210_channels;
> +	indio_dev->num_channels = 1;
> +	indio_dev->name = "max30210";
> +	indio_dev->info = &max30210_info;
> +
> +	ret = devm_iio_kfifo_buffer_setup_ext(dev, indio_dev, &max30210_buffer_ops,
> +					      max30210_fifo_attributes);
> +	if (ret)
> +		return ret;
> +
> +	if (client->irq) {

The way the driver is written currently, the interrup is required.

Either we need to reutrn error on !client->irq or we need to have a second
max30210_info that excludes buffer and events.

> +		ret = devm_request_irq(dev, client->irq, max30210_irq_handler, IRQF_NO_THREAD,
> +				       indio_dev->name, indio_dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id max30210_id[] = {
> +	{ "max30210" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max30210_id);
> +
> +static const struct of_device_id max30210_of_match[] = {
> +	{ .compatible = "adi,max30210" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max30210_of_match);
> +
> +static struct i2c_driver max30210_driver = {
> +	.driver = {
> +		.name = "max30210",
> +		.of_match_table = max30210_of_match,
> +	},
> +	.probe = max30210_probe,
> +	.id_table = max30210_id,
> +};
> +module_i2c_driver(max30210_driver);
> +
> +MODULE_AUTHOR("John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com");
> +MODULE_DESCRIPTION("MAX30210 low-power digital temperature sensor");
> +MODULE_LICENSE("GPL");

