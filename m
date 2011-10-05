Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>, "manuel.stahl@iis.fraunhofer.de"
	<manuel.stahl@iis.fraunhofer.de>
Date: Wed, 5 Oct 2011 07:55:47 +0100
Subject: RE: [RFC PATCH 0/2] IIO: Filtering - how to handle.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E73435B5@LIMKCMBX1.ad.analog.com>
References: <1317377879-9264-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1317377879-9264-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-09-30:
> Hi All,
>
> One big area we have pretty much glossed over so far is devices with
> controllable hardware filters.  This RFC proposes one option for
> how to handle this. For low pass filters at least, the 3db point
> seems the obvious choice as it allows us to gloss over exactly
> what type of filter it is whilst still capturing it's basic
> property of what it lets through.
>
> What do people think?

Looks good. The 3dB cutoff or corner frequency is typically used to describ=
e
various types of filters: low, high or band (pass/stop).

Documentation?


>
> Jonathan
>
> Jonathan Cameron (2):
>   staging:iio: filter description - low pass 3db frequency.
>   staging:iio:imu:adis16400 add control of data filtering.
>  drivers/staging/iio/iio.h                |    2 +
>  drivers/staging/iio/imu/adis16400.h      |    2 +
>  drivers/staging/iio/imu/adis16400_core.c |  177
>  +++++++++++++++++++++++------ drivers/staging/iio/industrialio-core.c
>  |    2 + 4 files changed, 146 insertions(+), 37 deletions(-)

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
