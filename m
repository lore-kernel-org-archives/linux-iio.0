Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-144.synserver.de ([212.40.185.144]:1049 "HELO
	smtp-out-142.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1750852Ab2AWJBq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Jan 2012 04:01:46 -0500
Message-ID: <4F1D2232.8090805@metafoo.de>
Date: Mon, 23 Jan 2012 10:02:42 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, pirmin.duss@flytec.ch
Subject: Re: [PATCH 6/6] staging:iio: attrs/event_attrs -> struct attribute
 * + move to iio_dev.
References: <1325931921-14547-1-git-send-email-jic23@kernel.org> <1325931921-14547-7-git-send-email-jic23@kernel.org> <4F0ABDED.2090407@metafoo.de> <4F0F347E.9030505@kernel.org> <4F0F50FF.4060204@kernel.org> <4F1AD566.1040500@kernel.org>
In-Reply-To: <4F1AD566.1040500@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/21/2012 04:10 PM, Jonathan Cameron wrote:
> On 01/12/2012 09:30 PM, Jonathan Cameron wrote:
>> On 01/12/2012 07:29 PM, Jonathan Cameron wrote:
>>> On 01/09/2012 10:14 AM, Lars-Peter Clausen wrote:
>>>> On 01/07/2012 11:25 AM, Jonathan Cameron wrote:
>>>>>
>>>>> diff --git a/drivers/staging/iio/adc/ad7606_core.c
>>>> b/drivers/staging/iio/adc/ad7606_core.c
>>>>> index 97e8d3d..99d91ee 100644
>>>>> --- a/drivers/staging/iio/adc/ad7606_core.c
>>>>> +++ b/drivers/staging/iio/adc/ad7606_core.c
>>>>> @@ -205,30 +205,18 @@ static struct attribute
>>>> *ad7606_attributes_os_and_range[] = {
>>>>>  	NULL,
>>>>>  };
>>>>>
>>>>> -static const struct attribute_group ad7606_attribute_group_os_and_range = {
>>>>> -	.attrs = ad7606_attributes_os_and_range,
>>>>> -};
>>>>> -
>>>>>  static struct attribute *ad7606_attributes_os[] = {
>>>>>  	&iio_dev_attr_oversampling_ratio.dev_attr.attr,
>>>>>  	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
>>>>>  	NULL,
>>>>>  };
>>>>>
>>>>> -static const struct attribute_group ad7606_attribute_group_os = {
>>>>> -	.attrs = ad7606_attributes_os,
>>>>> -};
>>>>> -
>>>>>  static struct attribute *ad7606_attributes_range[] = {
>>>>>  	&iio_dev_attr_in_voltage_range.dev_attr.attr,
>>>>>  	&iio_const_attr_in_voltage_range_available.dev_attr.attr,
>>>>>  	NULL,
>>>>>  };
>>>>>
>>>>> -static const struct attribute_group ad7606_attribute_group_range = {
>>>>> -	.attrs = ad7606_attributes_range,
>>>>> -};
>>>>> -
>>>>>  #define AD7606_CHANNEL(num)				\
>>>>>  	{						\
>>>>>  		.type = IIO_VOLTAGE,			\
>>>>> @@ -429,27 +417,9 @@ static irqreturn_t ad7606_interrupt(int irq, void
>>>> *dev_id)
>>>>>  	return IRQ_HANDLED;
>>>>>  };
>>>>>
>>>>> -static const struct iio_info ad7606_info_no_os_or_range = {
>>>>> -	.driver_module = THIS_MODULE,
>>>>> -	.read_raw = &ad7606_read_raw,
>>>>> -};
>>>>> -
>>>>> -static const struct iio_info ad7606_info_os_and_range = {
>>>>> -	.driver_module = THIS_MODULE,
>>>>> -	.read_raw = &ad7606_read_raw,
>>>>> -	.attrs = &ad7606_attribute_group_os_and_range,
>>>>> -};
>>>>> -
>>>>> -static const struct iio_info ad7606_info_os = {
>>>>> +static const struct iio_info ad7606_info = {
>>>>>  	.driver_module = THIS_MODULE,
>>>>>  	.read_raw = &ad7606_read_raw,
>>>>> -	.attrs = &ad7606_attribute_group_os,
>>>>> -};
>>>>> -
>>>>> -static const struct iio_info ad7606_info_range = {
>>>>> -	.driver_module = THIS_MODULE,
>>>>> -	.read_raw = &ad7606_read_raw,
>>>>> -	.attrs = &ad7606_attribute_group_range,
>>>>>  };
>>>>>
>>>>>  struct iio_dev *ad7606_probe(struct device *dev, int irq,
>>>>> @@ -494,19 +464,16 @@ struct iio_dev *ad7606_probe(struct device *dev, int
>>>> irq,
>>>>>  	st->chip_info = &ad7606_chip_info_tbl[id];
>>>>>
>>>>>  	indio_dev->dev.parent = dev;
>>>>> +	indio_dev->info = &ad7606_info;
>>>>>  	if (gpio_is_valid(st->pdata->gpio_os0) &&
>>>>>  	    gpio_is_valid(st->pdata->gpio_os1) &&
>>>>>  	    gpio_is_valid(st->pdata->gpio_os2)) {
>>>>>  		if (gpio_is_valid(st->pdata->gpio_range))
>>>>> -			indio_dev->info = &ad7606_info_os_and_range;
>>>>> +			indio_dev->attrs = ad7606_attributes_os_and_range;
>>>>>  		else
>>>>> -			indio_dev->info = &ad7606_info_os;
>>>>> -	} else {
>>>>> -		if (gpio_is_valid(st->pdata->gpio_range))
>>>>> -			indio_dev->info = &ad7606_info_range;
>>>>> -		else
>>>>> -			indio_dev->info = &ad7606_info_no_os_or_range;
>>>>> -	}
>>>>> +			indio_dev->attrs = ad7606_attributes_os;
>>>>> +	} else if (gpio_is_valid(st->pdata->gpio_range))
>>>>> +			indio_dev->attrs = ad7606_attributes_range;
>>>>>  	indio_dev->modes = INDIO_DIRECT_MODE;
>>>>>  	indio_dev->name = st->chip_info->name;
>>>>>  	indio_dev->channels = st->chip_info->channels;
>>>>
>>>> This makes me wonder if we not better add a function which can add a single
>>>> attribute to the attribute list at runtime. Or maybe just use
>>>> device_create_file directly.
>>> Device create file is out I think. It can only be applied after a the
>>> group has been created (so after the iio registration is done)  The
>>> whole issue is that udev doesn't get notified of such creations.  That's
>>> why we jumped through these hoops in the first place.
>>> (I've never entirely understood why this is the case, but Kay and
>>> Greg both assured me it was the case - only reliable option is to
>>> add all files on device registration as here.)  Yes, lots of the
>>> kernel doesn't do that, but they were strongly in favour of it for
>>> any new code.
>>>
>>> We could add our own function, but personally I'm against it.  In the
>>> vast majority of cases it is irrelevant and we have this approach for
>>> those where it might be a small clean up.  If these get more common
>>> then I'll come around to such a function with the slight additional
>>> complexity it would need.
>>>
>>> So in my view a question for another day!
>> Note this series no longer applies due to a series changing return type
>> of is_visible.  Obviously we just delete the new versions though so
>> I'm not going to repost for that!
> Lars-Peter, are you convinced by my argument that whilst what you
> suggest (a means of adding individual attributes at run time) may make
> sense in the long run it is not a good idea to do it now?
> 
> What I'm really fishing for is whether you are willing to ack what we
> have in this set?
> :)

I think considering all this, the series is fine without the last patch.
While it improves the situation for a few drivers it gets worse for the
other ones. So I think we are better of with the previous version which only
moves the attribute_group to a attribute list.

Patch 1-5:
Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks
- Lars
