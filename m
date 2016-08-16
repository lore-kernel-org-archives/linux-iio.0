Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 00/17] KCSD9 driver cleanup and modernization
Date: Tue, 16 Aug 2016 15:33:26 +0200
Message-Id: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

This patch series:

- Fixes a bunch of bugs in the KXSD9 driver.

- Make the KXSD9 driver actually report m/s^2 and removes
  a fat offset.

- Adds I2C support.

- Adds triggered buffer handling.

- Adds system and runtime PM.

- Adds support for the mounting matrix.

- Adds device tree bindings.

- Misc cleanup.

Some of it should arguably go into stable but I am pretty well
convinced that this driver is in use by one person in the world:
me.

Jonathan: if you wanna try it on your SPI-based KXSD9 (if it
doesn't work I am pretty sure all fixing just need to happen in
kxsd9-spi.c) go ahead, but unless there is some horrific problem
with any of the patches and you don't have time to test it on
SPI I would just take them and run ;)

Linus Walleij (17):
  iio: accel: kxsd9: Add device tree bindings
  iio: accel: kxsd9: Fix raw read return
  iio: accel: kxsd9: Split out transport mechanism
  iio: accel: kxsd9: Use devm_iio_device_register()
  iio: accel: kxsd9: Split out SPI transport
  iio: accel: kxsd9: Do away with the write2 helper
  iio: accel: kxsd9: Convert to use regmap for transport
  iio: accel: kxsd9: Add I2C transport
  iio: accel: kxsd9: Drop the buffer lock
  iio: accel: kxsd9: Fix scaling bug
  iio: accel: kxsd9: Fix up offset and scaling
  iio: accel: kxsd9: Add triggered buffer handling
  iio: accel: kxsd9: Deploy proper register bit defines
  iio: accel: kxsd9: Fetch and handle regulators
  iio: accel: kxsd9: Replace "parent" with "dev"
  iio: accel: kxsd9: Deploy system and runtime PM
  iio: accel: kxsd9: Support reading a mounting matrix

 .../devicetree/bindings/iio/accel/kionix,kxsd9.txt |  22 ++
 drivers/iio/accel/Kconfig                          |  25 +-
 drivers/iio/accel/Makefile                         |   2 +
 drivers/iio/accel/kxsd9-i2c.c                      |  64 +++
 drivers/iio/accel/kxsd9-spi.c                      |  56 +++
 drivers/iio/accel/kxsd9.c                          | 438 ++++++++++++++++-----
 drivers/iio/accel/kxsd9.h                          |  12 +
 7 files changed, 522 insertions(+), 97 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.txt
 create mode 100644 drivers/iio/accel/kxsd9-i2c.c
 create mode 100644 drivers/iio/accel/kxsd9-spi.c
 create mode 100644 drivers/iio/accel/kxsd9.h

-- 
2.7.4
