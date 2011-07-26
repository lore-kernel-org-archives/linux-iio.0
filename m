Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "arnd@arndb.de" <arnd@arndb.de>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Tue, 26 Jul 2011 09:36:08 +0100
Subject: RE: [PATCH 2/7] staging:iio: remove specific chrdev for event
 reading. Get fd from ioctl on buffer.
Message-ID: <544AC56F16B56944AEC3BD4E3D5917714300119677@LIMKCMBX1.ad.analog.com>
References: <1311599921-15729-1-git-send-email-jic23@cam.ac.uk>
 <1311599921-15729-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1311599921-15729-3-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-07-25:
> Change suggested by Arnd Bergmann.
>
> No real reason to have two chrdevs per device. This step merges them
> into one.
> Currently this means that events will only work on devices with
> buffers. THat will be remedied shortly.

Will there be am iio:event instead?
Or iio:buffer even if no buffer and we need to get the iio:event through th=
e anon fds?

> V2: set name for event attribute groups.  Otherwise they all sorts of
> fun occurs on dynamic channel event attribute creation.
>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/staging/iio/accel/sca3000_core.c |    1 +
>  drivers/staging/iio/adc/ad7150.c         |    1 +
>  drivers/staging/iio/adc/ad7745.c         |    1 +
>  drivers/staging/iio/adc/ad7816.c         |    1 +
>  drivers/staging/iio/adc/ad799x_core.c    |    2 +
>  drivers/staging/iio/adc/adt7310.c        |    2 +
>  drivers/staging/iio/adc/adt7410.c        |    2 +
>  drivers/staging/iio/adc/adt75.c          |    1 +
>  drivers/staging/iio/adc/max1363_core.c   |    4 +-
>  drivers/staging/iio/addac/adt7316.c      |    2 +
>  drivers/staging/iio/chrdev.h             |    1 +
>  drivers/staging/iio/dac/ad5504.c         |    1 +
>  drivers/staging/iio/iio.h                |    1 +
>  drivers/staging/iio/industrialio-core.c  |  174
> ++++++++++------------
> --------

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
