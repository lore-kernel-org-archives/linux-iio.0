Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:51230 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823Ab1IPPBH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 16 Sep 2011 11:01:07 -0400
Message-ID: <4E7366A7.5000700@cam.ac.uk>
Date: Fri, 16 Sep 2011 16:09:27 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: linux-iio@vger.kernel.org, Michael.Hennerich@analog.com,
	jonathan.kunkee@gmail.com
Subject: Re: [PATCH] staging:iio:Documentation Review simple dummy driver
References: <1316175268-6788-1-git-send-email-jic23@cam.ac.uk> <1316181840-9230-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <1316181840-9230-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/16/11 15:04, Manuel Stahl wrote:
> Hi Jonathon,
> 
> here are some enhancements from me. Of course you can merge the things you like with the original commit.
> Maybe we should call the driver "iio_reference", then it's clear what it's for.

Maybe, lets see where we end up after adding full functionality.
> 
> Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
> ---
>  drivers/staging/iio/iio_simple_dummy.c |   73 ++++++++++++++++++++++++++++---
>  1 files changed, 66 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
> index 0f22be7..674b585 100644
> --- a/drivers/staging/iio/iio_simple_dummy.c
> +++ b/drivers/staging/iio/iio_simple_dummy.c
> @@ -40,6 +40,13 @@ static const struct iio_dummy_accel_calibscale dummy_scales[] = {
>  
>  /**
>   * iio_dummy_state: device instance specific state.
> + * @dac_val:			cache for dac value
> + * @single_ended_adc_val:	cache for single ended adc value
> + * @differential_adc_val:	cache for differential adc value
> + * @accel_val:			cache for acceleration value
> + * @accel_calibbias:		cache for acceleration calibbias
> + * @accel_calibscale:		cache for acceleration calibscale
> + * @lock:			mutex to access this struct
>   */
Sure, there I was being lazy :) I'll drop those in.
>  struct iio_dummy_state {
>  	int dac_val;
> @@ -134,6 +141,17 @@ static struct iio_chan_spec iio_dummy_channels[] = {
>  		 */
>  		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
>  	},
> +	/*
> +	 * of course you can also use the IIO_CHAN and IIO_ST macros
> +	 */
No to this one, trying to kill off IIO_CHAN asap. It's a mess and has lead
to more than one bug.
> +#define IIO_DUMMY_ST	IIO_ST('s', 14, 16, 0)
> +
> +	IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, IIO_MOD_X, 0,
> +		0, 0, IIO_DUMMY_ST, 0),
> +	IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, IIO_MOD_Y, 0,
> +		0, 0, IIO_DUMMY_ST, 0),
> +	IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, IIO_MOD_Z, 0,
> +		0, 0, IIO_DUMMY_ST, 0),
>  };
>  
>  /**
> @@ -178,6 +196,10 @@ static int iio_dummy_read_raw(struct iio_dev *indio_dev,
>  			*val = st->accel_val;
>  			ret = IIO_VAL_INT;
>  			break;
> +		case IIO_GYRO:
> +			*val = -123; /* return some arbitrary number */
> +			ret = IIO_VAL_INT;
> +			break;
>  		default:
>  			break;
>  		}
> @@ -194,7 +216,7 @@ static int iio_dummy_read_raw(struct iio_dev *indio_dev,
>  		ret = IIO_VAL_INT_PLUS_MICRO;
>  		break;
>  	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
> -		/* all differential adc channels -> 0.000001344*/
> +		/* all differential adc channels -> 0.000001344 */
>  		*val = 0;
>  		*val2 = 1344;
>  		ret = IIO_VAL_INT_PLUS_NANO;
> @@ -281,8 +303,8 @@ static const struct iio_info iio_dummy_info = {
>   * iio_dummy_init_device: device instance specific init
>   * @indio_dev: the iio device structure
>   *
> - * Most drivers have one of these to set up default values
> - * etc.
> + * Most drivers have one of these to set up default values,
> + * reset the device, etc.
>   */
>  static int iio_dummy_init_device(struct iio_dev *indio_dev)
>  {
> @@ -298,6 +320,7 @@ static int iio_dummy_init_device(struct iio_dev *indio_dev)
>  
>  	return 0;
>  }
> +
>  /**
>   * iio_dummy_probe: device instance probe
>   * @index: an id number for this instance.
> @@ -335,13 +358,15 @@ static int __devinit iio_dummy_probe(int index)
>  	 * With hardware:
>  	 * Set the parent device.
>  	 * indio_dev->dev.parent = &spi->dev;
> -	 * indio_dev->dev.parent = &client->dev;
> +	 * or
> +	 * indio_dev->dev.parent = &i2c->dev;
Could do, though it doesn't line up with the i2c documentation
if we do that. Difficult balance to strike between making
ours obvious and keeping it coherent with others.

>  	 */
>  
>  	 /*
>  	 * Make the iio_dev struct available to remove function.
>  	 * Bus equivalents
> -	 * i2c_set_clientdata(client, indio_dev);
> +	 * i2c_set_clientdata(i2c, indio_dev);
> +	 * or
>  	 * spi_set_drvdata(spi, indio_dev);
>  	 */
>  	iio_dummy_devs[index] = indio_dev;
> @@ -368,7 +393,7 @@ static int __devinit iio_dummy_probe(int index)
>  	 */
>  	indio_dev->info = &iio_dummy_info;
>  
> -	/* Specify that device provides sysfs type interfaces */
> +	/* Specify that device provides sysfs type interfaces only */
Not true. This value is edited from various places by the time we have 
buffering etc.  Maybe should make it |= to avoid possible bugs from
ordering of initialization..
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	ret = iio_device_register(indio_dev);
> @@ -395,7 +420,8 @@ static int iio_dummy_remove(int index)
>  	/*
>  	 * Get a pointer to the device instance iio_dev structure
>  	 * from the bus subsystem. E.g.
> -	 * struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	 * struct iio_dev *indio_dev = i2c_get_clientdata(i2c);
> +	 * or
>  	 * struct iio_dev *indio_dev = spi_get_drvdata(spi);
>  	 */
>  	struct iio_dev *indio_dev = iio_dummy_devs[index];
> @@ -408,6 +434,39 @@ static int iio_dummy_remove(int index)
>  	return 0;
>  }
>  
> +/*********************************************************
> + * Example for I2C:
> +
> +static const struct i2c_device_id iio_dummy_id[] = {
> +	{ "dummy", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, iio_dummy_id);
I think I'd rather avoid this because we then overlap with the equivalent
i2c docs and stub driver. Documentation/i2c/writing-clients for
example.  
> +
> +static struct i2c_driver iio_dummy_driver = {
> +	.driver = {
> +		.owner  = THIS_MODULE,
> +		.name	= "iio_dummy",
> +	},
> +	.id_table	= iio_dummy_id,
> +	.probe		= iio_dummy_probe,
> +	.remove		= iio_dummy_remove,
> +};
> +
> +static int __init iio_dummy_init(void)
> +{
> +	return i2c_add_driver(&iio_dummy_driver);
> +}
> +module_init(iio_dummy_init);
> +
> +static void __exit iio_dummy_exit(void)
> +{
> +	i2c_del_driver(&iio_dummy_driver);
> +}
> +module_exit(iio_dummy_exit);
> + *********************************************************/
I'll pull the rest into the original patch.

Thanks,

Jonathan

