Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Fri, 21 Oct 2011 09:02:47 +0100
Subject: RE: Userspace event handling and header files
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E75C17CA@LIMKCMBX1.ad.analog.com>
References: <4EA11D7D.80202@metafoo.de>
In-Reply-To: <4EA11D7D.80202@metafoo.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Lars-Peter Clausen wrote on 2011-10-21:
> Hi Jonathan,
>
> I tried to write a small userspace iio event monitor in the style of
> evtest. Right now we have four header files for iio: iio_core.h iio.h
> chrdev.h and sysfs.h. To be able to receive and probably decode events
> in userspace we need three of theses headers: chrdev.h for ioctls and
> the iio_event_data struct, sysfs.h for the different iio_event enums and
> associated macros, iio.h for the iio_chan_type and iio_modifier enums.
>
> Since we probably don't want to export the sysfs.h and chrdev.h headers
> to userspace I propose that we move everything which is needed for
> external API into a common header for example iio.h and move all
> internal API, which is only required to write a IIO driver for by the
> core itself, from the iio.h header to a different header like iio_core.h.
>
> What is your opinion on this?

I think we should also convince Greg to allow staging IIO includes in
include/linux/staging/iio.
Only this would allow us to write maintainable user space code.

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
