Return-Path: <SRS0=JcFl=P3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993F9C61CE4
	for <linux-iio@archiver.kernel.org>; Sat, 19 Jan 2019 17:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A59F20883
	for <linux-iio@archiver.kernel.org>; Sat, 19 Jan 2019 17:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547918231;
	bh=wL6QTvaM+xfYPNIOwwFJiJAeKOX4rCaEIAO77lCCMvo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=d/2dODs0gyz2+EZK8tezzuEZxhaluWjkqFp/CRA6DjC0Z9aHw0T4kMoVLr0lixty2
	 W+UQkdOALqNDbDyER3kNxIUCMh0j9/tJ/zvltIw89sqYRh3xXBQ3VFn7BwwdG2RAw0
	 2YotpVA/1e+YlM6dSxfb0Xr6Rq/wXmSo7BANUB6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfASRRK (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 19 Jan 2019 12:17:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:47418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbfASRRK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Jan 2019 12:17:10 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A45F2084C;
        Sat, 19 Jan 2019 17:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547918229;
        bh=wL6QTvaM+xfYPNIOwwFJiJAeKOX4rCaEIAO77lCCMvo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X55O6tOk9D+7P7PE/EGVFlPTnRo6bZAyT3XTgluY1f9mUkWth9l2MZZDyBX/DzGsC
         74FuSByceybN5k5KLrNeXtviqi8+3g4ilf3/Oja+tp2KLcY2QGocDw667YumasdPBO
         pF+hw8znW+2mvwYKIDVLKjBizlmzXHTRchr6BOG8=
Date:   Sat, 19 Jan 2019 17:17:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kelly <martin@martingkelly.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/5] iio:bmi160: add drdy interrupt support
Message-ID: <20190119171704.4356c763@archlinux>
In-Reply-To: <20190114035621.5252-3-martin@martingkelly.com>
References: <20190114035621.5252-1-martin@martingkelly.com>
        <20190114035621.5252-3-martin@martingkelly.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 13 Jan 2019 19:56:18 -0800
Martin Kelly <martin@martingkelly.com> wrote:

> From: Martin Kelly <martin@martingkelly.com>
> 
> Add interrupt support for the data ready signal on the BMI160, which fires
> an interrupt whenever new accelerometer/gyroscope data is ready to read.

Various minor comments inline.  Mostly fine, but one big 'oddity'.

I think we only ever request 1 irq, but we have support in here for
configuring the chip to generate two at the same time.  Doesn't make
much sense as it stands... Am I missing something?

Jonathan

