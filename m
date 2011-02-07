Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Mon, 7 Feb 2011 15:34:12 +0000
Subject: RE: [PATCH 0/4] staging:iio:meter clean up and dead code removal.
Message-ID: <544AC56F16B56944AEC3BD4E3D591771324C1BAA0D@LIMKCMBX1.ad.analog.com>
References: <1296934459-15760-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1296934459-15760-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-02-05:
> This is very much the starting point for bashing the meter drivers
> into shape.  For now I've just removed most of the unused code and stubs.

Instead of removing the stubs - I would rather prefer implementing them.
But I think you're right this dead code is not going to be useful either.

> I have also cleaned up spi bus handling.  I may well have gotten that
> bit wrong so please do take a look.  In some cases this involved
> turning one transfer into two so as to clarify what the code was doing.
> This may cause issues if the spi bus drivers don't play the game
> properly or as if I got the conversion wrong.

Looks right - but I had to double check with the datasheet.
The SPI write then read behavior is a bit undefined.
In particular, what is shifted out on the MOSI pin during the receive part.

Some implementations send zero/one or repeat the last word in the shift reg=
ister, while others tristate MOSI.
If the target slave device in questions also listens on MOSI while it drive=
s MISO,
unpredicted behavior my result.

It's therefore sometimes necessary to use full duplex transfer and drive
MOSI to a known good state. You basically removed this, but the ADExxxx
Parts don't seem to depend on this.

> Next job is to pin down, standardise and document the sysfs interface
> for these parts.  Anyone care to take this on?

Considering the complexity and number of new arguments, this is going to ta=
ke some time.
But it has to be done. Unfortunately right now I'm a bit loaded with other =
stuff.
But I'll open a tracker item for me to look at.

> Note I have currently left the ade7758 driver alone as it is by far
> the most complex and didn't suffer the large amount of dead code to be
> found in the others.
>
> All comments as ever welcome.  I'd also like to know what test
> coverage we have on these parts.

The ADE7758 is the only one I have test hardware. Ideally we bring this one
in a good shape and add support for the other parts to it.

> Thanks,
>
> Jonathan
>
> Jonathan Cameron (4):
>   staging:iio:meter remove stubs from ade7753.
>   staging:iio:meter remove stubs from ade7754.
>   staging:iio:meter remove stubs from ade7759.
>   staging:iio:meter remove stubs from ade7854.
 drivers/staging/iio/meter/ade7753.c     |  200 +++++++----------------
 -------- drivers/staging/iio/meter/ade7753.h     |   64 ----------
 drivers/staging/iio/meter/ade7754.c     |  165 ++++-------------------

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
