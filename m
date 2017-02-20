Return-Path: <SRS0=LGL2=2B=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH v2 2/2] staging: iio: ad7152: Use GENMASK() macro for left
 shifts
To: sayli karnik <karniksayli1995@gmail.com>,
 outreachy-kernel@googlegroups.com
References: <cover.1487483384.git.karniksayli1995@gmail.com>
 <b74094e5c94e11cad734b1bde11db0356e6d3aab.1487483384.git.karniksayli1995@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <74cd812d-14ae-9adc-7c5b-8fe4d8daf272@metafoo.de>
Date: Mon, 20 Feb 2017 09:29:25 +0100
MIME-Version: 1.0
In-Reply-To: <b74094e5c94e11cad734b1bde11db0356e6d3aab.1487483384.git.karniksayli1995@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 02/19/2017 09:00 PM, sayli karnik wrote:
> Use GENMASK() macro for left shifting integers.
> 
> Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
> ---
> v2:
> Used GENMASK() macro instead of BIT() macro for multi-bit bitfields.
> Removed extra parentheses around argument to macro
> 
>  drivers/staging/iio/cdc/ad7152.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
> index e8609b8..ab94fad 100644
> --- a/drivers/staging/iio/cdc/ad7152.c
> +++ b/drivers/staging/iio/cdc/ad7152.c
> @@ -47,28 +47,28 @@
>  #define AD7152_STATUS_PWDN		BIT(7)
>  
>  /* Setup Register Bit Designations (AD7152_REG_CHx_SETUP) */
> -#define AD7152_SETUP_CAPDIFF		(1 << 5)
> [...]
> +#define AD7152_SETUP_CAPDIFF		GENMASK(1, 5)

This was actually right, the first time, CAPDIFF is a single bit bitfield,
so it should use BIT().

> [...]
> -#define AD7152_CONF_CH2EN		(1 << 3)
> -#define AD7152_CONF_CH1EN		(1 << 4)
> [...]
> +#define AD7152_CONF_CH2EN		GENMASK(1, 3)
> +#define AD7152_CONF_CH1EN		GENMASK(1, 4)

Same here CH2EN and CH1EN are single bit bitfields.

>  /* Capdac Register Bit Designations (AD7152_REG_CAPDAC_XXX) */
> -#define AD7152_CAPDAC_DACEN		(1 << 7)
> [...]
> +#define AD7152_CAPDAC_DACEN		GENMASK(1, 7)

Same for DACEN.
