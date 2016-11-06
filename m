Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55639 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751852AbcKFMFO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2016 07:05:14 -0500
Subject: Re: [PATCH 8/9] staging: iio: tsl2583: check if chip is suspended in
 in_illuminance_calibrate_store
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478177780-28699-1-git-send-email-masneyb@onstation.org>
 <1478177780-28699-9-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ba0f714d-a4ab-cff7-ac6e-c0b6ed42968d@kernel.org>
Date: Sun, 6 Nov 2016 12:04:49 +0000
MIME-Version: 1.0
In-Reply-To: <1478177780-28699-9-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/11/16 12:56, Brian Masney wrote:
> in_illuminance_calibrate_store() did not check to see if the chip is
> suspended. This patch adds the proper check. The return value from
> taos_als_calibrate() was also not checked in this function, so the
> proper check was also added while changes are being made here.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
This one is fine, I'll pick up after patch 7 stuff is sorted.

Jonathan
> ---
>  drivers/staging/iio/light/tsl2583.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 1ff90b3..8c8361d 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -473,16 +473,27 @@ static ssize_t in_illuminance_calibrate_store(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct tsl2583_chip *chip = iio_priv(indio_dev);
> -	int value;
> +	int value, ret;
>  
>  	if (kstrtoint(buf, 0, &value) || value != 1)
>  		return -EINVAL;
>  
>  	mutex_lock(&chip->als_mutex);
> -	taos_als_calibrate(indio_dev);
> +
> +	if (chip->suspended) {
> +		ret = -EBUSY;
> +		goto done;
> +	}
> +
> +	ret = taos_als_calibrate(indio_dev);
> +	if (ret < 0)
> +		goto done;
> +
> +	ret = len;
> +done:
>  	mutex_unlock(&chip->als_mutex);
>  
> -	return len;
> +	return ret;
>  }
>  
>  static ssize_t in_illuminance_lux_table_show(struct device *dev,
> 

