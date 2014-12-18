Return-Path: <knaack.h@gmx.de>
Message-ID: <549341D4.7040807@gmx.de>
Date: Thu, 18 Dec 2014 22:06:28 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Devendra Naga <devendra.aaru@gmail.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Peter Meerwald
 <pmeerw@pmeerw.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: meter: ade7754: fix build warnings with
 make randconfig
References: <1418644006-5558-1-git-send-email-devendra.aaru@gmail.com>
In-Reply-To: <1418644006-5558-1-git-send-email-devendra.aaru@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Devendra Naga schrieb am 15.12.2014 um 12:46:
> fixes
> 
> drivers/staging/iio/meter/ade7754.c:222:6: warning: ‘val’ may be used
> uninitialized in this function [-Wmaybe-uninitialized]
> drivers/staging/iio/meter/ade7754.c:368:6: warning: ‘val’ may be used
> uninitialized in this function [-Wmaybe-uninitialized]
> 
> the fix here is to check the return value of ade7754_spi_read_reg_8.
Hi,
I would recommend to use a different topic name, which represents a bit
better what your patch actually does (something like add error handling
in _reset and _stop_device).
Your attempt is basically right, but in _stop_device I would at least
recommend to add an error message, given that it is only called from
_remove, which does no error handling. So, at least it becomes clear
that something went wrong and the device didn't get powered down.
Since your second patch is very similar to this one, the same applies
there, too.
Thanks,

Hartmut
> 
> Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
> ---
> 
>  hapens on next-20141215 with make randconfig. compile tested only on x86_64.
> 
>  drivers/staging/iio/meter/ade7754.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
> index 81f6731..9e71575 100644
> --- a/drivers/staging/iio/meter/ade7754.c
> +++ b/drivers/staging/iio/meter/ade7754.c
> @@ -216,9 +216,13 @@ error_ret:
>  
>  static int ade7754_reset(struct device *dev)
>  {
> +	int ret;
>  	u8 val;
>  
> -	ade7754_spi_read_reg_8(dev, ADE7754_OPMODE, &val);
> +	ret = ade7754_spi_read_reg_8(dev, ADE7754_OPMODE, &val);
> +	if (ret < 0)
> +		return ret;
> +
>  	val |= 1 << 6; /* Software Chip Reset */
>  	return ade7754_spi_write_reg_8(dev, ADE7754_OPMODE, val);
>  }
> @@ -362,9 +366,13 @@ error_ret:
>  /* Power down the device */
>  static int ade7754_stop_device(struct device *dev)
>  {
> +	int ret;
>  	u8 val;
>  
> -	ade7754_spi_read_reg_8(dev, ADE7754_OPMODE, &val);
> +	ret = ade7754_spi_read_reg_8(dev, ADE7754_OPMODE, &val);
> +	if (ret < 0)
> +		return ret;
> +
>  	val |= 7 << 3;  /* ADE7754 powered down */
>  	return ade7754_spi_write_reg_8(dev, ADE7754_OPMODE, val);
>  }
> 
