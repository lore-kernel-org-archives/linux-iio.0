Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:34053 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbcDUVEr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 21 Apr 2016 17:04:47 -0400
Message-ID: <57193B91.9030704@denx.de>
Date: Thu, 21 Apr 2016 22:44:01 +0200
From: Marek Vasut <marex@denx.de>
MIME-Version: 1.0
To: Stefan Wahren <stefan.wahren@i2se.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC: Fabio Estevam <fabio.estevam@nxp.com>,
	Juergen Borleis <jbe@pengutronix.de>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFT V2 2/3] iio: mxs-lradc: disable only masked channels
 in mxs_lradc_hw_stop
References: <1461269478-449-1-git-send-email-stefan.wahren@i2se.com> <1461269478-449-3-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1461269478-449-3-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/21/2016 10:11 PM, Stefan Wahren wrote:
> Disabling of the touchscreen IRQs should be done in
> mxs_lradc_disable_ts. So disable only the masked virtual channels
> in mxs_lradc_hw_stop and finally remove the unused function
> mxs_lradc_irq_en_mask.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/iio/adc/mxs-lradc.c |   11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
> index 223650b..cfc558f 100644
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
> @@ -1505,7 +1498,9 @@ static void mxs_lradc_hw_stop(struct mxs_lradc *lradc)
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
Looks sane too:

Reviewed-by: Marek Vasut <marex@denx.de>

-- 
Best regards,
Marek Vasut
