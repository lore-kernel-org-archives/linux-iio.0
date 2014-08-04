Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:35332 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbaHDPLj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Aug 2014 11:11:39 -0400
Received: by mail-la0-f41.google.com with SMTP id s18so5636657lam.28
        for <linux-iio@vger.kernel.org>; Mon, 04 Aug 2014 08:11:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53DF33CE.4080100@metafoo.de>
References: <CADYu309fV8qNv0v03xr1T0eeLEV97YFPoAVkKdT8jZcom8uqGQ@mail.gmail.com>
	<53DCCB4A.3020304@kernel.org>
	<CADYu30-9Y4rjf5kZZea32pL04BGe1y1E0wCNtcy4qAn1wO1gHQ@mail.gmail.com>
	<53DD1881.1020607@kernel.org>
	<53DDEEC6.2070300@metafoo.de>
	<CADYu30--CpVmTowroGJEcKbg78B-xrzGXfdhFxpOYXAgcD41gA@mail.gmail.com>
	<53DF33CE.4080100@metafoo.de>
Date: Mon, 4 Aug 2014 20:41:37 +0530
Message-ID: <CADYu30_n3jndmH3oTq5V0ahJOGMn0ibvLckp+-0gq0jtqghAiw@mail.gmail.com>
Subject: Re: IIO: Why cannot open two iio device node file descriptors
 simultaneously ?
From: Aniroop Mathur <aniroop.mathur@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Aug 4, 2014 at 12:48 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 08/03/2014 11:32 AM, Aniroop Mathur wrote:
>>
>> On Sun, Aug 3, 2014 at 1:41 PM, Lars-Peter Clausen <lars@metafoo.de>
>> wrote:
>>>
>>> On 08/02/2014 06:57 PM, Jonathan Cameron wrote:
>>> [...]
>>>
>>>>> So, even after opening iio device node,
>>>>> can we write the data to IIO device node from user space ?
>>>>> (I do not see write function in below fileops)
>>>>
>>>>
>>>>
>>>> Indeed.  Lars was working on some buffered support for DACs but hasn't
>>>> yet submitted it for mainline inclusion.  Lars how is the buffered
>>>> output
>>>> stuff coming along?
>>>
>>>
>>>
>>> I still need to do the re-write you wanted me to do, otherwise its
>>> working
>>> fine ;)
>>>
>>
>> Great :)
>> So, it is possible to write data to iio fd ?
>
>
> No you can't. At least not with the upstream code. What exactly is it that
> you want to do with this?
>

Okay :)
Actually, I am working on IIO device simulator android application.
This simulator will record the sensor data first and then replay it again.
For recording, we can read the data from iio device node and store it some file.
And for replay, we need to write the recorded data back to iio device node.
But as you said, from hal/application we cannot write the data to iio
device node
and therefore i am stuck how to replay back the recorded data.

In normal input device node, we can both read and write data,
so simulator is working fine for this case.
I was hoping to do the same with IIO device node.

Is there any scope this facility will be included in future for IIO ? :)

Also, few days back I posted this query on Linuxquestions.org.
http://www.linuxquestions.org/questions/linux-general-1/iio-why-cannot-open-same-iio-device-node-twice-4175512869/

I think now this thread could be marked as solved.
Title - IIO: Why cannot open same iio device node twice ?

May be if it is okay, please help to put the answer upon the link above.

>From my side,
Below is the answer i am able to derive from above discussion:

"Basically IIO is a different design for the userspace interfaces.
IIO mainly deals with much faster devices so overhead of description of data
has been removed to avoid overhead in kernel.

An alternate solution would be to use a input client driver for IIO,
which can uses an iio device as the source of it's data.
That way we end up with all the normal input interfaces.

Ultimately if we want multiple user applications to share a datastream,
then it makes sense to avoid multiple switches in and out of the kernel
and do it in userspace instead."

Is the answer okay ?

> - Lars
