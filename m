Return-Path: <lars@metafoo.de>
Message-ID: <504B7E4F.1050902@metafoo.de>
Date: Sat, 08 Sep 2012 19:20:15 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
 drivers@analog.com
Subject: Re: [PATCH 03/10] staging:iio:ad7476: Avoid alloc/free for each sample
 in buffered mode
References: <1347021872-7885-1-git-send-email-lars@metafoo.de> <1347021872-7885-3-git-send-email-lars@metafoo.de> <504A22AD.2050403@metafoo.de> <504B12A8.6010909@kernel.org>
In-Reply-To: <504B12A8.6010909@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 09/08/2012 11:40 AM, Jonathan Cameron wrote:
> On 09/07/2012 05:37 PM, Lars-Peter Clausen wrote:
>> On 09/07/2012 02:44 PM, Lars-Peter Clausen wrote:
>>> The ad7476 driver has only support for 1 channel ADCs. So the upper limit for
>>> the buffer size is the size of one sample plus the size of the timestamp.
>>> Preallocate a buffer large enough to hold this to avoid having to allocate and
>>> free a new buffer for each sample being captured.
> Sensible move...
>>>
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>> ---
>>>  drivers/staging/iio/adc/ad7476.h      |    5 ++++-
>>>  drivers/staging/iio/adc/ad7476_ring.c |   13 +++----------
>>>  2 files changed, 7 insertions(+), 11 deletions(-)
>>>
[...]
>>>  enum ad7476_supported_device_ids {
>>> diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
>>> index 940681f..185cfde 100644
>>> --- a/drivers/staging/iio/adc/ad7476_ring.c
>>> +++ b/drivers/staging/iio/adc/ad7476_ring.c
>>> @@ -26,14 +26,9 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
>>>  	struct iio_dev *indio_dev = pf->indio_dev;
>>>  	struct ad7476_state *st = iio_priv(indio_dev);
>>>  	s64 time_ns;
>>> -	__u8 *rxbuf;
>>>  	int b_sent;
>>>  
>>> -	rxbuf = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
>>> -	if (rxbuf == NULL)
>>> -		goto done;
>>> -
>>> -	b_sent = spi_read(st->spi, rxbuf,
>>> +	b_sent = spi_read(st->spi, st->data,
>>>  			  st->chip_info->channel[0].scan_type.storagebits / 8);
>>
>> I just noticed this can even more be simplified by using the prepared SPI
>> message. Unfortunately this will require regeneration of a few more patches.
>> I'll resend the whole series next week, after it had some exposure to review.
> 
> Hmm. Guess that would be a marginal improvement.  Actually from code
> readability I'd be tempted to drop the prepared SPI message and
> just do the spi_read as you have it here where that message is currently used.
> 
> Obviously it'll have some overhead though so up to you which way you go.

I think the overhead is actually negligible. But there is a pattern that
emerges. For SPI based devices we usually first send the spi message which
fills the transfer buffer, then store the timestamp in the last element of the
transfer buffer and then send the transfer buffer to the iio buffer using
iio_push_to_buffer. What differs for different devices is how exactly the
message looks, but the rest of the pattern is identical. So if we define the
the message outside of the trigger handler, e.g. at device init or the
update_scan_mode callback we get the opportunity to have a common trigger
function between a wide range of different SPI devices. Obviously it wont work
for all, because some need special handling, but it will provide a good default
implementation. So that's one reason why I'd like to use spi_sync here, since
it will make the migration later on more obvious.

- Lars
