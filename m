Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52166 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbbHPIBn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 16 Aug 2015 04:01:43 -0400
Subject: Re: [PATCH v2 3/3] iio: mxc4005: add data ready trigger for mxc4005
To: Teodora Baluta <teodora.baluta@intel.com>
References: <1439487101-13085-1-git-send-email-teodora.baluta@intel.com>
 <1439487101-13085-4-git-send-email-teodora.baluta@intel.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	daniel.baluta@intel.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55D04363.4040101@kernel.org>
Date: Sun, 16 Aug 2015 09:01:39 +0100
MIME-Version: 1.0
In-Reply-To: <1439487101-13085-4-git-send-email-teodora.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/08/15 18:31, Teodora Baluta wrote:
> Add iio trigger for the data ready interrupt that signals new
> measurements for the X, Y and Z axes.
> 
> Signed-off-by: Teodora Baluta <teodora.baluta@intel.com>
Various bits inline.

Jonathan
> ---
>  drivers/iio/accel/mxc4005.c | 159 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 158 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
> index 5f4813d..0c47bfe 100644
> --- a/drivers/iio/accel/mxc4005.c
> +++ b/drivers/iio/accel/mxc4005.c
> @@ -17,13 +17,16 @@
>  #include <linux/i2c.h>
>  #include <linux/iio/iio.h>
>  #include <linux/acpi.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/regmap.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
>  
>  #define MXC4005_DRV_NAME		"mxc4005"
> +#define MXC4005_IRQ_NAME		"mxc4005_event"
>  #define MXC4005_REGMAP_NAME		"mxc4005_regmap"
>  
>  #define MXC4005_REG_XOUT_UPPER		0x03
> @@ -33,6 +36,15 @@
>  #define MXC4005_REG_ZOUT_UPPER		0x07
>  #define MXC4005_REG_ZOUT_LOWER		0x08
>  
> +#define MXC4005_REG_INT_SRC1		0x01
> +#define MXC4005_REG_INT_SRC2_BIT_DRDY	0x01
> +
> +#define MXC4005_REG_INT_MASK1		0x0B
> +#define MXC4005_REG_INT_MASK1_BIT_DRDYE	0x01
> +
> +#define MXC4005_REG_INT_CLR1		0x01
> +#define MXC4005_REG_INT_CLR1_BIT_DRDYC	0x01
> +
>  #define MXC4005_REG_CONTROL		0x0D
>  #define MXC4005_REG_CONTROL_MASK_FSR	GENMASK(6, 5)
>  #define MXC4005_CONTROL_FSR_SHIFT	5
> @@ -55,7 +67,10 @@ struct mxc4005_data {
>  	struct i2c_client *client;
>  	struct mutex mutex;
>  	struct regmap *regmap;
> +	struct iio_trigger *dready_trig;

As mentioned below, use the pf->timestamp or you'll get in a mess if for
example you driver the capture from this via a slow sysfs trigger.
> +	int64_t timestamp;
>  	__be16 buffer[3];
> +	bool trigger_enabled;
>  };
>  
>  /*
> @@ -97,6 +112,7 @@ static bool mxc4005_is_readable_reg(struct device *dev, unsigned int reg)
>  	case MXC4005_REG_ZOUT_UPPER:
>  	case MXC4005_REG_ZOUT_LOWER:
>  	case MXC4005_REG_DEVICE_ID:
> +	case MXC4005_REG_INT_SRC1:
>  	case MXC4005_REG_CONTROL:
>  		return true;
>  	default:
> @@ -107,6 +123,8 @@ static bool mxc4005_is_readable_reg(struct device *dev, unsigned int reg)
>  static bool mxc4005_is_writeable_reg(struct device *dev, unsigned int reg)
>  {
>  	switch (reg) {
> +	case MXC4005_REG_INT_CLR1:
> +	case MXC4005_REG_INT_MASK1:
>  	case MXC4005_REG_CONTROL:
>  		return true;
>  	default:
> @@ -300,7 +318,7 @@ static irqreturn_t mxc4005_trigger_handler(int irq, void *private)
>  		goto err;
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> -					   iio_get_time_ns());
> +					   data->timestamp);
Who said this was being triggered by the devices own trigger?  If
you want to do this, then use pull the timestamp save in the pollfunc
top half. (iio_pollfunc_store_time is available for this).

>  
>  err:
>  	iio_trigger_notify_done(indio_dev->trig);
> @@ -308,6 +326,103 @@ err:
>  	return IRQ_HANDLED;
>  }
>  
> +static int mxc4005_set_trigger_state(struct iio_trigger *trig,
> +				     bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct mxc4005_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +	if (state) {
> +		ret = regmap_write(data->regmap, MXC4005_REG_INT_MASK1,
> +				   MXC4005_REG_INT_MASK1_BIT_DRDYE);
> +	} else {
> +		ret = regmap_write(data->regmap, MXC4005_REG_INT_MASK1,
> +				   ~MXC4005_REG_INT_MASK1_BIT_DRDYE);
> +	}
> +
> +	if (ret < 0) {
> +		mutex_unlock(&data->mutex);
> +		dev_err(&data->client->dev,
> +			"failed to update reg_int_mask1");
> +		return ret;
> +	}
> +
> +	data->trigger_enabled = state;
> +	mutex_unlock(&data->mutex);
> +
> +	return 0;
> +}
> +
> +static const struct iio_trigger_ops mxc4005_trigger_ops = {
> +	.set_trigger_state = mxc4005_set_trigger_state,
> +	.owner = THIS_MODULE,
> +};
> +
> +static irqreturn_t mxc4005_irq_thrd_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct mxc4005_data *data = iio_priv(indio_dev);
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, MXC4005_REG_INT_SRC1, &reg);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "failed to read reg_int_src1\n");
> +		goto exit;
> +	}
Guessing you have to read the interrupt source to get it clear?  If so
please comment it.  If not, don't bother reading it :)
> +
> +	/* clear interrupt */
> +	ret = regmap_write(data->regmap, MXC4005_REG_INT_CLR1,
> +			   MXC4005_REG_INT_CLR1_BIT_DRDYC);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "failed to write to reg_int_clr1\n");
> +		goto exit;
> +	}

