Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44008 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753226AbcDJNzm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2016 09:55:42 -0400
Subject: Re: [PATCH 3/9] iio: adc: qcom-spmi-vadc: use regmap to retrieve
 struct device
To: Alison Schofield <amsfield22@gmail.com>
References: <cover.1459918214.git.amsfield22@gmail.com>
 <13e62b042435dba9edc127a29691bd3519c8e2c0.1459918214.git.amsfield22@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	kgene@kernel.org, k.kozlowski@samsung.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <570A5B5B.5050801@kernel.org>
Date: Sun, 10 Apr 2016 14:55:39 +0100
MIME-Version: 1.0
In-Reply-To: <13e62b042435dba9edc127a29691bd3519c8e2c0.1459918214.git.amsfield22@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/16 06:17, Alison Schofield wrote:
> Driver includes struct regmap and struct device in its global data.
> Remove the struct device and use regmap API to retrieve device info.
> 
> Patch created using Coccinelle plus manual edits.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Another one where the regmap belongs to the wrong device... (parent)
> ---
>  drivers/iio/adc/qcom-spmi-vadc.c | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
> index c2babe5..9e7aeca 100644
> --- a/drivers/iio/adc/qcom-spmi-vadc.c
> +++ b/drivers/iio/adc/qcom-spmi-vadc.c
> @@ -161,7 +161,6 @@ struct vadc_channel_prop {
>  /**
>   * struct vadc_priv - VADC private structure.
>   * @regmap: pointer to struct regmap.
> - * @dev: pointer to struct device.
>   * @base: base address for the ADC peripheral.
>   * @nchannels: number of VADC channels.
>   * @chan_props: array of VADC channel properties.
> @@ -174,7 +173,6 @@ struct vadc_channel_prop {
>   */
>  struct vadc_priv {
>  	struct regmap		 *regmap;
> -	struct device		 *dev;
>  	u16			 base;
>  	unsigned int		 nchannels;
>  	struct vadc_channel_prop *chan_props;
> @@ -236,6 +234,7 @@ static int vadc_set_state(struct vadc_priv *vadc, bool state)
>  
>  static void vadc_show_status(struct vadc_priv *vadc)
>  {
> +	struct device *dev = regmap_get_device(vadc->regmap);
>  	u8 mode, sta1, chan, dig, en, req;
>  	int ret;
>  
> @@ -263,7 +262,7 @@ static void vadc_show_status(struct vadc_priv *vadc)
>  	if (ret)
>  		return;
>  
> -	dev_err(vadc->dev,
> +	dev_err(dev,
>  		"mode:%02x en:%02x chan:%02x dig:%02x req:%02x sta1:%02x\n",
>  		mode, en, chan, dig, req, sta1);
>  }
> @@ -350,13 +349,14 @@ static int vadc_read_result(struct vadc_priv *vadc, u16 *data)
>  static struct vadc_channel_prop *vadc_get_channel(struct vadc_priv *vadc,
>  						  unsigned int num)
>  {
> +	struct device *dev = regmap_get_device(vadc->regmap);
>  	unsigned int i;
>  
>  	for (i = 0; i < vadc->nchannels; i++)
>  		if (vadc->chan_props[i].channel == num)
>  			return &vadc->chan_props[i];
>  
> -	dev_dbg(vadc->dev, "no such channel %02x\n", num);
> +	dev_dbg(dev, "no such channel %02x\n", num);
>  
>  	return NULL;
>  }
> @@ -364,6 +364,7 @@ static struct vadc_channel_prop *vadc_get_channel(struct vadc_priv *vadc,
>  static int vadc_do_conversion(struct vadc_priv *vadc,
>  			      struct vadc_channel_prop *prop, u16 *data)
>  {
> +	struct device *dev = regmap_get_device(vadc->regmap);
>  	unsigned int timeout;
>  	int ret;
>  
> @@ -406,7 +407,7 @@ static int vadc_do_conversion(struct vadc_priv *vadc,
>  err_disable:
>  	vadc_set_state(vadc, false);
>  	if (ret)
> -		dev_err(vadc->dev, "conversion failed\n");
> +		dev_err(dev, "conversion failed\n");
>  unlock:
>  	mutex_unlock(&vadc->lock);
>  	return ret;
> @@ -414,6 +415,7 @@ unlock:
>  
>  static int vadc_measure_ref_points(struct vadc_priv *vadc)
>  {
> +	struct device *dev = regmap_get_device(vadc->regmap);
>  	struct vadc_channel_prop *prop;
>  	u16 read_1, read_2;
>  	int ret;
> @@ -463,7 +465,7 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
>  	vadc->graph[VADC_CALIB_RATIOMETRIC].gnd = read_2;
>  err:
>  	if (ret)
> -		dev_err(vadc->dev, "measure reference points failed\n");
> +		dev_err(dev, "measure reference points failed\n");
>  
>  	return ret;
>  }
> @@ -814,6 +816,7 @@ static int vadc_get_dt_channel_data(struct device *dev,
>  
>  static int vadc_get_dt_data(struct vadc_priv *vadc, struct device_node *node)
>  {
> +	struct device *dev = regmap_get_device(vadc->regmap);
>  	const struct vadc_channels *vadc_chan;
>  	struct iio_chan_spec *iio_chan;
>  	struct vadc_channel_prop prop;
> @@ -825,12 +828,12 @@ static int vadc_get_dt_data(struct vadc_priv *vadc, struct device_node *node)
>  	if (!vadc->nchannels)
>  		return -EINVAL;
>  
> -	vadc->iio_chans = devm_kcalloc(vadc->dev, vadc->nchannels,
> +	vadc->iio_chans = devm_kcalloc(dev, vadc->nchannels,
>  				       sizeof(*vadc->iio_chans), GFP_KERNEL);
>  	if (!vadc->iio_chans)
>  		return -ENOMEM;
>  
> -	vadc->chan_props = devm_kcalloc(vadc->dev, vadc->nchannels,
> +	vadc->chan_props = devm_kcalloc(dev, vadc->nchannels,
>  					sizeof(*vadc->chan_props), GFP_KERNEL);
>  	if (!vadc->chan_props)
>  		return -ENOMEM;
> @@ -838,7 +841,7 @@ static int vadc_get_dt_data(struct vadc_priv *vadc, struct device_node *node)
>  	iio_chan = vadc->iio_chans;
>  
>  	for_each_available_child_of_node(node, child) {
> -		ret = vadc_get_dt_channel_data(vadc->dev, &prop, child);
> +		ret = vadc_get_dt_channel_data(dev, &prop, child);
>  		if (ret) {
>  			of_node_put(child);
>  			return ret;
> @@ -860,22 +863,22 @@ static int vadc_get_dt_data(struct vadc_priv *vadc, struct device_node *node)
>  
>  	/* These channels are mandatory, they are used as reference points */
>  	if (!vadc_get_channel(vadc, VADC_REF_1250MV)) {
> -		dev_err(vadc->dev, "Please define 1.25V channel\n");
> +		dev_err(dev, "Please define 1.25V channel\n");
>  		return -ENODEV;
>  	}
>  
>  	if (!vadc_get_channel(vadc, VADC_REF_625MV)) {
> -		dev_err(vadc->dev, "Please define 0.625V channel\n");
> +		dev_err(dev, "Please define 0.625V channel\n");
>  		return -ENODEV;
>  	}
>  
>  	if (!vadc_get_channel(vadc, VADC_VDD_VADC)) {
> -		dev_err(vadc->dev, "Please define VDD channel\n");
> +		dev_err(dev, "Please define VDD channel\n");
>  		return -ENODEV;
>  	}
>  
>  	if (!vadc_get_channel(vadc, VADC_GND_REF)) {
> -		dev_err(vadc->dev, "Please define GND channel\n");
> +		dev_err(dev, "Please define GND channel\n");
>  		return -ENODEV;
>  	}
>  
> @@ -893,6 +896,7 @@ static irqreturn_t vadc_isr(int irq, void *dev_id)
>  
>  static int vadc_check_revision(struct vadc_priv *vadc)
>  {
> +	struct device *dev = regmap_get_device(vadc->regmap);
>  	u8 val;
>  	int ret;
>  
> @@ -901,7 +905,7 @@ static int vadc_check_revision(struct vadc_priv *vadc)
>  		return ret;
>  
>  	if (val < VADC_PERPH_TYPE_ADC) {
> -		dev_err(vadc->dev, "%d is not ADC\n", val);
> +		dev_err(dev, "%d is not ADC\n", val);
>  		return -ENODEV;
>  	}
>  
> @@ -910,7 +914,7 @@ static int vadc_check_revision(struct vadc_priv *vadc)
>  		return ret;
>  
>  	if (val < VADC_PERPH_SUBTYPE_VADC) {
> -		dev_err(vadc->dev, "%d is not VADC\n", val);
> +		dev_err(dev, "%d is not VADC\n", val);
>  		return -ENODEV;
>  	}
>  
> @@ -919,7 +923,7 @@ static int vadc_check_revision(struct vadc_priv *vadc)
>  		return ret;
>  
>  	if (val < VADC_REVISION2_SUPPORTED_VADC) {
> -		dev_err(vadc->dev, "revision %d not supported\n", val);
> +		dev_err(dev, "revision %d not supported\n", val);
>  		return -ENODEV;
>  	}
>  
> @@ -950,7 +954,6 @@ static int vadc_probe(struct platform_device *pdev)
>  
>  	vadc = iio_priv(indio_dev);
>  	vadc->regmap = regmap;
> -	vadc->dev = dev;
>  	vadc->base = reg;
>  	vadc->are_ref_measured = false;
>  	init_completion(&vadc->complete);
> 

