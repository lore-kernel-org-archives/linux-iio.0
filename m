Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38877 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754231AbaHNRXB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Aug 2014 13:23:01 -0400
Message-ID: <53ECF070.5040304@kernel.org>
Date: Thu, 14 Aug 2014 18:22:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: balbi@ti.com
CC: linux-iio@vger.kernel.org, pmeerw@pmeerw.net
Subject: Re: [PATCH v3] iio: ligth: add support for TI's opt3001 ligth sensor
References: <1407940605-12270-1-git-send-email-balbi@ti.com> <53ECE90A.8010609@kernel.org> <20140814170530.GB1445@saruman.home>
In-Reply-To: <20140814170530.GB1445@saruman.home>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/08/14 18:05, Felipe Balbi wrote:
> hi,
> 
> On Thu, Aug 14, 2014 at 05:51:22PM +0100, Jonathan Cameron wrote:
>> On 13/08/14 15:36, Felipe Balbi wrote:
>>> TI's opt3001 light sensor is a simple and yet powerful
>>> little device. The device provides 99% IR rejection,
>>> Automatic full-scale, very low power consumption and
>>> measurements from 0.01 to 83k lux.
>>>
>>> This patch adds support for that device using the IIO
>>> framework.
>>>
>>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>> Please fix your patch title spelling of light!
> 
> alright done and sent another version too.
> 
>> I'm not keen on the ordering during remove and
>> your use of hysteresis does not conform to the ABI so please
>> take a look at that and the other drivers that make use of it.
> 
> see below
> 
>> Hystersis is documented in Documentation/ABI/testing/sysfs-bus-iio
>>
>> Specifies the hysteresis of threshold that the device is comparing
>> 	against for the events enabled by
>> 	<type>Y[_name]_thresh[_(rising|falling)]_hysteresis.
> 
> this is exactly what the driver is doing, read again
This is really hard without access to the datasheet.  It appeared you were
simply enabling hystersis on an event if the threshold was written to that.

The threshold would be the one written by using the value attribute.

So right now if you set hystersis to 10 then value will also be set to 10.

Hence, if the value reaches 10 once.  An event is triggered.  After that
for another event the value will have to hit 10 - 10 = 0 before again
passing 10.

