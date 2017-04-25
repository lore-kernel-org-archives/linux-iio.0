Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:59958 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1176751AbdDYIwY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Apr 2017 04:52:24 -0400
From: "Koivunen, Mikko" <Mikko.Koivunen@fi.rohmeurope.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 6/7] iio: light: rpr0521 triggered buffer added
Date: Tue, 25 Apr 2017 08:37:10 +0000
Message-ID: <E223F49C7E3E1C4E8F3928A8EC9CF0F8DBEC50C9@WILL-MAIL002.REu.RohmEu.com>
References: <1491566839-3925-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <1491566839-3925-6-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <61f2ce98-7eb4-8463-c932-ec5a4b0224f9@kernel.org>
 <E223F49C7E3E1C4E8F3928A8EC9CF0F8DBEC488D@WILL-MAIL002.REu.RohmEu.com>
 <b26a86cb-5255-6d89-f474-fbf957c15bb9@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14.4.2017 18:21, Jonathan Cameron wrote:
> On 12/04/17 14:44, Koivunen, Mikko wrote:
>> On 8.4.2017 18:28, Jonathan Cameron wrote:
>>> On 07/04/17 13:07, Mikko Koivunen wrote:
>>>> Driver sets up and uses triggered buffer if there is irq defined for device in
>>>> device tree. Trigger producer triggers from rpr0521 drdy interrupt line.
>>>> Trigger consumer reads rpr0521 data to scan buffer.
>>>> Depends on previous commits of _scale and _offset.
>>>>
>>>> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
>>>> ---
>>> A few comments inline...
>>>
>>> Jonathan
>>>> Tested on LeMaker HiKey with AOSP7.1, IIO_HAL and kernel 4.4.
>>>> Builds OK with torvalds/linux 4.9
>>>> checkpatch.pl OK.
>>>>
>>>> Patch v1->v2 changes:
>>>> removed flagging of the new feature
>>>> removed unnecesssary rpr0521_update_scan_mode()
>>>> removed unnecessary comments.
>>>> added IIO_LE to channel spec
>>>>
>>>>  drivers/iio/light/rpr0521.c |  287 ++++++++++++++++++++++++++++++++++++++++++-
>>>>  1 file changed, 282 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
>>>> index dc522fd..72f608d 100644
>>>> --- a/drivers/iio/light/rpr0521.c
>>>> +++ b/drivers/iio/light/rpr0521.c
>>>> @@ -9,9 +9,10 @@
>>>>   *
>>>>   * IIO driver for RPR-0521RS (7-bit I2C slave address 0x38).
>>>>   *
>>>> - * TODO: illuminance channel, PM support, buffer
>>>> + * TODO: illuminance channel, PM support
>>>>   */
>>>>  
>>>> +
>>> Be careful to clear out stray whitespace changes like this one.
>>> Just add noise to the patch and may mean it takes longer to be accepted...
>> Ack. Need to double check next time.
>>
>>>>  #include <linux/module.h>
>>>>  #include <linux/init.h>
>>>>  #include <linux/i2c.h>
>>>> @@ -20,6 +21,10 @@
>>>>  #include <linux/acpi.h>
>>>>  
>>>>  #include <linux/iio/iio.h>
>>>> +#include <linux/iio/buffer.h>
>>>> +#include <linux/iio/trigger.h>
>>>> +#include <linux/iio/trigger_consumer.h>
>>>> +#include <linux/iio/triggered_buffer.h>
>>>>  #include <linux/iio/sysfs.h>
>>>>  #include <linux/pm_runtime.h>
>>>>  
>>>> @@ -30,6 +35,7 @@
>>>>  #define RPR0521_REG_PXS_DATA		0x44 /* 16-bit, little endian */
>>>>  #define RPR0521_REG_ALS_DATA0		0x46 /* 16-bit, little endian */
>>>>  #define RPR0521_REG_ALS_DATA1		0x48 /* 16-bit, little endian */
>>>> +#define RPR0521_REG_INTERRUPT		0x4A
>>>>  #define RPR0521_PS_OFFSET_LSB		0x53
>>>>  #define RPR0521_PS_OFFSET_MSB		0x54
>>>>  
>>>> @@ -44,16 +50,33 @@
>>>>  #define RPR0521_ALS_DATA1_GAIN_SHIFT	2
>>>>  #define RPR0521_PXS_GAIN_MASK		GENMASK(5, 4)
>>>>  #define RPR0521_PXS_GAIN_SHIFT		4
>>>> +#define RPR0521_PXS_PERSISTENCE_MASK	GENMASK(3, 0)
>>>> +#define RPR0521_INTERRUPT_INT_TRIG_PS_MASK	BIT(0)
>>>> +#define RPR0521_INTERRUPT_INT_TRIG_ALS_MASK	BIT(1)
>>>> +#define RPR0521_INTERRUPT_INT_LATCH_MASK	BIT(2)
>>>> +#define RPR0521_INTERRUPT_INT_REASSERT_MASK	BIT(3)
>>>> +#define RPR0521_INTERRUPT_INT_MODE_MASK		GENMASK(5, 4)
>>>>  
>>>>  #define RPR0521_MODE_ALS_ENABLE		BIT(7)
>>>>  #define RPR0521_MODE_ALS_DISABLE	0x00
>>>>  #define RPR0521_MODE_PXS_ENABLE		BIT(6)
>>>>  #define RPR0521_MODE_PXS_DISABLE	0x00
>>>> +#define RPR0521_PXS_PERSISTENCE_DRDY	0x00
>>>> +#define RPR0521_INTERRUPT_INT_TRIG_PS_ENABLE	BIT(0)
>>>> +#define RPR0521_INTERRUPT_INT_TRIG_PS_DISABLE	0x00
>>>> +#define RPR0521_INTERRUPT_INT_TRIG_ALS_ENABLE	BIT(1)
>>>> +#define RPR0521_INTERRUPT_INT_TRIG_ALS_DISABLE	0x00
>>>> +#define RPR0521_INTERRUPT_INT_LATCH_DISABLE	BIT(2)
>>>> +#define RPR0521_INTERRUPT_INT_LATCH_ENABLE	0x00
>>>> +#define RPR0521_INTERRUPT_INT_REASSERT_ENABLE	BIT(3)
>>>> +#define RPR0521_INTERRUPT_INT_REASSERT_DISABLE	0x00
>>>> +#define RPR0521_INTERRUPT_INT_PS_OUTSIDE_DETECT	BIT(5)
>>>>  
>>>>  #define RPR0521_MANUFACT_ID		0xE0
>>>>  #define RPR0521_DEFAULT_MEAS_TIME	0x06 /* ALS - 100ms, PXS - 100ms */
>>>>  
>>>>  #define RPR0521_DRV_NAME		"RPR0521"
>>>> +#define RPR0521_IRQ_NAME		"rpr0521_event"
>>>>  #define RPR0521_REGMAP_NAME		"rpr0521_regmap"
>>>>  
>>>>  #define RPR0521_SLEEP_DELAY_MS	2000
>>>> @@ -169,6 +192,9 @@ struct rpr0521_data {
>>>>  	bool als_dev_en;
>>>>  	bool pxs_dev_en;
>>>>  
>>>> +	struct iio_trigger *drdy_trigger0;
>>>> +	bool drdy_trigger_on;
>>>> +
>>>>  	/* optimize runtime pm ops - enable device only if needed */
>>>>  	bool als_ps_need_en;
>>>>  	bool pxs_ps_need_en;
>>>> @@ -195,6 +221,13 @@ static const struct attribute_group rpr0521_attribute_group = {
>>>>  	.attrs = rpr0521_attributes,
>>>>  };
>>>>  
>>>> +/* Order of the channel data in buffer */
>>>> +enum rpr0521_scan_index_order {
>>>> +	RPR0521_CHAN_INDEX_PXS,
>>>> +	RPR0521_CHAN_INDEX_BOTH,
>>>> +	RPR0521_CHAN_INDEX_IR,
>>>> +};
>>>> +
>>>>  static const struct iio_chan_spec rpr0521_channels[] = {
>>>>  	{
>>>>  		.type = IIO_PROXIMITY,
>>>> @@ -203,6 +236,14 @@ static const struct iio_chan_spec rpr0521_channels[] = {
>>>>  			BIT(IIO_CHAN_INFO_OFFSET) |
>>>>  			BIT(IIO_CHAN_INFO_SCALE),
>>>>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>>>> +		.scan_index = RPR0521_CHAN_INDEX_PXS,
>>>> +		.scan_type = {
>>>> +			.sign = 'u',
>>>> +			.realbits = 16,
>>>> +			.storagebits = 16,
>>>> +			.shift = 0,
>>>> +			.endianness = IIO_LE,
>>>> +		},
>>>>  	},
>>>>  	{
>>>>  		.type = IIO_INTENSITY,
>>>> @@ -212,6 +253,14 @@ static const struct iio_chan_spec rpr0521_channels[] = {
>>>>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>>>  			BIT(IIO_CHAN_INFO_SCALE),
>>>>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>>>> +		.scan_index = RPR0521_CHAN_INDEX_BOTH,
>>>> +		.scan_type = {
>>>> +			.sign = 'u',
>>>> +			.realbits = 16,
>>>> +			.storagebits = 16,
>>>> +			.shift = 0,
>>>> +			.endianness = IIO_LE,
>>>> +		},
>>>>  	},
>>>>  	{
>>>>  		.type = IIO_INTENSITY,
>>>> @@ -221,9 +270,154 @@ static const struct iio_chan_spec rpr0521_channels[] = {
>>>>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>>>  			BIT(IIO_CHAN_INFO_SCALE),
>>>>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>>>> +		.scan_index = RPR0521_CHAN_INDEX_IR,
>>>> +		.scan_type = {
>>>> +			.sign = 'u',
>>>> +			.realbits = 16,
>>>> +			.storagebits = 16,
>>>> +			.shift = 0,
>>> shift default makes sense as 0 so don't bother specifying it
>>> (will be set to 0 anyway)
>> Ack.
>>>> +			.endianness = IIO_LE,
>>>> +		},
>>>>  	},
>>>>  };
>>>>  
>>>> +static int rpr0521_set_power_state(struct rpr0521_data *data, bool on,
>>>> +				   u8 device_mask);
>>>> +static int rpr0521_als_enable(struct rpr0521_data *data, u8 status);
>>>> +static int rpr0521_pxs_enable(struct rpr0521_data *data, u8 status);
>>> These forward definitions rather look like they could be removed with a bit
>>> of reorganization fo the file.  Do that in preference to having these in
>>> the middle of the code.
>> Ok.
>>
>>>> +
>>>> +/* IRQ to trigger -handler */
>>> why the -?
>>>> +static irqreturn_t rpr0521_drdy_irq_handler(int irq, void *private)
>>>> +{
>>>> +	struct iio_dev *indio_dev = private;
>>>> +	struct rpr0521_data *data = iio_priv(indio_dev);
>>>> +
>>>> +	/* Notify trigger0 consumers/subscribers */
>>>> +	if (data->drdy_trigger_on)
>>>> +		iio_trigger_poll(data->drdy_trigger0);
>>> How else are you getting here? Also the core will be fine
>>> if nothing cares and the trigger is polled.
>>> If there is another cause, we aren't handling it so should claim
>>> to be doing so.
>> Sometimes there is static on line and interrupt is generated even though
>> sensor interrupt output is in high impedance mode. What I've seen it's
>> max 2 interrupts in second, usually none. This doesn't matter much for
>> stability if sensor is switched on. It just causes extra reads. But if
>> extra interrupt happens when sensor power is switched off it isn't there
>> to respond to i2c data reading.
>> I don't know enough to know if all systems can handle this gracefully or
>> not. That's why safe playing here.
>> I'm keeping it unless someone can confirm that 2Hz regmap_bulk_read in
>> trigger_consumer_handler will not be causing ill effects on system when
>> there is no answer from sensor.
> Perhaps add a comment to mention that an issue has been observed.
> Normally we don't put this sort of code in to protect against hardware
> bugs like this, but if you have a platform where it is true, then fine
> but it needs to be mentioned, so someone doesn't come along later
> and remove what looks like pointless code!

Ok.

>>>> +
>>>> +	return IRQ_HANDLED;
>>>> +}
>>>> +
>>>> +static irqreturn_t rpr0521_trigger_consumer_handler(int irq, void *p)
>>>> +{
>>>> +	struct iio_poll_func *pf = p;
>>>> +	struct iio_dev *indio_dev = pf->indio_dev;
>>>> +	struct rpr0521_data *data = iio_priv(indio_dev);
>>>> +	int ret;
>>>> +
>>>> +	u8 buffer[16]; /* 3 16-bit channels + padding + ts */
>>>> +
>>>> +	ret = regmap_bulk_read(data->regmap,
>>>> +		RPR0521_REG_PXS_DATA,
>>>> +		&buffer,
>>>> +		(3*2)+1);	/* 3 * 16-bit + (discarded) int clear reg. */
>>> kernel style is spaces around the * and +
>> Ack.
>>>> +	if (ret < 0)
>>>> +		goto done;
>>>> +
>>>> +	iio_push_to_buffers_with_timestamp(indio_dev,
>>>> +		buffer,
>>> Dont wrap more than you have two.  So make this two lines perhaps.
>>>> +		pf->timestamp);
>>>> +done:
>> Refactoring to v3 to get rid of done:
>>>> +	iio_trigger_notify_done(indio_dev->trig);
>>>> +
>>>> +	return IRQ_HANDLED;
>>>> +}
>>>> +
>>>> +static int rpr0521_write_int_enable(struct rpr0521_data *data)
>>>> +{
>>>> +	int err;
>>>> +
>>>> +	/* Interrupt after each measurement */
>>>> +	err = regmap_update_bits(data->regmap, RPR0521_REG_PXS_CTRL,
>>>> +		RPR0521_PXS_PERSISTENCE_MASK,
>>>> +		RPR0521_PXS_PERSISTENCE_DRDY);
>>>> +	err = err || regmap_update_bits(data->regmap, RPR0521_REG_INTERRUPT,
>>> umm. really?  All of them? Are we looking at a clear the whole register
>>> case?  If so we should probably only clear relevant ones..
>> Hmm. .  Valid point. In drdy case we can write what ever to latch and
>> mode. This will be cleaner with write instead up write_bits.
>> ==> change to v3
>>> I don't like these stacked error handlers (err = err | *).
>>> Just handle each err as and when.  It's more code, but easier
>>> to review / follow.
>> It's (err = err || *), bail out on first error.
>> Matter of taste, ack.
>>
>>>> +		RPR0521_INTERRUPT_INT_REASSERT_MASK |
>>>> +		RPR0521_INTERRUPT_INT_LATCH_MASK |
>>>> +		RPR0521_INTERRUPT_INT_TRIG_ALS_MASK |
>>>> +		RPR0521_INTERRUPT_INT_TRIG_PS_MASK,
>>>> +		RPR0521_INTERRUPT_INT_REASSERT_DISABLE |
>>>> +		RPR0521_INTERRUPT_INT_LATCH_ENABLE |
>>>> +		RPR0521_INTERRUPT_INT_TRIG_ALS_DISABLE |
>>>> +		RPR0521_INTERRUPT_INT_TRIG_PS_ENABLE
>>>> +		);
>>>> +	err = err || regmap_update_bits(data->regmap, RPR0521_REG_INTERRUPT,
>>>> +		RPR0521_INTERRUPT_INT_MODE_MASK,
>>>> +		RPR0521_INTERRUPT_INT_PS_OUTSIDE_DETECT);
>>>> +	if (err) {
>>>> +		dev_err(&data->client->dev, "Interrupt setup write fail.\n");
>>>> +		return -EBUSY;
>>>> +		}
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int rpr0521_write_int_disable(struct rpr0521_data *data)
>>>> +{
>>>> +	return regmap_update_bits(data->regmap, RPR0521_REG_INTERRUPT,
>>>> +				RPR0521_INTERRUPT_INT_TRIG_ALS_MASK |
>>>> +				RPR0521_INTERRUPT_INT_TRIG_PS_MASK,
>>>> +				RPR0521_INTERRUPT_INT_TRIG_ALS_DISABLE |
>>>> +				RPR0521_INTERRUPT_INT_TRIG_PS_DISABLE
>>>> +				);
>>>> +}
>>>> +
>>>> +/* Trigger -enable/disable */
>>>> +static int rpr0521_pxs_drdy_set_state(struct iio_trigger *trigger,
>>>> +	bool enable_drdy)
>>>> +{
>>> This may be called from the moment iio_trigger_register is called until
>>> the trigger is unregistered on remove.
>>>
>>> Could that potentially be a problem as it might occur after the device
>>> is powered off in remove?  Hard to be sure without diving into the data
>>> sheet.  If it if safe as it is, then use the devm functions as described
>>> below, but perhaps put a note here about the fact it is safe to have
>>> this potential race.
>> Sensor itself doesn't care much, but since measurement is enabled we are
>> draining power for nothing.
>> I didn't like to touch pm_ -stuff, since I didn't know much of it. But
>> now since I did, I think I found couple of bugs both in the current code
>> and new code.
>>
>> There is another thing for the order. Int pin keeps state on power down.
>> So shutting down sensor before clearing interrupt might cause power
>> drain also on interrupt line.
>>
>> ==>
>> Reordering the _probe() and _remove() for v3.
>> Adding int clear to poweroff.
>> Adding couple commits for pm bugfixes.
>>
>> One question though. Is it ok to register device first, and then
>> trigger/buffer stuff? For now it seems like correct order.
> No.  The moment the register occurs, it's exposed to userspace.
> The buffer at least is hidden until after that.

Ok, I already forgot this was  also said in:
http://lxr.free-electrons.com/source/drivers/iio/buffer/industrialio-triggered-buffer.c?v=4.4#L37
So, setup buffer first, then register device. And on remove, unregister
device first, then remove buffer.

> Trigger vs device is more a matter of convention. Tends to be easier to
> make sure the trigger register doesn't cause trouble if something tries
> to use it early than the whole device (the userspace surface is smaller).
>>>> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trigger);
>>>> +	struct rpr0521_data *data = iio_priv(indio_dev);
>>>> +	int err;
>>>> +
>>>> +	if (enable_drdy) {
>>>> +		/* ENABLE DRDY */
>>>> +		mutex_lock(&data->lock);
>>>> +		err = rpr0521_set_power_state(data, true,
>>>> +			(RPR0521_MODE_PXS_MASK & RPR0521_MODE_ALS_MASK));
>>>> +		mutex_unlock(&data->lock);
>>>> +		if (err)
>>>> +			goto rpr0521_set_state_err;
>>>> +		err = rpr0521_pxs_enable(data, RPR0521_MODE_PXS_ENABLE);
>> Removing rpr0521_[pxs/als]_[en/dis]able(), since they are by default
>> enabled from rpr0521_init and _set_power_state sets them on if pm has
>> disabled them.
>>>> +		if (err)
>>>> +			goto rpr0521_set_state_err;
>>>> +		err = rpr0521_als_enable(data, RPR0521_MODE_ALS_ENABLE);
>>>> +		if (err)
>>>> +			goto rpr0521_set_state_err;
>>>> +		err = rpr0521_write_int_enable(data);
>>>> +		if (err)
>>>> +			goto rpr0521_set_state_err;
>>>> +	} else {
>>>> +		/* DISABLE DRDY */
>>>> +		mutex_lock(&data->lock);
>>>> +		err = rpr0521_set_power_state(data, false,
>>>> +			(RPR0521_MODE_PXS_MASK & RPR0521_MODE_ALS_MASK));
>>>> +		mutex_unlock(&data->lock);
>>>> +		if (err)
>>>> +			goto rpr0521_set_state_err;
>>>> +		err = rpr0521_als_enable(data, RPR0521_MODE_ALS_DISABLE);
>>>> +		if (err)
>>>> +			goto rpr0521_set_state_err;
>>>> +		err = rpr0521_pxs_enable(data, RPR0521_MODE_PXS_DISABLE);
>>>> +		if (err)
>>>> +			goto rpr0521_set_state_err;
>>>> +		err = rpr0521_write_int_disable(data);
>>>> +		if (err)
>>>> +			goto rpr0521_set_state_err;
>>>> +	}
>>>> +	data->drdy_trigger_on = enable_drdy;
>>>> +	return 0;
>>>> +
>>>> +rpr0521_set_state_err:
>>>> +	dev_err(&data->client->dev, "rpr0521_pxs_drdy_set_state failed\n");
>>>> +	return err;
>>>> +}
>>>> +
>>>> +static const struct iio_trigger_ops rpr0521_trigger_ops = {
>>>> +	.set_trigger_state = rpr0521_pxs_drdy_set_state,
>>>> +	.owner = THIS_MODULE,
>>>> +	};
>>>> +
>>>>  static int rpr0521_als_enable(struct rpr0521_data *data, u8 status)
>>>>  {
>>>>  	int ret;
>>>> @@ -454,6 +648,9 @@ static int rpr0521_read_raw(struct iio_dev *indio_dev,
>>>>  		if (chan->type != IIO_INTENSITY && chan->type != IIO_PROXIMITY)
>>>>  			return -EINVAL;
>>>>  
>>>> +		if (iio_buffer_enabled(indio_dev))
>>>> +			return -EBUSY;
>>>> +
>>>>  		device_mask = rpr0521_data_reg[chan->address].device_mask;
>>>>  
>>>>  		mutex_lock(&data->lock);
>>>> @@ -664,20 +861,90 @@ static int rpr0521_probe(struct i2c_client *client,
>>>>  		return ret;
>>>>  	}
>>>>  
>>>> -	ret = pm_runtime_set_active(&client->dev);
>>>> -	if (ret < 0)
>>>> -		return ret;
>>>> +	/* IRQ to trigger setup */
>>>> +	if (client->irq) {
>>>> +		/* Trigger0 producer setup */
>>>> +		data->drdy_trigger0 = devm_iio_trigger_alloc(
>>>> +			indio_dev->dev.parent,
>>>> +			"%s-dev%d",
>>>> +			indio_dev->name,
>>>> +			indio_dev->id);
>>>> +		if (!data->drdy_trigger0) {
>>>> +			ret = -ENOMEM;
>>>> +			return ret;
>>>> +		}
>>>> +		data->drdy_trigger0->dev.parent = indio_dev->dev.parent;
>>>> +		data->drdy_trigger0->ops = &rpr0521_trigger_ops;
>>>> +		iio_trigger_set_drvdata(data->drdy_trigger0, indio_dev);
>>>> +
>>>> +		ret = iio_trigger_register(data->drdy_trigger0);
>>> devm_iio_trigger_register should be fine
>> See below.
>>>> +		if (ret) {
>>>> +			dev_err(&client->dev, "iio trigger register failed\n");
>>>> +			return ret;
>>>> +		}
>>>>  
>>>> +		/* Set trigger0 as default trigger (and inc refcount) */
>>>> +		indio_dev->trig = iio_trigger_get(data->drdy_trigger0);
>>>> +
>>>> +		/* Ties irq to trigger producer handler. */
>>>> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
>>>> +			rpr0521_drdy_irq_handler,
>>>> +			NULL,
>>>> +			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>>>> +			RPR0521_IRQ_NAME,
>>>> +			indio_dev);
>>>> +		if (ret < 0) {
>>>> +			dev_err(&client->dev, "request irq %d for trigger0 failed\n",
>>>> +				client->irq);
>>>> +			goto err_iio_trigger_put_unregister;
>>>> +			}
>>>> +		/*
>>>> +		 * Now whole pipe from physical interrupt (irq defined by
>>>> +		 * devicetree to device) to trigger0 output is set up.
>>>> +		 */
>>>> +
>>>> +		/* Trigger consumer setup */
>>>> +		ret = iio_triggered_buffer_setup(indio_dev,
>>>> +			&iio_pollfunc_store_time,
>>>> +			rpr0521_trigger_consumer_handler,
>>>> +			NULL);		//Use default _ops
>>>> +		if (ret < 0) {
>>>> +			dev_err(&client->dev, "iio triggered buffer setup failed\n");
>>>> +			/* Count on devm to free_irq */
>>>> +			goto err_iio_trigger_put_unregister;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	ret = pm_runtime_set_active(&client->dev);
>>>> +	if (ret < 0) {
>>>> +		dev_err(&client->dev, "set_active failed\n");
>>> I'm not particularly bothered either way by the change, but technically
>>> adding this error message is unconnected to the subject of this patch so
>>> should not be here.
>>>
>>>> +		goto err_iio_unregister_trigger_consumer;
>>>> +		}
>>>>  	pm_runtime_enable(&client->dev);
>>>>  	pm_runtime_set_autosuspend_delay(&client->dev, RPR0521_SLEEP_DELAY_MS);
>>>>  	pm_runtime_use_autosuspend(&client->dev);
>>>>  
>>>>  	return iio_device_register(indio_dev);
>>>> +
>>> One line is enough.
>> Ok.
>>>> +
>>> Use devm versions and this lot goes away.
>>>> +err_iio_unregister_trigger_consumer:
>>>> +	iio_triggered_buffer_cleanup(indio_dev);
>>>> +err_iio_trigger_put_unregister:
>>>> +	if (indio_dev->trig) {
>>>> +		iio_trigger_put(indio_dev->trig);
>>>> +		indio_dev->trig = NULL;
>>>> +		}
>>>> +	if (data->drdy_trigger0) {
>>>> +		iio_trigger_unregister(data->drdy_trigger0);
>>>> +		data->drdy_trigger0 = NULL;
>>>> +		}
>>>> +	return ret;
>>>>  }
>>>>  
>>>>  static int rpr0521_remove(struct i2c_client *client)
>>>>  {
>>>>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>>>> +	struct rpr0521_data *data = iio_priv(indio_dev);
>>>>  
>>>>  	iio_device_unregister(indio_dev);
>>>>  
>>>> @@ -685,8 +952,18 @@ static int rpr0521_remove(struct i2c_client *client)
>>>>  	pm_runtime_set_suspended(&client->dev);
>>>>  	pm_runtime_put_noidle(&client->dev);
>>>>  
>>>> -	rpr0521_poweroff(iio_priv(indio_dev));
>>>> +	rpr0521_poweroff(data);
>>>>  
>>>> +	iio_triggered_buffer_cleanup(indio_dev);
>>>> +	if (indio_dev->trig) {
>>>> +		iio_trigger_put(indio_dev->trig);
>>>> +		indio_dev->trig = NULL;
>>>> +		}
>>>> +	if (data->drdy_trigger0) {
>>>> +		iio_trigger_unregister(data->drdy_trigger0);
>>>> +		data->drdy_trigger0 = NULL;
>>>> +		}
>>>> +	/* Rest of the cleanup is done by devm. */
>>> Givem where you have them, I don't think anything stops you using devm to
>>> handle the trigger registration and buffer cleanup.  No need to set
>>> either of hte magic flags to NULL as far as I can see...
>> For a second let's think we removed this line
>>
>>>> +	if (data->drdy_trigger_on)
>> from irq_handler().
>> If irq handler is not yet unregistered by devm_ and thus interrupt can
>> be generated (f.ex. by static),
> This is one of the nasty reasons why we tend to not spend all that much
> effort dealing with false interrupts. It's almost always possible to find
> a race where they will crash things.
>> then what does
>> iio_trigger_poll(data->drdy_trigger0) do with this unregistered trigger
>> pointer? If call is ok, then no need for NULL I guess.
> Firstly there is always a race here if this is an issue, you are just
> making it smaller.   This is all going to occur very fast in any case.
>
> Still all irrelevant anyway ;)

Removing NULL's for v3.

>>> Use the devm versions and remove should be unchanged...
>> Copy-paste from another post:
>>
>> Can't, since no devm_ on kernel 4.4.
>> I could make another commit to change to devm_, but I don't have target
>> to test it.
>>
>>> OK. We can leave it for someone else to clean up in future.
>>> However - look above - there is a race in how you have it currently ordered
>>> that means you should order it differently and not use the devm versions.
>> Ack.
>>
>>>>  	return 0;
>>>>  }
>>>>  
>>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

