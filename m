Return-Path: <peda@lysator.liu.se>
From: Peter Rosin <peda@lysator.liu.se>
To: linux-iio@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-kernel@vger.kernel.org
Subject: Driver for Microchip digital potentiometers, v2
Date: Mon, 21 Sep 2015 23:18:25 +0200
Message-Id: <1442870306-26128-1-git-send-email-peda@lysator.liu.se>
List-ID: <linux-iio@vger.kernel.org>

From: Peter Rosin <peda@axentia.se>

Hi!

This is a new attempt for a driver for these chips. It is a
complete rewrite since the first version which was a dirty
misc driver (plagiarized from another misc driver) that got
shredded in review.

I don't know if I should have added a new unit "ohms", or if
it is ok to only provide "steps"? One could also imagine that
a digital pot can be used to implement a DAC, or something
else, so maybe the actual unit should be somehow configurable?
On the other hand, all of that could in theory be handled
later.

Was it right to add the drivers/iio/pot directory? Should it
have been drivers/iio/potentiometer? What about rheostats
which are very similar? Anyway, I just wanted to say that
I'm not attached to the naming.

This is my first interaction with IIO, please bear with me.

I have admittedly only tested the driver with a MCP4651 chip,
but that one is the biggest in the family...

Changes since v1:
- Make it an IIO driver instead
- Don't convolute the code with big obscure macros
- Inline the bits from mcp4xxx_dpot.h that are actually used
  and drop that file
- Better Changelog

Cheers,
Peter

Peter Rosin (1):
  iio: mcp4xxx_dpot: Driver for Microchip digital potentiometers

 MAINTAINERS                    |    5 +
 drivers/iio/Kconfig            |    1 +
 drivers/iio/Makefile           |    1 +
 drivers/iio/pot/Kconfig        |   20 ++++
 drivers/iio/pot/Makefile       |    6 ++
 drivers/iio/pot/mcp4xxx_dpot.c |  218 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 251 insertions(+)
 create mode 100644 drivers/iio/pot/Kconfig
 create mode 100644 drivers/iio/pot/Makefile
 create mode 100644 drivers/iio/pot/mcp4xxx_dpot.c

-- 
1.7.10.4
