Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:58037 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590Ab1LLN4F (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 12 Dec 2011 08:56:05 -0500
Message-ID: <4EE607E6.8020401@free-electrons.com>
Date: Mon, 12 Dec 2011 14:55:50 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 6/6] AT91: IIO: Add support for hardware triggers for
 the ADC
References: <1323282340-24475-1-git-send-email-maxime.ripard@free-electrons.com> <1323282340-24475-7-git-send-email-maxime.ripard@free-electrons.com> <4EE3799E.8030307@kernel.org>
In-Reply-To: <4EE3799E.8030307@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 10/12/2011 16:24, Jonathan Cameron wrote:
> On 12/07/2011 06:25 PM, Maxime Ripard wrote:
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>
> Few bits and bobs inline...
> 
>> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
>> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>>  arch/arm/mach-at91/at91sam9260_devices.c |    3 +
>>  arch/arm/mach-at91/board-sam9g20ek.c     |    1 +
>>  drivers/staging/iio/adc/Kconfig          |   11 +-
>>  drivers/staging/iio/adc/at91_adc.c       |  286 +++++++++++++++++++++++++++++-
>>  include/linux/platform_data/at91_adc.h   |    2 +
>>  5 files changed, 292 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
>> index 67dad94..d30c9b8 100644
>> --- a/arch/arm/mach-at91/at91sam9260_devices.c
>> +++ b/arch/arm/mach-at91/at91sam9260_devices.c
>> @@ -1365,6 +1365,9 @@ void __init at91_add_device_adc(struct at91_adc_data *data)
>>  	if (test_bit(3, &data->channels_used))
>>  		at91_set_A_periph(AT91_PIN_PC3, 0);
>>  
>> +	if (data->use_external)
>> +		at91_set_A_periph(AT91_PIN_PA22, 0);
>> +
>>  	adc_data = *data;
>>  	platform_device_register(&at91_adc_device);
>>  }
>> diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
>> index 7758f34..f18f6f2 100644
>> --- a/arch/arm/mach-at91/board-sam9g20ek.c
>> +++ b/arch/arm/mach-at91/board-sam9g20ek.c
>> @@ -317,6 +317,7 @@ static void __init ek_add_device_buttons(void) {}
>>  
>>  static struct at91_adc_data ek_adc_data = {
>>  	.channels_used = BIT(0) | BIT(1) | BIT(2) | BIT(3),
>> +	.use_external = true,
>>  	.vref = 3300,
>>  };
>>  
>> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
>> index 93de64d..9d87c75 100644
>> --- a/drivers/staging/iio/adc/Kconfig
>> +++ b/drivers/staging/iio/adc/Kconfig
>> @@ -170,10 +170,13 @@ config AD7280
>>  	  module will be called ad7280a
>>  
>>  config AT91_ADC
>> -       tristate "Atmel AT91 ADC"
>> -       depends on SYSFS && ARCH_AT91
>> -       help
>> -         Say yes here to build support for Atmel AT91 ADC
>> +	tristate "Atmel AT91 ADC"
>> +	depends on SYSFS && ARCH_AT91
>> +	select IIO_BUFFER
>> +	select IIO_SW_RING
>> +	select IIO_TRIGGER
>> +	help
>> +	  Say yes here to build support for Atmel AT91 ADC.
>>  
>>  config MAX1363
>>  	tristate "Maxim max1363 ADC driver"
>> diff --git a/drivers/staging/iio/adc/at91_adc.c b/drivers/staging/iio/adc/at91_adc.c
>> index 9d6e351..fe31109 100644
>> --- a/drivers/staging/iio/adc/at91_adc.c
>> +++ b/drivers/staging/iio/adc/at91_adc.c
>> @@ -23,10 +23,28 @@
>>  #include "../iio.h"
>>  #include <linux/platform_data/at91_adc.h>
>>  
>> +#include "../buffer.h"
>> +#include "../ring_sw.h"
>> +#include "../trigger.h"
>> +#include "../trigger_consumer.h"
>> +
>>  #include <mach/at91_adc.h>
>>  #include <mach/cpu.h>
>>  
>>  /**
>> + * struct at91_adc_trigger - description of triggers
>> + * @name:		name of the trigger advertised to the user
>> + * @value:		value to set in the ADC's mode register to enable
>> +			the trigger
>> + * @is_external:	is the trigger relies on an external pin ?
>> + */
>> +struct at91_adc_trigger {
>> +	char	*name;
>> +	u8	value;
>> +	bool	is_external;
>> +};
>> +
>> +/**
>>   * struct at91_adc_desc - description of the ADC on the board
>>   * @clock:		ADC clock as specified by the datasheet, in Hz.
>>   * @num_channels:	global number of channels available on the board (to
>> @@ -34,30 +52,62 @@
>>  			board, see the channels_used bitmask in the platform
>>  			data)
>>   * @startup_time:	startup time of the ADC in microseconds
>> + * @triggers:		array of the triggers available on the board
>>   */
>>  struct at91_adc_desc {
>>  	u32			clock;
>>  	u8			num_channels;
>>  	u8			startup_time;
>> +	struct at91_adc_trigger	*triggers;
>>  };
>>  
>>  struct at91_adc_state {
>> +	u16			*buffer;
>>  	u32			channels_mask;
>>  	struct clk		*clk;
>>  	bool			done;
>>  	struct at91_adc_desc	*desc;
>>  	int			irq;
>> +	bool			irq_enabled;
>>  	u16			last_value;
>>  	struct mutex		lock;
>>  	void __iomem		*reg_base;
>> +	struct iio_trigger	**trig;
>>  	u32			vref_mv;
>>  	wait_queue_head_t	wq_data_avail;
>>  };
>>  
>> +static struct at91_adc_trigger at91_adc_trigger_sam9g20[] = {
>> +	[0] = {
>> +		.name = "timer-counter-0",
>> +		.value = AT91_ADC_TRGSEL_TC0 | AT91_ADC_TRGEN,
>> +		.is_external = false,
>> +	},
>> +	[1] = {
>> +		.name = "timer-counter-1",
>> +		.value = AT91_ADC_TRGSEL_TC1 | AT91_ADC_TRGEN,
>> +		.is_external = false,
>> +	},
>> +	[2] = {
>> +		.name = "timer-counter-2",
>> +		.value = AT91_ADC_TRGSEL_TC2 | AT91_ADC_TRGEN,
>> +		.is_external = false,
>> +	},
>> +	[3] = {
>> +		.name = "external",
>> +		.value = AT91_ADC_TRGSEL_EXTERNAL | AT91_ADC_TRGEN,
>> +		.is_external = true,
>> +	},
>> +	[4] = {
>> +		.name = NULL,
>> +	},
>> +};
>> +
>>  static struct at91_adc_desc at91_adc_desc_sam9g20 = {
>>  	.clock = 5000000,
>>  	.num_channels = 4,
>>  	.startup_time = 10,
>> +	.triggers = at91_adc_trigger_sam9g20,
>>  };
>>  
>>  static int at91_adc_select_soc(struct at91_adc_state *st)
>> @@ -83,6 +133,48 @@ static inline void at91_adc_reg_write(struct at91_adc_state *st,
>>  	writel_relaxed(val, st->reg_base + reg);
>>  }
>>  
>> +static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *idev = pf->indio_dev;
>> +	struct at91_adc_state *st = iio_priv(idev);
>> +	struct iio_buffer *buffer = idev->buffer;
>> +	int len = 0;
>> +
> This doesn't look like stuff that should be in the fast patch.
> Could you cache the register to be read in the update_scan_mask
> callback then just run over them here?  Feels like that might
> be cleaner and lead to reads occuring faster.

