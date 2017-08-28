Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:38542 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751172AbdH1QXx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2017 12:23:53 -0400
Date: Mon, 28 Aug 2017 12:23:45 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        benjamin.gaignard@linaro.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: 104-quad-8: Add IIO generic counter interface
 support
Message-ID: <20170828162334.GA17815@sophia>
References: <cover.1501516678.git.vilhelm.gray@gmail.com>
 <d6aa01425b819fc8c29bf563e11de90e680e0885.1501516678.git.vilhelm.gray@gmail.com>
 <20170820131118.13f99bbd@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170820131118.13f99bbd@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Aug 20, 2017 at 01:11:18PM +0100, Jonathan Cameron wrote:
>On Mon, 31 Jul 2017 12:03:46 -0400
>William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>
>> This patch adds support for the IIO generic counter interface to the
>> 104-QUAD-8 driver. The existing 104-QUAD-8 device interface should not
>> be affected by this patch; all changes are intended as supplemental
>> additions as perceived by the user.
>> 
>> IIO Counter Signals are defined for all quadrature input pairs
>> (A and B), as well as index input lines. However, IIO Counter Triggers
>> are not created for the index input Signals. IIO Counter Values are
>> created for the eight quadrature channel counts, and their respective
>> Signals are associated via IIO Counter Triggers.
>> 
>> The new generic counter interface sysfs attributes expose the same
>> functionality and data available via the existing 104-QUAD-8 device
>> interface. Four IIO Counter Value function modes are available,
>> correlating to the four possible quadrature mode configurations:
>> "non-quadrature," "quadrature x1," "quadrature x2," and "quadrature x4."
>> 
>> A quad8_remove function is defined to call iio_counter_unregister. This
>> function can be eliminated once a devm_iio_counter_register function is
>> defined.
>> 
>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>
>A good example.
>
>I think it does make it clear that we need to be very careful on how much of
>the interface is defined by freeform strings.  Even if we export other means
>of establishing the associations to userspace, the moment there are strings
>available giving them names, software will start to use those.
>
>May be fine but we need to be very careful.

I would like to limit the amount of strings as well; the availability of
freeform strings has an unfortunate tendency to create situations where
different drivers form separate conventions for duplicate functionality.

The reason freeform strings are available for the generic counter
interface is to provide the flexibility to support more complex classes
of counters. More specific counter class interfaces such as the future
quadrature counter interface will likely expose predefined constants
rather than allow drivers to create their own strings. In general
though, I believe your warning is a good word of caution and I'll keep
an eye on reducing the amount of freeform strings we allow.

In truth, while this is a good example of how a driver would utilize the
generic counter interface with real hardware, it's not a perfect case
for quadrature counters in general. As you noticed, the dynamic aspects
of the generic counter interface are not needed by the 104-QUAD-8. The
future quadrature counter interface would be more fitting for the
104-QUAD-8.

In addition, I may provide a dummy software counter driver in version 2
of this patchset to showcase and exemplify the functionality of the
generic counter interface more directly and aptly.

Sincerely,

William Breathitt Gray

