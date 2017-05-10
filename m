Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:6234 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752474AbdEJIsk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 May 2017 04:48:40 -0400
Subject: Re: [PATCH v2 2/3] iio: adc: at91-sama5d2_adc: add hw trigger and
 buffer support
To: Jonathan Cameron <jic23@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@free-electrons.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1493900000-26220-1-git-send-email-eugen.hristev@microchip.com>
 <1493900000-26220-3-git-send-email-eugen.hristev@microchip.com>
 <aeaf25d7-5e05-d854-1ae9-06d224925cad@kernel.org>
CC: <ludovic.desroches@microchip.com>
From: Eugen Hristev <eugen.hristev@microchip.com>
Message-ID: <7fb32b5f-4705-ab23-d9c8-020b03af9ac1@microchip.com>
Date: Wed, 10 May 2017 11:49:07 +0300
MIME-Version: 1.0
In-Reply-To: <aeaf25d7-5e05-d854-1ae9-06d224925cad@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

Thanks for the suggestions and reply.

Please see my answers inline

Eugen

On 07.05.2017 18:01, Jonathan Cameron wrote:
> On 04/05/17 13:13, Eugen Hristev wrote:
>> Added support for the external hardware trigger on pin ADTRG,
>> integrated the three possible edge triggers into the subsystem
>> and created buffer management for data retrieval
>>
>> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
>> ---
>>   Changes in v2:
>>  - Moved buffer allocation and freeing into the preenable and postdisable
>>    callbacks.
>>    We have a total of scan bytes that can vary a lot depending on each channel
>>    enabled at a certain point.
> How much?  Having dynamic allocations are likely to prove just as costly as you'll
> almost always end up allocating a lot more than you ask for.
>
> I'm counting worst case of 18x 2byte channels + timestamp = 48 bytes.
> A quick google suggests you'll always allocate 32 bytes whatever with slab
> (lower for slob). So not a huge saving...
>
> Worth the hassle?


I will modify the allocation of scan_bytes to make it static.

>
>>  - made the at91 trigger list part of state structure
>>  - made the iio trigger list preallocated in state structure
>>  - moved irq enabling/disabling into the try_reenable callback
> I'd have liked a little explanation on why we need to explicitly disable
> the irq.  It will have little effect it if triggers too often as the
> trigger consumers are all oneshot anyway.

Regarding the irq, the discussion is a bit longer.

As it is now, the interrupt is not a oneshot threaded one, because only
the top half handler is installed, and the threaded one is NULL.
Calling trigger_poll without disabling the interrupt will make the
handler loop, so that is the reason for disabling and reenabling
the interrupt.

One solution is to change it to oneshot threaded interrupt and call
trigger_poll_chained to make it a nested handling. This will make a
longer response time for conversions though.

One other option is to do irq_save and irq_restore before issuing the
trigger poll, but that limits the usability of the trigger by any
other device I guess.

I did the behavior with disabling and enabling the interrupt considering
the old at91 driver and the stm32-adc driver which looks to be fairly
similar with this implementation.

Can you please advise on which approach you think it's best for this
driver ?
So I can try that, and resend the patch.

