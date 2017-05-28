Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750776AbdE1PHA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 May 2017 11:07:00 -0400
Date: Sun, 28 May 2017 16:06:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Koivunen, Mikko" <Mikko.Koivunen@fi.rohmeurope.com>
Cc: "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5 9/9] iio: light: rpr0521 triggered buffer
Message-ID: <20170528160658.70af2403@kernel.org>
In-Reply-To: <E223F49C7E3E1C4E8F3928A8EC9CF0F8F7991C83@WILL-MAIL002.REu.RohmEu.com>
References: <1495109577-29596-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
        <1495109577-29596-10-git-send-email-mikko.koivunen@fi.rohmeurope.com>
        <40f34b95-b608-93d0-e85b-cd7b5b89b948@kernel.org>
        <E223F49C7E3E1C4E8F3928A8EC9CF0F8F7991C83@WILL-MAIL002.REu.RohmEu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 25 May 2017 13:53:03 +0000
"Koivunen, Mikko" <Mikko.Koivunen@fi.rohmeurope.com> wrote:

> On 21.5.2017 14:34, Jonathan Cameron wrote:
> > On 18/05/17 13:12, Mikko Koivunen wrote:  
> >> Set up and use triggered buffer if there is irq defined for device in
> >> device tree. Trigger producer triggers from rpr0521 drdy interrupt line.
> >> Trigger consumer reads rpr0521 data to scan buffer.
> >> Depends on previous commits of _scale and _offset.
> >>
> >> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>  
> > Hi Mikko,
> >
> > A few last bits in the final patch of the series.  See inline.
> > The IRQ_NONE one might trigger some nasty issues and ultimately
> > disable the interrupt.   
> 
> Do you have any pointer for more information about that?
Sure - just follow the code.  I can't recall why I first ended
up looking at this, but the irq code in general is quite clean
and elegant so it is usually easier than trying to find any 
docs ;)

In this particular case start in kernel/irq/handle.c and dive
down to handle_irq_event_per_cpu which calls (unless it is
disabled) note_interrupt which is in kernel/irq/spurious.c

