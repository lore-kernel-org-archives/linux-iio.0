Return-Path: <manuel.stahl9cd33xy531iis.fraunhofer.de@bounce.antispameurope.com>
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: IIO: angular measurement types.
Date: Thu, 29 Sep 2011 15:22:19 +0200
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <4E846F08.5070906@cam.ac.uk>
In-Reply-To: <4E846F08.5070906@cam.ac.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201109291522.19679.manuel.stahl@iis.fraunhofer.de>
List-ID: <linux-iio@vger.kernel.org>

Am Donnerstag, 29. September 2011, 15:13:44 schrieb Jonathan Cameron:
> Hi All
> 
> Just looking at add chan spec support for resolvers and
> realised that our representations of angular measurements
> have become somewhat confused.
> 
> Right now we have
> 
> IIO_GYRO -> angular velocity (units radians / sec)
> IIO_ROT -> vertical rotation position (undocumented)
> IIO_ANGL -> rotation angle (currently integrated version of IIO_GYRO,
> undocumented)
> 
> For resolvers we seem to need
> 
> Absolute rotation position (IIO_ANGL?)  set units to radians
> Angular velocity (IIO_GYRO? - odd naming here) randians / sec
> 
> So, proposal is to rename IIO_GYRO - > IIO_ANGL_VEL
> 
> Anyone have an thoughts on this?

The question is whether we want to have names according to the physical 
propery we measure or names according to the common terminology of the devices 
that measure that property.

i.e. gyros measure angular velocities. Are there other devices that measure 
angular velocities? I think not.

Devices that measure horizontal rotation are usually called inclinometers.
Devices that measure vertical rotation are for example compasses, but there 
could be others.
Devices that measure rotation angles are usually called resolvers, but this 
might also be non exclusive.

Do we want to distinguish between these? They all return angles.

And what about sensors that measure rotations? They can deliver angles outside 
[-PI:+PI] (i.e. several rotations), but that makes no sense for compasses.

Nevertheless I think we can keep IIO_GYRO for devices that measure angular 
velocities, as this is a very common name for these.

Regards,
Manuel
