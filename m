Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38659 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846AbbJaKkB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 31 Oct 2015 06:40:01 -0400
Subject: Re: [Outreachy kernel] [PATCH] staging: iio: dummy: complete IIO
 events delivery to userspace
To: Greg KH <greg@kroah.com>, Ioana Ciornei <ciorneiioana@gmail.com>
References: <1445971256-22474-1-git-send-email-ciorneiioana@gmail.com>
 <20151028224722.GA31531@kroah.com>
 <CAHWJYFmK1tLUW1EA=dDyGLqiqukOz_4CfL4AMuUdycQ0feTxzA@mail.gmail.com>
 <20151028230709.GA28617@kroah.com>
Cc: linux-iio@vger.kernel.org,
	outreachy-kernel <outreachy-kernel@googlegroups.com>,
	Cristina Georgiana Opriceana <cristina.opriceana@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56349A7C.7070907@kernel.org>
Date: Sat, 31 Oct 2015 10:39:56 +0000
MIME-Version: 1.0
In-Reply-To: <20151028230709.GA28617@kroah.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/10/15 23:07, Greg KH wrote:
> On Thu, Oct 29, 2015 at 12:49:28AM +0200, Ioana Ciornei wrote:
>> On Thu, Oct 29, 2015 at 12:47 AM, Greg KH <greg@kroah.com> wrote:
>>> On Tue, Oct 27, 2015 at 08:40:56PM +0200, Ioana Ciornei wrote:
>>>> Starting with commit fd2bb310ca (Staging: iio: Move evgen interrupt
>>>> generation to irq_work) event processing is handled by calling
>>>> both the top half and the threaded part properly simulating real
>>>> hardware interrupts making use of threaded interrupts.
>>>> This way the processing is split in 2 parts:
>>>>
>>>> * the IRQ handler that runs in IRQ context and only saves the event
>>>> timestamp
>>>> * the threaded handler that runs in process context, reads the events
>>>> and pushes the in the userspace.
>>>>
>>>> If the IRQ handler returns IRQ_HANDLED the threaded handler is not
>>>> even being called since the interrupt is considered to be processed.
>>>> Because the iio dummy driver processes the events in the threaded
>>>> handler the IRQ handler must return IRQ_WAKE_THREAD so that the
>>>> threaded part would be awakened and called.
>>>>
>>>> Signed-off-by: Ioana Ciornei <ciorneiioana@gmail.com>
>>>> Fixes: fd2bb310ca ("Staging: iio: Move evgen interrupt generation to irq_work")
>>>> Acked-by: Daniel Baluta <daniel.baluta@intel.com>
>>>> ---
>>>> rebased on linux-iio tree
>>>
>>> Daniel, can you forward this to the iio developers, I can't take this as
>>> it doesn't apply to my tree :(
>>>
>>
>> I already sent it to the linux-iio list as Daniel suggested in a
>> previous message.
>> I hope it's ok.
> 
> Fine with me, thanks.
Hmm. This one got complex.  The fix needs to go prior to the driver move
but after the patch that broken. I've bodged it together and pushed out
a temporary branch fixes-togreg-post-rc1

I'll push that one on to Greg as the name suggests after rc1 is out and hence
the broken patch has gone into Linus' tree.   Then I'll deal with any fallout
in the togreg branch before sending that on to Greg.

At the end of the day, we have a broken fake driver - as long as we fix it reasonably
quickly no one other than Ioana will probably ever notice ;)

Jonathan

> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

