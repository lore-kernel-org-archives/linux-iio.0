Return-Path: <ggao@invensense.com>
From: Ge Gao <ggao@invensense.com>
References: <C0999E24-1BF1-4B7D-835B-8E3AC76C61F8@gmail.com>
 <5348d4d4e8f4766e2ed416b6b8318ee5@mail.gmail.com> <5062AE55.4060205@jic23.retrosnub.co.uk>
 <CAEE_umqapZP0g6-LOb1xxFgxtkRFuU14_+gKmq+vt=JsB38qLw@mail.gmail.com> <50630FC5.3010904@jic23.retrosnub.co.uk>
In-Reply-To: <50630FC5.3010904@jic23.retrosnub.co.uk>
MIME-Version: 1.0
Date: Wed, 26 Sep 2012 11:10:03 -0700
Message-ID: <1f93b0f60407fcfe135d37d111083d5d@mail.gmail.com>
Subject: RE: iio_buffer length
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, Denis Ciocca <denis.ciocca@gmail.com>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

I updated the latest the staging next and noticed that your patch is
already in the kfifo along with other fixes. One thing I don't understand
why in the "iio_store_to_kfifo", only 1 byte is stored vs.
bytes_per_datum is stored before. Isn't KFIFO using bytes_per_datum when
reading and writing?
I send a patch for industrial-buffer to you.
Thanks.

Best Regards,

Ge GAO


-----Original Message-----
From: J.I. Cameron [mailto:jic23@hermes.cam.ac.uk] On Behalf Of Jonathan
Cameron
Sent: Wednesday, September 26, 2012 7:23 AM
To: Denis Ciocca
Cc: Ge Gao; linux-iio@vger.kernel.org
Subject: Re: iio_buffer length

On 26/09/12 13:37, Denis Ciocca wrote:
> Hi Jon and Ge,
>
> I switched my driver code by using kfifo (using code on linux-next),
> now what I see is:
>
> using generic-buffer application, I catch every sample independently
> by the value of buffer length, is that what you tell me by "Kfifo has
> a more conventional poll and will fire off userspace whenever any data
> is in the buffer."?
> To catch data only when the buffer is full, I must catch a particular
> signal event in /dev/iio:deviceX?
>
You never want the buffer to be full.  If it is you WILL loose data due to
unlucky timing sooner or later.

Only real option if you want to grab data in chunks from that buffer is to
deadreckon the timing using a userspace timer.


> Thanks
>
> Denis
>
>
>
>
> 2012/9/26 Jonathan Cameron <jic23@jic23.retrosnub.co.uk>:
>> On 26/09/12 02:32, Ge Gao wrote:
>>>
>>> To use KFIFO, you need Jonanthan's KFIFO poll patch,
>>
>> That's in staging-next now and will merge into mainline in the next
>> merge window (about 1 to 2 weeks time).
>>
>>> you probably also
>>> need a patch from me that fixed the industrial-buffer.c. But that
>>> buffer is not well tested and is only used by me.
>>
>> There are a lot of drivers using kfifo. It's hidden in many of them
>> as they use it via the industrialio-triggered-buffer helper functions
>> that deal with the most common use cases.
>>
>> With that I count 9 in drivers/iio and 6 in drivers/staging/iio vs 10
>> in total for sw_ring most of which will go away once someone has a
>> spare couple of hours.
>>
>> Basically any driver that has come along since we moved to kfifo is
>> the preferred choice and any that anyone has touched since then.
>>
>>
>>> The original KFIFO does not
>>> have poll functionality and has some other minor bug.
>>
>> If I've missed any patches from you on this (or just forgotten them
>> ;) please do keep pestering me.
>>
>>>
>>> Ge
>>>
>>>
>>> -----Original Message-----
>>> From: linux-iio-owner@vger.kernel.org
>>> [mailto:linux-iio-owner@vger.kernel.org] On Behalf Of Denis Ciocca
>>> Sent: Tuesday, September 25, 2012 2:35 PM
>>> To: jic23@jic23.retrosnub.co.uk
>>> Cc: linux-iio@vger.kernel.org
>>> Subject: iio_buffer length
>>>
>>> Hi Jon,
>>>
>>>> Firstly please confirm you are using a kfifo buffer?
>>>
>>>
>>> No, I use sw-ring.
>>>
>>>
>>>> Swring is deprecated but will do precisely what you are seeing I
think.
>>>
>>> It uses a half full watershead to decide to signal userspace.  If
>>> you wait till the buffer is full, unless your sampling is very slow
>>> you will have data coming in before userspace has read the whole
>>> buffer out. Hence you will loose data.
>>>
>>> You are right. I saw exatly what you said.
>>>
>>>
>>>> Kfifo has a more conventional poll and will fire off userspace
>>>> whenever
>>>
>>> any data is in the buffer. Hence kfifo will work for your usecase.
>>> I would like to have a fill level capable buffer again in the future
>>> as they are very useful in high speed uses where latency doesn't
matter.
>>>
>>> Ok, I will change my sw-ring buffer to kfifo!
>>>
>>> Thanks,
>>> Denis
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio"
> in the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html
>
