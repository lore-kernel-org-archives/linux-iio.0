Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48527 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753737AbdCVU1Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Mar 2017 16:27:24 -0400
Subject: Re: [PATCH v2] staging: iio: meter: ade7758_core: Replace mlock with
 driver's private lock
To: sayli karnik <karniksayli1995@gmail.com>,
        outreachy-kernel@googlegroups.com
References: <20170321161535.GA11483@sayli-HP-15-Notebook-PC>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0fceb066-fab6-2376-017f-e3cd77ba2898@kernel.org>
Date: Wed, 22 Mar 2017 20:27:06 +0000
MIME-Version: 1.0
In-Reply-To: <20170321161535.GA11483@sayli-HP-15-Notebook-PC>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/03/17 16:15, sayli karnik wrote:
> iio_dev->mlock should be used by the IIO core only for protecting
> device operating mode changes. ie. Changes between INDIO_DIRECT_MODE,
> INDIO_BUFFER_* modes.
> Replace mlock with a lock in the device's global data to protect
> hardware state changes. Declare a new lock to avoid deadlocks due to
> nested mutex locks.
> 
> Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
Talk me through the logic of which lock you have used where...

> ---
> Changes in v2:
> Declared a new lock for raw reads/writes
> 
>  drivers/staging/iio/meter/ade7758.h      |  4 +++-
>  drivers/staging/iio/meter/ade7758_core.c | 12 +++++++-----
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7758.h b/drivers/staging/iio/meter/ade7758.h
> index 6ae78d8..e45887e 100644
> --- a/drivers/staging/iio/meter/ade7758.h
> +++ b/drivers/staging/iio/meter/ade7758.h
> @@ -112,13 +112,15 @@
>   * @tx:			transmit buffer
>   * @rx:			receive buffer
>   * @buf_lock:		mutex to protect tx and rx
> + * @lock:		mutex to protect raw reads and writes
>   **/
>  struct ade7758_state {
>  	struct spi_device	*us;
>  	struct iio_trigger	*trig;
>  	u8			*tx;
>  	u8			*rx;
> -	struct mutex		buf_lock;
> +	struct mutex		buf_lock; /* protect buffer reads/writes */
> +	struct mutex		lock;	/* protect raw reads/writes */
>  	struct spi_transfer	ring_xfer[4];
>  	struct spi_message	ring_msg;
>  	/*
> diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
> index 99c89e6..0996d74 100644
> --- a/drivers/staging/iio/meter/ade7758_core.c
> +++ b/drivers/staging/iio/meter/ade7758_core.c
> @@ -522,13 +522,14 @@ static int ade7758_read_raw(struct iio_dev *indio_dev,
>  			    int *val2,
>  			    long mask)
>  {
> +	struct ade7758_state *st = iio_priv(indio_dev);
>  	int ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&st->lock);
>  		ret = ade7758_read_samp_freq(&indio_dev->dev, val);
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&st->lock);
>  		return ret;
>  	default:
>  		return -EINVAL;
> @@ -541,15 +542,16 @@ static int ade7758_write_raw(struct iio_dev *indio_dev,
>  			     struct iio_chan_spec const *chan,
>  			     int val, int val2, long mask)
>  {
> +	struct ade7758_state *st = iio_priv(indio_dev);
>  	int ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		if (val2)
>  			return -EINVAL;
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&st->buf_lock);
Why buf_lock here?
>  		ret = ade7758_write_samp_freq(&indio_dev->dev, val);
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&st->buf_lock);
>  		return ret;
>  	default:
>  		return -EINVAL;
> @@ -855,7 +857,7 @@ static int ade7758_probe(struct spi_device *spi)
>  	}
>  	st->us = spi;
>  	mutex_init(&st->buf_lock);
> -
> +	mutex_init(&st->lock);
>  	indio_dev->name = spi->dev.driver->name;
>  	indio_dev->dev.parent = &spi->dev;
>  	indio_dev->info = &ade7758_info;
> 

