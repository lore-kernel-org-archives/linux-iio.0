Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49613 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbcDPTUK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Apr 2016 15:20:10 -0400
Subject: Re: [PATCH v2 1/5] iio: accel: bmc150: use regmap to retrieve struct
 device
To: Alison Schofield <amsfield22@gmail.com>
References: <cover.1460314070.git.amsfield22@gmail.com>
 <f3cae5dd803486a774248afad096032f3f0546a2.1460314070.git.amsfield22@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	kgene@kernel.org, k.kozlowski@samsung.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <57129064.9050508@kernel.org>
Date: Sat, 16 Apr 2016 20:20:04 +0100
MIME-Version: 1.0
In-Reply-To: <f3cae5dd803486a774248afad096032f3f0546a2.1460314070.git.amsfield22@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/04/16 20:05, Alison Schofield wrote:
> Driver includes struct regmap and struct device in its global data.
> Remove the struct device and use regmap API to retrieve device info.
> 
> Patch created using Coccinelle plus manual edits.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
I'm happy with this but please do make sure to cc the maintainer / author
of drivers if possible (often the email addresses are out of date!)

Srinivas, this is one of yours.  Are you happy with this?
I've also cc'd Irina who has worked on this driver recently for any
comments.

If no one comments in the meantime I'll probably pick these up sometime
in the next week.

