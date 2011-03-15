Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:38681 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932216Ab1COPtH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Mar 2011 11:49:07 -0400
Message-ID: <4D7F8AB1.3080705@cam.ac.uk>
Date: Tue, 15 Mar 2011 15:50:09 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Moving staging:iio over to threaded interrupts.
References: <4D6FCC99.6090202@cam.ac.uk> <alpine.LFD.2.00.1103081055160.2787@localhost6.localdomain6> <4D76119A.2030100@cam.ac.uk> <alpine.LFD.2.00.1103081304470.2787@localhost6.localdomain6> <4D762065.7030009@cam.ac.uk>
In-Reply-To: <4D762065.7030009@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/08/11 12:26, Jonathan Cameron wrote:
> On 03/08/11 12:12, Thomas Gleixner wrote:
>> On Tue, 8 Mar 2011, Jonathan Cameron wrote:
>>> On 03/08/11 10:30, Thomas Gleixner wrote:
>>>> So now you can request the interrupts for your subdevices with
>>>> request_irq or request_threaded_irq.
>>>>
>>>> You can also implement #1 this way, you just mark the sub device
>>>> interrupts as IRQ_NESTED_THREAD, and then call the handlers from the
>>>> main trigger irq thread.
>>> Hi Thomas,
>>>
>>> One issue here that I'm not quite sure how to overcome is that the trigger to
>>> device mapping tends to be dynamic.  That is we quite often switch around
>>> what device is triggered by which trigger at runtime.  All done via text label
>>> matching via sysfs.
>>
>> Was not aware of that.
>>  
>>> I guess we could maintain this by a spot of indirection and pool of interrupts per
>>> trigger (with compile time control on how many). Any other approaches come to mind?
>>
>> That should work. You just need a function in the trigger
>> implementation which hands back an unused irq number to the device
>> when a trigger is installed for a device. Then the device calls
>> request[_threaded]_irq() on that irq number and all should work
>> magically.
>>
> Cool.  Actually thinking more on this we probably want to have a single pool for IIO
> in general that then allocates sets to the individual drivers.  That way things
> like dynamic trigger creation (which is needed for the bridge to the input subsystem
> but not currently implemented) become possible.
> 
Hi Thomas,

One question that I gather comes up from time to time but google isn't furnishing me
with an answer. I'd imagine it something to do with having to know where interrupts should
go early in boot, but best ask anyway.

I'm getting undefined errors for irq_to_desc, set_irq_chip_and_handler, handle_simple_irq
and set_irq_flags.

Why are irq_to_desc etc not usable from a module? I really would rather avoid building
the core of IIO in. I suppose I could move this corner out on it's own so that it alone
is built in.

I'm guessing the approach I have right now were my trigger allocate function (which can easily
be called from a module) creates and connects up the irq_chip on demand is a very bad idea?

Is the right way to do this to handle all my 'virtual' interrupts as a single chip in some built
in function then make their handler play some games underneath?

Thanks again for your help.

Too many years of just assuming this underlying interrupt stuff worked ;)

Jonathan
