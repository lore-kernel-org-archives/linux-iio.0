Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:42582 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515Ab0H0OUA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Aug 2010 10:20:00 -0400
Message-ID: <4C77CA90.2030806@cam.ac.uk>
Date: Fri, 27 Aug 2010 15:24:16 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	"Song, Barry" <Barry.Song@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"uclinux-dist-devel@blackfin.uclinux.org"
	<uclinux-dist-devel@blackfin.uclinux.org>
Subject: Re: [IIO] Cleanup userspace
References: <4C777E16.6040708@iis.fraunhofer.de> <4C77AC01.3090204@cam.ac.uk> <4C77B68B.4060805@iis.fraunhofer.de>
In-Reply-To: <4C77B68B.4060805@iis.fraunhofer.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Manuel,
> 
> Am 27.08.2010 14:13, schrieb Jonathan Cameron:
>>>
>>> The points I'd like to clean up are:
>>> - We currently have plenty of (optional) information per channel:
>>>    * the raw value
>>>    * an offset and scale to apply in user software
>>>    * calibration offset and gain applied in the device
>>>    * enable and bit size (not implemented yet) in the ring buffer
>>>
>>>    Should we put all that stuff into a channel directory?
>>>    |- /sys/bus/iio/device0/accel_x/
>>>       |- raw_value
>>>       |- offset
>>>       |- scale
>>>       |- calib_offset
>>>       |- calib_scale
>> Maybe...
>>
>> The disadvantages are:
>> * Breaks the abi compatibility we have been trying to maintain with hwmon.
>> * Lots more attribute groups (actually this is an advantage in some places where
>>    we have a driver covering devices with different numbers of channels)
>> * Cannot share attributes of the above types - e.g. often the offset and scale
>>    apply to all channels.  The abi allows this to be specified by a single attribute.
>>    It also allows say all acceleration offsets to be given by simply accel_offset.
> Actually we still could have these shared files or a shared directory:
>     |- /sys/bus/iio/device0/accel/
>        |- offset
>        |- scale
>     |- /sys/bus/iio/device0/accel_x/
>        |- raw_value
>     |- /sys/bus/iio/device0/accel_y/
>        |- raw_value
> 
> Not that nice, I have to agree. Another idea would be to use some other separator, like ':'. Then it's also clear for the human user, what's the name and what's the postfix:
>     |- /sys/bus/iio/device0/accel_x:raw
>     |- /sys/bus/iio/device0/accel_x:offset
>     |- /sys/bus/iio/device0/accel_x:scale
That would be nice, but breaks with hwmon style...  Given average user is going to be using your tools anyway
I don't think this being that readable is critical.
> 
> 
>> Advantages:
>> * It looks nicer to a human reader. (though anyone can deploy "ls *accel_x*" to get much the same.
>> * Possibly some minor simplifications in library code. (fairly trivial I would expect?)
> 
> Yes, that's not too complicated now. We just have to define the postfixes somewhere. Right now, adis16400 uses _offset for the internal calibration offset and _scale for user space scaling.
> 
>> Note that a similar level of complexity exists for the event interfaces.
>> ..zip..
> 
> I'm not so familiar with the event stuff, but I don't think we need
> to make it consistent, if there are different arguments for the one
> or the other solution. Yet we should use the same seperator, so if we
> switch to ':' in the channels, we should also switch in the event
> interface.
Firstly, the situation is so similar I think we would need to change both
just to avoid confusion from anyone looking at the files.  Also I'd imagine
it will allow some code to be shared in the userspace utils.

Second, I still think the issues with breaking hwmon consistency make this a bad idea
(and that stuff is from Greg KH + I think Andrew Morton is in favour of such unifying
based on discussions elswhere)  Keep both of them happy is going to make our eventual
move out of staging easier.
> 
> 
>>>    The enable and bit size are maybe buffer specific and could go
>>>    into the buffer directory.
>> We could do this now I guess (couldn't before the max1363 was switched to the current abi)
>>
>> As things currently stand these are in iio:device[n]/scan_elements. I guess we could move
>> them into iio:device[n]/buffer0  It is a bit of a pain in code as the buffer directory is
>> completely managed by the buffer implementation rather than the driver. Still I guess this
>> could be passed to the buffer initialization code.  Things are a bit tricky as there are
>> other attributes caused by the buffer it self. It cleans up the abi at the cost of further
>> messing up the separation between buffer implementation and device driver and some complexity
>> in driver.  It would be easier to move the scan_elements directory into the buffer directory?
>> Perhaps that is the better option?
>> What do others think on this?
> 
> I have no problem with moving the whole directory.
Cool.  I'll have a look to see how clean we can make the move.  It is going to break
a lot of drivers in the Analog devices tree so it might be worth delaying it for now
(perhaps updating the abi and saying the old location is deprecated).
> 
>>> - The trigger is also an iio device so I'd prefer to have:
>>>    |- /sys/bus/iio/iio0 (can be empty, if it's a pure trigger)
>>>    |- /sys/bus/iio/iio0:trigger0
>> I did think about this one (note it was marked as to be considered in the last abi
>> discussion). The only reason to have the iio0 directory is if it tells us
>> something.  Currently the iio:device0 is the top level device.
>> Is your intent that iio0 will have children of iio0:device0 and iio0:trigger0 etc?
>> Thus it won't be empty under any circumstances. It will always contain at least
>> iio0:device0 or iio0:trigger0
> 
> I just thought of renaming device<n> to iio<n> but we can also move the whole device directory. In 'lsiio' I have a structure like:
Ah, fair enough. Ah. I see you proposed the name change in a previous email to the list.  Sorry
as stated below my subscription clearly died for a few days! To what you state there I'd
rather we just added iio: to the beginning of all the naming. 

The question that arises is whether triggers and the base device should be at the same
level as it is perfectly possible to have a driver implementing one and not the other.
Perhaps we do want to introduce a top level grouping above them both?  So have iio[n]
containing either or both of trigger0 and device0 with the names under dev being
iio3:device0:buffer0:access0 etc?
> 
> Device 000: <name>
>   <channel_group> (if available)
>     <channel>
>         :
>   <channel_group> (if available)
>     <channel>
>         :
> 
>   buffer<n>       (if available)
>     bytes per datum: <bpd>,     length: 64
>     event:  /dev/device0:buffer0:event0
>     access: /dev/device0:buffer0:access0
> 
>   trigger<m>: <trigger_name>  (if available)
> 
> So for a single trigger it would be:
Ah I see.  I don't want to see the gpio triggers sharing a directory.
It implies a connection between them when they are no more connected
than two separate instances of an accelerometer.  The gpios in question
may even be on completely different physical chips.
> 
> # lsiio -v
> Device 000: gpio_trigger
>   trigger0: irqtrig30
>   trigger1: irqtrig45
>   trigger2: irqtrig51
> 
> or in sysfs:
>     |- /sys/bus/iio/iio0/
>        |- name
>        |- iio0:trigger0
>           |- name
>        |- iio0:trigger1
>           |- name
>        |- iio0:trigger2
>           |- name
> 
> 
>>> - Consitent names in ABI and code:
>>>    * bps: 'bits per sample' or 'bytes per scan'?
>> Yup, that's why bpd was introduced in the code.
>>>    * bpd: 'bytes per datum' but named bps in user space
>> Hmm. there does seem to be some confusion still around this.
>> Given we also have bpse (bits per scan element) the confusion gets even worse.
>> Perhaps the right option is to loose the acronyms entirely and have it long hand
>> both in core code (drivers don't really matter for this) and the userspace abi?
> 
> OK, I'll prepare a patch.
Excellent. Beware that these turn up a fair bit in the docs as well.
> 
>>> - Endianess of the buffers:
>>>    * Device specific? Then we need a sysfs file to publish this info.
>>>    * CPU native byte order?
>> It is currently cpu native for all software ring buffers. Agreed this may
>> change and hardware buffers may do either.  So you are quite right, we
>> need an attribute for this.  So I guess we support 3 options, cpu native, big endian,
>> little endian. So what shall we call it?
>>
>> byte_order - [big little native]  Mostly read only, though sooner or later I expect
>> we will get some device that allows this to be controlled.
> 
> Do we really need native? I think the driver can figure out what the native order is, and just give that one (even at compile time).
Good point.
> Another possibility is to let the driver always convert to native.
Bad idea.  In a hw ring buffer case that adds a lot of overhead for straight logging applications where we just want
to store what the data is rather than do anything with it live.
 At least that's what most userspace software want's to have. I recently sent a patch for sca3000 to the linux-iio list.
Strange, those never made it to my inbox.  I'm guessing my iio subscription must have borked.  I'll get them
from the archive.

On those patches, I'm happy to ack the first (not sure when that bug snuck in and I'm not in a possition
to test the fix today).

As per this discussion I'd rather avoid the data munging of the second. That's a job for userspace.
Obviously we'll be needing the stuff you specify below for that though.
> 
>>>    * Allow packed buffers for samples with fractional sizes?
>> Probably not using the current ring buffer. As you say a big issue is how
>> to describe a packed storage particularly if not all of it is packed.
>> (so say 2 x 11 bit readings in 3 bytes - for say a 4 channel device, this is a better
>> bet than packing it tightly into 44 bits.)  So far we haven't had a hardware
>> ring device giving us packed data, but I'm sure one will turn up and force
>> this element sometime in the future.  I think we leave this until a user comes
>> along then pin it down then. I agree it is definitely something we need to consider,
>> just not now!  Still if you want to lay out some guidance for discussion feel
>> free.
> 
> OK, no packed buffers for now, but we should implement variable
> sample sizes for standard types. Indeed we already have this for the
> timestamp, which is always 64 bit.

Agreed. These ought to be in there and will be needed 

> To be compatible with future extensions we could have:
>   |- /sys/bus/iio/ii0/buffer0/scan_elements/
>      |- accel_x:en    (0 or 1)
>      |- accel_x:type  (i.e. s14/16, see *)
>      |- accel_x:index
> 

> * s14/16 means signed 14 bits, stored in 16 bits, right aligned. If
> it's left aligned we can just modify the scale attribute and give the
> 16 bit interpretation in <channel>:raw.
That is quite a neat way of doing it though I'm not sure 'type' is the
ideal name.  My immediate thought is that type would be 'acceleration'!
We definitely want this on list.  We'd also want to drop the precision
attribute as that will just confuse things.

> I don't like the index prefix any more, even I had proposed this
> once. This is because for devices with more than 10 channels
> (adis16400) we have to get a leading 0 in the name to maintain
> alphabetical sorting, which is nearly impossible with the current
> macros.
Does alphabetical sorting really matter? + Doesn't putting 01 etc
in the macro give the right name?  I thought it was stringified in the
first step (could be wrong, that macro stuff always gives me a headache).
We definitely need the prefix or equivalent so this is worth clearing up.

Thanks,

Jonathan
