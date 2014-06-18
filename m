Return-Path: <kristina.martsenko@gmail.com>
Message-ID: <53A1895A.4090209@gmail.com>
Date: Wed, 18 Jun 2014 15:43:06 +0300
From: =?UTF-8?B?S3Jpc3RpbmEgTWFydMWhZW5rbw==?=
 <kristina.martsenko@gmail.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Greg KH <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: IIO drivers left in drivers/staging/
References: <20140611013007.GA32756@kroah.com> <f0db211a-bf69-4a3e-beda-2101af74ae25@email.android.com> <53998D43.9020209@gmail.com>
In-Reply-To: <53998D43.9020209@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

On 12/06/14 14:21, Kristina Martšenko wrote:
> On 11/06/14 11:05, Jonathan Cameron wrote:
>> On June 11, 2014 2:30:07 AM GMT+01:00, Greg KH <gregkh@linuxfoundation.org> wrote:
>>> Hi Jonathan,
>> Hi Kristina/Greg.
> 
> Hi Jonathan!
> 
>>> I'd really like to figure out what is left to do with all of the
>>> remaining IIO staging drivers, and see if we can get them all moved out
>>> soon.
>> There is a lot of each driver having its own peculiar set of little and sometimes big
>>  issues! We have also kind of gotten into the habbit of treating staging graduations as if
>>  they were initial driver submissions so proposed moves get quite a bit of review and
>>  that often extends the list of things to fix or improve rather a lot. Of course any help is
>>  welcome.
> 
> Sounds good, I'm glad to help out however I can.
> 
>> I'll reply in more detail about this later. 
>>
>> For now I have cc'd Lars as he has inherited
>>  responsibility for a lot of AD drivers that have been around from the early days when
>>  things were a little loose.
>>
>> If Christina is raring to get started, my notes say the lpc32xx_ADC driver needs some
>>  prefixes on #define constants and that is all I picked up for that driver when reviewing it
>>  for a staging graduation.
>>
>> If not, Lars, what about looking at the resolver drivers or perhaps the CDC drivers?
>>  If I recall they are pretty clean and straight forward. Probably some ABI in need of
>>  documentation (sysfs attribute naming). If not do you have any short term suggestions?
>>
>>>
>>> As part of the OPW intern program, Kristina has agreed to help out with
>>> staging kernel drivers and I thought that doing this type of work would
>>> be a great task.  There seems to be a number of different types of
>>> IIO drivers here, so that should keep her from being bored with just
>>> one
>>> specific type of sensor.  There are also some "dummy" IIO drivers,
>>> which
>>> I don't really understand what they are for (as well as why they remain
>>> in staging.)
>> Ah. There is only really one dummy driver, be it with a software interrupt driver to fake
>>  hardware threshold interrupts etc.
>>
>> This device is basically a fake. The intent was to allow those with no hardware to hand
>>  to work at or understand the core of iio.
>> It has come in very handy as a test tool!
>>
>> The other intended purpose is to act as an example of best practice and provide
>>  documentation of a sort.
>>
>> As for why it is still in staging... It comes down to the dubious hack that provides fake event interrupts. We do it much nicer in the sysfs trigger and would like to either use that approach or find something more generic.
>>>
>>> The drivers/staging/TODO file seems pretty old, being dated back in
>>> 2009
>>> and not really done much with the exception of adding one entry.
>>
>> Oops
>>>
>>> So, any thoughts about what to do here?  Any pointers to devices that
>>> she can aquire if that needs to happen, or APIs that need to be
>>> standardized across types?
>> Most ABI bits are now to do with new stuff.
>> Having said that the resolver and CDC
>>  drivers use some ABI that is probably documented but that documentation is also
>>  a candidate for cleaning up and moving out of staging.
>>
>> Busy day (pesky customer demo) so will get back with more concrete stuff later.
> 
> Okay so right now I'm getting the following things I could work on:
> 
> 1) prefixes on define constants for lpc32xx_ADC (then trying to move it
> out of staging and seeing what other issues people find?)
> 2) resolver/CDC ABI documentation cleanup
> 3) dummy driver fake event interrupt hack
> 4) Lars may have more ideas?
> 
> The plan is for me to start working on this stuff full time next week,
> so if you think of anything more, please let me know!

Haven't heard back from you about this. Have you found anything else
that needs to be done with staging IIO drivers before they can be moved out?

Thanks,
Kristina
