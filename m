Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750938AbdKSP5G (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Nov 2017 10:57:06 -0500
Date: Sun, 19 Nov 2017 15:57:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 5/5] iio: adc: meson-saradc: program the channel muxes
 during initialization
Message-ID: <20171119155701.551b4cd1@archlinux>
In-Reply-To: <20171031200147.14660-6-martin.blumenstingl@googlemail.com>
References: <20171031200147.14660-1-martin.blumenstingl@googlemail.com>
        <20171031200147.14660-6-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 31 Oct 2017 21:01:47 +0100
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> On some Meson8 devices the channel muxes are not programmed. This
> results in garbage values when trying to read channels that are not set
> up.
> Fix this by initializing the channel 0 and 1 muxes in
> MESON_SAR_ADC_CHAN_10_SW as well as the muxes for all other channels in
> MESON_SAR_ADC_AUX_SW based on what the vendor driver does (which is
> simply a 1:1 mapping of channel number and channel mux).
> This only showed up on Meson8 devices, because for GXBB and newer BL30
> is taking care of initializing the channel muxes.
> 
> This additionally fixes a typo in the
> MESON_SAR_ADC_AUX_SW_MUX_SEL_CHAN_MASK macro because the old definition
> assumed that the register fields were 2 bit wide, while they are
> actually 3 bit wide.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

I'll go with your opinion on this.   We can always request that it is
added to stable after it has gone in during the next merge window.

Let me know if I seem to have forgotten this once the fixes have
come back round the loop to my togreg branch.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/meson_saradc.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index fa3c1378c2c9..48fb1b642a5e 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -96,8 +96,8 @@
>  	#define MESON_SAR_ADC_FIFO_RD_SAMPLE_VALUE_MASK		GENMASK(11, 0)
>  
>  #define MESON_SAR_ADC_AUX_SW					0x1c
> -	#define MESON_SAR_ADC_AUX_SW_MUX_SEL_CHAN_MASK(_chan)	\
> -					(GENMASK(10, 8) << (((_chan) - 2) * 2))
> +	#define MESON_SAR_ADC_AUX_SW_MUX_SEL_CHAN_SHIFT(_chan)	\
> +					(8 + (((_chan) - 2) * 3))
>  	#define MESON_SAR_ADC_AUX_SW_VREF_P_MUX			BIT(6)
>  	#define MESON_SAR_ADC_AUX_SW_VREF_N_MUX			BIT(5)
>  	#define MESON_SAR_ADC_AUX_SW_MODE_SEL			BIT(4)
> @@ -623,7 +623,7 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
>  static int meson_sar_adc_init(struct iio_dev *indio_dev)
>  {
>  	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> -	int regval, ret;
> +	int regval, i, ret;
>  
>  	/*
>  	 * make sure we start at CH7 input since the other muxes are only used
> @@ -678,6 +678,32 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
>  			   FIELD_PREP(MESON_SAR_ADC_DELAY_INPUT_DLY_SEL_MASK,
>  				      1));
>  
> +	/*
> +	 * set up the input channel muxes in MESON_SAR_ADC_CHAN_10_SW
> +	 * (0 = SAR_ADC_CH0, 1 = SAR_ADC_CH1)
> +	 */
> +	regval = FIELD_PREP(MESON_SAR_ADC_CHAN_10_SW_CHAN0_MUX_SEL_MASK, 0);
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_CHAN_10_SW,
> +			   MESON_SAR_ADC_CHAN_10_SW_CHAN0_MUX_SEL_MASK,
> +			   regval);
> +	regval = FIELD_PREP(MESON_SAR_ADC_CHAN_10_SW_CHAN1_MUX_SEL_MASK, 1);
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_CHAN_10_SW,
> +			   MESON_SAR_ADC_CHAN_10_SW_CHAN1_MUX_SEL_MASK,
> +			   regval);
> +
> +	/*
> +	 * set up the input channel muxes in MESON_SAR_ADC_AUX_SW
> +	 * (2 = SAR_ADC_CH2, 3 = SAR_ADC_CH3, ...) and enable
> +	 * MESON_SAR_ADC_AUX_SW_YP_DRIVE_SW and
> +	 * MESON_SAR_ADC_AUX_SW_XP_DRIVE_SW like the vendor driver.
> +	 */
> +	regval = 0;
> +	for (i = 2; i <= 7; i++)
> +		regval |= i << MESON_SAR_ADC_AUX_SW_MUX_SEL_CHAN_SHIFT(i);
> +	regval |= MESON_SAR_ADC_AUX_SW_YP_DRIVE_SW;
> +	regval |= MESON_SAR_ADC_AUX_SW_XP_DRIVE_SW;
> +	regmap_write(priv->regmap, MESON_SAR_ADC_AUX_SW, regval);
> +
>  	ret = clk_set_parent(priv->adc_sel_clk, priv->clkin);
>  	if (ret) {
>  		dev_err(indio_dev->dev.parent,

