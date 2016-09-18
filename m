Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51758 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932228AbcIRTcL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2016 15:32:11 -0400
Subject: Re: accelerometer orientation
To: Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>, linux-iio@vger.kernel.org
References: <0b744f22-55c0-da22-b27f-6092aab18365@redhat.com>
 <1473694755.6389.2.camel@hadess.net>
 <761fcac8-c7c8-0745-d8e8-f70fbb82451c@redhat.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ae45d121-d91c-2566-7ec7-0eb7bcab88ca@kernel.org>
Date: Sun, 18 Sep 2016 20:32:07 +0100
MIME-Version: 1.0
In-Reply-To: <761fcac8-c7c8-0745-d8e8-f70fbb82451c@redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/09/16 17:15, Hans de Goede wrote:
> Hi,
> 
> On 12-09-16 17:39, Bastien Nocera wrote:
>> Hey,
>>
>> On Mon, 2016-09-12 at 17:25 +0200, Hans de Goede wrote:
>>> Hi Bastien,
>>>
>>> So as I guess you sorta know in my spare time I work on Linux
>>> (mainline) support for Allwinner SoC based ARM devices, including
>>> a whole lot of cheap Chinese tablets.
>>>
>>> Recently I've begun looking into supporting the accelerometers
>>> on these devices and I'm making good progress on getting the
>>> kernel bits working using iio drivers (including a few new
>>> ones I've written recently).
>>>
>>> Yesterday I realized there is a bit of a catch though, all
>>> these iio drivers report results assuming that the accelerometer
>>> is mounted on the top side of the PCB and with its X/Y
>>> coordination properly taken info account.
>>>
>>> Unfortunately neither is necessarily true. Almost all
>>> tablet PCBS are mounted upside down (with an empty PCB
>>> backside against the lcd-panel. Meaning that the Z axis
>>> reads -1G when the tablet is lying on its back instead
>>> of the expected +1G and some need X/Y axis swapping and/or
>>> inversion too.
>>>
>>> So there are 3 problems here:
>>>
>>> 1) Where do we store the orientation of the chip
>>>
>> <snip>
>>> 2) Where do we correct the readings for the orientation
>> <snip>
>>> 3) Currently implementing orientation support in an iio driver
>>> requires copy and pasting quite a bit of boiler plate, so
>>> a question to the linux-iio list, has anyone though of an
>>> easier way to do this. I really just want to be able to
>>> pass say a single flag to iio_device_register and then
>>> have the iio-core automatically call of_iio_read_mount_matrix()
>>> and add mount_matrix ext_info.
Hmm. Whilst it all seems simple, that flag is going to be
non trivial.  There are too many 'sensible' options and in compact
devices event aligning with axes doesn't always happen.

Might be room for a some utility functions to reduced boiler plate
though.
>>
>> All good ideas, but we need a way to do this for devices without DT
>> (meaning all of the x86 tablets).
> 
> Yes, so I've also been working on a touchscreen driver for silead
> touchscreen controllers (the gsl1680 and compatibles), which has
> the same problem, e.g. it needs tablet model specific firmware,
> so we need to provide a per tablet firmware name, and also
> things like resolution and orientation are different per model
> tablet. I now have 2 x86 tablets with such touchscreens, my plan
> for the silead driver is to use dmi info to identify the tablet
> and have a tablet with per tablet info inside the driver, this
> is not so easy to extend as the udev hw db, but in this case
> the info is needed inside the actual driver for things to work
> properly.
Why?  Seems to me that there ought to be somewhere to massage
that data on it's path from kernel to anywhere useful...
> 
>> Perhaps iio-sensor-proxy could read from udev instead, and udev either
>> pull from DT when available, or apply from its own rules?
> 
> Directly pulling from dt is not really convenient and iio
> already more or less has standardized on the mount_matrix
> sysfs attribute. I think it might be best to make the
> mount_matrix sysfs attribute writable and then udev can
> write the correct settings there for x86 tablets at
> least. So to any iio devs reading this thread:
> would making the mount_matrix sysfs attribute writable
> be an acceptable solution ?
It's really ugly to push data into the kernel just in order
to be able to read it directly out of the same interface.

My gut reaction to this is that we need something in between
in user space which can 'massage' the mount matrix as it
sees fit.

Should be possible to get udev to feed back the mount matrix
if present I think... Udev not something I like
to go near (or have in fact gone near in many years).

Jonathan
> 
> Regards,
> 
> Hans
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