Is this really what is happening?
> 
>> 	If separate attributes exist for the two directions, but
>> 	direction is not specified for this attribute, then a single
>> 	hysteresis value applies to both directions.
>> 	For falling events the hysteresis is added to the _value attribute for
>> 	this event to get the upper threshold for when the event goes back to
>> 	normal, for rising events the hysteresis is subtracted from the _value
>> 	attribute. E.g. if in_voltage0_raw_thresh_rising_value is set to 1200
>> 	and in_voltage0_raw_thresh_rising_hysteresis is set to 50. The event
>> 	will get activated once in_voltage0_raw goes above 1200 and will become
>> 	deactived again once the value falls below 1150.
>>
>> Also, I'll probably wait for Peter to take a look at any final version
>> (would like to credit him for his work reviewing the earlier versions!)
>> Not as though we are likely to be in a rush at this time in the cycle.
> 
> right
> 
>>> +static int opt3001_read_event_value(struct iio_dev *iio,
>>> +		const struct iio_chan_spec *chan, enum iio_event_type type,
>>> +		enum iio_event_direction dir, enum iio_event_info info,
>>> +		int *val, int *val2)
>>> +{
>>> +	struct opt3001 *opt = iio_priv(iio);
>>> +	int ret = IIO_VAL_INT_PLUS_MICRO;
>>> +
>>> +	mutex_lock(&opt->lock);
>>> +
>>> +	switch (dir) {
>>> +	case IIO_EV_DIR_RISING:
>> This should have separate handling for the hyseresis and value attributes
>> as they should return the relevant numeric values...
> 
> the register is the same for both cases.

> 
>>> +static int opt3001_write_event_value(struct iio_dev *iio,
>>> +		const struct iio_chan_spec *chan, enum iio_event_type type,
>>> +		enum iio_event_direction dir, enum iio_event_info info,
>>> +		int val, int val2)
>>> +{
>>> +	struct opt3001 *opt = iio_priv(iio);
>>> +	int ret = 0;
>>> +
>>> +	u16 mantissa;
>>> +	u16 value;
>>> +	u16 reg;
>>> +
>>> +	u8 exponent;
>>> +
>>> +	mutex_lock(&opt->lock);
>>> +
>>> +	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
>>> +	if (ret < 0) {
>>> +		dev_err(opt->dev, "failed to read register %02x\n",
>>> +				OPT3001_CONFIGURATION);
>>> +		goto err;
>>> +	}
>>> +
>>> +	reg = ret;
>>> +	if (info == IIO_EV_INFO_HYSTERESIS)
>> Hysteresis is typically a numeric value.  The options here should be either 0
>> (for none) or the value of hysteresis applied (how far we have to back off
>> from the thereshold to trigger the event).  It's not a boolean and even
>> if it were enabling it or not based on last write is not a good way of doing
>> things.
> 
> this is just to tell me if I should set the bit in the register or not.
> IOW, this is just a driver internal flag, note that it doesn't get
> returned to userland in no occasion.
> 
> See write_even_config below
> 
>>> +static int opt3001_write_event_config(struct iio_dev *iio,
>>> +		const struct iio_chan_spec *chan, enum iio_event_type type,
>>> +		enum iio_event_direction dir, int state)
>>> +{
>>> +	struct opt3001 *opt = iio_priv(iio);
>>> +	int ret;
>>> +	u16 mode;
>>> +	u16 reg;
>>> +
>>> +	if (state && opt->mode == OPT3001_CONFIGURATION_M_CONTINUOUS)
>>> +		return 0;
>>> +
>>> +	if (!state && opt->mode == OPT3001_CONFIGURATION_M_SHUTDOWN)
>>> +		return 0;
>>> +
>>> +	mode = state ? OPT3001_CONFIGURATION_M_CONTINUOUS
>>> +		: OPT3001_CONFIGURATION_M_SHUTDOWN;
>>> +
>>> +	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
>>> +	if (ret < 0) {
>>> +		dev_err(opt->dev, "failed to read register %02x\n",
>>> +				OPT3001_CONFIGURATION);
>>> +		return ret;
>>> +	}
>>> +
>>> +	reg = ret;
>>> +	opt3001_set_mode(opt, &reg, mode);
>>> +
>>> +	if (opt->hysteresis)
>>> +		reg |= OPT3001_CONFIGURATION_L;
>>> +	else
>>> +		reg &= ~OPT3001_CONFIGURATION_L;
> 
> here, I need to know if I have to set this bit or not. When it comes to
> values passed from sysfs, the register that gets written is the same
> hysteresis or not.
> 
>>> +static int opt3001_read_id(struct opt3001 *opt)
>>> +{
>>> +	char manufacturer[2];
>>> +	u16 device_id;
>>> +	int ret;
>>> +
>>> +	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_MANUFACTURER_ID);
>>> +	if (ret < 0) {
>>> +		dev_err(opt->dev, "failed to read register %02x\n",
>>> +				OPT3001_MANUFACTURER_ID);
>>> +		return ret;
>>> +	}
>>> +
>>> +	manufacturer[0] = ret >> 8;
>>> +	manufacturer[1] = ret & 0xff;
>> I would be a little 'unusual' but you could use an endian conversion here :)
>> Perhaps better to have the clarity of the way you have done it!
> 
> byte ordering is already handled by read_word_swapped, though.
Fair point.  Not an endian conversion, but rather an evil bit of type
casting that isn't worth bothering with.
> 
>>> +static int opt3001_probe(struct i2c_client *client,
>>> +		const struct i2c_device_id *id)
>>> +{
>>> +	struct device *dev = &client->dev;
>>> +
>>> +	struct iio_dev *iio;
>>> +	struct opt3001 *opt;
>>> +	int irq = client->irq;
>>> +	int ret;
>>> +
>>> +	iio = devm_iio_device_alloc(dev, sizeof(*opt));
>>> +	if (!iio)
>>> +		return -ENOMEM;
>>> +
>>> +	opt = iio_priv(iio);
>>> +	opt->client = client;
>>> +	opt->dev = dev;
>>> +
>>> +	mutex_init(&opt->lock);
>>> +	i2c_set_clientdata(client, opt);
>>> +
>>> +	ret = opt3001_read_id(opt);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = opt3001_configure(opt);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	iio->name = client->name;
>>> +	iio->channels = opt3001_channels;
>>> +	iio->num_channels = ARRAY_SIZE(opt3001_channels);
>>> +	iio->dev.parent = dev;
>>> +	iio->modes = INDIO_DIRECT_MODE;
>>> +	iio->info = &opt3001_info;
>>> +
>>> +	ret = devm_iio_device_register(dev, iio);
>>> +	if (ret) {
>>> +		dev_err(dev, "failed to register IIO device\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = devm_request_threaded_irq(dev, irq, NULL, opt3001_irq,
>>> +			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
>>> +			| IRQF_ONESHOT, "opt3001", iio);
>>> +	if (ret) {
>>> +		dev_err(dev, "failed to request IRQ #%d\n", irq);
>>> +		return ret;
>>> +	}
>>> +
>>> +	return 0;
>>> +
>>> +}
>>> +
>>> +static int opt3001_remove(struct i2c_client *client)
>>> +{
>>> +	struct opt3001 *opt = i2c_get_clientdata(client);
>>> +	int ret;
>>> +	u16 reg;
>>> +
>>
>> So here you are shutting down the part before removing the userspace interfaces
>> (due to using the devm_iio_unregister).  I'm guessing this might create some
>> interesting race conditions.  Would prefer to see non devm versions of the
>> register and irq request to ensure the ordering is exactly what we would
>> expect.
> 
> this will cause no problems whatsoever. The device is *always* shutdown
> unless I left a continuous transfer running. This is coping with that
> only situation.
Hmm. So shutdown in this case is fairly minor and doesn't effect register
reads for example.  Fair enough.
> It's also unnecessary to check if we have a continuous
> transfer running because shutting down something which is already
> shutdown won't cause any problems with this device.
> 
> Dropping devm_* would just add pointless complexity to the remove
> function.

But make it obviously correct, which it isn't right now.  For the
cost of about 4 lines of code...


