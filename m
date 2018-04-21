Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753148AbeDUQXv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Apr 2018 12:23:51 -0400
Date: Sat, 21 Apr 2018 17:23:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 05/13] staging: iio: tsl2x7x: remove unnecessary chip
 status checks in suspend/resume
Message-ID: <20180421172345.4c0e17a6@archlinux>
In-Reply-To: <20180421004153.19073-6-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
        <20180421004153.19073-6-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 20 Apr 2018 20:41:45 -0400
Brian Masney <masneyb@onstation.org> wrote:

> tsl2x7x_suspend() and tsl2x7x_resume() both check to see what the
> current chip status is. These checks are not necessary so this patch
> removes those checks.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
This description could have been clearer... The key point is we
can always know what state we are in when we hit these functions anyway
(I think).

Anyhow applied as is to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index f37fc74b8fbc..8d8af0cf9768 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1682,27 +1682,15 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  static int tsl2x7x_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> -	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	int ret = 0;
> -
> -	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_WORKING) {
> -		ret = tsl2x7x_chip_off(indio_dev);
> -		chip->tsl2x7x_chip_status = TSL2X7X_CHIP_SUSPENDED;
> -	}
>  
> -	return ret;
> +	return tsl2x7x_chip_off(indio_dev);
>  }
>  
>  static int tsl2x7x_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> -	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	int ret = 0;
>  
> -	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_SUSPENDED)
> -		ret = tsl2x7x_chip_on(indio_dev);
> -
> -	return ret;
> +	return tsl2x7x_chip_on(indio_dev);
>  }
>  
>  static int tsl2x7x_remove(struct i2c_client *client)

