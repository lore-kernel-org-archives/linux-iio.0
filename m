Return-Path: <ggao@invensense.com>
From: Ge Gao <ggao@invensense.com>
References: <6e6a0f27b1900226df5350cc320f25bb@mail.gmail.com>
 <9d0339d0-2cde-4605-a8b0-99f568d05eb8@email.android.com> <4FB35420.4020001@cam.ac.uk>
 <0a0072f9cc413b7489544b461684c953@mail.gmail.com> <4FB68736.7040303@cam.ac.uk>
 <260c9088755bc30017187698cf39b8c4@mail.gmail.com> <4FB764EB.4040707@kernel.org>
 <4FB76AAF.6040303@metafoo.de> <4FB76CF7.7010701@kernel.org> <4FB77937.3070109@metafoo.de>
In-Reply-To: <4FB77937.3070109@metafoo.de>
MIME-Version: 1.0
Date: Mon, 21 May 2012 10:03:45 -0700
Message-ID: <194f8003aa6ec7f6a2b05653027fee33@mail.gmail.com>
Subject: RE: sw_ring.c poll problem
To: Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

-----Original Message-----
From: Lars-Peter Clausen [mailto:lars@metafoo.de]
Sent: Saturday, May 19, 2012 3:43 AM
To: Jonathan Cameron
Cc: Ge Gao; Jonathan Cameron; linux-iio@vger.kernel.org
Subject: Re: sw_ring.c poll problem

