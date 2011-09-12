Return-Path: <manuel.stahl9cd33xy531iis.fraunhofer.de@bounce.antispameurope.com>
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] staging:iio: move id and device name setting to iio_device_allocate.
Date: Mon, 12 Sep 2011 10:27:23 +0200
Cc: linux-iio@vger.kernel.org
References: <4E6A2560.1050204@cam.ac.uk> <1315580167-26422-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1315580167-26422-1-git-send-email-jic23@cam.ac.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201109121027.23654.manuel.stahl@iis.fraunhofer.de>
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

the patch works for me, but I still have to search through all triggers and=
=20
try to match the names to find the trigger belonging to a device as the=20
trigger directories are enumerated differently.

Regards,
Manuel

Am Freitag, 9. September 2011, 16:56:07 schrieb Jonathan Cameron:
> The recent reorganization of the sysfs attribute registration had
> the side effect of moving iio_device_register after registration of
> triggers etc.  The side effect of this is that the id hadn't been
> allocated by the time of trigger registration. Thus all triggers
> based on device got the name <dev_name>-dev0 instead of <dev_name>-devN
> where N is the iio device id.
>=20
> This should also fix the lack of device name for some error messages
> that we have been seeing (and I'd been meaning to track down) as
> that has now moved earlier as well.
>=20
> Reported-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/industrialio-core.c |   25 +++++++++++++------------
>  1 files changed, 13 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/staging/iio/industrialio-core.c
> b/drivers/staging/iio/industrialio-core.c index fd4aada..8486914 100644
> --- a/drivers/staging/iio/industrialio-core.c
> +++ b/drivers/staging/iio/industrialio-core.c
> @@ -1033,6 +1033,15 @@ struct iio_dev *iio_allocate_device(int sizeof_pri=
v)
>  		device_initialize(&dev->dev);
>  		dev_set_drvdata(&dev->dev, (void *)dev);
>  		mutex_init(&dev->mlock);
> +
> +		dev->id =3D ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
> +		if (dev->id < 0) {
> +			/* cannot use a dev_err as the name isn't available */
> +			printk(KERN_ERR "Failed to get id\n");
> +			kfree(dev);
> +			return NULL;
> +		}
> +		dev_set_name(&dev->dev, "iio:device%d", dev->id);
>  	}
>=20
>  	return dev;
> @@ -1041,8 +1050,10 @@ EXPORT_SYMBOL(iio_allocate_device);
>=20
>  void iio_free_device(struct iio_dev *dev)
>  {
> -	if (dev)
> +	if (dev) {
> +		ida_simple_remove(&iio_ida, dev->id);
>  		kfree(dev);
> +	}
>  }
>  EXPORT_SYMBOL(iio_free_device);
>=20
> @@ -1100,14 +1111,6 @@ int iio_device_register(struct iio_dev *dev_info)
>  {
>  	int ret;
>=20
> -	dev_info->id =3D ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
> -	if (dev_info->id < 0) {
> -		ret =3D dev_info->id;
> -		dev_err(&dev_info->dev, "Failed to get id\n");
> -		goto error_ret;
> -	}
> -	dev_set_name(&dev_info->dev, "iio:device%d", dev_info->id);
> -
>  	/* configure elements for the chrdev */
>  	dev_info->dev.devt =3D MKDEV(MAJOR(iio_devt), dev_info->id);
>=20
> @@ -1115,7 +1118,7 @@ int iio_device_register(struct iio_dev *dev_info)
>  	if (ret) {
>  		dev_err(dev_info->dev.parent,
>  			"Failed to register sysfs interfaces\n");
> -		goto error_free_ida;
> +		goto error_ret;
>  	}
>  	ret =3D iio_device_register_eventset(dev_info);
>  	if (ret) {
> @@ -1142,8 +1145,6 @@ error_unreg_eventset:
>  	iio_device_unregister_eventset(dev_info);
>  error_free_sysfs:
>  	iio_device_unregister_sysfs(dev_info);
> -error_free_ida:
> -	ida_simple_remove(&iio_ida, dev_info->id);
>  error_ret:
>  	return ret;
>  }


=2D-=20
Gru=DF,
Manuel Stahl
