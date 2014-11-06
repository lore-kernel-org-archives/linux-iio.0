Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43893 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbaKFPFJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 6 Nov 2014 10:05:09 -0500
Message-ID: <1415286040.7340.12.camel@spandruv-hsb-test>
Subject: Re: [PATCH 1/3] iio: ak8975: minor fixes
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: jic23@kernel.org, knaack.h@gmx.de, linux-iio@vger.kernel.org
Date: Thu, 06 Nov 2014 07:00:40 -0800
In-Reply-To: <1415225452-21957-2-git-send-email-gwendal@chromium.org>
References: <CAMHSBOWmmCdd=5HXJN-vz9saaPrq3n0p-LjCNvnX3Q3ZieZdRQ@mail.gmail.com>
	 <1415225452-21957-1-git-send-email-gwendal@chromium.org>
	 <1415225452-21957-2-git-send-email-gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 2014-11-05 at 14:10 -0800, Gwendal Grignou wrote:
> Fixes code duplication, return of function.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/magnetometer/ak8975.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index bf5ef07..12f0b00 100644
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
> @@ -231,6 +231,10 @@ static int ak8975_setup(struct i2c_client *client)
>  				AK8975_REG_CNTL_MODE_POWER_DOWN,
>  				AK8975_REG_CNTL_MODE_MASK,
>  				AK8975_REG_CNTL_MODE_SHIFT);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Error in setting power-down mode\n");
> +		return ret;
> +	}
>  
>  	if (data->eoc_gpio > 0 || client->irq) {
>  		ret = ak8975_setup_irq(data);
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
Looks OK to me.

