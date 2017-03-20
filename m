Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:40197 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754260AbdCTQmd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Mar 2017 12:42:33 -0400
Subject: Re: [RESEND PATCH] staging: ad7606: Replace mlock with driver private
 lock
To: Arushi Singhal <arushisinghal19971997@gmail.com>
References: <20170320152247.GA6760@arushi-HP-Pavilion-Notebook>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <6d979fef-d5ec-d84d-f6c6-c8fc2d120693@metafoo.de>
Date: Mon, 20 Mar 2017 17:41:58 +0100
MIME-Version: 1.0
In-Reply-To: <20170320152247.GA6760@arushi-HP-Pavilion-Notebook>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/20/2017 04:22 PM, Arushi Singhal wrote:
> The IIO subsystem is redefining iio_dev->mlock to be used by
> the IIO core only for protecting device operating mode changes.
> ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
> 
> In this driver, mlock was being used to protect hardware state
> changes.  Replace it with a lock in the devices global data.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>

Hi,

Looks good, but mutex_init() is missing.

- Lars

> ---
>  drivers/staging/iio/adc/ad7606.c | 8 ++++----
>  drivers/staging/iio/adc/ad7606.h | 2 ++
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
> index 9dbfa64b1e53..9f529b34e018 100644
> --- a/drivers/staging/iio/adc/ad7606.c
> +++ b/drivers/staging/iio/adc/ad7606.c
> @@ -208,7 +208,7 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
>  		ret = -EINVAL;
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&st->lock);
>  		for (i = 0; i < ARRAY_SIZE(scale_avail); i++)
>  			if (val2 == scale_avail[i][1]) {
>  				gpiod_set_value(st->gpio_range, i);
> @@ -217,7 +217,7 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
>  				ret = 0;
>  				break;
>  			}
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&st->lock);
>  
>  		return ret;
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> @@ -231,11 +231,11 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
>  		values[1] = (ret >> 1) & 1;
>  		values[2] = (ret >> 2) & 1;
>  
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&st->lock);
>  		gpiod_set_array_value(ARRAY_SIZE(values), st->gpio_os->desc,
>  				      values);
>  		st->oversampling = val;
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&st->lock);
>  
>  		return 0;
>  	default:
> diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
> index 746f9553d2ba..5d59bdd78727 100644
> --- a/drivers/staging/iio/adc/ad7606.h
> +++ b/drivers/staging/iio/adc/ad7606.h
> @@ -14,6 +14,7 @@
>   * @name:		identification string for chip
>   * @channels:		channel specification
>   * @num_channels:	number of channels
> + * @lock		protect sensor state
>   */
>  
>  struct ad7606_chip_info {
> @@ -37,6 +38,7 @@ struct ad7606_state {
>  	bool				done;
>  	void __iomem			*base_address;
>  
> +	struct mutex			lock; /* protect sensor state */
>  	struct gpio_desc		*gpio_convst;
>  	struct gpio_desc		*gpio_reset;
>  	struct gpio_desc		*gpio_range;
> 

