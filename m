Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:55199 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700Ab1I2Np3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 29 Sep 2011 09:45:29 -0400
Message-ID: <4E847870.3040007@cam.ac.uk>
Date: Thu, 29 Sep 2011 14:53:52 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: IIO: angular measurement types.
References: <4E846F08.5070906@cam.ac.uk> <201109291522.19679.manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <201109291522.19679.manuel.stahl@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/29/11 14:22, Manuel Stahl wrote:
> Am Donnerstag, 29. September 2011, 15:13:44 schrieb Jonathan Cameron:
>> Hi All
>>
>> Just looking at add chan spec support for resolvers and
>> realised that our representations of angular measurements
>> have become somewhat confused.
>>
>> Right now we have
>>
>> IIO_GYRO -> angular velocity (units radians / sec)
>> IIO_ROT -> vertical rotation position (undocumented)
>> IIO_ANGL -> rotation angle (currently integrated version of IIO_GYRO,
>> undocumented)
>>
>> For resolvers we seem to need
>>
>> Absolute rotation position (IIO_ANGL?)  set units to radians
>> Angular velocity (IIO_GYRO? - odd naming here) randians / sec
>>
>> So, proposal is to rename IIO_GYRO - > IIO_ANGL_VEL
>>
>> Anyone have an thoughts on this?
> 
> The question is whether we want to have names according to the physical 
> propery we measure or names according to the common terminology of the devices 
> that measure that property.
What they measure.  It is true for every other type (IIRC)
> 
> i.e. gyros measure angular velocities. Are there other devices that measure 
> angular velocities? I think not.
resolvers.  There is a reason I was looking at this ;)  Can technically be
done with accelerometers in a number of locations or an accelerometer / magnetometer
pair.

Also, the term gyroscope may mean a device for measuring absolute rotation or
rotational velocity.  I've heard some argue that the term is completely missused
for mems devices...

> 
> Devices that measure horizontal rotation are usually called inclinometers.
But they measure inclination so that one is fine.
> Devices that measure vertical rotation are for example compasses, but there 
> could be others.

> Devices that measure rotation angles are usually called resolvers, but this 
> might also be non exclusive.
Also measure angular velocity (or at least the ad2s1200 does).
> 
> Do we want to distinguish between these? They all return angles.
Nope.  That's my argument.
> 
> And what about sensors that measure rotations? They can deliver angles outside 
> [-PI:+PI] (i.e. several rotations), but that makes no sense for compasses.
It does if you have sufficient tracking to know it happened.  Still I agree it
doesn't make sense when using them for navigation.  We probably don't need to
worry about it though.  Any userspace app should trivially be able to correct
wrap around if it expects the device to be used as a compass.
> 
> Nevertheless I think we can keep IIO_GYRO for devices that measure angular 
> velocities, as this is a very common name for these.
I'd agree except that it makes things inconsistent.  We already have one
definitely non gyroscope user.  Right now the change is trivial.  We can't
really do it later.

Jonathan
