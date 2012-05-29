Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:43203 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868Ab2E2HpA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 May 2012 03:45:00 -0400
Message-ID: <4FC47E79.60505@cam.ac.uk>
Date: Tue, 29 May 2012 08:44:57 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: Add iio_device_get()
References: <1337588514-23938-1-git-send-email-lars@metafoo.de> <4FBFB365.2020209@metafoo.de> <4FC28A49.1060205@kernel.org> <4FC47DAF.5040506@metafoo.de>
In-Reply-To: <4FC47DAF.5040506@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/29/2012 8:41 AM, Lars-Peter Clausen wrote:
> On 05/27/2012 10:10 PM, Jonathan Cameron wrote:
>> On 05/25/2012 05:29 PM, Lars-Peter Clausen wrote:
>>> On 05/21/2012 10:21 AM, Lars-Peter Clausen wrote:
>>>> This patch add the iio_device_get() function, which increases the reference
>>>> count of a iio device. The matching function to decrease the reference count -
>>>> iio_device_put() - already exists.
>>>>
>>>> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
>>>
>>> Hi Jonathan,
>>>
>>> Are you OK with these two patches?
>> Sorry, was a somewhat mad week..
>>
>> Acked-by: Jonathan Cameron<jic23@kernel.org>
>> for both of them.
>
> Thanks. Btw. these touch only out-of-staging IIO code. Now that the
> out-of-staging code is in mainline, what's the plan for the patch flow? Are
> you going to collect the patches and send them to Linus or should they still
> go through the staging tree?
Greg has kindly agreed to continue handling patches during this period 
(I'll start building up to take over in the longer run).
I'm not actually sure how he will want to split stuff as obviously a lot
of patches, not including this one, will touch both the stuff in staging 
and the stuff that isn't...

For now send patches to Greg and see what he does with them I guess!
Make it clear in the cover letter what they effect though.

Jonathan

>
> - Lars
>
>>>
>>> Thanks,
>>> - Lars
>>>
>>>> ---
>>>>   include/linux/iio/iio.h |   11 +++++++++++
>>>>   1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>>>> index 3a4f6a3..3238fa3 100644
>>>> --- a/include/linux/iio/iio.h
>>>> +++ b/include/linux/iio/iio.h
>>>> @@ -438,6 +438,17 @@ static inline struct iio_dev *dev_to_iio_dev(struct device *dev)
>>>>   	return container_of(dev, struct iio_dev, dev);
>>>>   }
>>>>
>>>> +/**
>>>> + * iio_device_get() - increment reference count for the device
>>>> + * @indio_dev: IIO device structure
>>>> + *
>>>> + * Returns: The passed IIO device
>>>> + **/
>>>> +static inline struct iio_dev *iio_device_get(struct iio_dev *indio_dev)
>>>> +{
>>>> +	return indio_dev ? dev_to_iio_dev(get_device(&indio_dev->dev)) : NULL;
>>>> +}
>>>> +
>>>>   /* Can we make this smaller? */
>>>>   #define IIO_ALIGN L1_CACHE_BYTES
>>>>   /**
>>>
>>
>

