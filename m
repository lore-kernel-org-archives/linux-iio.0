Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37448 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2999337AbdEAAcG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Apr 2017 20:32:06 -0400
Subject: Re: [PATCH v2 3/4] iio: accel: adxl345: Setup DATA_READY trigger
To: Eva Rachel Retuya <eraretuya@gmail.com>, linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dmitry.torokhov@gmail.com, michael.hennerich@analog.com,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        florian.vaussard@heig-vd.ch, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
References: <cover.1493450577.git.eraretuya@gmail.com>
 <d5c737cf4e5a2d639d09ad95f58ab32e01d0c338.1493450577.git.eraretuya@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <977684c1-8c87-80ae-fc13-576e30e88384@kernel.org>
Date: Mon, 1 May 2017 01:32:00 +0100
MIME-Version: 1.0
In-Reply-To: <d5c737cf4e5a2d639d09ad95f58ab32e01d0c338.1493450577.git.eraretuya@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/04/17 08:49, Eva Rachel Retuya wrote:
> The ADXL345 provides a DATA_READY interrupt function to signal
> availability of new data. This interrupt function is latched and can be
> cleared by reading the data registers. The polarity is set to active
> high by default.
> 
> Support this functionality by setting it up as an IIO trigger.
> 
> In addition, two output pins INT1 and INT2 are available for driving
> interrupts. Allow mapping to either pins by specifying the
> interrupt-names property in device tree.
> 
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
Coming together nicely, but a few more bits and pieces inline...

One slight worry is that the irq names stuff is to restrictive
as we want to direct different interrupts to different pins if
both are supported!

