Return-Path: <lars@metafoo.de>
Message-ID: <53DFC0DB.5080003@metafoo.de>
Date: Mon, 04 Aug 2014 19:20:27 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Aniroop Mathur <aniroop.mathur@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: IIO: Why cannot open two iio device node file descriptors simultaneously
 ?
References: <CADYu309fV8qNv0v03xr1T0eeLEV97YFPoAVkKdT8jZcom8uqGQ@mail.gmail.com>	<53DCCB4A.3020304@kernel.org>	<CADYu30-9Y4rjf5kZZea32pL04BGe1y1E0wCNtcy4qAn1wO1gHQ@mail.gmail.com>	<53DD1881.1020607@kernel.org>	<53DDEEC6.2070300@metafoo.de>	<CADYu30--CpVmTowroGJEcKbg78B-xrzGXfdhFxpOYXAgcD41gA@mail.gmail.com>	<53DF33CE.4080100@metafoo.de> <CADYu30_n3jndmH3oTq5V0ahJOGMn0ibvLckp+-0gq0jtqghAiw@mail.gmail.com>
In-Reply-To: <CADYu30_n3jndmH3oTq5V0ahJOGMn0ibvLckp+-0gq0jtqghAiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 08/04/2014 05:11 PM, Aniroop Mathur wrote:
> On Mon, Aug 4, 2014 at 12:48 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 08/03/2014 11:32 AM, Aniroop Mathur wrote:
>>>
>>> On Sun, Aug 3, 2014 at 1:41 PM, Lars-Peter Clausen <lars@metafoo.de>
>>> wrote:
>>>>
>>>> On 08/02/2014 06:57 PM, Jonathan Cameron wrote:
>>>> [...]
>>>>
>>>>>> So, even after opening iio device node,
>>>>>> can we write the data to IIO device node from user space ?
>>>>>> (I do not see write function in below fileops)
>>>>>
>>>>>
>>>>>
>>>>> Indeed.  Lars was working on some buffered support for DACs but hasn't
>>>>> yet submitted it for mainline inclusion.  Lars how is the buffered
>>>>> output
>>>>> stuff coming along?
>>>>
>>>>
>>>>
>>>> I still need to do the re-write you wanted me to do, otherwise its
>>>> working
>>>> fine ;)
>>>>
>>>
>>> Great :)
>>> So, it is possible to write data to iio fd ?
>>
>>
>> No you can't. At least not with the upstream code. What exactly is it that
>> you want to do with this?
>>
>
> Okay :)
> Actually, I am working on IIO device simulator android application.
> This simulator will record the sensor data first and then replay it again.
> For recording, we can read the data from iio device node and store it some file.
> And for replay, we need to write the recorded data back to iio device node.
> But as you said, from hal/application we cannot write the data to iio
> device node
> and therefore i am stuck how to replay back the recorded data.
>
> In normal input device node, we can both read and write data,
> so simulator is working fine for this case.
> I was hoping to do the same with IIO device node.
>
> Is there any scope this facility will be included in future for IIO ? :)

Injection of data into the output stream of a IIO device is something that's 
not planed at the moment I think. The writing support Jonathan referred to 
is for writing data to actual hardware (e.g. a DAC). If you think it will be 
useful to have support for injecting data into a abitrary IIO datastream 
rather than e.g. having dummy loopback device you can submit a patch which 
adds support for this.

- Lars
