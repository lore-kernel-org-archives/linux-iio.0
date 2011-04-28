Return-Path: <khali@linux-fr.org>
Date: Thu, 28 Apr 2011 15:51:18 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "device-drivers-devel@blackfin.uclinux.org"
 <device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>,
 Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: Oddities and how to handle them.
Message-ID: <20110428155118.041b84f2@endymion.delvare>
In-Reply-To: <4DB933E3.8070803@cam.ac.uk>
References: <4DB6EF2D.9090704@cam.ac.uk>
	<4DB7FEE8.3080004@analog.com>
	<4DB82B5C.5070900@cam.ac.uk>
	<544AC56F16B56944AEC3BD4E3D5917713AAEE15859@LIMKCMBX1.ad.analog.com>
	<4DB8322A.6050207@cam.ac.uk>
	<544AC56F16B56944AEC3BD4E3D5917713AAEE15A62@LIMKCMBX1.ad.analog.com>
	<4DB933E3.8070803@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Thu, 28 Apr 2011 10:31:15 +0100, Jonathan Cameron wrote:
> Guenter / Jean - cc'd you two because we have an sysfs interface naming question for
> AC sensors that touches on the edge of hwmon.
>
> > For the metering parts I think we need to define a few more channel types.
> > 
> > How about this ones
> > 
> > inSX            S is the apparent power.
> > inPX            P is the active power.
> > inQX            Q is the reactive power.
> > inVX            V is the voltage. (only inX ?)
> > inVRMSX VRMS is the quadratic mean voltage.
> Call it 'root mean square' rather than quadratic in the docs. They have different
> meanings in English.
> > inIX            I is the current.
> currX as per hwmon?  They also define a power attribute, but only 1 (as DC
> I guess). Cc'd Guenter and Jean to see if we can / want to share an interface...
> 
> Guenter/ Jean, do you think hwmon will ever handle AC sensors?

Well, never say never ;) While I've never heard of such sensors, I
guess it would make some sense for a computer PSU to include a sensor
chip monitoring both the AC input and the DC output to measure the
efficiency of the unit.

> Maybe we want to be
> well clear of your interfaces just to avoid confusion? Or define a new set of shared
> names for the above that we will both use (when it becomes relevant?)

It's hard to tell in advance what hwmon would implement, as we lack
actual examples. All I can say is that we would never use "in" prefixes
for power or current. The above power examples would most probably be
named powerX_apparent_input, powerX_active_input and
powerX_reactive_input, if we ever have to support these. And
inX_rms_input for the root mean square voltage input.

But then again, I'm not sure if there is any point in sharing anything,
or forcing any difference, between hwmon and iio interfaces. They are
different by nature, and if we don't strictly enforce their relation,
they are bound to randomly diverge and converge anyway.

-- 
Jean Delvare
