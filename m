Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35853 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbcFVUx4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jun 2016 16:53:56 -0400
Received: by mail-lf0-f48.google.com with SMTP id q132so82362667lfe.3
        for <linux-iio@vger.kernel.org>; Wed, 22 Jun 2016 13:53:55 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Matt Ranostay <mranostay@gmail.com>
Cc: Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/9] Improve BMP280 driver v2
Date: Wed, 22 Jun 2016 22:53:30 +0200
Message-Id: <1466628819-29784-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is version two of the previous patchset. Changes:

- Rebased on top of Matt Ranostays BME280 support patch so everything
  applies cleanly on top of Jonathans development branch

- Added Akinobu Mitas special SPI bus handling code snippets

- Made the regulators non-optional: if the chip has supplies, it should
  have regulators for them

- Fixed review comments and build remarks provided by the zeroday
  build robot

Linus Walleij (9):
  iio: pressure: bmp280: augment DT bindings
  iio: pressure: bmp280: support device tree initialization
  iio: pressure: bmp280: add reset GPIO line handling
  iio: pressure: bmp280: support supply regulators
  iio: pressure: bmp280: split driver in logical parts
  iio: pressure: bmp280: split off an I2C Kconfig entry
  iio: pressure: bmp280: add SPI interface driver
  iio: pressure: bmp280: add support for BMP085 EOC interrupt
  iio: pressure: bmp280: read calibration data once

 .../devicetree/bindings/iio/pressure/bmp085.txt    |   15 +-
 drivers/iio/pressure/Kconfig                       |   29 +-
 drivers/iio/pressure/Makefile                      |    3 +
 drivers/iio/pressure/bmp280-core.c                 | 1009 ++++++++++++++++++
 drivers/iio/pressure/bmp280-i2c.c                  |   83 ++
 drivers/iio/pressure/bmp280-regmap.c               |   81 ++
 drivers/iio/pressure/bmp280-spi.c                  |  118 +++
 drivers/iio/pressure/bmp280.c                      | 1118 --------------------
 drivers/iio/pressure/bmp280.h                      |  108 ++
 9 files changed, 1437 insertions(+), 1127 deletions(-)
 create mode 100644 drivers/iio/pressure/bmp280-core.c
 create mode 100644 drivers/iio/pressure/bmp280-i2c.c
 create mode 100644 drivers/iio/pressure/bmp280-regmap.c
 create mode 100644 drivers/iio/pressure/bmp280-spi.c
 delete mode 100644 drivers/iio/pressure/bmp280.c
 create mode 100644 drivers/iio/pressure/bmp280.h

-- 
2.4.11

