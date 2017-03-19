Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48567 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751478AbdCSLDN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2017 07:03:13 -0400
Subject: Re: [PATCH] staging: iio: adis16209: Remove mutex_lock() and
 mutex_unlock() calls
To: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>,
        lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
References: <1489597214-24564-1-git-send-email-narcisaanamaria12@gmail.com>
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0ce4aae0-da57-d7fd-5eb2-d98d4a4a964e@kernel.org>
Date: Sun, 19 Mar 2017 11:02:28 +0000
MIME-Version: 1.0
In-Reply-To: <1489597214-24564-1-git-send-email-narcisaanamaria12@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/03/17 17:00, Narcisa Ana Maria Vasile wrote:
> The function adis16209_read_raw() is safe to be run in parallel.
> The call to adis_read_reg_16() is safe since adis_read_reg() uses the
> txrx_lock from struct adis to protect simultaneous changes.
> 
> Remove mutex.h inclusion since it is no longer needed.
> 
> Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing.  Thanks,

Jonathan
> ---
>  drivers/staging/iio/accel/adis16209.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index 8ff537f..f8c1fb0 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -7,7 +7,6 @@
>   */
>  
>  #include <linux/delay.h>
> -#include <linux/mutex.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/spi/spi.h>
> @@ -252,17 +251,14 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> -		mutex_lock(&indio_dev->mlock);
>  		addr = adis16209_addresses[chan->scan_index][0];
>  		ret = adis_read_reg_16(st, addr, &val16);
>  		if (ret) {
> -			mutex_unlock(&indio_dev->mlock);
>  			return ret;
>  		}
>  		val16 &= (1 << bits) - 1;
>  		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
>  		*val = val16;
> -		mutex_unlock(&indio_dev->mlock);
>  		return IIO_VAL_INT;
>  	}
>  	return -EINVAL;
> 

