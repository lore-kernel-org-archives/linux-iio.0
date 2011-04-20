Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:59357 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445Ab1DTJZo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 Apr 2011 05:25:44 -0400
Message-ID: <4DAEA711.8040607@cam.ac.uk>
Date: Wed, 20 Apr 2011 10:27:45 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Subject: Re: iio_trigger_poll_chained causes NULL pointer access
References: <544AC56F16B56944AEC3BD4E3D591771375475ED44@LIMKCMBX1.ad.analog.com> <4DADAD72.9070701@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D59177137547D64CA@LIMKCMBX1.ad.analog.com> <544AC56F16B56944AEC3BD4E3D59177137547D656F@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177137547D656F@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/20/11 08:36, Hennerich, Michael wrote:
> Hennerich, Michael wrote on 2011-04-19:
>> Jonathan Cameron wrote on 2011-04-19:
>>> On 04/19/11 16:22, Hennerich, Michael wrote:
>>>> Hi Jonathan,
>>>>
>>>> The AD7606 ring buffer doesn't use the thread, and installs only
>>>> the hard handler.
>>>>
>>>>         indio_dev->pollfunc->h = &ad7606_trigger_handler_th;
>>>>         indio_dev->pollfunc->thread = NULL; This crashes the system
>>>> in handle_nested_irq (null pointer
>>>> action->thread_fn) called from iio_trigger_poll_chained().
>>> I knew that wouldn't work, but didn't realize it wouldn't just fail
>>> with an error...
>>>
>>> The only thing I can think to do is to actually set both h and
>>> thread to ad7606_trigger_handler_th.
>>>
>>> As it returns IRQ_HANDLED, if it is called via irq_trigger_poll, it
>>> will happen in interrupt context and thread will never run.
>>>
>>> If it is called via irq_trigger_poll_handler (e.g. for non interrupt
>>> context) it'll happen outside interrupt context. Given timing is never
>>> going to be that tight for userspace triggers, this probably isn't a
>>> problem.
>>>
>>> Can you try that out and see if it works?
>>
>> I know that setting the thread function will effectively avoid the
>> crash. However I actually haven't traced if it's actually being called
>> once the Hard handler returned IRQ_HANDLED.
>>
>> I'll have try.
> 
> I did some tests, using the sysfs trigger. The top-half handler is never being called.
> That's due to the fact that iio_trigger_poll_chained() calls handle_nested_irq(),
> which will only call the bottom-half thread function.
> 
> I guess there is some fundamental issue here.
There is indeed.  Non interrupt triggers can't currently call the top half.
For that one case, simply registering the top half as both top and bottom half
will work.  For more general cases, we'll need to work out a way of finding out
if the bottom half is being called nested or not...  If it is then it will just
have to first run whatever was in the top half then whatever was in the bottom
half.

The alternative is to play some nasty games to get into interrupt context
from the soft triggers.  I'm not sure it's worth the pain just to avoid adding
a small amount of complexity to those devices with a top half (currently one 
though obviously that will rise!).

Sorry, I should have put a good deal more documentation in about this issue.

Jonathan
