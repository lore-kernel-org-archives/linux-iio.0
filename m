Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34977 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbcF3HfR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jun 2016 03:35:17 -0400
From: Florian Vaussard <florian.vaussard@gmail.com>
To: devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Peter Rosin <peda@axentia.se>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Slawomir Stepien <sst@poczta.fm>,
	Joachim Eastwood <manabian@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Vaussard <florian.vaussard@heig-vd.ch>
Subject: [PATCH v3 0/4] iio: potentiometer: mcp4531: New parts, DT and typo
Date: Thu, 30 Jun 2016 09:34:47 +0200
Message-Id: <1467272091-28087-1-git-send-email-florian.vaussard@heig-vd.ch>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

This series first adds support for parts missing from mcp4531 driver
(MCP454x, MCP456x, MCP464x and MCP466x). It then introduces the necessary
device tree binding to perform DT boot. Finally it fixes a typo in the
Kconfig.

Tested with MCP4561-103 and MCP4561-503 (DT boot).

Best regards,
Florian

---
Since v2:
- Fixed 7-bit/8-bit mix in the DT documentation
- Use a macro to declare compatibles in the macro, as suggested by Peter

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

 .../devicetree/bindings/i2c/trivial-devices.txt    |  64 +++++++++
 drivers/iio/potentiometer/Kconfig                  |  12 +-
 drivers/iio/potentiometer/mcp4531.c                | 159 ++++++++++++++++++++-
 3 files changed, 229 insertions(+), 6 deletions(-)

-- 
2.5.5

