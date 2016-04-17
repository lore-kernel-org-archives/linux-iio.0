Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53035 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbcDQKrM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Apr 2016 06:47:12 -0400
Subject: Re: [PATCH RFT 4/5] iio: mxs-lradc: disable only mapped channels in
 mxs_lradc_hw_stop
To: Stefan Wahren <stefan.wahren@i2se.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Marek Vasut <marex@denx.de>
References: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com>
 <1460648909-2657-5-git-send-email-stefan.wahren@i2se.com>
Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Juergen Borleis <jbe@pengutronix.de>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <571369AA.8060106@kernel.org>
Date: Sun, 17 Apr 2016 11:47:06 +0100
MIME-Version: 1.0
In-Reply-To: <1460648909-2657-5-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/04/16 16:48, Stefan Wahren wrote:
> Disabling of the touchscreen IRQs is already done in
> mxs_lradc_disable_ts. There is no need to disable them in
> mxs_lradc_hw_stop again.
We could do with a little more documentation in the driver on
which bits in this register are doing what.

The disable_ts deals with bits 22-24... 
The only other bit I think is ever used by the driver currently is
16 (channel 0).  

So whilst this change probably works, I'm not sure of the logic behind it.
As far as I can tell your new clear is fine but in reality you could
just clear (0x3f << 16) and get the same result (which would be clearer
to my mind).

The key think here is that we don't support the higher bits on i.mx28
yet... Which are for button detection and threshold detection.

Have I understood this correctly?

Jonathan
 So we only need to care of the
> mapped channels which are common for i.MX23 and i.MX28
> and we remove the now unused function mxs_lradc_irq_en_mask.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/iio/adc/mxs-lradc.c |   11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
> index 95d84c9..97c993f 100644
> --- a/drivers/iio/adc/mxs-lradc.c
> +++ b/drivers/iio/adc/mxs-lradc.c
> @@ -295,6 +295,7 @@ struct mxs_lradc {
>  #define	LRADC_CTRL1_LRADC_IRQ_EN(n)		(1 << ((n) + 16))
>  #define	LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK	(0x1fff << 16)
>  #define	LRADC_CTRL1_MX23_LRADC_IRQ_EN_MASK	(0x01ff << 16)
> +#define	LRADC_CTRL1_MAPPED_CHANS_IRQ_EN_MASK	(0x00ff << 16)
>  #define	LRADC_CTRL1_LRADC_IRQ_EN_OFFSET		16
>  #define	LRADC_CTRL1_TOUCH_DETECT_IRQ		BIT(8)
>  #define	LRADC_CTRL1_LRADC_IRQ(n)		(1 << (n))
> @@ -373,13 +374,6 @@ static u32 mxs_lradc_plate_mask(struct mxs_lradc *lradc)
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
> @@ -1505,7 +1499,8 @@ static void mxs_lradc_hw_stop(struct mxs_lradc *lradc)
>  {
>  	int i;
>  
> -	mxs_lradc_reg_clear(lradc, mxs_lradc_irq_en_mask(lradc), LRADC_CTRL1);
> +	mxs_lradc_reg_clear(lradc, LRADC_CTRL1_MAPPED_CHANS_IRQ_EN_MASK,
> +			    LRADC_CTRL1);
>  
>  	for (i = 0; i < LRADC_MAX_DELAY_CHANS; i++)
>  		mxs_lradc_reg_wrt(lradc, 0, LRADC_DELAY(i));
> 

