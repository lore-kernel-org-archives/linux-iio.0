Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Mon, 11 Apr 2011 15:55:01 +0100
Subject: RE: RFC How to handle device with different _scale values depending
 on how you access them.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177137546EF0C4@LIMKCMBX1.ad.analog.com>
References: <4DA0A420.8060302@cam.ac.uk>
In-Reply-To: <4DA0A420.8060302@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-04-09:
> Dear All,
>
> I'm messing with my favourite 'special' device, the sca3000.
>
> It has a hardware ring buffer and direct read abilities.
>
> Direct reads of current value are 13bit signed, the buffer is either
> 11 bit or 8 bit.
>
> So ultimately the scale on the buffer can change which is nasty
> enough, however direct reads are 13bits whatever the buffer is set to.
>
> Hence we need to export two scale's at a time.
>
> Would anyone mind if I add the option to have both
>
> /device0/accel_scale (applies to _raw files in the same dir). and
> /device0/device0:buffer0/accel_scale (or maybe put it in the
> 'scan_elements' directory?
>
> This means we will have to define a precedence for these attributes
> when reading from buffers which isn't nice, but such is life...
>
> Jonathan

If scaling the values in the buffer to 13-bit is not an alternative, that s=
ounds like the way to go.


Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
