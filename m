Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35830 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770AbcDXLga (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Apr 2016 07:36:30 -0400
Subject: Re: [RFC PATCH 2/3] iio: dummy: Convert IIO dummy to configfs
To: Daniel Baluta <daniel.baluta@intel.com>
References: <1461167126-23399-1-git-send-email-daniel.baluta@intel.com>
 <1461167126-23399-3-git-send-email-daniel.baluta@intel.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2ddba9c6-1f62-468d-da71-7819934f0869@kernel.org>
Date: Sun, 24 Apr 2016 12:36:28 +0100
MIME-Version: 1.0
In-Reply-To: <1461167126-23399-3-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/04/16 16:45, Daniel Baluta wrote:
> We register a new device type named "dummy", this will create a
> configfs entry under:
> 	* /config/iio/devices/dummy.
> 
> Creating dummy devices is now as simple as:
> 
> $ mkdir /config/iio/devices/dummy/my_dummy_device
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
Looks very nice.

I don't think it is unreasonable to demand people have configfs for
the dummy driver so very happy to have this cleaned up.

Now to try it with a few thousand devices and see what breaks ;)

1 trivial point inline.

Jonathan
> ---
>  drivers/iio/dummy/iio_simple_dummy.c | 98 ++++++++++++------------------------
>  1 file changed, 33 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
> index 43fe4ba..65f92f8 100644
> --- a/drivers/iio/dummy/iio_simple_dummy.c
> +++ b/drivers/iio/dummy/iio_simple_dummy.c
> @@ -22,21 +22,12 @@
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/events.h>
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/sw_device.h>
>  #include "iio_simple_dummy.h"
>  
> -/*
> - * A few elements needed to fake a bus for this driver
> - * Note instances parameter controls how many of these
> - * dummy devices are registered.
> - */
> -static unsigned instances = 1;
> -module_param(instances, uint, 0);
> -
> -/* Pointer array used to fake bus elements */
> -static struct iio_dev **iio_dummy_devs;
> -
> -/* Fake a name for the part number, usually obtained from the id table */
> -static const char *iio_dummy_part_number = "iio_dummy_part_no";
> +static struct config_item_type iio_dummy_type = {
> +	.ct_owner = THIS_MODULE,
> +};
>  
>  /**
>   * struct iio_dummy_accel_calibscale - realworld to register mapping
> @@ -572,12 +563,18 @@ static int iio_dummy_init_device(struct iio_dev *indio_dev)
>   *                      const struct i2c_device_id *id)
>   * SPI: iio_dummy_probe(struct spi_device *spi)
>   */
> -static int iio_dummy_probe(int index)
> +static struct iio_sw_device *iio_dummy_probe(const char *name)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev;
>  	struct iio_dummy_state *st;
> +	struct iio_sw_device *swd;
>  
> +	swd = kzalloc(sizeof(*swd), GFP_KERNEL);
> +	if (!swd) {
> +		ret = -ENOMEM;
> +		goto error_kzalloc;
> +	}
>  	/*
>  	 * Allocate an IIO device.
>  	 *
> @@ -608,7 +605,7 @@ static int iio_dummy_probe(int index)
>  	 * i2c_set_clientdata(client, indio_dev);
>  	 * spi_set_drvdata(spi, indio_dev);
>  	 */
> -	iio_dummy_devs[index] = indio_dev;
> +	swd->device = indio_dev;
>  
>  	/*
>  	 * Set the device name.
> @@ -619,7 +616,7 @@ static int iio_dummy_probe(int index)
>  	 *    indio_dev->name = id->name;
>  	 *    indio_dev->name = spi_get_device_id(spi)->name;
>  	 */
> -	indio_dev->name = iio_dummy_part_number;
> +	indio_dev->name = name;
>  
>  	/* Provide description of available channels */
>  	indio_dev->channels = iio_dummy_channels;
> @@ -646,7 +643,8 @@ static int iio_dummy_probe(int index)
>  	if (ret < 0)
>  		goto error_unconfigure_buffer;
>  
> -	return 0;
> +	iio_swd_group_init_type_name(swd, name, &iio_dummy_type);
> +	return swd;
>  error_unconfigure_buffer:
>  	iio_simple_dummy_unconfigure_buffer(indio_dev);
>  error_unregister_events:
> @@ -654,16 +652,18 @@ error_unregister_events:
>  error_free_device:
>  	iio_device_free(indio_dev);
>  error_ret:
> -	return ret;
> +	kfree(swd);
> +error_kzalloc:
> +	return ERR_PTR(ret);
>  }
>  
>  /**
>   * iio_dummy_remove() - device instance removal function
> - * @index: device index.
> + * @swd: pointer to software IIO device abstraction
>   *
>   * Parameters follow those of iio_dummy_probe for buses.
>   */
> -static void iio_dummy_remove(int index)
> +static int iio_dummy_remove(struct iio_sw_device *swd)
>  {
>  	/*
>  	 * Get a pointer to the device instance iio_dev structure
> @@ -671,7 +671,7 @@ static void iio_dummy_remove(int index)
>  	 * struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  	 * struct iio_dev *indio_dev = spi_get_drvdata(spi);
>  	 */
> -	struct iio_dev *indio_dev = iio_dummy_devs[index];
> +	struct iio_dev *indio_dev = swd->device;
>  
>  	/* Unregister the device */
>  	iio_device_unregister(indio_dev);
> @@ -685,10 +685,10 @@ static void iio_dummy_remove(int index)
>  
>  	/* Free all structures */
>  	iio_device_free(indio_dev);
blank line here (nitpick of the day ;)
> +	return 0;
>  }
> -
>  /**
> - * iio_dummy_init() -  device driver registration
> + * module_iio_sw_device_driver() -  device driver registration
>   *
>   * Varies depending on bus type of the device. As there is no device
>   * here, call probe directly. For information on device registration
> @@ -697,50 +697,18 @@ static void iio_dummy_remove(int index)
>   * spi:
>   * Documentation/spi/spi-summary
>   */
> -static __init int iio_dummy_init(void)
> -{
> -	int i, ret;
> -
> -	if (instances > 10) {
> -		instances = 1;
> -		return -EINVAL;
> -	}
> -
> -	/* Fake a bus */
> -	iio_dummy_devs = kcalloc(instances, sizeof(*iio_dummy_devs),
> -				 GFP_KERNEL);
> -	/* Here we have no actual device so call probe */
> -	for (i = 0; i < instances; i++) {
> -		ret = iio_dummy_probe(i);
> -		if (ret < 0)
> -			goto error_remove_devs;
> -	}
> -	return 0;
> -
> -error_remove_devs:
> -	while (i--)
> -		iio_dummy_remove(i);
> -
> -	kfree(iio_dummy_devs);
> -	return ret;
> -}
> -module_init(iio_dummy_init);
> +static const struct iio_sw_device_ops iio_dummy_device_ops = {
> +	.probe = iio_dummy_probe,
> +	.remove = iio_dummy_remove,
> +};
>  
> -/**
> - * iio_dummy_exit() - device driver removal
> - *
> - * Varies depending on bus type of the device.
> - * As there is no device here, call remove directly.
> - */
> -static __exit void iio_dummy_exit(void)
> -{
> -	int i;
> +static struct iio_sw_device_type iio_dummy_device = {
> +	.name = "dummy",
> +	.owner = THIS_MODULE,
> +	.ops = &iio_dummy_device_ops,
> +};
>  
> -	for (i = 0; i < instances; i++)
> -		iio_dummy_remove(i);
> -	kfree(iio_dummy_devs);
> -}
> -module_exit(iio_dummy_exit);
> +module_iio_sw_device_driver(iio_dummy_device);
>  
>  MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
>  MODULE_DESCRIPTION("IIO dummy driver");
> 

