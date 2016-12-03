Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57238 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753553AbcLCOlx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Dec 2016 09:41:53 -0500
Subject: Re: [PATCH] iio: 104-quad-8: Add IRQ support for the ACCES 104-QUAD-8
To: William Breathitt Gray <vilhelm.gray@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20161129195955.GA27766@sophia>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <17224a84-e933-6070-ee86-fedc4e0f4914@kernel.org>
Date: Sat, 3 Dec 2016 10:21:58 +0000
MIME-Version: 1.0
In-Reply-To: <20161129195955.GA27766@sophia>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/11/16 20:00, William Breathitt Gray wrote:
> The LSI/CSI LS7266R1 chip provides programmable output via the FLG pins.
> When interrupts are enabled on the ACCES 104-QUAD-8, they occur whenever
> FLG1 is active. Four functions are available for the FLG1 signal:
> /Carry, /Compare, /Carry/Borrow, and Index.
> 
> 	/Carry:
> 		Interrupt generated on active low Carry signal. Carry
> 		signal toggles every time the respective channel's
> 		counter overflows.
This one is kind of a rising threshold with the threshold set to 0
(as the counter is cyclic)

> 
> 	/Compare:
> 		Interrupt generated on active low Compare signal.
> 		Compare signal toggles every time respective channel's
> 		preset register is equal to the respective channel's
> 		counter.
So this one is a kind of cycling threshold (in either direction).
> 
> 	/Carry/Borrow:
> 		Interrupt generated on active low Carry signal and
> 		active low Borrow signal. Carry signal toggles every
> 		time the respective channel's counter overflows. Borrow
> 		signal toggles every time the respective channel's
> 		counter underflows.
This is kind of a bi directional version of the Carry case.
> 
> 	Index:
> 		Interrupt generated on active high Index signal.
Kind of threshold against a physical thing which we don't know.  Might want
a new event type for this, or at least an  extra attribute to make this clear...
(just thinking through this as I read)

I think I'm going to want to think this over for a it.  Give me a poke
if I don't come back to you.  The interface as it stands is very
device specific and it feels like we should be able to generalize it
rather better than this.

Presumably this patch won't apply anyway until the others have worked there
way through mainline and back through staging-next so it'll be at least a
few weeks.

