Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40365 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933745AbcKMMNm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Nov 2016 07:13:42 -0500
Subject: Re: [PATCH v4 09/26] staging: iio: tsl2583: fix alignment of #define
 values
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
 <1478974781-1457-10-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <74ca5a26-9af9-f876-0261-a8748b62c5e2@kernel.org>
Date: Sun, 13 Nov 2016 12:13:40 +0000
MIME-Version: 1.0
In-Reply-To: <1478974781-1457-10-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/11/16 18:19, Brian Masney wrote:
> Most of the values in the #defines have their values aligned on a single
> column, but some do not. This changes the remaining defines to use
> consistent alignment with the majority to improve code readability.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/tsl2583.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 5a82a26..d482a84 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -44,19 +44,19 @@
>  /* tsl2583 cmd reg masks */
>  #define TSL2583_CMD_REG			0x80
>  #define TSL2583_CMD_SPL_FN		0x60
> -#define TSL2583_CMD_ALS_INT_CLR	0X01
> +#define TSL2583_CMD_ALS_INT_CLR		0x01
>  
>  /* tsl2583 cntrl reg masks */
> -#define TSL2583_CNTL_ADC_ENBL	0x02
> +#define TSL2583_CNTL_ADC_ENBL		0x02
>  #define TSL2583_CNTL_PWR_OFF		0x00
>  #define TSL2583_CNTL_PWR_ON		0x01
>  
>  /* tsl2583 status reg masks */
> -#define TSL2583_STA_ADC_VALID	0x01
> -#define TSL2583_STA_ADC_INTR	0x10
> +#define TSL2583_STA_ADC_VALID		0x01
> +#define TSL2583_STA_ADC_INTR		0x10
>  
>  /* Lux calculation constants */
> -#define	TSL2583_LUX_CALC_OVER_FLOW		65535
> +#define	TSL2583_LUX_CALC_OVER_FLOW	65535
>  
>  #define TSL2583_INTERRUPT_DISABLED	0x00
>  
> 

