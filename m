Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Date: Fri, 27 May 2011 15:46:03 +0100
Subject: RE: [PATCH] IIO: ADC: New driver for AD7792/AD7793 3 Channel SPI ADC
Message-ID: <544AC56F16B56944AEC3BD4E3D5917713AAF2F450F@LIMKCMBX1.ad.analog.com>
References: <1306335750-428-1-git-send-email-michael.hennerich@analog.com>
 <4DDE28F4.5040705@cam.ac.uk> <4DDE63B1.2060301@analog.com>
 <4DDE6A8D.5000007@cam.ac.uk>
In-Reply-To: <4DDE6A8D.5000007@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-05-26:
>
> ...
>>> What would happen if this driver used any other trigger?  Would
> everything work?
>> No. But other drivers can you the trigger. It's not really an
>> trigger
> it's a data ready.
> Most are.  As you say, it is useful to trigger other reads from this,
> but not to trigger this to read from other sources...
>>> I think it would do an immediate read which is going to be a problem.
>>> Perhaps we need a way of restricting triggers.  This one can be used
>>> by anyone, but the part can only use it's own trigger (I think).
>> Having the ability to reject alien triggers are nice to have.
> True enough.  I guess the easiest is some sort of 'filter' callback on
> trigger connect.
> Then drivers that care, can reject devices that don't match what they
> need.  Would probably want one in each direction.  Trigggers can
> reject devices and devices can reject triggers.

Are you going to put this in place?
Or do you want me to look at it?

BTW - I'm out next week...

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
