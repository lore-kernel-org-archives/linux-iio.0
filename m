Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57579 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932328AbcISShy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2016 14:37:54 -0400
To: Greg KH <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] 3rd set of IIO new drivers, functionality and cleanups for the
 4.9 cycle.
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0d5ce522-69ac-ef6c-d77a-87f7be059ad5@kernel.org>
Date: Mon, 19 Sep 2016 19:37:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 6841b2a0fccf930e80e0c7d7f1bd8d78d21cd0fa:

  Staging: dgnc: dgnc_tty: fixed a line too long style issue (2016-09-17 23:47:12 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.9c

for you to fetch changes up to ac45e57f15903747ccd5a14cebfbd673ebcbdd6f:

  iio: light: Add driver for Silabs si1132, si1141/2/3 and si1145/6/7 ambient light, uv index and proximity sensors (2016-09-18 19:56:39 +0100)

----------------------------------------------------------------
Third set of new device support, functionality and cleanups for IIO in the 4.9 cycle.

Given Linus is hinting (strongly!) at an rc8 this last set is hopefully in
time for the 4.9 merge window.  The zpa2326 and si1145 drivers provide
fine illustrations that devices aren't getting any simpler!

I'm also particularly pleased Linus Walliej did such a thorough job of cleaning
up one of my old drivers.

New device support
* mCube MC3230 accelerometer
  - new fairly minimal driver.
* Murata zpa2326
  - extensive new driver supporting the rather 'novel' buffering of data this
    device provides and handling both it's own data ready trigger and other
    triggers rather elegantly.
* si1141, si1142, si1143, si1145, si1146 and si1147 proximity, UV, visible and
  IR sensors.
  - another extensive new driver supporting all the key bits of what this
    set of devices supplies including dataready triggers, buffers and all the
    various data channels.

Functionality
* kxsd9 - Linus brought this scratch driver I wrote in one afternoon years ago
  up to date adding lots of good stuff along the way.
  - SPI support after extensive rework of the driver.
  - Triggered buffer capture support.
  - Runtime PM.
  - Regulator handling.
  - Mounting matrix support.
* mma7660
  - Add MODULE_DEVICE_TABLE to support autoprobing.

Cleanups
* ad5933
  - Align some function arguements nicely.
* med_z188
  - Constify iio_info structure.
* sca3000
  - Implement IIO_CHAN_INFO_SAMP_FREQ rather than a hand rolled attr.
    There are still quite a few drivers that would benefit from similar updates.
* ssp_sensors
  - Constify iio_info structures in accel and gyro drivers.

----------------------------------------------------------------
Gregor Boirie (1):
      iio:pressure: initial zpa2326 barometer support

Hans de Goede (2):
      iio: accel: mma7660: fix missing MODULE_DEVICE_TABLE(i2c)
      iio: accel: Add driver for the mCube MC3230 3-axis accelerometer

Ico Doornekamp (1):
      iio: accel: sca3000_core: implemented IIO_CHAN_INFO_SAMP_FREQ

Julia Lawall (3):
      iio: common: ssp_sensors: accel: constify iio_info structures
      iio: adc: men_z188_adc: constify iio_info structures
      iio: common: ssp_sensors: gyro: constify iio_info structures

Katie Dunne (1):
      staging: iio: ad5933: align arguments on new line with open parenthesis

Linus Walleij (14):
      iio: accel: kxsd9: Split out transport mechanism
      iio: accel: kxsd9: split out a common remove() function
      iio: accel: kxsd9: Split out SPI transport
      iio: accel: kxsd9: Do away with the write2 helper
      iio: accel: kxsd9: Convert to use regmap for transport
      iio: accel: kxsd9: Add I2C transport
      iio: accel: kxsd9: Drop the buffer lock
      iio: accel: kxsd9: Fix up offset and scaling
      iio: accel: kxsd9: Add triggered buffer handling
      iio: accel: kxsd9: Deploy proper register bit defines
      iio: accel: kxsd9: Fetch and handle regulators
      iio: accel: kxsd9: Replace "parent" with "dev"
      iio: accel: kxsd9: Deploy system and runtime PM
      iio: accel: kxsd9: Support reading a mounting matrix

Peter Meerwald-Stadler (1):
      iio: light: Add driver for Silabs si1132, si1141/2/3 and si1145/6/7 ambient light, uv index and proximity sensors

 .../devicetree/bindings/i2c/trivial-devices.txt    |    1 +
 .../devicetree/bindings/iio/pressure/zpa2326.txt   |   31 +
 drivers/iio/accel/Kconfig                          |   35 +-
 drivers/iio/accel/Makefile                         |    3 +
 drivers/iio/accel/kxsd9-i2c.c                      |   64 +
 drivers/iio/accel/kxsd9-spi.c                      |   56 +
 drivers/iio/accel/kxsd9.c                          |  435 +++--
 drivers/iio/accel/kxsd9.h                          |   12 +
 drivers/iio/accel/mc3230.c                         |  211 +++
 drivers/iio/accel/mma7660.c                        |    1 +
 drivers/iio/accel/ssp_accel_sensor.c               |    2 +-
 drivers/iio/adc/men_z188_adc.c                     |    2 +-
 drivers/iio/gyro/ssp_gyro_sensor.c                 |    2 +-
 drivers/iio/light/Kconfig                          |   13 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/si1145.c                         | 1404 ++++++++++++++++
 drivers/iio/pressure/Kconfig                       |   22 +
 drivers/iio/pressure/Makefile                      |    3 +
 drivers/iio/pressure/zpa2326.c                     | 1735 ++++++++++++++++++++
 drivers/iio/pressure/zpa2326.h                     |   89 +
 drivers/iio/pressure/zpa2326_i2c.c                 |   99 ++
 drivers/iio/pressure/zpa2326_spi.c                 |  103 ++
 drivers/staging/iio/accel/sca3000.h                |    1 +
 drivers/staging/iio/accel/sca3000_core.c           |  242 ++-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   38 +-
 25 files changed, 4367 insertions(+), 238 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/zpa2326.txt
 create mode 100644 drivers/iio/accel/kxsd9-i2c.c
 create mode 100644 drivers/iio/accel/kxsd9-spi.c
 create mode 100644 drivers/iio/accel/kxsd9.h
 create mode 100644 drivers/iio/accel/mc3230.c
 create mode 100644 drivers/iio/light/si1145.c
 create mode 100644 drivers/iio/pressure/zpa2326.c
 create mode 100644 drivers/iio/pressure/zpa2326.h
 create mode 100644 drivers/iio/pressure/zpa2326_i2c.c
 create mode 100644 drivers/iio/pressure/zpa2326_spi.c
