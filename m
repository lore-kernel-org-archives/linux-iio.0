Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50924 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756Ab1LDSIb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Dec 2011 13:08:31 -0500
Message-ID: <4EDBB71C.6050004@kernel.org>
Date: Sun, 04 Dec 2011 18:08:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: linux-iio@vger.kernel.org,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 5/5] AT91:IIO: Add support for hardware triggers for the
 ADC
References: <1322840104-3525-1-git-send-email-maxime.ripard@free-electrons.com> <1322840104-3525-6-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1322840104-3525-6-git-send-email-maxime.ripard@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Maxime.

Mostly fine, though I'd structure a few corners differently as explained
inline.

Also, I don't immediately see a reason not to use threaded interrupts
for much
of what we have here and that would definitely be preferable if possible!

Review may be more thorough that you wanted at this stage, but given I was
reading the code I thought I might as well do it along the way!

Jonathan

On 12/02/2011 03:35 PM, Maxime Ripard wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  arch/arm/mach-at91/at91sam9260_devices.c |    3 +
>  arch/arm/mach-at91/board-sam9g20ek.c     |    1 +
>  drivers/staging/iio/adc/Kconfig          |   11 +-
>  drivers/staging/iio/adc/at91_adc.c       |  329 +++++++++++++++++++++++++++++-
>  include/linux/platform_data/at91_adc.h   |    2 +
>  5 files changed, 331 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
> index 95b3127..9dc9f96 100644
> --- a/arch/arm/mach-at91/at91sam9260_devices.c
> +++ b/arch/arm/mach-at91/at91sam9260_devices.c
> @@ -1366,6 +1366,9 @@ void __init at91_add_device_adc(struct at91_adc_data *data)
>  	if (test_bit(3, &data->channels_used))
>  		at91_set_A_periph(AT91_PIN_PC3, 0);
>  
> +	if (data->use_external)
> +		at91_set_A_periph(AT91_PIN_PA22, 0);
> +
>  	adc_data = *data;
>  	platform_device_register(&at91_adc_device);
>  }
> diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
> index 7758f34..f18f6f2 100644
> --- a/arch/arm/mach-at91/board-sam9g20ek.c
> +++ b/arch/arm/mach-at91/board-sam9g20ek.c
> @@ -317,6 +317,7 @@ static void __init ek_add_device_buttons(void) {}
>  
>  static struct at91_adc_data ek_adc_data = {
>  	.channels_used = BIT(0) | BIT(1) | BIT(2) | BIT(3),
> +	.use_external = true,
>  	.vref = 3300,
>  };
>  
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index 93de64d..9d87c75 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -170,10 +170,13 @@ config AD7280
>  	  module will be called ad7280a
>  
>  config AT91_ADC
> -       tristate "Atmel AT91 ADC"
> -       depends on SYSFS && ARCH_AT91
> -       help
> -         Say yes here to build support for Atmel AT91 ADC
> +	tristate "Atmel AT91 ADC"
> +	depends on SYSFS && ARCH_AT91
> +	select IIO_BUFFER
> +	select IIO_SW_RING
> +	select IIO_TRIGGER
I assume this is true because some of these changes mean
that it will simply not function without the buffered side?
Given that one typical usecase for this device is simple
hwmon type monitoring (fully pull interface in kernel)
I'd be inclined to see how much extra code would be
required to allow it to run as before adding buffered support.
If it is really uggly then fair enough!
> +	help
> +	  Say yes here to build support for Atmel AT91 ADC.
>  
>  config MAX1363
>  	tristate "Maxim max1363 ADC driver"
> diff --git a/drivers/staging/iio/adc/at91_adc.c b/drivers/staging/iio/adc/at91_adc.c
> index b357363..74baaf3 100644
> --- a/drivers/staging/iio/adc/at91_adc.c
> +++ b/drivers/staging/iio/adc/at91_adc.c
> @@ -23,9 +23,20 @@
>  #include "../iio.h"
>  #include <linux/platform_data/at91_adc.h>
>  
> +#include "../buffer.h"
> +#include "../ring_sw.h"
> +#include "../trigger.h"
> +#include "../trigger_consumer.h"
> +
>  #include <mach/at91_adc.h>
>  #include <mach/cpu.h>
>  
I'd like to see some docs for this.  Obviously
name is self explanatory but value isn't!
> +struct at91_adc_trigger {
> +	char *name;
> +	u8 value;
> +	bool is_external;
> +};
> +
>  struct at91_adc_desc {
>  	/* ADC Clock as specified by the datasheet, in Hz. */
>  	u32 clock;
> @@ -37,6 +48,7 @@ struct at91_adc_desc {
>  	u8 num_channels;
>  	/* Startup time of the ADC, in microseconds. */
>  	u8 startup_time;
> +	struct at91_adc_trigger *triggers;
>  };
>  
>  struct at91_adc_state {
> @@ -51,12 +63,37 @@ struct at91_adc_state {
>  	unsigned long channels_mask;
>  	bool irq_enabled;
>  	struct at91_adc_desc *desc;
> +	struct iio_trigger **trig;
> +};
> +
Trigger names are a little cryptic. I'd be inclined to make them
a bit longer and hence perhaps self explanatory if you can.  Note
as first device of this type you are pretty much setting the
naming standard and I think these will appear in some of the user
space abi, so they won't be easy to change later!
For that reason we are going to be fussier than normal.

> +static struct at91_adc_trigger at91_adc_trigger_sam9g20[] = {
> +	[0] = {
> +		.name = "TC0",
> +		.value = AT91_ADC_TRGSEL_TC0 | AT91_ADC_TRGEN,
> +		.is_external = false,
> +	},
> +	[1] = {
> +		.name = "TC1",
> +		.value = AT91_ADC_TRGSEL_TC1 | AT91_ADC_TRGEN,
> +		.is_external = false,
> +	},
> +	[2] = {
> +		.name = "TC2",
> +		.value = AT91_ADC_TRGSEL_TC2 | AT91_ADC_TRGEN,
> +		.is_external = false,
> +	},
> +	[3] = {
> +		.name = "external",
> +		.value = AT91_ADC_TRGSEL_EXTERNAL | AT91_ADC_TRGEN,
> +		.is_external = true,
> +	},
How does it know how many there are?  Null terminate this perhaps?
>  };
>  
>  static struct at91_adc_desc at91_adc_desc_sam9g20 = {
>  	.clock = 5000000,
>  	.num_channels = 4,
>  	.startup_time = 10,
> +	.triggers = at91_adc_trigger_sam9g20,
>  };
>  
>  static int at91_adc_select_soc(struct at91_adc_state *st)
> @@ -82,27 +119,124 @@ static inline void at91_adc_reg_write(struct at91_adc_state *st,
>  	writel_relaxed(val, st->reg_base + reg);
>  }
>  
> +static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *idev = pf->indio_dev;
> +	struct at91_adc_state *st = iio_priv(idev);
> +	struct iio_buffer *buffer = idev->buffer;
> +	int len = 0;
> +
> +	size_t datasize = buffer->access->get_bytes_per_datum(buffer);
> +	u16 *data = kmalloc(datasize, GFP_KERNEL);
> +	if (data == NULL)
> +		return -ENOMEM;
I know some of my drivers have done this, but I prefer the approach
used by some of the ADI ones.  They allocate these buffers in the
chip_state and hence get this kmalloc out of this fast patch.
That should be fine as we should always be able to make sure it
is the right size in the preenable function for the buffer.
> +
> +	/* Needed to ACK the DRDY interruption */
> +	at91_adc_reg_read(st, AT91_ADC_LCDR);
Here?  Conceptually I'd expect to see this right at the end of the interrupt
handling.  I would imaging acking this means another one can arive.  To
cleanly support capture from other devices on this trigger this would occur
in the try_reenable callback.  That only gets called when the number of
calls to iio_trigger_notify_done is equal to the number of devices waiting
on the trigger (i.e. everyone is done).
> +
> +	if (buffer->scan_count) {
> +		int i, j;
> +		for (i = 0, j = 0; i < buffer->scan_count; i++) {
Just as a heads up, this patch will change shortly due to the
introduction of multiple buffer support so please watch those
patches as they go through and the driver changes we are making..

Also, this looks like a for_each_set_bit function would make this easier to
read.

> +			j = find_next_bit(buffer->scan_mask,
> +					  st->desc->num_channels,
> +					  j);
> +			data[i] = at91_adc_reg_read(st, AT91_ADC_CHR(j));
> +			j++;
> +			len += 2;
> +		}
> +	}
> +
The utility of ALIGN macro has been pointed out to me recently and makes
it more apparent what is going on in cases like this.
Also, conceptually I'd expect to see the timestamp capture occuring earlier
to make it nearer to the trigger point (when I guess the read is actually
occuring - having been lazy and not actually loaded the datasheet ;)
> +	if (buffer->scan_timestamp) {
> +		s64 *timestamp = (s64 *)((u8 *)data + round_up(len,
> +							       sizeof(s64)));
> +		*timestamp = iio_get_time_ns();
> +	}
> +
> +	buffer->access->store_to(buffer, (u8 *)data, pf->timestamp);
> +
> +	kfree(data);
> +
> +	iio_trigger_notify_done(idev->trig);
> +	st->irq_enabled = true;

> +	enable_irq(st->irq);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static irqreturn_t at91_adc_eoc_trigger(int irq, void *private)
>  {
>  	struct iio_dev *idev = private;
>  	struct at91_adc_state *st = iio_priv(idev);
> -	unsigned int status = at91_adc_reg_read(st, AT91_ADC_SR);
>  
> -	if (!(status & AT91_ADC_DRDY))
> -		return IRQ_HANDLED;
> +	st->done = true;
Want to wake this up here?  Not after the st->last_value bit below?
Obviously probably doesn't actually matter is we are in an irq handler
but it would make for more logical flow to my mind.  Data is read first
and then we tell those waiting it is available...
> +	wake_up_interruptible(&st->wq_data_avail);
>  
> -	if (status & st->channels_mask) {
> -		st->done = true;
> +	if (iio_buffer_enabled(idev)) {
For ease of flow, can we not make this a one shot interrupt (using
threaded irqs)?  I'm also given we are being notified data is ready
the read doesn't actually need to happen in the top half. I'd prefer
seeing just the check that it is this interrupt and the iio_trigger_poll
happening in the top half.

The trigger_poll is just in case we need to fire a capturing pin on
something else using this trigger alongside this device.


> +		disable_irq_nosync(irq);
> +		st->irq_enabled = false;
> +		iio_trigger_poll(idev->trig, iio_get_time_ns());
> +	} else {
>  		st->last_value = at91_adc_reg_read(st, AT91_ADC_LCDR);
>  	}
>  
> -	wake_up_interruptible(&st->wq_data_avail);
> -
>  	return IRQ_HANDLED;
>  }
>  
> +static const struct iio_buffer_setup_ops at91_adc_buffer_setup_ops = {
> +	.preenable = &iio_sw_buffer_preenable,
> +	.postenable = &iio_triggered_buffer_postenable,
> +	.predisable = &iio_triggered_buffer_predisable,
> +};
> +
> +static int at91_adc_buffer_init(struct iio_dev *idev)
> +{
> +	struct iio_buffer *buffer;
> +	int ret;
> +
> +	buffer = iio_sw_rb_allocate(idev);
> +	if (buffer == NULL) {
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +
> +	idev->buffer = buffer;
> +	buffer->scan_timestamp = true;
Killing of bpe is scheduled.  Nothing that can't be recovered from
iio_chan_spec structures and shouldn't be used in capture path anyway.
The new iio_sw_buffer_preenable is a lot cleverer!  Easy to change
once those patches have merged of course!

> +	buffer->bpe = 2;
> +	buffer->access = &ring_sw_access_funcs;
> +	buffer->setup_ops = &at91_adc_buffer_setup_ops;
> +	buffer->owner = THIS_MODULE;
> +
Looking at what you have here, you might save a fair bit of code by
taking advantage of Lars-Peter's patch of last week that handles all
this boilerplate under slightly restricted circumstances...

> +	idev->pollfunc = iio_alloc_pollfunc(NULL,
> +					    &at91_adc_trigger_handler,
> +					    0,
> +					    idev,
> +					    "at91_adc-consumer-%d",
> +					    idev->id);
> +
> +	if (idev->pollfunc == NULL) {
> +		ret = -ENOMEM;
> +		goto error_free_buffer;
> +	}
> +
> +	idev->modes |= INDIO_BUFFER_TRIGGERED;
> +	return 0;
> +
> +error_free_buffer:
> +	iio_sw_rb_free(idev->buffer);
> +error_ret:
> +	return ret;
> +
> +}
> +
> +static void at91_adc_buffer_remove(struct iio_dev *indio_dev)
> +{
> +	iio_dealloc_pollfunc(indio_dev->pollfunc);
> +	iio_sw_rb_free(indio_dev->buffer);
> +}
> +
>  static int at91_adc_channel_init(struct iio_dev *idev,
> -				struct at91_adc_data *pdata)
> +				 struct at91_adc_data *pdata)
May be a valid whitespace cleanup, but shouldn't be in this patch.
>  {
>  	struct at91_adc_state *st = iio_priv(idev);
>  	struct iio_chan_spec *chan_array;
> @@ -121,6 +255,7 @@ static int at91_adc_channel_init(struct iio_dev *idev,
>  		chan->type = IIO_VOLTAGE;
>  		chan->indexed = 1;
>  		chan->channel = bit;
> +		chan->scan_index = idx;
>  		chan->scan_type.sign = 'u';
>  		chan->scan_type.realbits = 10;
>  		chan->scan_type.storagebits = 16;
> @@ -137,6 +272,145 @@ static void at91_adc_channel_remove(struct iio_dev *idev)
>  	kfree(idev->channels);
>  }
>  
> +static int at91_adc_set_trigger_state(struct iio_trigger *trig, bool state)
> +{
> +	struct iio_dev *idev = trig->private_data;
> +	struct at91_adc_state *st = iio_priv(idev);
> +	struct iio_buffer *buffer = idev->buffer;
> +	u32 status = at91_adc_reg_read(st, AT91_ADC_MR);
> +	u8 bit;
> +
> +	if (state) {
> +		int i;
> +
Looks suspect.  sizeof that is only 4 because it is a pointer, not because
it has 4 elements I think???
> +		for (i = 0; i < sizeof(st->desc->triggers); i++) {
> +			char *name = kasprintf(GFP_KERNEL,
> +					       "%s-dev%d-%s",
> +					       idev->name,
> +					       idev->id,
> +					       st->desc->triggers[i].name);
> +
Cleaner to verify the kasprintf worked first and return -ENOMEM if it
failed.  Then see if the name matches.  Also, !strcmp is a really
confusing idiom.  I at least prefer strcmp() == 0

> +			if (!strcmp(idev->trig->name, name)) {
> +				status |= st->desc->triggers[i].value;
> +				kfree(name);
> +				break;
> +			}
> +
> +			kfree(name);
> +		}
> +
> +		if (i == sizeof(st->desc->triggers))
> +			return -EINVAL;
> +
> +		at91_adc_reg_write(st, AT91_ADC_MR, status);
> +
> +		for_each_set_bit(bit, buffer->scan_mask,
> +				 st->desc->num_channels) {
> +			struct iio_chan_spec const *chan = idev->channels + bit;
> +			at91_adc_reg_write(st, AT91_ADC_CHER,
> +					   AT91_ADC_CH(chan->channel));
> +		}
> +
> +		at91_adc_reg_write(st, AT91_ADC_IER, AT91_ADC_DRDY);
> +
> +
> +	} else {
> +		at91_adc_reg_write(st, AT91_ADC_IDR, AT91_ADC_DRDY);
> +		at91_adc_reg_write(st, AT91_ADC_MR,
> +				   status & ~AT91_ADC_TRGEN);
> +
> +		for_each_set_bit(bit, buffer->scan_mask,
> +				 st->desc->num_channels) {
> +			at91_adc_reg_write(st, AT91_ADC_CHDR,
> +					   AT91_ADC_CH(bit));
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct iio_trigger_ops at91_adc_trigger_ops = {
> +	.owner = THIS_MODULE,
> +	.set_trigger_state = &at91_adc_set_trigger_state,
> +};
> +
> +
Name is a little misleading as this also registers the trigger.
Perhaps at91_adc_configure_trigger?
> +static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *idev,
> +						     struct at91_adc_trigger *trigger)
> +{
> +	struct iio_trigger *trig = iio_allocate_trigger("%s-dev%d-%s",
> +							idev->name,
> +							idev->id,
> +							trigger->name);
> +	int ret;
> +
> +	if (trig == NULL)
> +		return NULL;
> +
> +	trig->dev.parent = idev->dev.parent;
> +	trig->owner = THIS_MODULE;
yikes. That's silly, we still have an owner field in trig and in ops?
Definitely one for cleaning up.
> +	trig->private_data = idev;
> +	trig->ops = &at91_adc_trigger_ops;
> +
> +	ret = iio_trigger_register(trig);
> +	if (ret < 0)
> +		return NULL;
> +
> +	return trig;
> +}
> +
> +static int at91_adc_trigger_init(struct iio_dev *idev,
> +				 struct at91_adc_data *pdata)
> +{
> +	struct at91_adc_state *st = iio_priv(idev);
> +	int i, ret;
> +
> +	st->trig = kcalloc(sizeof(st->desc->triggers),
> +			   sizeof(struct iio_trigger *),
> +			   GFP_KERNEL);
> +
extra white space...
> +	if (st->trig == NULL) {
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +
> +	for (i = 0; i < sizeof(st->desc->triggers); i++) {
> +		if (st->desc->triggers[i].is_external && !(pdata->use_external))
> +			continue;
> +
> +		st->trig[i] = at91_adc_allocate_trigger(idev,
> +							st->desc->triggers + i);
Check the right trigger ;)
> +		if (st->trig[0] == NULL) {
> +			ret = -ENOMEM;
> +			goto error_trigger;
> +		}
> +	}
> +
> +	return 0;
> +
> +error_trigger:
> +	for (; i >= 0; i--) {
> +		iio_trigger_unregister(st->trig[i]);
> +		iio_free_trigger(st->trig[i]);
> +	}
> +	kfree(st->trig);
> +error_ret:
> +	return ret;
> +}
> +
> +static void at91_adc_trigger_remove(struct iio_dev *idev)
> +{
> +	struct at91_adc_state *st = iio_priv(idev);
> +	int i;
> +
> +	for (i = 0; i < sizeof(st->trig); i++) {
> +		iio_trigger_unregister(st->trig[i]);
> +		iio_free_trigger(st->trig[i]);
> +	}
> +
> +	kfree(st->trig);
> +}
> +
>  static int at91_adc_read_raw(struct iio_dev *idev,
>  			    struct iio_chan_spec const *chan,
>  			    int *val, int *val2, long mask)
> @@ -309,8 +583,10 @@ static int __devinit at91_adc_probe(struct platform_device *pdev)
>  
>  	/* Setup the ADC channels available on the board */
>  	ret = at91_adc_channel_init(idev, pdata);
> -	if (ret < 0)
Shouldn't be in this patch.
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Couldn't initialize the channels.\n");
>  		goto error_free_clk;
> +	}
>  
>  	init_waitqueue_head(&st->wq_data_avail);
>  	mutex_init(&st->lock);
> @@ -318,12 +594,40 @@ static int __devinit at91_adc_probe(struct platform_device *pdev)
>  	st->vref_mv = pdata->vref;
>  	st->channels_mask = pdata->channels_used;
>  
> -	ret = iio_device_register(idev);
> -	if (ret < 0)
> +	ret = at91_adc_buffer_init(idev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Couldn't initialize the buffer.\n");
>  		goto error_free_channels;
> +	}
> +
> +	ret = iio_buffer_register(idev,
> +				  idev->channels,
> +				  idev->num_channels);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Couldn't register the buffer.\n");
> +		goto error_free_buffer;
> +	}
> +
> +	ret = at91_adc_trigger_init(idev, pdata);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Couldn't setup the triggers.\n");
> +		goto error_unregister_buffer;
> +	}
> +

Also, not in this patch.
> +	ret = iio_device_register(idev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Couldn't register the device.\n");
> +		goto error_remove_triggers;
> +	}
>  
>  	return 0;
>  
> +error_remove_triggers:
> +	at91_adc_trigger_remove(idev);
> +error_unregister_buffer:
> +	iio_buffer_unregister(idev);
> +error_free_buffer:
> +	at91_adc_buffer_remove(idev);
>  error_free_channels:
>  	at91_adc_channel_remove(idev);
>  error_free_clk:
> @@ -348,6 +652,9 @@ static int __devexit at91_adc_remove(struct platform_device *pdev)
>  	struct at91_adc_state *st = iio_priv(idev);
>  
>  	iio_device_unregister(idev);
> +	at91_adc_trigger_remove(idev);
> +	iio_buffer_unregister(idev);
> +	at91_adc_buffer_remove(idev);
>  	at91_adc_channel_remove(idev);
>  	clk_disable(st->clk);
>  	clk_put(st->clk);
> diff --git a/include/linux/platform_data/at91_adc.h b/include/linux/platform_data/at91_adc.h
> index 9c5a64e..5b65eff 100644
> --- a/include/linux/platform_data/at91_adc.h
> +++ b/include/linux/platform_data/at91_adc.h
> @@ -18,6 +18,8 @@
Probably worth doing docs here in kernel-doc format.
>  struct at91_adc_data {
>  	/* Channels in use on the board as a bitmask */
>  	unsigned long channels_used;
> +	/* Do we need the external triggers ? */
> +	bool use_external;
>  	/* Reference voltage for the ADC in millivolts */
>  	u16 vref;
>  };

