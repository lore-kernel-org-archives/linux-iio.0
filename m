Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yk0-f196.google.com ([209.85.160.196]:35712 "EHLO
	mail-yk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbbJ1Wt2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 28 Oct 2015 18:49:28 -0400
Received: by ykek133 with SMTP id k133so1905463yke.2
        for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2015 15:49:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20151028224722.GA31531@kroah.com>
References: <1445971256-22474-1-git-send-email-ciorneiioana@gmail.com>
	<20151028224722.GA31531@kroah.com>
Date: Thu, 29 Oct 2015 00:49:28 +0200
Message-ID: <CAHWJYFmK1tLUW1EA=dDyGLqiqukOz_4CfL4AMuUdycQ0feTxzA@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: iio: dummy: complete IIO
 events delivery to userspace
From: Ioana Ciornei <ciorneiioana@gmail.com>
To: Greg KH <greg@kroah.com>
Cc: linux-iio@vger.kernel.org,
	outreachy-kernel <outreachy-kernel@googlegroups.com>,
	Cristina Georgiana Opriceana <cristina.opriceana@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Oct 29, 2015 at 12:47 AM, Greg KH <greg@kroah.com> wrote:
> On Tue, Oct 27, 2015 at 08:40:56PM +0200, Ioana Ciornei wrote:
>> Starting with commit fd2bb310ca (Staging: iio: Move evgen interrupt
>> generation to irq_work) event processing is handled by calling
>> both the top half and the threaded part properly simulating real
>> hardware interrupts making use of threaded interrupts.
>> This way the processing is split in 2 parts:
>>
>> * the IRQ handler that runs in IRQ context and only saves the event
>> timestamp
>> * the threaded handler that runs in process context, reads the events
>> and pushes the in the userspace.
>>
>> If the IRQ handler returns IRQ_HANDLED the threaded handler is not
>> even being called since the interrupt is considered to be processed.
>> Because the iio dummy driver processes the events in the threaded
>> handler the IRQ handler must return IRQ_WAKE_THREAD so that the
>> threaded part would be awakened and called.
>>
>> Signed-off-by: Ioana Ciornei <ciorneiioana@gmail.com>
>> Fixes: fd2bb310ca ("Staging: iio: Move evgen interrupt generation to irq_work")
>> Acked-by: Daniel Baluta <daniel.baluta@intel.com>
>> ---
>> rebased on linux-iio tree
>
> Daniel, can you forward this to the iio developers, I can't take this as
> it doesn't apply to my tree :(
>

I already sent it to the linux-iio list as Daniel suggested in a
previous message.
I hope it's ok.

Thanks,

Ioana

> thanks,
>
> greg k-h