Hmm, I don't see any update_scan_mask callback neither in the code nor
in the patches sent to the ml, am I missing something ?

>> +	if (!bitmap_empty(idev->active_scan_mask, idev->masklength)) {
>> +		int i, j;
>> +		for (i = 0, j = 0;
>> +		     i < bitmap_weight(idev->active_scan_mask,
>> +				       idev->masklength);
>> +		     i++) {
>> +			j = find_next_bit(buffer->scan_mask,
>> +					  idev->masklength,
>> +					  j);
>> +			st->buffer[i] = at91_adc_reg_read(st, AT91_ADC_CHR(j));
>> +			j++;
>> +			len += 2;
>> +		}
>> +	}
>> +
>> +	if (buffer->scan_timestamp) {
>> +		s64 *timestamp = (s64 *)((u8 *)st->buffer + ALIGN(len,
>> +								  sizeof(s64)));
>> +		*timestamp = pf->timestamp;
>> +	}
>> +
>> +	buffer_store_to(buffer, (u8 *)st->buffer, pf->timestamp);
>> +
>> +	iio_trigger_notify_done(idev->trig);
>> +	st->irq_enabled = true;
>> +
>> +	/* Needed to ACK the DRDY interruption */
>> +	at91_adc_reg_read(st, AT91_ADC_LCDR);
> Still unsure why not threaded_irq and IRQF_ONESHOT.

