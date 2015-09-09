Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:34590 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859AbbIIOjZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Sep 2015 10:39:25 -0400
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Markus Pargmann <mpa@pengutronix.de>,
	Jonathan Cameron <jic23@kernel.org>
CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Lars-Peter Clausen" <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v2 2/4] iio: bcm150: Remove i2c_client from private data
Date: Wed, 9 Sep 2015 14:39:16 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F0C838C@irsmsx105.ger.corp.intel.com>
References: <1440074986-28716-1-git-send-email-mpa@pengutronix.de>
 <1440074986-28716-3-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1440074986-28716-3-git-send-email-mpa@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Markus Pargmann [mailto:mpa@pengutronix.de]
> Sent: 20 August, 2015 15:50
> To: Jonathan Cameron
> Cc: Srinivas Pandruvada; Tirdea, Irina; Lars-Peter Clausen; linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org;
> kernel@pengutronix.de; Markus Pargmann
> Subject: [PATCH v2 2/4] iio: bcm150: Remove i2c_client from private data
> 
> i2c_client struct is now only used for debugging output. We can use the
> device struct as well so we can remove all struct i2c_client usage.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---

This patch also works (in my rebased version) .
I have tested the iio buffer code path and the i2c code path.

>  drivers/iio/accel/bmc150-accel.c | 120 +++++++++++++++++++--------------------
>  1 file changed, 58 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
> index c5c773e75173..e4a0691d9b88 100644
> --- a/drivers/iio/accel/bmc150-accel.c
> +++ b/drivers/iio/accel/bmc150-accel.c
> @@ -185,9 +185,9 @@ enum bmc150_accel_trigger_id {
>  };
> 
>  struct bmc150_accel_data {
> -	struct i2c_client *client;
>  	struct regmap *regmap;
>  	struct device *dev;
> +	int irq;
>  	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
>  	atomic_t active_intr;
>  	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
> @@ -276,11 +276,11 @@ static int bmc150_accel_set_mode(struct bmc150_accel_data *data,
>  	lpw_bits = mode << BMC150_ACCEL_PMU_MODE_SHIFT;
>  	lpw_bits |= (dur_val << BMC150_ACCEL_PMU_BIT_SLEEP_DUR_SHIFT);
> 
> -	dev_dbg(&data->client->dev, "Set Mode bits %x\n", lpw_bits);
> +	dev_dbg(data->dev, "Set Mode bits %x\n", lpw_bits);
> 
>  	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_PMU_LPW, lpw_bits);
>  	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error writing reg_pmu_lpw\n");
> +		dev_err(data->dev, "Error writing reg_pmu_lpw\n");
>  		return ret;
>  	}
> 
> @@ -318,18 +318,18 @@ static int bmc150_accel_update_slope(struct bmc150_accel_data *data)
>  	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_INT_6,
>  					data->slope_thres);
>  	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error writing reg_int_6\n");
> +		dev_err(data->dev, "Error writing reg_int_6\n");
>  		return ret;
>  	}
> 
>  	ret = regmap_update_bits(data->regmap, BMC150_ACCEL_REG_INT_5,
>  				 BMC150_ACCEL_SLOPE_DUR_MASK, data->slope_dur);
>  	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error updating reg_int_5\n");
> +		dev_err(data->dev, "Error updating reg_int_5\n");
>  		return ret;
>  	}
> 
> -	dev_dbg(&data->client->dev, "%s: %x %x\n", __func__, data->slope_thres,
> +	dev_dbg(data->dev, "%s: %x %x\n", __func__, data->slope_thres,
>  		data->slope_dur);
> 
>  	return ret;
> @@ -351,14 +351,14 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
> 
>  	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_CHIP_ID, &val);
>  	if (ret < 0) {
> -		dev_err(&data->client->dev,
> +		dev_err(data->dev,
>  			"Error: Reading chip id\n");
>  		return ret;
>  	}
> 
> -	dev_dbg(&data->client->dev, "Chip Id %x\n", val);
> +	dev_dbg(data->dev, "Chip Id %x\n", val);
>  	if (val != data->chip_info->chip_id) {
> -		dev_err(&data->client->dev, "Invalid chip %x\n", val);
> +		dev_err(data->dev, "Invalid chip %x\n", val);
>  		return -ENODEV;
>  	}
> 
> @@ -375,8 +375,7 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
>  	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_PMU_RANGE,
>  			   BMC150_ACCEL_DEF_RANGE_4G);
>  	if (ret < 0) {
> -		dev_err(&data->client->dev,
> -					"Error writing reg_pmu_range\n");
> +		dev_err(data->dev, "Error writing reg_pmu_range\n");
>  		return ret;
>  	}
> 
> @@ -394,7 +393,7 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
>  			   BMC150_ACCEL_INT_MODE_LATCH_INT |
>  			   BMC150_ACCEL_INT_MODE_LATCH_RESET);
>  	if (ret < 0) {
> -		dev_err(&data->client->dev,
> +		dev_err(data->dev,
>  			"Error writing reg_int_rst_latch\n");
>  		return ret;
>  	}
> @@ -436,16 +435,16 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
>  	int ret;
> 
>  	if (on)
> -		ret = pm_runtime_get_sync(&data->client->dev);
> +		ret = pm_runtime_get_sync(data->dev);
>  	else {
> -		pm_runtime_mark_last_busy(&data->client->dev);
> -		ret = pm_runtime_put_autosuspend(&data->client->dev);
> +		pm_runtime_mark_last_busy(data->dev);
> +		ret = pm_runtime_put_autosuspend(data->dev);
>  	}
>  	if (ret < 0) {
> -		dev_err(&data->client->dev,
> +		dev_err(data->dev,
>  			"Failed: bmc150_accel_set_power_state for %d\n", on);
>  		if (on)
> -			pm_runtime_put_noidle(&data->client->dev);
> +			pm_runtime_put_noidle(data->dev);
> 
>  		return ret;
>  	}
> @@ -528,7 +527,7 @@ static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data, int i,
>  	ret = regmap_update_bits(data->regmap, info->map_reg, info->map_bitmask,
>  				 (state ? info->map_bitmask : 0));
>  	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error updating reg_int_map\n");
> +		dev_err(data->dev, "Error updating reg_int_map\n");
>  		goto out_fix_power_state;
>  	}
> 
> @@ -536,7 +535,7 @@ static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data, int i,
>  	ret = regmap_update_bits(data->regmap, info->en_reg, info->en_bitmask,
>  				 (state ? info->en_bitmask : 0));
>  	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error updating reg_int_en\n");
> +		dev_err(data->dev, "Error updating reg_int_en\n");
>  		goto out_fix_power_state;
>  	}
> 
> @@ -563,7 +562,7 @@ static int bmc150_accel_set_scale(struct bmc150_accel_data *data, int val)
>  				     BMC150_ACCEL_REG_PMU_RANGE,
>  				     data->chip_info->scale_table[i].reg_range);
>  			if (ret < 0) {
> -				dev_err(&data->client->dev,
> +				dev_err(data->dev,
>  					"Error writing pmu_range\n");
>  				return ret;
>  			}
> @@ -585,7 +584,7 @@ static int bmc150_accel_get_temp(struct bmc150_accel_data *data, int *val)
> 
>  	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_TEMP, &value);
>  	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error reading reg_temp\n");
> +		dev_err(data->dev, "Error reading reg_temp\n");
>  		mutex_unlock(&data->mutex);
>  		return ret;
>  	}
> @@ -614,7 +613,7 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
>  	ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_AXIS_TO_REG(axis),
>  			       &raw_val, 2);
>  	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error reading axis %d\n", axis);
> +		dev_err(data->dev, "Error reading axis %d\n", axis);
>  		bmc150_accel_set_power_state(data, false);
>  		mutex_unlock(&data->mutex);
>  		return ret;
> @@ -928,7 +927,7 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
> 
>  	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_FIFO_STATUS, &val);
>  	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error reading reg_fifo_status\n");
> +		dev_err(data->dev, "Error reading reg_fifo_status\n");
>  		return ret;
>  	}
> 
> @@ -1209,7 +1208,7 @@ static int bmc150_accel_trig_try_reen(struct iio_trigger *trig)
>  			   BMC150_ACCEL_INT_MODE_LATCH_RESET);
>  	mutex_unlock(&data->mutex);
>  	if (ret < 0) {
> -		dev_err(&data->client->dev,
> +		dev_err(data->dev,
>  			"Error writing reg_int_rst_latch\n");
>  		return ret;
>  	}
> @@ -1267,7 +1266,7 @@ static int bmc150_accel_handle_roc_event(struct iio_dev *indio_dev)
> 
>  	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_INT_STATUS_2, &val);
>  	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error reading reg_int_status_2\n");
> +		dev_err(data->dev, "Error reading reg_int_status_2\n");
>  		return ret;
>  	}
> 
> @@ -1327,7 +1326,7 @@ static irqreturn_t bmc150_accel_irq_thread_handler(int irq, void *private)
>  				   BMC150_ACCEL_INT_MODE_LATCH_INT |
>  				   BMC150_ACCEL_INT_MODE_LATCH_RESET);
>  		if (ret)
> -			dev_err(&data->client->dev, "Error writing reg_int_rst_latch\n");
> +			dev_err(data->dev, "Error writing reg_int_rst_latch\n");
>  		ret = IRQ_HANDLED;
>  	} else {
>  		ret = IRQ_NONE;
> @@ -1379,17 +1378,13 @@ static const char *bmc150_accel_match_acpi_device(struct device *dev, int *data)
>  	return dev_name(dev);
>  }
> 
> -static int bmc150_accel_gpio_probe(struct i2c_client *client,
> -					struct bmc150_accel_data *data)
> +static int bmc150_accel_gpio_probe(struct bmc150_accel_data *data)
>  {
>  	struct device *dev;
>  	struct gpio_desc *gpio;
>  	int ret;
> 
> -	if (!client)
> -		return -EINVAL;
> -
> -	dev = &client->dev;
> +	dev = data->dev;
> 
>  	/* data ready gpio interrupt pin */
>  	gpio = devm_gpiod_get_index(dev, BMC150_ACCEL_GPIO_NAME, 0, GPIOD_IN);
> @@ -1442,7 +1437,7 @@ static int bmc150_accel_triggers_setup(struct iio_dev *indio_dev,
>  	for (i = 0; i < BMC150_ACCEL_TRIGGERS; i++) {
>  		struct bmc150_accel_trigger *t = &data->triggers[i];
> 
> -		t->indio_trig = devm_iio_trigger_alloc(&data->client->dev,
> +		t->indio_trig = devm_iio_trigger_alloc(data->dev,
>  					       bmc150_accel_triggers[i].name,
>  						       indio_dev->name,
>  						       indio_dev->id);
> @@ -1451,7 +1446,7 @@ static int bmc150_accel_triggers_setup(struct iio_dev *indio_dev,
>  			break;
>  		}
> 
> -		t->indio_trig->dev.parent = &data->client->dev;
> +		t->indio_trig->dev.parent = data->dev;
>  		t->indio_trig->ops = &bmc150_accel_trigger_ops;
>  		t->intr = bmc150_accel_triggers[i].intr;
>  		t->data = data;
> @@ -1480,7 +1475,7 @@ static int bmc150_accel_fifo_set_mode(struct bmc150_accel_data *data)
> 
>  	ret = regmap_write(data->regmap, reg, data->fifo_mode);
>  	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error writing reg_fifo_config1\n");
> +		dev_err(data->dev, "Error writing reg_fifo_config1\n");
>  		return ret;
>  	}
> 
> @@ -1490,7 +1485,7 @@ static int bmc150_accel_fifo_set_mode(struct bmc150_accel_data *data)
>  	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_FIFO_CONFIG0,
>  			   data->watermark);
>  	if (ret < 0)
> -		dev_err(&data->client->dev, "Error writing reg_fifo_config0\n");
> +		dev_err(data->dev, "Error writing reg_fifo_config0\n");
> 
>  	return ret;
>  }
> @@ -1580,6 +1575,7 @@ static int bmc150_accel_probe(struct i2c_client *client,
>  	int ret;
>  	const char *name = NULL;
>  	int chip_id = 0;
> +	struct device *dev;
> 
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
> @@ -1587,12 +1583,13 @@ static int bmc150_accel_probe(struct i2c_client *client,
> 
>  	data = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
> -	data->client = client;
>  	data->dev = &client->dev;
> +	dev = &client->dev;
> +	data->irq = client->irq;
> 
>  	data->regmap = devm_regmap_init_i2c(client, &bmc150_i2c_regmap_conf);
>  	if (IS_ERR(data->regmap)) {
> -		dev_err(&client->dev, "Failed to initialize i2c regmap\n");
> +		dev_err(dev, "Failed to initialize i2c regmap\n");
>  		return PTR_ERR(data->regmap);
>  	}
> 
> @@ -1601,8 +1598,8 @@ static int bmc150_accel_probe(struct i2c_client *client,
>  		chip_id = id->driver_data;
>  	}
> 
> -	if (ACPI_HANDLE(&client->dev))
> -		name = bmc150_accel_match_acpi_device(&client->dev, &chip_id);
> +	if (ACPI_HANDLE(dev))
> +		name = bmc150_accel_match_acpi_device(dev, &chip_id);
> 
>  	data->chip_info = &bmc150_accel_chip_info_tbl[chip_id];
> 
> @@ -1612,7 +1609,7 @@ static int bmc150_accel_probe(struct i2c_client *client,
> 
>  	mutex_init(&data->mutex);
> 
> -	indio_dev->dev.parent = &client->dev;
> +	indio_dev->dev.parent = dev;
>  	indio_dev->channels = data->chip_info->channels;
>  	indio_dev->num_channels = data->chip_info->num_channels;
>  	indio_dev->name = name;
> @@ -1624,16 +1621,16 @@ static int bmc150_accel_probe(struct i2c_client *client,
>  					 bmc150_accel_trigger_handler,
>  					 &bmc150_accel_buffer_ops);
>  	if (ret < 0) {
> -		dev_err(&client->dev, "Failed: iio triggered buffer setup\n");
> +		dev_err(data->dev, "Failed: iio triggered buffer setup\n");
>  		return ret;
>  	}
> 
> -	if (client->irq < 0)
> -		client->irq = bmc150_accel_gpio_probe(client, data);
> +	if (data->irq <= 0)
> +		data->irq = bmc150_accel_gpio_probe(data);
> 
> -	if (client->irq > 0) {
> +	if (data->irq > 0) {
>  		ret = devm_request_threaded_irq(
> -						&client->dev, client->irq,
> +						data->dev, data->irq,
>  						bmc150_accel_irq_handler,
>  						bmc150_accel_irq_thread_handler,
>  						IRQF_TRIGGER_RISING,
> @@ -1651,7 +1648,7 @@ static int bmc150_accel_probe(struct i2c_client *client,
>  		ret = regmap_write(data->regmap, BMC150_ACCEL_REG_INT_RST_LATCH,
>  				   BMC150_ACCEL_INT_MODE_LATCH_RESET);
>  		if (ret < 0) {
> -			dev_err(&data->client->dev, "Error writing reg_int_rst_latch\n");
> +			dev_err(data->dev, "Error writing reg_int_rst_latch\n");
>  			goto err_buffer_cleanup;
>  		}
> 
> @@ -1672,18 +1669,17 @@ static int bmc150_accel_probe(struct i2c_client *client,
> 
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
> -		dev_err(&client->dev, "Unable to register iio device\n");
> +		dev_err(data->dev, "Unable to register iio device\n");
>  		goto err_trigger_unregister;
>  	}
> 
> -	ret = pm_runtime_set_active(&client->dev);
> +	ret = pm_runtime_set_active(dev);
>  	if (ret)
>  		goto err_iio_unregister;
> 
> -	pm_runtime_enable(&client->dev);
> -	pm_runtime_set_autosuspend_delay(&client->dev,
> -					 BMC150_AUTO_SUSPEND_DELAY_MS);
> -	pm_runtime_use_autosuspend(&client->dev);
> +	pm_runtime_enable(dev);
> +	pm_runtime_set_autosuspend_delay(dev, BMC150_AUTO_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> 
>  	return 0;
> 
> @@ -1702,9 +1698,9 @@ static int bmc150_accel_remove(struct i2c_client *client)
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
> 
> -	pm_runtime_disable(&client->dev);
> -	pm_runtime_set_suspended(&client->dev);
> -	pm_runtime_put_noidle(&client->dev);
> +	pm_runtime_disable(data->dev);
> +	pm_runtime_set_suspended(data->dev);
> +	pm_runtime_put_noidle(data->dev);
> 
>  	iio_device_unregister(indio_dev);
> 
> @@ -1722,7 +1718,7 @@ static int bmc150_accel_remove(struct i2c_client *client)
>  #ifdef CONFIG_PM_SLEEP
>  static int bmc150_accel_suspend(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
> 
>  	mutex_lock(&data->mutex);
> @@ -1734,7 +1730,7 @@ static int bmc150_accel_suspend(struct device *dev)
> 
>  static int bmc150_accel_resume(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
> 
>  	mutex_lock(&data->mutex);
> @@ -1750,11 +1746,11 @@ static int bmc150_accel_resume(struct device *dev)
>  #ifdef CONFIG_PM
>  static int bmc150_accel_runtime_suspend(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
>  	int ret;
> 
> -	dev_dbg(&data->client->dev,  __func__);
> +	dev_dbg(data->dev,  __func__);
>  	ret = bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_SUSPEND, 0);
>  	if (ret < 0)
>  		return -EAGAIN;
> @@ -1764,12 +1760,12 @@ static int bmc150_accel_runtime_suspend(struct device *dev)
> 
>  static int bmc150_accel_runtime_resume(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
>  	int ret;
>  	int sleep_val;
> 
> -	dev_dbg(&data->client->dev,  __func__);
> +	dev_dbg(data->dev,  __func__);
> 
>  	ret = bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_NORMAL, 0);
>  	if (ret < 0)
> --
> 2.4.6

