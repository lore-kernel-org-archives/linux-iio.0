Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55751 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758694Ab2FAH7U (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Jun 2012 03:59:20 -0400
Message-ID: <4FC8764C.9050700@kernel.org>
Date: Fri, 01 Jun 2012 08:59:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Ge Gao <ggao@invensense.com>
CC: linux-iio@vger.kernel.org
Subject: Re: A IIO trigger problem/bug.
References: <CAE9_fz=THxH8DRwbJMGONJC3szwiJ9DM=NF0HM-e19nqXmtcHQ@mail.gmail.com>
In-Reply-To: <CAE9_fz=THxH8DRwbJMGONJC3szwiJ9DM=NF0HM-e19nqXmtcHQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/31/2012 4:56 PM, Ge Gao wrote:
>
>     I met a strange problem concerning IIO driver. I wrote a driver 
> that has trigger, ring buffer,just the standard way of doing things. 
> It sometimes runs OK. However, I found sometimes, the trigger is NOT 
> triggered at all. I am using a hardware interrupt to trigger a 
> threaded ISR and post-ISR. I can see the interrupt coming correctly. 
> By using "cat /proc/interrupts", I can see that the number of triggers 
> stays the same while the number of interrupt increases steadily. 
It's been a while since I looked at this corner, but IIRC the basic 
principal is to prevent the driver
read out code from being reentrant. Thus if your trigger is occuring 
faster than the driver is
capable of reading from the device then triggers will be dropped.
It's possible that we have a bug in there that means it is not 
succesfully recovering from the trigger being dropped.

One thought would be that you weren't clearing the interrupt unless a 
read occurs, but that doesn't seem
to be the case here given you are seeing /proc/interrupts continue to 
increase...

The driver controls masking (typically through IRQF_ONESHOT) of an 
interrupt that is in turn fed by a second
interrupt handler - the one in your driver handling the actual hardware 
interrupt.

I can't immediately spot why trig->usecount would be wrong.   Just as a 
test could you drop the test for it
entirely and see if that makes things work as expected?  That will break 
having multiple users of the trigger,
but might give us some clues as to what is happening.  Otherwise, please 
add some printk's to the relevant
places and lets see what is happening.  With your usecase 
trig->use_count should only ever be 0 or 1
and if it is still 1 in iio_trigger_poll, we'll have some clue what is 
happening...


