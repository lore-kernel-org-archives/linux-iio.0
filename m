Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:41246 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216Ab2DYPAj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Apr 2012 11:00:39 -0400
Message-ID: <4F981194.2060903@cam.ac.uk>
Date: Wed, 25 Apr 2012 16:00:36 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 09/14] staging:iio:buffers switch select kconfig elements
 to depends.
References: <1335096819-19565-1-git-send-email-jic23@kernel.org> <1335096819-19565-10-git-send-email-jic23@kernel.org> <4F97BDAB.9050506@metafoo.de>
In-Reply-To: <4F97BDAB.9050506@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 4/25/2012 10:02 AM, Lars-Peter Clausen wrote:
> On 04/22/2012 02:13 PM, Jonathan Cameron wrote:
>> As we are moving the IIO core out of staging, we need to
>> stop drivers in staging controlling whether elements of the
>> core are built.
>>
>> Signed-off-by: Jonathan Cameron<jic23@kernel.org>
>> ---
>>   drivers/staging/iio/Kconfig |    4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
>> index fe15867..e644508 100644
>> --- a/drivers/staging/iio/Kconfig
>> +++ b/drivers/staging/iio/Kconfig
>> @@ -28,7 +28,7 @@ config IIO_BUFFER
>>   if IIO_BUFFER
>>
>>   config IIO_SW_RING
>> -       select IIO_TRIGGER
>> +        depends on IIO_TRIGGER
>>   	tristate "Industrial I/O lock free software ring"
>>   	help
>>   	  Example software ring buffer implementation.  The design aim
>> @@ -37,7 +37,7 @@ config IIO_SW_RING
>>   	  in interrupt context.
>>
>>   config IIO_KFIFO_BUF
>> -	select IIO_TRIGGER
>> +	depends on IIO_TRIGGER
>>   	tristate "Industrial I/O buffering based on kfifo"
>>   	help
>>   	  A simple fifo based on kfifo.  Use this if you want a fifo
>
> Is there actually anything in the code which gets enabled by these config
> symbols that depends on IIO_TRIGGER?
Not that I can think of..  Would imagine they snuck in to prevent a 
build error at somepoint.
Took the view we can fix this up later as I've dropped all these patches.
>
> - Lars
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

