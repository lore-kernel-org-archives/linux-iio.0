Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48218 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbdCSKTo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2017 06:19:44 -0400
Subject: Re: [PATCH v3] staging: iio: accel: adis16201: remove iio_dev mlock
To: Aishwarya Pant <aishpant@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>
References: <20170317214356.GA8369@aishwarya>
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c4f803ee-8a6a-520e-2be3-bb68a57a8303@kernel.org>
Date: Sun, 19 Mar 2017 10:19:42 +0000
MIME-Version: 1.0
In-Reply-To: <20170317214356.GA8369@aishwarya>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/03/17 21:43, Aishwarya Pant wrote:
> In the driver adis16201 read raw does not require an iio_dev->mlock for
> reads. It can run concurrently as adis_read_reg_16() is protected by a
> transaction lock.
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
Great, one suggestion for a follow up patch below.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> 
> ---
> Changes in v3:
> 	-- Fix change log format
> 	-- Send patch to linuc-iio
> Changes in v2:
> 	-- Remove read lock
> 
>  drivers/staging/iio/accel/adis16201.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index d6c8658..fd2baf2 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -223,17 +223,13 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> -		mutex_lock(&indio_dev->mlock);
>  		addr = adis16201_addresses[chan->scan_index];
>  		ret = adis_read_reg_16(st, addr, &val16);
Not a lot of point in having the local variable addr given it's
only used here.  Perhaps you could follow up with a patch getting
rid of it?
> -		if (ret) {
> -			mutex_unlock(&indio_dev->mlock);
> +		if (ret)
>  			return ret;
> -		}
>  		val16 &= (1 << bits) - 1;
>  		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
>  		*val = val16;
> -		mutex_unlock(&indio_dev->mlock);
>  		return IIO_VAL_INT;
>  	}
>  	return -EINVAL;
> 

