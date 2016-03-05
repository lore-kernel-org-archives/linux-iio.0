Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55956 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbcCEPDc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Mar 2016 10:03:32 -0500
Subject: Re: [PATCH 2/3] iio:adc:at91-sama5d2: fix identation
To: Ludovic Desroches <ludovic.desroches@atmel.com>
References: <1457021355-23898-1-git-send-email-ludovic.desroches@atmel.com>
 <1457021355-23898-3-git-send-email-ludovic.desroches@atmel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56DAF542.6020803@kernel.org>
Date: Sat, 5 Mar 2016 15:03:30 +0000
MIME-Version: 1.0
In-Reply-To: <1457021355-23898-3-git-send-email-ludovic.desroches@atmel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/03/16 16:09, Ludovic Desroches wrote:
> Remove some extra tabs.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
I find it hard to care about this sort of patch, but whatever.

Applied to the togreg branch of iio.git - pushed out as testing.. etc etc.

Jonathan
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 33bacec..5bc038f 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -92,13 +92,13 @@
>  /* Last Converted Data Register */
>  #define AT91_SAMA5D2_LCDR	0x20
>  /* Interrupt Enable Register */
> -#define AT91_SAMA5D2_IER		0x24
> +#define AT91_SAMA5D2_IER	0x24
>  /* Interrupt Disable Register */
> -#define AT91_SAMA5D2_IDR		0x28
> +#define AT91_SAMA5D2_IDR	0x28
>  /* Interrupt Mask Register */
> -#define AT91_SAMA5D2_IMR		0x2c
> +#define AT91_SAMA5D2_IMR	0x2c
>  /* Interrupt Status Register */
> -#define AT91_SAMA5D2_ISR		0x30
> +#define AT91_SAMA5D2_ISR	0x30
>  /* Last Channel Trigger Mode Register */
>  #define AT91_SAMA5D2_LCTMR	0x34
>  /* Last Channel Compare Window Register */
> @@ -106,17 +106,17 @@
>  /* Overrun Status Register */
>  #define AT91_SAMA5D2_OVER	0x3c
>  /* Extended Mode Register */
> -#define AT91_SAMA5D2_EMR		0x40
> +#define AT91_SAMA5D2_EMR	0x40
>  /* Compare Window Register */
> -#define AT91_SAMA5D2_CWR		0x44
> +#define AT91_SAMA5D2_CWR	0x44
>  /* Channel Gain Register */
> -#define AT91_SAMA5D2_CGR		0x48
> +#define AT91_SAMA5D2_CGR	0x48
>  /* Channel Offset Register */
> -#define AT91_SAMA5D2_COR		0x4c
> +#define AT91_SAMA5D2_COR	0x4c
>  /* Channel Data Register 0 */
>  #define AT91_SAMA5D2_CDR0	0x50
>  /* Analog Control Register */
> -#define AT91_SAMA5D2_ACR		0x94
> +#define AT91_SAMA5D2_ACR	0x94
>  /* Touchscreen Mode Register */
>  #define AT91_SAMA5D2_TSMR	0xb0
>  /* Touchscreen X Position Register */
> @@ -130,7 +130,7 @@
>  /* Correction Select Register */
>  #define AT91_SAMA5D2_COSR	0xd0
>  /* Correction Value Register */
> -#define AT91_SAMA5D2_CVR		0xd4
> +#define AT91_SAMA5D2_CVR	0xd4
>  /* Channel Error Correction Register */
>  #define AT91_SAMA5D2_CECR	0xd8
>  /* Write Protection Mode Register */
> 

