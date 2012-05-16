Return-Path: <ggao@invensense.com>
From: Ge Gao <ggao@invensense.com>
References: <6e6a0f27b1900226df5350cc320f25bb@mail.gmail.com>
 <9d0339d0-2cde-4605-a8b0-99f568d05eb8@email.android.com> <4FB35420.4020001@cam.ac.uk>
In-Reply-To: <4FB35420.4020001@cam.ac.uk>
MIME-Version: 1.0
Date: Wed, 16 May 2012 10:16:48 -0700
Message-ID: <911a9107977d704ed7f0c218a15b8c38@mail.gmail.com>
Subject: RE: sw_ring.c poll problem
To: Jonathan Cameron <jic23@cam.ac.uk>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Dear Jonathan,
	Thank you very much for the information .  I will switch to kfifo. The
problem was that a lot of drivers,  which are already in the kernel,  seem
to use sw_ring, I was following other driver's route to do it.
	There is no problem with the sw_ring if we follow the way it should be
used. However, the motion integration algorithm requires that the data comes
in immediately when it is available and don't lose data. This half full
requirement poses some problems. If we set the buffer length too small, we
could lose data if the CPU is accidently delayed. If we set the length too
big, it will take a while for the data to come and the data becomes too old
when it comes to user application. It would be better that we have a ring
buffer that is long enough yet the poll will pass when there is only one
sample in the ring buffer. Hopefully, this kfifo can do the job.
	Now that I understand the mechanism underneath, I will switch to kfifo for
our driver resubmitted patch.

Best regards,

Ge GAO


-----Original Message-----
From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
Sent: Wednesday, May 16, 2012 12:16 AM
To: Ge Gao; Jonathan Cameron
Cc: linux-iio@vger.kernel.org
Subject: Re: sw_ring.c poll problem

On 5/16/2012 6:46 AM, Jonathan Cameron wrote:
>
>
> Ge Gao<ggao@invensense.com>  wrote:
>
>> Dear all,
>> 	I found that ring_sw.c the poll function has to read half of the
>> data for poll to work. Basically, you have to fill half of the ring
>> buffer in order for poll to be triggrerred. You have to also read
>> more than half of the data for poll to be disappeared. This would
>> pose problems. If you have big ring buffer, the data will lost its
>> immediacy. If you have small ring buffer, the data could lost if not
>> buffered enough. Is that possible this poll action configurable? Or I
>> missed anything.
>
> Use kfifobuf instead. Sw _ring is going away anyway.

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
