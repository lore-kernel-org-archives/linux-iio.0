Return-Path: <Robin.Getz@analog.com>
From: Robin Getz <robin.getz@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>, abbotti@mev.co.uk,
        fmhess@users.sourceforge.net
Subject: IIO and Comedi
Date: Fri, 17 Dec 2010 15:13:02 -0500
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        comedi_list@googlegroups.com, greg@kroah.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID: <201012171513.03045.robin.getz@analog.com>
List-ID: <linux-iio@vger.kernel.org>

I'm just trying to rationalise something in my head...

In staging, there exists both iio, and comedi - which both seem to do simil=
ar=20
things (capture/create external analog signals), just with different=20
busses -- which is really different platforms (Desktop - PCI, PCIe vs=20
embedded - I2C, SPI, SoC, etc).

=2E/staging/iio
=2E/staging/comedi

the problem (to me) is two different userspace interfaces.

=46or userspace, for those "typical" applications - oscilloscope, generator=
,=20
strip chart recorder, etc - it would be nice to have a common userspace lib=
=20
between the two - so I can prototype on a desktop via PCI DAQ card, and run=
=20
on my embedded system with a SPI converter.

I can't be the only one asking if there any desire to unify these before th=
ey=20
are moved to mainline (out of staging). If there isn't - that's OK too.

Thanks
=2DRobin


=46or those not familiar with the other:

=46rom ./staging/iio/Documentation
=2D-----------------------------------
Overview of IIO

The Industrial I/O subsytem is intended to provide support for devices
that in some sense are analog to digital convertors (ADCs). As many
actual devices combine some ADCs with digital to analog convertors
(DACs) the intention is to add that functionality at a future date
(hence the name).

The aim is to fill the gap between the somewhat similar hwmon and
input subsystems.  Hwmon is very much directed at low sample rate
sensors used in applications such as fan speed control and temperature
measurement.  Input is, as it's name suggests focused on input
devices. In some cases there is considerable overlap between these and
IIO.

A typical device falling into this category would be connected via SPI
or I2C.
=2D----------------------------------

and from:
http://www.comedi.org/doc/index.html#INTRODUCTION

=2D----------------------------------
Comedi is a free software project that develops drivers, tools, and librari=
es=20
for various forms of data acquisition: reading and writing of analog signal=
s;=20
reading and writing of digital inputs/outputs; pulse and frequency counting=
;=20
pulse generation; reading encoders; etc.
=2D----------------------------------
