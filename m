Return-Path: <jic23@kernel.org>
Message-ID: <4FB1412D.5020908@kernel.org>
Date: Mon, 14 May 2012 18:30:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Ge Gao <ggao@invensense.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: trigger removal problem.
References: <dca0c620c60e1144778bfea74da1336b@mail.gmail.com> <4FACC265.4000408@cam.ac.uk> <26bba6e6470eba82ab34f37d5a7a69da@mail.gmail.com> <4FAE2635.5090604@kernel.org> <db7757fa754546d268093a0c8df8528f@mail.gmail.com>
In-Reply-To: <db7757fa754546d268093a0c8df8528f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/14/2012 05:54 PM, Ge Gao wrote:
> It is about 7000 lines. It contains seven ".c" files and three ".h" files.
> This is a driver that can drive all invensense MPU chips(MPU3500, MPU3050,
> MPU6050, MPU9150) and support all the features of the chip.
Cool. Sounds like quite a beast ;)

Ideal would be to introduce the driver as a number of patches, but if
that really isn't possible see whether you will break the
vger.kernel.org limit of 100,000 characters.

Another option is to attach it as a patch file, but that tends to reduce
the number of people who take a look drastically!

If you want to send me a copy of the raw patch I'd be happy to advise
on whether it can be sensibly broken up into smaller parts.  I'll only
do a formal review once it is on the list though!

Jonathan
> 
> Ge
> 
> 
> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: Saturday, May 12, 2012 1:58 AM
> To: Ge Gao
> Cc: Jonathan Cameron; linux-iio@vger.kernel.org
> Subject: Re: trigger removal problem.
> 
> On 05/11/2012 06:45 PM, Ge Gao wrote:
>> I found that if I write "NULL" to the "current_trigger", it will not
>> be able to be removed. However, if I write a valid trigger name, such
>> as the one in my driver code, it can be removed. Looks strange. But
>> solve the problem anyway.
>> I actually want to submit my driver code to you. However, it is pretty
>> big(it supports all invensense sensors, which are similar but some
>> differences still). Is that possible I package the code and send it
>> directly?
> Much better to do it as an inline patch in an email if you can.
> 
> Attachements are just about alright if you really can't do that.
> Just how many lines of code are we talking?
> 
> 
>> Thanks for your help.
>>
>> Ge
>>
>>
>> -----Original Message-----
>> From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
>> Sent: Friday, May 11, 2012 12:40 AM
>> To: Ge Gao
>> Cc: linux-iio@vger.kernel.org
>> Subject: Re: trigger removal problem.
>>
>> On 5/11/2012 12:53 AM, Ge Gao wrote:
>>> Dear all,
>>>
>>>                  I am building my IIO driver as a module and will
>>> constantly need to use "insmod" and "rmmod" to install it and remove
>>> it due to development. However, I found that if I write anything to
>>> the "trigger/current_trigger", it will not be able to remove it. The
>>> error code is (11). Even I write "null" to it, it will not be able to
>>> be removed.
>>> However, If I don't write anything to it, just insmod and rmmod, it
>>> will be remove successfully. Any idea what could cause this problem?
>>> I followed what is in the IIO subsystem driver to write my driver. I
>>> can post it if anyone want to take a look.
>> Hi Ge,
>>
>> I'm afraid I won't be able to do any testing until at least tomorrow.
>> There are a few things that could give more information though in the
>> meantime:
>>
>> * Could you try the above, but note down the reference counts that
>> lsmod will give you for the various drivers at each step of the
>> process. (before connecting the trigger, whilst it is connected and upon
> disconnecting).
>>
>> * Is there anything left when you read 'current_trigger' after writing
>> an invalid name to it?
>>
>> *  Are you using an existing trigger or is it also part of you driver?
>>
>> Having the source code when I dig futher into this would also be
> helpful.
>>
>> Anyone else seen anything similar?  I haven't run any removal
>> hammering tests for a month or so, so something might have slipped into
> the core...
>>
>> Jonathan
>>>
>>>                  Thanks.
>>>
>>>
>>>
>>> Ge
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
