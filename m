Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>
Date: Mon, 26 Sep 2011 08:55:18 +0100
Subject: RE: [PATCH 00/16] staging:iio:adc cleanups / fixes.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E7272AFA@LIMKCMBX1.ad.analog.com>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-09-23:
> Hi Michael,
>
> Result of doing a careful review of these fundamentally clean
> drivers.  A few actual bug fixes and quite a few cases of moving
> to prefered means of doing things (not using IIO_CHAN for starters).
>
> Please look over these as I may well have 'cleaned' things into
> not working.  Only functional changes beyond bug fixes are that
> we now have event _en attributes for the ad799x (read only and always
> equal to 1) and what happens with gpio request failures has changed
> in the ad7606.

Hi Jonathan,

Great work. Looks good except for one patch I've NACKed.

[PATCH 03/16] staging:iio:adc:ad799x fix incorrect setting of configuration=
 register on single channel read.

Thanks!

-Michael


> Thanks,
>
> Jonathan
>
> Jonathan Cameron (16):
>   staging:iio:adc:ad799x fix incorrect scan_type descriptions.
>   staging:iio:adc:ad799x stop using IIO_CHAN macro.
>   staging:iio:adc:ad799x fix incorrect setting of configuration
>     register on single channel read.
>   staging:iio:adc:ad799x trivial: use the convenient chan struct.
>   staging:iio:adc:ad799x use a table for frequency values rather than
>     big switch. staging:iio:adc:ad799x avoid bouncing back and forth
>     from iio_priv space. staging:iio:adc:ad799x use the core handling
>     for as much of the events as possible.
>   staging:iio:adc:ad799x set the device name only once.
>   staging:iio:adc:ad799x address and scan_index always match so stop
>     using address
>   staging:iio:adc:ad7606 add local define for chan_spec structures.
>   staging:iio:adc:ad7606 trivial code style fix.
>   staging:iio:adc:ad7606 make gpio request failures more consistent
>   staging;iio:adc:ad7606 use iio_sw_buffer_preenable rather than local
>     equiv
>   staging:iio:adc:ad7606 refactor to remove st->irq and st->id.
>   staging:iio:adc:ad7606 remove unused chip info elements.
>   staging:iio:adc:ad7887 stop using IIO_CHAN macro.
>  drivers/staging/iio/adc/ad7606.h      |   12 +-
>  drivers/staging/iio/adc/ad7606_core.c |  226 ++++++------
>  drivers/staging/iio/adc/ad7606_par.c  |    2 +-
>  drivers/staging/iio/adc/ad7606_ring.c |   44 +--
>  drivers/staging/iio/adc/ad7606_spi.c  |    2 +-
>  drivers/staging/iio/adc/ad7887_core.c |   26 +-
>  drivers/staging/iio/adc/ad799x.h      |    4 +-
>  drivers/staging/iio/adc/ad799x_core.c |  645 ++++++++++++++++++++-----
>  -------- drivers/staging/iio/adc/ad799x_ring.c |    4 +- 9 files
>  changed, 546 insertions(+), 419 deletions(-)

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
