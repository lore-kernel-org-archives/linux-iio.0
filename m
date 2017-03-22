Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48102 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935003AbdCVTWX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Mar 2017 15:22:23 -0400
Subject: Re: [PATCH v8] staging: adis16060: Remove iio_dev mlock and refactor
 code
To: simran singhal <singhalsimran0@gmail.com>, lars@metafoo.de
References: <20170322162042.GA7955@singhal-Inspiron-5558>
Cc: Michael.Hennerich@analog.com, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <fd0eaa12-4680-a5c6-cb56-b5efe26c28dd@kernel.org>
Date: Wed, 22 Mar 2017 19:22:20 +0000
MIME-Version: 1.0
In-Reply-To: <20170322162042.GA7955@singhal-Inspiron-5558>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/03/17 16:20, simran singhal wrote:
> The IIO subsystem is redefining iio_dev->mlock to be used by
> the IIO core only for protecting device operating mode changes.
> ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
> 
> In this driver, mlock was being used to protect hardware state changes.
> 
> In the driver, buf_lock protects both the adis16060_spi_write() and
> adis16060_spi_read() functions and both are always called in
> pair. First write, then read. Refactor the code to have
> one single function adis16060_spi_write_than_read() and remove
> the use of mlock as adis16060_read_raw() does not require an
> iio_dev->mlock for reads.
I'll slightly modify this description.  The key thing is
that after the above change to have a unified read then write
there is no longer any need for mlock to protect these
read, update, write cycles.
> 
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

I slightly modified the title as well. It's useful to be a little
more specific than staging, so I added iio: after that.

Thanks,

Jonathan
> ---
> 
>  v8:
>    -change subject
>    -change commit message
>  v7:
>    -Change subject
>    -Remove lock from read_raw instead from
>     function adis16060_spi_write_than_read().
>  v6:
>    -Change commit message
>    -Remove nested lock
>  v5:
>    -Rename val in adis16060_spi_write_than_read() to conf.
>    -Rename val2 in adis16060_spi_write_than_read() to val.
>    -Corrected Checkpatch issues.
>    -Removed goto from adis16060_read_raw().
>  v4:
>    -Refactored code
>    -change commit subject
>    -change commit message
>  v3:
>    -Removed new lock to reuse the existing lock
>  v2:
>    -Fixed compilation error
> 
>  drivers/staging/iio/gyro/adis16060_core.c | 33 ++++++++-----------------------
>  1 file changed, 8 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
> index c9d46e7..e96fce5 100644
> --- a/drivers/staging/iio/gyro/adis16060_core.c
> +++ b/drivers/staging/iio/gyro/adis16060_core.c
> @@ -40,25 +40,18 @@ struct adis16060_state {
>  
>  static struct iio_dev *adis16060_iio_dev;
>  
> -static int adis16060_spi_write(struct iio_dev *indio_dev, u8 val)
> +static int adis16060_spi_write_than_read(struct iio_dev *indio_dev,
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
> +	if (ret < 0)
> +		return ret;
>  
>  	ret = spi_read(st->us_r, st->buf, 3);
>  
> @@ -86,17 +79,11 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		/* Take the iio_dev status lock */
> -		mutex_lock(&indio_dev->mlock);
> -		ret = adis16060_spi_write(indio_dev, chan->address);
> +		ret = adis16060_spi_write_than_read(indio_dev,
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
> @@ -110,10 +97,6 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
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

