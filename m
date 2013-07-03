Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:48823 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528Ab3GCMVV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jul 2013 08:21:21 -0400
From: Marek Vasut <marex@denx.de>
To: Hector Palacios <hector.palacios@digi.com>
Subject: Re: [PATCH RFC] iio: mxs-lradc: add scaling to enable divide_by_two operation
Date: Wed, 3 Jul 2013 13:25:29 +0200
Cc: linux-iio@vger.kernel.org, alexandre.belloni@free-electrons.com,
	lars@metafoo.de, fabio.estevam@freescale.com
References: <1372845969-31776-1-git-send-email-hector.palacios@digi.com>
In-Reply-To: <1372845969-31776-1-git-send-email-hector.palacios@digi.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201307031325.29554.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Hector Palacios,

> Most LRADC channels have an optional divisor by two which allows
> a maximum input voltage of VDDIO - 50mV. This patch adds the scaling
> info flag to these channels (all except 7 -VBATT-, 10 -VDDIO- and
> 15 -VDD5V-) to allow enabled divide_by_two read operation.
> 
> Reference: http://www.spinics.net/lists/linux-iio/msg08876.html
> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
> ---
>  drivers/staging/iio/adc/mxs-lradc.c | 52
> +++++++++++++++++++++++-------------- 1 file changed, 33 insertions(+), 19
> deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
> b/drivers/staging/iio/adc/mxs-lradc.c index 51f781f..4363bb6 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -197,6 +197,7 @@ struct mxs_lradc {
>  #define	LRADC_CTRL1_LRADC_IRQ_OFFSET		0
> 
>  #define	LRADC_CTRL2				0x20
> +#define LRADC_CTRL2_DIVIDE_BY_TWO_OFFSET	24
>  #define	LRADC_CTRL2_TEMPSENSE_PWD		(1 << 15)
> 
>  #define	LRADC_STATUS				0x40
> @@ -234,7 +235,7 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
>  	struct mxs_lradc *lradc = iio_priv(iio_dev);
>  	int ret;
> 
> -	if (m != IIO_CHAN_INFO_RAW)
> +	if (m != IIO_CHAN_INFO_RAW && m != IIO_CHAN_INFO_SCALE)
>  		return -EINVAL;
> 
>  	/* Check for invalid channel */
> @@ -262,6 +263,11 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
>  		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
>  	writel(0xff, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
> 
> +	/* Enable DIVIDE_BY_TWO on channel 0 if reading scaled value */
> +	if (IIO_CHAN_INFO_SCALE == m)
> +		writel(1 << LRADC_CTRL2_DIVIDE_BY_TWO_OFFSET,
> +		       lradc->base + LRADC_CTRL2 + STMP_OFFSET_REG_SET);
> +
>  	/* Clean the slot's previous content, then set new one. */
>  	writel(LRADC_CTRL4_LRADCSELECT_MASK(0),
>  		lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_CLR);
> @@ -286,6 +292,10 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
>  	ret = IIO_VAL_INT;
> 
>  err:
> +	/* Disable DIVIDE_BY_TWO on channel 0 if reading scaled value */
> +	if (IIO_CHAN_INFO_SCALE == m)
> +		writel(1 << LRADC_CTRL2_DIVIDE_BY_TWO_OFFSET,
> +		       lradc->base + LRADC_CTRL2 + STMP_OFFSET_REG_CLR);
>  	writel(LRADC_CTRL1_LRADC_IRQ_EN(0),
>  		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
> 
> @@ -806,11 +816,11 @@ static const struct iio_buffer_setup_ops
> mxs_lradc_buffer_ops = { * Driver initialization
>   */
> 
> -#define MXS_ADC_CHAN(idx, chan_type) {				\
> +#define MXS_ADC_CHAN(idx, chan_type, info) {			\
>  	.type = (chan_type),					\
>  	.indexed = 1,						\
>  	.scan_index = (idx),					\
> -	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,		\
> +	.info_mask = (info),					\
>  	.channel = (idx),					\
>  	.scan_type = {						\
>  		.sign = 'u',					\
> @@ -819,23 +829,27 @@ static const struct iio_buffer_setup_ops
> mxs_lradc_buffer_ops = { },							
\
>  }
> 
> +#define RAW		IIO_CHAN_INFO_RAW_SEPARATE_BIT
> +#define RAW_SCALED	(IIO_CHAN_INFO_RAW_SEPARATE_BIT |	\
> +			 IIO_CHAN_INFO_SCALE_SEPARATE_BIT)
> +
>  static const struct iio_chan_spec mxs_lradc_chan_spec[] = {
> -	MXS_ADC_CHAN(0, IIO_VOLTAGE),
> -	MXS_ADC_CHAN(1, IIO_VOLTAGE),
> -	MXS_ADC_CHAN(2, IIO_VOLTAGE),
> -	MXS_ADC_CHAN(3, IIO_VOLTAGE),
> -	MXS_ADC_CHAN(4, IIO_VOLTAGE),
> -	MXS_ADC_CHAN(5, IIO_VOLTAGE),
> -	MXS_ADC_CHAN(6, IIO_VOLTAGE),
> -	MXS_ADC_CHAN(7, IIO_VOLTAGE),	/* VBATT */
> -	MXS_ADC_CHAN(8, IIO_TEMP),	/* Temp sense 0 */
> -	MXS_ADC_CHAN(9, IIO_TEMP),	/* Temp sense 1 */
> -	MXS_ADC_CHAN(10, IIO_VOLTAGE),	/* VDDIO */
> -	MXS_ADC_CHAN(11, IIO_VOLTAGE),	/* VTH */
> -	MXS_ADC_CHAN(12, IIO_VOLTAGE),	/* VDDA */
> -	MXS_ADC_CHAN(13, IIO_VOLTAGE),	/* VDDD */
> -	MXS_ADC_CHAN(14, IIO_VOLTAGE),	/* VBG */
> -	MXS_ADC_CHAN(15, IIO_VOLTAGE),	/* VDD5V */
> +	MXS_ADC_CHAN(0, IIO_VOLTAGE, RAW_SCALED),
> +	MXS_ADC_CHAN(1, IIO_VOLTAGE, RAW_SCALED),
> +	MXS_ADC_CHAN(2, IIO_VOLTAGE, RAW_SCALED),
> +	MXS_ADC_CHAN(3, IIO_VOLTAGE, RAW_SCALED),
> +	MXS_ADC_CHAN(4, IIO_VOLTAGE, RAW_SCALED),
> +	MXS_ADC_CHAN(5, IIO_VOLTAGE, RAW_SCALED),
> +	MXS_ADC_CHAN(6, IIO_VOLTAGE, RAW_SCALED),
> +	MXS_ADC_CHAN(7, IIO_VOLTAGE, RAW),		/* VBATT */
> +	MXS_ADC_CHAN(8, IIO_TEMP, RAW_SCALED),		/* Temp sense 0 */
> +	MXS_ADC_CHAN(9, IIO_TEMP, RAW_SCALED),		/* Temp sense 1 */
> +	MXS_ADC_CHAN(10, IIO_VOLTAGE, RAW),		/* VDDIO */
> +	MXS_ADC_CHAN(11, IIO_VOLTAGE, RAW_SCALED),	/* VTH */
> +	MXS_ADC_CHAN(12, IIO_VOLTAGE, RAW_SCALED),	/* VDDA */
> +	MXS_ADC_CHAN(13, IIO_VOLTAGE, RAW_SCALED),	/* VDDD */
> +	MXS_ADC_CHAN(14, IIO_VOLTAGE, RAW_SCALED),	/* VBG */
> +	MXS_ADC_CHAN(15, IIO_VOLTAGE, RAW),		/* VDD5V */

Please check the MX23 datasheet, I think what is, isn't and how is scaled 
differs there. Also, can you make sure you also implement the fixed pre-dividers 
? I think some channel is pre-divided with 1:4 ratio etc (see bullets at the top 
of 38.2 in MX28 datasheet).

Best regards,
Marek Vasut
