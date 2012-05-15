Return-Path: <jic23@kernel.org>
Message-ID: <4FB2B93D.50903@kernel.org>
Date: Tue, 15 May 2012 21:14:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Ge Gao <ggao@invensense.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: Submission of invensense IIO driver.
References: <963e33ea7e241e4ee81b4d50180eb8ae@mail.gmail.com>
In-Reply-To: <963e33ea7e241e4ee81b4d50180eb8ae@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/14/2012 07:55 PM, Ge Gao wrote:
> Dear Jonanthan,
> 	The attached is the driver for invensense MPU IIO driver. I
> believe it exceeds the 100,00 characters.  Would you advise what to do
> with it? Thanks.

Couple of things to do before we go too far with this.

1) Make it a patch (or better a series of patches - it must be
bisectable - i.e. compile up to any point in the patch series).
2) Make sure it applies against staging/staging-next and builds
on x86 (yeah it may seem odd, but that's a staging requirement ;)
3) Make sure it doesn't use any non standard headers linux/mpu.h.

Basically I want to be able to buid it.

For reference, the patch is about 220,000 characters so indeed
won't in it's current form get through the mailing list limits.

Few general comments.  Use bitfields when you have lots of
basically boolean values in a row. Makes for much smaller
structures.

Don't be scared of white space.  Blank lines at the end of function
or structure definitions make things easier to read.  At this
stage I'm afraid a lot of your job is making life pleasant for
reviewers ;)

A few more specific bits...
st->compass_st_upper etc look to be just set to some defined values.
An array of static const structures, onen entry for each device is
cleaner.

Prefix definitions with appropriate part number. Basically this
is convention, rather than it being specifically better than what
you have.

Convention is to not have brackets around defined constants.
They should be added in the code where necessary...

If you have bitmasks (e.g. INV_TAP_AXIS_X etc) use BIT(n) to
specify the bits. It's easier to read.

Function naming could be more consistent in form. There are some
random mpu functions in amongst all the inv_ ones.

Need to think very very hard about whether it is possible to have
the slave i2c busses registered as i2c busses under linux.  Having
two copies of every driver is not going to go down well.  Having
extra bits where you need them in standard drivers is far more likely
to be accepted.  I know this is going to be tricky but we really really
don't want that code duplication.


This crossed with your email (I've been looking at this during 'compile'
breaks during the day...) I'll take a look at your patch over the next
few days.

Jonathan

> 
> Best regards,
> 
> Ge GAO
> 
> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: Monday, May 14, 2012 10:30 AM
> To: Ge Gao
> Cc: Jonathan Cameron; linux-iio@vger.kernel.org
> Subject: Re: trigger removal problem.
> 
> On 05/14/2012 05:54 PM, Ge Gao wrote:
>> It is about 7000 lines. It contains seven ".c" files and three ".h"
> files.
>> This is a driver that can drive all invensense MPU chips(MPU3500,
>> MPU3050, MPU6050, MPU9150) and support all the features of the chip.
> Cool. Sounds like quite a beast ;)
> 
> Ideal would be to introduce the driver as a number of patches, but if that
> really isn't possible see whether you will break the vger.kernel.org limit
> of 100,000 characters.
> 
> Another option is to attach it as a patch file, but that tends to reduce
> the number of people who take a look drastically!
> 
> If you want to send me a copy of the raw patch I'd be happy to advise on
> whether it can be sensibly broken up into smaller parts.  I'll only do a
> formal review once it is on the list though!
> 
> Jonathan
>>
>> Ge
>>
>>
>> -----Original Message-----
>> From: Jonathan Cameron [mailto:jic23@kernel.org]
>> Sent: Saturday, May 12, 2012 1:58 AM
>> To: Ge Gao
>> Cc: Jonathan Cameron; linux-iio@vger.kernel.org
>> Subject: Re: trigger removal problem.
>>
>> On 05/11/2012 06:45 PM, Ge Gao wrote:
>>> I found that if I write "NULL" to the "current_trigger", it will not
>>> be able to be removed. However, if I write a valid trigger name, such
>>> as the one in my driver code, it can be removed. Looks strange. But
>>> solve the problem anyway.
>>> I actually want to submit my driver code to you. However, it is
>>> pretty big(it supports all invensense sensors, which are similar but
>>> some differences still). Is that possible I package the code and send
>>> it directly?
>> Much better to do it as an inline patch in an email if you can.
>>
>> Attachements are just about alright if you really can't do that.
>> Just how many lines of code are we talking?
>>
>>
>>> Thanks for your help.
>>>
>>> Ge
>>>
>>>
>>> -----Original Message-----
>>> From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
>>> Sent: Friday, May 11, 2012 12:40 AM
>>> To: Ge Gao
>>> Cc: linux-iio@vger.kernel.org
>>> Subject: Re: trigger removal problem.
>>>
>>> On 5/11/2012 12:53 AM, Ge Gao wrote:
>>>> Dear all,
>>>>
>>>>                  I am building my IIO driver as a module and will
>>>> constantly need to use "insmod" and "rmmod" to install it and remove
>>>> it due to development. However, I found that if I write anything to
>>>> the "trigger/current_trigger", it will not be able to remove it. The
>>>> error code is (11). Even I write "null" to it, it will not be able
>>>> to be removed.
>>>> However, If I don't write anything to it, just insmod and rmmod, it
>>>> will be remove successfully. Any idea what could cause this problem?
>>>> I followed what is in the IIO subsystem driver to write my driver. I
>>>> can post it if anyone want to take a look.
>>> Hi Ge,
>>>
>>> I'm afraid I won't be able to do any testing until at least tomorrow.
>>> There are a few things that could give more information though in the
>>> meantime:
>>>
>>> * Could you try the above, but note down the reference counts that
>>> lsmod will give you for the various drivers at each step of the
>>> process. (before connecting the trigger, whilst it is connected and
>>> upon
>> disconnecting).
>>>
>>> * Is there anything left when you read 'current_trigger' after
>>> writing an invalid name to it?
>>>
>>> *  Are you using an existing trigger or is it also part of you driver?
>>>
>>> Having the source code when I dig futher into this would also be
>> helpful.
>>>
>>> Anyone else seen anything similar?  I haven't run any removal
>>> hammering tests for a month or so, so something might have slipped
>>> into
>> the core...
>>>
>>> Jonathan
>>>>
>>>>                  Thanks.
>>>>
>>>>
>>>>
>>>> Ge
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>>> info at  http://vger.kernel.org/majordomo-info.html
