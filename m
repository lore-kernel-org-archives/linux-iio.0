Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34776 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422642AbcIYIbo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Sep 2016 04:31:44 -0400
Subject: Re: accelerometer orientation
To: Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>, linux-iio@vger.kernel.org,
        Patrick Porlan <patrick.porlan@intel.com>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>
References: <0b744f22-55c0-da22-b27f-6092aab18365@redhat.com>
 <1473694755.6389.2.camel@hadess.net>
 <761fcac8-c7c8-0745-d8e8-f70fbb82451c@redhat.com>
 <ae45d121-d91c-2566-7ec7-0eb7bcab88ca@kernel.org>
 <52f0fe9b-ad0c-aa32-861c-e187de825288@redhat.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4b231b53-03a0-784a-8582-36f14c7c4557@kernel.org>
Date: Sun, 25 Sep 2016 09:31:41 +0100
MIME-Version: 1.0
In-Reply-To: <52f0fe9b-ad0c-aa32-861c-e187de825288@redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/09/16 15:14, Hans de Goede wrote:
> Hi,
> 
> On 18-09-16 21:32, Jonathan Cameron wrote:
>> On 12/09/16 17:15, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 12-09-16 17:39, Bastien Nocera wrote:
>>>> Hey,
>>>>
>>>> On Mon, 2016-09-12 at 17:25 +0200, Hans de Goede wrote:
>>>>> Hi Bastien,
>>>>>
>>>>> So as I guess you sorta know in my spare time I work on Linux
>>>>> (mainline) support for Allwinner SoC based ARM devices, including
>>>>> a whole lot of cheap Chinese tablets.
>>>>>
>>>>> Recently I've begun looking into supporting the accelerometers
>>>>> on these devices and I'm making good progress on getting the
>>>>> kernel bits working using iio drivers (including a few new
>>>>> ones I've written recently).
>>>>>
>>>>> Yesterday I realized there is a bit of a catch though, all
>>>>> these iio drivers report results assuming that the accelerometer
>>>>> is mounted on the top side of the PCB and with its X/Y
>>>>> coordination properly taken info account.
>>>>>
>>>>> Unfortunately neither is necessarily true. Almost all
>>>>> tablet PCBS are mounted upside down (with an empty PCB
>>>>> backside against the lcd-panel. Meaning that the Z axis
>>>>> reads -1G when the tablet is lying on its back instead
>>>>> of the expected +1G and some need X/Y axis swapping and/or
>>>>> inversion too.
>>>>>
>>>>> So there are 3 problems here:
>>>>>
>>>>> 1) Where do we store the orientation of the chip
>>>>>
>>>> <snip>
>>>>> 2) Where do we correct the readings for the orientation
>>>> <snip>
>>>>> 3) Currently implementing orientation support in an iio driver
>>>>> requires copy and pasting quite a bit of boiler plate, so
>>>>> a question to the linux-iio list, has anyone though of an
>>>>> easier way to do this. I really just want to be able to
>>>>> pass say a single flag to iio_device_register and then
>>>>> have the iio-core automatically call of_iio_read_mount_matrix()
>>>>> and add mount_matrix ext_info.
>> Hmm. Whilst it all seems simple, that flag is going to be
>> non trivial.  There are too many 'sensible' options
> 
> The flag is not there to provide all the options, it is just
> there to tell the core to call of_iio_read_mount_matrix()
> and if that returns an non default matrix then add the
> mount_matrix ext_info.
> 
> So it would really be just a boolean.
It would save some boiler plate but ultimately not that much at
the cost of a lot of churn.  I'm unconvinced it's worth doing.
> 
>> and in compact
>> devices event aligning with axes doesn't always happen.
>>
>> Might be room for a some utility functions to reduced boiler plate
>> though.
>>>>
>>>> All good ideas, but we need a way to do this for devices without DT
>>>> (meaning all of the x86 tablets).
>>>
>>> Yes, so I've also been working on a touchscreen driver for silead
>>> touchscreen controllers (the gsl1680 and compatibles), which has
>>> the same problem, e.g. it needs tablet model specific firmware,
>>> so we need to provide a per tablet firmware name, and also
>>> things like resolution and orientation are different per model
>>> tablet. I now have 2 x86 tablets with such touchscreens, my plan
>>> for the silead driver is to use dmi info to identify the tablet
>>> and have a tablet with per tablet info inside the driver, this
>>> is not so easy to extend as the udev hw db, but in this case
>>> the info is needed inside the actual driver for things to work
>>> properly.
>> Why?  Seems to me that there ought to be somewhere to massage
>> that data on it's path from kernel to anywhere useful...
> 
> Well for one the touchscreen controller needs to be initialized
> with a digitizer specific firmware file and since we want to
> be able to habe say a single usb live image with multiple x86
> work on multiple tablets that means specifying a tablet specific
> firmware file-name to pass to the in-kernel firmware loader.
> 
> An other issue is that there are multiple consumers of the kernel
> evdev interface and they all expect evdev events to be ready
> to use and not require more processing (other then maybe applying
> a calibration matrix on resistive touchscreens).
> 
>>>
>>>> Perhaps iio-sensor-proxy could read from udev instead, and udev either
>>>> pull from DT when available, or apply from its own rules?
>>>
>>> Directly pulling from dt is not really convenient and iio
>>> already more or less has standardized on the mount_matrix
>>> sysfs attribute. I think it might be best to make the
>>> mount_matrix sysfs attribute writable and then udev can
>>> write the correct settings there for x86 tablets at
>>> least. So to any iio devs reading this thread:
>>> would making the mount_matrix sysfs attribute writable
>>> be an acceptable solution ?
>> It's really ugly to push data into the kernel just in order
>> to be able to read it directly out of the same interface.
> 
> That is actually exactly what evdev is doing, e.g. for ps/2
> keyboards the non standardized keycodes for e.g. brightness
> hotkeys on laptops are read from a laptop specific udev hwdb
> entry and then loaded into the kernels scancode to evdev button
> code table for the ps/2 keyboard evdev device.
> 
> Likewise hwdb may be used to adjust to the abs axis min/max values
> reported by touchpads since some touchpads lie about these
> (both under and over reporting of the range happens).
> 
>> My gut reaction to this is that we need something in between
>> in user space which can 'massage' the mount matrix as it
>> sees fit.
> 
> Well we've 2 paths we're walking here, one which already
> has been established is the mount-matrix sits in dt, gets
> read by of_iio_read_mount_matrix() and then exported as
> a mount_matrix sysfs attribute. The other is a yet to be
> designed path for x86+efi/acpi devices which we are
> discussing now. IMHO it would be good to present the
> same interface to userspace for both paths.
> 
> And as my evdev examples show there us precedence
> for loading such info from userspace into the kernel
> for hw where it is inconvenient for the kernel to get
> the info itself. The writing would of course be a root-only
> thing.
Good examples, I'm coming round to thinking having this
writeable would not be too bad.  Cc'd a few of the intel
guys doing the android HAL stuff for more feedback on this.
> 
>> Should be possible to get udev to feed back the mount matrix
>> if present I think... Udev not something I like
>> to go near (or have in fact gone near in many years).
> 
> Using an udev attribute definitely is an option here and udev
> needs to be involved on x86 one way or the other anyways, but
> I would like to keep udev out of the dt path since it is not
> necessary there.
Hmm. Udev to write or udev on the read path.  Not an obvious
choice really.  
> 
> Regards,
> 
> Hans

