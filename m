Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750784AbdKSPf3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Nov 2017 10:35:29 -0500
Date: Sun, 19 Nov 2017 15:35:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] staging: iio: ad7152: Improve unlocking of a mutex in
 ad7152_start_calib()
Message-ID: <20171119153524.0a88acd9@archlinux>
In-Reply-To: <eef53bde-ab45-6e5c-8e0d-bd9cf7ebc431@users.sourceforge.net>
References: <eef53bde-ab45-6e5c-8e0d-bd9cf7ebc431@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 3 Nov 2017 09:09:21 +0100
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 3 Nov 2017 09:00:25 +0100
> 
> * Add a jump target so that a call of the function "mutex_unlock" is stored
>   only twice in this function implementation.
> 
> * Replace two calls by goto statements.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
A reasonable tidy up that slightly improves the code. Just makes
it past past the point where the benefit justifies the code churn.

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/cdc/ad7152.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
> index 61377ca444de..59d1b35f6a4e 100644
> --- a/drivers/staging/iio/cdc/ad7152.c
> +++ b/drivers/staging/iio/cdc/ad7152.c
> @@ -118,22 +118,23 @@ static inline ssize_t ad7152_start_calib(struct device *dev,
>  
>  	mutex_lock(&chip->state_lock);
>  	ret = i2c_smbus_write_byte_data(chip->client, AD7152_REG_CFG, regval);
> -	if (ret < 0) {
> -		mutex_unlock(&chip->state_lock);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		goto unlock;
>  
>  	do {
>  		mdelay(20);
>  		ret = i2c_smbus_read_byte_data(chip->client, AD7152_REG_CFG);
> -		if (ret < 0) {
> -			mutex_unlock(&chip->state_lock);
> -			return ret;
> -		}
> +		if (ret < 0)
> +			goto unlock;
> +
>  	} while ((ret == regval) && timeout--);
>  
>  	mutex_unlock(&chip->state_lock);
>  	return len;
> +
> +unlock:
> +	mutex_unlock(&chip->state_lock);
> +	return ret;
>  }
>  
>  static ssize_t ad7152_start_offset_calib(struct device *dev,