On 05/19/2012 11:50 AM, Jonathan Cameron wrote:
> On 05/19/2012 10:41 AM, Lars-Peter Clausen wrote:
>> On 05/19/2012 11:16 AM, Jonathan Cameron wrote:
>>> On 05/18/2012 07:26 PM, Ge Gao wrote:
>>>> Thanks for the patch. There could be one problem with the
implementation.
>>>> Consider the situation:
>>>> 1. there are 10 packets in the kfifo.
>>>> 2. Read 1 packet. Then poll again.
>>>> 3. the poll will stuck at poll_wait(filp, &rb->pollq, wait) because
>>>> it needs the next store to wake it up, while in reality, it should
>>>> return immediately if there is data already in the kfifo.
>>> Agreed that is what should happen.  I'm just getting my head around
>>> why it doesn't (or more specifically what is different about how we
>>> are doing it from other similar cases).
>>
>> I'm not sure that this is what should happen. We most certainly want
>> to have a threshold for poll. Otherwise we'd switch back and forth
>> between userspace and kernel space for each sample individual sample
>> captured. This will decrease the overall system performance (because
>> of all the context switching). So userspace should be aware of that
>> threshold and that poll might not wake the process up even if there are
samples in the buffer. ALSA basically does the same.
> When this originally came up, one suggestion was to use one of the
> other types of poll for this (can't recall, but maybe POLLRDBAND)
>
> For Ge's case it actually makes sense to do it for every scan as the
> scans can be very large and at relatively low frequency.

Well, for the sw_ring buffer the threshold was buffer_size/2, so if you'd
set your buffer size to 2 you'd get woken up for each sample written.

>From GE: Clearly setting the sw_ring size to 2 won't buffer well. It will
easily lose when system load is heavy. A mechanism of both instancy and
buffering capability is required in some situations.

>
> What you are asking for is one of the primary things that we loose in
> moving from ring_sw to kfifo.   I keep meaning to take time to look
> at adding watersheads to the kfifo implementation. Right now we just
> have to dead recon in userspace and read slightly faster than data is
> being generated.  We had some bells and whistles in that sw_ring that
> aren't anywhere else at the moment but we'll work on that going forward.
>

I think it is better to get rid of that stufftoread flag and add a
samples_available() callback. It'd serve a similar purpose, but instead of
just telling you that something is available or not it will tell you the
exact number of samples. Which then allows us to implement stuff like
watersheads in the generic code.

>
> I don't think there is any harm in Ge's fix of adding a check before
> poll_wait. Worst thing it does is tell userspace there is data when
> there isn't.  Slight overhead due to the race, but trivial given we
> can argue the read and the poll should be in the same thread anyway in
> almost all cases.


I suppose it makes sense, but I'm still a bit confused as to why it works
for everybody else (all the other subsystems) without this extra check.

Frem GE: the sw_ring is working OK in my driver. However, it may have
problem in some situations, like I said earlier.

>
> Jonathan
>>
>> - Lars
>>
>>>
>>>
>>>> 4. It might be better to put poll inside ring buffer implementation
>>>> itself rather than industrial-buffer.c, such as providing a new
>>>> method like poll to do it.
>>> Certainly could do that, but I'm not sure how it will help.
>>>
>>>
>>>
>>>> What do you think?
>>>> Thanks.
>>>>
>>>> Best Regards,
>>>>
>>>> GE GAO
>>>>
>>>>
>>>>
>>>> -----Original Message-----
>>>> From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
>>>> Sent: Friday, May 18, 2012 10:31 AM
>>>> To: Ge Gao
>>>> Cc: Jonathan Cameron; linux-iio@vger.kernel.org
>>>> Subject: Re: sw_ring.c poll problem
>>>>
>>>>
>>>>
>>>> On 05/18/2012 02:08 AM, Ge Gao wrote:
>>>>> Dear Jonathan,
>>>>> 	I check the kfifo buffer implementation under IIO directory.
>>>> However,
>>>>> I didn't find the "pollq" is released anywhere as sw_ring does.
>>>>> Without it, how can kfifo be polled if it is used by
>>>> industrial-buffer.c? Thanks.
>>>> Sorry for not getting back to you sooner.  Totally manic at the day
>>>> job today tracking two delightful bugs.
>>>>
>>>> Anyhow, looks like I'd imagined we'd actually added poll support to
>>>> kfifo when it never got implemented.  Should be easy enough though.
>>>>
>>>> diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
>>>> index 6bf9d05..e69d6ce 100644
>>>> --- a/drivers/iio/kfifo_buf.c
>>>> +++ b/drivers/iio/kfifo_buf.c
>>>> @@ -6,6 +6,7 @@
>>>>  #include <linux/kfifo.h>
>>>>  #include <linux/mutex.h>
>>>>  #include <linux/iio/kfifo_buf.h>
>>>> +#include <linux/sched.h>
>>>>
>>>>  struct iio_kfifo {
>>>>  	struct iio_buffer buffer;
>>>> @@ -35,6 +36,7 @@ static int iio_request_update_kfifo(struct
>>>> iio_buffer
>>>> *r)
>>>>  	kfifo_free(&buf->kf);
>>>>  	ret = __iio_allocate_kfifo(buf, buf->buffer.bytes_per_datum,
>>>>  				   buf->buffer.length);
>>>> +	r->stufftoread = false;
>>>>  error_ret:
>>>>  	return ret;
>>>>  }
>>>> @@ -97,6 +99,10 @@ static int iio_store_to_kfifo(struct iio_buffer
*r,
>>>>  	ret = kfifo_in(&kf->kf, data, r->bytes_per_datum);
>>>>  	if (ret != r->bytes_per_datum)
>>>>  		return -EBUSY;
>>>> +	
>>>> +	r->stufftoread = true;
>>>> +	wake_up_interruptible(&r->pollq);
>>>> +
>>>>  	return 0;
>>>>  }
>>>>
>>>> @@ -112,6 +118,12 @@ static int iio_read_first_n_kfifo(struct
>>>> iio_buffer *r,
>>>>  	n = rounddown(n, r->bytes_per_datum);
>>>>  	ret = kfifo_to_user(&kf->kf, buf, n, &copied);
>>>>
>>>> +	if (kfifo_is_empty(&kf->kf))
>>>> +		r->stufftoread = false;
>>>> +	/* verify it is still empty to avoid race */
>>>> +	if (!kfifo_is_empty(&kf->kf))
>>>> +		r->stufftoread = true;
>>>> +
>>>>  	return copied;
>>>>  }
>>>>
>>>> .. is a totally untested patch to add poll support to it.
>>>> The little dance at the end is to avoid a write having occured
>>>> between the kfifo_is_empty and setting the flag false as that could
>>>> wipe out the existence of some data in the buffer. Given we only
>>>> ever have one writer and one reader that should work I think.
>>>>
>>>> Jonathan
>>>>
>>>>>
>>>>> Hi Ge,
>>>>>
>>>>> I realised after sending that message that I was being rather
>>>>> dismissive of your query.  Got up far too early this morning (as
>>>>> every morning ;)
>>>>>
>>>>> Anyhow, to give more details. sw_ring is probably never going to
>>>>> make it out of staging, hence the move to kfifo_buf. At somepoint
>>>>> we need to work out how to do equivalent functionality of sw_ring
>>>>> but I've not had time to more than start looking into this.
>>>>>
>>>>> As you saw, poll on sw_ring is a watershead signal indicating (in
>>>>> theory and last I checked it worked) that the ring is more than
>>>>> half
>>>> full.
>>>>> Any read that takes the fill level below half (test code just
>>>>> reads half the size of the buffer), should allow a new passing of
>>>>> the watershead to resignal poll. It's entirely possible there is a
>>>>> bug in there though I know it is been getting a fair bit of
>>>>> testing with some other drivers so could be todo with the precise
>>>>> way you are reading it hitting some corner case? (I'm
>>>>> stretching...)
>>>>>
>>>>> Right now I'd just move over to kfifo_buf if I were you. It's much
>>>>> more 'standard' in that it's a fifo and poll indicates if there is
>>>>> anything there at all.
>>>>>>> 	Thanks.
>>>>>>>
>>>>>>> Best regards,
>>>>>>>
>>>>>>> Ge GAO
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe
linux-iio"
>>>>>>> in the body of a message to majordomo@vger.kernel.org More
>>>>>>> majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>