This is what the try_to_reenable callback is meant for.  That will clear
the interrupt, only when all child interrupts are done (i.e. all
triggers consumers are ready for the next one).  Here you clear it immediately
and hence could end up feeding interrupts into that system faster than they
can be handled (though the masking that occurs should prevent that actually
causing too much trouble).

> +
> +exit:
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t mxc4005_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct mxc4005_data *data = iio_priv(indio_dev);
> +
> +	data->timestamp = iio_get_time_ns();
> +
Right now you don't need this as this is the only supported interrupt.
I'm guessing you have some events to come though?
> +	if (data->trigger_enabled)
> +		iio_trigger_poll(data->dready_trig);
> +
Unusual to have a thread handler here when only one interrupt type is possible.
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static int mxc4005_gpio_probe(struct i2c_client *client,
> +			      struct mxc4005_data *data)
> +{
> +	struct device *dev;
> +	struct gpio_desc *gpio;
> +	int ret;
> +
> +	if (!client)
> +		return -EINVAL;
> +
> +	dev = &client->dev;
> +
> +	gpio = devm_gpiod_get_index(dev, "mxc4005_int", 0, GPIOD_IN);
> +	if (IS_ERR(gpio)) {
> +		dev_err(dev, "failed to get acpi gpio index\n");
> +		return PTR_ERR(gpio);
> +	}
> +
> +	ret = gpiod_to_irq(gpio);
> +
> +	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
> +
> +	return ret;
> +}
> +
>  static int mxc4005_chip_init(struct mxc4005_data *data)
>  {
>  	int ret;
> @@ -373,6 +488,43 @@ static int mxc4005_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> +	if (client->irq < 0)
> +		client->irq = mxc4005_gpio_probe(client, data);
> +
> +	if (client->irq >= 0) {
Should be > 0.

IRQ of 0 is nolonger considered valid (used to indicate a specified not
connected IRQ which isn't going to be useful here!)

Had a patch set correcting all remaining cases of this in IIO the other
day.  Quite a few years ago now, IRQ 0 was valid on arm, but that was
changed.

> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +						mxc4005_irq_handler,
> +						mxc4005_irq_thrd_handler,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
> +						MXC4005_IRQ_NAME,
> +						indio_dev);
> +		if (ret) {
> +			dev_err(&client->dev,
> +				"failed to init threaded irq\n");
> +			goto err_buffer_cleanup;
> +		}
> +
> +		data->dready_trig = devm_iio_trigger_alloc(&client->dev,
> +							   "%s-dev%d",
> +							   indio_dev->name,
> +							   indio_dev->id);
> +		if (!data->dready_trig)
> +			return -ENOMEM;
> +
> +		data->dready_trig->dev.parent = &client->dev;
> +		data->dready_trig->ops = &mxc4005_trigger_ops;
> +		iio_trigger_set_drvdata(data->dready_trig, indio_dev);
> +		indio_dev->trig = data->dready_trig;
> +		iio_trigger_get(indio_dev->trig);
> +		ret = iio_trigger_register(data->dready_trig);
> +		if (ret) {
> +			dev_err(&client->dev,
> +				"failed to register trigger\n");
> +			goto err_trigger_unregister;
> +		}
> +	}
> +
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
>  		dev_err(&client->dev,
> @@ -382,6 +534,8 @@ static int mxc4005_probe(struct i2c_client *client,
>  
>  	return 0;
>  
> +err_trigger_unregister:
> +	iio_trigger_unregister(data->dready_trig);
>  err_buffer_cleanup:
>  	iio_triggered_buffer_cleanup(indio_dev);
>  
> @@ -391,10 +545,13 @@ err_buffer_cleanup:
>  static int mxc4005_remove(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct mxc4005_data *data = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
>  
>  	iio_triggered_buffer_cleanup(indio_dev);
> +	if (data->dready_trig)
> +		iio_trigger_unregister(data->dready_trig);
>  
>  	return 0;
>  }
> 

