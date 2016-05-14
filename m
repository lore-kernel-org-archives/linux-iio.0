Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35844 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbcENRyr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 May 2016 13:54:47 -0400
Subject: Re: [RFC PATCH v1 4/9] iio:st_sensors: align on storagebits
 boundaries
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1461056711.git.gregor.boirie@parrot.com>
 <6b0ff9259418de8dacf125f642f2737ffcb62065.1461056711.git.gregor.boirie@parrot.com>
 <6e284ab9-bf02-37eb-fa8b-4741d55fd6bd@kernel.org>
 <974d01ea-326b-9a18-3a12-131eefcfbbf8@kernel.org> <57270DAB.40401@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Denis Ciocca <denis.ciocca@st.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Giuseppe Barba <giuseppe.barba@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <632c0abb-9204-4c02-da22-f2386e06dfcd@kernel.org>
Date: Sat, 14 May 2016 18:54:43 +0100
MIME-Version: 1.0
In-Reply-To: <57270DAB.40401@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/05/16 09:19, Gregor Boirie wrote:
> 
> 
> On 05/01/2016 09:27 PM, Jonathan Cameron wrote:
>> On 24/04/16 10:35, Jonathan Cameron wrote:
>>> On 19/04/16 10:18, Gregor Boirie wrote:
>>>> Triggered buffering memory accesses are not aligned on per channel
>>>> storagebits boundaries. Fix this by reading each channel individually to
>>>> ensure proper alignment.
>>>> Note that this patch drops the earlier optimisation that packs multiple
>>>> channels reading into a single data block transaction when their
>>>> respective I2C register addresses are contiguous.
>>> I wonder how much effect this change has on the read out rate and whether
>>> repacking in software would be significantly quicker than the multiple
>>> transfers...
>> Thinking more on this I'm really not happy with this solution - may well
>> kill data rates on some chips, to deal with this one unaligned case.
>> Gregor, can you give repacking in software a go?
>> Won't be that hard I think...  Be cynical and just memove the data a byte if
>> you hit a 24bit channel.
> I'll give it a try, maybe next week as I'm quite busy right now.
Cool, I've pinged Denis to see if he will have time to review the rest of the
series in the meantime.
>>
>> We could do this in the core demux but then we'd have to do something a bit
>> clever with the reported buffer element type so it looked different to the driver
>> and the buffer.
>>
>> Lars, IIRC you've messed with that corner of the code more recently than me.
>> Do you think doing unaligned data smashing in the demux would be sensible?
>>
>> Can see we'd have to:
>> * expand the 'does the demux have to do anything' case to catch
>> this one (not too hard).
>> * make the demux table builder force size constraints to power of two.
>> * either work out the shift to export to userspace (nasty) or make sure we packed
>>    the data right depending on endianness so there wasn't any change to the shift.
>> All this stuff occurs in the slow patch (table build) - it would look no worse
>> than normal demux (some memcpys) in the fast path.
>>
>> Good idea or not? What do people think.
>>
>> I'm might mock this up in iio_dummy if I get bored and find out how bad it really is...
>>
I didn't get bored enough (or more accurately my laptop battery ran flat before
I got this far and there was no power on the remaining trains that week).
>> Jonathan
>>
>>>> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
>>>> ---
>>>>   drivers/iio/common/st_sensors/st_sensors_buffer.c | 38 ++++++++++-------------
>>>>   drivers/iio/common/st_sensors/st_sensors_core.c   |  2 +-
>>>>   2 files changed, 18 insertions(+), 22 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
>>>> index c558985..a7f1ced 100644
>>>> --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
>>>> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
>>>> @@ -21,33 +21,29 @@
>>>>     #include <linux/iio/common/st_sensors.h>
>>>>   -
>>>>   int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
>>>>   {
>>>> -    int i, len;
>>>> -    int total = 0;
>>>> +    unsigned int cid;
>>>>       struct st_sensor_data *sdata = iio_priv(indio_dev);
>>>> -    unsigned int num_data_channels = sdata->num_data_channels;
>>>> -
>>>> -    for (i = 0; i < num_data_channels; i++) {
>>>> -        unsigned int bytes_to_read;
>>>> -
>>>> -        if (test_bit(i, indio_dev->active_scan_mask)) {
>>>> -            bytes_to_read = indio_dev->channels[i].scan_type.storagebits >> 3;
>>>> -            len = sdata->tf->read_multiple_byte(&sdata->tb,
>>>> -                sdata->dev, indio_dev->channels[i].address,
>>>> -                bytes_to_read,
>>>> -                buf + total, sdata->multiread_bit);
>>>> -
>>>> -            if (len < bytes_to_read)
>>>> -                return -EIO;
>>>>   -            /* Advance the buffer pointer */
>>>> -            total += len;
>>>> -        }
>>>> +    for_each_set_bit(cid, indio_dev->active_scan_mask,
>>>> +             sdata->num_data_channels) {
>>>> +        const struct iio_chan_spec *chan = &indio_dev->channels[cid];
>>>> +        int sb = chan->scan_type.storagebits / 8;
>>>> +        int rb = chan->scan_type.realbits / 8;
>>>> +        int err;
>>>> +
>>>> +        buf = PTR_ALIGN(buf, sb);
>>>> +        err = sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
>>>> +                            chan->address, rb, buf,
>>>> +                            sdata->multiread_bit);
>>>> +        if (err != rb)
>>>> +            return (err < 0) ? err : -EIO;
>>>> +
>>>> +        buf += sb;
>>>>       }
>>>>   -    return total;
>>>> +    return 0;
>>>>   }
>>>>   EXPORT_SYMBOL(st_sensors_get_buffer_element);
>>>>   diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
>>>> index dffe006..6901c7f 100644
>>>> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
>>>> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
>>>> @@ -463,7 +463,7 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
>>>>       int err;
>>>>       u8 *outdata;
>>>>       struct st_sensor_data *sdata = iio_priv(indio_dev);
>>>> -    unsigned int byte_for_channel = ch->scan_type.storagebits >> 3;
>>>> +    unsigned int byte_for_channel = ch->scan_type.realbits >> 3;
>>>>         outdata = kmalloc(byte_for_channel, GFP_KERNEL);
>>>>       if (!outdata)
>>>>
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

