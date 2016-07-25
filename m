Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35336 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbcGYPV2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2016 11:21:28 -0400
From: Aleksei Mamlin <mamlinav@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Aleksei Mamlin <mamlinav@gmail.com>
Subject: [PATCH v2 0/2] Add driver for Domintech DMARD06 accelerometer
Date: Mon, 25 Jul 2016 18:21:16 +0300
Message-Id: <1469460078-6460-1-git-send-email-mamlinav@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch series adds driver for Domintech DMARD05, DMARD06 and DMARD07
accelerometers and vendor prefix for Domintech Co., Ltd.

Changes since v1:
 - Add Rob's Acked-by to vendor-prefix bindings
 - Remove dmard06_i2c_read function, use i2c_smbus_read_byte_data instead
 - Remove dmard06_read_chip_id function, check chip id directly on probe
 - Use sign_extend32 in dmard06_read_raw function
 - Replace error variable with ret
 - Remove unnecessary messages
 - Fix typo in documentation bindings
 - Add support for DMARD05 and DMARD07 chips
 - Add PM ops

Aleksei Mamlin (2):
  devicetree: bindings: Add vendor prefix for Domintech Co., Ltd.
  iio: accel: Add support for Domintech DMARD06 accelerometer

 .../devicetree/bindings/iio/accel/dmard06.txt      |  19 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/accel/Kconfig                          |  11 +
 drivers/iio/accel/Makefile                         |   1 +
 drivers/iio/accel/dmard06.c                        | 241 +++++++++++++++++++++
 5 files changed, 273 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/dmard06.txt
 create mode 100644 drivers/iio/accel/dmard06.c

-- 
2.7.3

