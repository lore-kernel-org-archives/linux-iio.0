Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-207.synserver.de ([212.40.185.207]:1254 "EHLO
	smtp-out-207.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756101AbaJ2Sa3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Oct 2014 14:30:29 -0400
Message-ID: <54513238.6050903@metafoo.de>
Date: Wed, 29 Oct 2014 19:30:16 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
CC: linux-iio@vger.kernel.org
Subject: Re: Kernel wishlist item: Better IIO API
References: <1414593052.2406.37.camel@hadess.net>		 <5451221D.6000301@metafoo.de> <1414604035.2406.41.camel@hadess.net>	 <54512640.3040505@metafoo.de> <1414604840.2406.43.camel@hadess.net>
In-Reply-To: <1414604840.2406.43.camel@hadess.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/2014 06:47 PM, Bastien Nocera wrote:
> On Wed, 2014-10-29 at 18:39 +0100, Lars-Peter Clausen wrote:
>> On 10/29/2014 06:33 PM, Bastien Nocera wrote:
>>> On Wed, 2014-10-29 at 18:21 +0100, Lars-Peter Clausen wrote:
>>>> On 10/29/2014 03:30 PM, Bastien Nocera wrote:
>>>>> Hey,
>>>>>
>>>>> I've posted this a couple of days ago:
>>>>> http://www.hadess.net/2014/10/a-gnome-kernel-wishlist.html
>>>>> along with a mail to LKML:
>>>>> http://thread.gmane.org/gmane.linux.kernel/1810083
>>>>>
>>>>> I've recently added to my list an item about IIO:
>>>>> https://wiki.gnome.org/BastienNocera/KernelWishlist
>>>>>
>>>>> Are there any plans for a better API for the IIO subsystem? The API
>>>>> might be good enough to drive from shell scripts, or helpers that only
>>>>> need to work with one variant of a device, but my attempts at trying to
>>>>> use the IIO subsystem to provide an accelerometer to do automatic
>>>>> display rotation[1] showed that the API is really cumbersome.
>>>>>
>>>>> The code I wrote spends most of its time creating sysfs paths, reading
>>>>> values in different formats, and mangling filenames[2].
>>>>>
>>>>> Is an ioctl-based API planned? Something where I could get/set
>>>>> structures to gather metadata about the device, and set it up easily, so
>>>>> reading data from it is easier?
>>>>
>>>> No, unfortunately not and I'm not sure if such a ABI would be accepted if
>>>> proposed.
>>>
>>> Why not?
>>
>> Because it means there will be ambiguity in the API on how to do things.
>> Which is typically not a desired property.
>>
>>>
>>>> But checkout libiio[1][2], it hides the details of the sysfs file manipulation.
>>>
>>> I'm not sure that's any better unfortunately. I've certainly tried to do
>>> that already in my code, but that doesn't change that the user-space API
>>> is barely usable.
>>
>> It's not completely unusable ;)
>
> In the end, you prefer the "self-documenting" of using sysfs files,
> rather than an API which you can document in a header file?

If it was for me we'd be using a state-full IOCTL ABI rather than a 
stateless sysfs ABI. I'm definitely not happy with the current interface, 
but it's the interface we have. But the problem with userspace ABI (in 
comparison to in-kernel API) is that we can just change things at random, 
but we have to stick with the existing interface.

The sysfs ABI is not meant to be self documenting and it is not 
undocumented. The documentation for the different attributes can be found in 
Documentation/ABI/testing/sysfs-bus-iio[1].

>
> I don't understand that. My questions on this very mailing-list, and
> comments that were made to users of my code[1] clearly show that the
> existing API is anything but "not ambiguous".

That bug report sounds like bugs in the driver.

>
> I've used the Bluetooth, input, rfkill, and inotify APIs as provided
> directly by the Linux kernel (not through a layer) and they're of better
> quality than the IIO one.
>
> I just don't see how one could support a class of IIO sensors with the
> existing API.

I can understand your frustration. A API that is not usable in a generic way 
is not really useful. So we should try to fix that, but we are bound by the 
framework itself and can't just throw everything away.

So lets start by trying to identify what is missing. Which information do 
you think could be provided by using a IOCTL interface which you need or 
want which is not provided by the current sysfs interface or can not be 
provided by the current sysfs interface.

- Lars

[1] 
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-bus-iio
