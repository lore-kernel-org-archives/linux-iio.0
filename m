Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45226 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdA1MPy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Jan 2017 07:15:54 -0500
Subject: Re: [PATCH -next] iio: common: ssp_sensors: accel: use
 devm_iio_device_register()
To: Wei Yongjun <weiyj.lk@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Julia Lawall <Julia.Lawall@lip6.fr>
References: <20170122163612.27084-1-weiyj.lk@gmail.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <80490140-794e-1c24-b180-80a872f10781@kernel.org>
Date: Sat, 28 Jan 2017 12:15:52 +0000
MIME-Version: 1.0
In-Reply-To: <20170122163612.27084-1-weiyj.lk@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/01/17 16:36, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Use devm_iio_device_register() for IIO subsystem device
> registration and delete the remove function since there
> is no need after this change.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/ssp_accel_sensor.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/accel/ssp_accel_sensor.c b/drivers/iio/accel/ssp_accel_sensor.c
> index 6b54008..dd6ece8 100644
> --- a/drivers/iio/accel/ssp_accel_sensor.c
> +++ b/drivers/iio/accel/ssp_accel_sensor.c
> @@ -136,7 +136,7 @@ static int ssp_accel_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -146,21 +146,11 @@ static int ssp_accel_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int ssp_accel_remove(struct platform_device *pdev)
> -{
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> -
> -	iio_device_unregister(indio_dev);
> -
> -	return 0;
> -}
> -
>  static struct platform_driver ssp_accel_driver = {
>  	.driver = {
>  		.name = SSP_ACCEL_NAME,
>  	},
>  	.probe = ssp_accel_probe,
> -	.remove =  ssp_accel_remove,
>  };
>  
>  module_platform_driver(ssp_accel_driver);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

