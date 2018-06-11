Return-Path: <SRS0=Cvk6=I5=perches.com=joe@kernel.org>
Message-ID: <48143872d69d231273bd2c8ed835cbf0046a263d.camel@perches.com>
Subject: Re: [PATCH] staging:iio:accel:adis16240: sign extend function
 avoiding code duplication
From: Joe Perches <joe@perches.com>
To: Karim Eshapa <karim.eshapa@gmail.com>, lars@metafoo.de
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date: Mon, 11 Jun 2018 16:57:24 -0700
In-Reply-To: <20180611233814.18597-1-karim.eshapa@gmail.com>
References: <20180611233814.18597-1-karim.eshapa@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Tue, 2018-06-12 at 01:38 +0200, Karim Eshapa wrote:
> Use sign_extend32 kernel function instead of code duplication.
> Safe also for 16 bit.

Perhaps remove the bits declaration and assignments
and just use 9 directly.

> diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
[]
> @@ -292,9 +292,7 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
>  		ret = adis_read_reg_16(st, addr, &val16);
>  		if (ret)
>  			return ret;
> -		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> -		*val = val16;
> +		*val = sign_extend32(val16, bits - 1);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_PEAK:
>  		bits = 10;
> @@ -302,9 +300,7 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
>  		ret = adis_read_reg_16(st, addr, &val16);
>  		if (ret)
>  			return ret;
> -		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> -		*val = val16;
> +		*val = sign_extend32(val16, bits - 1);
>  		return IIO_VAL_INT;
>  	}
>  	return -EINVAL;
