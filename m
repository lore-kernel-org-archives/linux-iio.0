Return-Path: <gmane@reliableembeddedsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 04 Apr 2014 08:59:00 -0500
From: gmane@reliableembeddedsystems.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Zubair Lutfullah :" <zubair.lutfullah@gmail.com>,
 <linux-iio@vger.kernel.org>
Subject: Re: iio on beagle bone black 3.13.6 kernel
In-Reply-To: <532F3724.3020302@kernel.org>
References: <be30164b26d247c2576ba7369032bc23@reliableembeddedsystems.com>
 <532F1DE0.9090908@kernel.org> <20140323185446.GA2485@gmail.com>
 <532F3724.3020302@kernel.org>
Message-ID: <6cc8bbd3474d7c20df8d7901add9412e@reliableembeddedsystems.com>
List-ID: <linux-iio@vger.kernel.org>

Hi,

On 2014-03-23 14:33, Jonathan Cameron wrote:
> On 23/03/14 18:54, Zubair Lutfullah : wrote:
>> On Sun, Mar 23, 2014 at 05:46:08PM +0000, Jonathan Cameron wrote:
>>> On 22/03/14 17:19, gmane@reliableembeddedsystems.com wrote:
>>>> Hi,
>>>> 
>>>> I use a beagle bone black with a 3.13.6 kernel and would like to 
>>>> get the
>>>> ./generic_buffer test which comes with the kernel to work.
>>>> 
>>>> This is what I do:
>>>> 
>>>> echo 1 > /sys/bus/iio/devices/iio_sysfs_trigger/add_trigger
>>>> 
>>>> ls /sys/bus/iio/devices/
>>>> iio:device0  iio_sysfs_trigger  trigger0
>>>> 
>>>> cat /sys/bus/iio/devices/trigger0/name
>>>> sysfstrig1
>>>> 
>>>> echo 1 > 
>>>> /sys/bus/iio/devices/iio:device0/scan_elements/in_voltage5_en
>>>> 
>>>> 
>>>> ./generic_buffer.out -n TI-am335x-adc -t sysfstrig1 -l 128
>>>> iio device number being used is 0
>>>> iio trigger number being used is 0
>>>>   sysfstrig1
>>>> ---> Could not open /trigger/current_trigger
>>>> Failed to write current_trigger file
>>>> 
>>>> How can I get rid of this?
>>>> 
>>>> Is this a problem with my driver, or should I just create this 
>>>> magic
>>>> file somewhere?
>>> Does /sys/bus/iio/device/iio:device0/trigger/current_trigger exist?
>>> If so, try
>>> echo sysfstrig1 > 
>>> /usys/bus/iio/device/iio:device0/trigger/current_trigger
>>> and see if that gives an error or not, then cat the same file to see 
>>> if
>>> it 'took'.
>>> 
>>> Otherwise, I'm not sure...
>>> 
>>> Zubair, any thoughts?
>>> 
>> 
>> I thought we removed trigger from this driver for using continuous 
>> sampling.
>> It was a hardware buffer driver with not proper support in 
>> generic_buffer.c
> Good point.  I have a mind like a sieve sometimes :)

This might explain my issues ;)

>> 
>> For one-shot sampling you just cat 
>> /sys/bus/iio/devices/iio:device0/channel etc.

As far as I remember this works.

>> For continuous sampling, modify generic_buffer.c to remove trigger 
>> checks.

I will have a look at the code and will try to understand what you are 
talking about ;)

>> 
>> Could you please tell me where you got this driver? It shouldn't be 
>> in any tree..
> From the email I suspect he's using your mainlined driver, but without 
> the
> generic_buffer.c changes (as you never sent them out, *hint*)

I would assume this is mainline and also the generic_buffer.c is from 
the same mainline kernel.

To be exact:

kernel:
3.13.6 stable

patches:
https://github.com/RobertBerger/meta-mainline/blob/dora-training-v3.13.x/beagle-bone-black-ml/recipes-kernel/linux/linux-yocto-custom/beagle-bone-black-ml-user-patches.scc

(which should not affect iio)

BTW:

This (your) reply email does not show up in Gmane[1] for some strange 
reason, hence my late reply and the additional post [2] (where replies 
seem to work)

[1] http://thread.gmane.org/gmane.linux.kernel.iio/11631
[2] http://thread.gmane.org/gmane.linux.kernel.iio/11673
>> 
>> Regards
>> ZubairLK
>> 

Regards,

Robert
