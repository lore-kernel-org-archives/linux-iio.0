Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH 2/2] Staging: iio: adc: Prefer using the BIT macro
To: Bhumika Goyal <bhumirks@gmail.com>, gregkh@linuxfoundation.org,
 Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
 pmeerw@pmeerw.net
References: <cover.1454913458.git.bhumirks@gmail.com>
 <9d77eec44a1f7223c2482ebe3c7df1f90d96aa9a.1454913458.git.bhumirks@gmail.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56B85CEA.4070106@metafoo.de>
Date: Mon, 8 Feb 2016 10:16:26 +0100
MIME-Version: 1.0
In-Reply-To: <9d77eec44a1f7223c2482ebe3c7df1f90d96aa9a.1454913458.git.bhumirks@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 02/08/2016 07:48 AM, Bhumika Goyal wrote:
> This patch replaces bit shifting on 1 with the BIT(x) macro.
> 
> This was done with coccinelle:
> 
> @@ int g; @@
> 
> -(1 << g)
> +BIT(g)
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Hi,

Thanks for the patch. This looks good.

> ---
>  drivers/staging/iio/adc/ad7280a.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 0c73bce..ccf3157 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -117,7 +117,7 @@
>   */
>  #define POLYNOM		0x2F
>  #define POLYNOM_ORDER	8
> -#define HIGHBIT		(1 << (POLYNOM_ORDER - 1))
> +#define HIGHBIT		BIT((POLYNOM_ORDER - 1))

But please drop the extra brackets and resend the patch.

>  
>  struct ad7280_state {
>  	struct spi_device		*spi;
> @@ -388,7 +388,7 @@ static ssize_t ad7280_show_balance_sw(struct device *dev,
>  
>  	return sprintf(buf, "%d\n",
>  		       !!(st->cb_mask[this_attr->address >> 8] &
> -		       (1 << ((this_attr->address & 0xFF) + 2))));
> +		       BIT(((this_attr->address & 0xFF) + 2))));

Same here.
