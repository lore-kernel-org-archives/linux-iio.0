Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37470 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751749AbdBSMTF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2017 07:19:05 -0500
Subject: Re: [PATCH v2 1/2] iio: adc: meson-saradc: switch from polling to
 interrupt mode
To: Heiner Kallweit <hkallweit1@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <ff323b09-2ea8-7b7b-71b5-2f5248de6067@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6669b94f-6c0e-1a75-cecf-79d437b170d5@kernel.org>
Date: Sun, 19 Feb 2017 12:19:03 +0000
MIME-Version: 1.0
In-Reply-To: <ff323b09-2ea8-7b7b-71b5-2f5248de6067@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/02/17 19:31, Heiner Kallweit wrote:
> Switch from polling to interrupt mode.
> 
> Successfully tested on a S905GXBB-based Odroid C2.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Looks like a nice change to me.  I'll wait on Martin taking another look though
before applying it.

One question that came up wrt to a similar change in another driver the other
day, are there any reasons why we might not want to use the IRQ and hence preserve
the existing polled approach? On the other device it turned out there was a limit on
the number of interrupts that could be enabled simultaneously so there might be cases
where the ADC was unimportant and they'd elect to do it without the interrupt.  

I have no idea what the situation is here so thought I'd just ask!

Jonathan
> ---
> v2:
> - move enabling / disabling irq to meson_sar_adc_start_sample_engine /
>   meson_sar_adc_stop_sample_engine respectively
> - move setting FIFO threshold for irq triggering to meson_sar_adc_hw_enable
>   to avoid a potential issue when uboot should be involved in system resume
> - return IRQ_NONE if the interrupt can't be for us
> - document interrupts property in DT documentation
> ---
>  .../bindings/iio/adc/amlogic,meson-saradc.txt      |  2 +
>  drivers/iio/adc/meson_saradc.c                     | 56 ++++++++++++++++++++--
>  2 files changed, 53 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
> index f9e3ff2c..04718919 100644
> --- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
> @@ -7,6 +7,7 @@ Required properties:
>  			- "amlogic,meson-gxm-saradc" for GXM
>  		along with the generic "amlogic,meson-saradc"
>  - reg:		the physical base address and length of the registers
> +- interrupts:	the interrupt indicating end of sampling
>  - clocks:	phandle and clock identifier (see clock-names)
>  - clock-names:	mandatory clocks:
>  			- "clkin" for the reference clock (typically XTAL)
> @@ -23,6 +24,7 @@ Example:
>  		compatible = "amlogic,meson-gxl-saradc", "amlogic,meson-saradc";
>  		#io-channel-cells = <1>;
>  		reg = <0x0 0x8680 0x0 0x34>;
> +		interrupts = <GIC_SPI 73 IRQ_TYPE_EDGE_RISING>;
>  		clocks = <&xtal>,
>  			 <&clkc CLKID_SAR_ADC>,
>  			 <&clkc CLKID_SANA>,
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 89def603..9f186de2 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -18,7 +18,9 @@
>  #include <linux/io.h>
>  #include <linux/iio/iio.h>
>  #include <linux/module.h>
> +#include <linux/interrupt.h>
>  #include <linux/of.h>
> +#include <linux/of_irq.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> @@ -163,6 +165,7 @@
>  	#define MESON_SAR_ADC_REG13_12BIT_CALIBRATION_MASK	GENMASK(13, 8)
>  
>  #define MESON_SAR_ADC_MAX_FIFO_SIZE				32
> +#define MESON_SAR_ADC_TIMEOUT					100 /* ms */
>  
>  #define MESON_SAR_ADC_CHAN(_chan) {					\
>  	.type = IIO_VOLTAGE,						\
> @@ -229,6 +232,7 @@ struct meson_sar_adc_priv {
>  	struct clk_gate				clk_gate;
>  	struct clk				*adc_div_clk;
>  	struct clk_divider			clk_div;
> +	struct completion			done;
>  };
>  
>  static const struct regmap_config meson_sar_adc_regmap_config = {
> @@ -274,11 +278,11 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
>  					 int *val)
>  {
>  	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> -	int ret, regval, fifo_chan, fifo_val, sum = 0, count = 0;
> +	int regval, fifo_chan, fifo_val, sum = 0, count = 0;
>  
> -	ret = meson_sar_adc_wait_busy_clear(indio_dev);
> -	if (ret)
> -		return ret;
> +	if(!wait_for_completion_timeout(&priv->done,
> +				msecs_to_jiffies(MESON_SAR_ADC_TIMEOUT)))
> +		return -ETIMEDOUT;
>  
>  	while (meson_sar_adc_get_fifo_count(indio_dev) > 0 &&
>  	       count < MESON_SAR_ADC_MAX_FIFO_SIZE) {
> @@ -378,6 +382,12 @@ static void meson_sar_adc_start_sample_engine(struct iio_dev *indio_dev)
>  {
>  	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
>  
> +	reinit_completion(&priv->done);
> +
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
> +			   MESON_SAR_ADC_REG0_FIFO_IRQ_EN,
> +			   MESON_SAR_ADC_REG0_FIFO_IRQ_EN);
> +
>  	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
>  			   MESON_SAR_ADC_REG0_SAMPLE_ENGINE_ENABLE,
>  			   MESON_SAR_ADC_REG0_SAMPLE_ENGINE_ENABLE);
> @@ -392,6 +402,9 @@ static void meson_sar_adc_stop_sample_engine(struct iio_dev *indio_dev)
>  	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
>  
>  	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
> +			   MESON_SAR_ADC_REG0_FIFO_IRQ_EN, 0);
> +
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
>  			   MESON_SAR_ADC_REG0_SAMPLING_STOP,
>  			   MESON_SAR_ADC_REG0_SAMPLING_STOP);
>  
> @@ -643,6 +656,7 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
>  {
>  	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
>  	int ret;
> +	u32 regval;
>  
>  	ret = meson_sar_adc_lock(indio_dev);
>  	if (ret)
> @@ -667,6 +681,9 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
>  		goto err_sana_clk;
>  	}
>  
> +	regval = FIELD_PREP(MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK, 1);
> +	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
> +			   MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK, regval);
>  	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
>  			   MESON_SAR_ADC_REG11_BANDGAP_EN,
>  			   MESON_SAR_ADC_REG11_BANDGAP_EN);
> @@ -728,6 +745,25 @@ static int meson_sar_adc_hw_disable(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> +static irqreturn_t meson_sar_adc_irq(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +	unsigned int cnt, threshold;
> +	u32 regval;
> +
> +	regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
> +	cnt = FIELD_GET(MESON_SAR_ADC_REG0_FIFO_COUNT_MASK, regval);
> +	threshold = FIELD_GET(MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK, regval);
> +
> +	if (cnt < threshold)
> +		return IRQ_NONE;
> +
> +	complete(&priv->done);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static const struct iio_info meson_sar_adc_iio_info = {
>  	.read_raw = meson_sar_adc_iio_info_read_raw,
>  	.driver_module = THIS_MODULE,
> @@ -770,7 +806,7 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	void __iomem *base;
>  	const struct of_device_id *match;
> -	int ret;
> +	int irq, ret;
>  
>  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
>  	if (!indio_dev) {
> @@ -779,6 +815,7 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>  	}
>  
>  	priv = iio_priv(indio_dev);
> +	init_completion(&priv->done);
>  
>  	match = of_match_device(meson_sar_adc_of_match, &pdev->dev);
>  	priv->data = match->data;
> @@ -797,6 +834,15 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  
> +	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
> +	if (!irq)
> +		return -EINVAL;
> +
> +	ret = devm_request_irq(&pdev->dev, irq, meson_sar_adc_irq, IRQF_SHARED,
> +			       dev_name(&pdev->dev), indio_dev);
> +	if (ret)
> +		return ret;
> +
>  	priv->regmap = devm_regmap_init_mmio(&pdev->dev, base,
>  					     &meson_sar_adc_regmap_config);
>  	if (IS_ERR(priv->regmap))
> 

