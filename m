Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:53408 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab2FOMfp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jun 2012 08:35:45 -0400
Message-ID: <4FDB2C1E.3080202@cam.ac.uk>
Date: Fri, 15 Jun 2012 13:35:42 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio: Remove superfluous flush_scheduled_work
References: <1339748968-4116-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1339748968-4116-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/15/2012 9:29 AM, Lars-Peter Clausen wrote:
> None of these drivers ever schedule any work, so there is no need to flush any
> scheduled work when the driver is removed.
>
Guessing these are left from pre threaded interrupt days...
Good spot.

> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/staging/iio/accel/adis16209_core.c |    2 --
>   drivers/staging/iio/accel/adis16220_core.c |    2 --
>   drivers/staging/iio/accel/adis16240_core.c |    2 --
>   drivers/staging/iio/gyro/adis16260_core.c  |    2 --
>   4 files changed, 8 deletions(-)
>
> diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
> index f6fd0d3..6fc426e 100644
> --- a/drivers/staging/iio/accel/adis16209_core.c
> +++ b/drivers/staging/iio/accel/adis16209_core.c
> @@ -606,8 +606,6 @@ static int adis16209_remove(struct spi_device *spi)
>   {
>   	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>
> -	flush_scheduled_work();
> -
>   	iio_device_unregister(indio_dev);
>   	adis16209_remove_trigger(indio_dev);
>   	iio_buffer_unregister(indio_dev);
> diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
> index 6a9ac89..af5c576 100644
> --- a/drivers/staging/iio/accel/adis16220_core.c
> +++ b/drivers/staging/iio/accel/adis16220_core.c
> @@ -694,8 +694,6 @@ static int adis16220_remove(struct spi_device *spi)
>   {
>   	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>
> -	flush_scheduled_work();
> -
>   	sysfs_remove_bin_file(&indio_dev->dev.kobj,&adc2_bin);
>   	sysfs_remove_bin_file(&indio_dev->dev.kobj,&adc1_bin);
>   	sysfs_remove_bin_file(&indio_dev->dev.kobj,&accel_bin);
> diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
> index 8b15eae..2f59f83 100644
> --- a/drivers/staging/iio/accel/adis16240_core.c
> +++ b/drivers/staging/iio/accel/adis16240_core.c
> @@ -641,8 +641,6 @@ static int adis16240_remove(struct spi_device *spi)
>
>   	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>
> -	flush_scheduled_work();
> -
>   	iio_device_unregister(indio_dev);
>   	adis16240_remove_trigger(indio_dev);
>   	iio_buffer_unregister(indio_dev);
> diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
> index ec765f9..fdb84cc 100644
> --- a/drivers/staging/iio/gyro/adis16260_core.c
> +++ b/drivers/staging/iio/gyro/adis16260_core.c
> @@ -728,8 +728,6 @@ static int adis16260_remove(struct spi_device *spi)
>   	if (ret)
>   		goto err_ret;
>
> -	flush_scheduled_work();
> -
>   	adis16260_remove_trigger(indio_dev);
>   	iio_buffer_unregister(indio_dev);
>   	adis16260_unconfigure_ring(indio_dev);

