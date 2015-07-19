Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	marex@denx.de,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH 0/2] iio: temperature: add mcp98xx driver support
Date: Sat, 18 Jul 2015 20:04:11 -0700
Message-Id: <1437275053-16211-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This changeset adds driver support for the Microchip mcp98xx series of
temperature sensors.

This includes temperature reading, and rising/falling threshold events.

Matt Ranostay (2):
  iio: temperature: DT binding doc for mcp98xx
  iio: temperature: add support for mcp98xx sensors

 .../bindings/iio/temperature/mcp98xx.txt           |  22 +
 drivers/iio/temperature/Kconfig                    |  10 +
 drivers/iio/temperature/Makefile                   |   1 +
 drivers/iio/temperature/mcp98xx.c                  | 588 +++++++++++++++++++++
 4 files changed, 621 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/mcp98xx.txt
 create mode 100644 drivers/iio/temperature/mcp98xx.c

-- 
1.9.1
