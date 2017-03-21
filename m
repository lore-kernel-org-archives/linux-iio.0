Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40846 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933263AbdCUTlE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 15:41:04 -0400
Subject: Re: [PATCH v7] staging: adis16060_core: Replace mlock with buf_lock
 and refactor code
To: simran singhal <singhalsimran0@gmail.com>, lars@metafoo.de
References: <20170320125320.GA22516@singhal-Inspiron-5558>
Cc: Michael.Hennerich@analog.com, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9977ffe2-d261-e075-b3ca-9d465ea08f07@kernel.org>
Date: Tue, 21 Mar 2017 19:40:29 +0000
MIME-Version: 1.0
In-Reply-To: <20170320125320.GA22516@singhal-Inspiron-5558>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/03/17 12:53, simran singhal wrote:
> The IIO subsystem is redefining iio_dev->mlock to be used by
> the IIO core only for protecting device operating mode changes.
> ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
> 
> In this driver, mlock was being used to protect hardware state
> changes. Replace it with buf_lock in the devices global data.
> 
> As buf_lock protects both the adis16060_spi_write() and
> adis16060_spi_read() functions and both are always called in
> pair. First write, then read. Thus, refactor the code to have
> one single function adis16060_spi_write_than_read() which is
> protected by the existing buf_lock.
> 
> Removed nested locks as the function adis16060_read_raw call
> a lock on &st->buf_lock and then calls the function
> adis16060_spi_write which again tries to get hold
> of the same lock.
> 
> The locks in adis16060_read_raw are dropped and now have a
> single safe function adis16060_spi_write_than_read
> with the locks inside it being called.
> 
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
So close!  If part of the exercise here wasn't learning how
to get things near perfect, I'd probably have picked this up
and fixed it (whilst moaning extensively :)  Not this time
though: roll on v8.

Anyhow, see inline.  Always worth checking the patch before
emailing for anything that has snuck in and shouldn't be there.

I always find git gui particularly useful for seeing this stuff
as well.

The actual chance is correct and the patch well presented.

Jonathan
p.s. I'd probably have picked it up anyway, but there is
always a slight pause after one sends a pull request as
I will want to fast forward my tree if / when Greg pulls.
> ---
> 
>  v7:
>    -Change subject
>    -Remove lock from read_raw instead of from 
>     function adis16060_spi_write_than_read().
>  
>  drivers/staging/iio/gyro/adis16060_core.c | 38 +++++++++----------------------
>  1 file changed, 11 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
> index c9d46e7..193587c 100644
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
> @@ -69,8 +62,8 @@ static int adis16060_spi_read(struct iio_dev *indio_dev, u16 *val)
>  	 */
>  	if (!ret)
>  		*val = ((st->buf[0] & 0x3) << 12) |
> -			(st->buf[1] << 4) |
> -			((st->buf[2] >> 4) & 0xF);
> +			 (st->buf[1] << 4) |
> +			 ((st->buf[2] >> 4) & 0xF);
Why the above change? Not related to everything else in the patch
(looks like an editor thinking it knows better on alignment to me!)
>  	mutex_unlock(&st->buf_lock);
>  
>  	return ret;
> @@ -83,20 +76,15 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
>  {
>  	u16 tval = 0;
>  	int ret;
> +	struct adis16060_state *st = iio_priv(indio_dev);
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
> @@ -110,10 +98,6 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
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

