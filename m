Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:55713 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbdE1JrM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 May 2017 05:47:12 -0400
Subject: Re: [PATCH] staging: iio: ad7152: Fix deadlock in
 ad7152_write_raw_samp_freq()
To: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1495839184-28468-1-git-send-email-khoroshilov@ispras.ru>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <38c5952c-8c92-9d97-73cd-06fd0d74aaf3@metafoo.de>
Date: Sun, 28 May 2017 11:47:04 +0200
MIME-Version: 1.0
In-Reply-To: <1495839184-28468-1-git-send-email-khoroshilov@ispras.ru>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/27/2017 12:53 AM, Alexey Khoroshilov wrote:
> ad7152_write_raw_samp_freq() is called by ad7152_write_raw() with
> chip->state_lock held. So, there is unavoidable deadlock when
> ad7152_write_raw_samp_freq() locks the mutex itself.
> 
> The patch removes unneeded locking.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Looks good, thanks.

Fixes: 6572389bcc11 ("staging: iio: cdc: ad7152: Implement
IIO_CHAN_INFO_SAMP_FREQ attribute")
Acked-by: Lars-Peter Clausen <lars@metafoo.de>


> ---
>  drivers/staging/iio/cdc/ad7152.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
> index dc6ecd824365..ff10d1f0a7e4 100644
> --- a/drivers/staging/iio/cdc/ad7152.c
> +++ b/drivers/staging/iio/cdc/ad7152.c
> @@ -231,16 +231,12 @@ static int ad7152_write_raw_samp_freq(struct device *dev, int val)
>  	if (i >= ARRAY_SIZE(ad7152_filter_rate_table))
>  		i = ARRAY_SIZE(ad7152_filter_rate_table) - 1;
>  
> -	mutex_lock(&chip->state_lock);
>  	ret = i2c_smbus_write_byte_data(chip->client,
>  					AD7152_REG_CFG2, AD7152_CFG2_OSR(i));
> -	if (ret < 0) {
> -		mutex_unlock(&chip->state_lock);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	chip->filter_rate_setup = i;
> -	mutex_unlock(&chip->state_lock);
>  
>  	return ret;
>  }
> 

