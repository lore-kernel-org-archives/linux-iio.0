Return-Path: <lars@metafoo.de>
Message-ID: <4FF55149.2080801@metafoo.de>
Date: Thu, 05 Jul 2012 10:33:13 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jonathan Cameron <jic23@kernel.org>,
 Wolfgang Denk <wd@denx.de>, Juergen Beisert <jbe@pengutronix.de>
Subject: Re: [PATCH] IIO: Add basic MXS LRADC driver
References: <1341368129-20468-1-git-send-email-marex@denx.de> <4FF40044.90904@metafoo.de> <201207050148.27289.marex@denx.de>
In-Reply-To: <201207050148.27289.marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 07/05/2012 01:48 AM, Marek Vasut wrote:
> Dear Lars-Peter Clausen,
> 
>> On 07/04/2012 04:15 AM, Marek Vasut wrote:
>>> This driver is very basic. It supports userland trigger, buffer and
>>> raw access to channels. The support for delay channels is missing
>>> altogether.
>>>
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> Cc: Jonathan Cameron <jic23@kernel.org>
>>> Cc: Wolfgang Denk <wd@denx.de>
>>> Cc: Juergen Beisert <jbe@pengutronix.de>
>>> [...]
>>
>> The overall structure looks good, but a few things need to be addressed.
>> I also think the driver doesn't have to go through staging and could be put
>> in to the out-of-staging part of iio.
> 
> Come and rip me to shreds ;-)
> 
> [...]
> 
>>> +	wait_queue_head_t	wq_data_avail[LRADC_MAX_MAPPED_CHANS];
>>> +	bool			wq_done[LRADC_MAX_MAPPED_CHANS];
>>
>> This and it's usage looks a bit like an open-coded struct completion.
> 
> Indeed, completion is good for this :)
> 
>>> +};
>>> +
>>> +struct mxs_lradc_data {
>>> +	struct mxs_lradc	*lradc;
>>> +};
>>
>> Is there any reason not to use the mxs_lradc struct directly has the iio
>> data?
> 
> I explained it below in the patch. I hope we'll eventually support the delay 
> triggers, which will need 4 separate IIO devices. And this is where this 
> structure will be augmented by other components.

Ok I saw the comment, but it wasn't obvious to me that delay channels will
require multiple IIO devices. Might make sense to state this explicitly.

> 
>>> [...]
>>>
>>> +
>>> +/*
>>> + * Channel management
>>> + *
>>> + * This involves crazy mapping between 8 virtual channels the CTRL4
>>> register + * can harbor and 16 channels total this hardware supports.
>>> + */
>>
>> I suppose this means only a maximum 8 channels can be active at a time.
>> I've recently posted a patch which makes it easy to implement such a
>> restriction. http://www.spinics.net/lists/linux-iio/msg05936.html and
>> http://www.spinics.net/lists/linux-iio/msg05935.html for an example
>> validate callback implementation. In your case you'd check for
>> bitmap_weight(...) <= 8. Those patches are not yet in IIO though.
> 
> This is good. When do you expect this to hit linux-next possibly? Or at least 
> linux-iio?
> 

soon, hopefully.

> [..]
> 
>>> +static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
>>> +			const struct iio_chan_spec *chan,
>>> +			int *val, int *val2, long m)
>>> +{
>>> +	struct mxs_lradc_data *data = iio_priv(iio_dev);
>>> +	struct mxs_lradc *lradc = data->lradc;
>>> +	int ret, slot;
>>> +
>>> +	if (m != 0)
>>
>> I'd use the symbolic constant here IIO_CHAN_INFO_RAW
>>
>>> +		return -EINVAL;
>>> +
>>> +	/* Map channel. */
>>> +	slot = mxs_lradc_map_channel(lradc, chan->channel,
>>> LRADC_CHAN_FLAG_RAW); +	if (slot < 0)
>>> +		return slot;
>>> +
>>> +	/* Start sampling. */
>>> +	mxs_lradc_run_slots(lradc, 1 << slot);
>>> +
>>> +	/* Wait for completion on the channel, 1 second max. */
>>> +	lradc->wq_done[slot] = false;
>>> +	ret = wait_event_interruptible_timeout(lradc->wq_data_avail[slot],
>>> +					       lradc->wq_done[slot],
>>> +					       msecs_to_jiffies(1000));
>>> +	if (!ret) {

Just noticed this, wait_event_interruptible_timeout can return an error
value, e.g. if it has been interrupted.

>>> +		ret = -ETIMEDOUT;
>>> +		goto err;
>>> +	}
>>> +
>>
>> How well will this work if the device is currrently in buffered mode? Maybe
>> it's better do disablow it by checking iio_buffer_enabled and return -EBUSY
>> if it returns true;
> 
> I believe this should work perfectly OK, why won't it ? I tried to avoid such 
> artificial limitation.
> 

I suppose it is fine, but not knowing the hardware, what does
mxs_lradc_run_slots do exactly?

> [...]
> 
>>> +static int mxs_lradc_configure_trigger(struct iio_trigger *trig, bool
>>> state) +{
>>> +	struct iio_dev *iio = trig->private_data;
>>> +	struct mxs_lradc_data *data = iio_priv(iio);
>>> +	struct mxs_lradc *lradc = data->lradc;
>>> +	struct iio_buffer *buffer = iio->buffer;
>>> +	int slot, bit, ret = 0;
>>> +	uint8_t map = 0;
>>> +	unsigned long chans = 0;
>>> +
>>> +	if (!state)
>>> +		goto exit;
>>> +
>>> +	lradc->buffer = kmalloc(iio->scan_bytes, GFP_KERNEL);
>>> +	if (!lradc->buffer)
>>> +		return -ENOMEM;
>>> +
>>> +	for_each_set_bit(bit, buffer->scan_mask, LRADC_MAX_TOTAL_CHANS) {
>>> +		slot = mxs_lradc_map_channel(lradc, bit, LRADC_CHAN_FLAG_BUF);
>>> +
>>> +		if (slot < 0) {
>>> +			ret = -EINVAL;
>>> +			goto exit;
>>> +		}
>>> +		map |= 1 << slot;
>>> +		chans |= 1 << bit;
>>> +	}
>>
>> I think this should go into the buffer preenable and postdisable callbacks.
> 
> How much of it, only the slot mapping or the allocation too ?
> 

Yeah I guess it is a bit tricky in this case. A good rule of thumb is to ask
yourself whether the driver will (hypothetically) still work if another
trigger is used. So the buffer allocation should certainly be handled by the
buffer code, either the prenable or the update_scan_mode callback. The
channel mapping part is not so obvious, but I'd put it in the
preenable/postdisable callbacks as well.
