Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:36435 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbcF0Qan (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2016 12:30:43 -0400
Received: by mail-lf0-f53.google.com with SMTP id q132so159943228lfe.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Jun 2016 09:30:37 -0700 (PDT)
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
Subject: [PATCH 00/10] Improve the BMP280 driver v3
Date: Mon, 27 Jun 2016 18:30:10 +0200
Message-Id: <1467045020-2665-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes in this version:

- Build robot is happy, also with allmodconfig

- Added some collected ACKs and Tested-by's

- Fixed all review comments

- Added runtime PM on top: after fixing the review comments for
  the regulators it was such a tempting move that I couldn't
  resist

Jonathan: if you want to keep the old DT binding patch you can
drop patch 1 or ask me to provide a patch patching the patch, it
adds the new BME280 as well.

Linus Walleij (10):
  iio: pressure: bmp280: augment DT bindings
  iio: pressure: bmp280: support device tree initialization
  iio: pressure: bmp280: add reset GPIO line handling
  iio: pressure: bmp280: support supply regulators
  iio: pressure: bmp280: split driver in logical parts
  iio: pressure: bmp280: split off an I2C Kconfig entry
  iio: pressure: bmp280: add SPI interface driver
  iio: pressure: bmp280: add support for BMP085 EOC interrupt
  iio: pressure: bmp280: read calibration data once
  iio: pressure: bmp280: add power management

 .../devicetree/bindings/iio/pressure/bmp085.txt    |  15 +-
 drivers/iio/pressure/Kconfig                       |  28 +-
 drivers/iio/pressure/Makefile                      |   3 +
 drivers/iio/pressure/{bmp280.c => bmp280-core.c}   | 578 ++++++++++-----------
 drivers/iio/pressure/bmp280-i2c.c                  |  91 ++++
 drivers/iio/pressure/bmp280-regmap.c               |  84 +++
 drivers/iio/pressure/bmp280-spi.c                  | 125 +++++
 drivers/iio/pressure/bmp280.h                      | 112 ++++
 8 files changed, 737 insertions(+), 299 deletions(-)
 rename drivers/iio/pressure/{bmp280.c => bmp280-core.c} (72%)
 create mode 100644 drivers/iio/pressure/bmp280-i2c.c
 create mode 100644 drivers/iio/pressure/bmp280-regmap.c
 create mode 100644 drivers/iio/pressure/bmp280-spi.c
 create mode 100644 drivers/iio/pressure/bmp280.h

-- 
2.4.11