> 
> The irq_trig_func sysfs attribute is introduced to allow the selection
> of the desired IRQ trigger function per channel. Interrupts push events
> via the mag_en event sysfs attribute.
hmm. We really need to rework the events support to allow more than one
of a given type of event.  It's ugly as we will need to find space in the
event code without breaking existing userspace.  Ah well, yet another thing
we got slightly wrong a long time ago!
> 
> This patch adds IRQ support for the ACCES 104-QUAD-8. The interrupt line
> numbers for the devices may be configured via the irq array module
> parameter.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-counter-104-quad-8   |  37 +++++-
>  drivers/iio/counter/104-quad-8.c                   | 129 ++++++++++++++++++++-
>  drivers/iio/counter/Kconfig                        |   6 +-
>  3 files changed, 163 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
> index ba67652..53db967 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
> @@ -51,6 +51,31 @@ Description:
>  			not freeze at the bundary points, but counts
>  			continuously throughout.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_countY_irq_trig_func
> +KernelVersion:	4.9
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		IRQ trigger function for channel Y. Four IRQ trigger functions
> +		are available: /Carry, /Compare, /Carry/Borrow, and Index.
> +
> +		/Carry:
> +			Interrupt generated on active low Carry signal. Carry
> +			signal toggles every time channel Y counter overflows.
Why the /s?
> +
> +		/Compare:
> +			Interrupt generated on active low Compare signal.
> +			Compare signal toggles every time channel Y preset
> +			register is equal to channel Y counter.
> +
> +		/Carry/Borrow:
> +			Interrupt generated on active low Carry signal and
> +			active low Borrow signal. Carry signal toggles every
> +			time channel Y counter overflows. Borrow signal toggles
> +			every time channel Y counter underflows.
> +
> +		Index:
> +			Interrupt generated on active high Index signal.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_countY_noise_error
>  KernelVersion:	4.9
>  Contact:	linux-iio@vger.kernel.org
> @@ -93,7 +118,8 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Whether to set channel Y counter with channel Y preset value
>  		when channel Y index input is active, or continuously count.
> -		Valid attribute values are boolean.
> +		Valid attribute values are boolean. This attribute is ignored
> +		when channel Y IRQs are disabled.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_index_polarity
>  KernelVersion:	4.9
> @@ -123,3 +149,12 @@ Description:
>  			set_to_preset_on_index) is performed synchronously with
>  			the quadrature clock on the active level of the index
>  			input.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/events/in_countY_mag_en
These aren't magnitude events (there isn't a concept of negative so it doesn't
really make difference).  I'd argue they are thresh events however with both
directions.
> +KernelVersion:	4.9
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Event generated when a channel Y IRQ occurs. Channel Y IRQs are
> +		triggered as configured by the channel Y irq_trig_func
> +		attribute. Channel Y IRQs are disabled when this attribute is
> +		set to 0.
> diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-quad-8.c
> index 2d2ee35..e1ea38c 100644
> --- a/drivers/iio/counter/104-quad-8.c
> +++ b/drivers/iio/counter/104-quad-8.c
> @@ -16,10 +16,12 @@
>  #include <linux/bitops.h>
>  #include <linux/device.h>
>  #include <linux/errno.h>
> +#include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/types.h>
>  #include <linux/io.h>
>  #include <linux/ioport.h>
> +#include <linux/interrupt.h>
>  #include <linux/isa.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -33,6 +35,10 @@ static unsigned int num_quad8;
>  module_param_array(base, uint, &num_quad8, 0);
>  MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
>  
> +static unsigned int irq[max_num_isa_dev(QUAD8_EXTENT)];
> +module_param_array(irq, uint, NULL, 0000);
> +MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 interrupt line numbers");
> +
>  #define QUAD8_NUM_COUNTERS 8
>  
>  /**
> @@ -43,6 +49,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
>   * @quadrature_scale:	array of quadrature mode scale configurations
>   * @ab_enable:		array of A and B inputs enable configurations
>   * @preset_enable:	array of set_to_preset_on_index attribute configurations
> + * @irq_trig_func:	array of IRQ trigger function attribute configurations
>   * @synchronous_mode:	array of index function synchronous mode configurations
>   * @index_polarity:	array of index function polarity configurations
>   * @base:		base port address of the IIO device
> @@ -54,6 +61,7 @@ struct quad8_iio {
>  	unsigned int quadrature_scale[QUAD8_NUM_COUNTERS];
>  	unsigned int ab_enable[QUAD8_NUM_COUNTERS];
>  	unsigned int preset_enable[QUAD8_NUM_COUNTERS];
> +	unsigned int irq_trig_func[QUAD8_NUM_COUNTERS];
>  	unsigned int synchronous_mode[QUAD8_NUM_COUNTERS];
>  	unsigned int index_polarity[QUAD8_NUM_COUNTERS];
>  	unsigned int base;
> @@ -150,7 +158,8 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
>  
>  		priv->ab_enable[chan->channel] = val;
>  
> -		ior_cfg = val | priv->preset_enable[chan->channel] << 1;
> +		ior_cfg = val | priv->preset_enable[chan->channel] << 1 |
> +			priv->irq_trig_func[chan->channel] << 3;
>  
>  		/* Load I/O control configuration */
>  		outb(0x40 | ior_cfg, base_offset);
> @@ -184,10 +193,39 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> +static int quad8_read_event_config(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, enum iio_event_type type,
> +	enum iio_event_direction dir)
> +{
> +	const struct quad8_iio *const priv = iio_priv(indio_dev);
> +	const unsigned int irq_enabled = inb(priv->base + 0x12);
> +
> +	return !!(irq_enabled & BIT(chan->channel));
> +}
> +
> +static int quad8_write_event_config(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, enum iio_event_type type,
> +	enum iio_event_direction dir, int state)
> +{
> +	const struct quad8_iio *const priv = iio_priv(indio_dev);
> +	unsigned int irq_enabled = inb(priv->base + 0x12);
> +
> +	if (state)
> +		irq_enabled |= BIT(chan->channel);
> +	else
> +		irq_enabled &= ~BIT(chan->channel);
> +
> +	outb(irq_enabled, priv->base + 0x12);
> +
> +	return 0;
> +}
> +
>  static const struct iio_info quad8_info = {
>  	.driver_module = THIS_MODULE,
>  	.read_raw = quad8_read_raw,
> -	.write_raw = quad8_write_raw
> +	.write_raw = quad8_write_raw,
> +	.read_event_config = quad8_read_event_config,
> +	.write_event_config = quad8_write_event_config
>  };
>  
>  static ssize_t quad8_read_preset(struct iio_dev *indio_dev, uintptr_t private,
> @@ -253,7 +291,8 @@ static ssize_t quad8_write_set_to_preset_on_index(struct iio_dev *indio_dev,
>  	priv->preset_enable[chan->channel] = preset_enable;
>  
>  	ior_cfg = priv->ab_enable[chan->channel] |
> -		(unsigned int)preset_enable << 1;
> +		(unsigned int)preset_enable << 1 |
> +		priv->irq_trig_func[chan->channel] << 3;
>  
>  	/* Load I/O control configuration to Input / Output Control Register */
>  	outb(0x40 | ior_cfg, base_offset);
> @@ -261,6 +300,44 @@ static ssize_t quad8_write_set_to_preset_on_index(struct iio_dev *indio_dev,
>  	return len;
>  }
>  
> +static const char *const quad8_irq_trig_func_modes[] = {
> +	"/Carry",
> +	"/Compare",
> +	"/Carry/Borrow",
> +	"Index"
> +};
> +
> +static int quad8_set_irq_trig_func(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, unsigned int irq_trig_func)
> +{
> +	struct quad8_iio *const priv = iio_priv(indio_dev);
> +	const unsigned int ior_cfg = priv->ab_enable[chan->channel] |
> +		priv->preset_enable[chan->channel] << 1 | irq_trig_func << 3;
> +	const int base_offset = priv->base + 2 * chan->channel + 1;
> +
> +	priv->irq_trig_func[chan->channel] = irq_trig_func;
> +
> +	/* Load I/O control configuration to Input/Output Control Register */
> +	outb(0x40 | ior_cfg, base_offset);
> +
> +	return 0;
> +}
> +
> +static int quad8_get_irq_trig_func(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan)
> +{
> +	const struct quad8_iio *const priv = iio_priv(indio_dev);
> +
> +	return priv->irq_trig_func[chan->channel];
> +}
> +
> +static const struct iio_enum quad8_irq_trig_func_enum = {
> +	.items = quad8_irq_trig_func_modes,
> +	.num_items = ARRAY_SIZE(quad8_irq_trig_func_modes),
> +	.set = quad8_set_irq_trig_func,
> +	.get = quad8_get_irq_trig_func
> +};
> +
>  static const char *const quad8_noise_error_states[] = {
>  	"No excessive noise is present at the count inputs",
>  	"Excessive noise is present at the count inputs"
> @@ -477,6 +554,8 @@ static const struct iio_chan_spec_ext_info quad8_count_ext_info[] = {
>  		.read = quad8_read_set_to_preset_on_index,
>  		.write = quad8_write_set_to_preset_on_index
>  	},
> +	IIO_ENUM("irq_trig_func", IIO_SEPARATE, &quad8_irq_trig_func_enum),
> +	IIO_ENUM_AVAILABLE("irq_trig_func", &quad8_irq_trig_func_enum),
>  	IIO_ENUM("noise_error", IIO_SEPARATE, &quad8_noise_error_enum),
>  	IIO_ENUM_AVAILABLE("noise_error", &quad8_noise_error_enum),
>  	IIO_ENUM("count_direction", IIO_SEPARATE, &quad8_count_direction_enum),
> @@ -497,12 +576,22 @@ static const struct iio_chan_spec_ext_info quad8_index_ext_info[] = {
>  	{}
>  };
>  
> +static const struct iio_event_spec quad8_event[] = {
> +	{
> +		.type = IIO_EV_TYPE_MAG,
> +		.dir = IIO_EV_DIR_NONE,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE)
> +	}
> +};
> +
>  #define QUAD8_COUNT_CHAN(_chan) {					\
>  	.type = IIO_COUNT,						\
>  	.channel = (_chan),						\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
>  		BIT(IIO_CHAN_INFO_ENABLE) | BIT(IIO_CHAN_INFO_SCALE),	\
>  	.ext_info = quad8_count_ext_info,				\
> +	.event_spec = quad8_event,					\
> +	.num_event_specs = ARRAY_SIZE(quad8_event),			\
>  	.indexed = 1							\
>  }
>  
> @@ -525,12 +614,35 @@ static const struct iio_chan_spec quad8_channels[] = {
>  	QUAD8_COUNT_CHAN(7), QUAD8_INDEX_CHAN(7)
>  };
>  
> +static irqreturn_t quad8_irq_handler(int irq, void *indio_dev)
> +{
> +	const struct quad8_iio *const priv = iio_priv(indio_dev);
> +	unsigned long irq_status;
> +	unsigned long channel;
> +
> +	irq_status = inb(priv->base + 0x10);
> +	if (!irq_status)
> +		return IRQ_NONE;
> +
> +	for_each_set_bit(channel, &irq_status, QUAD8_NUM_COUNTERS)
> +		iio_push_event(indio_dev,
> +			IIO_UNMOD_EVENT_CODE(IIO_COUNT, channel,
> +				IIO_EV_TYPE_MAG, IIO_EV_DIR_NONE),
> +			iio_get_time_ns(indio_dev));
> +
> +	/* Clear pending interrupts on device */
> +	outb(0x10, priv->base + 0x11);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int quad8_probe(struct device *dev, unsigned int id)
>  {
>  	struct iio_dev *indio_dev;
>  	struct quad8_iio *priv;
>  	int i, j;
>  	unsigned int base_offset;
> +	int err;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
>  	if (!indio_dev)
> @@ -552,6 +664,8 @@ static int quad8_probe(struct device *dev, unsigned int id)
>  	priv = iio_priv(indio_dev);
>  	priv->base = base[id];
>  
> +	/* Reset Index/Interrupt Register */
> +	outb(0x00, base[id] + 0x12);
>  	/* Reset all counters and disable interrupt function */
>  	outb(0x01, base[id] + 0x11);
>  	/* Set initial configuration for all counters */
> @@ -573,8 +687,13 @@ static int quad8_probe(struct device *dev, unsigned int id)
>  		/* Disable index function; negative index polarity */
>  		outb(0x60, base_offset + 1);
>  	}
> -	/* Enable all counters */
> -	outb(0x00, base[id] + 0x11);
> +	/* Enable all counters and enable interrupt function */
> +	outb(0x10, base[id] + 0x11);
> +
> +	err = devm_request_irq(dev, irq[id], quad8_irq_handler, IRQF_SHARED,
> +		dev_name(dev), indio_dev);
> +	if (err)
> +		return err;
>  
>  	return devm_iio_device_register(dev, indio_dev);
>  }
> diff --git a/drivers/iio/counter/Kconfig b/drivers/iio/counter/Kconfig
> index 44627f6..2cea823 100644
> --- a/drivers/iio/counter/Kconfig
> +++ b/drivers/iio/counter/Kconfig
> @@ -15,10 +15,10 @@ config 104_QUAD_8
>  	  Performing a write to a counter's IIO_CHAN_INFO_RAW sets the counter and
>  	  also clears the counter's respective error flag. Although the counters
>  	  have a 25-bit range, only the lower 24 bits may be set, either directly
> -	  or via a counter's preset attribute. Interrupts are not supported by
> -	  this driver.
> +	  or via a counter's preset attribute.
>  
>  	  The base port addresses for the devices may be configured via the base
> -	  array module parameter.
> +	  array module parameter. The interrupt line numbers for the devices may
> +	  be configured via the irq array module parameter.
>  
>  endmenu
> 

