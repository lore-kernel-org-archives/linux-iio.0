Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2806 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755146AbaLHLru (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 8 Dec 2014 06:47:50 -0500
Date: Mon, 8 Dec 2014 13:48:59 +0200
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: driver for Semtech SX9500 proximity solution
Message-ID: <20141208114859.GA2066@vdogaru>
References: <1417006231-17952-1-git-send-email-vlad.dogaru@intel.com>
 <548444DD.1030003@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <548444DD.1030003@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Dec 07, 2014 at 01:15:25PM +0100, Hartmut Knaack wrote:
> Vlad Dogaru schrieb am 26.11.2014 um 13:50:
> > Supports buffering, IIO events and changing sampling frequency.
> > 
> > Datasheet available at:
> > http://www.semtech.com/images/datasheet/sx9500_ag.pdf
> > 
> Please find some issues and suggestions inline.

Thanks for the review.  I'll answer some points inline and hold off the
next version until I hear back from you.

As for the points I didn't address, I will fix them in the next
iteration.

[snip]

> > +#define SX9500_CHANNEL(idx)					\
> > +	{							\
> > +		.type = IIO_PROXIMITY,				\
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> > +		.indexed = 1,					\
> > +		.channel = idx,					\
> > +		.event_spec = sx9500_events,			\
> > +		.num_event_specs = 1,				\
> = ARRAY_SIZE(sx9500_events)?
> > +		.scan_index = idx,				\
> > +		.scan_type = {					\
> > +			.sign = 'u',				\
> Datasheet says: Signed, 2's complement format.

See my comment below.

[snip]

> > +static int sx9500_read_proximity(struct sx9500_data *data,
> > +				 const struct iio_chan_spec *chan,
> > +				 int *val)
> > +{
> > +	int ret;
> > +	__be16 regval;
> > +
> > +	ret = regmap_write(data->regmap, SX9500_REG_SENSOR_SEL, chan->channel);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = regmap_bulk_read(data->regmap, SX9500_REG_USE_MSB, &regval, 2);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*val = 32767 - (s16)be16_to_cpu(regval);
> Unless I'm missing something, it should be:
> *val = (s16)be16_to_cpu(regval);

I've chosen the formula so that when a finger is touching the sensor,
the reported value is 0; as the distance grows, so does the value.
Your version would report a large value when a finger is touching the
sensor, with the value decreasing as distance grows.

The ABI documentation of in_proximity_raw mentions that, where possible,
the value after scaling should be meters.  In this case it is not
possible to convert the readings to meters, but I think it would be
beneficial to have a value that at least behaves like a distance.

[snip]

> > +static irqreturn_t sx9500_irq_handler(int irq, void *private)
> > +{
> > +	struct iio_dev *indio_dev = private;
> > +	struct sx9500_data *data = iio_priv(indio_dev);
> > +
> > +	if (data->trigger_enabled)
> > +		iio_trigger_poll(data->trig);
> > +
> > +	/*
> > +	 * Even if no event is enabled, we need to wake the thread to
> > +	 * clear the interrupt state by reading SX9500_REG_IRQ_SRC.  It
> Double whitespace.

I've consistently used double spaces after full stops in the comments
(and in my emails).  AFAICT, this is an open discussion [1].  The kernel
uses both standards, so as long as comments across a file are consistent
I don't see a problem with using double spaces to separate sentences.

[1] http://en.wikipedia.org/wiki/Sentence_spacing#Digital_age

> > +	 * is not possible to do that here because regmap_read takes a
> > +	 * mutex.
> > +	 */
> > +	return IRQ_WAKE_THREAD;
> > +}
> > +
> > +static irqreturn_t sx9500_irq_thread_handler(int irq, void *private)
> > +{
> > +	struct iio_dev *indio_dev = private;
> > +	struct sx9500_data *data = iio_priv(indio_dev);
> > +	int ret, chan;
> chan could be unsigned.
> > +	unsigned int val;
> > +
> > +	mutex_lock(&data->mutex);
> > +
> > +	ret = regmap_read(data->regmap, SX9500_REG_IRQ_SRC, &val);
> > +	if (ret < 0) {
> > +		dev_err(&data->client->dev, "i2c transfer error in irq\n");
> > +		goto out;
> > +	}
> > +
> > +	if (!(val & (SX9500_CLOSE_IRQ | SX9500_FAR_IRQ)))
> > +		goto out;
> > +
> > +	ret = regmap_read(data->regmap, SX9500_REG_STAT, &val);
> > +	if (ret < 0) {
> > +		dev_err(&data->client->dev, "i2c transfer error in irq\n");
> > +		goto out;
> > +	}
> > +
> > +	val >>= SX9500_PROXSTAT_SHIFT;
> > +	for (chan = 0; chan < SX9500_NUM_CHANNELS; chan++) {
> > +		int dir;
> > +		u64 ev;
> > +		u8 new_prox = !(val & (1 << chan));
> new_prox should be bool. (1 << chan) could be expressed as BIT(chan).
> Why the negation? If PROXSTATx gets set, doesn't this indicate, that an object
> gets close to the sensor? Shouldn't such an event cause IIO_EV_DIR_RISING?

Maybe I'm misreading the ABI, but if PROXSTATx is set, it means
proximity is detected.  If it wasn't detected previously, this means
that an object has moved closer to the sensor, thus the distance to the
object has decreased and we should cause an IIO_EV_DIR_FALLING.

[snip]

> > +	any_active = 0;
> true or false should be used for bools, but better initialize during declaration.
> > +	for (i = 0; i < SX9500_NUM_CHANNELS; i++)
> > +		if (data->event_enabled[chan->channel]) {
> Don't you mean data->event_enabled[i]?

I definitely do, that was silly of me :)

> > +			any_active = true;
> > +			break;
> > +		}
> > +
> > +	irqmask = SX9500_CLOSE_IRQ | SX9500_FAR_IRQ;
> > +	ret = regmap_update_bits(data->regmap, SX9500_REG_IRQ_MSK,
> > +				 irqmask, any_active ? irqmask : 0);
> > +
> > +	mutex_unlock(&data->mutex);
> > +
> > +	return ret;
> > +}
> > +
> > +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
> > +	"2.500000 3.333333 5 6.666666 8.333333 11.111111 16.666666 33.333333");
> > +
> > +static struct attribute *sx9500_attributes[] = {
> > +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> > +	NULL,
> > +};
> > +
> > +static const struct attribute_group sx9500_attribute_group = {
> > +	.attrs = sx9500_attributes,
> > +};
> > +
> > +static const struct iio_info sx9500_info = {
> > +	.driver_module = THIS_MODULE,
> > +	.attrs = &sx9500_attribute_group,
> > +	.read_raw = &sx9500_read_raw,
> > +	.write_raw = &sx9500_write_raw,
> > +	.read_event_config = &sx9500_read_event_config,
> > +	.write_event_config = &sx9500_write_event_config,
> > +};
> > +
> > +static int sx9500_set_trigger_state(struct iio_trigger *trig,
> > +				    bool state)
> > +{
> > +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> > +	struct sx9500_data *data = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	mutex_lock(&data->mutex);
> > +
> > +	ret = regmap_update_bits(data->regmap, SX9500_REG_IRQ_MSK,
> > +				 SX9500_CONVDONE_IRQ,
> > +				 state ? SX9500_CONVDONE_IRQ : 0);
> > +	data->trigger_enabled = state;
> Only set data->trigger_enabled if regmap_update_bits was successful.
> > +
> > +	mutex_unlock(&data->mutex);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct iio_trigger_ops sx9500_trigger_ops = {
> > +	.set_trigger_state = sx9500_set_trigger_state,
> > +	.owner = THIS_MODULE,
> > +};
> > +
> > +static irqreturn_t sx9500_trigger_handler(int irq, void *private)
> > +{
> > +	struct iio_poll_func *pf = private;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct sx9500_data *data = iio_priv(indio_dev);
> > +	s16 *buf;
> > +	int val, bit, ret, i = 0;
> > +
> > +	buf = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> Use kzalloc for a clean buffer?

Is this just cosmetic or am I missing something?  Assuming that
scan_bytes has the correct value, won't all of 'buf' be written with
channel data and the timestamp?

[snip]

> > +static int sx9500_init_device(struct iio_dev *indio_dev)
> > +{
> > +	struct sx9500_data *data = iio_priv(indio_dev);
> > +	int ret, i, num_defaults;
> > +	unsigned int val;
> > +
> > +	ret = regmap_write(data->regmap, SX9500_REG_IRQ_MSK, 0);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = regmap_write(data->regmap, SX9500_REG_RESET,
> > +			   SX9500_SOFT_RESET);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = regmap_read(data->regmap, SX9500_REG_IRQ_SRC, &val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	num_defaults = ARRAY_SIZE(sx9500_default_regs);
> num_defaults doesn't serve an essential purpose.

Thought I'd avoid it being calculated at every step of the for loop.
But it's not on a hot path, so I'll get rid of it.

[snip]

> > +static const struct acpi_device_id sx9500_acpi_match[] = {
> > +	{"SSX9500", 0}, /* TODO is there a better ACPI handle? */
> Is this a typo? Shouldn't it be "SX9500"?

ACPI rules prohibit such a device ID:

ssdt.dsl     11:                 Name (_HID, "SX9500")
Error    6033 -                                    ^ _HID string must be
exactly 7 or 8 characters (SX9500)

I was unable to find a common method to fix such an issue and was hoping
someone can help, that's why I left the TODO in the code.
