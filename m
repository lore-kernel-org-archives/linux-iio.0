Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40148 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbaKVL2F (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Nov 2014 06:28:05 -0500
Message-ID: <54707340.6000806@kernel.org>
Date: Sat, 22 Nov 2014 11:28:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Gwendal Grignou <gwendal@chromium.org>,
	srinivas.pandruvada@linux.intel.com, knaack.h@gmx.de
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iio: ak8975: minor fixes
References: <1416595549-18717-1-git-send-email-gwendal@chromium.org> <1416595549-18717-2-git-send-email-gwendal@chromium.org>
In-Reply-To: <1416595549-18717-2-git-send-email-gwendal@chromium.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/11/14 18:45, Gwendal Grignou wrote:
> Fixes code duplication, return of function.
> Check client->irq properly when setting up optional irq handler.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the togreg branch of iio.git - pushed out as testing for the
autobuilder to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/magnetometer/ak8975.c | 35 ++++++++++++++---------------------
>  1 file changed, 14 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index bf5ef07..4e69480 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -64,10 +64,10 @@
>  #define AK8975_REG_CNTL			0x0A
>  #define AK8975_REG_CNTL_MODE_SHIFT	0
>  #define AK8975_REG_CNTL_MODE_MASK	(0xF << AK8975_REG_CNTL_MODE_SHIFT)
> -#define AK8975_REG_CNTL_MODE_POWER_DOWN	0
> -#define AK8975_REG_CNTL_MODE_ONCE	1
> -#define AK8975_REG_CNTL_MODE_SELF_TEST	8
> -#define AK8975_REG_CNTL_MODE_FUSE_ROM	0xF
> +#define AK8975_REG_CNTL_MODE_POWER_DOWN	0x00
> +#define AK8975_REG_CNTL_MODE_ONCE	0x01
> +#define AK8975_REG_CNTL_MODE_SELF_TEST	0x08
> +#define AK8975_REG_CNTL_MODE_FUSE_ROM	0x0F
>  
>  #define AK8975_REG_RSVC			0x0B
>  #define AK8975_REG_ASTC			0x0C
> @@ -166,8 +166,8 @@ static int ak8975_setup_irq(struct ak8975_data *data)
>  		irq = gpio_to_irq(data->eoc_gpio);
>  
>  	rc = devm_request_irq(&client->dev, irq, ak8975_irq_handler,
> -			 IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> -			 dev_name(&client->dev), data);
> +			      IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +			      dev_name(&client->dev), data);
>  	if (rc < 0) {
>  		dev_err(&client->dev,
>  			"irq %d request failed, (gpio %d): %d\n",
> @@ -231,8 +231,12 @@ static int ak8975_setup(struct i2c_client *client)
>  				AK8975_REG_CNTL_MODE_POWER_DOWN,
>  				AK8975_REG_CNTL_MODE_MASK,
>  				AK8975_REG_CNTL_MODE_SHIFT);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Error in setting power-down mode\n");
> +		return ret;
> +	}
>  
> -	if (data->eoc_gpio > 0 || client->irq) {
> +	if (data->eoc_gpio > 0 || client->irq > 0) {
>  		ret = ak8975_setup_irq(data);
>  		if (ret < 0) {
>  			dev_err(&client->dev,
> @@ -241,11 +245,6 @@ static int ak8975_setup(struct i2c_client *client)
>  		}
>  	}
>  
> -	if (ret < 0) {
> -		dev_err(&client->dev, "Error in setting power-down mode\n");
> -		return ret;
> -	}
> -
>  /*
>   * Precalculate scale factor (in Gauss units) for each axis and
>   * store in the device data.
> @@ -550,24 +549,18 @@ static int ak8975_probe(struct i2c_client *client,
>  	/* Perform some basic start-of-day setup of the device. */
>  	err = ak8975_setup(client);
>  	if (err < 0) {
> -		dev_err(&client->dev, "AK8975 initialization fails\n");
> +		dev_err(&client->dev, "%s initialization fails\n", name);
>  		return err;
>  	}
>  
> -	data->client = client;
>  	mutex_init(&data->lock);
> -	data->eoc_gpio = eoc_gpio;
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->channels = ak8975_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(ak8975_channels);
>  	indio_dev->info = &ak8975_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->name = name;
> -	err = devm_iio_device_register(&client->dev, indio_dev);
> -	if (err < 0)
> -		return err;
> -
> -	return 0;
> +	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
>  static const struct i2c_device_id ak8975_id[] = {
> @@ -588,7 +581,7 @@ MODULE_DEVICE_TABLE(of, ak8975_of_match);
>  static struct i2c_driver ak8975_driver = {
>  	.driver = {
>  		.name	= "ak8975",
> -		.of_match_table = ak8975_of_match,
> +		.of_match_table = of_match_ptr(ak8975_of_match),
>  		.acpi_match_table = ACPI_PTR(ak_acpi_match),
>  	},
>  	.probe		= ak8975_probe,
> 

