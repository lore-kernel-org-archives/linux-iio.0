Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Mon, 23 May 2011 15:52:17 +0100
Subject: RE: [PATCH 0/2] IIO more resolver cleanups.
Message-ID: <544AC56F16B56944AEC3BD4E3D5917713AAF293900@LIMKCMBX1.ad.analog.com>
References: <1305884517-11168-1-git-send-email-jic23@cam.ac.uk>
 <1305889112-28814-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305889112-28814-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-05-20:
> What can I say, this morning has turned out to be rather dull as well
> and these other two drivers are small so here is a cleanup series for
> them.
>
> Note in the ad2s1210 driver I forgot to clear the IN / OUT of
> resolution bit out of the Kconfig file. I'm also not entirely sure I
> understand how that is supposed to work, so may well have it wrong.
>
> Thanks,

Hi Jonathan,

Thanks for having dull times.
Really nice cleanup!

Give me some time to review these - unfortunately I don't have hardware to
test at the moment.

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