That has an if statement
if (unlikely(action_ret == IRQ_NONE)) with some logic that can
ultimately disable the IRQ, though it takes quite a few interrupts
to trigger this.
> 
> > However, it is the right option if we know
> > it's not our interrupt...  
> 
> Ok, agree. It's also mandatory for shared interrupt -> changing.
> 
> > Jonathan  
> >> ---
> >> Patch v2->v3 changes:
> >> .shift = 0 removed
> >> reordered functions to remove forward declarations
> >> whitespace changes
> >> refactored some update_bits->write, no "err = err || *"-pattern
> >> refactored trigger_consumer_handler
> >> reordered _probe() and _remove()
> >> added int clear on poweroff()
> >> checkpatch.pl OK
> >> Tested on LeMaker HiKey with AOSP7.1 kernel 4.4.
> >> Builds ok with torvalds/linux feb 27.
> >>
> >> Patch v3->v4 changes:
> >> Moved sensor on/off commands to buffer preenable and postdisable
> >>   - Since drdy happens only on measurement data ready and register writes
> >>     are cached, the trigger producer doesn't care of suspend/resume state.
> >> available_scan_masks added
> >> indent fix
> >> checkpatch.pl OK
> >> Lightly re-tested on LeMaker HiKey with AOSP7.1 kernel 4.4.
> >> Builds ok with torvalds/linux feb 27.
> >>
> >>   drivers/iio/light/rpr0521.c |  294 ++++++++++++++++++++++++++++++++++++++++++-
> >>   1 file changed, 291 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> >> index 9d0c2e8..1ef6060 100644
> >> --- a/drivers/iio/light/rpr0521.c
> >> +++ b/drivers/iio/light/rpr0521.c
> >> @@ -9,7 +9,7 @@
> >>    *
> >>    * IIO driver for RPR-0521RS (7-bit I2C slave address 0x38).
> >>    *
> >> - * TODO: illuminance channel, buffer
> >> + * TODO: illuminance channel
> >>    */
> >>   
> >>   #include <linux/module.h>
> >> @@ -20,6 +20,10 @@
> >>   #include <linux/acpi.h>
> >>   
> >>   #include <linux/iio/iio.h>
> >> +#include <linux/iio/buffer.h>
> >> +#include <linux/iio/trigger.h>
> >> +#include <linux/iio/trigger_consumer.h>
> >> +#include <linux/iio/triggered_buffer.h>
> >>   #include <linux/iio/sysfs.h>
> >>   #include <linux/pm_runtime.h>
> >>   
> >> @@ -30,6 +34,7 @@
> >>   #define RPR0521_REG_PXS_DATA		0x44 /* 16-bit, little endian */
> >>   #define RPR0521_REG_ALS_DATA0		0x46 /* 16-bit, little endian */
> >>   #define RPR0521_REG_ALS_DATA1		0x48 /* 16-bit, little endian */
> >> +#define RPR0521_REG_INTERRUPT		0x4A
> >>   #define RPR0521_REG_PS_OFFSET_LSB	0x53
> >>   #define RPR0521_REG_ID			0x92
> >>   
> >> @@ -42,16 +47,29 @@
> >>   #define RPR0521_ALS_DATA1_GAIN_SHIFT	2
> >>   #define RPR0521_PXS_GAIN_MASK		GENMASK(5, 4)
> >>   #define RPR0521_PXS_GAIN_SHIFT		4
> >> +#define RPR0521_PXS_PERSISTENCE_MASK	GENMASK(3, 0)
> >> +#define RPR0521_INTERRUPT_INT_TRIG_PS_MASK	BIT(0)
> >> +#define RPR0521_INTERRUPT_INT_TRIG_ALS_MASK	BIT(1)
> >> +#define RPR0521_INTERRUPT_INT_REASSERT_MASK	BIT(3)
> >>   
> >>   #define RPR0521_MODE_ALS_ENABLE		BIT(7)
> >>   #define RPR0521_MODE_ALS_DISABLE	0x00
> >>   #define RPR0521_MODE_PXS_ENABLE		BIT(6)
> >>   #define RPR0521_MODE_PXS_DISABLE	0x00
> >> +#define RPR0521_PXS_PERSISTENCE_DRDY	0x00
> >> +
> >> +#define RPR0521_INTERRUPT_INT_TRIG_PS_ENABLE	BIT(0)
> >> +#define RPR0521_INTERRUPT_INT_TRIG_PS_DISABLE	0x00
> >> +#define RPR0521_INTERRUPT_INT_TRIG_ALS_ENABLE	BIT(1)
> >> +#define RPR0521_INTERRUPT_INT_TRIG_ALS_DISABLE	0x00
> >> +#define RPR0521_INTERRUPT_INT_REASSERT_ENABLE	BIT(3)
> >> +#define RPR0521_INTERRUPT_INT_REASSERT_DISABLE	0x00
> >>   
> >>   #define RPR0521_MANUFACT_ID		0xE0
> >>   #define RPR0521_DEFAULT_MEAS_TIME	0x06 /* ALS - 100ms, PXS - 100ms */
> >>   
> >>   #define RPR0521_DRV_NAME		"RPR0521"
> >> +#define RPR0521_IRQ_NAME		"rpr0521_event"
> >>   #define RPR0521_REGMAP_NAME		"rpr0521_regmap"
> >>   
> >>   #define RPR0521_SLEEP_DELAY_MS	2000
> >> @@ -167,6 +185,9 @@ struct rpr0521_data {
> >>   	bool als_dev_en;
> >>   	bool pxs_dev_en;
> >>   
> >> +	struct iio_trigger *drdy_trigger0;
> >> +	bool drdy_trigger_on;
> >> +
> >>   	/* optimize runtime pm ops - enable/disable device only if needed */
> >>   	bool als_ps_need_en;
> >>   	bool pxs_ps_need_en;
> >> @@ -196,6 +217,19 @@ static const struct attribute_group rpr0521_attribute_group = {
> >>   	.attrs = rpr0521_attributes,
> >>   };
> >>   
> >> +/* Order of the channel data in buffer */
> >> +enum rpr0521_scan_index_order {
> >> +	RPR0521_CHAN_INDEX_PXS,
> >> +	RPR0521_CHAN_INDEX_BOTH,
> >> +	RPR0521_CHAN_INDEX_IR,
> >> +};
> >> +
> >> +static const unsigned long rpr0521_available_scan_masks[] = {
> >> +	BIT(RPR0521_CHAN_INDEX_PXS) | BIT(RPR0521_CHAN_INDEX_BOTH) |
> >> +	BIT(RPR0521_CHAN_INDEX_IR),
> >> +	0
> >> +};
> >> +
> >>   static const struct iio_chan_spec rpr0521_channels[] = {
> >>   	{
> >>   		.type = IIO_PROXIMITY,
> >> @@ -204,6 +238,13 @@ static const struct iio_chan_spec rpr0521_channels[] = {
> >>   			BIT(IIO_CHAN_INFO_OFFSET) |
> >>   			BIT(IIO_CHAN_INFO_SCALE),
> >>   		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> >> +		.scan_index = RPR0521_CHAN_INDEX_PXS,
> >> +		.scan_type = {
> >> +			.sign = 'u',
> >> +			.realbits = 16,
> >> +			.storagebits = 16,
> >> +			.endianness = IIO_LE,
> >> +		},
> >>   	},
> >>   	{
> >>   		.type = IIO_INTENSITY,
> >> @@ -213,6 +254,13 @@ static const struct iio_chan_spec rpr0521_channels[] = {
> >>   		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> >>   			BIT(IIO_CHAN_INFO_SCALE),
> >>   		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> >> +		.scan_index = RPR0521_CHAN_INDEX_BOTH,
> >> +		.scan_type = {
> >> +			.sign = 'u',
> >> +			.realbits = 16,
> >> +			.storagebits = 16,
> >> +			.endianness = IIO_LE,
> >> +		},
> >>   	},
> >>   	{
> >>   		.type = IIO_INTENSITY,
> >> @@ -222,6 +270,13 @@ static const struct iio_chan_spec rpr0521_channels[] = {
> >>   		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> >>   			BIT(IIO_CHAN_INFO_SCALE),
> >>   		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> >> +		.scan_index = RPR0521_CHAN_INDEX_IR,
> >> +		.scan_type = {
> >> +			.sign = 'u',
> >> +			.realbits = 16,
> >> +			.storagebits = 16,
> >> +			.endianness = IIO_LE,
> >> +		},
> >>   	},
> >>   };
> >>   
> >> @@ -330,6 +385,150 @@ static int rpr0521_set_power_state(struct rpr0521_data *data, bool on,
> >>   	return 0;
> >>   }
> >>   
> >> +/* IRQ to trigger handler */
> >> +static irqreturn_t rpr0521_drdy_irq_handler(int irq, void *private)
> >> +{
> >> +	struct iio_dev *indio_dev = private;
> >> +	struct rpr0521_data *data = iio_priv(indio_dev);
> >> +
> >> +	/*
> >> +	 * Sometimes static on floating (hi-z) interrupt line causes interrupt.
> >> +	 * Notify trigger0 consumers/subscribers only if trigger has been
> >> +	 * enabled. This is to prevent i2c writes to sensor which is actually
> >> +	 * powered off.
> >> +	 */
> >> +	if (data->drdy_trigger_on)
> >> +		iio_trigger_poll(data->drdy_trigger0);
> >> +  
> > If this isn't our interrupt we should really be returning IRQ_NONE
> > rather than IRQ_HANDLED.  That will trigger unhandled interrupt
> > messages etc in the log...  
> 
> Ack. Adding shared irq support.
> 
> >> +	return IRQ_HANDLED;
> >> +}
> >> +
> >> +static irqreturn_t rpr0521_trigger_consumer_handler(int irq, void *p)
> >> +{
> >> +	struct iio_poll_func *pf = p;
> >> +	struct iio_dev *indio_dev = pf->indio_dev;
> >> +	struct rpr0521_data *data = iio_priv(indio_dev);
> >> +	int err;
> >> +
> >> +	u8 buffer[16]; /* 3 16-bit channels + padding + ts */
> >> +
> >> +	err = regmap_bulk_read(data->regmap, RPR0521_REG_PXS_DATA,
> >> +		&buffer,
> >> +		(3 * 2) + 1);	/* 3 * 16-bit + (discarded) int clear reg. */
> >> +	if (!err)
> >> +		iio_push_to_buffers_with_timestamp(indio_dev,
> >> +						   buffer, pf->timestamp);
> >> +	else
> >> +		dev_err(&data->client->dev,
> >> +			"Trigger consumer can't read from sensor.\n");
> >> +
> >> +	iio_trigger_notify_done(indio_dev->trig);
> >> +
> >> +	return IRQ_HANDLED;
> >> +}
> >> +
> >> +static int rpr0521_write_int_enable(struct rpr0521_data *data)
> >> +{
> >> +	int err;
> >> +
> >> +	/* Interrupt after each measurement */
> >> +	err = regmap_update_bits(data->regmap, RPR0521_REG_PXS_CTRL,
> >> +		RPR0521_PXS_PERSISTENCE_MASK,
> >> +		RPR0521_PXS_PERSISTENCE_DRDY);
> >> +	if (err) {
> >> +		dev_err(&data->client->dev, "PS control reg write fail.\n");
> >> +		return -EBUSY;
> >> +		}
> >> +
> >> +	/* Ignore latch and mode because of drdy */
> >> +	err = regmap_write(data->regmap, RPR0521_REG_INTERRUPT,
> >> +		RPR0521_INTERRUPT_INT_REASSERT_DISABLE |
> >> +		RPR0521_INTERRUPT_INT_TRIG_ALS_DISABLE |
> >> +		RPR0521_INTERRUPT_INT_TRIG_PS_ENABLE
> >> +		);
> >> +	if (err) {
> >> +		dev_err(&data->client->dev, "Interrupt setup write fail.\n");
> >> +		return -EBUSY;
> >> +		}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int rpr0521_write_int_disable(struct rpr0521_data *data)
> >> +{
> >> +	/* Don't care of clearing mode, assert and latch. */
> >> +	return regmap_write(data->regmap, RPR0521_REG_INTERRUPT,
> >> +				RPR0521_INTERRUPT_INT_TRIG_ALS_DISABLE |
> >> +				RPR0521_INTERRUPT_INT_TRIG_PS_DISABLE
> >> +				);
> >> +}
> >> +
> >> +/*
> >> + * Trigger producer enable / disable. Note that there will be trigs only when
> >> + * measurement data is ready to be read.
> >> + */
> >> +static int rpr0521_pxs_drdy_set_state(struct iio_trigger *trigger,
> >> +	bool enable_drdy)
> >> +{
> >> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trigger);
> >> +	struct rpr0521_data *data = iio_priv(indio_dev);
> >> +	int err;
> >> +
> >> +	if (enable_drdy)
> >> +		err = rpr0521_write_int_enable(data);
> >> +	else
> >> +		err = rpr0521_write_int_disable(data);
> >> +	if (err)
> >> +		dev_err(&data->client->dev, "rpr0521_pxs_drdy_set_state failed\n");
> >> +	else
> >> +		data->drdy_trigger_on = enable_drdy;
> >> +
> >> +	return err;
> >> +}
> >> +
> >> +static const struct iio_trigger_ops rpr0521_trigger_ops = {
> >> +	.set_trigger_state = rpr0521_pxs_drdy_set_state,
> >> +	.owner = THIS_MODULE,
> >> +	};
> >> +
> >> +
> >> +static int rpr0521_buffer_preenable(struct iio_dev *indio_dev)
> >> +{
> >> +	int err;
> >> +	struct rpr0521_data *data = iio_priv(indio_dev);
> >> +
> >> +	mutex_lock(&data->lock);
> >> +	err = rpr0521_set_power_state(data, true,
> >> +		(RPR0521_MODE_PXS_MASK | RPR0521_MODE_ALS_MASK));
> >> +	mutex_unlock(&data->lock);
> >> +	if (err)
> >> +		dev_err(&data->client->dev, "_buffer_preenable fail\n");
> >> +
> >> +	return err;
> >> +}
> >> +
> >> +static int rpr0521_buffer_postdisable(struct iio_dev *indio_dev)
> >> +{
> >> +	int err;
> >> +	struct rpr0521_data *data = iio_priv(indio_dev);
> >> +
> >> +	mutex_lock(&data->lock);
> >> +	err = rpr0521_set_power_state(data, false,
> >> +		(RPR0521_MODE_PXS_MASK | RPR0521_MODE_ALS_MASK));
> >> +	mutex_unlock(&data->lock);
> >> +	if (err)
> >> +		dev_err(&data->client->dev, "_buffer_postdisable fail\n");
> >> +
> >> +	return err;
> >> +}
> >> +
> >> +static const struct iio_buffer_setup_ops rpr0521_buffer_setup_ops = {
> >> +	.preenable = rpr0521_buffer_preenable,
> >> +	.postenable = iio_triggered_buffer_postenable,
> >> +	.predisable = iio_triggered_buffer_predisable,
> >> +	.postdisable = rpr0521_buffer_postdisable,
> >> +};
> >> +
> >>   static int rpr0521_get_gain(struct rpr0521_data *data, int chan,
> >>   			    int *val, int *val2)
> >>   {
> >> @@ -481,6 +680,9 @@ static int rpr0521_read_raw(struct iio_dev *indio_dev,
> >>   		if (chan->type != IIO_INTENSITY && chan->type != IIO_PROXIMITY)
> >>   			return -EINVAL;
> >>   
> >> +		if (iio_buffer_enabled(indio_dev))
> >> +			return -EBUSY;  
> > This is racy.  You need to actually prevent a transition to buffered reading.
> > That means you want to use iio_claim_direct etc to hold the lock over state
> > transitions whilst the read is going on.
> >
> > (sorry I missed this in earlier versions!)  
> 
> Oh, you are nudging me away from the 4.4.
> Np. I agree on issue and fix. However iio_device_claim_direct_mode() is
> available only from 4.7 onward and I'm working and testing on top of 4.4.
> 
> Since buffer preenable has mutex for powering on, I could mostly (not
> fully) tackle this by extending mutex below to include this test. Single
> read happening while in iio_buffer_store_enable() between preenable and
> "currentmode =" would cause sensor to power down and not wake up on next
> system suspend-resume.
> 
> I can't figure out any other 4.4 fix than making similar mutex in driver
> as in iio_device_claim_direct_mode(). So maybe do commit
> without+separate fix commit? I can do second commit and build it but not
> test it currently.
You could hand role the code that iio_device_claim_direct_mode is doing.
I'm fairly sure the infrastructure was always there and this wrapper
just made sure that it was correctly used.  Then a follow up patch
to just replace that with using iio_device_claim_direct_mode.

I'd be happy with that if it makes your life easier.
> 
> >> +
> >>   		device_mask = rpr0521_data_reg[chan->address].device_mask;
> >>   
> >>   		mutex_lock(&data->lock);
> >> @@ -623,6 +825,7 @@ static int rpr0521_init(struct rpr0521_data *data)
> >>   static int rpr0521_poweroff(struct rpr0521_data *data)
> >>   {
> >>   	int ret;
> >> +	int tmp;
> >>   
> >>   	ret = regmap_update_bits(data->regmap, RPR0521_REG_MODE_CTRL,
> >>   				 RPR0521_MODE_ALS_MASK |
> >> @@ -635,6 +838,16 @@ static int rpr0521_poweroff(struct rpr0521_data *data)
> >>   	data->als_dev_en = false;
> >>   	data->pxs_dev_en = false;
> >>   
> >> +	/*
> >> +	 * Int pin keeps state after power off. Set pin to high impedance
> >> +	 * mode to prevent power drain.
> >> +	 */
> >> +	ret = regmap_read(data->regmap, RPR0521_REG_INTERRUPT, &tmp);
> >> +	if (ret) {
> >> +		dev_err(&data->client->dev, "Failed to reset int pin.\n");
> >> +		return ret;
> >> +	}
> >> +
> >>   	return 0;
> >>   }
> >>   
> >> @@ -707,12 +920,78 @@ static int rpr0521_probe(struct i2c_client *client,
> >>   	pm_runtime_set_autosuspend_delay(&client->dev, RPR0521_SLEEP_DELAY_MS);
> >>   	pm_runtime_use_autosuspend(&client->dev);
> >>   
> >> +	/*
> >> +	 * If sensor write/read  is needed in _probe after _use_autosuspend,
> >> +	 * sensor needs to be _resumed first using rpr0521_set_power_state().
> >> +	 */
> >> +
> >> +	/* IRQ to trigger setup */
> >> +	if (client->irq) {
> >> +		/* Trigger0 producer setup */
> >> +		data->drdy_trigger0 = devm_iio_trigger_alloc(
> >> +			indio_dev->dev.parent,
> >> +			"%s-dev%d", indio_dev->name, indio_dev->id);
> >> +		if (!data->drdy_trigger0) {
> >> +			ret = -ENOMEM;
> >> +			goto err_pm_disable;
> >> +		}
> >> +		data->drdy_trigger0->dev.parent = indio_dev->dev.parent;
> >> +		data->drdy_trigger0->ops = &rpr0521_trigger_ops;
> >> +		indio_dev->available_scan_masks = rpr0521_available_scan_masks;
> >> +		iio_trigger_set_drvdata(data->drdy_trigger0, indio_dev);
> >> +
> >> +		/* Ties irq to trigger producer handler. */
> >> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> >> +			rpr0521_drdy_irq_handler,
> >> +			NULL,
> >> +			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> >> +			RPR0521_IRQ_NAME,
> >> +			indio_dev);
> >> +		if (ret < 0) {
> >> +			dev_err(&client->dev, "request irq %d for trigger0 failed\n",
> >> +				client->irq);
> >> +			goto err_pm_disable;
> >> +			}
> >> +
> >> +		ret = iio_trigger_register(data->drdy_trigger0);
> >> +		if (ret) {
> >> +			dev_err(&client->dev, "iio trigger register failed\n");
> >> +			goto err_pm_disable;
> >> +		}
> >> +
> >> +		/*
> >> +		 * Now whole pipe from physical interrupt (irq defined by
> >> +		 * devicetree to device) to trigger0 output is set up.
> >> +		 */
> >> +
> >> +		/* Trigger consumer setup */
> >> +		ret = iio_triggered_buffer_setup(indio_dev,
> >> +			&iio_pollfunc_store_time,
> >> +			rpr0521_trigger_consumer_handler,
> >> +			&rpr0521_buffer_setup_ops);
> >> +		if (ret < 0) {
> >> +			dev_err(&client->dev, "iio triggered buffer setup failed\n");
> >> +			/* Count on devm to free_irq */
> >> +			goto err_iio_trigger_unregister;
> >> +		}
> >> +	}
> >> +
> >>   	ret = iio_device_register(indio_dev);
> >>   	if (ret)
> >> -		goto err_pm_disable;
> >> +		goto err_iio_triggered_buffer_cleanup;
> >> +
> >> +	if (client->irq) {
> >> +		/* Set trigger0 as current trigger (and inc refcount) */
> >> +		indio_dev->trig = iio_trigger_get(data->drdy_trigger0);
> >> +	}
> >>   
> >>   	return 0;
> >>   
> >> +err_iio_triggered_buffer_cleanup:
> >> +	iio_triggered_buffer_cleanup(indio_dev);
> >> +err_iio_trigger_unregister:
> >> +	if (data->drdy_trigger0)
> >> +		iio_trigger_unregister(data->drdy_trigger0);
> >>   err_pm_disable:
> >>   	pm_runtime_disable(&client->dev);
> >>   	pm_runtime_set_suspended(&client->dev);
> >> @@ -726,14 +1005,23 @@ err_poweroff:
> >>   static int rpr0521_remove(struct i2c_client *client)
> >>   {
> >>   	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> >> +	struct rpr0521_data *data = iio_priv(indio_dev);
> >> +
> >> +	if (indio_dev->trig)
> >> +		iio_trigger_put(indio_dev->trig);  
> > There is not guarantee this is the same trigger as that
> > provided by this driver.  
> 
> It doesn't matter. In that case iio_trigger_write_current() has put the
> default one and has get the new one. Then we just put the new one here.
But.. It might not be any trigger at all - so this would cause a null
pointer dereference.
> 
> > So strangely the right option here
> > is to get it as you have done which will set up the default
> > to be sane, but to allow userspace to be responsible for the
> > put by clearing current_trigger if it wants to remove the
> > driver.  As a general rule I'm fairly anti default triggers
> > but I do appreciate they are sometimes all that makes sense...  
> 
> If defaults are not good habit, then I think it should be fine to not
> get default trigger just and rely on userspace getting it when needed.
> Didn't test it yet, but I think that should be fine with IIO_HAL. Even
> in that case I would _put() it in remove().
Userspace should be actively removing the trigger before trying
to remove the driver.   You should only be able to remove anyway
by forcing the remove as we will have a far from zero reference counter
on the module.

It's non standard and I don't want to see the possible bugs breaking
the standard flow could create.

I'd certainly prefer in general that the driver didn't attempt to set
up the default trigger and didn't attempt to cleanup any triggers
in remove as they should have already been disconnected cleanly before
the remove happens.

Thanks,

Jonathan
> 
> > However, if that is the case, then you should have the various
> > validation callbacks provided to ensure this trigger is used
> > only for this device and the device can only use this trigger.
> >
> > You 'could' set indio_dev->trig_readonly which will block
> > out userspace changes...  Perhaps that's what you want to
> > do here.  
> >>   
> >>   	iio_device_unregister(indio_dev);
> >>   
> >> +	iio_triggered_buffer_cleanup(indio_dev);
> >> +
> >> +	if (data->drdy_trigger0)
> >> +		iio_trigger_unregister(data->drdy_trigger0);
> >> +
> >>   	pm_runtime_disable(&client->dev);
> >>   	pm_runtime_set_suspended(&client->dev);
> >>   	pm_runtime_put_noidle(&client->dev);
> >>   
> >> -	rpr0521_poweroff(iio_priv(indio_dev));
> >> +	rpr0521_poweroff(data);
> >>   
> >>   	return 0;
> >>   }
> >>  
> 

