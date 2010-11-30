Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Drivers
	<Drivers@analog.com>, "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Tue, 30 Nov 2010 16:44:48 +0000
Subject: RE: [PATCH] staging: iio: dds: ad9834: Enable driver support for
 AD9833 and AD9834 DDS devices
Message-ID: <544AC56F16B56944AEC3BD4E3D591771312F0818BD@LIMKCMBX1.ad.analog.com>
References: <1291045919-11141-1-git-send-email-michael.hennerich@analog.com>
 <4CF43350.4000703@cam.ac.uk>
 <544AC56F16B56944AEC3BD4E3D591771312F081809@LIMKCMBX1.ad.analog.com>
 <4CF52280.2050600@cam.ac.uk>
In-Reply-To: <4CF52280.2050600@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

>Jonathan Cameron wrote on 2010-11-30:
>>> From a generalization point of view we don't care that the square wave
>>> is a random bonus option the part happens to be able to kick out.
>>> Ideally we want a naming scheme that makes it's relationship to the
>>> other waveforms apparent though and it's not entirely obvious how to
>>> handle that (e.g. how to handle the double frequency square wave this
>>> part can produce). Things will get more fun if parts have multiple
>>> outputs tied to one dds channel.
>>
>> Actually that's the case here on the AD9834. The signbit is an
>> independent output. It therefore can't be handled with the
> dds0_wavetype file.
> Then have dds0_wavetype0 (sine triangle) and dds0_wavetype1 (square).
> Document that the second index is only required if there are multiple
> physical outputs from a given channel.

How to disable dds0_wavetype1 (square)?

(square off)?

Not all combinations of dds0_wavetype0 (sine triangle) are allowed with the=
 signbit output.


>> It can be enabled/disabled while the DDS generates a sine wave on the
>> main output.
>>
>> On the AD9833 the signbit square wave feature is routed to the DDS
> main output.
> Then that part just has the dds0_wavetype (triangle sine square) as
> suggested above.

That's how I implemented it for the AD9833

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036
Geschaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif
