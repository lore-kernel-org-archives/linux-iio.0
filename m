Return-Path: <SRS0=hvw+=3A=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH] staging: ad7746: Moved contents of the header to the
 source file.
To: Arushi Singhal <arushisinghal19971997@gmail.com>
References: <20170323113649.GA23947@arushi-HP-Pavilion-Notebook>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 outreachy-kernel@googlegroups.com
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <575e7930-5328-1a06-4b68-04e121e8a7f6@metafoo.de>
Date: Thu, 23 Mar 2017 12:44:47 +0100
MIME-Version: 1.0
In-Reply-To: <20170323113649.GA23947@arushi-HP-Pavilion-Notebook>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 03/23/2017 12:36 PM, Arushi Singhal wrote:
> Moved the contents of the header(ad7746.h) into the source file
> ad7746.c with the exception of the platform data struct which is
> supposed to be used from somewhere else other than the driver.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>  drivers/staging/iio/cdc/ad7746.c | 5 +++++
>  drivers/staging/iio/cdc/ad7746.h | 5 -----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 2d8397b11b19..033a41fd9bee 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -21,6 +21,11 @@
>  
>  #include "ad7746.h"
>  
> +#define AD7466_EXCLVL_0         0 /* +-VDD/8 */
> +#define AD7466_EXCLVL_1         1 /* +-VDD/4 */
> +#define AD7466_EXCLVL_2         2 /* +-VDD * 3/8 */
> +#define AD7466_EXCLVL_3         3 /* +-VDD/2 */
> +
>  /*
>   * AD7746 Register Definition
>   */
> diff --git a/drivers/staging/iio/cdc/ad7746.h b/drivers/staging/iio/cdc/ad7746.h
> index ea8572d1df02..2fbcee88fda6 100644
> --- a/drivers/staging/iio/cdc/ad7746.h
> +++ b/drivers/staging/iio/cdc/ad7746.h
> @@ -13,11 +13,6 @@
>   * TODO: struct ad7746_platform_data needs to go into include/linux/iio
>   */
>  
> -#define AD7466_EXCLVL_0		0 /* +-VDD/8 */
> -#define AD7466_EXCLVL_1		1 /* +-VDD/4 */
> -#define AD7466_EXCLVL_2		2 /* +-VDD * 3/8 */
> -#define AD7466_EXCLVL_3		3 /* +-VDD/2 */
> -

I believe those are settings for the exclvl field in the platform data
struct. Hence this has to stay here.

>  struct ad7746_platform_data {
>  	unsigned char exclvl;	/*Excitation Voltage Level */
>  	bool exca_en;		/* enables EXCA pin as the excitation output */
> 
