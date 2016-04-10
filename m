Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43998 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192AbcDJNyt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2016 09:54:49 -0400
Subject: Re: [PATCH 2/9] iio: adc: qcom-spmi-iadc: use regmap to retrieve
 struct device
To: Alison Schofield <amsfield22@gmail.com>
References: <cover.1459918214.git.amsfield22@gmail.com>
 <aaffb79b464a361556e098d42081406813c511c4.1459918214.git.amsfield22@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	kgene@kernel.org, k.kozlowski@samsung.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <570A5B25.8060308@kernel.org>
Date: Sun, 10 Apr 2016 14:54:45 +0100
MIME-Version: 1.0
In-Reply-To: <aaffb79b464a361556e098d42081406813c511c4.1459918214.git.amsfield22@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/16 06:16, Alison Schofield wrote:
> Driver includes struct regmap and struct device in its global data.
> Remove the struct device and use regmap API to retrieve device info.
> 
> Patch created using Coccinelle plus manual edits.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
This has the same issue as the exynos driver - in that the regmap belongs
to the parent, not this device.
> ---
>  drivers/iio/adc/qcom-spmi-iadc.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-iadc.c b/drivers/iio/adc/qcom-spmi-iadc.c
> index fabd24e..f69a057 100644
> --- a/drivers/iio/adc/qcom-spmi-iadc.c
> +++ b/drivers/iio/adc/qcom-spmi-iadc.c
> @@ -102,7 +102,6 @@
>  /**
>   * struct iadc_chip - IADC Current ADC device structure.
>   * @regmap: regmap for register read/write.
> - * @dev: This device pointer.
>   * @base: base offset for the ADC peripheral.
>   * @rsense: Values of the internal and external sense resister in micro Ohms.
>   * @poll_eoc: Poll for end of conversion instead of waiting for IRQ.
> @@ -113,7 +112,6 @@
>   */
>  struct iadc_chip {
>  	struct regmap	*regmap;
> -	struct device	*dev;
>  	u16		base;
>  	bool		poll_eoc;
>  	u32		rsense[2];
> @@ -170,6 +168,7 @@ static int iadc_set_state(struct iadc_chip *iadc, bool state)
>  
>  static void iadc_status_show(struct iadc_chip *iadc)
>  {
> +	struct device *dev = regmap_get_device(iadc->regmap);
>  	u8 mode, sta1, chan, dig, en, req;
>  	int ret;
>  
> @@ -197,7 +196,7 @@ static void iadc_status_show(struct iadc_chip *iadc)
>  	if (ret < 0)
>  		return;
>  
> -	dev_err(iadc->dev,
> +	dev_err(dev,
>  		"mode:%02x en:%02x chan:%02x dig:%02x req:%02x sta1:%02x\n",
>  		mode, en, chan, dig, req, sta1);
>  }
> @@ -284,6 +283,7 @@ static int iadc_read_result(struct iadc_chip *iadc, u16 *data)
>  
>  static int iadc_do_conversion(struct iadc_chip *iadc, int chan, u16 *data)
>  {
> +	struct device *dev = regmap_get_device(iadc->regmap);
>  	unsigned int wait;
>  	int ret;
>  
> @@ -310,7 +310,7 @@ static int iadc_do_conversion(struct iadc_chip *iadc, int chan, u16 *data)
>  exit:
>  	iadc_set_state(iadc, false);
>  	if (ret < 0)
> -		dev_err(iadc->dev, "conversion failed\n");
> +		dev_err(dev, "conversion failed\n");
>  
>  	return ret;
>  }
> @@ -320,6 +320,7 @@ static int iadc_read_raw(struct iio_dev *indio_dev,
>  			 int *val, int *val2, long mask)
>  {
>  	struct iadc_chip *iadc = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(iadc->regmap);
>  	s32 isense_ua, vsense_uv;
>  	u16 adc_raw, vsense_raw;
>  	int ret;
> @@ -339,7 +340,7 @@ static int iadc_read_raw(struct iio_dev *indio_dev,
>  
>  		isense_ua = vsense_uv / iadc->rsense[chan->channel];
>  
> -		dev_dbg(iadc->dev, "off %d gain %d adc %d %duV I %duA\n",
> +		dev_dbg(dev, "off %d gain %d adc %d %duV I %duA\n",
>  			iadc->offset[chan->channel], iadc->gain,
>  			adc_raw, vsense_uv, isense_ua);
>  
> @@ -370,6 +371,7 @@ static irqreturn_t iadc_isr(int irq, void *dev_id)
>  
>  static int iadc_update_offset(struct iadc_chip *iadc)
>  {
> +	struct device *dev = regmap_get_device(iadc->regmap);
>  	int ret;
>  
>  	ret = iadc_do_conversion(iadc, IADC_GAIN_17P857MV, &iadc->gain);
> @@ -382,7 +384,7 @@ static int iadc_update_offset(struct iadc_chip *iadc)
>  		return ret;
>  
>  	if (iadc->gain == iadc->offset[IADC_INT_RSENSE]) {
> -		dev_err(iadc->dev, "error: internal offset == gain %d\n",
> +		dev_err(dev, "error: internal offset == gain %d\n",
>  			iadc->gain);
>  		return -EINVAL;
>  	}
> @@ -393,8 +395,7 @@ static int iadc_update_offset(struct iadc_chip *iadc)
>  		return ret;
>  
>  	if (iadc->gain == iadc->offset[IADC_EXT_RSENSE]) {
> -		dev_err(iadc->dev, "error: external offset == gain %d\n",
> -			iadc->gain);
> +		dev_err(dev, "error: external offset == gain %d\n", iadc->gain);
>  		return -EINVAL;
>  	}
>  
> @@ -403,6 +404,7 @@ static int iadc_update_offset(struct iadc_chip *iadc)
>  
>  static int iadc_version_check(struct iadc_chip *iadc)
>  {
> +	struct device *dev = regmap_get_device(iadc->regmap);
>  	u8 val;
>  	int ret;
>  
> @@ -411,7 +413,7 @@ static int iadc_version_check(struct iadc_chip *iadc)
>  		return ret;
>  
>  	if (val < IADC_PERPH_TYPE_ADC) {
> -		dev_err(iadc->dev, "%d is not ADC\n", val);
> +		dev_err(dev, "%d is not ADC\n", val);
>  		return -EINVAL;
>  	}
>  
> @@ -420,7 +422,7 @@ static int iadc_version_check(struct iadc_chip *iadc)
>  		return ret;
>  
>  	if (val < IADC_PERPH_SUBTYPE_IADC) {
> -		dev_err(iadc->dev, "%d is not IADC\n", val);
> +		dev_err(dev, "%d is not IADC\n", val);
>  		return -EINVAL;
>  	}
>  
> @@ -429,7 +431,7 @@ static int iadc_version_check(struct iadc_chip *iadc)
>  		return ret;
>  
>  	if (val < IADC_REVISION2_SUPPORTED_IADC) {
> -		dev_err(iadc->dev, "revision %d not supported\n", val);
> +		dev_err(dev, "revision %d not supported\n", val);
>  		return -EINVAL;
>  	}
>  
> @@ -438,6 +440,7 @@ static int iadc_version_check(struct iadc_chip *iadc)
>  
>  static int iadc_rsense_read(struct iadc_chip *iadc, struct device_node *node)
>  {
> +	struct device *dev = regmap_get_device(iadc->regmap);
>  	int ret, sign, int_sense;
>  	u8 deviation;
>  
> @@ -447,7 +450,7 @@ static int iadc_rsense_read(struct iadc_chip *iadc, struct device_node *node)
>  		iadc->rsense[IADC_EXT_RSENSE] = IADC_INT_RSENSE_IDEAL_VALUE;
>  
>  	if (!iadc->rsense[IADC_EXT_RSENSE]) {
> -		dev_err(iadc->dev, "external resistor can't be zero Ohms");
> +		dev_err(dev, "external resistor can't be zero Ohms");
>  		return -EINVAL;
>  	}
>  
> @@ -505,7 +508,6 @@ static int iadc_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	iadc = iio_priv(indio_dev);
> -	iadc->dev = dev;
>  
>  	iadc->regmap = dev_get_regmap(dev->parent, NULL);
>  	if (!iadc->regmap)
> @@ -528,7 +530,7 @@ static int iadc_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return -ENODEV;
>  
> -	dev_dbg(iadc->dev, "sense resistors %d and %d micro Ohm\n",
> +	dev_dbg(&pdev->dev, "sense resistors %d and %d micro Ohm\n",
>  		iadc->rsense[IADC_INT_RSENSE],
>  		iadc->rsense[IADC_EXT_RSENSE]);
>  
> @@ -553,7 +555,7 @@ static int iadc_probe(struct platform_device *pdev)
>  		else
>  			return ret;
>  	} else {
> -		device_init_wakeup(iadc->dev, 1);
> +		device_init_wakeup(&pdev->dev, 1);
>  	}
>  
>  	ret = iadc_update_offset(iadc);
> 