Jonathan
> ---
> Changes in v2:
> * Provide a detailed commit message
> * Move the of_irq_get_byname() check in core file in order to avoid
>   introducing another parameter in probe()
> * adxl345_irq():
>   * return values directly
>   * switch from iio_trigger_poll() to iio_trigger_poll_chained(), the former
>     should only be called at the top-half not at the bottom-half.
> * adxl345_drdy_trigger_set_state():
>   * move regmap_get_device() to definition block
>   * regmap_update_bits(): line splitting - one parameter per line, remove extra
>     parenthesis
> * probe()
>   * use variable 'regval' to hold value to be written to the register and call
>     regmap_write() unconditionally
>   * fix line splitting in devm_request_threaded_irq() and devm_iio_trigger_alloc()
>   * Switch to devm_iio_trigger_register()
> 
>  drivers/iio/accel/adxl345.h      |   2 +-
>  drivers/iio/accel/adxl345_core.c | 104 ++++++++++++++++++++++++++++++++++++++-
>  drivers/iio/accel/adxl345_i2c.c  |   3 +-
>  drivers/iio/accel/adxl345_spi.c  |   2 +-
>  4 files changed, 107 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> index c1ddf39..d2fa806 100644
> --- a/drivers/iio/accel/adxl345.h
> +++ b/drivers/iio/accel/adxl345.h
> @@ -11,7 +11,7 @@
>  #ifndef _ADXL345_H_
>  #define _ADXL345_H_
>  
> -int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> +int adxl345_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  		       const char *name);
>  int adxl345_core_remove(struct device *dev);
>  
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index b8a212c..b8be0d7 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -9,15 +9,20 @@
>   */
>  
>  #include <linux/delay.h>
> +#include <linux/interrupt.h>
>  #include <linux/module.h>
> +#include <linux/of_irq.h>
>  #include <linux/regmap.h>
>  
>  #include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
>  
>  #include "adxl345.h"
>  
>  #define ADXL345_REG_DEVID		0x00
>  #define ADXL345_REG_POWER_CTL		0x2D
> +#define ADXL345_REG_INT_ENABLE		0x2E
> +#define ADXL345_REG_INT_MAP		0x2F
>  #define ADXL345_REG_INT_SOURCE		0x30
>  #define ADXL345_REG_DATA_FORMAT		0x31
>  #define ADXL345_REG_DATAX0		0x32
> @@ -39,6 +44,8 @@
>  
>  #define ADXL345_DEVID			0xE5
>  
> +#define ADXL345_IRQ_NAME		"adxl345_event"
I'd just put this inline.  It doesn't really give any benefit to
have this defined at the top.
> +
>  /*
>   * In full-resolution mode, scale factor is maintained at ~4 mg/LSB
>   * in all g ranges.
> @@ -49,6 +56,8 @@
>  static const int adxl345_uscale = 38300;
>  
>  struct adxl345_data {
> +	struct iio_trigger *data_ready_trig;
> +	bool data_ready_trig_on;
>  	struct regmap *regmap;
>  	struct mutex lock; /* protect this data structure */
>  	u8 data_range;
> @@ -158,17 +167,62 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> +static irqreturn_t adxl345_irq(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct adxl345_data *data = iio_priv(indio_dev);
> +	int ret;
> +	u32 int_stat;
> +
> +	ret = regmap_read(data->regmap, ADXL345_REG_INT_SOURCE, &int_stat);
> +	if (ret < 0)
> +		return IRQ_HANDLED;
> +
> +	if (int_stat & ADXL345_INT_DATA_READY) {
> +		iio_trigger_poll_chained(data->data_ready_trig);
> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_NONE;
> +}
> +
> +static int adxl345_drdy_trigger_set_state(struct iio_trigger *trig, bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct adxl345_data *data = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	ret = regmap_update_bits(data->regmap,
> +				 ADXL345_REG_INT_ENABLE,
> +				 ADXL345_INT_DATA_READY,
> +				 state ? ADXL345_INT_DATA_READY : 0);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to update INT_ENABLE bits\n");
> +		return ret;
> +	}
> +	data->data_ready_trig_on = state;
> +
> +	return ret;
> +}
> +
> +static const struct iio_trigger_ops adxl345_trigger_ops = {
> +	.owner = THIS_MODULE,
> +	.set_trigger_state = adxl345_drdy_trigger_set_state,
> +};
> +
>  static const struct iio_info adxl345_info = {
>  	.driver_module	= THIS_MODULE,
>  	.read_raw	= adxl345_read_raw,
>  };
>  
> -int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> +int adxl345_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  		       const char *name)
>  {
>  	struct adxl345_data *data;
>  	struct iio_dev *indio_dev;
>  	u32 regval;
> +	int of_irq;
>  	int ret;
>  
>  	ret = regmap_read(regmap, ADXL345_REG_DEVID, &regval);
> @@ -199,6 +253,22 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  		dev_err(dev, "Failed to set data range: %d\n", ret);
>  		return ret;
>  	}
> +	/*
> +	 * Any bits set to 0 send their respective interrupts to the INT1 pin,
> +	 * whereas bits set to 1 send their respective interrupts to the INT2
> +	 * pin. Map all interrupts to the specified pin.
This is an interesting comment.  The usual reason for dual interrupt
pins is precisely to not map all functions to the same one.  That allows
for a saving in querying which interrupt it is by having just the data ready
on one pin and just the events on the other...

Perhaps the current approach won't support that mode of operation?
Clearly we can't merge a binding that enforces them all being the same
and then change it later as it'll be incompatible.

I'm not quite sure how one should do this sort of stuff in DT though.

Rob?
> +	 */
> +	of_irq = of_irq_get_byname(dev->of_node, "INT2");
> +	if (of_irq == irq)
> +		regval = 0xFF;
> +	else
> +		regval = 0x00;
> +
> +	ret = regmap_write(data->regmap, ADXL345_REG_INT_MAP, regval);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to set up interrupts: %d\n", ret);
> +		return ret;
> +	}
>  
>  	mutex_init(&data->lock);
>  
> @@ -209,6 +279,38 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	indio_dev->channels = adxl345_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
>  
> +	if (irq > 0) {
> +		ret = devm_request_threaded_irq(dev,
> +						irq,
> +						NULL,
> +						adxl345_irq,
> +						IRQF_TRIGGER_HIGH |
> +						IRQF_ONESHOT,
> +						ADXL345_IRQ_NAME,
> +						indio_dev);
> +		if (ret < 0) {
> +			dev_err(dev, "Failed to request irq: %d\n", irq);
> +			return ret;
> +		}
> +
> +		data->data_ready_trig = devm_iio_trigger_alloc(dev,
> +							       "%s-dev%d",
> +							       indio_dev->name,
> +							       indio_dev->id);
> +		if (!data->data_ready_trig)
> +			return -ENOMEM;
> +
> +		data->data_ready_trig->dev.parent = dev;
> +		data->data_ready_trig->ops = &adxl345_trigger_ops;
> +		iio_trigger_set_drvdata(data->data_ready_trig, indio_dev);
> +
> +		ret = devm_iio_trigger_register(dev, data->data_ready_trig);
> +		if (ret) {
> +			dev_err(dev, "Failed to register trigger: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0)
>  		dev_err(dev, "iio_device_register failed: %d\n", ret);
> diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
> index 05e1ec4..31af702 100644
> --- a/drivers/iio/accel/adxl345_i2c.c
> +++ b/drivers/iio/accel/adxl345_i2c.c
> @@ -34,7 +34,8 @@ static int adxl345_i2c_probe(struct i2c_client *client,
>  		return PTR_ERR(regmap);
>  	}
>  
> -	return adxl345_core_probe(&client->dev, regmap, id ? id->name : NULL);
> +	return adxl345_core_probe(&client->dev, regmap, client->irq,
> +				  id ? id->name : NULL);
>  }
>  
>  static int adxl345_i2c_remove(struct i2c_client *client)
> diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
> index 6d65819..75a8c12 100644
> --- a/drivers/iio/accel/adxl345_spi.c
> +++ b/drivers/iio/accel/adxl345_spi.c
> @@ -42,7 +42,7 @@ static int adxl345_spi_probe(struct spi_device *spi)
>  		return PTR_ERR(regmap);
>  	}
>  
> -	return adxl345_core_probe(&spi->dev, regmap, id->name);
> +	return adxl345_core_probe(&spi->dev, regmap, spi->irq, id->name);
>  }
>  
>  static int adxl345_spi_remove(struct spi_device *spi)
> 

