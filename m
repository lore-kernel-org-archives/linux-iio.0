Return-Path: <SRS0=aGnT=6V=oracle.com=dan.carpenter@kernel.org>
Date: Tue, 18 Jul 2017 14:28:44 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jaya Durga <rjdurga@gmail.com>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
        jic23@kernel.org
Subject: Re: [PATCH v2 3/3] Staging: iio: adc: ad7280a.c: Fixed Macro
 argument reuse
Message-ID: <20170718112844.nla4n6e7pb2xmruk@mwanda>
References: <1500376504-22779-3-git-send-email-rjdurga@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500376504-22779-3-git-send-email-rjdurga@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jul 18, 2017 at 04:45:04PM +0530, Jaya Durga wrote:
> CHECK: Macro argument reuse 'addr' - possible side-effects?
> 
> convert AD7280A_DEVADDR to ad7280a_devaddr static function
> to fix checkpath check
> 
> Signed-off-by: Jaya Durga <rjdurga@gmail.com>
> ---

Put a little changelog here:

v2: small style changes

>  drivers/staging/iio/adc/ad7280a.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index d5ab83f..f543b42 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -99,9 +99,14 @@
>  #define AD7280A_DEVADDR_MASTER		0
>  #define AD7280A_DEVADDR_ALL		0x1F
>  /* 5-bit device address is sent LSB first */
> -#define AD7280A_DEVADDR(addr)	(((addr & 0x1) << 4) | ((addr & 0x2) << 3) | \
> -				(addr & 0x4) | ((addr & 0x8) >> 3) | \
> -				((addr & 0x10) >> 4))
> +static unsigned int ad7280a_devaddr(unsigned int addr)
> +{
> +	return ((addr & 0x1) << 4) |
> +		((addr & 0x2) << 3) |
> +		(addr & 0x4)       |
> +		((addr & 0x8) >> 3) |
> +		((addr & 0x10) >> 4);

This indenting makes no sense though.  You're almost but not quite
making the '|' characters line up.  When I did it, I added space
characters to make it work:

	return ((addr & 0x1) << 4) |
	       ((addr & 0x2) << 3) |  <- 1 tab and 7 spaces
		(addr & 0x4)       |  <- 2 tabs
	       ((addr & 0x8) >> 3) |
	       ((addr & 0x10) >> 4);

regards,
dan carpenter
