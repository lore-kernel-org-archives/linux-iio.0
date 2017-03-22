Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48637 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932205AbdCVUke (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Mar 2017 16:40:34 -0400
Subject: Re: [PATCH] staging: iio: adc: Replace mlock with driver private lock
To: Arushi Singhal <arushisinghal19971997@gmail.com>, lars@metafoo.de
References: <20170320141207.GA5908@arushi-HP-Pavilion-Notebook>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0e0fa0e5-2baf-61f0-dd86-a6362cf83f5e@kernel.org>
Date: Wed, 22 Mar 2017 20:40:29 +0000
MIME-Version: 1.0
In-Reply-To: <20170320141207.GA5908@arushi-HP-Pavilion-Notebook>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/03/17 14:12, Arushi Singhal wrote:
> The IIO subsystem is redefining iio_dev->mlock to be used by
> the IIO core only for protecting device operating mode changes.
> ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
> 
> In this driver, mlock was being used to protect hardware state
> changes.  Replace it with a lock in the devices global data.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
mutex_init?

This partly came from the fact Alison missed it in her example
patch (and I didn't notice!), but all mutexes need to be initialized
before use.  It's an interesting diversion to follow what that actually
does...  There is more to a mutex than you might expect!

Jonathan
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

