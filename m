Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:49404 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146Ab2FSHRV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jun 2012 03:17:21 -0400
Message-ID: <4FE0277E.40007@cam.ac.uk>
Date: Tue, 19 Jun 2012 08:17:18 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 02/10] iio: Add helper function for initializing triggered
 buffers
References: <1340037236-15685-1-git-send-email-lars@metafoo.de> <1340037236-15685-2-git-send-email-lars@metafoo.de> <20120619002818.GA20240@kroah.com>
In-Reply-To: <20120619002818.GA20240@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/19/2012 1:28 AM, Greg Kroah-Hartman wrote:
> On Mon, Jun 18, 2012 at 06:33:48PM +0200, Lars-Peter Clausen wrote:
>> --- a/drivers/iio/Makefile
>> +++ b/drivers/iio/Makefile
>> @@ -7,6 +7,7 @@ industrialio-y := industrialio-core.o industrialio-event.o inkern.o
>>   industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
>>   industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
>>
>> +obj-$(CONFIG_IIO_TRIGGERED_BUFFER) += industrialio-triggered-buffer.o
>
> That's a crazy module name, does it really need to be that big?  And in
> a separate module?
Probably (for now at least).   I actually asked Lars-Peter to expand it
as the previous version he had wasn't descriptive enough.
>
> Anyway, I've taken it, but why can't this just be merged into the iio.ko
> main module?  Actually, why can't all of these different trigger and
> buffer modules be part of the iio module?
Leads to one rather big module and when quite a few users (including me)
work on boards with very little RAM that can be an issue if they only 
want a simple driver that just requires the core.  32MB in my case.

Having said that, some consolidation may make sense.  We could just make 
kfifo_buf dependent on IIO_TRIGGER.  There are very few drivers 
(possibly none?) that use one without the other, despite that being
a perfectly reasonable option. Any that do could just pay the slight 
cost. That would allow us to merge this into kfifo buf.

Having said that, I'm still interested in a better alternative to 
kfifo_buf for some devices.  I was crossing my fingers the work on
unifying the various tracing buffers would produce something suitable.
Not seen anything on that front for a while though.
>
>>   obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
>
> Shouldn't this be iio_kfifo_buf?
Certainly need to do some work on getting the naming at least consistent 
and indeed a prefix on that does make sense.

>
> thanks,
>
> greg k-h

