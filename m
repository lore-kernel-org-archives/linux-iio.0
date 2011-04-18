Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Drivers
	<Drivers@analog.com>, "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Mon, 18 Apr 2011 20:51:15 +0100
Subject: RE: [PATCH 1/1] IIO-onwards: ADC: AD799x: Use private data space
 from iio_allocate_device
Message-ID: <544AC56F16B56944AEC3BD4E3D591771375475E993@LIMKCMBX1.ad.analog.com>
References: <1303140639-3306-1-git-send-email-michael.hennerich@analog.com>
 <4DAC5DCD.5040706@cam.ac.uk> <4DAC600D.6040800@cam.ac.uk>
In-Reply-To: <4DAC600D.6040800@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-04-18:
> On 04/18/11 16:50, Jonathan Cameron wrote:
>> On 04/18/11 16:30, michael.hennerich@analog.com wrote:
>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>
>>> Use private data space from iio_allocate_device Fix typo in
>>> pollfunc name
>> That's in the tree already after you pointed out the other one.
> I did this slightly differently and used iio_dev->name rather than
> ad799x for the consumer name.  Do you mind?

Not at all - Even better.

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
