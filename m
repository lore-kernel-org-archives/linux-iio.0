Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753621AbeAFPKp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jan 2018 10:10:45 -0500
Date: Sat, 6 Jan 2018 15:10:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sumit Pundir <pundirsumit11@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Staging: iio: cdc: Prefer using BIT macro
Message-ID: <20180106151040.731937ef@archlinux>
In-Reply-To: <1515251124-5954-1-git-send-email-pundirsumit11@gmail.com>
References: <1515251124-5954-1-git-send-email-pundirsumit11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat,  6 Jan 2018 20:35:24 +0530
Sumit Pundir <pundirsumit11@gmail.com> wrote:

> This patch fixes the following checkpatch.pl issue at multiple lines:
> 
> CHECK: Prefer using the BIT macro
> 
> Signed-off-by: Sumit Pundir <pundirsumit11@gmail.com>
> ---
> v2:
>  Added the specific driver being changed to the patch title
Not that I can see.

Anyhow, never mind I'll fix it whilst applying.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

>  and the appropriate fixes as suggested.
> 
>  drivers/staging/iio/cdc/ad7152.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
> index 59d1b35..19dc896 100644
> --- a/drivers/staging/iio/cdc/ad7152.c
> +++ b/drivers/staging/iio/cdc/ad7152.c
> @@ -47,7 +47,7 @@
>  #define AD7152_STATUS_PWDN		BIT(7)
>  
>  /* Setup Register Bit Designations (AD7152_REG_CHx_SETUP) */
> -#define AD7152_SETUP_CAPDIFF		(1 << 5)
> +#define AD7152_SETUP_CAPDIFF		BIT(5)
>  #define AD7152_SETUP_RANGE_2pF		(0 << 6)
>  #define AD7152_SETUP_RANGE_0_5pF	(1 << 6)
>  #define AD7152_SETUP_RANGE_1pF		(2 << 6)
> @@ -55,8 +55,8 @@
>  #define AD7152_SETUP_RANGE(x)		((x) << 6)
>  
>  /* Config Register Bit Designations (AD7152_REG_CFG) */
> -#define AD7152_CONF_CH2EN		(1 << 3)
> -#define AD7152_CONF_CH1EN		(1 << 4)
> +#define AD7152_CONF_CH2EN		BIT(3)
> +#define AD7152_CONF_CH1EN		BIT(4)
>  #define AD7152_CONF_MODE_IDLE		(0 << 0)
>  #define AD7152_CONF_MODE_CONT_CONV	(1 << 0)
>  #define AD7152_CONF_MODE_SINGLE_CONV	(2 << 0)
> @@ -64,7 +64,7 @@
>  #define AD7152_CONF_MODE_GAIN_CAL	(6 << 0)
>  
>  /* Capdac Register Bit Designations (AD7152_REG_CAPDAC_XXX) */
> -#define AD7152_CAPDAC_DACEN		(1 << 7)
> +#define AD7152_CAPDAC_DACEN		BIT(7)
>  #define AD7152_CAPDAC_DACP(x)		((x) & 0x1F)
>  
>  /* CFG2 Register Bit Designations (AD7152_REG_CFG2) */

