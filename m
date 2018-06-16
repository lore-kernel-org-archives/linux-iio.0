Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752587AbeFPSF1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Jun 2018 14:05:27 -0400
Date: Sat, 16 Jun 2018 19:05:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Karim Eshapa <karim.eshapa@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging:iio:accel:adis16203: sign extend function
 rather code duplication
Message-ID: <20180616190520.7996a010@archlinux>
In-Reply-To: <20180612164838.22961-1-karim.eshapa@gmail.com>
References: <20180612164838.22961-1-karim.eshapa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 12 Jun 2018 18:48:38 +0200
Karim Eshapa <karim.eshapa@gmail.com> wrote:

> Use sign_extend32 kernel function instead of code duplication.
> This function is also safe for 16 bits.
> 
> Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/accel/adis16203.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
> index b3e4571340ab..5cc96c8086b5 100644
> --- a/drivers/staging/iio/accel/adis16203.c
> +++ b/drivers/staging/iio/accel/adis16203.c
> @@ -168,7 +168,6 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct adis *st = iio_priv(indio_dev);
>  	int ret;
> -	int bits;
>  	u8 addr;
>  	s16 val16;
>  
> @@ -202,14 +201,11 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
>  		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBBIAS:
> -		bits = 14;
>  		addr = adis16203_addresses[chan->scan_index];
>  		ret = adis_read_reg_16(st, addr, &val16);
>  		if (ret)
>  			return ret;
> -		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> -		*val = val16;
> +		*val = sign_extend32(val16, 13);
>  		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;

