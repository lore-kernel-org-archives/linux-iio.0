Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Paul Thomas <pthomas8589@gmail.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Date: Fri, 26 Aug 2011 08:29:45 +0100
Subject: RE: [PATCH] IIO: ADC: New driver for AD7190/AD7192/AD7195 4 Channel
 SPI ADC
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E6D0732F@LIMKCMBX1.ad.analog.com>
References: <1313593455-29706-1-git-send-email-michael.hennerich@analog.com>
	<4E4BDEBC.3090606@cam.ac.uk>
	<CAD56B7cP+b3EbpvwfnqMdU9oWJVWw-HG66SgQeY6EX3tFEaRiw@mail.gmail.com>
	<544AC56F16B56944AEC3BD4E3D59177143006BA839@LIMKCMBX1.ad.analog.com>
	<CAD56B7ea7kqEkjDo=4xH8e00Ss=CA1cANjr_Mo8vw+mo8NrvGA@mail.gmail.com>
	<544AC56F16B56944AEC3BD4E3D59177143006BAC41@LIMKCMBX1.ad.analog.com>
 <CAD56B7dxi-YE24BCtMEXuUoMCvnB=gLt4KxRpEO6J0pFHXXAcQ@mail.gmail.com>
In-Reply-To: <CAD56B7dxi-YE24BCtMEXuUoMCvnB=gLt4KxRpEO6J0pFHXXAcQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Paul Thomas wrote on 2011-08-26:
> I was just trying to test this driver with the IRQ, and I get this
> after a ctrl^c after a hung modprobe.

Hi Paul,

Can you explain this a bit further?
The modprobe can only hung if the part never generates an interrupt.
This basically happens in ad7192_calibrate().

When this happens, you press ctrl^c?
Then the second time doing the modprobe you see this oops?
It's basically something enabled an already enabled interrupt.

> I also get a "ad7192 spi1.1:
> device ID query failed (0x3)", but it looks like the id isn't used.

Well the AD7194 is currently not recognized by the driver.
You have to add it, as known ID.

> Also this is with the ad7194 instead of the ad7192. I'm using
> .irq=3DAT91SAM9260_ID_IRQ0 which works well for the mcp251x driver,
> although with that device it's a dedicated interrupt line.

There is a significant difference between the AD7190/AD7192/AD7195,
and the part you are going to add.
Make sure you get the channel selection bits right!


Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
