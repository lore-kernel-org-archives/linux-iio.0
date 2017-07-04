Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751960AbdGDTsZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 Jul 2017 15:48:25 -0400
Date: Tue, 4 Jul 2017 20:48:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 09/10] iio: light: rpr0521 triggered buffer
Message-ID: <20170704204821.30384e00@kernel.org>
In-Reply-To: <1499086214-1811-2-git-send-email-mikko.koivunen@fi.rohmeurope.com>
References: <1499086214-1811-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
        <1499086214-1811-2-git-send-email-mikko.koivunen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon,  3 Jul 2017 15:50:13 +0300
Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com> wrote:

> Set up and use triggered buffer if there is irq defined for device in
> device tree. Trigger producer triggers from rpr0521 drdy interrupt line.
> Trigger consumer reads rpr0521 data to scan buffer.
> Depends on previous commits of _scale and _offset.
> 
> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
one side comment inline, but so tiny I'm not even going to bother changing
it whilst applying.

Very nice.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> Patch v2->v3 changes:
> .shift = 0 removed
> reordered functions to remove forward declarations
> whitespace changes
> refactored some update_bits->write, no "err = err || *"-pattern
> refactored trigger_consumer_handler
> reordered _probe() and _remove()
> added int clear on poweroff()
> checkpatch.pl OK
> Tested on LeMaker HiKey with AOSP7.1 kernel 4.4.
> Builds ok with torvalds/linux feb 27.
> 
> Patch v3->v4 changes:
> Moved sensor on/off commands to buffer preenable and postdisable
>  - Since drdy happens only on measurement data ready and register writes
>    are cached, the trigger producer doesn't care of suspend/resume state.
> available_scan_masks added
> indent fix
> checkpatch.pl OK
> Lightly re-tested on LeMaker HiKey with AOSP7.1 kernel 4.4.
> Builds ok with torvalds/linux feb 27.
> 
> Patch v5->v6 changes:
> Changed base from kernel 4.4 to 4.9
>  - Using iio_device_claim_direct_mode()
>  - Using iio_trigger_using_own()
>  - Changed trigger/buffer to devm_
> Added shared irq support
>  - divided trigger producer to top/bottom
>  - divided trigger consumer to top/bottom
>  - Using irq_timestamp when available
> Removed default trigger
> 
> Patch v6->v7 changes:
> trigger_poll to trigger_poll_chained
>  + some timestamp saving logic changes due that
> 2 whitespace fixes
> 
>  drivers/iio/light/rpr0521.c |  336 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 329 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index 9d0c2e8..a6efa126 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -9,7 +9,7 @@
>   *
>   * IIO driver for RPR-0521RS (7-bit I2C slave address 0x38).
>   *
> - * TODO: illuminance channel, buffer
> + * TODO: illuminance channel
>   */
>  
>  #include <linux/module.h>
> @@ -20,6 +20,10 @@
>  #include <linux/acpi.h>
>  
>  #include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/pm_runtime.h>
>  
> @@ -30,6 +34,7 @@
>  #define RPR0521_REG_PXS_DATA		0x44 /* 16-bit, little endian */
>  #define RPR0521_REG_ALS_DATA0		0x46 /* 16-bit, little endian */
>  #define RPR0521_REG_ALS_DATA1		0x48 /* 16-bit, little endian */
> +#define RPR0521_REG_INTERRUPT		0x4A
>  #define RPR0521_REG_PS_OFFSET_LSB	0x53
>  #define RPR0521_REG_ID			0x92
>  
> @@ -42,16 +47,31 @@
>  #define RPR0521_ALS_DATA1_GAIN_SHIFT	2
>  #define RPR0521_PXS_GAIN_MASK		GENMASK(5, 4)
>  #define RPR0521_PXS_GAIN_SHIFT		4
> +#define RPR0521_PXS_PERSISTENCE_MASK	GENMASK(3, 0)
> +#define RPR0521_INTERRUPT_INT_TRIG_PS_MASK	BIT(0)
> +#define RPR0521_INTERRUPT_INT_TRIG_ALS_MASK	BIT(1)
> +#define RPR0521_INTERRUPT_INT_REASSERT_MASK	BIT(3)
> +#define RPR0521_INTERRUPT_ALS_INT_STATUS_MASK	BIT(6)
> +#define RPR0521_INTERRUPT_PS_INT_STATUS_MASK	BIT(7)
>  
>  #define RPR0521_MODE_ALS_ENABLE		BIT(7)
>  #define RPR0521_MODE_ALS_DISABLE	0x00
>  #define RPR0521_MODE_PXS_ENABLE		BIT(6)
>  #define RPR0521_MODE_PXS_DISABLE	0x00
> +#define RPR0521_PXS_PERSISTENCE_DRDY	0x00
> +
> +#define RPR0521_INTERRUPT_INT_TRIG_PS_ENABLE	BIT(0)
> +#define RPR0521_INTERRUPT_INT_TRIG_PS_DISABLE	0x00
> +#define RPR0521_INTERRUPT_INT_TRIG_ALS_ENABLE	BIT(1)
> +#define RPR0521_INTERRUPT_INT_TRIG_ALS_DISABLE	0x00
> +#define RPR0521_INTERRUPT_INT_REASSERT_ENABLE	BIT(3)
> +#define RPR0521_INTERRUPT_INT_REASSERT_DISABLE	0x00
>  
>  #define RPR0521_MANUFACT_ID		0xE0
>  #define RPR0521_DEFAULT_MEAS_TIME	0x06 /* ALS - 100ms, PXS - 100ms */
>  
>  #define RPR0521_DRV_NAME		"RPR0521"
> +#define RPR0521_IRQ_NAME		"rpr0521_event"
>  #define RPR0521_REGMAP_NAME		"rpr0521_regmap"
>  
>  #define RPR0521_SLEEP_DELAY_MS	2000
> @@ -167,6 +187,9 @@ struct rpr0521_data {
>  	bool als_dev_en;
>  	bool pxs_dev_en;
>  
> +	struct iio_trigger *drdy_trigger0;
> +	s64 irq_timestamp;
> +
>  	/* optimize runtime pm ops - enable/disable device only if needed */
>  	bool als_ps_need_en;
>  	bool pxs_ps_need_en;
> @@ -196,6 +219,19 @@ static const struct attribute_group rpr0521_attribute_group = {
>  	.attrs = rpr0521_attributes,
>  };
>  
> +/* Order of the channel data in buffer */
> +enum rpr0521_scan_index_order {
> +	RPR0521_CHAN_INDEX_PXS,
> +	RPR0521_CHAN_INDEX_BOTH,
> +	RPR0521_CHAN_INDEX_IR,
> +};
> +
> +static const unsigned long rpr0521_available_scan_masks[] = {
> +	BIT(RPR0521_CHAN_INDEX_PXS) | BIT(RPR0521_CHAN_INDEX_BOTH) |
> +	BIT(RPR0521_CHAN_INDEX_IR),
> +	0
> +};
> +
>  static const struct iio_chan_spec rpr0521_channels[] = {
>  	{
>  		.type = IIO_PROXIMITY,
> @@ -204,6 +240,13 @@ static const struct iio_chan_spec rpr0521_channels[] = {
>  			BIT(IIO_CHAN_INFO_OFFSET) |
>  			BIT(IIO_CHAN_INFO_SCALE),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.scan_index = RPR0521_CHAN_INDEX_PXS,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_LE,
> +		},
>  	},
>  	{
>  		.type = IIO_INTENSITY,
> @@ -213,6 +256,13 @@ static const struct iio_chan_spec rpr0521_channels[] = {
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_SCALE),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.scan_index = RPR0521_CHAN_INDEX_BOTH,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_LE,
> +		},
>  	},
>  	{
>  		.type = IIO_INTENSITY,
> @@ -222,6 +272,13 @@ static const struct iio_chan_spec rpr0521_channels[] = {
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_SCALE),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.scan_index = RPR0521_CHAN_INDEX_IR,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_LE,
> +		},
>  	},
>  };
>  
> @@ -330,6 +387,198 @@ static int rpr0521_set_power_state(struct rpr0521_data *data, bool on,
>  	return 0;
>  }
>  
> +/* Interrupt register tells if this sensor caused the interrupt or not. */
> +static inline bool rpr0521_is_triggered(struct rpr0521_data *data)
> +{
> +	int ret;
> +	int reg;
> +
> +	ret = regmap_read(data->regmap, RPR0521_REG_INTERRUPT, &reg);
> +	if (ret < 0)
> +		return false;   /* Reg read failed. */
> +	if (reg &
> +	    (RPR0521_INTERRUPT_ALS_INT_STATUS_MASK |
> +	    RPR0521_INTERRUPT_PS_INT_STATUS_MASK))
> +		return true;
> +	else
> +		return false;   /* Int not from this sensor. */
> +}
> +
> +/* IRQ to trigger handler */
> +static irqreturn_t rpr0521_drdy_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct rpr0521_data *data = iio_priv(indio_dev);
> +
> +	data->irq_timestamp = iio_get_time_ns(indio_dev);
> +	/*
> +	 * We need to wake the thread to read the interrupt reg. It
> +	 * is not possible to do that here because regmap_read takes a
> +	 * mutex.
> +	 */
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t rpr0521_drdy_irq_thread(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct rpr0521_data *data = iio_priv(indio_dev);
> +
> +	if (rpr0521_is_triggered(data)) {
> +		iio_trigger_poll_chained(data->drdy_trigger0);
> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_NONE;
> +}
> +
> +static irqreturn_t rpr0521_trigger_consumer_store_time(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +
> +	/* Other trigger polls store time here. */
> +	if (!iio_trigger_using_own(indio_dev))
> +		pf->timestamp = iio_get_time_ns(indio_dev);
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t rpr0521_trigger_consumer_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct rpr0521_data *data = iio_priv(indio_dev);
> +	int err;
> +
> +	u8 buffer[16]; /* 3 16-bit channels + padding + ts */
> +
> +	/* Use irq timestamp when reasonable. */
> +	if (iio_trigger_using_own(indio_dev) && data->irq_timestamp) {
> +		pf->timestamp = data->irq_timestamp;
> +		data->irq_timestamp = 0;
> +	}
> +	/* Other chained trigger polls get timestamp only here. */
> +	if (!pf->timestamp)
> +		pf->timestamp = iio_get_time_ns(indio_dev);
> +
> +	err = regmap_bulk_read(data->regmap, RPR0521_REG_PXS_DATA,
> +		&buffer,
> +		(3 * 2) + 1);	/* 3 * 16-bit + (discarded) int clear reg. */
> +	if (!err)
> +		iio_push_to_buffers_with_timestamp(indio_dev,
> +						   buffer, pf->timestamp);
> +	else
> +		dev_err(&data->client->dev,
> +			"Trigger consumer can't read from sensor.\n");
> +	pf->timestamp = 0;
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int rpr0521_write_int_enable(struct rpr0521_data *data)
> +{
> +	int err;
> +
> +	/* Interrupt after each measurement */
> +	err = regmap_update_bits(data->regmap, RPR0521_REG_PXS_CTRL,
> +		RPR0521_PXS_PERSISTENCE_MASK,
> +		RPR0521_PXS_PERSISTENCE_DRDY);
> +	if (err) {
> +		dev_err(&data->client->dev, "PS control reg write fail.\n");
> +		return -EBUSY;
> +		}
> +
> +	/* Ignore latch and mode because of drdy */
> +	err = regmap_write(data->regmap, RPR0521_REG_INTERRUPT,
> +		RPR0521_INTERRUPT_INT_REASSERT_DISABLE |
> +		RPR0521_INTERRUPT_INT_TRIG_ALS_DISABLE |
> +		RPR0521_INTERRUPT_INT_TRIG_PS_ENABLE
> +		);
> +	if (err) {
> +		dev_err(&data->client->dev, "Interrupt setup write fail.\n");
> +		return -EBUSY;
> +		}
> +
> +	return 0;
> +}
> +
> +static int rpr0521_write_int_disable(struct rpr0521_data *data)
> +{
> +	/* Don't care of clearing mode, assert and latch. */
> +	return regmap_write(data->regmap, RPR0521_REG_INTERRUPT,
> +				RPR0521_INTERRUPT_INT_TRIG_ALS_DISABLE |
> +				RPR0521_INTERRUPT_INT_TRIG_PS_DISABLE
> +				);
> +}
> +
> +/*
> + * Trigger producer enable / disable. Note that there will be trigs only when
> + * measurement data is ready to be read.
> + */
> +static int rpr0521_pxs_drdy_set_state(struct iio_trigger *trigger,
> +	bool enable_drdy)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trigger);
> +	struct rpr0521_data *data = iio_priv(indio_dev);
> +	int err;
> +
> +	if (enable_drdy)
> +		err = rpr0521_write_int_enable(data);
> +	else
> +		err = rpr0521_write_int_disable(data);
> +	if (err)
> +		dev_err(&data->client->dev, "rpr0521_pxs_drdy_set_state failed\n");
> +
> +	return err;
> +}
> +
> +static const struct iio_trigger_ops rpr0521_trigger_ops = {
> +	.set_trigger_state = rpr0521_pxs_drdy_set_state,
> +	.owner = THIS_MODULE,
> +	};
> +
> +
> +static int rpr0521_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	int err;
> +	struct rpr0521_data *data = iio_priv(indio_dev);
> +
> +	mutex_lock(&data->lock);
> +	err = rpr0521_set_power_state(data, true,
> +		(RPR0521_MODE_PXS_MASK | RPR0521_MODE_ALS_MASK));
> +	mutex_unlock(&data->lock);
> +	if (err)
> +		dev_err(&data->client->dev, "_buffer_preenable fail\n");
> +
> +	return err;
> +}
> +
> +static int rpr0521_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	int err;
> +	struct rpr0521_data *data = iio_priv(indio_dev);
> +
> +	mutex_lock(&data->lock);
> +	err = rpr0521_set_power_state(data, false,
> +		(RPR0521_MODE_PXS_MASK | RPR0521_MODE_ALS_MASK));
> +	mutex_unlock(&data->lock);
> +	if (err)
> +		dev_err(&data->client->dev, "_buffer_postdisable fail\n");
> +
> +	return err;
> +}
> +
> +static const struct iio_buffer_setup_ops rpr0521_buffer_setup_ops = {
> +	.preenable = rpr0521_buffer_preenable,
> +	.postenable = iio_triggered_buffer_postenable,
> +	.predisable = iio_triggered_buffer_predisable,
> +	.postdisable = rpr0521_buffer_postdisable,
> +};
> +
>  static int rpr0521_get_gain(struct rpr0521_data *data, int chan,
>  			    int *val, int *val2)
>  {
> @@ -473,6 +722,7 @@ static int rpr0521_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct rpr0521_data *data = iio_priv(indio_dev);
>  	int ret;
> +	int busy;
>  	u8 device_mask;
>  	__le16 raw_data;
>  
> @@ -481,26 +731,30 @@ static int rpr0521_read_raw(struct iio_dev *indio_dev,
>  		if (chan->type != IIO_INTENSITY && chan->type != IIO_PROXIMITY)
>  			return -EINVAL;
>  
> +		busy = iio_device_claim_direct_mode(indio_dev);
> +		if (busy)
> +			return -EBUSY;
> +
>  		device_mask = rpr0521_data_reg[chan->address].device_mask;
>  
>  		mutex_lock(&data->lock);
>  		ret = rpr0521_set_power_state(data, true, device_mask);
> -		if (ret < 0) {
> -			mutex_unlock(&data->lock);
> -			return ret;
> -		}
> +		if (ret < 0)
> +			goto rpr0521_read_raw_out;
>  
>  		ret = regmap_bulk_read(data->regmap,
>  				       rpr0521_data_reg[chan->address].address,
>  				       &raw_data, sizeof(raw_data));
>  		if (ret < 0) {
>  			rpr0521_set_power_state(data, false, device_mask);
> -			mutex_unlock(&data->lock);
> -			return ret;
> +			goto rpr0521_read_raw_out;
>  		}
>  
>  		ret = rpr0521_set_power_state(data, false, device_mask);
> +
> +rpr0521_read_raw_out:
>  		mutex_unlock(&data->lock);
> +		iio_device_release_direct_mode(indio_dev);
>  		if (ret < 0)
>  			return ret;
>  
> @@ -617,12 +871,15 @@ static int rpr0521_init(struct rpr0521_data *data)
>  		return ret;
>  #endif
>  
> +	data->irq_timestamp = 0;
> +
>  	return 0;
>  }
>  
>  static int rpr0521_poweroff(struct rpr0521_data *data)
>  {
>  	int ret;
> +	int tmp;
>  
>  	ret = regmap_update_bits(data->regmap, RPR0521_REG_MODE_CTRL,
>  				 RPR0521_MODE_ALS_MASK |
> @@ -635,6 +892,16 @@ static int rpr0521_poweroff(struct rpr0521_data *data)
>  	data->als_dev_en = false;
>  	data->pxs_dev_en = false;
>  
> +	/*
> +	 * Int pin keeps state after power off. Set pin to high impedance
> +	 * mode to prevent power drain.
> +	 */
> +	ret = regmap_read(data->regmap, RPR0521_REG_INTERRUPT, &tmp);
> +	if (ret) {
> +		dev_err(&data->client->dev, "Failed to reset int pin.\n");
> +		return ret;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -707,6 +974,61 @@ static int rpr0521_probe(struct i2c_client *client,
>  	pm_runtime_set_autosuspend_delay(&client->dev, RPR0521_SLEEP_DELAY_MS);
>  	pm_runtime_use_autosuspend(&client->dev);
>  
> +	/*
> +	 * If sensor write/read is needed in _probe after _use_autosuspend,
> +	 * sensor needs to be _resumed first using rpr0521_set_power_state().
> +	 */
> +
> +	/* IRQ to trigger setup */
> +	if (client->irq) {
> +		/* Trigger0 producer setup */
> +		data->drdy_trigger0 = devm_iio_trigger_alloc(
> +			indio_dev->dev.parent,
> +			"%s-dev%d", indio_dev->name, indio_dev->id);
> +		if (!data->drdy_trigger0) {
> +			ret = -ENOMEM;
> +			goto err_pm_disable;
> +		}
> +		data->drdy_trigger0->dev.parent = indio_dev->dev.parent;
> +		data->drdy_trigger0->ops = &rpr0521_trigger_ops;
> +		indio_dev->available_scan_masks = rpr0521_available_scan_masks;
If I was being really fussy, this has nothing much to do with the trigger
(semantically anyway) so should probably just be set whatever or at very
least down by where you setup the buffer.


> +		iio_trigger_set_drvdata(data->drdy_trigger0, indio_dev);
> +
> +		/* Ties irq to trigger producer handler. */
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +			rpr0521_drdy_irq_handler, rpr0521_drdy_irq_thread,
> +			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +			RPR0521_IRQ_NAME, indio_dev);
> +		if (ret < 0) {
> +			dev_err(&client->dev, "request irq %d for trigger0 failed\n",
> +				client->irq);
> +			goto err_pm_disable;
> +			}
> +
> +		ret = devm_iio_trigger_register(indio_dev->dev.parent,
> +						data->drdy_trigger0);
> +		if (ret) {
> +			dev_err(&client->dev, "iio trigger register failed\n");
> +			goto err_pm_disable;
> +		}
> +
> +		/*
> +		 * Now whole pipe from physical interrupt (irq defined by
> +		 * devicetree to device) to trigger0 output is set up.
> +		 */
> +
> +		/* Trigger consumer setup */
> +		ret = devm_iio_triggered_buffer_setup(indio_dev->dev.parent,
> +			indio_dev,
> +			rpr0521_trigger_consumer_store_time,
> +			rpr0521_trigger_consumer_handler,
> +			&rpr0521_buffer_setup_ops);
> +		if (ret < 0) {
> +			dev_err(&client->dev, "iio triggered buffer setup failed\n");
> +			goto err_pm_disable;
> +		}
> +	}
> +
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
>  		goto err_pm_disable;

