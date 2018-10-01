Return-Path: <SRS0=8BuI=MN=oracle.com=dan.carpenter@kernel.org>
Date: Mon, 1 Oct 2018 15:52:16 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Slawomir Stepien <sst@poczta.fm>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
        pmeerw@pmeerw.net, knaack.h@gmx.de, jic23@kernel.org
Subject: Re: [PATCH] staging: iio: adc: add missing spaces around minus sign
Message-ID: <20181001125216.jdqtcqcnisnea3tf@mwanda>
References: <20181001122834.GA13306@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181001122834.GA13306@x220.localdomain>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Oct 01, 2018 at 02:28:34PM +0200, Slawomir Stepien wrote:
> The checkpatch.pl tool detected coding style problem:
> 
>     CHECK: spaces preferred around that '-' (ctx:VxV)
> 
> in two files inside the adc directory. This patch will remove this
> problem.
> 
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> ---
>  drivers/staging/iio/adc/ad7192.c  | 2 +-
>  drivers/staging/iio/adc/ad7280a.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index acdbc07fd259..7c632cf1932b 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -355,7 +355,7 @@ ad7192_show_scale_available(struct device *dev,
>  }
>  
>  static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
> -			     in_voltage-voltage_scale_available,
> +			     in_voltage - voltage_scale_available,
>  			     0444, ad7192_show_scale_available, NULL, 0);


This doesn't work.  That's not arithmatic, it's a string which is passed
to a macro.  It's an ugly macro, but it would take a lot of work to
change it at this point.

regards,
dan carpenter
