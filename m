Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:53972 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881Ab3I0DHH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2013 23:07:07 -0400
Received: by mail-ob0-f178.google.com with SMTP id uy5so2805328obc.37
        for <linux-iio@vger.kernel.org>; Thu, 26 Sep 2013 20:07:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5244998F.4090905@metafoo.de>
References: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
	<1380106208-6948-2-git-send-email-sachin.kamat@linaro.org>
	<5244998F.4090905@metafoo.de>
Date: Fri, 27 Sep 2013 08:37:05 +0530
Message-ID: <CAK9yfHySWMO-Ax0Zqwa5RxGNDTTuEEdL68yL-0OuEWYDMa1hdg@mail.gmail.com>
Subject: Re: [PATCH 01/32] iio: core: Implement devm_iio_device_{register,unregister}
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27 September 2013 02:01, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 09/25/2013 12:49 PM, Sachin Kamat wrote:
>> Add device managed devm_iio_device_{register,unregister}()
>> to automatically unregister IIO drivers thus leading to
>> simplified IIO driver code.
>>
>
> I have the same fears as Jonathan that this is going to be used incorrectly
> for drivers where the remove function is not empty. But hopefully the
> benefits outweigh the dangers. So I think we should add this functionality.
> But the implementation looks broken. Also few nitpicks on style issue inline
> below. Otherwise looks good.

Thank you for your review and feedback.

>
>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>> +int devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev)
>> +{
>> +     void *ptr;
>> +     int iio_dev;
>
> ret is probably a better name.

OK.

>
>> +
>> +     ptr = devres_alloc(devm_iio_device_unreg, 0, GFP_KERNEL);
>
> So we allocate memory with the size of 0. And then never actually pass the
> IIO device itself to the devres managed resource, but de-reference the
> pointer in devm_iio_device_unreg assuming it points is a iio_dev struct
> pointer. This doesn't seem right.

I was a bit unsure about the way this should be handled as
iio_device_register returned an int
and not struct iio_dev.

 I think it needs to be something like this:

Thanks for providing the right way of handling. Will incorporate these changes.

>
> struct iio_dev **ptr;
>
> ptr = devres_alloc(devm_iio_device_unreg, sizeof(*ptr), GFP_KERNEL);
>
> ...
>
> *ptr = indio_dev;
>
>> +     if (!ptr)
>> +             return -ENOMEM;
>> +
>> +     iio_dev = iio_device_register(indio_dev);
>> +     if (!iio_dev)
>> +             devres_add(dev, ptr);
>> +     else
>> +             devres_free(ptr);
>> +
>> +     return iio_dev;
>> +}
>> +EXPORT_SYMBOL_GPL(devm_iio_device_register);
>> +
>> +void devm_iio_device_unregister(struct device *dev, struct iio_dev *iio_dev)
>
> The last parameter should be named indio_dev.

OK. Just for my info, what is the convention about choosing indio_dev
and iio_dev?

>
>> +{
>> +     int rc;
>> +
>> +     rc = devres_release(dev, devm_iio_device_unreg,
>> +                         devm_iio_device_match, iio_dev);
>> +     WARN_ON(rc);
>> +}
>> +EXPORT_SYMBOL_GPL(devm_iio_device_unregister);
>> +
>>  subsys_initcall(iio_init);
>>  module_exit(iio_exit);
>>
>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>> index ac1cb8f..be16dd6 100644
>> --- a/include/linux/iio/iio.h
>> +++ b/include/linux/iio/iio.h
>> @@ -453,6 +453,31 @@ int iio_device_register(struct iio_dev *indio_dev);
>>  void iio_device_unregister(struct iio_dev *indio_dev);
>>
>>  /**
>> + * devm_iio_device_register - Resource-managed iio_device_register()
>> + * @dev:     Device to allocate iio_dev for
>> + * @indio_dev:       Device structure filled by the device driver
>> + *
>> + * Managed iio_device_register.  iio_dev registered with this function is
>
> The IIO device registered ...
>
> I would also add that this function calls iio_device_register() internally
> and to look at that function for more information.

OK. I will update.

>
>> + * automatically unregistered on driver detach.
>> + *
>> + * If an iio_dev registered with this function needs to be unregistered
>> + * separately, devm_iio_device_unregister() must be used.
>> + *
>> + * RETURNS:
>> + * 0 on success, negative error number on failure.
>> + */
>
> The kernel doc should be placed above the implementation, not the
> definition. And yes we got that wrong on quite a few functions.

Yes that is correct. I just followed the existing convention in the file.
I will first create a patch to move the existing kernel doc to the .c
file and then update accordingly
for my implementation.

-- 
With warm regards,
Sachin
