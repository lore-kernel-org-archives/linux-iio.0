Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49644 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbcDPTWn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Apr 2016 15:22:43 -0400
Subject: Re: [PATCH v2 4/5] iio: health: afe4404: use regmap to retrieve
 struct device
To: Alison Schofield <amsfield22@gmail.com>
References: <cover.1460314070.git.amsfield22@gmail.com>
 <2dd23e55fa7c2d16c577146eefd4a84046d2b838.1460314070.git.amsfield22@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	kgene@kernel.org, k.kozlowski@samsung.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <57129101.7000503@kernel.org>
Date: Sat, 16 Apr 2016 20:22:41 +0100
MIME-Version: 1.0
In-Reply-To: <2dd23e55fa7c2d16c577146eefd4a84046d2b838.1460314070.git.amsfield22@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/04/16 20:07, Alison Schofield wrote:
> Driver includes struct regmap and struct device in its global data.
> Remove the struct device and use regmap API to retrieve device info.
> 
> Patch created using Coccinelle plus manual edits.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Cc'd Andrew
> ---
>  drivers/iio/health/afe4404.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
> index 5096a46..9cd8590 100644
> --- a/drivers/iio/health/afe4404.c
> +++ b/drivers/iio/health/afe4404.c
> @@ -107,14 +107,12 @@
>  
>  /**
>   * struct afe4404_data
> - * @dev - Device structure
>   * @regmap - Register map of the device
>   * @regulator - Pointer to the regulator for the IC
>   * @trig - IIO trigger for this device
>   * @irq - ADC_RDY line interrupt number
>   */
>  struct afe4404_data {
> -	struct device *dev;
>  	struct regmap *regmap;
>  	struct regulator *regulator;
>  	struct iio_trigger *trig;
> @@ -534,54 +532,54 @@ static int afe4404_probe(struct i2c_client *client,
>  	afe = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
>  
> -	afe->dev = &client->dev;
>  	afe->irq = client->irq;
>  
>  	afe->regmap = devm_regmap_init_i2c(client, &afe4404_regmap_config);
>  	if (IS_ERR(afe->regmap)) {
> -		dev_err(afe->dev, "Unable to allocate register map\n");
> +		dev_err(&client->dev, "Unable to allocate register map\n");
>  		return PTR_ERR(afe->regmap);
>  	}
>  
> -	afe->regulator = devm_regulator_get(afe->dev, "tx_sup");
> +	afe->regulator = devm_regulator_get(&client->dev, "tx_sup");
>  	if (IS_ERR(afe->regulator)) {
> -		dev_err(afe->dev, "Unable to get regulator\n");
> +		dev_err(&client->dev, "Unable to get regulator\n");
>  		return PTR_ERR(afe->regulator);
>  	}
>  	ret = regulator_enable(afe->regulator);
>  	if (ret) {
> -		dev_err(afe->dev, "Unable to enable regulator\n");
> +		dev_err(&client->dev, "Unable to enable regulator\n");
>  		return ret;
>  	}
>  
>  	ret = regmap_write(afe->regmap, AFE440X_CONTROL0,
>  			   AFE440X_CONTROL0_SW_RESET);
>  	if (ret) {
> -		dev_err(afe->dev, "Unable to reset device\n");
> +		dev_err(&client->dev, "Unable to reset device\n");
>  		goto disable_reg;
>  	}
>  
>  	ret = regmap_multi_reg_write(afe->regmap, afe4404_reg_sequences,
>  				     ARRAY_SIZE(afe4404_reg_sequences));
>  	if (ret) {
> -		dev_err(afe->dev, "Unable to set register defaults\n");
> +		dev_err(&client->dev, "Unable to set register defaults\n");
>  		goto disable_reg;
>  	}
>  
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->dev.parent = afe->dev;
> +	indio_dev->dev.parent = &client->dev;
>  	indio_dev->channels = afe4404_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(afe4404_channels);
>  	indio_dev->name = AFE4404_DRIVER_NAME;
>  	indio_dev->info = &afe4404_iio_info;
>  
>  	if (afe->irq > 0) {
> -		afe->trig = devm_iio_trigger_alloc(afe->dev,
> +		afe->trig = devm_iio_trigger_alloc(&client->dev,
>  						   "%s-dev%d",
>  						   indio_dev->name,
>  						   indio_dev->id);
>  		if (!afe->trig) {
> -			dev_err(afe->dev, "Unable to allocate IIO trigger\n");
> +			dev_err(&client->dev,
> +				"Unable to allocate IIO trigger\n");
>  			ret = -ENOMEM;
>  			goto disable_reg;
>  		}
> @@ -589,21 +587,22 @@ static int afe4404_probe(struct i2c_client *client,
>  		iio_trigger_set_drvdata(afe->trig, indio_dev);
>  
>  		afe->trig->ops = &afe4404_trigger_ops;
> -		afe->trig->dev.parent = afe->dev;
> +		afe->trig->dev.parent = &client->dev;
>  
>  		ret = iio_trigger_register(afe->trig);
>  		if (ret) {
> -			dev_err(afe->dev, "Unable to register IIO trigger\n");
> +			dev_err(&client->dev,
> +				"Unable to register IIO trigger\n");
>  			goto disable_reg;
>  		}
>  
> -		ret = devm_request_threaded_irq(afe->dev, afe->irq,
> +		ret = devm_request_threaded_irq(&client->dev, afe->irq,
>  						iio_trigger_generic_data_rdy_poll,
>  						NULL, IRQF_ONESHOT,
>  						AFE4404_DRIVER_NAME,
>  						afe->trig);
>  		if (ret) {
> -			dev_err(afe->dev, "Unable to request IRQ\n");
> +			dev_err(&client->dev, "Unable to request IRQ\n");
>  			goto disable_reg;
>  		}
>  	}
> @@ -611,13 +610,13 @@ static int afe4404_probe(struct i2c_client *client,
>  	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
>  					 afe4404_trigger_handler, NULL);
>  	if (ret) {
> -		dev_err(afe->dev, "Unable to setup buffer\n");
> +		dev_err(&client->dev, "Unable to setup buffer\n");
>  		goto unregister_trigger;
>  	}
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret) {
> -		dev_err(afe->dev, "Unable to register IIO device\n");
> +		dev_err(&client->dev, "Unable to register IIO device\n");
>  		goto unregister_triggered_buffer;
>  	}
>  
> @@ -638,6 +637,7 @@ static int afe4404_remove(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  	struct afe4404_data *afe = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(afe->regmap);
>  	int ret;
>  
>  	iio_device_unregister(indio_dev);
> @@ -649,7 +649,7 @@ static int afe4404_remove(struct i2c_client *client)
>  
>  	ret = regulator_disable(afe->regulator);
>  	if (ret) {
> -		dev_err(afe->dev, "Unable to disable regulator\n");
> +		dev_err(dev, "Unable to disable regulator\n");
>  		return ret;
>  	}
>  
> 

