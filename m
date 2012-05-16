Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:55972 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759223Ab2EPHPr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 May 2012 03:15:47 -0400
Message-ID: <4FB35420.4020001@cam.ac.uk>
Date: Wed, 16 May 2012 08:15:44 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Ge Gao <ggao@invensense.com>, Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: sw_ring.c poll problem
References: <6e6a0f27b1900226df5350cc320f25bb@mail.gmail.com> <9d0339d0-2cde-4605-a8b0-99f568d05eb8@email.android.com>
In-Reply-To: <9d0339d0-2cde-4605-a8b0-99f568d05eb8@email.android.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/16/2012 6:46 AM, Jonathan Cameron wrote:
>
>
> Ge Gao<ggao@invensense.com>  wrote:
>
>> Dear all,
>> 	I found that ring_sw.c the poll function has to read half of the
>> data for poll to work. Basically, you have to fill half of the ring
>> buffer
>> in order for poll to be triggrerred. You have to also read more than
>> half
>> of the data for poll to be disappeared. This would pose problems. If
>> you
>> have big ring buffer, the data will lost its immediacy. If you have
>> small
>> ring buffer, the data could lost if not buffered enough. Is that
>> possible
>> this poll action configurable? Or I missed anything.
>
> Use kfifobuf instead. Sw _ring is going away anyway.

Hi Ge,

I realised after sending that message that I was being rather dismissive
of your query.  Got up far too early this morning (as every morning ;)

Anyhow, to give more details. sw_ring is probably never going to make it
out of staging, hence the move to kfifo_buf. At somepoint we need to 
work out how to do equivalent functionality of sw_ring but I've not had
time to more than start looking into this.

As you saw, poll on sw_ring is a watershead signal indicating (in theory
and last I checked it worked) that the ring is more than half full.
Any read that takes the fill level below half (test code just reads half
the size of the buffer), should allow a new passing of the watershead
to resignal poll. It's entirely possible there is a bug in there though
I know it is been getting a fair bit of testing with some other drivers
so could be todo with the precise way you are reading it hitting some
corner case? (I'm stretching...)

Right now I'd just move over to kfifo_buf if I were you. It's much more
'standard' in that it's a fifo and poll indicates if there is anything
there at all.
>> 	Thanks.
>>
>> Best regards,
>>
>> Ge GAO
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