Jonathan
> ---
>  drivers/iio/accel/bmc150-accel-core.c | 99 +++++++++++++++++++----------------
>  1 file changed, 54 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index f3d096f..ad5310b 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -188,7 +188,6 @@ enum bmc150_accel_trigger_id {
>  
>  struct bmc150_accel_data {
>  	struct regmap *regmap;
> -	struct device *dev;
>  	int irq;
>  	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
>  	atomic_t active_intr;
> @@ -256,6 +255,7 @@ static int bmc150_accel_set_mode(struct bmc150_accel_data *data,
>  				 enum bmc150_power_modes mode,
>  				 int dur_us)
>  {
> +	struct device *dev = regmap_get_device(data->regmap);
>  	int i;
>  	int ret;
>  	u8 lpw_bits;
> @@ -279,11 +279,11 @@ static int bmc150_accel_set_mode(struct bmc150_accel_data *data,
>  	lpw_bits = mode << BMC150_ACCEL_PMU_MODE_SHIFT;
>  	lpw_bits |= (dur_val << BMC150_ACCEL_PMU_BIT_SLEEP_DUR_SHIFT);
>  
> -	dev_dbg(data->dev, "Set Mode bits %x\n", lpw_bits);
> +	dev_dbg(dev, "Set Mode bits %x\n", lpw_bits);
>  
>  	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_PMU_LPW, lpw_bits);
>  	if (ret < 0) {
> -		dev_err(data->dev, "Error writing reg_pmu_lpw\n");
> +		dev_err(dev, "Error writing reg_pmu_lpw\n");
>  		return ret;
>  	}
>  
> @@ -316,23 +316,24 @@ static int bmc150_accel_set_bw(struct bmc150_accel_data *data, int val,
>  
>  static int bmc150_accel_update_slope(struct bmc150_accel_data *data)
>  {
> +	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
>  
>  	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_INT_6,
>  					data->slope_thres);
>  	if (ret < 0) {
> -		dev_err(data->dev, "Error writing reg_int_6\n");
> +		dev_err(dev, "Error writing reg_int_6\n");
>  		return ret;
>  	}
>  
>  	ret = regmap_update_bits(data->regmap, BMC150_ACCEL_REG_INT_5,
>  				 BMC150_ACCEL_SLOPE_DUR_MASK, data->slope_dur);
>  	if (ret < 0) {
> -		dev_err(data->dev, "Error updating reg_int_5\n");
> +		dev_err(dev, "Error updating reg_int_5\n");
>  		return ret;
>  	}
>  
> -	dev_dbg(data->dev, "%s: %x %x\n", __func__, data->slope_thres,
> +	dev_dbg(dev, "%s: %x %x\n", __func__, data->slope_thres,
>  		data->slope_dur);
>  
>  	return ret;
> @@ -378,20 +379,21 @@ static int bmc150_accel_get_startup_times(struct bmc150_accel_data *data)
>  
>  static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
>  {
> +	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
>  
>  	if (on) {
> -		ret = pm_runtime_get_sync(data->dev);
> +		ret = pm_runtime_get_sync(dev);
>  	} else {
> -		pm_runtime_mark_last_busy(data->dev);
> -		ret = pm_runtime_put_autosuspend(data->dev);
> +		pm_runtime_mark_last_busy(dev);
> +		ret = pm_runtime_put_autosuspend(dev);
>  	}
>  
>  	if (ret < 0) {
> -		dev_err(data->dev,
> +		dev_err(dev,
>  			"Failed: bmc150_accel_set_power_state for %d\n", on);
>  		if (on)
> -			pm_runtime_put_noidle(data->dev);
> +			pm_runtime_put_noidle(dev);
>  
>  		return ret;
>  	}
> @@ -445,6 +447,7 @@ static void bmc150_accel_interrupts_setup(struct iio_dev *indio_dev,
>  static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data, int i,
>  				      bool state)
>  {
> +	struct device *dev = regmap_get_device(data->regmap);
>  	struct bmc150_accel_interrupt *intr = &data->interrupts[i];
>  	const struct bmc150_accel_interrupt_info *info = intr->info;
>  	int ret;
> @@ -474,7 +477,7 @@ static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data, int i,
>  	ret = regmap_update_bits(data->regmap, info->map_reg, info->map_bitmask,
>  				 (state ? info->map_bitmask : 0));
>  	if (ret < 0) {
> -		dev_err(data->dev, "Error updating reg_int_map\n");
> +		dev_err(dev, "Error updating reg_int_map\n");
>  		goto out_fix_power_state;
>  	}
>  
> @@ -482,7 +485,7 @@ static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data, int i,
>  	ret = regmap_update_bits(data->regmap, info->en_reg, info->en_bitmask,
>  				 (state ? info->en_bitmask : 0));
>  	if (ret < 0) {
> -		dev_err(data->dev, "Error updating reg_int_en\n");
> +		dev_err(dev, "Error updating reg_int_en\n");
>  		goto out_fix_power_state;
>  	}
>  
> @@ -500,6 +503,7 @@ out_fix_power_state:
>  
>  static int bmc150_accel_set_scale(struct bmc150_accel_data *data, int val)
>  {
> +	struct device *dev = regmap_get_device(data->regmap);
>  	int ret, i;
>  
>  	for (i = 0; i < ARRAY_SIZE(data->chip_info->scale_table); ++i) {
> @@ -508,8 +512,7 @@ static int bmc150_accel_set_scale(struct bmc150_accel_data *data, int val)
>  				     BMC150_ACCEL_REG_PMU_RANGE,
>  				     data->chip_info->scale_table[i].reg_range);
>  			if (ret < 0) {
> -				dev_err(data->dev,
> -					"Error writing pmu_range\n");
> +				dev_err(dev, "Error writing pmu_range\n");
>  				return ret;
>  			}
>  
> @@ -523,6 +526,7 @@ static int bmc150_accel_set_scale(struct bmc150_accel_data *data, int val)
>  
>  static int bmc150_accel_get_temp(struct bmc150_accel_data *data, int *val)
>  {
> +	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
>  	unsigned int value;
>  
> @@ -530,7 +534,7 @@ static int bmc150_accel_get_temp(struct bmc150_accel_data *data, int *val)
>  
>  	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_TEMP, &value);
>  	if (ret < 0) {
> -		dev_err(data->dev, "Error reading reg_temp\n");
> +		dev_err(dev, "Error reading reg_temp\n");
>  		mutex_unlock(&data->mutex);
>  		return ret;
>  	}
> @@ -545,6 +549,7 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
>  				 struct iio_chan_spec const *chan,
>  				 int *val)
>  {
> +	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
>  	int axis = chan->scan_index;
>  	unsigned int raw_val;
> @@ -559,7 +564,7 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
>  	ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_AXIS_TO_REG(axis),
>  			       &raw_val, 2);
>  	if (ret < 0) {
> -		dev_err(data->dev, "Error reading axis %d\n", axis);
> +		dev_err(dev, "Error reading axis %d\n", axis);
>  		bmc150_accel_set_power_state(data, false);
>  		mutex_unlock(&data->mutex);
>  		return ret;
> @@ -831,6 +836,7 @@ static int bmc150_accel_set_watermark(struct iio_dev *indio_dev, unsigned val)
>  static int bmc150_accel_fifo_transfer(struct bmc150_accel_data *data,
>  				      char *buffer, int samples)
>  {
> +	struct device *dev = regmap_get_device(data->regmap);
>  	int sample_length = 3 * 2;
>  	int ret;
>  	int total_length = samples * sample_length;
> @@ -854,7 +860,8 @@ static int bmc150_accel_fifo_transfer(struct bmc150_accel_data *data,
>  	}
>  
>  	if (ret)
> -		dev_err(data->dev, "Error transferring data from fifo in single steps of %zu\n",
> +		dev_err(dev,
> +			"Error transferring data from fifo in single steps of %zu\n",
>  			step);
>  
>  	return ret;
> @@ -864,6 +871,7 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
>  				     unsigned samples, bool irq)
>  {
>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(data->regmap);
>  	int ret, i;
>  	u8 count;
>  	u16 buffer[BMC150_ACCEL_FIFO_LENGTH * 3];
> @@ -873,7 +881,7 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
>  
>  	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_FIFO_STATUS, &val);
>  	if (ret < 0) {
> -		dev_err(data->dev, "Error reading reg_fifo_status\n");
> +		dev_err(dev, "Error reading reg_fifo_status\n");
>  		return ret;
>  	}
>  
> @@ -1135,6 +1143,7 @@ static int bmc150_accel_trig_try_reen(struct iio_trigger *trig)
>  {
>  	struct bmc150_accel_trigger *t = iio_trigger_get_drvdata(trig);
>  	struct bmc150_accel_data *data = t->data;
> +	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
>  
>  	/* new data interrupts don't need ack */
> @@ -1148,8 +1157,7 @@ static int bmc150_accel_trig_try_reen(struct iio_trigger *trig)
>  			   BMC150_ACCEL_INT_MODE_LATCH_RESET);
>  	mutex_unlock(&data->mutex);
>  	if (ret < 0) {
> -		dev_err(data->dev,
> -			"Error writing reg_int_rst_latch\n");
> +		dev_err(dev, "Error writing reg_int_rst_latch\n");
>  		return ret;
>  	}
>  
> @@ -1200,13 +1208,14 @@ static const struct iio_trigger_ops bmc150_accel_trigger_ops = {
>  static int bmc150_accel_handle_roc_event(struct iio_dev *indio_dev)
>  {
>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(data->regmap);
>  	int dir;
>  	int ret;
>  	unsigned int val;
>  
>  	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_INT_STATUS_2, &val);
>  	if (ret < 0) {
> -		dev_err(data->dev, "Error reading reg_int_status_2\n");
> +		dev_err(dev, "Error reading reg_int_status_2\n");
>  		return ret;
>  	}
>  
> @@ -1249,6 +1258,7 @@ static irqreturn_t bmc150_accel_irq_thread_handler(int irq, void *private)
>  {
>  	struct iio_dev *indio_dev = private;
>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(data->regmap);
>  	bool ack = false;
>  	int ret;
>  
> @@ -1272,7 +1282,7 @@ static irqreturn_t bmc150_accel_irq_thread_handler(int irq, void *private)
>  				   BMC150_ACCEL_INT_MODE_LATCH_INT |
>  				   BMC150_ACCEL_INT_MODE_LATCH_RESET);
>  		if (ret)
> -			dev_err(data->dev, "Error writing reg_int_rst_latch\n");
> +			dev_err(dev, "Error writing reg_int_rst_latch\n");
>  
>  		ret = IRQ_HANDLED;
>  	} else {
> @@ -1343,13 +1353,14 @@ static void bmc150_accel_unregister_triggers(struct bmc150_accel_data *data,
>  static int bmc150_accel_triggers_setup(struct iio_dev *indio_dev,
>  				       struct bmc150_accel_data *data)
>  {
> +	struct device *dev = regmap_get_device(data->regmap);
>  	int i, ret;
>  
>  	for (i = 0; i < BMC150_ACCEL_TRIGGERS; i++) {
>  		struct bmc150_accel_trigger *t = &data->triggers[i];
>  
> -		t->indio_trig = devm_iio_trigger_alloc(data->dev,
> -					       bmc150_accel_triggers[i].name,
> +		t->indio_trig = devm_iio_trigger_alloc(dev,
> +					bmc150_accel_triggers[i].name,
>  						       indio_dev->name,
>  						       indio_dev->id);
>  		if (!t->indio_trig) {
> @@ -1357,7 +1368,7 @@ static int bmc150_accel_triggers_setup(struct iio_dev *indio_dev,
>  			break;
>  		}
>  
> -		t->indio_trig->dev.parent = data->dev;
> +		t->indio_trig->dev.parent = dev;
>  		t->indio_trig->ops = &bmc150_accel_trigger_ops;
>  		t->intr = bmc150_accel_triggers[i].intr;
>  		t->data = data;
> @@ -1381,12 +1392,13 @@ static int bmc150_accel_triggers_setup(struct iio_dev *indio_dev,
>  
>  static int bmc150_accel_fifo_set_mode(struct bmc150_accel_data *data)
>  {
> +	struct device *dev = regmap_get_device(data->regmap);
>  	u8 reg = BMC150_ACCEL_REG_FIFO_CONFIG1;
>  	int ret;
>  
>  	ret = regmap_write(data->regmap, reg, data->fifo_mode);
>  	if (ret < 0) {
> -		dev_err(data->dev, "Error writing reg_fifo_config1\n");
> +		dev_err(dev, "Error writing reg_fifo_config1\n");
>  		return ret;
>  	}
>  
> @@ -1396,7 +1408,7 @@ static int bmc150_accel_fifo_set_mode(struct bmc150_accel_data *data)
>  	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_FIFO_CONFIG0,
>  			   data->watermark);
>  	if (ret < 0)
> -		dev_err(data->dev, "Error writing reg_fifo_config0\n");
> +		dev_err(dev, "Error writing reg_fifo_config0\n");
>  
>  	return ret;
>  }
> @@ -1480,17 +1492,17 @@ static const struct iio_buffer_setup_ops bmc150_accel_buffer_ops = {
>  
>  static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
>  {
> +	struct device *dev = regmap_get_device(data->regmap);
>  	int ret, i;
>  	unsigned int val;
>  
>  	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_CHIP_ID, &val);
>  	if (ret < 0) {
> -		dev_err(data->dev,
> -			"Error: Reading chip id\n");
> +		dev_err(dev, "Error: Reading chip id\n");
>  		return ret;
>  	}
>  
> -	dev_dbg(data->dev, "Chip Id %x\n", val);
> +	dev_dbg(dev, "Chip Id %x\n", val);
>  	for (i = 0; i < ARRAY_SIZE(bmc150_accel_chip_info_tbl); i++) {
>  		if (bmc150_accel_chip_info_tbl[i].chip_id == val) {
>  			data->chip_info = &bmc150_accel_chip_info_tbl[i];
> @@ -1499,7 +1511,7 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
>  	}
>  
>  	if (!data->chip_info) {
> -		dev_err(data->dev, "Invalid chip %x\n", val);
> +		dev_err(dev, "Invalid chip %x\n", val);
>  		return -ENODEV;
>  	}
>  
> @@ -1516,8 +1528,7 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
>  	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_PMU_RANGE,
>  			   BMC150_ACCEL_DEF_RANGE_4G);
>  	if (ret < 0) {
> -		dev_err(data->dev,
> -					"Error writing reg_pmu_range\n");
> +		dev_err(dev, "Error writing reg_pmu_range\n");
>  		return ret;
>  	}
>  
> @@ -1535,8 +1546,7 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
>  			   BMC150_ACCEL_INT_MODE_LATCH_INT |
>  			   BMC150_ACCEL_INT_MODE_LATCH_RESET);
>  	if (ret < 0) {
> -		dev_err(data->dev,
> -			"Error writing reg_int_rst_latch\n");
> +		dev_err(dev, "Error writing reg_int_rst_latch\n");
>  		return ret;
>  	}
>  
> @@ -1556,7 +1566,6 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  
>  	data = iio_priv(indio_dev);
>  	dev_set_drvdata(dev, indio_dev);
> -	data->dev = dev;
>  	data->irq = irq;
>  
>  	data->regmap = regmap;
> @@ -1580,13 +1589,13 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  					 bmc150_accel_trigger_handler,
>  					 &bmc150_accel_buffer_ops);
>  	if (ret < 0) {
> -		dev_err(data->dev, "Failed: iio triggered buffer setup\n");
> +		dev_err(dev, "Failed: iio triggered buffer setup\n");
>  		return ret;
>  	}
>  
>  	if (data->irq > 0) {
>  		ret = devm_request_threaded_irq(
> -						data->dev, data->irq,
> +						dev, data->irq,
>  						bmc150_accel_irq_handler,
>  						bmc150_accel_irq_thread_handler,
>  						IRQF_TRIGGER_RISING,
> @@ -1604,7 +1613,7 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  		ret = regmap_write(data->regmap, BMC150_ACCEL_REG_INT_RST_LATCH,
>  				   BMC150_ACCEL_INT_MODE_LATCH_RESET);
>  		if (ret < 0) {
> -			dev_err(data->dev, "Error writing reg_int_rst_latch\n");
> +			dev_err(dev, "Error writing reg_int_rst_latch\n");
>  			goto err_buffer_cleanup;
>  		}
>  
> @@ -1653,9 +1662,9 @@ int bmc150_accel_core_remove(struct device *dev)
>  
>  	iio_device_unregister(indio_dev);
>  
> -	pm_runtime_disable(data->dev);
> -	pm_runtime_set_suspended(data->dev);
> -	pm_runtime_put_noidle(data->dev);
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);
> +	pm_runtime_put_noidle(dev);
>  
>  	bmc150_accel_unregister_triggers(data, BMC150_ACCEL_TRIGGERS - 1);
>  
> @@ -1704,7 +1713,7 @@ static int bmc150_accel_runtime_suspend(struct device *dev)
>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	dev_dbg(data->dev,  __func__);
> +	dev_dbg(dev,  __func__);
>  	ret = bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_SUSPEND, 0);
>  	if (ret < 0)
>  		return -EAGAIN;
> @@ -1719,7 +1728,7 @@ static int bmc150_accel_runtime_resume(struct device *dev)
>  	int ret;
>  	int sleep_val;
>  
> -	dev_dbg(data->dev,  __func__);
> +	dev_dbg(dev,  __func__);
>  
>  	ret = bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_NORMAL, 0);
>  	if (ret < 0)
> 

