Return-Path: <SRS0=5Ir3=2W=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH] staging: adis16060_core: Use private driver lock instead
 of mlock
To: simran singhal <singhalsimran0@gmail.com>
References: <20170312131052.GA21816@singhal-Inspiron-5558>
Cc: Michael.Hennerich@analog.com, jic23@kernel.org,
 Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler
 <pmeerw@pmeerw.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <14f72fd1-e1e8-133b-0ff8-a1096f0583d9@metafoo.de>
Date: Mon, 13 Mar 2017 13:05:59 +0100
MIME-Version: 1.0
In-Reply-To: <20170312131052.GA21816@singhal-Inspiron-5558>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 03/12/2017 02:10 PM, simran singhal wrote:
> The IIO subsystem is redefining iio_dev->mlock to be used by
> the IIO core only for protecting device operating mode changes.
> ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
> 
> In this driver, mlock was being used to protect hardware state
> changes.  Replace it with a lock in the devices global data.
> 
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
> ---
>  drivers/staging/iio/gyro/adis16060_core.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
> index c9d46e7..90a3a18 100644
> --- a/drivers/staging/iio/gyro/adis16060_core.c
> +++ b/drivers/staging/iio/gyro/adis16060_core.c
> @@ -29,11 +29,13 @@
>   * @us_r:		actual spi_device to read back data
>   * @buf:		transmit or receive buffer
>   * @buf_lock:		mutex to protect tx and rx
> + * @lock:		protect sensor state
>   **/
>  struct adis16060_state {
>  	struct spi_device		*us_w;
>  	struct spi_device		*us_r;
>  	struct mutex			buf_lock;
> +	struct mutex			lock;	 /* protect sensor state */

There should be no need to have two locks here. One should be enough. The
buf_lock protects both the adis16060_spi_write() and adis16060_spi_read()
functions. But both are always called in a pair. First write, then read. You
can refactor the code to have one single function
adis16060_spi_write_than_read() which is protected by the existing buf_lock.


>  
>  	u8 buf[3] ____cacheline_aligned;
>  };
> @@ -87,7 +89,7 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		/* Take the iio_dev status lock */
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&st->lock);
>  		ret = adis16060_spi_write(indio_dev, chan->address);
>  		if (ret < 0)
>  			goto out_unlock;
> @@ -96,7 +98,7 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			goto out_unlock;
>  
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&st->lock);
>  		*val = tval;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_OFFSET:
> @@ -112,7 +114,7 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  
>  out_unlock:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  	return ret;
>  }
>  
> 
