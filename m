Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Date: Mon, 19 Sep 2011 20:44:40 +0100
Subject: RE: [PATCH] iio: adc: Replace, rewrite ad7745 from scratch.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E7206653@LIMKCMBX1.ad.analog.com>
References: <1316184432-22349-1-git-send-email-michael.hennerich@analog.com>
 <4E77334A.1000207@cam.ac.uk>
In-Reply-To: <4E77334A.1000207@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-09-19:
>
> One quick nitpick on submission format:
> Please put version in the email subject
> [PATCH V3] iio:...
>
> That way it's easy to spot which one to bother reading ;)
>
> On 09/16/11 15:47, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> The existing ad7745 driver didn't conform with the IIO spec for such
>> devices. It was way simpler to rewrite the existing driver, than
>> actually fixing it.
>>
>> Changes since V1:
>>
>> Fix file header description. Fix erroneous defines. Pin channels to
>> expected places in the iio_chan_spec array, to avoid magic numbers. Use
>> msleep instead of busy waiting mdelay. Fix indention style. Drop _bias
>> and use _offset attribute.
>>
>> Changes since V2:
>> Increase accuracy of cap scale.
>> Fix channel spec for VIN.
> Some formatting nitpicks. I'll fix them up.
>
> I don't think Greg's tree is visible anywhere so I'll pull this through
> mine and push on to him.  Thanks,

Hi Jonathan,

Thanks!
I'm curious, since you own a tree at kernel.org -
Any more precise updates, or rumors when it will go live again?


Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
