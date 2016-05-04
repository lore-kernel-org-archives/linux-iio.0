Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35805 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbcEDOiG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2016 10:38:06 -0400
Subject: Re: [PATCH V3 3/3] iio: mxs-lradc: disable only masked channels in
 mxs_lradc_hw_stop
To: Stefan Wahren <stefan.wahren@i2se.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Marek Vasut <marex@denx.de>
References: <1461441479-23218-1-git-send-email-stefan.wahren@i2se.com>
 <1461441479-23218-4-git-send-email-stefan.wahren@i2se.com>
Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Juergen Borleis <jbe@pengutronix.de>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <240d09cb-8df3-01dd-ee84-6f5dd8cad64a@kernel.org>
Date: Wed, 4 May 2016 10:39:52 +0100
MIME-Version: 1.0
In-Reply-To: <1461441479-23218-4-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/04/16 20:57, Stefan Wahren wrote:
> Disabling of the touchscreen IRQs should be done in
> mxs_lradc_disable_ts. So disable only the masked virtual channels
> in mxs_lradc_hw_stop and finally remove the unused function
> mxs_lradc_irq_en_mask.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Reviewed-by: Marek Vasut <marex@denx.de>
> Tested-by: Marek Vasut <marex@denx.de>
Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/iio/adc/mxs-lradc.c |   11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
> index 90242ba..b84d37c 100644
> --- a/drivers/iio/adc/mxs-lradc.c
> +++ b/drivers/iio/adc/mxs-lradc.c
> @@ -373,13 +373,6 @@ static u32 mxs_lradc_plate_mask(struct mxs_lradc *lradc)
>  	return LRADC_CTRL0_MX28_PLATE_MASK;
>  }
>  
> -static u32 mxs_lradc_irq_en_mask(struct mxs_lradc *lradc)
> -{
> -	if (lradc->soc == IMX23_LRADC)
> -		return LRADC_CTRL1_MX23_LRADC_IRQ_EN_MASK;
> -	return LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK;
> -}
> -
>  static u32 mxs_lradc_irq_mask(struct mxs_lradc *lradc)
>  {
>  	if (lradc->soc == IMX23_LRADC)
> @@ -1496,7 +1489,9 @@ static void mxs_lradc_hw_stop(struct mxs_lradc *lradc)
>  {
>  	int i;
>  
> -	mxs_lradc_reg_clear(lradc, mxs_lradc_irq_en_mask(lradc), LRADC_CTRL1);
> +	mxs_lradc_reg_clear(lradc,
> +		lradc->buffer_vchans << LRADC_CTRL1_LRADC_IRQ_EN_OFFSET,
> +		LRADC_CTRL1);
>  
>  	for (i = 0; i < LRADC_MAX_DELAY_CHANS; i++)
>  		mxs_lradc_reg_wrt(lradc, 0, LRADC_DELAY(i));
> 

