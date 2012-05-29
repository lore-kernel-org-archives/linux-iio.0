Return-Path: <lars@metafoo.de>
Message-ID: <4FC47DAF.5040506@metafoo.de>
Date: Tue, 29 May 2012 09:41:35 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: Add iio_device_get()
References: <1337588514-23938-1-git-send-email-lars@metafoo.de> <4FBFB365.2020209@metafoo.de> <4FC28A49.1060205@kernel.org>
In-Reply-To: <4FC28A49.1060205@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/27/2012 10:10 PM, Jonathan Cameron wrote:
> On 05/25/2012 05:29 PM, Lars-Peter Clausen wrote:
>> On 05/21/2012 10:21 AM, Lars-Peter Clausen wrote:
>>> This patch add the iio_device_get() function, which increases the reference
>>> count of a iio device. The matching function to decrease the reference count -
>>> iio_device_put() - already exists.
>>>
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>
>> Hi Jonathan,
>>
>> Are you OK with these two patches?
> Sorry, was a somewhat mad week..
> 
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> for both of them.

Thanks. Btw. these touch only out-of-staging IIO code. Now that the
out-of-staging code is in mainline, what's the plan for the patch flow? Are
you going to collect the patches and send them to Linus or should they still
go through the staging tree?

- Lars

>>
>> Thanks,
>> - Lars
>>
>>> ---
>>>  include/linux/iio/iio.h |   11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>
>>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>>> index 3a4f6a3..3238fa3 100644
>>> --- a/include/linux/iio/iio.h
>>> +++ b/include/linux/iio/iio.h
>>> @@ -438,6 +438,17 @@ static inline struct iio_dev *dev_to_iio_dev(struct device *dev)
>>>  	return container_of(dev, struct iio_dev, dev);
>>>  }
>>>  
>>> +/**
>>> + * iio_device_get() - increment reference count for the device
>>> + * @indio_dev: IIO device structure
>>> + *
>>> + * Returns: The passed IIO device
>>> + **/
>>> +static inline struct iio_dev *iio_device_get(struct iio_dev *indio_dev)
>>> +{
>>> +	return indio_dev ? dev_to_iio_dev(get_device(&indio_dev->dev)) : NULL;
>>> +}
>>> +
>>>  /* Can we make this smaller? */
>>>  #define IIO_ALIGN L1_CACHE_BYTES
>>>  /**
>>
> 
