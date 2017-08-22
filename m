Return-Path: <SRS0=1TP6=7Y=wunner.de=lukas@kernel.org>
Message-Id: <cover.1503407738.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 22 Aug 2017 15:33:00 +0200
Subject: [PATCH 0/6] IIO driver for MCP3550/1/3
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Mathias Duckeck <m.duckeck@kunbus.de>, Phil Elwell <phil@raspberrypi.org>, Oskar Andero <oskar.andero@gmail.com>, Andrea Galbusera <gizero@gmail.com>, Akinobu Mita <akinobu.mita@gmail.com>, Manfred Schlaegl <manfred.schlaegl@gmx.at>, Michael Welling <mwelling@ieee.org>, Soeren Andersen <san@rosetechnology.dk>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-ID: <linux-iio@vger.kernel.org>

Two fixes, one speedup & one cleanup for the mcp320x.c driver,
plus support for new chips:

The MCP3550/1/3 are 22 bit delta-sigma ADCs with high accuracy,
low noise characteristics and an extended temperature range.
It's the top-of-the-line SPI ADC in Microchip's portfolio.

The chip is used by the "Revolution Pi" family of open source PLCs
based on the Raspberry Pi (https://revolution.kunbus.com/).

Thanks,

Lukas


Lukas Wunner (6):
  iio: adc: mcp320x: Fix oops on module unload
  iio: adc: mcp320x: Fix readout of negative voltages
  iio: adc: mcp320x: Speed up readout of single-channel ADCs
  iio: adc: mcp320x: Drop unnecessary of_device_id attributes
  dt-bindings: iio: adc: mcp320x: Update for mcp3550/1/3
  iio: adc: mcp320x: Add support for mcp3550/1/3

 .../devicetree/bindings/iio/adc/mcp320x.txt        |  23 ++
 drivers/iio/adc/Kconfig                            |   5 +-
 drivers/iio/adc/mcp320x.c                          | 264 ++++++++++++++-------
 3 files changed, 202 insertions(+), 90 deletions(-)

-- 
2.11.0
