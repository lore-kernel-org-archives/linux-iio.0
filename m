Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:33825 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbcFUGz4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2016 02:55:56 -0400
From: Florian Vaussard <florian.vaussard@gmail.com>
To: devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Peter Rosin <peda@axentia.se>,
	Slawomir Stepien <sst@poczta.fm>,
	Joachim Eastwood <manabian@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Vaussard <florian.vaussard@heig-vd.ch>
Subject: [PATCH 0/3] iio: potentiometer: mcp4531: New parts and device tree
Date: Tue, 21 Jun 2016 08:55:34 +0200
Message-Id: <1466492137-32683-1-git-send-email-florian.vaussard@heig-vd.ch>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

This series first adds support for parts missing from mcp4531 driver
(MCP454x, MCP456x, MCP464x and MCP466x). It then introduces the necessary
device tree binding to perform DT boot.

Tested with MCP4561-103 and MCP4561-503 (DT boot).

Best regards,
Florian

Florian Vaussard (3):
  iio: potentiometer: mcp4531: Add support for MCP454x, MCP456x, MCP464x
    and MCP466x
  iio: potentiometer: mcp4531: Add device tree binding documentation
  iio: potentiometer: mcp4531: Add device tree binding

 .../bindings/iio/potentiometer/mcp4531.txt         |  84 +++++++++++
 drivers/iio/potentiometer/Kconfig                  |   6 +-
 drivers/iio/potentiometer/mcp4531.c                | 155 ++++++++++++++++++++-
 3 files changed, 242 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/mcp4531.txt

-- 
2.5.0

