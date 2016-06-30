Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:34439 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbcF3BtC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jun 2016 21:49:02 -0400
Received: by mail-lf0-f41.google.com with SMTP id h129so45218436lfh.1
        for <linux-iio@vger.kernel.org>; Wed, 29 Jun 2016 18:49:01 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 00/10] Improve the BMP280 driver v4
Date: Thu, 30 Jun 2016 03:48:44 +0200
Message-Id: <1467251334-30594-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This version should finally deal with all complaints from
build robots and the last round of review comments.

Since reading calibration once seems to be most controversial
I moved it to the end of the series, so it can be applied up
to that point.

The first patch with the DT bindings can also be dropped if
the old one is already applied, just minor things anyway.

Linus Walleij (10):
  iio: pressure: bmp280: augment DT bindings
  iio: pressure: bmp280: support device tree initialization
  iio: pressure: bmp280: add reset GPIO line handling
  iio: pressure: bmp280: support supply regulators
  iio: pressure: bmp280: split driver in logical parts
  iio: pressure: bmp280: split off an I2C Kconfig entry
  iio: pressure: bmp280: add SPI interface driver
  iio: pressure: bmp280: add support for BMP085 EOC interrupt
  iio: pressure: bmp280: add power management
  iio: pressure: bmp280: read calibration data once

 .../devicetree/bindings/iio/pressure/bmp085.txt    |  15 +-
 drivers/iio/pressure/Kconfig                       |  28 +-
 drivers/iio/pressure/Makefile                      |   3 +
 drivers/iio/pressure/{bmp280.c => bmp280-core.c}   | 567 ++++++++++-----------
 drivers/iio/pressure/bmp280-i2c.c                  |  91 ++++
 drivers/iio/pressure/bmp280-regmap.c               |  84 +++
 drivers/iio/pressure/bmp280-spi.c                  | 125 +++++
 drivers/iio/pressure/bmp280.h                      | 112 ++++
 8 files changed, 730 insertions(+), 295 deletions(-)
 rename drivers/iio/pressure/{bmp280.c => bmp280-core.c} (73%)
 create mode 100644 drivers/iio/pressure/bmp280-i2c.c
 create mode 100644 drivers/iio/pressure/bmp280-regmap.c
 create mode 100644 drivers/iio/pressure/bmp280-spi.c
 create mode 100644 drivers/iio/pressure/bmp280.h

-- 
2.4.11

