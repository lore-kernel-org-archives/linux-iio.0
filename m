Return-Path: <florian.vaussard@gmail.com>
From: Florian Vaussard <florian.vaussard@gmail.com>
To: devicetree@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Peter Rosin <peda@axentia.se>,
	Slawomir Stepien <sst@poczta.fm>,
	Joachim Eastwood <manabian@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Florian Vaussard <florian.vaussard@heig-vd.ch>
Subject: [PATCH v2 0/4] iio: potentiometer: mcp4531: New parts, DT and typo
Date: Sun, 26 Jun 2016 22:22:43 +0200
Message-Id: <1466972567-9580-1-git-send-email-florian.vaussard@heig-vd.ch>
List-ID: <linux-iio@vger.kernel.org>

Hello,

This series first adds support for parts missing from mcp4531 driver
(MCP454x, MCP456x, MCP464x and MCP466x). It then introduces the necessary
device tree binding to perform DT boot. Finally it fixes a typo in the
Kconfig.

Tested with MCP4561-103 and MCP4561-503 (DT boot).

Best regards,
Florian

---
Since v1:
- Applied Acks
- Moved the binding to i2c/trivial-devices.txt
- Fixed data pointer handling in struct of_device_id
- Renamed struct of_device_id to mcp4531_of_match
- New patch to fix typo in Kconfig

Florian Vaussard (4):
  iio: potentiometer: mcp4531: Add support for MCP454x, MCP456x, MCP464x
    and MCP466x
  iio: potentiometer: mcp4531: Add device tree binding documentation
  iio: potentiometer: mcp4531: Add device tree binding
  iio: potentiometer: Fix typo in Kconfig

 .../devicetree/bindings/i2c/trivial-devices.txt    |  64 ++++
 drivers/iio/potentiometer/Kconfig                  |  12 +-
 drivers/iio/potentiometer/mcp4531.c                | 345 ++++++++++++++++++++-
 3 files changed, 415 insertions(+), 6 deletions(-)

-- 
2.5.5
