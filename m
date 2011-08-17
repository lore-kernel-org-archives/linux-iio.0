Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Wed, 17 Aug 2011 12:32:52 +0100
Subject: RE: [RFC PATCH 0/6] IIO: capacitance ADC cleanup (ad7150)
Message-ID: <544AC56F16B56944AEC3BD4E3D591771430064583E@LIMKCMBX1.ad.analog.com>
References: <1313570537-26971-1-git-send-email-jic23@cam.ac.uk>
 <4E4B85B8.3010006@analog.com> <4E4B908B.7010805@cam.ac.uk>
 <4E4BA7F8.4050500@cam.ac.uk>
In-Reply-To: <4E4BA7F8.4050500@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-08-17:
> On 08/17/11 10:57, Jonathan Cameron wrote:
>> On 08/17/11 10:11, Michael Hennerich wrote:
>>> On 08/17/2011 10:42 AM, Jonathan Cameron wrote:
>>>> Hi All,
>>>>
>>>> Couple of bits in here that I'll push out into next set of main
>>>> cleanups.
>>>>
>>>> Controversial bits (hence RFC) are the introduction of
>>>> IIO_EV_TYPE_MAG_ADAPTIVE and IIO_EV_TYPE_THRESH_ADAPTIVE, to handle
>>>> the 'mean' shifted thresholds of this device.  I'm far from convinced
>>>> these are the right way to go, but best I have come up with just yet.
>>>>
>>>> Note this series is completely untested.  I haven't even verified
>>>> that the new chan spec related bits work right yet (can do that
> with a dummy driver).
>>> Hi Jonathan,
>>>
>>> I have a EVAL-AD7156EBZ board, so I should be able to test the driver.
>>> Can you please push these patches onto your iio-blue git?
>>>
>> Will do. Have fixed the swab16 requirements I think.
>>
>> Branch is capfun. The push included a few other minor bits and bobs in
>> the master branch but nothing interesting..
> Also, some ad7152 changes in there, but currently non compiling. oops.

Also have a EVAL-AD7152, so I'll test it as well.

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
