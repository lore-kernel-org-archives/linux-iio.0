Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43410 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757127Ab2EaH2t (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 31 May 2012 03:28:49 -0400
Message-ID: <4FC71DAC.3080802@kernel.org>
Date: Thu, 31 May 2012 08:28:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Leed Aguilar <leed.aguilar@ti.com>
CC: linux-iio@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH] staging:iio:magnetometer:ak8975: fix the sensor enable
 logic
References: <1338437446-12829-1-git-send-email-leed.aguilar@ti.com>
In-Reply-To: <1338437446-12829-1-git-send-email-leed.aguilar@ti.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Also cc'd Laxman for comments.
> Allow the magn sensor raw attributes to be available only
> when enable is true.
>
> The single measurement mode change to power-down mode
> automatically once the sensor data is measured, so there
> is no need to enable this mode to allow the data reading
> process (ak8975_read_axis) to begin, which internally is
> setting the single measurement mode to take a sample.
Hmm. I'm not terribly keen on this as it's just changed from one non
abi compliant attribute to a different one.

We need to take another look at how to handle low power modes etc.
We could add some heuristics in driver on when to disable the device,
but that is obviously not that flexible.

Otherwise I'd much prefer a kernel wide view on manual disables
of indivual devices to adhoc bits of code liek this...

The underlying change to do with not explicitly setting power down
modes is fine, but I'd like Laxman's comment on this as I don't have
one.
>
> Change-Id: I428afa7cb2d4894e8730a5afc3dd009675a78bef
> Signed-off-by: Leed Aguilar<leed.aguilar@ti.com>
> Cc: Jonathan Cameron<jic23@kernel.org>
> ---
>   drivers/staging/iio/magnetometer/ak8975.c |   52 ++++++++++-------------------
>   1 files changed, 18 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
> index b06bd2d..ef107fa 100644
> --- a/drivers/staging/iio/magnetometer/ak8975.c
> +++ b/drivers/staging/iio/magnetometer/ak8975.c
> @@ -92,7 +92,7 @@ struct ak8975_data {
>   	struct mutex		lock;
>   	u8			asa[3];
>   	long			raw_to_gauss[3];
> -	bool			mode;
> +	bool			enable;
>   	u8			reg_cache[AK8975_MAX_REGS];
>   	int			eoc_gpio;
>   	int			eoc_irq;
> @@ -250,53 +250,36 @@ static int ak8975_setup(struct i2c_client *client)
>   /*
>    * Shows the device's mode.  0 = off, 1 = on.
>    */
> -static ssize_t show_mode(struct device *dev, struct device_attribute *devattr,
> -			 char *buf)
> +static ssize_t show_enable(struct device *dev,
> +				struct device_attribute *devattr, char *buf)
>   {
>   	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>   	struct ak8975_data *data = iio_priv(indio_dev);
>
> -	return sprintf(buf, "%u\n", data->mode);
> +	return sprintf(buf, "%u\n", data->enable);
>   }
>
>   /*
> - * Sets the device's mode.  0 = off, 1 = on.  The device's mode must be on
> - * for the magn raw attributes to be available.
> + * Set the sensor enable state for the magn raw attributes to be available.
>    */
> -static ssize_t store_mode(struct device *dev, struct device_attribute *devattr,
> -			  const char *buf, size_t count)
> +static ssize_t store_enable(struct device *dev,
> +				struct device_attribute *devattr,
> +				const char *buf, size_t count)
>   {
>   	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>   	struct ak8975_data *data = iio_priv(indio_dev);
> -	struct i2c_client *client = data->client;
>   	bool value;
>   	int ret;
>
> -	/* Convert mode string and do some basic sanity checking on it.
> -	   only 0 or 1 are valid. */
> +	/* Convert the enable string and do some basic sanity checking on it.
> +	   Only 0 or 1 are valid. */
>   	ret = strtobool(buf,&value);
>   	if (ret<  0)
>   		return ret;
>
> -	mutex_lock(&data->lock);
> -
> -	/* Write the mode to the device. */
> -	if (data->mode != value) {
> -		ret = ak8975_write_data(client,
> -					AK8975_REG_CNTL,
> -					(u8)value,
> -					AK8975_REG_CNTL_MODE_MASK,
> -					AK8975_REG_CNTL_MODE_SHIFT);
> -
> -		if (ret<  0) {
> -			dev_err(&client->dev, "Error in setting mode\n");
> -			mutex_unlock(&data->lock);
> -			return ret;
> -		}
> -		data->mode = value;
> -	}
> -
> -	mutex_unlock(&data->lock);
> +	/* Set the enable state */
> +	if (data->enable != value)
> +		data->enable = value;
>
>   	return count;
>   }
> @@ -368,8 +351,8 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
>
>   	mutex_lock(&data->lock);
>
> -	if (data->mode == 0) {
> -		dev_err(&client->dev, "Operating mode is in power down mode\n");
> +	if (data->enable == 0) {
> +		dev_err(&client->dev, "Sensor is not enabled\n");
>   		ret = -EBUSY;
>   		goto exit;
>   	}
> @@ -464,10 +447,10 @@ static const struct iio_chan_spec ak8975_channels[] = {
>   	AK8975_CHANNEL(X, 0), AK8975_CHANNEL(Y, 1), AK8975_CHANNEL(Z, 2),
>   };
>
> -static IIO_DEVICE_ATTR(mode, S_IRUGO | S_IWUSR, show_mode, store_mode, 0);
> +static IIO_DEVICE_ATTR(enable, S_IRUGO | S_IWUSR, show_enable, store_enable, 0);
>
>   static struct attribute *ak8975_attr[] = {
> -	&iio_dev_attr_mode.dev_attr.attr,
> +	&iio_dev_attr_enable.dev_attr.attr,
>   	NULL
>   };
>
> @@ -522,6 +505,7 @@ static int ak8975_probe(struct i2c_client *client,
>   		goto exit_free_iio;
>   	}
>
> +	data->enable = 0;
>   	data->client = client;
>   	mutex_init(&data->lock);
>   	data->eoc_irq = client->irq;

