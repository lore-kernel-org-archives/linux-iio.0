Return-Path: <SRS0=A4gG=F6=axentia.se=peda@kernel.org>
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 0/2] iio: potentiometer: mcp4018: new driver
Date: Thu,  8 Mar 2018 20:58:28 +0100
Message-Id: <20180308195830.16348-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Hi!

Here's an iio driver for Microchip MCP4018 potentiometers, that
also covers a few variants (MCP4017 and MCP4019).

I found no existing potentiometer driver with a compatible
interface to piggyback on, so I did a new driver.

Cheers,
Peter

Peter Rosin (2):
  dt-bindings: trivial: add various mcp4017/18/19 potentiometers
  iio: potentiometer: mcp4018: driver for Microchip digital
    potentiometers

 .../devicetree/bindings/trivial-devices.txt        |  12 ++
 MAINTAINERS                                        |   3 +-
 drivers/iio/potentiometer/Kconfig                  |  11 ++
 drivers/iio/potentiometer/Makefile                 |   1 +
 drivers/iio/potentiometer/mcp4018.c                | 194 +++++++++++++++++++++
 5 files changed, 220 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/potentiometer/mcp4018.c

-- 
2.11.0
