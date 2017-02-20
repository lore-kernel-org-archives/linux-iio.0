Return-Path: <SRS0=LflA=2B=consetetur.de=hendrik@kernel.org>
Date: Mon, 20 Feb 2017 10:48:46 +0100
From: "Hendrik v. Raven" <hendrik@consetetur.de>
To: sayli karnik <karniksayli1995@gmail.com>
Cc: outreachy-kernel@googlegroups.com, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] staging: iio: ad7152: Use GENMASK() macro for
 left shifts
Message-ID: <20170220094845.GA17071@psyche.fritz.box>
References: <cover.1487483384.git.karniksayli1995@gmail.com>
 <b74094e5c94e11cad734b1bde11db0356e6d3aab.1487483384.git.karniksayli1995@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <b74094e5c94e11cad734b1bde11db0356e6d3aab.1487483384.git.karniksayli1995@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Feb 20, 2017 at 01:30:27AM +0530, sayli karnik wrote:
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
> -#define AD7152_SETUP_RANGE_2pF		(0 << 6)
> -#define AD7152_SETUP_RANGE_0_5pF	(1 << 6)
> -#define AD7152_SETUP_RANGE_1pF		(2 << 6)
> -#define AD7152_SETUP_RANGE_4pF		(3 << 6)
> -#define AD7152_SETUP_RANGE(x)		((x) << 6)
> +#define AD7152_SETUP_CAPDIFF		GENMASK(1, 5)
> +#define AD7152_SETUP_RANGE_2pF		GENMASK(0, 6)
> +#define AD7152_SETUP_RANGE_0_5pF	GENMASK(1, 6)
> +#define AD7152_SETUP_RANGE_1pF		GENMASK(2, 6)
> +#define AD7152_SETUP_RANGE_4pF		GENMASK(3, 6)
> +#define AD7152_SETUP_RANGE(x)		GENMASK(x, 6)
I am a bit confused about the usage of GENMASK here. Unless I completely
misunderstand the macro these are not at all equivalent to the previous
bitshifts as most of them just expand to 0.

>  /* Config Register Bit Designations (AD7152_REG_CFG) */
> -#define AD7152_CONF_CH2EN		(1 << 3)
> -#define AD7152_CONF_CH1EN		(1 << 4)
> -#define AD7152_CONF_MODE_IDLE		(0 << 0)
> -#define AD7152_CONF_MODE_CONT_CONV	(1 << 0)
> -#define AD7152_CONF_MODE_SINGLE_CONV	(2 << 0)
> -#define AD7152_CONF_MODE_OFFS_CAL	(5 << 0)
> -#define AD7152_CONF_MODE_GAIN_CAL	(6 << 0)
> +#define AD7152_CONF_CH2EN		GENMASK(1, 3)
> +#define AD7152_CONF_CH1EN		GENMASK(1, 4)
> +#define AD7152_CONF_MODE_IDLE		GENMASK(0, 0)
> +#define AD7152_CONF_MODE_CONT_CONV	GENMASK(1, 0)
> +#define AD7152_CONF_MODE_SINGLE_CONV	GENMASK(2, 0)
> +#define AD7152_CONF_MODE_OFFS_CAL	GENMASK(5, 0)
> +#define AD7152_CONF_MODE_GAIN_CAL	GENMASK(6, 0)
>  
>  /* Capdac Register Bit Designations (AD7152_REG_CAPDAC_XXX) */
> -#define AD7152_CAPDAC_DACEN		(1 << 7)
> -#define AD7152_CAPDAC_DACP(x)		((x) & 0x1F)
> +#define AD7152_CAPDAC_DACEN		GENMASK(1, 7)
same here
> +#define AD7152_CAPDAC_DACP(x)		GENMASK(x, 0x1F)
this is more something like ((x) & GENMASK(5,0)).

>  /* CFG2 Register Bit Designations (AD7152_REG_CFG2) */
> -#define AD7152_CFG2_OSR(x)		(((x) & 0x3) << 4)
> +#define AD7152_CFG2_OSR(x)		GENMASK((x) & 0x3, 4)
>  
>  enum {
>  	AD7152_DATA,
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
