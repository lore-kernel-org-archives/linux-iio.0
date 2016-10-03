Return-Path: <gregor.boirie@parrot.com>
Message-ID: <57F22A77.6090706@parrot.com>
Date: Mon, 3 Oct 2016 11:52:55 +0200
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, Lorenzo Bianconi
	<lorenzo.bianconi83@gmail.com>
CC: <linux-iio@vger.kernel.org>, Lorenzo BIANCONI <lorenzo.bianconi@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH] iio: common: st_sensors: fix channel data parsing
References: <1475093161-7239-1-git-send-email-lorenzo.bianconi@st.com> <45809aef-5396-90fa-1312-677eaeec36da@kernel.org> <CAA2SeNKCr3+rWJd2_Laa0UriPs0FUUWzy6c-s7-smFRSJEk0vQ@mail.gmail.com> <8b3ae000-43fc-9624-acc6-8416ef22fb5f@kernel.org>
In-Reply-To: <8b3ae000-43fc-9624-acc6-8416ef22fb5f@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Sorry for the delay (vacations). Answers inline...


On 10/01/2016 04:58 PM, Jonathan Cameron wrote:
> On 01/10/16 15:18, Lorenzo Bianconi wrote:
>>> On 28/09/16 21:06, Lorenzo Bianconi wrote:
>>>> Using realbits as i2c/spi read len, when that value is not byte aligned
>>>> (e.g 12 bits), lead to skip msb part of out data registers.
>>>> Fix this using storagebits as read length
>>>>
>>>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
>>> Hi Lorenzo,
>> Hi Jonathan,
>>
>>> This would ideally have had a fixes tag.
>>>
>>> I think it was
>>> Fixes: e7385de5 ("iio:st_sensors: align on storagebits boundaries")
>>> Doing that would also have lead to you to the logic that lead to
>>> this buggy change in the first place. Would also have shown
>>> you that there is another place that probably suffers from the
>>> same sort of issue.
>>>
>> Right. I missed the same issue in st_sensors_read_axis_data()
>>
>>> Gregor can you take a look at this please.
>>>
>>> If I recall the issue that lead to the original patch it was
>>> that we were miss handling 24 bit values on pressure sensors and
>>> this was intended to pad them?
>>>
>>> I think the 'right' fix will be something along the lines of:
>>> unsigned int bytes_to_read = (channel->scan_type.realbits + 7) >> 3;
>>>
>> This should not be correct if you consider 8bit accel like LIS331DL.
> 8 + 7 = 15
> 15 >> 3 = 1 byte.
>
> Would get interest if the data was shifted to run across two bytes, but
> it's not.  Could handle that case as well by doing
> (channel->scan_type.realbits + channel->scan_type.shift + 7) >> 3
Agreed.Maybe using DIV_ROUND_UP() would make ita bit clearer ? Something
like :
DIV_ROUND_UP(channel->scan_type.realbits + channel->scan_type.shift, 8)

Should alsobe applied to st_sensors_get_buffer_element() and
st_sensors_read_axis_data() functions as told earlier.


>> Taking a look to lps22hb code I think storagebits should be 24 and not
>> 32 for pressure channel. What do you think?
> No. Storage bytes must always be a power of 2. It's assumed at various
> points in the buffer handling code in the core and userspace code.
> This is why Gregor's fix was needed.
That was it.

I'll be happy to perform some testing with my setup (LPS22HB).

Regards,
Grégor.

>
> These 24 bit packed readings are a pain, but it was much worse to try
> and remove the aligned data assumptions that need them to be powers
> of 2.  Just think about 3 bytes floating in a little endian integer
> field vs the big endian version. It's a real pain to unwind.
>>> Should give 2 bytes for a 12 bit and still the 3 bytes needed for a
>>> 24 bit read.
>>>
>>> Thanks,
>>>
>> Thanks,
>> Lorenzo
>>
>>> Jonathan
>>>> ---
>>>>   drivers/iio/common/st_sensors/st_sensors_buffer.c | 5 ++---
>>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
>>>> index fe7775b..d01aa34 100644
>>>> --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
>>>> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
>>>> @@ -30,16 +30,15 @@ static int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
>>>>
>>>>        for_each_set_bit(i, indio_dev->active_scan_mask, num_data_channels) {q
>>>>                const struct iio_chan_spec *channel = &indio_dev->channels[i];
>>>> -             unsigned int bytes_to_read = channel->scan_type.realbits >> 3;
>>>>                unsigned int storage_bytes =
>>>>                        channel->scan_type.storagebits >> 3;
>>>>
>>>>                buf = PTR_ALIGN(buf, storage_bytes);
>>>>                if (sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
>>>>                                                  channel->address,
>>>> -                                               bytes_to_read, buf,
>>>> +                                               storage_bytes, buf,
>>>>                                                  sdata->multiread_bit) <
>>>> -                 bytes_to_read)
>>>> +                 storage_bytes)
>>>>                        return -EIO;
>>>>
>>>>                /* Advance the buffer pointer */
>>>>
>>
>>
