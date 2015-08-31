Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38368 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422AbbHaQlY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2015 12:41:24 -0400
Subject: Re: [PATCH v3 3/3] iio: mxc4005: add data ready trigger for mxc4005
To: Teodora Baluta <teodora.baluta@intel.com>
References: <1440081453-12600-1-git-send-email-teodora.baluta@intel.com>
 <1440081453-12600-4-git-send-email-teodora.baluta@intel.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	daniel.baluta@intel.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55E483B2.5030705@kernel.org>
Date: Mon, 31 Aug 2015 17:41:22 +0100
MIME-Version: 1.0
In-Reply-To: <1440081453-12600-4-git-send-email-teodora.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/08/15 15:37, Teodora Baluta wrote:
> Add iio trigger for the data ready interrupt that signals new
> measurements for the X, Y and Z axes.
> 
> Signed-off-by: Teodora Baluta <teodora.baluta@intel.com>
Or alternatively you lost a stray line into this patch from the
previous one (the pollfunc line!)  Anyhow, all's well that ends
well!

Applied this one (with predictable fuzz) to the togreg branch of
iio.git - initially pushed out as testing for the autobuilders to
play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/mxc4005.c | 144 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 142 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
> index 95b91b5..e72e218 100644
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
> @@ -33,6 +36,12 @@
>  #define MXC4005_REG_ZOUT_UPPER		0x07
>  #define MXC4005_REG_ZOUT_LOWER		0x08
>  
> +#define MXC4005_REG_INT_MASK1		0x0B
> +#define MXC4005_REG_INT_MASK1_BIT_DRDYE	0x01
> +
> +#define MXC4005_REG_INT_CLR1		0x01
> +#define MXC4005_REG_INT_CLR1_BIT_DRDYC	0x01
> +
>  #define MXC4005_REG_CONTROL		0x0D
>  #define MXC4005_REG_CONTROL_MASK_FSR	GENMASK(6, 5)
>  #define MXC4005_CONTROL_FSR_SHIFT	5
> @@ -55,7 +64,9 @@ struct mxc4005_data {
>  	struct device *dev;
>  	struct mutex mutex;
>  	struct regmap *regmap;
> +	struct iio_trigger *dready_trig;
>  	__be16 buffer[8];
> +	bool trigger_enabled;
>  };
>  
>  /*
> @@ -107,6 +118,8 @@ static bool mxc4005_is_readable_reg(struct device *dev, unsigned int reg)
>  static bool mxc4005_is_writeable_reg(struct device *dev, unsigned int reg)
>  {
>  	switch (reg) {
> +	case MXC4005_REG_INT_CLR1:
> +	case MXC4005_REG_INT_MASK1:
>  	case MXC4005_REG_CONTROL:
>  		return true;
>  	default:
> @@ -299,7 +312,7 @@ static irqreturn_t mxc4005_trigger_handler(int irq, void *private)
>  		goto err;
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> -					   iio_get_time_ns());
> +					   pf->timestamp);
>  
>  err:
>  	iio_trigger_notify_done(indio_dev->trig);
> @@ -307,6 +320,91 @@ err:
>  	return IRQ_HANDLED;
>  }
>  
> +static int mxc4005_clr_intr(struct mxc4005_data *data)
> +{
> +	int ret;
> +
> +	/* clear interrupt */
> +	ret = regmap_write(data->regmap, MXC4005_REG_INT_CLR1,
> +			   MXC4005_REG_INT_CLR1_BIT_DRDYC);
> +	if (ret < 0) {
> +		dev_err(data->dev, "failed to write to reg_int_clr1\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
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
> +		dev_err(data->dev, "failed to update reg_int_mask1");
> +		return ret;
> +	}
> +
> +	data->trigger_enabled = state;
> +	mutex_unlock(&data->mutex);
> +
> +	return 0;
> +}
> +
> +static int mxc4005_trigger_try_reen(struct iio_trigger *trig)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct mxc4005_data *data = iio_priv(indio_dev);
> +
> +	if (!data->dready_trig)
> +		return 0;
> +
> +	return mxc4005_clr_intr(data);
> +}
> +
> +static const struct iio_trigger_ops mxc4005_trigger_ops = {
> +	.set_trigger_state = mxc4005_set_trigger_state,
> +	.try_reenable = mxc4005_trigger_try_reen,
> +	.owner = THIS_MODULE,
> +};
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
> @@ -363,7 +461,7 @@ static int mxc4005_probe(struct i2c_client *client,
>  	indio_dev->info = &mxc4005_info;
>  
>  	ret = iio_triggered_buffer_setup(indio_dev,
> -					 &iio_pollfunc_store_time,
> +					 iio_pollfunc_store_time,
>  					 mxc4005_trigger_handler,
>  					 NULL);
>  	if (ret < 0) {
> @@ -372,6 +470,43 @@ static int mxc4005_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> +	if (client->irq < 0)
> +		client->irq = mxc4005_gpio_probe(client, data);
> +
> +	if (client->irq > 0) {
> +		data->dready_trig = devm_iio_trigger_alloc(&client->dev,
> +							   "%s-dev%d",
> +							   indio_dev->name,
> +							   indio_dev->id);
> +		if (!data->dready_trig)
> +			return -ENOMEM;
> +
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +						iio_trigger_generic_data_rdy_poll,
> +						NULL,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
> +						MXC4005_IRQ_NAME,
> +						data->dready_trig);
> +		if (ret) {
> +			dev_err(&client->dev,
> +				"failed to init threaded irq\n");
> +			goto err_buffer_cleanup;
> +		}
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
> @@ -381,6 +516,8 @@ static int mxc4005_probe(struct i2c_client *client,
>  
>  	return 0;
>  
> +err_trigger_unregister:
> +	iio_trigger_unregister(data->dready_trig);
>  err_buffer_cleanup:
>  	iio_triggered_buffer_cleanup(indio_dev);
>  
> @@ -390,10 +527,13 @@ err_buffer_cleanup:
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

