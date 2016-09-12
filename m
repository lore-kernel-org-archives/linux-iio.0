Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751724AbcILQPj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Sep 2016 12:15:39 -0400
Subject: Re: accelerometer orientation
To: Bastien Nocera <hadess@hadess.net>, linux-iio@vger.kernel.org
References: <0b744f22-55c0-da22-b27f-6092aab18365@redhat.com>
 <1473694755.6389.2.camel@hadess.net>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <761fcac8-c7c8-0745-d8e8-f70fbb82451c@redhat.com>
Date: Mon, 12 Sep 2016 18:15:35 +0200
MIME-Version: 1.0
In-Reply-To: <1473694755.6389.2.camel@hadess.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 12-09-16 17:39, Bastien Nocera wrote:
> Hey,
>
> On Mon, 2016-09-12 at 17:25 +0200, Hans de Goede wrote:
>> Hi Bastien,
>>
>> So as I guess you sorta know in my spare time I work on Linux
>> (mainline) support for Allwinner SoC based ARM devices, including
>> a whole lot of cheap Chinese tablets.
>>
>> Recently I've begun looking into supporting the accelerometers
>> on these devices and I'm making good progress on getting the
>> kernel bits working using iio drivers (including a few new
>> ones I've written recently).
>>
>> Yesterday I realized there is a bit of a catch though, all
>> these iio drivers report results assuming that the accelerometer
>> is mounted on the top side of the PCB and with its X/Y
>> coordination properly taken info account.
>>
>> Unfortunately neither is necessarily true. Almost all
>> tablet PCBS are mounted upside down (with an empty PCB
>> backside against the lcd-panel. Meaning that the Z axis
>> reads -1G when the tablet is lying on its back instead
>> of the expected +1G and some need X/Y axis swapping and/or
>> inversion too.
>>
>> So there are 3 problems here:
>>
>> 1) Where do we store the orientation of the chip
>>
> <snip>
>> 2) Where do we correct the readings for the orientation
> <snip>
>> 3) Currently implementing orientation support in an iio driver
>> requires copy and pasting quite a bit of boiler plate, so
>> a question to the linux-iio list, has anyone though of an
>> easier way to do this. I really just want to be able to
>> pass say a single flag to iio_device_register and then
>> have the iio-core automatically call of_iio_read_mount_matrix()
>> and add mount_matrix ext_info.
>
> All good ideas, but we need a way to do this for devices without DT
> (meaning all of the x86 tablets).

Yes, so I've also been working on a touchscreen driver for silead
touchscreen controllers (the gsl1680 and compatibles), which has
the same problem, e.g. it needs tablet model specific firmware,
so we need to provide a per tablet firmware name, and also
things like resolution and orientation are different per model
tablet. I now have 2 x86 tablets with such touchscreens, my plan
for the silead driver is to use dmi info to identify the tablet
and have a tablet with per tablet info inside the driver, this
is not so easy to extend as the udev hw db, but in this case
the info is needed inside the actual driver for things to work
properly.

> Perhaps iio-sensor-proxy could read from udev instead, and udev either
> pull from DT when available, or apply from its own rules?

Directly pulling from dt is not really convenient and iio
already more or less has standardized on the mount_matrix
sysfs attribute. I think it might be best to make the
mount_matrix sysfs attribute writable and then udev can
write the correct settings there for x86 tablets at
least. So to any iio devs reading this thread:
would making the mount_matrix sysfs attribute writable
be an acceptable solution ?

Regards,

Hans
