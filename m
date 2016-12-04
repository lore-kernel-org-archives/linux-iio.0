Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42832 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934482AbdAHJng (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 04:43:36 -0500
Subject: Re: [PATCH 05/19] staging: iio: isl29028: made alignment of #defines
 consistent
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
 <1480817983-32359-6-git-send-email-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4bd7cc64-f429-8234-9e6a-144bd445b36f@kernel.org>
Date: Sun, 4 Dec 2016 11:39:25 +0000
MIME-Version: 1.0
In-Reply-To: <1480817983-32359-6-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/12/16 02:19, Brian Masney wrote:
> The alignment of the #defines at the top of the file is not consistent.
> This changes all of the defines to use consistent alignment to improve
> the code readability.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Skipped patch 4 for now, but this one still applies fine so applied to the
togreg branch of iio.git.

Will push out as testing later.
> ---
>  drivers/staging/iio/light/isl29028.c | 42 ++++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index e96a8cb..d5b069e 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -27,38 +27,38 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> -#define ISL29028_CONV_TIME_MS		100
> +#define ISL29028_CONV_TIME_MS			100
>  
> -#define ISL29028_REG_CONFIGURE		0x01
> +#define ISL29028_REG_CONFIGURE			0x01
>  
> -#define ISL29028_CONF_ALS_IR_MODE_ALS	0
> -#define ISL29028_CONF_ALS_IR_MODE_IR	BIT(0)
> -#define ISL29028_CONF_ALS_IR_MODE_MASK	BIT(0)
> +#define ISL29028_CONF_ALS_IR_MODE_ALS		0
> +#define ISL29028_CONF_ALS_IR_MODE_IR		BIT(0)
> +#define ISL29028_CONF_ALS_IR_MODE_MASK		BIT(0)
>  
> -#define ISL29028_CONF_ALS_RANGE_LOW_LUX	0
> +#define ISL29028_CONF_ALS_RANGE_LOW_LUX		0
>  #define ISL29028_CONF_ALS_RANGE_HIGH_LUX	BIT(1)
> -#define ISL29028_CONF_ALS_RANGE_MASK	BIT(1)
> +#define ISL29028_CONF_ALS_RANGE_MASK		BIT(1)
>  
> -#define ISL29028_CONF_ALS_DIS		0
> -#define ISL29028_CONF_ALS_EN		BIT(2)
> -#define ISL29028_CONF_ALS_EN_MASK	BIT(2)
> +#define ISL29028_CONF_ALS_DIS			0
> +#define ISL29028_CONF_ALS_EN			BIT(2)
> +#define ISL29028_CONF_ALS_EN_MASK		BIT(2)
>  
> -#define ISL29028_CONF_PROX_SLP_SH	4
> -#define ISL29028_CONF_PROX_SLP_MASK	(7 << ISL29028_CONF_PROX_SLP_SH)
> +#define ISL29028_CONF_PROX_SLP_SH		4
> +#define ISL29028_CONF_PROX_SLP_MASK		(7 << ISL29028_CONF_PROX_SLP_SH)
>  
> -#define ISL29028_CONF_PROX_EN		BIT(7)
> -#define ISL29028_CONF_PROX_EN_MASK	BIT(7)
> +#define ISL29028_CONF_PROX_EN			BIT(7)
> +#define ISL29028_CONF_PROX_EN_MASK		BIT(7)
>  
> -#define ISL29028_REG_INTERRUPT		0x02
> +#define ISL29028_REG_INTERRUPT			0x02
>  
> -#define ISL29028_REG_PROX_DATA		0x08
> -#define ISL29028_REG_ALSIR_L		0x09
> -#define ISL29028_REG_ALSIR_U		0x0A
> +#define ISL29028_REG_PROX_DATA			0x08
> +#define ISL29028_REG_ALSIR_L			0x09
> +#define ISL29028_REG_ALSIR_U			0x0A
>  
> -#define ISL29028_REG_TEST1_MODE		0x0E
> -#define ISL29028_REG_TEST2_MODE		0x0F
> +#define ISL29028_REG_TEST1_MODE			0x0E
> +#define ISL29028_REG_TEST2_MODE			0x0F
>  
> -#define ISL29028_NUM_REGS		(ISL29028_REG_TEST2_MODE + 1)
> +#define ISL29028_NUM_REGS			(ISL29028_REG_TEST2_MODE + 1)
>  
>  enum isl29028_als_ir_mode {
>  	ISL29028_MODE_NONE = 0,
> 