>>  - on trigger disable must write disable registries as well
> Basically looks good. A few questions inline.
>
> Jonathan
>>
>>  drivers/iio/adc/at91-sama5d2_adc.c | 231 ++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 228 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
>> index e10dca3..11f5570 100644
>> --- a/drivers/iio/adc/at91-sama5d2_adc.c
>> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
>> @@ -23,8 +23,15 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/sched.h>
>>  #include <linux/wait.h>
>> +#include <linux/slab.h>
>> +
>>  #include <linux/iio/iio.h>
>>  #include <linux/iio/sysfs.h>
>> +#include <linux/iio/buffer.h>
>> +#include <linux/iio/trigger.h>
>> +#include <linux/iio/trigger_consumer.h>
>> +#include <linux/iio/triggered_buffer.h>
>> +
>>  #include <linux/regulator/consumer.h>
>>
>>  /* Control Register */
>> @@ -132,6 +139,17 @@
>>  #define AT91_SAMA5D2_PRESSR	0xbc
>>  /* Trigger Register */
>>  #define AT91_SAMA5D2_TRGR	0xc0
>> +/* Mask for TRGMOD field of TRGR register */
>> +#define AT91_SAMA5D2_TRGR_TRGMOD_MASK GENMASK(2, 0)
>> +/* No trigger, only software trigger can start conversions */
>> +#define AT91_SAMA5D2_TRGR_TRGMOD_NO_TRIGGER 0
>> +/* Trigger Mode external trigger rising edge */
>> +#define AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_RISE 1
>> +/* Trigger Mode external trigger falling edge */
>> +#define AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_FALL 2
>> +/* Trigger Mode external trigger any edge */
>> +#define AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_ANY 3
>> +
>>  /* Correction Select Register */
>>  #define AT91_SAMA5D2_COSR	0xd0
>>  /* Correction Value Register */
>> @@ -145,14 +163,20 @@
>>  /* Version Register */
>>  #define AT91_SAMA5D2_VERSION	0xfc
>>
>> +#define AT91_SAMA5D2_HW_TRIG_CNT 3
>> +#define AT91_SAMA5D2_SINGLE_CHAN_CNT 12
>> +#define AT91_SAMA5D2_DIFF_CHAN_CNT 6
>> +
>>  #define AT91_SAMA5D2_CHAN_SINGLE(num, addr)				\
>>  	{								\
>>  		.type = IIO_VOLTAGE,					\
>>  		.channel = num,						\
>>  		.address = addr,					\
>> +		.scan_index = num,					\
>>  		.scan_type = {						\
>>  			.sign = 'u',					\
>>  			.realbits = 12,					\
>> +			.storagebits = 16,				\
>>  		},							\
>>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
>> @@ -168,9 +192,11 @@
>>  		.channel = num,						\
>>  		.channel2 = num2,					\
>>  		.address = addr,					\
>> +		.scan_index = num + AT91_SAMA5D2_SINGLE_CHAN_CNT,	\
>>  		.scan_type = {						\
>>  			.sign = 's',					\
>>  			.realbits = 12,					\
>> +			.storagebits = 16,				\
>>  		},							\
>>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
>> @@ -188,18 +214,25 @@ struct at91_adc_soc_info {
>>  	unsigned			max_sample_rate;
>>  };
>>
>> +struct at91_adc_trigger {
>> +	char				*name;
>> +	unsigned int			trgmod_value;
>> +};
>> +
>>  struct at91_adc_state {
>>  	void __iomem			*base;
>>  	int				irq;
>>  	struct clk			*per_clk;
>>  	struct regulator		*reg;
>>  	struct regulator		*vref;
>> +	u16				*buffer;
>>  	int				vref_uv;
>>  	const struct iio_chan_spec	*chan;
>>  	bool				conversion_done;
>>  	u32				conversion_value;
>>  	struct at91_adc_soc_info	soc_info;
>>  	wait_queue_head_t		wq_data_available;
>> +	struct iio_trigger		*trig[AT91_SAMA5D2_HW_TRIG_CNT];
>>  	/*
>>  	 * lock to prevent concurrent 'single conversion' requests through
>>  	 * sysfs.
>> @@ -207,6 +240,21 @@ struct at91_adc_state {
>>  	struct mutex			lock;
>>  };
>>
>> +static const struct at91_adc_trigger at91_adc_trigger_list[] = {
>> +	{
>> +		.name = "external-rising",
>> +		.trgmod_value = AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_RISE,
>> +	},
>> +	{
>> +		.name = "external-falling",
>> +		.trgmod_value = AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_FALL,
>> +	},
>> +	{
>> +		.name = "external-any",
>> +		.trgmod_value = AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_ANY,
>> +	},
> Hmm. Should this be a userspace configurable option?  Feels rather like
> it is an element of the hardware - reflecting the characteristics of some
> hardware device sat on the pin.
The user can choose from sysfs which trigger
is best suited for the use case, since all
three triggers are provided and can be connected to the buffer.
It reflects more the triggering capability of the ADC rather than
any different hardware device sitting on the pin

>> +};
>> +
>>  static const struct iio_chan_spec at91_adc_channels[] = {
>>  	AT91_SAMA5D2_CHAN_SINGLE(0, 0x50),
>>  	AT91_SAMA5D2_CHAN_SINGLE(1, 0x54),
>> @@ -226,8 +274,168 @@ static const struct iio_chan_spec at91_adc_channels[] = {
>>  	AT91_SAMA5D2_CHAN_DIFF(6, 7, 0x68),
>>  	AT91_SAMA5D2_CHAN_DIFF(8, 9, 0x70),
>>  	AT91_SAMA5D2_CHAN_DIFF(10, 11, 0x78),
>> +	IIO_CHAN_SOFT_TIMESTAMP(AT91_SAMA5D2_SINGLE_CHAN_CNT
>> +				+ AT91_SAMA5D2_DIFF_CHAN_CNT + 1),
>>  };
>>
>> +static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
>> +{
>> +	struct iio_dev *indio = iio_trigger_get_drvdata(trig);
>> +	struct at91_adc_state *st = iio_priv(indio);
>> +	u32 status = at91_adc_readl(st, AT91_SAMA5D2_TRGR);
>> +	u8 bit;
>> +	int i;
>> +
>> +	/* clear TRGMOD */
>> +	status &= ~AT91_SAMA5D2_TRGR_TRGMOD_MASK;
>> +
>> +	if (state)
>> +		for (i = 0; i < AT91_SAMA5D2_HW_TRIG_CNT; i++) {
>> +			if (!strstr(trig->name,
>> +				    at91_adc_trigger_list[i].name)) {
>> +				status |= at91_adc_trigger_list[i].trgmod_value;
>> +				break;
>> +			}
>> +		}
>> +
>> +	/* set/unset hw trigger */
>> +	at91_adc_writel(st, AT91_SAMA5D2_TRGR, status);
>> +
>> +	for_each_set_bit(bit, indio->active_scan_mask, indio->num_channels) {
>> +		struct iio_chan_spec const *chan = indio->channels + bit;
>> +
>> +		if (state) {
>> +			at91_adc_writel(st, AT91_SAMA5D2_CHER,
>> +					BIT(chan->channel));
>> +			at91_adc_writel(st, AT91_SAMA5D2_IER,
>> +					BIT(chan->channel));
>> +		} else {
>> +			at91_adc_writel(st, AT91_SAMA5D2_IDR,
>> +					BIT(chan->channel));
>> +			at91_adc_writel(st, AT91_SAMA5D2_CHDR,
>> +					BIT(chan->channel));
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int at91_adc_reenable_trigger(struct iio_trigger *trig)
>> +{
>> +	struct iio_dev *indio = iio_trigger_get_drvdata(trig);
>> +	struct at91_adc_state *st = iio_priv(indio);
>> +
>> +	enable_irq(st->irq);
>> +	return 0;
>> +}
>> +
>> +static const struct iio_trigger_ops at91_adc_trigger_ops = {
>> +	.owner = THIS_MODULE,
>> +	.set_trigger_state = &at91_adc_configure_trigger,
>> +	.try_reenable = &at91_adc_reenable_trigger,
>> +};
>> +
>> +static int at91_adc_buffer_preenable(struct iio_dev *indio_dev)
>> +{
>> +	struct at91_adc_state *st = iio_priv(indio_dev);
>> +
>> +	st->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);Why allocate it here?  Presumably the biggest it can get is fairly
> small?  Unless very large, just make sure you allocate enough
> directly in st in the first place.

Yes , as discussed above will change to static allocation.

>
>> +
>> +	if (!st->buffer)
>> +		return -ENOMEM;
>> +
>> +	return 0;
>> +}
>> +
>> +static int at91_adc_buffer_postdisable(struct iio_dev *indio_dev)
>> +{
>> +	struct at91_adc_state *st = iio_priv(indio_dev);
>> +
>> +	kfree(st->buffer);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct iio_buffer_setup_ops at91_buffer_setup_ops = {
>> +	.preenable = &at91_adc_buffer_preenable,
>> +	.postenable = &iio_triggered_buffer_postenable,
>> +	.predisable = &iio_triggered_buffer_predisable,
>> +	.postdisable = &at91_adc_buffer_postdisable,
>> +};
>> +
>> +static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *indio,
>> +						     char *trigger_name)
>> +{
>> +	struct iio_trigger *trig;
>> +	int ret;
>> +
>> +	trig = devm_iio_trigger_alloc(&indio->dev, "%s-dev%d-%s", indio->name,
>> +				      indio->id, trigger_name);
>> +	if (!trig)
>> +		return NULL;
>> +
>> +	trig->dev.parent = indio->dev.parent;
>> +	iio_trigger_set_drvdata(trig, indio);
>> +	trig->ops = &at91_adc_trigger_ops;
>> +
>> +	ret = devm_iio_trigger_register(&indio->dev, trig);
>> +
>> +	if (ret)
>> +		return NULL;
>> +
>> +	return trig;
>> +}
>> +
>> +static int at91_adc_trigger_init(struct iio_dev *indio)
>> +{
>> +	struct at91_adc_state *st = iio_priv(indio);
>> +	int i;
>> +
>> +	for (i = 0; i < AT91_SAMA5D2_HW_TRIG_CNT; i++) {
>> +		st->trig[i] = at91_adc_allocate_trigger(indio,
>> +						at91_adc_trigger_list[i].name);
>> +		if (!st->trig[i]) {
>> +			dev_err(&indio->dev,
>> +				"could not allocate trigger %d\n", i);
>> +			return -ENOMEM;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *indio = pf->indio_dev;
>> +	struct at91_adc_state *st = iio_priv(indio);
>> +	int i = 0;
>> +	u8 bit;
>> +
>> +	for_each_set_bit(bit, indio->active_scan_mask, indio->num_channels) {
>> +		struct iio_chan_spec const *chan = indio->channels + bit;
>> +
>> +		st->buffer[i] = at91_adc_readl(st, chan->address);
>> +		i++;
>> +	}
>> +
>> +	iio_push_to_buffers_with_timestamp(indio, st->buffer, pf->timestamp);
>> +
>> +	iio_trigger_notify_done(indio->trig);
>> +
>> +	/* Needed to ACK the DRDY interruption */
>> +	at91_adc_readl(st, AT91_SAMA5D2_LCDR);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int at91_adc_buffer_init(struct iio_dev *indio)
>> +{
>> +	return devm_iio_triggered_buffer_setup(&indio->dev, indio,
>> +			&iio_pollfunc_store_time,
>> +			&at91_adc_trigger_handler, &at91_buffer_setup_ops);
>> +}
>> +
>>  static unsigned at91_adc_startup_time(unsigned startup_time_min,
>>  				      unsigned adc_clk_khz)
>>  {
>> @@ -293,14 +501,19 @@ static irqreturn_t at91_adc_interrupt(int irq, void *private)
>>  	u32 status = at91_adc_readl(st, AT91_SAMA5D2_ISR);
>>  	u32 imr = at91_adc_readl(st, AT91_SAMA5D2_IMR);
>>
>> -	if (status & imr) {
>> +	if (!(status & imr))
>> +		return IRQ_NONE;
>> +
>> +	if (iio_buffer_enabled(indio)) {
>> +		disable_irq_nosync(irq);
>> +		iio_trigger_poll(indio->trig);
>> +	} else {
>>  		st->conversion_value = at91_adc_readl(st, st->chan->address);
>>  		st->conversion_done = true;
>>  		wake_up_interruptible(&st->wq_data_available);
>> -		return IRQ_HANDLED;
>>  	}
>>
>> -	return IRQ_NONE;
>> +	return IRQ_HANDLED;
>>  }
>>
>>  static int at91_adc_read_raw(struct iio_dev *indio_dev,
>> @@ -499,6 +712,18 @@ static int at91_adc_probe(struct platform_device *pdev)
>>
>>  	platform_set_drvdata(pdev, indio_dev);
>>
>> +	ret = at91_adc_buffer_init(indio_dev);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "couldn't initialize the buffer.\n");
>> +		goto per_clk_disable_unprepare;
>> +	}
>> +
>> +	ret = at91_adc_trigger_init(indio_dev);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "couldn't setup the triggers.\n");
>> +		goto per_clk_disable_unprepare;
>> +	}
>> +
>>  	ret = iio_device_register(indio_dev);
>>  	if (ret < 0)
>>  		goto per_clk_disable_unprepare;
>>
>
