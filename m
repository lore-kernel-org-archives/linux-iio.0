Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48340 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754489AbaHBQ5k (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Aug 2014 12:57:40 -0400
Message-ID: <53DD1881.1020607@kernel.org>
Date: Sat, 02 Aug 2014 17:57:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Aniroop Mathur <aniroop.mathur@gmail.com>
CC: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: IIO: Why cannot open two iio device node file descriptors simultaneously
 ?
References: <CADYu309fV8qNv0v03xr1T0eeLEV97YFPoAVkKdT8jZcom8uqGQ@mail.gmail.com>	<53DCCB4A.3020304@kernel.org> <CADYu30-9Y4rjf5kZZea32pL04BGe1y1E0wCNtcy4qAn1wO1gHQ@mail.gmail.com>
In-Reply-To: <CADYu30-9Y4rjf5kZZea32pL04BGe1y1E0wCNtcy4qAn1wO1gHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/08/14 14:07, Aniroop Mathur wrote:
> On Sat, Aug 2, 2014 at 4:58 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 07/31/14 18:07, Aniroop Mathur wrote:
>>> Dear IIO Community,
>>> Greetings !!
>>>
>>> I am Aniroop Mathur working in Sensors kernel and HAL field.
>>> I have one question about IIO, for which i need your support.
>>>
>>> I would like to open two file descriptors for IIO device node - /dev/iio:device0
>>> int fd1 = open("/dev/iio:device0",O_RDONLY);
>>> int fd2 = open("/dev/iio:device0",O_RDONLY);
>>>
>>> But, only first open call succeeds.
>>> The second open calls fails with error "Device or Resource busy".
>>>
>>> In normal input device, we can open as many event node file
>>> descriptors as we like.
>>> int fd1 = open("/dev/input/event1");
>>> int fd2 = open("/dev/input/event1");
>>>
>>> Both calls succeeds for input subsystem case.
>>>
>>> So, why restriction is present in IIO subsystem ?
>> Basically a different design descision for the userspace interfaces.  Input moves
>> a lot of handling and processing into the kernel.  For IIO, which at least sometimes
>> is dealing with much faster devices, this adds overhead.  Note that we remove
>> all overhead of description of data from the main data stream to reduce overhead
>> so that must be described elsewhere (sysfs).
>>
>> If you really want to do that then we do have a prototype input client driver for IIO
>> (though it's not seen much work recently).
>>
> 
> I did not understood your point clearly. (prototype input client driver for IIO)
> So you mean it is possible to open same iio device node twice by some means ?
Not really.  What you can do is add an input device driver that uses an iio device
as the source of it's data.  That way you end up with all the normal input
interfaces.  This was originally intended for multipurpose devices such as
accelerometers or cases where a clear input device is wired up to a general
purpose ADC (joysticks etc).
> If so, could you please explain how to do it ?
> 
> Actually, main aim is to create an IIO device Simulator.
Cool
> For this I need to write data to IIO device node from a user space application
> when hardware chip is actually off.
Sure, though if you paired a DAC device with an ADC (or a modification of
our existing simulated driver - the dummy driver still in staging).

> So, even after opening iio device node,
> can we write the data to IIO device node from user space ?
> (I do not see write function in below fileops)

Indeed.  Lars was working on some buffered support for DACs but hasn't
yet submitted it for mainline inclusion.  Lars how is the buffered output
stuff coming along?

Right now output devices are only supported via the sysfs interfaces.
> 
> static const struct file_operations iio_event_chrdev_fileops = {
>      .read =  iio_event_chrdev_read,
>      .poll =  iio_event_poll,
>      .release = iio_event_chrdev_release,
>      .owner = THIS_MODULE,
>      .llseek = noop_llseek,
> };
> 
>> In theory it is possible to have more userspace exposed buffer associated with
>> a given IIO device, though right now this isn't actually done.  The intent of that
>> infrastructure is to provide splitting of data to multiple users within the kernel
>> (one might be IIO, another input and a third battery monitoring).
>>
>> Ultimately if you want multiple userspace devices to share a datastream, then it
>> makes sense to avoid multiple switches in and out of the kernel and do it in userspace
>> instead.
>>
>> Jonathan
>>
>>> Why two iio device nodes cannot be open together ?
>> Not quite what I think you mean.  You mean, why can you not open the same device node
>> twice?
> 
> Yes, right. Thanks for the correction. :)
> 
>>>
>>> Thanks in advance !
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
> Thanks,
> Aniroop Mathur
> 
