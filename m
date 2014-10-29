Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-207.synserver.de ([212.40.185.207]:1037 "EHLO
	smtp-out-207.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbaJ2RjY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Oct 2014 13:39:24 -0400
Message-ID: <54512640.3040505@metafoo.de>
Date: Wed, 29 Oct 2014 18:39:12 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
CC: linux-iio@vger.kernel.org
Subject: Re: Kernel wishlist item: Better IIO API
References: <1414593052.2406.37.camel@hadess.net>	 <5451221D.6000301@metafoo.de> <1414604035.2406.41.camel@hadess.net>
In-Reply-To: <1414604035.2406.41.camel@hadess.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/2014 06:33 PM, Bastien Nocera wrote:
> On Wed, 2014-10-29 at 18:21 +0100, Lars-Peter Clausen wrote:
>> On 10/29/2014 03:30 PM, Bastien Nocera wrote:
>>> Hey,
>>>
>>> I've posted this a couple of days ago:
>>> http://www.hadess.net/2014/10/a-gnome-kernel-wishlist.html
>>> along with a mail to LKML:
>>> http://thread.gmane.org/gmane.linux.kernel/1810083
>>>
>>> I've recently added to my list an item about IIO:
>>> https://wiki.gnome.org/BastienNocera/KernelWishlist
>>>
>>> Are there any plans for a better API for the IIO subsystem? The API
>>> might be good enough to drive from shell scripts, or helpers that only
>>> need to work with one variant of a device, but my attempts at trying to
>>> use the IIO subsystem to provide an accelerometer to do automatic
>>> display rotation[1] showed that the API is really cumbersome.
>>>
>>> The code I wrote spends most of its time creating sysfs paths, reading
>>> values in different formats, and mangling filenames[2].
>>>
>>> Is an ioctl-based API planned? Something where I could get/set
>>> structures to gather metadata about the device, and set it up easily, so
>>> reading data from it is easier?
>>
>> No, unfortunately not and I'm not sure if such a ABI would be accepted if
>> proposed.
>
> Why not?

Because it means there will be ambiguity in the API on how to do things. 
Which is typically not a desired property.

>
>> But checkout libiio[1][2], it hides the details of the sysfs file manipulation.
>
> I'm not sure that's any better unfortunately. I've certainly tried to do
> that already in my code, but that doesn't change that the user-space API
> is barely usable.

It's not completely unusable ;)

- Lars
