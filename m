Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.babblebit.net ([37.139.8.208]:48282 "EHLO
        mail.babblebit.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbeKUAqu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Nov 2018 19:46:50 -0500
From: Chris Coffey <cmc@babblebit.net>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Peter Rosin <peda@axentia.se>, Slawomir Stepien <sst@poczta.fm>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Chris Coffey <cmc@babblebit.net>
Subject: [PATCH v3 0/2] Add support for Microchip MCP41xxx/42xxx potentiometers
Date: Tue, 20 Nov 2018 14:17:11 +0000
Message-Id: <20181120141713.9963-1-cmc@babblebit.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello all,

This patch series adds device-tree documentation and driver support
for the Microchip MCP41xxx/42xxx family of digital potentiometers.

Changes in v3:
 - Get device names from mcp41010_cfg struct instead of spi device as
   suggested by Jonathan Cameron.
 - Refactor code structure in mcp41010_write_raw() as recommended by
   Jonathan Cameron.
 - Only call spi_get_device_id() when necessary to load config as
   suggested by Slawomir Stepien.
 - In mcp41010_probe(), return err to make static checkers happy as
   recommended by Jonathan Cameron.
 - Edit mcp41010_match struct members to fit on one line as suggested
   by Slawomir Stepien.
 - In device tree binding documentation, add company name to example
   as pointed out by Slawomir Stepien.
 - In device tree binding documentation, remove mcp41010 prefix from
   example as suggested by Jonathan Cameron.

Changes in v2:
 - Move device tree binding documentation to separate commit as
   pointed out by Himanshu Jha.
 - Remove explicit '= 0' initialization in mcp41010_type enum as
   recommended by Himanshu Jha.
 - Change MCP41010_WRITE from (0x01 << 4) to BIT(4) as recommended by
   Himanshu Jha.
 - Use of_device_get_match_data() to load configuration as 
   recommended by Peter Rosin. 
 - Rename MCP41010_WIPER_ENABLE to MCP41010_WIPER_CHANNEL as 
   suggested by Peter Rosin.
 - Remove CONFIG_OF build protections as recommended by Jonathan
   Cameron.
 - Remove of_match_ptr wrapper from mcp41010_driver struct as 
   recommended by Jonathan Cameron.
 - Remove blank line in mcp41010.c intro as recommended by Jonathan
   Cameron.

Chris Coffey (2):
  dt-bindings: iio: potentiometer: Add Microchip MCP41xxx/42xxx
  iio: potentiometer: Add driver for Microchip MCP41xxx/42xxx

 .../bindings/iio/potentiometer/mcp41010.txt        |  29 +++
 drivers/iio/potentiometer/Kconfig                  |  12 ++
 drivers/iio/potentiometer/Makefile                 |   1 +
 drivers/iio/potentiometer/mcp41010.c               | 204 +++++++++++++++++++++
 4 files changed, 246 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt
 create mode 100644 drivers/iio/potentiometer/mcp41010.c

-- 
2.11.0
