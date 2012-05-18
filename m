Return-Path: <ggao@invensense.com>
From: Ge Gao <ggao@invensense.com>
References: <6e6a0f27b1900226df5350cc320f25bb@mail.gmail.com>
 <9d0339d0-2cde-4605-a8b0-99f568d05eb8@email.android.com> <4FB35420.4020001@cam.ac.uk>
In-Reply-To: <4FB35420.4020001@cam.ac.uk>
MIME-Version: 1.0
Date: Thu, 17 May 2012 18:08:51 -0700
Message-ID: <0a0072f9cc413b7489544b461684c953@mail.gmail.com>
Subject: RE: sw_ring.c poll problem
To: Jonathan Cameron <jic23@cam.ac.uk>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Dear Jonathan,
	I check the kfifo buffer implementation under IIO directory. However, I
didn't find the "pollq" is released anywhere as sw_ring does.  Without it,
how can kfifo be polled if it is used by industrial-buffer.c? Thanks.

Best Regards,

Ge GAO


Hi Ge,

I realised after sending that message that I was being rather dismissive of
your query.  Got up far too early this morning (as every morning ;)

Anyhow, to give more details. sw_ring is probably never going to make it out
of staging, hence the move to kfifo_buf. At somepoint we need to work out
how to do equivalent functionality of sw_ring but I've not had time to more
than start looking into this.

As you saw, poll on sw_ring is a watershead signal indicating (in theory and
last I checked it worked) that the ring is more than half full.
Any read that takes the fill level below half (test code just reads half the
size of the buffer), should allow a new passing of the watershead to
resignal poll. It's entirely possible there is a bug in there though I know
it is been getting a fair bit of testing with some other drivers so could be
todo with the precise way you are reading it hitting some corner case? (I'm
stretching...)

Right now I'd just move over to kfifo_buf if I were you. It's much more
'standard' in that it's a fifo and poll indicates if there is anything there
at all.
>> 	Thanks.
>>
>> Best regards,
>>
>> Ge GAO
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>
