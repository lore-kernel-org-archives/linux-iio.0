Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <539722F7.10308@linux.intel.com>
Date: Tue, 10 Jun 2014 08:23:35 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
CC: Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: make blocking read wait for data
References: <1402065052-32161-1-git-send-email-josselin.costanzi@mobile-devices.fr> <5391D279.5060909@metafoo.de> <CAJA4uhc+RdEmOgyK8f3VHTqgCdAbVtdko1EW8z3BDvFq8Y4Rzw@mail.gmail.com> <5391E0D7.8050309@metafoo.de> <CAJA4uhfOGPZ_sZ1BC_OOPOOmy9YsGF8XpKjW9bE-8BSTkEdzoA@mail.gmail.com> <5392E6E4.40408@kernel.org> <539611C6.6000209@metafoo.de> <5396151C.1050109@kernel.org> <CAJA4uhcVpXEHUTcfcGw6iqU79GJrXHAEZ+MUDQyOOKjgqB8tkA@mail.gmail.com>
In-Reply-To: <CAJA4uhcVpXEHUTcfcGw6iqU79GJrXHAEZ+MUDQyOOKjgqB8tkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/10/2014 03:55 AM, Josselin Costanzi wrote:
> 2014-06-09 22:12 GMT+02:00 Jonathan Cameron <jic23@kernel.org>:
>> On 09/06/14 20:57, Lars-Peter Clausen wrote:
>>>
>>> On 06/07/2014 12:18 PM, Jonathan Cameron wrote:
>>>>
>>>> On 06/06/14 18:15, Josselin Costanzi wrote:
>>>>>
>>>>> 2014-06-06 17:40 GMT+02:00 Lars-Peter Clausen <lars@metafoo.de>:
>>>>>
>>>>>> On 06/06/2014 05:12 PM, Josselin Costanzi wrote:
>>>>>>>
>>>>>>>
>>>>>>> 2014-06-06 16:38 GMT+02:00 Lars-Peter Clausen <lars@metafoo.de>:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 06/06/2014 04:30 PM, Josselin Costanzi wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Currently the IIO buffer blocking read only wait until at least one
>>>>>>>>> data element is available.
>>>>>>>>
>>>>>>>>
>>>>>>>> But that is how it is supposed to work. With this patch for example
>>>>>>>> you
>>>>>>>> won't be able to read the last data from the buffer after the buffer
>>>>>>>> has
>>>>>>>> been disabled.
>>>>>>>
>>>>>>>
>>>>>>> I don't understand the usecase this patch breaks... If the buffer is
>>>>>>> disabled then we return what was read alreay.
>>>>>>
>>>>>>
>>>>>> If there is less data in the buffer than the amount of requested data
>>>>>> you'll
>>>>>> keep looping forever.
>>>>>
>>>>>
>>>>> We are working with an accelerometer and the only trigger is periodic so
>>>>> we
>>>>> didn't think of that since we are sure we end up with enough data.
>>>>> Is there a way to know when if the trigger is done generating events and
>>>>> no
>>>>> more data is expected?
>>>>
>>>> It should be done when the sysfs write to turn the buffer off is
>>>> complete.
>>>> Otherwise, no - there is is general no way to know when some triggers
>>>> will
>>>> fire.
>>>>>
>>>>>
>>>>> Even with the patch as is, we can use a signal to interrupt the read so
>>>>> it's
>>>>> possible for the userspace to set a timeout (this works with our
>>>>> userspace,
>>>>> on a SIGINT we correctly get the data acquired so far).
>>>>
>>>> We could, but see below...
>>>>>
>>>>>
>>>>>
>>>>>>>> Or if for example n is not aligned to the sample size you'll also
>>>>>>>> continue to loop forever.
>>>>>>>
>>>>>>>
>>>>>>> If n isn't aligned to the sample size, wouldn't iio_read_first_n_kfifo
>>>>>>> still return data multiple of samples size? In that case we would copy
>>>>>>> complete elements until we try to do a short read which would fail at
>>>>>>> n < kfifo_esize(&kf->kf) (in iio_read_first_n_kfifo).
>>>>>>
>>>>>>
>>>>>> The read_first_n() callback will make sure that it only returns full
>>>>>> samples, which means if n is smaller than the sample size it will
>>>>>> return 0.
>>>>>
>>>>>
>>>>> In fact it won't return 0 but -EINVAL then read returns the size of
>>>>> the data already
>>>>> copied (this also works with our userspace program)
>>>>>
>>>>>
>>>>>> Maybe start with which problem you are trying to address with this
>>>>>> patch and
>>>>>> then we can work forward from there to a solution. The current form of
>>>>>> the
>>>>>> patch changes the semantics of read() in a way they shouldn't be
>>>>>> changed, so
>>>>>> this is not only about the implementation bugs.
>>>>>
>>>>>
>>>>> Our use case is we continuously get data from an accelerometer. The
>>>>> sample
>>>>> frequency is relatively low (< 1KHz) so the userland ends up making one
>>>>> syscall
>>>>> per sample when we would prefer to process the data by batches to reduce
>>>>> the cpu
>>>>> load.
>>>>> We would like to have the blocking read() semantics where we wait for
>>>>> the
>>>>> data
>>>>> until the buffer is full unless there is an exceptional condition as
>>>>> it's usually done for
>>>>> ttys and sockets.
>>>>
>>>> Be careful with your examples.  This simply isn't true for sockets. Try
>>>> sending
>>>> a large amount of date over a tcp connection using blocking reads. You
>>>> frequently
>>>> get less data than requested as it tends to return when individual
>>>> packets come
>>>> in.  Note the man page for read makes it absolutely clear that partial
>>>> data may
>>>> be returned and if so the userspace program is responsible for reading
>>>> again
>>>> until it gets what it wants.
>>>>
>>>>>
>>>>> I think the patch doesn't break anything except for the case where the
>>>>> trigger generates
>>>>> a finite and unknown number of data samples and the userspace requests
>>>>> more than this
>>>>> amount of samples.
>>>>
>>>> A very common situation...
>>>>>
>>>>> But in this scenario, without the patch, a blocking read does the same
>>>>> as a poll followed
>>>>> by a non blocking read which is the standard way to get a variable
>>>>> amount of data.
>>>>
>>>> Sorry, but we simply aren't going to change the semantics of this as this
>>>> is a major userspace ABI change.  What we have at the moment conforms
>>>> entirely to what is permitted by the semantics of read.
>>>>
>>>> Now having said that, we have had a number of discussions of how to
>>>> support
>>>> watershed type events on the buffer over the years.  I think the current
>>>> consensus would be to use one of the more obscure POLL types to indicate
>>>> that there was more than a specified amount of data in a buffer ready
>>>> to be read.  The most recent thread was related specifically to hardware
>>>> buffers, but as I point out later in the discussion any interface should
>>>> work equally well with software buffers.
>>>>
>>>> http://marc.info/?l=linux-iio&m=139939531422385&w=2
>>>>
>>>> If/when this gets implemented the semantics (which will need a man page
>>>> of their own given the 'unusual' use of POLL_PRI) will be
>>>>
>>>> poll (POLLIN,  POLLRDNORM) - wait for some data.
>>>> read non blocking - read anything that is there.
>>>> read blocking - read what is there or wait until something is then read
>>>> that.
>>>> poll (POLLPRI, POLLRDBAND) - wait for a sysfs defined watershed level of
>>>> data
>>>> be available.
>>>>
>>>> Now to actually do this requires some additional functions for the
>>>> buffers
>>>> interface, and an implementation within the kfifo buffer + any others
>>>> people are using.  As it stands, kfifo has the ability to query how
>>>> many elements are unused which gets us at least close to what we want...
>>>> I've cc'd Srinivas as he may have made some progress on an interface
>>>> for this.
>>>
>>>
>>> I'm not sure if we need to or should overload the POLLPRI/POLLRDBAND
>>> semantics with a IIO specific meaning. In my opinion introducing a
>>> watershed level should be enough. E.g. if it is set to 0 you get the
>>> current behavior. It should not be to hard to implement this, the
>>> important part is to make sure to not wakeup the pollqueue each time
>>> something is added to the FIFO, but only if the FIFO level rises
>>> above the threshold. And when the buffer is disabled the threshold is
>>> ignored and the pollqueue is woken unconditionally to make it
>>> possible to read any residue that is left in the FIFO.
>>>
>> That works for me.
>>
>>> It is probably also worth looking at how other frameworks handle
>>> this. (I think ALSA pretty much does what I just described).
>>
>> Alsa is the only one I can think of that might do something similar.
>> Input definitely does straight forward polling as we currently do.
>>
>> Anyone know if V4L allows multiple frames to be polled for?  Can't
>> think what it would be for, but it is a functionality decent computer
>> vision cameras offer so maybe it is there somewhere....
>>
>> Otherwise we are into areas such as networking which don't correspond
>> that closely really as they mostly don't have a concept of 'timed' sets
>> of data.
>>
>> Thoughts welcome, but right now I like the simplicity of what Lars
>> suggests. I think it will also work just fine for hardware buffers.
>> Their watershed would presumably be set to some divisor of the requested
>> length as appropriate for a given part...
>>
>> J
>>>
>>> - Lars
>>
>>
>
> Ok, thanks for the pointers.
> Adding a per buffer sysfs watermark and timeout seems like a good
> solution for data streaming with IIO.
> I will try to look into this.

Are you planning to implement this? If you are, then I will wait for 
your updates, otherwise this is my to-do list.

Thanks,
Srinivas

>