Oops, forgot to change it, sorry.

> + I'd prefer to see that ack in try_reenable callback.
> Also, if we need to ack, then why do we need to disable
> the irq at all?  Surely it won't reoccur until we have
> acked?

If we don't ACK the interrupt, it will be replayed again and again.
Moreover, if we don't disable the interrupt, as we have no guarantee
about when the reading will actually occur, won't this screw things up
if the triggers keeps firing and we never enter in the handler that
store data in the buffer ?

>> +
>> +	enable_irq(st->irq);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>>  static irqreturn_t at91_adc_eoc_trigger(int irq, void *private)
>>  {
>>  	struct iio_dev *idev = private;
>> @@ -92,13 +184,16 @@ static irqreturn_t at91_adc_eoc_trigger(int irq, void *private)
>>  	if (!(status & AT91_ADC_DRDY))
>>  		return IRQ_HANDLED;
>>  
>> -	if (status & st->channels_mask) {
>> -		st->done = true;
>> +	if (iio_buffer_enabled(idev)) {
>> +		disable_irq_nosync(irq);
>> +		st->irq_enabled = false;
>> +		iio_trigger_poll(idev->trig, iio_get_time_ns());
>> +	} else {
>>  		st->last_value = at91_adc_reg_read(st, AT91_ADC_LCDR);
>> +		st->done = true;
>> +		wake_up_interruptible(&st->wq_data_avail);
>>  	}
>>  
>> -	wake_up_interruptible(&st->wq_data_avail);
>> -
>>  	return IRQ_HANDLED;
>>  }
>>  
>> @@ -110,8 +205,9 @@ static int at91_adc_channel_init(struct iio_dev *idev,
>>  	int bit, idx = 0;
>>  
>>  	idev->num_channels = bitmap_weight(&pdata->channels_used,
>> -					   st->desc->num_channels);
>> -	chan_array = kcalloc(idev->num_channels, sizeof(struct iio_chan_spec),
>> +					   st->desc->num_channels) + 1;
>> +	chan_array = kcalloc(idev->num_channels + 1,
>> +			     sizeof(struct iio_chan_spec),
>>  			     GFP_KERNEL);
> Cosmetic change that should not be in this patch...

Well, the number of allocated channels has been incremented by 1 for the
timestamp in the process, and while the diff makes it look that way, I
don't see any cosmetic change here.

>>  
>>  	if (chan_array == NULL)
>> @@ -122,6 +218,7 @@ static int at91_adc_channel_init(struct iio_dev *idev,
>>  		chan->type = IIO_VOLTAGE;
>>  		chan->indexed = 1;
>>  		chan->channel = bit;
>> +		chan->scan_index = idx;
>>  		chan->scan_type.sign = 'u';
>>  		chan->scan_type.realbits = 10;
>>  		chan->scan_type.storagebits = 16;
>> @@ -129,6 +226,13 @@ static int at91_adc_channel_init(struct iio_dev *idev,
>>  		idx++;
>>  	}
>>  
>> +	(chan_array + idx)->type = IIO_TIMESTAMP;
>> +	(chan_array + idx)->channel = -1;
>> +	(chan_array + idx)->scan_index = idx;
>> +	(chan_array + idx)->scan_type.sign = 's';
>> +	(chan_array + idx)->scan_type.realbits = 64;
>> +	(chan_array + idx)->scan_type.storagebits = 64;
>> +
>>  	idev->channels = chan_array;
>>  	return idev->num_channels;
>>  }
>> @@ -138,6 +242,152 @@ static void at91_adc_channel_remove(struct iio_dev *idev)
>>  	kfree(idev->channels);
>>  }
>>  
>> +static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
>> +{
>> +	struct iio_dev *idev = trig->private_data;
>> +	struct at91_adc_state *st = iio_priv(idev);
>> +	struct iio_buffer *buffer = idev->buffer;
>> +	u32 status = at91_adc_reg_read(st, AT91_ADC_MR);
>> +	u8 bit;
>> +
>> +	if (state) {
>> +		size_t datasize = buffer_get_bytes_per_datum(buffer);
>> +		int i;
>> +
>> +		st->buffer = kmalloc(datasize, GFP_KERNEL);
>> +		if (st->buffer == NULL)
>> +			return -ENOMEM;
>> +
>> +		for (i = 0; (st->desc->triggers + i) != NULL; i++) {
> I kind of feels here like we ought to be able to do better than matching
> by name.  After all, both ends of this match are controlled by this driver.
> Perhaps embed the iio_trigger structure in a device specific one and
> store some sort of reference in that?  Just feels a little odd as it
> currently stands...

I agree on having a better dispatch mechanism, but maybe we could just
add a integer ID in the iio_trigger structure directly instead of
relying on some "heavy" structure manipulation. Of course, this ID would
have to be set in stone by the driver, juste like the channel part in
iio_chan_spec.

>> +			char *name = kasprintf(GFP_KERNEL,
>> +					       "%s-dev%d-%s",
>> +					       idev->name,
>> +					       idev->id,
>> +					       st->desc->triggers[i].name);
>> +			if (name == NULL)
>> +				return -ENOMEM;
>> +
>> +			if (strcmp(idev->trig->name, name) == 0) {
>> +				status |= st->desc->triggers[i].value;
>> +				kfree(name);
>> +				break;
>> +			}
>> +
>> +			kfree(name);
>> +		}
>> +
>> +		if ((st->desc->triggers + i) == NULL)
>> +			return -EINVAL;
>> +
>> +		at91_adc_reg_write(st, AT91_ADC_MR, status);
>> +
>> +		for_each_set_bit(bit, buffer->scan_mask,
>> +				 st->desc->num_channels) {
>> +			struct iio_chan_spec const *chan = idev->channels + bit;
>> +			at91_adc_reg_write(st, AT91_ADC_CHER,
>> +					   AT91_ADC_CH(chan->channel));
>> +		}
>> +
>> +		at91_adc_reg_write(st, AT91_ADC_IER, AT91_ADC_DRDY);
>> +
>> +	} else {
>> +		at91_adc_reg_write(st, AT91_ADC_IDR, AT91_ADC_DRDY);
>> +		at91_adc_reg_write(st, AT91_ADC_MR,
>> +				   status & ~AT91_ADC_TRGEN);
>> +
>> +		for_each_set_bit(bit, buffer->scan_mask,
>> +				 st->desc->num_channels) {
>> +			at91_adc_reg_write(st, AT91_ADC_CHDR,
>> +					   AT91_ADC_CH(bit));
> Why do we need to look up the channel to turn it on, and not
> to turn it off?  Looks suspicious!

Oh, right.

> beware that things may well go wrong when we introduce multiple
> buffers.  I'm not sure that the scan configuration (which is
> what is actually happening here) should be in the trigger
> enable disable at all.  Is this just to get us back to a
> consistent state when not in triggered mode or is it
> needed to stop triggers occuring?

Both actually. It sets us back into a state were we can safely either
use software triggers or setup a new capture. If we remove the setup of
the channels from here and put it into some callback, I'm quite certain
we will reach some corner cases when we come back from triggered mode,
with channels still enabled in IIO (and presumably in the hardware too)
and read into in_voltageX_raw...

>> +		}
>> +		kfree(st->buffer);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct iio_trigger_ops at91_adc_trigger_ops = {
>> +	.owner = THIS_MODULE,
>> +	.set_trigger_state = &at91_adc_configure_trigger,
>> +};
>> +
> only one blank line please. (yup, i'm in a fussy mood ;)

Ok :)

>> +
>> +static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *idev,
>> +						     struct at91_adc_trigger *trigger)
>> +{
>> +	struct iio_trigger *trig = iio_allocate_trigger("%s-dev%d-%s",
>> +							idev->name,
>> +							idev->id,
>> +							trigger->name);
>> +	int ret;
>> +
>> +	if (trig == NULL)
>> +		return NULL;
>> +
>> +	trig->dev.parent = idev->dev.parent;
>> +	trig->owner = THIS_MODULE;
> Clearly my bug, but don't bother setting trig->owner as I'm
> going to clear it out shortly...  Actually you have led
> me to what looks like a nasty issue for any driver that don't
> have a trigger->ops (given that get and put trigger don't
> bother to check). For the interested, ad7793 and ad7192 are
> effected by this mess up.  Will post patches after this review.

I'm glad I can help :)

>> +	trig->private_data = idev;
>> +	trig->ops = &at91_adc_trigger_ops;
>> +
>> +	ret = iio_trigger_register(trig);
>> +	if (ret < 0)
>> +		return NULL;
>> +
>> +	return trig;
>> +}
>> +
>> +static int at91_adc_trigger_init(struct iio_dev *idev,
>> +				 struct at91_adc_data *pdata)
>> +{
>> +	struct at91_adc_state *st = iio_priv(idev);
>> +	int i, ret;
>> +
>> +	st->trig = kcalloc(sizeof(st->desc->triggers),
> 			   sizeof(st->trig),
> makes things a tiny little bit more obvious...
> (utter nitpick!)

Ok

>> +			   sizeof(struct iio_trigger *),
>> +			   GFP_KERNEL);
>> +
>> +	if (st->trig == NULL) {
>> +		ret = -ENOMEM;
>> +		goto error_ret;
>> +	}
>> +
>> +	for (i = 0; st->desc->triggers[i].name != NULL; i++) {
>> +		if (st->desc->triggers[i].is_external && !(pdata->use_external))
>> +			continue;
>> +
>> +		st->trig[i] = at91_adc_allocate_trigger(idev,
>> +							st->desc->triggers + i);
>> +		if (st->trig[i] == NULL) {
>> +			ret = -ENOMEM;
>> +			goto error_trigger;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +
>> +error_trigger:
>> +	for (; i >= 0; i--) {
>> +		iio_trigger_unregister(st->trig[i]);
>> +		iio_free_trigger(st->trig[i]);
>> +	}
>> +	kfree(st->trig);
>> +error_ret:
>> +	return ret;
>> +}
>> +
>> +static void at91_adc_trigger_remove(struct iio_dev *idev)
>> +{
>> +	struct at91_adc_state *st = iio_priv(idev);
>> +	int i;
>> +
>> +	for (i = 0; st->desc->triggers[i].name != NULL; i++) {
>> +		iio_trigger_unregister(st->trig[i]);
>> +		iio_free_trigger(st->trig[i]);
>> +	}
>> +
>> +	kfree(st->trig);
>> +}
>> +
>>  static int at91_adc_read_raw(struct iio_dev *idev,
>>  			     struct iio_chan_spec const *chan,
>>  			     int *val, int *val2, long mask)
>> @@ -321,14 +571,34 @@ static int __devinit at91_adc_probe(struct platform_device *pdev)
>>  	st->vref_mv = pdata->vref;
>>  	st->channels_mask = pdata->channels_used;
>>  
>> +	ret = iio_sw_rb_simple_setup(idev,
>> +				     &iio_pollfunc_store_time,
>> +				     &at91_adc_trigger_handler);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "Couldn't initialize the buffer.\n");
>> +		goto error_free_channels;
>> +	}
>> +
>> +	idev->buffer->scan_timestamp = true;
> I've just been moaning at others about this.  Is there a good reason why
> this wants to be on by default?  I'd much rather decisions on this were
> left to userspace. Hence lets assume no one wants any data unless they
> tell us otherwise. (note I'm not sure this will play well with the
> in kernel push interface stuff so I may well be killing off all
> remaining cases where this occurs anyway...

It makes sense indeed.

>> +
>> +	ret = at91_adc_trigger_init(idev, pdata);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "Couldn't setup the triggers.\n");
>> +		goto error_unregister_buffer;
>> +	}
>> +
>>  	ret = iio_device_register(idev);
>>  	if (ret < 0) {
>>  		dev_err(&pdev->dev, "Couldn't register the device.\n");
>> -		goto error_free_channels;
>> +		goto error_remove_triggers;
>>  	}
>>  
>>  	return 0;
>>  
>> +error_remove_triggers:
>> +	at91_adc_trigger_remove(idev);
>> +error_unregister_buffer:
>> +	iio_sw_rb_simple_cleanup(idev);
>>  error_free_channels:
>>  	at91_adc_channel_remove(idev);
>>  error_free_clk:
>> @@ -353,6 +623,8 @@ static int __devexit at91_adc_remove(struct platform_device *pdev)
>>  	struct at91_adc_state *st = iio_priv(idev);
>>  
>>  	iio_device_unregister(idev);
>> +	at91_adc_trigger_remove(idev);
>> +	iio_sw_rb_simple_cleanup(idev);
>>  	at91_adc_channel_remove(idev);
>>  	clk_disable(st->clk);
>>  	clk_put(st->clk);
>> diff --git a/include/linux/platform_data/at91_adc.h b/include/linux/platform_data/at91_adc.h
>> index ab43de8..b1d3a6d 100644
>> --- a/include/linux/platform_data/at91_adc.h
>> +++ b/include/linux/platform_data/at91_adc.h
>> @@ -18,10 +18,12 @@
>>  /**
>>   * struct at91_adc_data - platform data for ADC driver
>>   * @channels_use:	channels in use on the board as a bitmask
>> + * @use_external:	does the board has external triggers availables
>>   * @vref:		Reference voltage for the ADC in millvolts
>>   */
>>  struct at91_adc_data {
>>  	u32	channels_used;
>> +	bool	use_external;
>>  	u16	vref;
>>  };
>>  
> 


-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
