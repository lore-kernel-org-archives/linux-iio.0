Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57099 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbcGCJf7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2016 05:35:59 -0400
Subject: Re: [RFC PATCH] iio: imu: add driver for Bosch Sensortec BNO055
To: Vlad Dogaru <vlad.dogaru@intel.com>
References: <1466766936-20561-1-git-send-email-vlad.dogaru@intel.com>
 <0fb507e2-e936-9c0c-9148-e4e329ba9dcb@kernel.org>
 <20160627133110.GE3142@vdogaru>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, andrey_utkin@fastmail.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <58c1d7dc-5ff4-8d49-dd4d-affb380eb272@kernel.org>
Date: Sun, 3 Jul 2016 10:35:57 +0100
MIME-Version: 1.0
In-Reply-To: <20160627133110.GE3142@vdogaru>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/06/16 14:31, Vlad Dogaru wrote:
> On Sun, Jun 26, 2016 at 06:56:57PM +0100, Jonathan Cameron wrote:
>> On 24/06/16 12:15, Vlad Dogaru wrote:
>>> Hi everyone,
>>>
>>> This is a minimal implementation of a driver for the Bosch Sensortec
>>> BNO055, a very interesting accel-gyro-magneto combo.  The datasheet is
>>> available at https://www.bosch-sensortec.com/bst/products/all_products/bno055
>> 'interesting' device indeed.
>>>
>>> The driver in its present state works, but this is a RFC for a few
>>> reasons detailed below:
>>>
>>> (1) The device has a few possible operating modes.  The most simple
>>> ones employ a single sensor and power down the other two; the most
>>> complex use all 3 for sensor fusion.  Changing the mode at runtime would
>>> require changing the channels and I'm not sure IIO allows that.
>> It allows a much greater set of channels than can run at one time though..
>> Would that work here?  Lots of fun with available_scan_masks and
>> friends, but from your description here sounds fine (will look at
>> the code in a minute).
>>>  So I've
>>> opted to choose the mode at probe time, based on a DeviceTree property.
>>> Hope that's ok.
>> Would rather it was runtime controllable I think...
>>>
>>> (2) Fusion modes provide orientation data.  This is either relative to
>>> the initial position of the sensor, or to magnetic North.
>> Something new :)
>>>  There is a
>>> modifier, IIO_MOD_NORTH_MAGN,
>> I'm trying to remember why we have that...  Ah, just checked docs, it
>> was for devices that offered planar rotation angles from north.
>>> but it occupies the same field as
>>> IIO_MOD_QUATERNION 
>> With hindsight we should probably have made that a new channel type
>> rather than trying to mash it into the rotation type.  Perhaps doing
>> that now is the way to go and adding the interface to the hid sensor
>> device driver that is the only user (keeping the old option as well
>> for compatibility reasons).
>>
>>> and IIO_MOD_{X,Y,Z}, so we can't use both.
>> This is kind of related to mounting matrix, be it a 'world mounting matrix'.
>> I wonder if we want to support it in a vaguely similar way...
>>
>>   Therefore
>>> there is currently no means of telling from user space whether the
>>> orientation is relative to North or to the initial position;  one could
>>> look at the DeviceTree description to deduce the operating mode, but
>>> that's hardly ideal.
>> Absolutely, this one needs to be exposed in userspace.
>>
>> Is there a means of resetting the initial position at runtime?
> 
> I think switching the device to config mode (where no sensors are
> available) and then back to a relative-orientation mode would work.
> I've proposed a means to do this in my previous message, but it's just a
> first draft.  Please feel free to poke holes in that approach :)
> 
>> Providing an attribute to do that might be the cleanest option if
>> so. Not sure if there are any benefits to picking the initial value
>> against the north one otherwise...
>>>
>>> (3) In fusion modes, the device also exposes linear and gravitational
>>> accelerations, but IIO doesn't seem to support this.  I can add these
>>> channel types if you believe they are useful.
>>
>> They will indeed have to be new channel types as you suggest, though
>> 'linear' is a rather unclear name to my mind.
> 
> Quoting Section 3.3.3 of the datasheet:
> 
> 	In fusion modes it is possible to separate the two acceleration
> 	sources, and thus the sensor fusion data provides separately
> 	linear acceleration (i.e. acceleration that is applied due to
> 	movement) and the gravity vector.
> 
> This agrees with Android's definitions:
> https://developer.android.com/guide/topics/sensors/sensors_motion.html#sensors-motion-grav
> https://developer.android.com/guide/topics/sensors/sensors_motion.html#sensors-motion-linear
Hmm. Silly naming gets cut and paste everywhere... 

If we do go with this we'll have to scatter descriptions of it everywhere
as anyone not knowing the term is used as such (google won't give it this
meaning for starters) will be unable to work out what it is.

https://en.wikipedia.org/wiki/Acceleration for example defines it acceleration without
a change of direction.

What fun. I'd be tempted to call it something like gravity removed acceleration but
that's rather unwieldy.

Jonathan
> 
> Thanks,
> Vlad
> 