> 
> Signed-off-by: Martin Kelly <martin@martingkelly.com>
> ---
>  drivers/iio/imu/bmi160/Makefile         |   1 +
>  drivers/iio/imu/bmi160/bmi160.h         |  13 +-
>  drivers/iio/imu/bmi160/bmi160_core.c    | 271 +++++++++++++++++++++++++++++++-
>  drivers/iio/imu/bmi160/bmi160_i2c.c     |   3 +-
>  drivers/iio/imu/bmi160/bmi160_spi.c     |   2 +-
>  drivers/iio/imu/bmi160/bmi160_trigger.c |  60 +++++++
>  6 files changed, 341 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/iio/imu/bmi160/bmi160_trigger.c
> 
> diff --git a/drivers/iio/imu/bmi160/Makefile b/drivers/iio/imu/bmi160/Makefile
> index 10365e493ae2..19e1720c6fe9 100644
> --- a/drivers/iio/imu/bmi160/Makefile
> +++ b/drivers/iio/imu/bmi160/Makefile
> @@ -2,5 +2,6 @@
>  # Makefile for Bosch BMI160 IMU
>  #
>  obj-$(CONFIG_BMI160) += bmi160_core.o
> +obj-$(CONFIG_BMI160) += bmi160_trigger.o
>  obj-$(CONFIG_BMI160_I2C) += bmi160_i2c.o
>  obj-$(CONFIG_BMI160_SPI) += bmi160_spi.o
> diff --git a/drivers/iio/imu/bmi160/bmi160.h b/drivers/iio/imu/bmi160/bmi160.h
> index 2351049d930b..0c5e67e0d35b 100644
> --- a/drivers/iio/imu/bmi160/bmi160.h
> +++ b/drivers/iio/imu/bmi160/bmi160.h
> @@ -2,9 +2,20 @@
>  #ifndef BMI160_H_
>  #define BMI160_H_
>  
> +#include <linux/iio/iio.h>
> +
> +struct bmi160_data {
> +	struct regmap *regmap;
> +	struct iio_trigger *trig;
> +};
> +
>  extern const struct regmap_config bmi160_regmap_config;
>  
>  int bmi160_core_probe(struct device *dev, struct regmap *regmap,
> -		      const char *name, bool use_spi);
> +		      const char *name, bool use_spi, int irq);
> +
> +int bmi160_enable_irq(struct regmap *regmap, bool enable);
> +
> +int bmi160_probe_trigger(struct iio_dev *indio_dev, int irq, u32 irq_type);
>  
>  #endif  /* BMI160_H_ */
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> index ce61026d84c3..e119965e64a3 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -6,12 +6,14 @@
>   *
>   * IIO core driver for BMI160, with support for I2C/SPI busses
>   *
> - * TODO: magnetometer, interrupts, hardware FIFO
> + * TODO: magnetometer, hardware FIFO
>   */
>  #include <linux/module.h>
>  #include <linux/regmap.h>
>  #include <linux/acpi.h>
>  #include <linux/delay.h>
> +#include <linux/irq.h>
> +#include <linux/of_irq.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/triggered_buffer.h>
> @@ -61,8 +63,32 @@
>  #define BMI160_CMD_GYRO_PM_FAST_STARTUP	0x17
>  #define BMI160_CMD_SOFTRESET		0xB6
>  
> +#define BMI160_REG_INT_EN		0x51
> +#define BMI160_DRDY_INT_EN		BIT(4)
> +
> +#define BMI160_REG_INT_OUT_CTRL		0x53
> +#define BMI160_INT_OUT_CTRL_MASK	0x0f
> +#define BMI160_INT1_OUT_CTRL_SHIFT	0
> +#define BMI160_INT2_OUT_CTRL_SHIFT	4
> +#define BMI160_LEVEL_TRIGGERED		BIT(0)
> +#define BMI160_ACTIVE_HIGH		BIT(1)
> +#define BMI160_OPEN_DRAIN		BIT(2)
> +#define BMI160_OUTPUT_EN		BIT(3)
> +
> +#define BMI160_REG_INT_LATCH		0x54
> +#define BMI160_INT1_LATCH_MASK		BIT(4)
> +#define BMI160_INT2_LATCH_MASK		BIT(5)
> +
> +/* INT1 and INT2 are in the opposite order as in INT_OUT_CTRL! */
> +#define BMI160_REG_INT_MAP		0x56
> +#define BMI160_INT1_MAP_DRDY_EN		0x80
> +#define BMI160_INT2_MAP_DRDY_EN		0x08
> +
>  #define BMI160_REG_DUMMY		0x7F
>  
> +#define BMI160_NORMAL_WRITE_USLEEP	2
> +#define BMI160_SUSPENDED_WRITE_USLEEP	450
> +
>  #define BMI160_ACCEL_PMU_MIN_USLEEP	3800
>  #define BMI160_GYRO_PMU_MIN_USLEEP	80000
>  #define BMI160_SOFTRESET_USLEEP		1000
> @@ -105,8 +131,9 @@ enum bmi160_sensor_type {
>  	BMI160_NUM_SENSORS /* must be last */
>  };
>  
> -struct bmi160_data {
> -	struct regmap *regmap;
> +enum bmi160_int_pin {
> +	BMI160_PIN_INT1,
> +	BMI160_PIN_INT2
>  };
>  
>  const struct regmap_config bmi160_regmap_config = {
> @@ -495,7 +522,232 @@ static const char *bmi160_match_acpi_device(struct device *dev)
>  	return dev_name(dev);
>  }
>  
> -static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
> +static int bmi160_write_conf_reg(struct regmap *regmap, unsigned int reg,
> +				 unsigned int mask, unsigned int bits,
> +				 unsigned int write_usleep)
> +{
> +	int ret;
> +	unsigned int val;
> +
> +	ret = regmap_read(regmap, reg, &val);
> +	if (ret < 0)
> +		return ret;
regmap is 0 on success, so
if (ret) preferred.

Makes the question on whether this can return a positive number
that I raise below more obvious.
> +
> +	val = (val & ~mask) | bits;
> +
> +	ret = regmap_write(regmap, reg, val);
> +	if (ret < 0)
if (ret)
> +		return ret;
> +
> +	/*
> +	 * We need to wait after writing before we can write again. See the
> +	 * datasheet, page 93.
> +	 */
> +	usleep_range(write_usleep, write_usleep + 1000);
> +
> +	return 0;
> +}
> +
> +static int bmi160_config_pin(struct regmap *regmap, enum bmi160_int_pin pin,
> +				bool open_drain, u8 irq_mask,
> +				unsigned long write_usleep)
> +{
> +	int ret;
> +	u8 int_out_ctrl_shift;
> +	u8 int_latch_mask;
> +	u8 int_map_mask;
> +	u8 int_out_ctrl_mask;
> +	u8 int_out_ctrl_bits;
> +
> +	switch (pin) {
> +	case BMI160_PIN_INT1:
> +		int_out_ctrl_shift = BMI160_INT1_OUT_CTRL_SHIFT;
> +		int_latch_mask = BMI160_INT1_LATCH_MASK;
> +		int_map_mask = BMI160_INT1_MAP_DRDY_EN;
> +		break;
> +	case BMI160_PIN_INT2:
> +		int_out_ctrl_shift = BMI160_INT2_OUT_CTRL_SHIFT;
> +		int_latch_mask = BMI160_INT2_LATCH_MASK;
> +		int_map_mask = BMI160_INT2_MAP_DRDY_EN;
> +		break;
> +	}
> +	int_out_ctrl_mask = BMI160_INT_OUT_CTRL_MASK << int_out_ctrl_shift;
> +
> +	/*
> +	 * Enable the requested pin with the right settings:
> +	 * - Push-pull/open-drain
> +	 * - Active low/high
> +	 * - Edge/level triggered
> +	 */
> +	int_out_ctrl_bits = 0;
> +	int_out_ctrl_bits |= BMI160_OUTPUT_EN;

Combine the two lines above.

> +	if (open_drain)
> +		/* Default is push-pull. */
> +		int_out_ctrl_bits |= BMI160_OPEN_DRAIN;
> +	int_out_ctrl_bits |= irq_mask;
> +	int_out_ctrl_bits <<= int_out_ctrl_shift;
> +
> +	ret = bmi160_write_conf_reg(regmap, BMI160_REG_INT_OUT_CTRL,
> +				    int_out_ctrl_mask, int_out_ctrl_bits,
> +				    write_usleep);
> +	if (ret < 0)
if (ret) See both above an below!
> +		return ret;
> +
> +	/* Set the pin to input mode with no latching. */
> +	ret = bmi160_write_conf_reg(regmap, BMI160_REG_INT_LATCH,
> +				    int_latch_mask, int_latch_mask,
> +				    write_usleep);
> +	if (ret < 0)
> +		return ret;
if (ret)
> +
> +	/* Map interrupts to the requested pin. */
> +	ret = bmi160_write_conf_reg(regmap, BMI160_REG_INT_MAP,
> +				    int_map_mask, int_map_mask,
> +				    write_usleep);
> +	if (ret < 0)
> +		return ret;
Can ret be greater than 0?  I checked, nope.
return bmi160_write_conf_reg.  (note btw that I review backwards
as code makes more sense that way to me!)
> +
> +	return 0;
> +}
> +
> +int bmi160_enable_irq(struct regmap *regmap, bool enable)
> +{
> +	int ret;
> +	unsigned int enable_bit;
= 0;

> +
> +	if (enable)
> +		enable_bit = BMI160_DRDY_INT_EN;
> +	else
> +		enable_bit = 0;
Then drop the else.
> +
> +	ret = bmi160_write_conf_reg(regmap, BMI160_REG_INT_EN,
> +				    BMI160_DRDY_INT_EN, enable_bit,
> +				    BMI160_NORMAL_WRITE_USLEEP);
> +

return bmi160...

> +	return ret;
> +}
> +EXPORT_SYMBOL(bmi160_enable_irq);
> +
> +static void bmi160_parse_irqname(struct device_node *of_node, int irq,
> +				 bool *int1_enabled, bool *int2_enabled)
> +{
> +	int ret;
> +
> +	/* of_irq_get_byname returns the IRQ number if the entry is found. */
> +	ret = of_irq_get_byname(of_node, "INT1");
> +	if (ret == irq) {
> +		*int1_enabled = true;
> +		*int2_enabled = false;
> +		return;
> +	}
> +
> +	ret = of_irq_get_byname(of_node, "INT2");
> +	if (ret == irq) {
> +		*int1_enabled = false;
> +		*int2_enabled = true;
> +		return;
> +	}
> +
> +	ret = of_irq_get_byname(of_node, "BOTH");
?  I'm not following this.  Hopefully the DT docs will make it clear.

> +	if (ret == irq) {
> +		*int1_enabled = true;
> +		*int2_enabled = true;
> +		return;
> +	}
> +
> +	/* No interrupt name entries found. */
> +	*int1_enabled = false;
> +	*int2_enabled = false;
> +}
> +
> +static int bmi160_config_device_irq(struct iio_dev *indio_dev,
> +				    int irq, int irq_type)
> +{
> +	int ret;
> +	bool int1_enabled;
> +	bool int1_open_drain;
> +	bool int2_enabled;
> +	bool int2_open_drain;
> +	u8 irq_mask;
> +	struct bmi160_data *data = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(data->regmap);
> +
> +	/* Edge-triggered, active-low is the default if we set all zeroes. */
> +	if (irq_type == IRQF_TRIGGER_RISING)
> +		irq_mask = BMI160_ACTIVE_HIGH | BMI160_LEVEL_TRIGGERED;
> +	else if (irq_type == IRQF_TRIGGER_FALLING)
> +		irq_mask = BMI160_LEVEL_TRIGGERED;
> +	else if (irq_type == IRQF_TRIGGER_HIGH)
> +		irq_mask = BMI160_ACTIVE_HIGH;
> +	else if (irq_type == IRQF_TRIGGER_LOW)
> +		irq_mask = 0;
> +	else {
> +		dev_err(&indio_dev->dev,
> +			"Invalid interrupt type 0x%x specified\n", irq_type);
> +		return -EINVAL;
> +	}
> +
> +	bmi160_parse_irqname(dev->of_node, irq, &int1_enabled, &int2_enabled);
> +
> +	if (!int1_enabled && !int2_enabled) {
> +		dev_err(&indio_dev->dev, "IRQ specified but not routed anywhere. bmi160,int1-enabled or bmi160,int2-enabled must be set.");
> +		return -EINVAL;
> +	}
> +
> +	int1_open_drain = of_property_read_bool(dev->of_node,
> +						"bmi160,int1-open-drain");
> +	int2_open_drain = of_property_read_bool(dev->of_node,
> +						"bmi160,int2-open-drain");
> +

This is fine for this section, but a little confusing as we don't actually
register for two interrupts.

> +	if (int1_enabled) {
> +		ret = bmi160_config_pin(data->regmap, BMI160_PIN_INT1,
> +					int1_open_drain, irq_mask,
> +					BMI160_NORMAL_WRITE_USLEEP);
> +		if (ret < 0) {
> +			dev_err(&indio_dev->dev, "Failed to configure INT1 IRQ pin");
> +			return ret;
> +		}
> +	}
> +
> +	if (int2_enabled) {
> +		ret = bmi160_config_pin(data->regmap, BMI160_PIN_INT2,
> +					int2_open_drain, irq_mask,
> +					BMI160_NORMAL_WRITE_USLEEP);
> +		if (ret < 0) {
> +			dev_err(&indio_dev->dev, "Failed to configure INT2 IRQ pin");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int bmi160_setup_irq(struct iio_dev *indio_dev, int irq)
> +{
> +	struct irq_data *desc;
> +	u32 irq_type;
> +	int ret;
> +
> +	desc = irq_get_irq_data(irq);
> +	if (!desc) {
> +		dev_warn(&indio_dev->dev, "Could not find IRQ %d\n", irq);
> +		return -EINVAL;
> +	}
> +
> +	irq_type = irqd_get_trigger_type(desc);
> +
> +	ret = bmi160_config_device_irq(indio_dev, irq, irq_type);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = bmi160_probe_trigger(indio_dev, irq, irq_type);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int bmi160_chip_init(struct bmi160_data *data, bool use_spi, int irq)
>  {
>  	int ret;
>  	unsigned int val;
> @@ -548,7 +800,7 @@ static void bmi160_chip_uninit(void *data)
>  }
>  
>  int bmi160_core_probe(struct device *dev, struct regmap *regmap,
> -		      const char *name, bool use_spi)
> +		      const char *name, bool use_spi, int irq)
>  {
>  	struct iio_dev *indio_dev;
>  	struct bmi160_data *data;
> @@ -561,8 +813,9 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
>  	data = iio_priv(indio_dev);
>  	dev_set_drvdata(dev, indio_dev);
>  	data->regmap = regmap;
> +	data->trig = NULL;

Given that data is allocated as part of the iio_device_alloc, its already
set to null.  No need to do so again as it's a fairly obvious default
for a pointer (hence no 'documentation' benefit here).

>  
> -	ret = bmi160_chip_init(data, use_spi);
> +	ret = bmi160_chip_init(data, use_spi, irq);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -585,6 +838,12 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
>  	if (ret < 0)
>  		return ret;
>  
> +	if (irq) {
> +		ret = bmi160_setup_irq(indio_dev, irq);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret < 0)
>  		return ret;
> diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
> index e36f5e82d400..98467d73c887 100644
> --- a/drivers/iio/imu/bmi160/bmi160_i2c.c
> +++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
> @@ -32,7 +32,8 @@ static int bmi160_i2c_probe(struct i2c_client *client,
>  	if (id)
>  		name = id->name;
>  
> -	return bmi160_core_probe(&client->dev, regmap, name, false);
> +	return bmi160_core_probe(&client->dev, regmap,
> +				 name, false, client->irq);
>  }
>  
>  static const struct i2c_device_id bmi160_i2c_id[] = {
> diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
> index c19e3df35559..23e323518873 100644
> --- a/drivers/iio/imu/bmi160/bmi160_spi.c
> +++ b/drivers/iio/imu/bmi160/bmi160_spi.c
> @@ -24,7 +24,7 @@ static int bmi160_spi_probe(struct spi_device *spi)
>  			(int)PTR_ERR(regmap));
>  		return PTR_ERR(regmap);
>  	}
> -	return bmi160_core_probe(&spi->dev, regmap, id->name, true);
> +	return bmi160_core_probe(&spi->dev, regmap, id->name, true, spi->irq);
>  }
>  
>  static const struct spi_device_id bmi160_spi_id[] = {
> diff --git a/drivers/iio/imu/bmi160/bmi160_trigger.c b/drivers/iio/imu/bmi160/bmi160_trigger.c
> new file mode 100644
> index 000000000000..96e254eb2f19
> --- /dev/null
> +++ b/drivers/iio/imu/bmi160/bmi160_trigger.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * BMI160 - Bosch IMU, trigger/IRQ bits
> + *
> + * Copyright (c) 2019, Martin Kelly.
> + */

It's nice to break up code into relevant files etc, but this one
is rather short.  Perhaps just put it in the core file?
Feel free to add a second copyright notice to that file whilst
doing so to reflect this non-trivial addition.

> +
> +#include <linux/interrupt.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +
> +#include "bmi160.h"
> +
> +static int bmi160_data_rdy_trigger_set_state(struct iio_trigger *trig,
> +					     bool enable)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct bmi160_data *data = iio_priv(indio_dev);
> +
> +	return bmi160_enable_irq(data->regmap, enable);
> +}
> +
> +static const struct iio_trigger_ops bmi160_trigger_ops = {
> +	.set_trigger_state = &bmi160_data_rdy_trigger_set_state,
> +};
> +
> +int bmi160_probe_trigger(struct iio_dev *indio_dev, int irq, u32 irq_type)
> +{
> +	struct bmi160_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	data->trig = devm_iio_trigger_alloc(&indio_dev->dev, "%s-dev%d",
> +					    indio_dev->name, indio_dev->id);
> +
> +	if (data->trig == NULL)
> +		return -ENOMEM;
> +
> +	ret = devm_request_irq(&indio_dev->dev, irq,
> +			       &iio_trigger_generic_data_rdy_poll,
> +			       irq_type, "bmi160", data->trig);
> +	if (ret < 0)
> +		return ret;
> +
> +	data->trig->dev.parent = regmap_get_device(data->regmap);
> +	data->trig->ops = &bmi160_trigger_ops;
> +	iio_trigger_set_drvdata(data->trig, indio_dev);
> +
> +	ret = devm_iio_trigger_register(&indio_dev->dev, data->trig);
> +	if (ret < 0)
> +		return ret;
> +
> +	indio_dev->trig = iio_trigger_get(data->trig);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(bmi160_probe_trigger);

