Return-Path: <SRS0=oaKA=NN=gmail.com=songqiang1304521@kernel.org>
Subject: Re: [PATCH v4 3/3] iio: magnetometer: Add driver support for PNI
 RM3100
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
 mark.rutland@arm.com, preid@electromag.com.au, himanshujha199640@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20181002143812.3661-1-songqiang1304521@gmail.com>
 <20181012073536.20339-1-songqiang1304521@gmail.com>
 <20181012073536.20339-4-songqiang1304521@gmail.com>
 <20181013111935.00a2e1af@archlinux>
 <e1715942-8fd8-152f-49c8-2a9e081d8a2a@gmail.com>
 <20181021151427.5b3dbb9b@archlinux>
From: Song Qiang <songqiang1304521@gmail.com>
Message-ID: <b7078a05-c40b-eba5-73f6-d5e3940d88f2@gmail.com>
Date: Fri, 2 Nov 2018 15:55:27 +0800
MIME-Version: 1.0
In-Reply-To: <20181021151427.5b3dbb9b@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>


On 2018/10/21 下午10:14, Jonathan Cameron wrote:
> On Thu, 18 Oct 2018 16:24:15 +0800
> Song Qiang <songqiang1304521@gmail.com> wrote:
>
> ...
>>>> +static irqreturn_t rm3100_trigger_handler(int irq, void *p)
>>>> +{
>>>> +	struct iio_poll_func *pf = p;
>>>> +	struct iio_dev *indio_dev = pf->indio_dev;
>>>> +	unsigned long scan_mask = *indio_dev->active_scan_mask;
>>>> +	unsigned int mask_len = indio_dev->masklength;
>>>> +	struct rm3100_data *data = iio_priv(indio_dev);
>>>> +	struct regmap *regmap = data->regmap;
>>>> +	int ret, i, bit;
>>>> +
>>>> +	mutex_lock(&data->lock);
>>>> +	switch (scan_mask) {
>>>> +	case BIT(0) | BIT(1) | BIT(2):
>>>> +		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 9);
>>>> +		mutex_unlock(&data->lock);
>>>> +		if (ret < 0)
>>>> +			goto done;
>>>> +	break;
>>>> +	case BIT(0) | BIT(1):
>>>> +		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 6);
>>>> +		mutex_unlock(&data->lock);
>>>> +		if (ret < 0)
>>>> +			goto done;
>>>> +	break;
>>>> +	case BIT(1) | BIT(2):
>>>> +		ret = regmap_bulk_read(regmap, RM3100_REG_MY2, data->buffer, 6);
>>>> +		mutex_unlock(&data->lock);
>>>> +		if (ret < 0)
>>>> +			goto done;
>>>> +	break;
>>> What about BIT(0) | BIT(2)?
>>>
>>> Now you can do it like you have here and on that one corner case let the iio core
>>> demux code take care of it, but then you will need to provide available_scan_masks
>>> so the core knows it needs to handle this case.
>>>   
>> This confused me a little. The available_scan_masks I was using is {BIT(0) |
>> BIT(1) | BIT(2), 0x0}. Apparently in this version of patch I would like it to
>> handle every circumstances like BIT(0), BIT(0) | BIT(2), BIT(1) | BIT(2), etc.
>> Since Phil mentioned he would like this to reduce bus usage as much as we can
>> and I want it, too, I think these three circumstances can be read consecutively
>> while others can be read one axis at a time. So I plan to let  BIT(0) | BIT(2)
>> fall into the 'default' section, which reads axis one by one.
>>
>> My question is, since this handles every possible combination, do I still need
>> to list every available scan masks in available_scan_masks?
> Ah. I see, I'd missed that the default was picking up that case as well as the
> single axes.   It would be interesting to sanity check if it is quicker on
> a 'typical' platform to do the all axis read for the BIT(0) | BIT(2) case
> and drop the middle value (which would be done using available scan_masks)
> or to just do two independent reads.
>
> (I would guess it is worth reading the 'dead' axis).
>
>>
>> All other problems will be fixed in the next patch.
>>
>> yours,
>>
>> Song Qiang
>>
>>
>> ...
> Thanks,
>
> Jonathan

I tested this two ways of getting data with the following code snippet:


     u8 buffer[9];
     struct timeval timebefore, timeafter;

     do_gettimeofday(&timebefore);
     ret = regmap_bulk_read(regmap, RM3100_REG_MX2, buffer, 9);
     if (ret < 0)
         goto unlock_return;
     do_gettimeofday(&timeafter);
     printk(KERN_INFO "read with dead axis time: %ld",
            timeafter.tv_sec * 1000000 + timeafter.tv_usec -
            timebefore.tv_sec * 1000000 - timebefore.tv_usec);
     do_gettimeofday(&timebefore);

     ret = regmap_bulk_read(regmap, RM3100_REG_MX2, buffer, 3);
     if (ret < 0)
         goto unlock_return;
     ret = regmap_bulk_read(regmap, RM3100_REG_MZ2, buffer + 6, 3);
     if (ret < 0)
         goto unlock_return;
     do_gettimeofday(&timeafter);
     printk(KERN_INFO "read two single axis time: %ld",
            timeafter.tv_sec * 1000000 + timeafter.tv_usec -
            timebefore.tv_sec * 1000000 - timebefore.tv_usec);


And get this result:

[  161.264777] read with dead axis time: 883
[  161.270621] read two single axis time: 1359
[  161.575134] read with dead axis time: 852
[  161.580973] read two single axis time: 1356
[  161.895704] read with dead axis time: 854
[  161.903744] read two single axis time: 3540
[  162.223600] read with dead axis time: 853
[  162.229451] read two single axis time: 1363
[  162.591227] read with dead axis time: 850
[  162.597630] read two single axis time: 1555
[  162.920102] read with dead axis time: 852
[  162.926467] read two single axis time: 1534
[  163.303121] read with dead axis time: 881
[  163.308997] read two single axis time: 1390
[  163.711004] read with dead axis time: 861


It seems like you're right! Reading consecutively 9 bytes does save a lot time 
compared to read 3 bytes twice.
