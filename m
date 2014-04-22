Return-Path: <rdunlap@infradead.org>
Message-ID: <5356E217.3090105@infradead.org>
Date: Tue, 22 Apr 2014 14:41:43 -0700
From: Randy Dunlap <rdunlap@infradead.org>
MIME-Version: 1.0
To: Masanari Iida <standby24x7@gmail.com>, jic23@kernel.org,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
CC: gregkh@linuxfoundation.org
Subject: Re: [PATCH] staging: iio: Fix typo in iio
References: <1398165818-25904-1-git-send-email-standby24x7@gmail.com>
In-Reply-To: <1398165818-25904-1-git-send-email-standby24x7@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 04/22/14 04:23, Masanari Iida wrote:
> Correct spelling typo in comment within staging/iio
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/staging/iio/adc/ad7606.h    | 4 ++--
>  drivers/staging/iio/adc/ad7816.c    | 2 +-
>  drivers/staging/iio/adc/ad799x.h    | 2 +-
>  drivers/staging/iio/addac/adt7316.c | 4 ++--
>  drivers/staging/iio/cdc/ad7152.c    | 2 +-
>  drivers/staging/iio/cdc/ad7746.c    | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
> index 93c7299..ec89d05 100644
> --- a/drivers/staging/iio/adc/ad7606.h
> +++ b/drivers/staging/iio/adc/ad7606.h
> @@ -14,7 +14,7 @@
>   */
>  
>  /**
> - * struct ad7606_platform_data - platform/board specifc information
> + * struct ad7606_platform_data - platform/board specific information
>   * @default_os:		default oversampling value {0, 2, 4, 8, 16, 32, 64}
>   * @default_range:	default range +/-{5000, 10000} mVolt
>   * @gpio_convst:	number of gpio connected to the CONVST pin
> @@ -41,7 +41,7 @@ struct ad7606_platform_data {
>  };
>  
>  /**
> - * struct ad7606_chip_info - chip specifc information
> + * struct ad7606_chip_info - chip specific information
>   * @name:		identification string for chip
>   * @int_vref_mv:	the internal reference voltage
>   * @channels:		channel specification
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 2369cf2..158d770 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -40,7 +40,7 @@
>  
>  
>  /*
> - * struct ad7816_chip_info - chip specifc information
> + * struct ad7816_chip_info - chip specific information
>   */
>  
>  struct ad7816_chip_info {
> diff --git a/drivers/staging/iio/adc/ad799x.h b/drivers/staging/iio/adc/ad799x.h
> index fc8c852..70ddfa2 100644
> --- a/drivers/staging/iio/adc/ad799x.h
> +++ b/drivers/staging/iio/adc/ad799x.h
> @@ -76,7 +76,7 @@ enum {
>  struct ad799x_state;
>  
>  /**
> - * struct ad799x_chip_info - chip specifc information
> + * struct ad799x_chip_info - chip specific information
>   * @channel:		channel specification
>   * @num_channels:	number of channels
>   * @monitor_mode:	whether the chip supports monitor interrupts
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 9f0ebb3..5f1770e 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -172,7 +172,7 @@
>  #define ID_ADT75XX		0x10
>  
>  /*
> - * struct adt7316_chip_info - chip specifc information
> + * struct adt7316_chip_info - chip specific information
>   */
>  
>  struct adt7316_chip_info {
> @@ -208,7 +208,7 @@ struct adt7316_chip_info {
>  	(ADT7316_TEMP_INT_MASK)
>  
>  /*
> - * struct adt7316_chip_info - chip specifc information
> + * struct adt7316_chip_info - chip specific information
>   */
>  
>  struct adt7316_limit_regs {
> diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
> index f2c309d..87110d9 100644
> --- a/drivers/staging/iio/cdc/ad7152.c
> +++ b/drivers/staging/iio/cdc/ad7152.c
> @@ -78,7 +78,7 @@ enum {
>  };
>  
>  /*
> - * struct ad7152_chip_info - chip specifc information
> + * struct ad7152_chip_info - chip specific information
>   */
>  
>  struct ad7152_chip_info {
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index cbb1588..e6e9eaa 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -91,7 +91,7 @@
>  #define AD7746_CAPDAC_DACP(x)		((x) & 0x7F)
>  
>  /*
> - * struct ad7746_chip_info - chip specifc information
> + * struct ad7746_chip_info - chip specific information
>   */
>  
>  struct ad7746_chip_info {
> 


-- 
~Randy
