Return-Path: <SRS0=Wx2m=2V=gmail.com=amsfield22@kernel.org>
Date: Sun, 12 Mar 2017 11:48:42 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: sayli karnik <karniksayli1995@gmail.com>
Cc: outreachy-kernel@googlegroups.com, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: iio: ad9834: Use private
 driver lock instead of mlock
Message-ID: <20170312184841.GA8713@d830.WORKGROUP>
References: <20170312115013.GA31878@sayli-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170312115013.GA31878@sayli-HP-15-Notebook-PC>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Mar 12, 2017 at 05:21:25PM +0530, sayli karnik wrote:
> iio_dev->mlock should be used by the IIO core only for protecting
> device operating mode changes. ie. Changes between INDIO_DIRECT_MODE,
> INDIO_BUFFER_* modes.
> Replace mlock with a lock in the device's global data to protect hardware
> state changes.

Hi Sayli,
Thanks for the patch!  Find one fix-up and one opportunity for
a follow on patch embedded below.
alisons

> 
> Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9834.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index f92ff7f..4259474 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -63,6 +63,7 @@
>   * @msg:		default spi message
>   * @freq_xfer:		tuning word spi transfer
>   * @freq_msg:		tuning word spi message
> + * @lock:		protect sensor state
>   * @data:		spi transmit buffer
>   * @freq_data:		tuning word spi transmit buffer
>   */
> @@ -77,6 +78,7 @@ struct ad9834_state {
>  	struct spi_message		msg;
>  	struct spi_transfer		freq_xfer[2];
>  	struct spi_message		freq_msg;
> +	struct mutex			lock;	/* protect sensor state */
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
> @@ -149,7 +151,7 @@ static ssize_t ad9834_write(struct device *dev,
>  	if (ret)
>  		goto error_ret;

Not related to your patch...the above goto error_ret seems excessived.
When you look down at error_ret, it's not doing any clean up. So,
perhaps we can just return right here and get rid of the goto & label?

>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	switch ((u32)this_attr->address) {
>  	case AD9834_REG_FREQ0:
>  	case AD9834_REG_FREQ1:
> @@ -207,7 +209,7 @@ static ssize_t ad9834_write(struct device *dev,
>  	default:
>  		ret = -ENODEV;
>  	}
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  error_ret:
>  	return ret ? ret : len;
> @@ -224,7 +226,7 @@ static ssize_t ad9834_store_wavetype(struct device *dev,
>  	int ret = 0;
>  	bool is_ad9833_7 = (st->devid == ID_AD9833) || (st->devid == ID_AD9837);
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  
>  	switch ((u32)this_attr->address) {
>  	case 0:
> @@ -267,7 +269,7 @@ static ssize_t ad9834_store_wavetype(struct device *dev,
>  		st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
>  		ret = spi_sync(st->spi, &st->msg);
>  	}
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);

Needs to be mutex_unlock()

>  
>  	return ret ? ret : len;
>  }
> -- 
> 2.7.4
> 
> -- 
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170312115013.GA31878%40sayli-HP-15-Notebook-PC.
> For more options, visit https://groups.google.com/d/optout.
