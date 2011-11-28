Return-Path: <jic23@kernel.org>
Message-ID: <4ED3FDCD.8030302@kernel.org>
Date: Mon, 28 Nov 2011 21:31:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, Michael.Hennerich@analog.com,
 manuel.stahl@iis.fraunhofer.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 04/16] staging:iio: scrap scan_count and ensure all drivers
 use active_scan_mask
References: <1322400825-29400-1-git-send-email-jic23@kernel.org> <1322400825-29400-5-git-send-email-jic23@kernel.org> <4ED3584B.3040603@metafoo.de> <4ED3B385.1000002@metafoo.de> <4ED3F6F7.2090008@kernel.org> <4ED3FAE7.5070307@metafoo.de>
In-Reply-To: <4ED3FAE7.5070307@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 11/28/2011 09:19 PM, Lars-Peter Clausen wrote:
> On 11/28/2011 10:02 PM, Jonathan Cameron wrote:
>> On 11/28/2011 04:15 PM, Lars-Peter Clausen wrote:
>>> On 11/28/2011 10:45 AM, Lars-Peter Clausen wrote:
>>>> On 11/27/2011 02:33 PM, Jonathan Cameron wrote:
>>>>> From: Jonathan Cameron <jic23@cam.ac.uk>
>>>>>
>>>>> Obviously drivers should only use this for pushing to buffers.
>>>>> They need buffer->scan_mask for pulling from them post demux.
>>>>>
>>>>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>>>>> ---
>>>>>  drivers/staging/iio/accel/adis16201_ring.c      |   10 +++++-----
>>>>>  drivers/staging/iio/accel/adis16203_ring.c      |   10 +++++-----
>>>>>  drivers/staging/iio/accel/adis16204_ring.c      |   10 +++++-----
>>>>>  drivers/staging/iio/accel/adis16209_ring.c      |    5 +++--
>>>>>  drivers/staging/iio/accel/adis16240_ring.c      |    5 +++--
>>>>>  drivers/staging/iio/accel/lis3l02dq_ring.c      |   23 +++++++++++++----------
>>>>>  drivers/staging/iio/adc/ad7192.c                |   10 ++++++----
>>>>>  drivers/staging/iio/adc/ad7298_ring.c           |   12 +++++++-----
>>>>>  drivers/staging/iio/adc/ad7476_ring.c           |    3 ++-
>>>>>  drivers/staging/iio/adc/ad7793.c                |   11 ++++++-----
>>>>>  drivers/staging/iio/adc/ad7887_ring.c           |    8 +++++---
>>>>>  drivers/staging/iio/adc/ad799x_ring.c           |   13 ++++++++-----
>>>>>  drivers/staging/iio/buffer.h                    |    2 --
>>>>>  drivers/staging/iio/gyro/adis16260_ring.c       |    5 +++--
>>>>>  drivers/staging/iio/iio_simple_dummy_buffer.c   |    7 +++++--
>>>>>  drivers/staging/iio/impedance-analyzer/ad5933.c |   14 ++++++++------
>>>>>  drivers/staging/iio/imu/adis16400_ring.c        |   19 +++++++++++--------
>>>>>  drivers/staging/iio/industrialio-buffer.c       |    2 --
>>>>>  drivers/staging/iio/meter/ade7758_ring.c        |    7 ++++---
>>>>>  19 files changed, 99 insertions(+), 77 deletions(-)
>>>>>
>>>>> diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
>>>>> index 936e8cb..68d4b38 100644
>>>>> --- a/drivers/staging/iio/accel/adis16201_ring.c
>>>>> +++ b/drivers/staging/iio/accel/adis16201_ring.c
>>>>> @@ -74,11 +74,11 @@ static irqreturn_t adis16201_trigger_handler(int irq, void *p)
>>>>>  		return -ENOMEM;
>>>>>  	}
>>>>>  
>>>>> -	if (ring->scan_count)
>>>>> -		if (adis16201_read_ring_data(indio_dev, st->rx) >= 0)
>>>>> -			for (; i < ring->scan_count; i++)
>>>>> -				data[i] = be16_to_cpup(
>>>>> -					(__be16 *)&(st->rx[i*2]));
>>>>> +	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength)
>>>>> +	    && adis16201_read_ring_data(indio_dev, st->rx) >= 0)
>>>>> +		for (; i < bitmap_weight(indio_dev->active_scan_mask,
>>>>> +					 indio_dev->masklength); i++)
>>>>> +			data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
>>>>>  
>>>>
>>>> Does it really make sense to recompute bitmap_weight for each transfer?
>>>> Can't we update scan_count once, when we update the scan_mask?
>> I partly got rid of scan mask to make the more 'interesting' route with
>> the active scan mask stuff easier to adapt (information is now in only
>> one place.).
>> I'd not be against caching this somewhere if it is convenient for the
>> driver (such as in the update_scan_mode callback). I'm not however
>> convinced it should be in the core code.  Mostly the transfers that rely
>> on this should probably be setup in the preenable functions etc
>> rather than buffers being allocated in this fast path. This particular
>> approach is based on some of my early drivers. I much prefer Michaels
>> drivers where the whole transfer sequence is setup and only changed when
>> the channels being captured change.  The only other common use case is a
>> fudge to get the timestamp in the right place.
>> It kind of feels there ought to be a better way of handing software
>> timestamps.  Perhaps your timestamp source stuff that mentioned in
>> the ZIO thread.
>>
>> This particular example is a bad one as it shouldn't be there at all
>> given we no longer do endian conversion but rather describe the buffer.
>>
>> Don't suppose you fancy writing the patch that gets rid of these endian
>> conversions?  If not I'll get to it, but may not be that soon.
> 
> I'll try to have a look at it tomorrow.
> 
>>> Also: for chips where we can only read all values at once, should we set
>>> available_scan_masks to ~0 and just let the demuxer handle everything else?
>> No. For consistency (and ability to use some of the standard functions)
>> the available scan masks should list the actual combination that is
>> available.  Assuming I've understood you correctly and you don't just
>> mean for the channels that exist?
>>>
> 
> What I meant was, if for example a device has 4 channels and we can only read
> all 4 channels together and not selectively only a subset, available_scan_masks
> should contain one item set to 0xf. This would allow us to just pass the buffer
> we read from the device up to the next level and let the demuxer take care of
> splitting it up instead of manually do the demuxing, like it is done now.
Agreed.  I just only implemented the demux usage for the max1363 so far.
Definitely the intention that things like this will be covered.
> 
> E.g. the adis16201_trigger_handler would basically boil down to:
> ring->access->store_to(ring, st->rx, pf->timestamp);
> 
> On the other hand the adis16201 seems to support reading a subset of registers,
> but it's just not implemented.
IIRC it's to do with the fact that burst mode reading of everything is
faster for more than a couple of registers...  Hence no one bothered.
