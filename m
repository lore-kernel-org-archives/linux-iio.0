Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Tue, 26 Jul 2011 10:01:50 +0100
Subject: RE: [PATCH 0/2] blue part 6: IIO abi rework
Message-ID: <544AC56F16B56944AEC3BD4E3D59177143001196A7@LIMKCMBX1.ad.analog.com>
References: <1311600234-16128-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1311600234-16128-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-07-25:
> Michael pointed out the issues that not having an explicit direction
> for channels was causing and the inconsistency of the inX and outX
> channel naming we got from hmwon.
>
> They are stuck with it, but we aren't, so lets fix this now.
>
> Interesting question is whether we reset the base units to be volts
> whilst we are at it? (for voltage channels obviously!)

What do you mean exactly volts versus milli volts?
Or given the fact that we have some current converter currently as inX and =
outX -
So we need to audit the datasheet to make sure we the (in|out)_(voltage|cur=
rent)Y_raw
right?


> Given there will be a lot of auditing and datasheet reading to do
> that, I suggest that if we decide to do it, we leave that for when we
> are moving drivers out of staging.
>
> We could roll the doc patch in with the one in the previous series to
> reduce churn.  If they go together I'll probably do that.
>
> Thanks,
>
> Jonathan
>
> Jonathan Cameron (2):
>   staging:iio: ABI rework - add in_ or out_ prefix to channnels
>   staging:iio:Documentation sysfs-bus-iio add in and out prefixes
>  drivers/staging/iio/Documentation/sysfs-bus-iio |  536
> +++++++++++----
> -------
>  drivers/staging/iio/dac/ad5686.c                |   24 +-
>  drivers/staging/iio/iio.h                       |   31 ++-
>  drivers/staging/iio/industrialio-core.c         |   28 +-
>  4 files changed, 324 insertions(+), 295 deletions(-)

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
