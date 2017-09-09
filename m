Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:47147 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbdIIScq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 9 Sep 2017 14:32:46 -0400
Message-Id: <cover.1504807204.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 9 Sep 2017 20:32:41 +0200
Subject: [PATCH v2 0/6] IIO driver for MCP3550/1/3
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Phil Elwell <phil@raspberrypi.org>,
        Oskar Andero <oskar.andero@gmail.com>,
        Andrea Galbusera <gizero@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Manfred Schlaegl <manfred.schlaegl@gmx.at>,
        Michael Welling <mwelling@ieee.org>,
        Soeren Andersen <san@rosetechnology.dk>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

One speedup, one cleanup, one kerneldoc patch for mcp320x.c
plus support for the MCP3550/1/3 used by the "Revolution Pi"
family of open source PLCs (https://revolution.kunbus.com/).

Changes since v1:
- Drop two patches which are now queued. (Jonathan)

- Move kerneldoc to separate patch. (Jonathan)

- Move support for continuous conversion mode to separate patch
  which is marked informational / not for merging.  Rename device
  property to "continuous" for consistency with the existing
  similar property of drivers/iio/light/us5182d.c. (Rob, Jonathan)

- Rework calculation of raw value in patch [5/6]:  Instead of
  byte-wise mangling, convert the big endian value clocked out
  by the chip to host byte order and mangle the resulting 32-bit
  value.  Reduces the amount of code and improves readability as
  the bit numbers referenced in the code comment and datasheet
  are used verbatim in the code.

- Use switch/case-statement instead of if-clause when applying
  chip-specific quirks in mcp320x_probe(). (Jonathan)

- Expand code comment explaining the two consecutive conversions
  in mcp320x_probe(). (Jonathan)

Thanks,

Lukas


Lukas Wunner (6):
  iio: adc: mcp320x: Speed up readout of single-channel ADCs
  iio: adc: mcp320x: Drop unnecessary of_device_id attributes
  iio: adc: mcp320x: Document struct mcp320x
  dt-bindings: iio: adc: mcp320x: Update for mcp3550/1/3
  iio: adc: mcp320x: Add support for mcp3550/1/3
  iio: adc: mcp320x: Support continuous conversion mode

 .../devicetree/bindings/iio/adc/mcp320x.txt        |  23 ++
 drivers/iio/adc/Kconfig                            |   5 +-
 drivers/iio/adc/mcp320x.c                          | 240 ++++++++++++++-------
 3 files changed, 188 insertions(+), 80 deletions(-)

-- 
2.11.0

