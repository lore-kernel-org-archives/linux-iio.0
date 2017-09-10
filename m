Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750923AbdIJQDf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Sep 2017 12:03:35 -0400
Date: Sun, 10 Sep 2017 17:03:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: chemical: ccs811: Add support for data ready
 trigger
Message-ID: <20170910170331.5f6681f7@archlinux>
In-Reply-To: <1504809517-21788-1-git-send-email-narcisaanamaria12@gmail.com>
References: <1504809517-21788-1-git-send-email-narcisaanamaria12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu,  7 Sep 2017 21:38:37 +0300
Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com> wrote:

> Add data ready trigger for hardware interrupts that signal
> new, available measurement samples.
> 
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> Cc: Alison Schofield <amsfield22@gmail.com>
> Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>

Very nice.  Applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with it.

I guess it's going to happen a lot this cycle, but there was some
fuzz due to the THIS_MODULE changes.

Thanks,

Jonathan
> ---
> Changes in v3:
>     - Remove IRQ_NAME macro and use the name directly
>     - Verify the trigger is not null before calling iio_trigger_unregister
> 
> Changes in v2:
>     - Define top half handler for interrupts which calls iio_trigger_poll
>     - Remove bottom half interrupt handler
>     - Add bool variable to store the state of the data ready trigger
>     - Remove threshold related macros and checks, as driver doesn't support
>       threshold interrupts yet
>     - Protect direct/buffered modes, by claiming direct mode in raw readings.
>       Reading the data from ALG_RESULT_DATA will clear the data ready bit and
>       will stop the nINT signal from being driven low. Therefore, disallow
>       raw readings while hardware interrupts are active.
>     - Rephrase commit message
> 
>  drivers/iio/chemical/ccs811.c | 87 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 86 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
> index b59994d..0dfd37b 100644
> --- a/drivers/iio/chemical/ccs811.c
> +++ b/drivers/iio/chemical/ccs811.c
> @@ -23,6 +23,7 @@
>  #include <linux/i2c.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/module.h>
> @@ -60,6 +61,8 @@
>  #define CCS811_MODE_IAQ_60SEC	0x30
>  #define CCS811_MODE_RAW_DATA	0x40
> 
> +#define CCS811_MEAS_MODE_INTERRUPT	BIT(3)
> +
>  #define CCS811_VOLTAGE_MASK	0x3FF
> 
>  struct ccs811_reading {
> @@ -74,6 +77,8 @@ struct ccs811_data {
>  	struct i2c_client *client;
>  	struct mutex lock; /* Protect readings */
>  	struct ccs811_reading buffer;
> +	struct iio_trigger *drdy_trig;
> +	bool drdy_trig_on;
>  };
> 
>  static const struct iio_chan_spec ccs811_channels[] = {
> @@ -194,10 +199,14 @@ static int ccs811_read_raw(struct iio_dev *indio_dev,
> 
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
>  		mutex_lock(&data->lock);
>  		ret = ccs811_get_measurement(data);
>  		if (ret < 0) {
>  			mutex_unlock(&data->lock);
> +			iio_device_release_direct_mode(indio_dev);
>  			return ret;
>  		}
> 
> @@ -229,6 +238,7 @@ static int ccs811_read_raw(struct iio_dev *indio_dev,
>  			ret = -EINVAL;
>  		}
>  		mutex_unlock(&data->lock);
> +		iio_device_release_direct_mode(indio_dev);
> 
>  		return ret;
> 
> @@ -274,6 +284,32 @@ static int ccs811_read_raw(struct iio_dev *indio_dev,
>  	.driver_module = THIS_MODULE,
>  };
> 
> +static int ccs811_set_trigger_state(struct iio_trigger *trig,
> +				    bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct ccs811_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, CCS811_MEAS_MODE);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (state)
> +		ret |= CCS811_MEAS_MODE_INTERRUPT;
> +	else
> +		ret &= ~CCS811_MEAS_MODE_INTERRUPT;
> +
> +	data->drdy_trig_on = state;
> +
> +	return i2c_smbus_write_byte_data(data->client, CCS811_MEAS_MODE, ret);
> +}
> +
> +static const struct iio_trigger_ops ccs811_trigger_ops = {
> +	.set_trigger_state = ccs811_set_trigger_state,
> +	.owner = THIS_MODULE,
> +};
> +
>  static irqreturn_t ccs811_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
> @@ -299,6 +335,17 @@ static irqreturn_t ccs811_trigger_handler(int irq, void *p)
>  	return IRQ_HANDLED;
>  }
> 
> +static irqreturn_t ccs811_data_rdy_trigger_poll(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct ccs811_data *data = iio_priv(indio_dev);
> +
> +	if (data->drdy_trig_on)
> +		iio_trigger_poll(data->drdy_trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int ccs811_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> @@ -347,16 +394,48 @@ static int ccs811_probe(struct i2c_client *client,
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->name = id->name;
>  	indio_dev->info = &ccs811_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> 
>  	indio_dev->channels = ccs811_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(ccs811_channels);
> 
> +	if (client->irq > 0) {
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +						ccs811_data_rdy_trigger_poll,
> +						NULL,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
> +						"ccs811_irq", indio_dev);
> +		if (ret) {
> +			dev_err(&client->dev, "irq request error %d\n", -ret);
> +			goto err_poweroff;
> +		}
> +
> +		data->drdy_trig = devm_iio_trigger_alloc(&client->dev,
> +							 "%s-dev%d",
> +							 indio_dev->name,
> +							 indio_dev->id);
> +		if (!data->drdy_trig) {
> +			ret = -ENOMEM;
> +			goto err_poweroff;
> +		}
> +
> +		data->drdy_trig->dev.parent = &client->dev;
> +		data->drdy_trig->ops = &ccs811_trigger_ops;
> +		iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
> +		indio_dev->trig = data->drdy_trig;
> +		iio_trigger_get(indio_dev->trig);
> +		ret = iio_trigger_register(data->drdy_trig);
> +		if (ret)
> +			goto err_poweroff;
> +	}
> +
>  	ret = iio_triggered_buffer_setup(indio_dev, NULL,
>  					 ccs811_trigger_handler, NULL);
> 
>  	if (ret < 0) {
>  		dev_err(&client->dev, "triggered buffer setup failed\n");
> -		goto err_poweroff;
> +		goto err_trigger_unregister;
>  	}
> 
>  	ret = iio_device_register(indio_dev);
> @@ -368,6 +447,9 @@ static int ccs811_probe(struct i2c_client *client,
> 
>  err_buffer_cleanup:
>  	iio_triggered_buffer_cleanup(indio_dev);
> +err_trigger_unregister:
> +	if (data->drdy_trig)
> +		iio_trigger_unregister(data->drdy_trig);
>  err_poweroff:
>  	i2c_smbus_write_byte_data(client, CCS811_MEAS_MODE, CCS811_MODE_IDLE);
> 
> @@ -377,9 +459,12 @@ static int ccs811_probe(struct i2c_client *client,
>  static int ccs811_remove(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct ccs811_data *data = iio_priv(indio_dev);
> 
>  	iio_device_unregister(indio_dev);
>  	iio_triggered_buffer_cleanup(indio_dev);
> +	if (data->drdy_trig)
> +		iio_trigger_unregister(data->drdy_trig);
> 
>  	return i2c_smbus_write_byte_data(client, CCS811_MEAS_MODE,
>  					 CCS811_MODE_IDLE);
> --
> 1.9.1
> 

