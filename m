Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52118 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343AbbITTSg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Sep 2015 15:18:36 -0400
Subject: Re: [PATCH] iio: gyro: ssp_gyro_sensor: Use devm_iio_device_register
To: Vaishali Thakkar <vthakkar1994@gmail.com>
References: <20150914160849.GA21748@localhost>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Karol Wrona <k.wrona@samsung.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55FF068A.30302@kernel.org>
Date: Sun, 20 Sep 2015 20:18:34 +0100
MIME-Version: 1.0
In-Reply-To: <20150914160849.GA21748@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/09/15 17:08, Vaishali Thakkar wrote:
> Use resourced managed function devm_iio_device_register to
> make error path simpler. To be compatible with the change,
> the remove function is removed as it is now redundant.
> 
> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
This patch is reasonable, but makes me wonder if there is an issue
in the remove path for this driver.  It relies on the ssp_sensors common
module.  That in ssp_spi.c uses the fact ssp_register_consumer
has saved the struct iio_dev into a local array in the core driver.
I think this means that a remove of this function will leave a possible
null pointer de reference.

Now I suspect that case doesn't actually occur because the relevant
device elements are disabled whenever this module is removed.  Having
said that we might expect an ssp_unregister_consumer function that
sets the relevant pointer back to null on removal so as to avoid
any possible race conditions around driver removal / reprobing.
A spot of defensive programming rather than necessarily a bug to be
fixed!

One little process thing. This driver was written by Karol so patches
should probably always cc Karol as well as the more general
maintainer / reviewers for IIO.  Added cc.

Jonathan
> ---
>  drivers/iio/gyro/ssp_gyro_sensor.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/gyro/ssp_gyro_sensor.c b/drivers/iio/gyro/ssp_gyro_sensor.c
> index 0a8afdd..ac88de7 100644
> --- a/drivers/iio/gyro/ssp_gyro_sensor.c
> +++ b/drivers/iio/gyro/ssp_gyro_sensor.c
> @@ -134,7 +134,7 @@ static int ssp_gyro_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -144,21 +144,11 @@ static int ssp_gyro_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int ssp_gyro_remove(struct platform_device *pdev)
> -{
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> -
> -	iio_device_unregister(indio_dev);
> -
> -	return 0;
> -}
> -
>  static struct platform_driver ssp_gyro_driver = {
>  	.driver = {
>  		.name = SSP_GYROSCOPE_NAME,
>  	},
>  	.probe = ssp_gyro_probe,
> -	.remove = ssp_gyro_remove,
>  };
>  
>  module_platform_driver(ssp_gyro_driver);
> 

