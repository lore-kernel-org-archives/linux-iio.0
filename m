Return-Path: <SRS0=xXKh=I4=perches.com=joe@kernel.org>
Message-ID: <f32e6e86a92c76ca2fab2abbf3ae3f454afbe72e.camel@perches.com>
Subject: Re: [PATCH] staging:iio:accel: use sign extend function avoiding
 code duplication
From: Joe Perches <joe@perches.com>
To: Karim Eshapa <karim.eshapa@gmail.com>, lars@metafoo.de, Himanshu Jha
	 <himanshujha199640@gmail.com>
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date: Sun, 10 Jun 2018 15:34:44 -0700
In-Reply-To: <20180610220920.12244-1-karim.eshapa@gmail.com>
References: <20180610220920.12244-1-karim.eshapa@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Mon, 2018-06-11 at 00:09 +0200, Karim Eshapa wrote:
> Use sign_extend32 kernel function instead of code duplication.
> This function is also safe for 16 bits.

Firstly:

This file is not in staging anymore.
Please use the -next tree for patches.

> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
[]
> @@ -227,9 +227,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  		ret = adis_read_reg_16(st, addr, &val16);
>  		if (ret)
>  			return ret;
> -		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> -		*val = val16;
> +		*val = sign_extend32(val16, bits);
>  		return IIO_VAL_INT;
>  	}

Secondly:

A similar patch with a different bits value was
already applied.

Please verify the appropriate bits value.

commit e7f3bfb7eb7d9307c0c157f82fceb228f0aec1d9
Author: Himanshu Jha <himanshujha199640@gmail.com>
Date:   Sat Mar 17 01:36:23 2018 +0530

    Staging: iio: accel: adis16201: Use sign_extend32 function
    
    Use sign_extned32() for 32 bit sign extending rather than hard coding.
    
    Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
    Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/accel/adis16201.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 87ad3d421c12..526dde481f84 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -173,9 +173,8 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 		ret = adis_read_reg_16(st, addr, &val16);
 		if (ret)
 			return ret;
-		val16 &= (1 << bits) - 1;
-		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
-		*val = val16;
+
+		*val = sign_extend32(val16, bits - 1);
                return IIO_VAL_INT;
        }
 
