Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48656 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932205AbdCVUlx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Mar 2017 16:41:53 -0400
Subject: Re: [PATCH] staging: adis16203: Remove locking on raw reads of
 IIO_CHAN_INFO_CALIBBIAS
To: Gargi Sharma <gs051095@gmail.com>,
        outreachy-kernel@googlegroups.com
References: <1489998642-13796-1-git-send-email-gs051095@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5940916e-2c48-ec4c-8ed8-8475642582e9@kernel.org>
Date: Wed, 22 Mar 2017 20:41:50 +0000
MIME-Version: 1.0
In-Reply-To: <1489998642-13796-1-git-send-email-gs051095@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/03/17 08:30, Gargi Sharma wrote:
> adis16203_read_raw does not need lock for IIO_CHAN_INFO_CALIBBIAS
> since adis_read_reg_16 is already atomic and nothing else needs to be
> protected.
> 
> Signed-off-by: Gargi Sharma <gs051095@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.  Thanks,

Jonathan
> ---
>  drivers/staging/iio/accel/adis16203.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
> index 68189ad..14fe2d3 100644
> --- a/drivers/staging/iio/accel/adis16203.c
> +++ b/drivers/staging/iio/accel/adis16203.c
> @@ -203,17 +203,14 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		bits = 14;
> -		mutex_lock(&indio_dev->mlock);
>  		addr = adis16203_addresses[chan->scan_index];
>  		ret = adis_read_reg_16(st, addr, &val16);
>  		if (ret) {
> -			mutex_unlock(&indio_dev->mlock);
>  			return ret;
>  		}
>  		val16 &= (1 << bits) - 1;
>  		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
>  		*val = val16;
> -		mutex_unlock(&indio_dev->mlock);
>  		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
> 

