Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43841 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbdCYRrE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Mar 2017 13:47:04 -0400
Subject: Re: [PATCH v9] staging: iio: adis16060: Remove iio_dev mlock and
 refactor code
To: simran singhal <singhalsimran0@gmail.com>, lars@metafoo.de
References: <20170323092048.GA25470@singhal-Inspiron-5558>
Cc: Michael.Hennerich@analog.com, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0a2934e9-5dca-1c2b-125d-776e9dfcfccb@kernel.org>
Date: Sat, 25 Mar 2017 17:46:04 +0000
MIME-Version: 1.0
In-Reply-To: <20170323092048.GA25470@singhal-Inspiron-5558>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/03/17 09:20, simran singhal wrote:
> The IIO subsystem is redefining iio_dev->mlock to be used by
> the IIO core only for protecting device operating mode changes.
> ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
> 
> In this driver, mlock was being used to protect hardware state changes.
> 
> In the driver, buf_lock protects both the adis16060_spi_write() and
> adis16060_spi_read() functions and both are always called in pair.
> First write, then read. Refactor the code to have one single function
> adis16060_spi_write_then_read() protected by the buf_lock. This removes
> the need for additional locking via mlock, so this locking is removed.
> 
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
Unfortunately I've now pushed out v8 as togreg which is a non rebasing tree.
As such, could you post a separate patch, on top of that making the
than -> then change?

Thanks,

Jonathan
> ---
> 
>  v9:
>    -Change the name of function from adis16060_spi_write_than_read()
>     to adis16060_spi_write_then_read(). change "than" to "then" as
>     its time depended.
>    -Add mutex_unlock
As Alison keeps mentioning, ideal is to keep all previous change logs
here as it allows those who last looked at say v5 to know what changed
in between without reading a lot of threads!
>  
>  drivers/staging/iio/gyro/adis16060_core.c | 35 +++++++++----------------------
>  1 file changed, 10 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
> index c9d46e7..9675245 100644
> --- a/drivers/staging/iio/gyro/adis16060_core.c
> +++ b/drivers/staging/iio/gyro/adis16060_core.c
> @@ -40,25 +40,20 @@ struct adis16060_state {
>  
>  static struct iio_dev *adis16060_iio_dev;
>  
> -static int adis16060_spi_write(struct iio_dev *indio_dev, u8 val)
> +static int adis16060_spi_write_then_read(struct iio_dev *indio_dev,
> +					 u8 conf, u16 *val)
>  {
>  	int ret;
>  	struct adis16060_state *st = iio_priv(indio_dev);
>  
>  	mutex_lock(&st->buf_lock);
> -	st->buf[2] = val; /* The last 8 bits clocked in are latched */
> +	st->buf[2] = conf; /* The last 8 bits clocked in are latched */
>  	ret = spi_write(st->us_w, st->buf, 3);
> -	mutex_unlock(&st->buf_lock);
> -
> -	return ret;
> -}
> -
> -static int adis16060_spi_read(struct iio_dev *indio_dev, u16 *val)
> -{
> -	int ret;
> -	struct adis16060_state *st = iio_priv(indio_dev);
>  
> -	mutex_lock(&st->buf_lock);
> +	if (ret < 0) {
> +		mutex_unlock(&st->buf_lock);
> +		return ret;
> +	}
>  
>  	ret = spi_read(st->us_r, st->buf, 3);
>  
> @@ -86,17 +81,11 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		/* Take the iio_dev status lock */
> -		mutex_lock(&indio_dev->mlock);
> -		ret = adis16060_spi_write(indio_dev, chan->address);
> +		ret = adis16060_spi_write_then_read(indio_dev,
> +						    chan->address, &tval);
>  		if (ret < 0)
> -			goto out_unlock;
> +			return ret;
>  
> -		ret = adis16060_spi_read(indio_dev, &tval);
> -		if (ret < 0)
> -			goto out_unlock;
> -
> -		mutex_unlock(&indio_dev->mlock);
>  		*val = tval;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_OFFSET:
> @@ -110,10 +99,6 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
>  	}
>  
>  	return -EINVAL;
> -
> -out_unlock:
> -	mutex_unlock(&indio_dev->mlock);
> -	return ret;
>  }
>  
>  static const struct iio_info adis16060_info = {
> 

