Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:32946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751706AbeCRIdU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Mar 2018 04:33:20 -0400
Date: Sun, 18 Mar 2018 08:33:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        daniel.baluta@gmail.com, 21cnbao@gmail.com
Subject: Re: [PATCH v2 6/9] Staging: iio: accel: adis16201: Use
 sign_extend32 function
Message-ID: <20180318083314.3b444790@archlinux>
In-Reply-To: <1521230786-18155-7-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
        <1521230786-18155-7-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 17 Mar 2018 01:36:23 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Use sign_extned32() for 32 bit sign extending rather than hard coding.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>

Great, applied.

Thanks,

Jonathan

> ---
> v2:
>    -no change in this patch.
> 
>  drivers/staging/iio/accel/adis16201.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 97150ea..298bf90 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -173,9 +173,8 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  		ret = adis_read_reg_16(st, addr, &val16);
>  		if (ret)
>  			return ret;
> -		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> -		*val = val16;
> +
> +		*val = sign_extend32(val16, bits - 1);
>  		return IIO_VAL_INT;
>  	}
>  

