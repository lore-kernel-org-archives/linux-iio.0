Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Amit Kucheria
	<amit.kucheria@verdurent.com>, Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	"Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>
Date: Wed, 28 Sep 2011 07:58:43 +0100
Subject: RE: ownership of patches taking drivers out of staging.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E72D697C@LIMKCMBX1.ad.analog.com>
References: <4E81D071.5050806@cam.ac.uk>
In-Reply-To: <4E81D071.5050806@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-09-27:
> Hi All,
>
> I'm putting together a patch set to propose the first step in moving
> IIO out of the staging tree.
>
> I want to take a small set (initially) of representative drivers
> along for the ride.
>
> Now unlike later elements which will consist of git moves (and hence
> preserve history) those that come with us now will be done by
> stripping down the drivers and then building their feature set
> back up as we go.
>
> My question here is whether people are happy if I assign authorship
> of patches for their drivers to them (with appropriate note and
> sign off from me to explain where they came from).
>
> Right now my example set consists of
>
> ad799x - Michael's
> max1363 - mine :)
> tsl2583 - Amit's
> adis16400 - Manuel's but with large bits from drivers of mine
>           and Barry Song. I'm fine with it being Manuel's.
>           Copyright notice covers that some of it is Analog's
>           so, Michael, is that fine with you guys?
>
> So I need responses from Amit, Michael and Manuel as to whether
> they mind me setting author of relevant drivers to them?

Hi Jonathan,

Sure - no problem.

>  I'd
> obviously also like sign offs once you have had time to look
> at them. I'll post an updated tree shortly to github.
>
> Thanks,
>
> Jonathan
>
>

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
