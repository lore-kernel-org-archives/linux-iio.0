Return-Path: <SRS0=uEUa=L3=lechnology.com=david@kernel.org>
From: David Lechner <david@lechnology.com>
To: linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] spi: introduce SPI_CS_WORD mode flag
Date: Wed, 12 Sep 2018 19:39:16 -0500
Message-Id: <20180913003920.30600-1-david@lechnology.com>
List-ID: <linux-iio@vger.kernel.org>

This series introduces a new SPI mode flag, SPI_CS_WORD, that indicates that
the chip select line should be toggled after each word sent. This series
includes examples of how this can be implemented for both an SPI controller
and an SPI device.

The motivation here is to take advantage of DMA transfers with an analog/digital
convert chip. This chip requires that the chip select line be toggled after
each word send in order to drive the internal circuitry of the chip.

The way we were accomplishing this was, for example, to read 16 channels, we
would create 16 SPI _transfer_s in one SPI _message_. Although this works, it
uses quite a bit of CPU because we have to do work at the end of each transfer
to get the next transfer ready. When you are polling the chip at 100Hz, this
CPU usage adds up.

The SPI controller being used has DMA support, but only on the _transfer_ level
and not on the _message_ level. So, to take advantage of DMA, we need to read
all of the A/DC channels in a single _transfer_. The SPI controller is capable
automatically toggling the chip select line during a DMA transfer, so we are
adding a new SPI flag in order to take advantage of this.

I have tested both the default software implementation and the spi-davinci
implementation with the A/DC driver in this series.

v2 changes:
- dropped patch "spi: spi-bitbang: change flags from u8 to u16" that has already
  been applied
- new patch "spi: add software implementation for SPI_CS_WORD" that provides
  a default implementation of SPI_CS_WORD for controllers

David Lechner (4):
  spi: add new SPI_CS_WORD flag
  spi: add software implementation for SPI_CS_WORD
  iio: adc: ti-ads7950: use SPI_CS_WORD to reduce CPU usage
  spi: spi-davinci: Add support for SPI_CS_WORD

 drivers/iio/adc/ti-ads7950.c | 53 +++++++++++++++++++++---------------
 drivers/spi/spi-davinci.c    | 11 ++++++--
 drivers/spi/spi.c            | 32 +++++++++++++++++++++-
 include/linux/spi/spi.h      |  2 +-
 4 files changed, 71 insertions(+), 27 deletions(-)

-- 
2.17.1