>
>Jonathan
>
>> ---
>>  drivers/iio/counter/104-quad-8.c | 306 ++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 289 insertions(+), 17 deletions(-)
>> 
>> diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-quad-8.c
>> index ba3d9030cd51..72b88b7de5b3 100644
>> --- a/drivers/iio/counter/104-quad-8.c
>> +++ b/drivers/iio/counter/104-quad-8.c
>> @@ -16,6 +16,7 @@
>>  #include <linux/bitops.h>
>>  #include <linux/device.h>
>>  #include <linux/errno.h>
>> +#include <linux/iio/counter.h>
>>  #include <linux/iio/iio.h>
>>  #include <linux/iio/types.h>
>>  #include <linux/io.h>
>> @@ -24,6 +25,7 @@
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>>  #include <linux/moduleparam.h>
>> +#include <linux/string.h>
>>  #include <linux/types.h>
>>  
>>  #define QUAD8_EXTENT 32
>> @@ -37,6 +39,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
>>  
>>  /**
>>   * struct quad8_iio - IIO device private data structure
>> + * @counter:		instance of the iio_counter
>>   * @preset:		array of preset values
>>   * @count_mode:		array of count mode configurations
>>   * @quadrature_mode:	array of quadrature mode configurations
>> @@ -48,6 +51,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
>>   * @base:		base port address of the IIO device
>>   */
>>  struct quad8_iio {
>> +	struct iio_counter counter;
>>  	unsigned int preset[QUAD8_NUM_COUNTERS];
>>  	unsigned int count_mode[QUAD8_NUM_COUNTERS];
>>  	unsigned int quadrature_mode[QUAD8_NUM_COUNTERS];
>> @@ -528,33 +532,289 @@ static const struct iio_chan_spec quad8_channels[] = {
>>  	QUAD8_COUNT_CHAN(7), QUAD8_INDEX_CHAN(7)
>>  };
>>  
>> +static int quad8_signal_read(struct iio_counter *counter,
>> +	struct iio_counter_signal *signal, int *val, int *val2)
>> +{
>> +	struct quad8_iio *const priv = counter->driver_data;
>> +
>> +	if (signal->id < 16)
>> +		return -EINVAL;
>> +
>> +	*val = !!(inb(priv->base + 0x16) & BIT(signal->id - 16));
>> +
>> +	return IIO_VAL_INT;
>> +}
>> +
>> +static int quad8_trigger_mode_get(struct iio_counter *counter,
>> +	struct iio_counter_value *value, struct iio_counter_trigger *trigger)
>> +{
>> +	struct quad8_iio *const priv = counter->driver_data;
>> +	const unsigned int mode = priv->quadrature_mode[value->id];
>> +	const unsigned int scale = priv->quadrature_scale[value->id];
>> +	unsigned int direction;
>> +	const unsigned int flag_addr = priv->base + 2 * value->id + 1;
>> +	const int signal_id = trigger->signal->id % 2;
>> +
>> +	if (mode)
>> +		switch (scale) {
>> +		case 0:
>> +			/* U/D flag: 1 = up, 0 = down */
>> +			/* direction: 0 = up, 1 = down */
>> +			direction = !(inb(flag_addr) & BIT(5));
>> +			if (!signal_id)
>> +				return direction + 1;
>> +			break;
>> +		case 1:
>> +			if (!signal_id)
>> +				return 3;
>> +			break;
>> +		case 2:
>> +			return 3;
>> +		}
>> +	else
>> +		if (!signal_id)
>> +			return 1;
>> +
>> +	return 0;
>The meaning of the return values in here is obscure to put
>it lightly.  Use and enum or defines or something to make it clear
>what is going on!  Even comments would help.
>> +}
>> +
>> +static int quad8_value_read(struct iio_counter *counter,
>> +	struct iio_counter_value *value, int *val, int *val2)
>> +{
>> +	struct quad8_iio *const priv = counter->driver_data;
>> +	const int base_offset = priv->base + 2 * value->id;
>> +	unsigned int flags;
>> +	unsigned int borrow;
>> +	unsigned int carry;
>> +	int i;
>> +
>> +	flags = inb(base_offset + 1);
>> +	borrow = flags & BIT(0);
>> +	carry = !!(flags & BIT(1));
>> +
>> +	/* Borrow XOR Carry effectively doubles count range */
>> +	*val = (borrow ^ carry) << 24;
>> +
>> +	/* Reset Byte Pointer; transfer Counter to Output Latch */
>> +	outb(0x11, base_offset + 1);
>> +
>> +	for (i = 0; i < 3; i++)
>> +		*val |= (unsigned int)inb(base_offset) << (8 * i);
>> +
>> +	return IIO_VAL_INT;
>> +}
>> +
>> +static int quad8_value_write(struct iio_counter *counter,
>> +	struct iio_counter_value *value, int val, int val2)
>> +{
>> +	struct quad8_iio *const priv = counter->driver_data;
>> +	const int base_offset = priv->base + 2 * value->id;
>> +	int i;
>> +
>> +	/* Only 24-bit values are supported */
>> +	if ((unsigned int)val > 0xFFFFFF)
>> +		return -EINVAL;
>> +
>> +	/* Reset Byte Pointer */
>> +	outb(0x01, base_offset + 1);
>> +
>> +	/* Counter can only be set via Preset Register */
>> +	for (i = 0; i < 3; i++)
>> +		outb(val >> (8 * i), base_offset);
>> +
>> +	/* Transfer Preset Register to Counter */
>> +	outb(0x08, base_offset + 1);
>> +
>> +	/* Reset Byte Pointer */
>> +	outb(0x01, base_offset + 1);
>> +
>> +	/* Set Preset Register back to original value */
>> +	val = priv->preset[value->id];
>> +	for (i = 0; i < 3; i++)
>> +		outb(val >> (8 * i), base_offset);
>> +
>> +	/* Reset Borrow, Carry, Compare, and Sign flags */
>> +	outb(0x02, base_offset + 1);
>> +	/* Reset Error flag */
>> +	outb(0x06, base_offset + 1);
>> +
>> +	return 0;
>> +}
>> +
>> +static int quad8_value_function_set(struct iio_counter *counter,
>> +	struct iio_counter_value *value, unsigned int mode)
>> +{
>> +	struct quad8_iio *const priv = counter->driver_data;
>> +	const unsigned int mode_cfg = mode << 3 |
>> +		priv->count_mode[value->id] << 1;
>> +	const unsigned int idr_cfg = priv->index_polarity[value->id] << 1;
>> +	const int base_offset = priv->base + 2 * value->id + 1;
>> +
>> +	if (mode)
>> +		priv->quadrature_scale[value->id] = mode - 1;
>> +	else {
>> +		/* Quadrature scaling only available in quadrature mode */
>> +		priv->quadrature_scale[value->id] = 0;
>> +
>> +		/* Synchronous function not supported in non-quadrature mode */
>> +		if (priv->synchronous_mode[value->id]) {
>> +			priv->synchronous_mode[value->id] = 0;
>> +			outb(0x60 | idr_cfg, base_offset);
>> +		}
>> +	}
>> +
>> +	priv->quadrature_mode[value->id] = !!mode;
>> +
>> +	/* Load mode configuration to Counter Mode Register */
>> +	outb(0x20 | mode_cfg, base_offset);
>> +
>> +	return 0;
>> +}
>> +
>> +static int quad8_value_function_get(struct iio_counter *counter,
>> +	struct iio_counter_value *value)
>> +{
>> +	struct quad8_iio *const priv = counter->driver_data;
>> +	unsigned int quadrature_mode = priv->quadrature_mode[value->id];
>> +
>> +	return (quadrature_mode) ? priv->quadrature_scale[value->id] + 1 : 0;
>> +}
>> +
>> +static const struct iio_counter_ops quad8_ops = {
>> +	.signal_read = quad8_signal_read,
>> +	.trigger_mode_get = quad8_trigger_mode_get,
>> +	.value_read = quad8_value_read,
>> +	.value_write = quad8_value_write,
>> +	.value_function_set = quad8_value_function_set,
>> +	.value_function_get = quad8_value_function_get
>> +};
>> +
>> +static const char *const quad8_function_modes[] = {
>> +	"non-quadrature",
>> +	"quadrature x1",
>> +	"quadrature x2",
>> +	"quadrature x4"
>> +};
>> +
>> +#define QUAD8_SIGNAL(_id, _name) {	\
>> +	.id = _id,			\
>> +	.name = _name			\
>> +}
>> +
>> +static const struct iio_counter_signal quad8_signals[] = {
>> +	QUAD8_SIGNAL(0, "Channel 1 Quadrature A"),
>> +	QUAD8_SIGNAL(1, "Channel 1 Quadrature B"),
>> +	QUAD8_SIGNAL(2, "Channel 2 Quadrature A"),
>> +	QUAD8_SIGNAL(3, "Channel 2 Quadrature B"),
>> +	QUAD8_SIGNAL(4, "Channel 3 Quadrature A"),
>> +	QUAD8_SIGNAL(5, "Channel 3 Quadrature B"),
>> +	QUAD8_SIGNAL(6, "Channel 4 Quadrature A"),
>> +	QUAD8_SIGNAL(7, "Channel 4 Quadrature B"),
>> +	QUAD8_SIGNAL(8, "Channel 5 Quadrature A"),
>> +	QUAD8_SIGNAL(9, "Channel 5 Quadrature B"),
>> +	QUAD8_SIGNAL(10, "Channel 6 Quadrature A"),
>> +	QUAD8_SIGNAL(11, "Channel 6 Quadrature B"),
>> +	QUAD8_SIGNAL(12, "Channel 7 Quadrature A"),
>> +	QUAD8_SIGNAL(13, "Channel 7 Quadrature B"),
>> +	QUAD8_SIGNAL(14, "Channel 8 Quadrature A"),
>> +	QUAD8_SIGNAL(15, "Channel 8 Quadrature B"),
>> +	QUAD8_SIGNAL(16, "Channel 1 Index"),
>> +	QUAD8_SIGNAL(17, "Channel 2 Index"),
>> +	QUAD8_SIGNAL(18, "Channel 3 Index"),
>> +	QUAD8_SIGNAL(19, "Channel 4 Index"),
>> +	QUAD8_SIGNAL(20, "Channel 5 Index"),
>> +	QUAD8_SIGNAL(21, "Channel 6 Index"),
>> +	QUAD8_SIGNAL(22, "Channel 7 Index"),
>> +	QUAD8_SIGNAL(23, "Channel 8 Index")
>
>This naming needs to take on a very standard format or it will become hard
>for userspace to use (when it is dynamic anyway).
>
>> +};
>> +
>> +#define QUAD8_VALUE(_id, _name) {					\
>> +	.id = _id,							\
>> +	.name = _name,							\
>> +	.mode = 0,							\
>> +	.function_modes = quad8_function_modes,				\
>> +	.num_function_modes = ARRAY_SIZE(quad8_function_modes)		\
>> +}
>> +
>> +static const struct iio_counter_value quad8_values[] = {
>> +	QUAD8_VALUE(0, "Channel 1 Count"), QUAD8_VALUE(1, "Channel 2 Count"),
>> +	QUAD8_VALUE(2, "Channel 3 Count"), QUAD8_VALUE(3, "Channel 4 Count"),
>> +	QUAD8_VALUE(4, "Channel 5 Count"), QUAD8_VALUE(5, "Channel 6 Count"),
>> +	QUAD8_VALUE(6, "Channel 7 Count"), QUAD8_VALUE(7, "Channel 8 Count")
>> +};
>
>Likewise.  These need to be very formally defined. Userspace may need to
>parse these...
> 
>> +
>> +static const char *const quad8_trigger_modes[] = {
>> +	"none",
>> +	"rising edge",
>> +	"falling edge",
>> +	"both edges"
>> +};
>> +
>>  static int quad8_probe(struct device *dev, unsigned int id)
>>  {
>> -	struct iio_dev *indio_dev;
>> -	struct quad8_iio *priv;
>> +	struct iio_counter_signal *init_signals;
>> +	const size_t num_init_signals = ARRAY_SIZE(quad8_signals);
>> +	struct iio_counter_value *init_values;
>> +	const size_t num_init_values = ARRAY_SIZE(quad8_values);
>> +	struct iio_counter_trigger *triggers;
>> +	struct quad8_iio *quad8iio;
>>  	int i, j;
>>  	unsigned int base_offset;
>>  
>> -	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
>> -	if (!indio_dev)
>> -		return -ENOMEM;
>> -
>> -	if (!devm_request_region(dev, base[id], QUAD8_EXTENT,
>> -		dev_name(dev))) {
>> +	if (!devm_request_region(dev, base[id], QUAD8_EXTENT, dev_name(dev))) {
>>  		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
>>  			base[id], base[id] + QUAD8_EXTENT);
>>  		return -EBUSY;
>>  	}
>>  
>> -	indio_dev->info = &quad8_info;
>> -	indio_dev->modes = INDIO_DIRECT_MODE;
>> -	indio_dev->num_channels = ARRAY_SIZE(quad8_channels);
>> -	indio_dev->channels = quad8_channels;
>> -	indio_dev->name = dev_name(dev);
>> -	indio_dev->dev.parent = dev;
>> +	init_signals = devm_kmalloc(dev, sizeof(quad8_signals), GFP_KERNEL);
>> +	if (!init_signals)
>> +		return -ENOMEM;
>> +
>> +	memcpy(init_signals, quad8_signals, sizeof(quad8_signals));
>> +
>> +	init_values = devm_kmalloc(dev, sizeof(quad8_values), GFP_KERNEL);
>> +	if (!init_values)
>> +		return -ENOMEM;
>> +
>> +	memcpy(init_values, quad8_values, sizeof(quad8_values));
>> +
>> +	/* Associate values with their respective signals */
>> +	for (i = 0; i < num_init_values; i++) {
>> +		triggers = devm_kmalloc(dev, 2 * sizeof(*triggers), GFP_KERNEL);
>> +		if (!triggers)
>> +			return -ENOMEM;
>> +
>> +		/* Starts up in non-quadrature mode */
>> +		triggers[0].mode = 1;
>> +		triggers[0].trigger_modes = quad8_trigger_modes;
>> +		triggers[0].num_trigger_modes = ARRAY_SIZE(quad8_trigger_modes);
>> +		triggers[0].signal = &init_signals[2 * i];
>> +		triggers[1].mode = 0;
>> +		triggers[1].trigger_modes = quad8_trigger_modes;
>> +		triggers[1].num_trigger_modes = ARRAY_SIZE(quad8_trigger_modes);
>> +		triggers[1].signal = &init_signals[2 * i + 1];
>Can these not be defined as constants? I'm not immediately seeing anything
>dynamic in here. It would make it easier to eyeball how everything fits together.
>In this case where everything is constant can we define it as such?
>
>Fiddly perhaps ;)
>> +
>> +		init_values[i].init_triggers = triggers;
>> +		init_values[i].num_init_triggers = 2;
>> +	}
>> +
>> +	quad8iio = devm_kzalloc(dev, sizeof(*quad8iio), GFP_KERNEL);
>> +	if (!quad8iio)
>> +		return -ENOMEM;
>>  
>> -	priv = iio_priv(indio_dev);
>> -	priv->base = base[id];
>> +	quad8iio->counter.name = dev_name(dev);
>> +	quad8iio->counter.dev = dev;
>> +	quad8iio->counter.ops = &quad8_ops;
>> +	quad8iio->counter.init_signals = init_signals;
>> +	quad8iio->counter.num_init_signals = num_init_signals;
>> +	quad8iio->counter.init_values = init_values;
>> +	quad8iio->counter.num_init_values = num_init_values;
>> +	quad8iio->counter.channels = quad8_channels;
>> +	quad8iio->counter.num_channels = ARRAY_SIZE(quad8_channels);
>> +	quad8iio->counter.info = &quad8_info;
>> +	quad8iio->counter.driver_data = quad8iio;
>> +	quad8iio->base = base[id];
>>  
>>  	/* Reset all counters and disable interrupt function */
>>  	outb(0x01, base[id] + 0x11);
>> @@ -580,11 +840,23 @@ static int quad8_probe(struct device *dev, unsigned int id)
>>  	/* Enable all counters */
>>  	outb(0x00, base[id] + 0x11);
>>  
>> -	return devm_iio_device_register(dev, indio_dev);
>> +	dev_set_drvdata(dev, &quad8iio->counter);
>> +
>> +	return iio_counter_register(&quad8iio->counter);
>> +}
>> +
>> +static int quad8_remove(struct device *dev, unsigned int id)
>> +{
>> +	struct iio_counter *counter = dev_get_drvdata(dev);
>> +
>> +	iio_counter_unregister(counter);
>> +
>> +	return 0;
>>  }
>>  
>>  static struct isa_driver quad8_driver = {
>>  	.probe = quad8_probe,
>> +	.remove = quad8_remove,
>>  	.driver = {
>>  		.name = "104-quad-8"
>>  	}
>
