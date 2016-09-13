Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47700 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759045AbcIMRTK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Sep 2016 13:19:10 -0400
Subject: Re: [PATCH v2 1/1] iio:buffer: let poll report an error for
 unregistered devices
To: Lars-Peter Clausen <lars@metafoo.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        linux-iio@vger.kernel.org
References: <cover.1473430265.git.gregor.boirie@parrot.com>
 <579ce80942853be7eb6e6320727df0d4ffbd0903.1473430265.git.gregor.boirie@parrot.com>
 <7f729816-f82c-7ad1-8505-6df24a619131@kernel.org>
 <a544ae58-5e8b-7fd7-16ff-eb5d4144cc58@metafoo.de>
 <57D6AC92.8000609@parrot.com>
 <4badd4ba-cc23-bdae-061f-0948af93e1f0@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0a007f35-4617-e82c-c65b-1c4caa5c177c@kernel.org>
Date: Tue, 13 Sep 2016 18:19:08 +0100
MIME-Version: 1.0
In-Reply-To: <4badd4ba-cc23-bdae-061f-0948af93e1f0@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/09/16 14:36, Lars-Peter Clausen wrote:
> On 09/12/2016 03:24 PM, Gregor Boirie wrote:
>> Hi,
>>
>> On 09/12/2016 02:18 PM, Lars-Peter Clausen wrote:
>>> Hi,
>>>
>>> I had some more comments inline in v1, please see below.
>>>
>>> On 09/10/2016 05:44 PM, Jonathan Cameron wrote:
>>>>> @@ -162,13 +163,20 @@ unsigned int iio_buffer_poll(struct file *filp,
>>>>>   {
>>>>>       struct iio_dev *indio_dev = filp->private_data;
>>>>>       struct iio_buffer *rb = indio_dev->buffer;
>>>>> +    bool rdy;
>>>>>         if (!indio_dev->info)
>>>>> -        return 0;
>>>>> +        return POLLERR;
>>> I've had a look at what other subsystems do and input returns POLLERR |
>>> POLLHUP. Maybe we should mirror this.
>> Well, some input device only don't IFAIK (I'm no expert on this) as
>> POLLHUP might be focused on output errors only.
> 
> The way I understand it is that the 'output only' description for POLLHUP
> means that you can't pass POLLHUP as a event to listen for. A POLLHUP will
> always wakeup the poll() and be set in the revents field. It does not meant
> that is only set for output devices.
> 
>>
>>>
>>>>>         poll_wait(filp, &rb->pollq, wait);
>>>>> -    if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
>>>>> +    rdy = iio_buffer_ready(indio_dev, rb, rb->watermark, 0);
>>>>> +
>>>>> +    if (!indio_dev->info)
>>>>> +        return POLLERR;
>>> Why check indio_dev->info twice though, since there is no locking involved
>>> the second check does gain us anything in terms of race condition avoidance.
>> I took iio_buffer_read_first_n_outer() as a reference : the check of
>> indio_dev->info is performed at least twice :
>> * once at function start
>> * each time wait_event_interruptible() returns.
>>
>> I thought it would be a good starting point.
>>
> 
> Strictly speaking the first check there is redundant.
Feel free to post a patch killing it off :)

J
> 
>>> I think we should have one check after the poll_wait() call. If the device
>>> is unregistered we wake the pollq. So adding it there should make sure that
>>> the poll() callback is called again if the device is unregistered after the
>>> check.
>> No risk that an "exotic" userspace process perform 2 sys_poll() in the time
>> between iio_device_unregister() and iio_device_free() ?
>> I mean : am I wrong in thinking that the filep is still valid as long as the
>> fd has
>> not been released completly ?
> 
> The filep is valid as long as the file is open, same is true for the iio_dev
> and iio_buffer structures. The open file holds a reference to them.
> 
> What I meant with the race condition here is that we should make sure that
> no matter how the device unregister() and the sys_poll() are timed relative
> to each other it should still work as expected and not result in a
> indefinitely waiting poll() operation.
> 
> When multiple CPUs are involved the two operations can happen at the same
> time, so we need to cover that.
> 
>>
>>>
>>> I'm not sure though if we'd need a explicit memory barrier or whether
>>> poll_wait() can act as a implicit one. But probably we are ok, given that
>>> poll_wait() should take a lock.
>>>
>>> To be sure that the code is race free we need a guarantee that there is
>>> strict ordering between the indio_dev->info = NULL and wake_up() in
>>> unregister as well as between poll_wait() and the if (indio_dev->info) check
>>> in poll().
>>>
>>> The scenario is basically
>>>
>>> CPU0                CPU1
>>> ---------------------------------------------------------
>>> poll_wait()            indio_dev->info = NULL
>>> if (!indio_dev->info)        wake_up()
>>>
>>>
>>> If strict ordering is not observed for either side we could end up missing
>>> the unregister and poll() will block forever just as before.
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

