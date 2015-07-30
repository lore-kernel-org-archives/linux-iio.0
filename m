Return-Path: <antoine.tenart@free-electrons.com>
Date: Thu, 30 Jul 2015 14:47:43 +0200
From: Antoine Tenart <antoine.tenart@free-electrons.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v2 3/8] iio:adc:berlin2-adc: use GENMASK and BIT for masks
Message-ID: <20150730124743.GB16416@kwain>
References: <cover.1438035998.git.knaack.h@gmx.de>
 <1e5a908f364c1fb18982be097ac83689820d64a8.1438035998.git.knaack.h@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1e5a908f364c1fb18982be097ac83689820d64a8.1438035998.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jul 28, 2015 at 12:38:59AM +0200, Hartmut Knaack wrote:
> Make use of GENMASK for consecutive bitmasks and BIT for single bitmasks.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>

> ---
>  drivers/iio/adc/berlin2-adc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
> index b31bcf4c7c90..ed31a0a8d78e 100644
> --- a/drivers/iio/adc/berlin2-adc.c
> +++ b/drivers/iio/adc/berlin2-adc.c
> @@ -27,13 +27,13 @@
>  #define  BERLIN2_SM_CTRL_SM_SOC_INT		BIT(1)
>  #define  BERLIN2_SM_CTRL_SOC_SM_INT		BIT(2)
>  #define  BERLIN2_SM_CTRL_ADC_SEL(x)		((x) << 5)	/* 0-15 */
> -#define  BERLIN2_SM_CTRL_ADC_SEL_MASK		(0xf << 5)
> +#define  BERLIN2_SM_CTRL_ADC_SEL_MASK		GENMASK(8, 5)
>  #define  BERLIN2_SM_CTRL_ADC_POWER		BIT(9)
>  #define  BERLIN2_SM_CTRL_ADC_CLKSEL_DIV2	(0x0 << 10)
>  #define  BERLIN2_SM_CTRL_ADC_CLKSEL_DIV3	(0x1 << 10)
>  #define  BERLIN2_SM_CTRL_ADC_CLKSEL_DIV4	(0x2 << 10)
>  #define  BERLIN2_SM_CTRL_ADC_CLKSEL_DIV8	(0x3 << 10)
> -#define  BERLIN2_SM_CTRL_ADC_CLKSEL_MASK	(0x3 << 10)
> +#define  BERLIN2_SM_CTRL_ADC_CLKSEL_MASK	GENMASK(11, 10)
>  #define  BERLIN2_SM_CTRL_ADC_START		BIT(12)
>  #define  BERLIN2_SM_CTRL_ADC_RESET		BIT(13)
>  #define  BERLIN2_SM_CTRL_ADC_BANDGAP_RDY	BIT(14)
> @@ -50,7 +50,7 @@
>  #define  BERLIN2_SM_CTRL_TSEN_MODE_10_50	(0x1 << 22)	/* 10-50 C */
>  #define  BERLIN2_SM_CTRL_TSEN_RESET		BIT(29)
>  #define BERLIN2_SM_ADC_DATA			0x20
> -#define  BERLIN2_SM_ADC_MASK			0x3ff
> +#define  BERLIN2_SM_ADC_MASK			GENMASK(9, 0)
>  #define BERLIN2_SM_ADC_STATUS			0x1c
>  #define  BERLIN2_SM_ADC_STATUS_DATA_RDY(x)	BIT(x)		/* 0-15 */
>  #define  BERLIN2_SM_ADC_STATUS_DATA_RDY_MASK	GENMASK(15, 0)
> @@ -65,9 +65,9 @@
>  #define  BERLIN2_SM_TSEN_CTRL_START		BIT(8)
>  #define  BERLIN2_SM_TSEN_CTRL_SETTLING_4	(0x0 << 21)	/* 4 us */
>  #define  BERLIN2_SM_TSEN_CTRL_SETTLING_12	(0x1 << 21)	/* 12 us */
> -#define  BERLIN2_SM_TSEN_CTRL_SETTLING_MASK	(0x1 << 21)
> +#define  BERLIN2_SM_TSEN_CTRL_SETTLING_MASK	BIT(21)
>  #define  BERLIN2_SM_TSEN_CTRL_TRIM(x)		((x) << 22)
> -#define  BERLIN2_SM_TSEN_CTRL_TRIM_MASK		(0xf << 22)
> +#define  BERLIN2_SM_TSEN_CTRL_TRIM_MASK		GENMASK(25, 22)
>  
>  struct berlin2_adc_priv {
>  	struct regmap		*regmap;
> -- 
> 2.4.6
> 

-- 
Antoine Ténart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
