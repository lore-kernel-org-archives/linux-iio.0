Return-Path: <jic23@cam.ac.uk>
Message-ID: <4C828138.6060406@cam.ac.uk>
Date: Sat, 04 Sep 2010 18:26:16 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>
Subject: Re: [IIO] Cleanup userspace
References: <4C777E16.6040708@iis.fraunhofer.de> <4C77AC01.3090204@cam.ac.uk> <4C77B68B.4060805@iis.fraunhofer.de> <4C77CA90.2030806@cam.ac.uk> <4C77CC28.6020604@iis.fraunhofer.de> <4C77D52A.6090606@cam.ac.uk>
In-Reply-To: <4C77D52A.6090606@cam.ac.uk>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 08/27/10 16:09, Jonathan Cameron wrote:
> ...
>>>
>>> Agreed. These ought to be in there and will be needed
>>>
>>>> To be compatible with future extensions we could have:
>>>>    |- /sys/bus/iio/ii0/buffer0/scan_elements/
>>>>       |- accel_x:en    (0 or 1)
>>>>       |- accel_x:type  (i.e. s14/16, see *)
>>>>       |- accel_x:index
>>>>
>>>
>>>> * s14/16 means signed 14 bits, stored in 16 bits, right aligned. If
>>>> it's left aligned we can just modify the scale attribute and give the
>>>> 16 bit interpretation in <channel>:raw.
>>> That is quite a neat way of doing it though I'm not sure 'type' is the
>>> ideal name.  My immediate thought is that type would be 'acceleration'!
>>> We definitely want this on list.  We'd also want to drop the precision
>>> attribute as that will just confuse things.
>>
>> I'm open for any other name.
> Lets see if anyone else has a suggestion...

actually, having thought about it a bit more (and as no one else chipped in)
I'm happy to go with type as you suggested. It's a nice clear interface.
It should be obvious to anyone looking at the value that it is about the size
of the element (even if they don't immediately follow the /16 bit).
Perhaps we should run this past lkml to see if anyone has a suggestion?

Manuel, it's your idea so you get to write the email ;)
