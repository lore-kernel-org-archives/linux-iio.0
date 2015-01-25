Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50970 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbbAYWpq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 25 Jan 2015 17:45:46 -0500
Message-ID: <54C57217.4020809@kernel.org>
Date: Sun, 25 Jan 2015 22:45:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: as3935: Switch to PM ops
References: <1420987024-31189-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1420987024-31189-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/01/15 14:37, Lars-Peter Clausen wrote:
> Switch from the legacy suspend/resume callbacks to device pm ops.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play.

Thanks,
> ---
>  drivers/iio/proximity/as3935.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index 78244e6..3008b43 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -273,9 +273,9 @@ static void calibrate_as3935(struct as3935_state *st)
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> -static int as3935_suspend(struct spi_device *spi, pm_message_t msg)
> +static int as3935_suspend(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct as3935_state *st = iio_priv(indio_dev);
>  	int val, ret;
>  
> @@ -293,9 +293,9 @@ err_suspend:
>  	return ret;
>  }
>  
> -static int as3935_resume(struct spi_device *spi)
> +static int as3935_resume(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct as3935_state *st = iio_priv(indio_dev);
>  	int val, ret;
>  
> @@ -311,9 +311,12 @@ err_resume:
>  
>  	return ret;
>  }
> +
> +static SIMPLE_DEV_PM_OPS(as3935_pm_ops, as3935_suspend, as3935_resume);
> +#define AS3935_PM_OPS (&as3935_pm_ops)
> +
>  #else
> -#define as3935_suspend	NULL
> -#define as3935_resume	NULL
> +#define AS3935_PM_OPS NULL
>  #endif
>  
>  static int as3935_probe(struct spi_device *spi)
> @@ -441,12 +444,11 @@ static struct spi_driver as3935_driver = {
>  	.driver = {
>  		.name	= "as3935",
>  		.owner	= THIS_MODULE,
> +		.pm	= AS3935_PM_OPS,
>  	},
>  	.probe		= as3935_probe,
>  	.remove		= as3935_remove,
>  	.id_table	= as3935_id,
> -	.suspend	= as3935_suspend,
> -	.resume		= as3935_resume,
>  };
>  module_spi_driver(as3935_driver);
>  
> 

