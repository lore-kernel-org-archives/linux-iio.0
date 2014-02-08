Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:57964 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868AbaBHAHZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 7 Feb 2014 19:07:25 -0500
Received: from [192.168.0.80] ([178.8.245.194]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0M0yaB-1VMZwx0Wsx-00v73w for
 <linux-iio@vger.kernel.org>; Sat, 08 Feb 2014 01:07:24 +0100
Message-ID: <52F57539.7070903@gmx.de>
Date: Sat, 08 Feb 2014 01:07:21 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC]iio:industrialio-event fix error-handling in iio_device_add_event
References: <52C00D75.70302@gmx.de> <52C40E53.1040906@kernel.org>
In-Reply-To: <52C40E53.1040906@kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron schrieb:
> On 29/12/13 11:54, Hartmut Knaack wrote:
>> __iio_add_chan_devattr returns -EBUSY, when registering the event-interface of
>> ad799x, but iio_device_add_event does not catch it. So, handle it like in
>> iio_device_add_info_mask_type. Not sure, if this is the right solution, but it
>> makes the ad799x (and possibly others as well) usable.
>>
>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> I think the fix is correct, but I'm not entirely sure what is triggering 
> the bug in this particular driver. All of the elements of ad799x_events 
> are in mask separate so shared_by should be IIO_SEPARATE for all calls 
> to this function.
>
> Lars, any idea's on what Hartmut is hitting?
> Also, is the below patch as valid as it appears at first glance?
I've been digging a bit more into the event interface registration, and it turned out that the problem is a typo in the ad799x driver. A patch is on the way.
While debugging, I always encountered crashes of my machine, about 15 seconds after the device-initialization failed. You can find a short video of the screen capture at [1]. This was taken on a Linux 3.13.1 (with slight changes to ad799x_core.c for working without platform_data and fix the irq-issue). Any ideas, where to start looking for that problems?
Besides, I'm a bit confused with all the branches of the iio.git repo. Which one shall be used, when developing for the iio subsystem (that contains all the patches you accepted)?

[1] http://www.upitus.net/36zhlrijl9lh
>> ---
>> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
>> index c10eab6..d37a907 100644
>> --- a/drivers/iio/industrialio-event.c
>> +++ b/drivers/iio/industrialio-event.c
>> @@ -362,7 +362,9 @@ static int iio_device_add_event(struct iio_dev *indio_dev,
>>   			&indio_dev->event_interface->dev_attr_list);
>>   		kfree(postfix);
>>
>> -		if (ret)
>> +		if ((ret == -EBUSY) && (shared_by != IIO_SEPARATE))
>> +			continue;
>> +		else if (ret < 0)
>>   			return ret;
>>
>>   		attrcount++;
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

