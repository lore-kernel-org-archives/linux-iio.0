Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Tue, 26 Jul 2011 10:04:08 +0100
Subject: RE: [PATCH 1/3] staging:iio: remove broken support for multiple
 event interfaces.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177143001196AF@LIMKCMBX1.ad.analog.com>
References: <1311600911-20353-1-git-send-email-jic23@cam.ac.uk>
 <1311600911-20353-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1311600911-20353-2-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-07-25:
> We don't have a use case for these.  Two drivers appeared to use them
> but both report all events on the first.
>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/staging/iio/accel/lis3l02dq_core.c |   13 +--
>  drivers/staging/iio/accel/sca3000_core.c   |    9 +-
>  drivers/staging/iio/adc/ad7150.c           |   21 +++--
>  drivers/staging/iio/adc/ad7291.c           |   13 +--
>  drivers/staging/iio/adc/ad7745.c           |    5 +-
>  drivers/staging/iio/adc/ad7816.c           |    5 +-
>  drivers/staging/iio/adc/ad799x_core.c      |    4 +-
>  drivers/staging/iio/adc/adt7310.c          |    7 +-
>  drivers/staging/iio/adc/adt7410.c          |    7 +-
>  drivers/staging/iio/adc/adt75.c            |    3 +-
>  drivers/staging/iio/adc/max1363_core.c     |    4 +-
>  drivers/staging/iio/addac/adt7316.c        |   18 ++--
>  drivers/staging/iio/dac/ad5504.c           |    4 +-
>  drivers/staging/iio/iio.h                  |   11 +--
>  drivers/staging/iio/industrialio-core.c    |  146 +++++++++++++-------

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
