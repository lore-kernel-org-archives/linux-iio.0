Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34879 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbcJAOSJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Oct 2016 10:18:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id f193so2834004wmg.2
        for <linux-iio@vger.kernel.org>; Sat, 01 Oct 2016 07:18:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <45809aef-5396-90fa-1312-677eaeec36da@kernel.org>
References: <1475093161-7239-1-git-send-email-lorenzo.bianconi@st.com> <45809aef-5396-90fa-1312-677eaeec36da@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Sat, 1 Oct 2016 16:18:05 +0200
Message-ID: <CAA2SeNKCr3+rWJd2_Laa0UriPs0FUUWzy6c-s7-smFRSJEk0vQ@mail.gmail.com>
Subject: Re: [PATCH] iio: common: st_sensors: fix channel data parsing
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
        Lorenzo BIANCONI <lorenzo.bianconi@st.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Gregor Boirie <gregor.boirie@parrot.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> On 28/09/16 21:06, Lorenzo Bianconi wrote:
>> Using realbits as i2c/spi read len, when that value is not byte aligned
>> (e.g 12 bits), lead to skip msb part of out data registers.
>> Fix this using storagebits as read length
>>
>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> Hi Lorenzo,

Hi Jonathan,

>
> This would ideally have had a fixes tag.
>
> I think it was
> Fixes: e7385de5 ("iio:st_sensors: align on storagebits boundaries")
> Doing that would also have lead to you to the logic that lead to
> this buggy change in the first place. Would also have shown
> you that there is another place that probably suffers from the
> same sort of issue.
>

Right. I missed the same issue in st_sensors_read_axis_data()

> Gregor can you take a look at this please.
>
> If I recall the issue that lead to the original patch it was
> that we were miss handling 24 bit values on pressure sensors and
> this was intended to pad them?
>
> I think the 'right' fix will be something along the lines of:
> unsigned int bytes_to_read = (channel->scan_type.realbits + 7) >> 3;
>

This should not be correct if you consider 8bit accel like LIS331DL.
Taking a look to lps22hb code I think storagebits should be 24 and not
32 for pressure channel. What do you think?

> Should give 2 bytes for a 12 bit and still the 3 bytes needed for a
> 24 bit read.
>
> Thanks,
>

Thanks,
Lorenzo

> Jonathan
>> ---
>>  drivers/iio/common/st_sensors/st_sensors_buffer.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
>> index fe7775b..d01aa34 100644
>> --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
>> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
>> @@ -30,16 +30,15 @@ static int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
>>
>>       for_each_set_bit(i, indio_dev->active_scan_mask, num_data_channels) {q
>>               const struct iio_chan_spec *channel = &indio_dev->channels[i];
>> -             unsigned int bytes_to_read = channel->scan_type.realbits >> 3;
>>               unsigned int storage_bytes =
>>                       channel->scan_type.storagebits >> 3;
>>
>>               buf = PTR_ALIGN(buf, storage_bytes);
>>               if (sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
>>                                                 channel->address,
>> -                                               bytes_to_read, buf,
>> +                                               storage_bytes, buf,
>>                                                 sdata->multiread_bit) <
>> -                 bytes_to_read)
>> +                 storage_bytes)
>>                       return -EIO;
>>
>>               /* Advance the buffer pointer */
>>
>



-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
