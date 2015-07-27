Return-Path: <antoine.tenart@free-electrons.com>
Date: Mon, 27 Jul 2015 09:45:52 +0200
From: Antoine Tenart <antoine.tenart@free-electrons.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: Re: [PATCH 1/8] iio:adc:berlin2-adc: Fix register definition
Message-ID: <20150727074552.GA16683@kwain>
References: <cover.1437862404.git.knaack.h@gmx.de>
 <57c4e77919394abab3c4f93c84d469221ba081f4.1437862404.git.knaack.h@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <57c4e77919394abab3c4f93c84d469221ba081f4.1437862404.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jul 26, 2015 at 12:43:19AM +0200, Hartmut Knaack wrote:
> Active channel number is stored in BERLIN2_SM_CTRL as value, instead of a
> bit map.
> The masks for channel interrupts and data ready are a 16 bits wide bit
> map each, instead of just 4 bits.

Thanks for fixing this!

> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>

> ---
> Driver analysis indicates that only one ADC channel can be sampled at a
> time, and this channel number is stored in BERLIN2_SM_CTRL as a value,
> instead of a bit map.
> In register BERLIN2_SM_ADC_STATUS however, interrupts can be enabled for
> each ADC channel, and data ready is indicated for each ADC channel,
> too - in both cases as a bit map. Since there are 8 channels available,
> both masks should be at least 8 bits wide. But as the comment indicates,
> there are 16 bits for each mask.
> 
>  drivers/iio/adc/berlin2-adc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
> index aecc9ad995ad..97863d1ba79a 100644
> --- a/drivers/iio/adc/berlin2-adc.c
> +++ b/drivers/iio/adc/berlin2-adc.c
> @@ -26,7 +26,7 @@
>  #define BERLIN2_SM_CTRL				0x14
>  #define  BERLIN2_SM_CTRL_SM_SOC_INT		BIT(1)
>  #define  BERLIN2_SM_CTRL_SOC_SM_INT		BIT(2)
> -#define  BERLIN2_SM_CTRL_ADC_SEL(x)		(BIT(x) << 5)	/* 0-15 */
> +#define  BERLIN2_SM_CTRL_ADC_SEL(x)		((x) << 5)	/* 0-15 */
>  #define  BERLIN2_SM_CTRL_ADC_SEL_MASK		(0xf << 5)
>  #define  BERLIN2_SM_CTRL_ADC_POWER		BIT(9)
>  #define  BERLIN2_SM_CTRL_ADC_CLKSEL_DIV2	(0x0 << 10)
> @@ -53,9 +53,9 @@
>  #define  BERLIN2_SM_ADC_MASK			0x3ff
>  #define BERLIN2_SM_ADC_STATUS			0x1c
>  #define  BERLIN2_SM_ADC_STATUS_DATA_RDY(x)	BIT(x)		/* 0-15 */
> -#define  BERLIN2_SM_ADC_STATUS_DATA_RDY_MASK	0xf
> +#define  BERLIN2_SM_ADC_STATUS_DATA_RDY_MASK	GENMASK(15, 0)
>  #define  BERLIN2_SM_ADC_STATUS_INT_EN(x)	(BIT(x) << 16)	/* 0-15 */
> -#define  BERLIN2_SM_ADC_STATUS_INT_EN_MASK	(0xf << 16)
> +#define  BERLIN2_SM_ADC_STATUS_INT_EN_MASK	GENMASK(31, 16)
>  #define BERLIN2_SM_TSEN_STATUS			0x24
>  #define  BERLIN2_SM_TSEN_STATUS_DATA_RDY	BIT(0)
>  #define  BERLIN2_SM_TSEN_STATUS_INT_EN		BIT(1)
> -- 
> 2.4.3
> 

-- 
Antoine Ténart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
