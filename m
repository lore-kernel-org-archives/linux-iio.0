Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752351AbdGFSlE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Jul 2017 14:41:04 -0400
Date: Thu, 6 Jul 2017 19:41:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        singhalsimran0@gmail.com, linux-iio@vger.kernel.org,
        Fugang Duan <B38611@freescale.com>
Subject: Re: [PATCH] iio: adc: vf610_adc: Fix VALT selection value for
 REFSEL bits
Message-ID: <20170706194101.428c49a1@kernel.org>
In-Reply-To: <1499332001-8486-1-git-send-email-stefan-gabriel.mirea@nxp.com>
References: <1499332001-8486-1-git-send-email-stefan-gabriel.mirea@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu,  6 Jul 2017 10:06:41 +0100
Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com> wrote:

> In order to select the alternate voltage reference pair (VALTH/VALTL), the
> right value for the REFSEL field in the ADCx_CFG register is "01", leading
> to 0x800 as register mask. See section 8.2.6.4 in the reference manual[1].
> 
> [1] http://www.nxp.com/docs/en/reference-manual/VFXXXRM.pdf
> 
> Fixes: a775427632fd ("iio:adc:imx: add Freescale Vybrid vf610 adc driver")
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Looks good.

Applied to the fixes to greg branch of iio.git.  

Cc'd Fugang as the original author.

Btw if you know the author is no longer available, adding a note below the
  --- saves on me trying to get hold of them!

Thanks,

Jonathan
> ---
>  drivers/iio/adc/vf610_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index 01fc76f7d660..c168e0db329a 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -77,7 +77,7 @@
>  #define VF610_ADC_ADSTS_MASK		0x300
>  #define VF610_ADC_ADLPC_EN		0x80
>  #define VF610_ADC_ADHSC_EN		0x400
> -#define VF610_ADC_REFSEL_VALT		0x100
> +#define VF610_ADC_REFSEL_VALT		0x800
>  #define VF610_ADC_REFSEL_VBG		0x1000
>  #define VF610_ADC_ADTRG_HARD		0x2000
>  #define VF610_ADC_AVGS_8		0x4000

