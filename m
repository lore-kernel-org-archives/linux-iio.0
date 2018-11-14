Return-Path: <SRS0=SU2m=NZ=babblebit.net=cmc@kernel.org>
From: Chris Coffey <cmc@babblebit.net>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Peter Rosin <peda@axentia.se>,
	Slawomir Stepien <sst@poczta.fm>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chris Coffey <cmc@babblebit.net>
Subject: [PATCH v2 0/2] Add support for Microchip MCP41xxx/42xxx potentiometers
Date: Wed, 14 Nov 2018 09:52:39 +0000
Message-Id: <20181114095241.27037-1-cmc@babblebit.net>
List-ID: <linux-iio@vger.kernel.org>

Hello all,

This patch series adds device-tree documentation and driver support
for the Microchip MCP41xxx/42xxx family of digital potentiometers.

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
 drivers/iio/potentiometer/mcp41010.c               | 216 +++++++++++++++++++++
 4 files changed, 258 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt
 create mode 100644 drivers/iio/potentiometer/mcp41010.c

-- 
2.11.0
