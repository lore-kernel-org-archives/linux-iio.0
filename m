Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:52788 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752521AbcDAIec (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 1 Apr 2016 04:34:32 -0400
Date: Fri, 1 Apr 2016 10:34:30 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 2/2] ti-adc081c: Initial triggered buffer support
In-Reply-To: <b0276dfaa9a6a8ac1777bf5d92753dab1fc493b1.1459444547.git.leonard.crestez@intel.com>
Message-ID: <alpine.DEB.2.02.1604011017450.15685@pmeerw.net>
References: <cover.1459444547.git.leonard.crestez@intel.com> <b0276dfaa9a6a8ac1777bf5d92753dab1fc493b1.1459444547.git.leonard.crestez@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Using this requires software triggers like CONFIG_IIO_HRTIMER_TRIGGER.
> 
> The device can be configured to do internal periodic sampling but does
> not appear to offer some sort of interrupt on data ready. It only offers
> interrupts on values out of a specific range.
> 
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> ---
>  drivers/iio/adc/ti-adc081c.c | 99 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 83 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
> index 9b2f26f..040e2aa 100644
> --- a/drivers/iio/adc/ti-adc081c.c
> +++ b/drivers/iio/adc/ti-adc081c.c
> @@ -24,6 +24,9 @@
>  #include <linux/of.h>
>  
>  #include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  #include <linux/regulator/consumer.h>
>  
>  struct adc081c {
> @@ -69,27 +72,83 @@ static int adc081c_read_raw(struct iio_dev *iio,
>  	return -EINVAL;
>  }
>  
> -static const struct iio_chan_spec adc081c_channel = {
> -	.type = IIO_VOLTAGE,
> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> -};

the patch would look cleaner/shorter if adc081c_channel won't get moved 
around

> +static irqreturn_t adc081c_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct adc081c *data = iio_priv(indio_dev);
> +	s64 ts;
> +	u16 buf[8];

comment: 2 bytes data + 6 bytes padding + 8 bytes timestamp

> +	int ret;
> +
> +	/* Otherwise iio_push_to_buffers will corrupt the stack. */
> +	if (indio_dev->scan_bytes > sizeof(buf)) {
> +		dev_crit_once(&indio_dev->dev, "Bad iio_scan_bytes=%d > %d\n",
> +				indio_dev->scan_bytes, (int)sizeof(buf));

rather than casting sizeof(buf), use the correct printf length modifier, 
i.e. %z

not sure if this check is needed

> +		goto out;
> +	}
> +
> +	ret = i2c_smbus_read_word_swapped(data->i2c, REG_CONV_RES);

REG_CONV_RES should be called ADC081C_REG_CONV_RES, but that's a separate 
issue

> +	ts = iio_get_time_ns();

why is the timestamp taken here?, seems strange
often this is done together with iio_push_to_buffers_with_timestamp()

> +	if (ret < 0)
> +		goto out;
> +	buf[0] = ret;
> +	iio_push_to_buffers_with_timestamp(indio_dev, buf, ts);
> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
>  
>  static const struct iio_info adc081c_info = {
>  	.read_raw = adc081c_read_raw,
>  	.driver_module = THIS_MODULE,
>  };
>  
> +struct adcxx1c_model {
> +	int bits;
> +	const struct iio_chan_spec* channels;
> +};
> +
> +#define ADCxx1C_CHAN(_bits) {					\
> +	.type = IIO_VOLTAGE,					\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.scan_type = {						\
> +		.sign = 'u',					\
> +		.realbits = (_bits),				\
> +		.storagebits = 16,				\
> +		.shift = 12 - (_bits),				\
> +		.endianness = IIO_CPU,				\
> +	},							\
> +}
> +
> +#define DEFINE_ADCxx1C_MODEL(_name, _bits)				\
> +	static const struct iio_chan_spec _name ## _channels[] = {	\
> +		ADCxx1C_CHAN((_bits)),					\
> +		IIO_CHAN_SOFT_TIMESTAMP(1),				\
> +	};								\
> +	static const struct adcxx1c_model _name ## _model = {		\
> +		.bits = (_bits),					\
> +		.channels = _name ## _channels,				\
> +	}
> +
> +DEFINE_ADCxx1C_MODEL(adc081c,  8);
> +DEFINE_ADCxx1C_MODEL(adc101c, 10);
> +DEFINE_ADCxx1C_MODEL(adc121c, 12);
> +
> +struct adcxx1c_info {
> +	int bits;
> +	const struct adc081c_channels* channels;
> +};
> +
>  static int adc081c_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
>  	struct iio_dev *iio;
>  	struct adc081c *adc;
> +	struct adcxx1c_model *model = (struct adcxx1c_model*)id->driver_data;
>  	int err;
>  
> -	if (id->driver_data != 8 && id->driver_data != 10 && id->driver_data != 12)
> -		return -EINVAL;
> -
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
>  		return -EOPNOTSUPP;
>  
> @@ -99,7 +158,7 @@ static int adc081c_probe(struct i2c_client *client,
>  
>  	adc = iio_priv(iio);
>  	adc->i2c = client;
> -	adc->bits = id->driver_data;
> +	adc->bits = model->bits;
>  
>  	adc->ref = devm_regulator_get(&client->dev, "vref");
>  	if (IS_ERR(adc->ref))
> @@ -114,18 +173,26 @@ static int adc081c_probe(struct i2c_client *client,
>  	iio->modes = INDIO_DIRECT_MODE;
>  	iio->info = &adc081c_info;
>  
> -	iio->channels = &adc081c_channel;
> -	iio->num_channels = 1;
> +	iio->channels = model->channels;
> +	iio->num_channels = 2;

the number of channels could go into the adcxx1c_info struct

> +
> +	err = iio_triggered_buffer_setup(iio, NULL, adc081c_trigger_handler, NULL);
> +	if (err < 0) {
> +		dev_err(&client->dev, "iio triggered buffer setup failed\n");
> +		goto err_regulator_disable;
> +	}
>  
>  	err = iio_device_register(iio);
>  	if (err < 0)
> -		goto regulator_disable;
> +		goto err_buffer_cleanup;
>  
>  	i2c_set_clientdata(client, iio);
>  
>  	return 0;
>  
> -regulator_disable:
> +err_buffer_cleanup:
> +	iio_triggered_buffer_cleanup(iio);
> +err_regulator_disable:
>  	regulator_disable(adc->ref);
>  
>  	return err;
> @@ -143,9 +210,9 @@ static int adc081c_remove(struct i2c_client *client)
>  }

iio_triggered_buffer_cleanup() in _remove()?

  
>  static const struct i2c_device_id adc081c_id[] = {
> -	{ "adc081c",  8 },
> -	{ "adc101c", 10 },
> -	{ "adc121c", 12 },
> +	{ "adc081c", (long)&adc081c_model },

often an enum is used instead of a pointer

> +	{ "adc101c", (long)&adc101c_model },
> +	{ "adc121c", (long)&adc121c_model },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, adc081c_id);
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
