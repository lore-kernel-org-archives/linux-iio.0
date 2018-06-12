Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:8658 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752659AbeFLKBm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 12 Jun 2018 06:01:42 -0400
Date: Tue, 12 Jun 2018 11:01:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Karim Eshapa <karim.eshapa@gmail.com>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging:iio:accel:adis16240: sign extend function
 avoiding code  duplication
Message-ID: <20180612110114.00002303@huawei.com>
In-Reply-To: <20180612005748.3546-1-karim.eshapa@gmail.com>
References: <48143872d69d231273bd2c8ed835cbf0046a263d.camel@perches.com>
        <20180612005748.3546-1-karim.eshapa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 12 Jun 2018 02:57:48 +0200
Karim Eshapa <karim.eshapa@gmail.com> wrote:

> Use sign_extend32 kernel function instead of code duplication.
> Safe also for 16 bit.
> 
> Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>

Please resend as a fresh patch marked at V2 with a change log below the ---
so we can easily see what has changed.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/accel/adis16240.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
> index fff6d99089cc..24e525f1ef25 100644
> --- a/drivers/staging/iio/accel/adis16240.c
> +++ b/drivers/staging/iio/accel/adis16240.c
> @@ -250,7 +250,6 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct adis *st = iio_priv(indio_dev);
>  	int ret;
> -	int bits;
>  	u8 addr;
>  	s16 val16;
>  
> @@ -287,24 +286,18 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
>  		*val = 25000 / 244 - 0x133; /* 25 C = 0x133 */
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBBIAS:
> -		bits = 10;
>  		addr = adis16240_addresses[chan->scan_index][0];
>  		ret = adis_read_reg_16(st, addr, &val16);
>  		if (ret)
>  			return ret;
> -		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> -		*val = val16;
> +		*val = sign_extend32(val16, 9);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_PEAK:
> -		bits = 10;
>  		addr = adis16240_addresses[chan->scan_index][1];
>  		ret = adis_read_reg_16(st, addr, &val16);
>  		if (ret)
>  			return ret;
> -		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> -		*val = val16;
> +		*val = sign_extend32(val16, 9);
>  		return IIO_VAL_INT;
>  	}
>  	return -EINVAL;


