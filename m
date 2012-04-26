Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "jic23@kernel.org" <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Thu, 26 Apr 2012 17:11:48 +0100
Subject: RE: [PATCH 1/4] iio: Rename iio/dds to iio/frequency
Message-ID: <544AC56F16B56944AEC3BD4E3D5917714E7965F942@LIMKCMBX1.ad.analog.com>
References: <1335443643-20439-1-git-send-email-michael.hennerich@analog.com>
 <4F9948D7.20109@cam.ac.uk>
In-Reply-To: <4F9948D7.20109@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2012-04-26:
> On 4/26/2012 1:34 PM, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich<michael.hennerich@analog.com>
>>
>> Generalize naming to allow other frequency synthesis techniques as
>> well. No functional changes.
> Other than doing git --format-patch -M to generate this, fine with me.
> One thought though. Do we want a separate directory for frequency
> measurement devices from frequency generating ones?  If so might want to
> pick a naming that allows for that...

Hi Jonathan,

Right now I'm happy with a single directory, potentially covering both
type of devices.


Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
