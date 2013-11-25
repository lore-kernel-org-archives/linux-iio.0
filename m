Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58832 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565Ab3KYVCe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Nov 2013 16:02:34 -0500
Message-ID: <5293BAE8.8090800@kernel.org>
Date: Mon, 25 Nov 2013 21:02:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new drivers, features and cleanups for 3.14 - set 1
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit ed5d6ca0038f274aada1244358ad89b7941bdcbf:

  staging: drm/imx: fix return value check in ipu_add_subdevice_pdata() (2013-10-30 10:17:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.14a

for you to fetch changes up to 794a870e776717ccbd27676a551250613de9c40c:

  staging: iio: ad2s1200: Use devm_iio_device_register (2013-11-24 21:07:22 +0000)

----------------------------------------------------------------
First set of new features, drivers and cleanups for IIO in the 3.14 cycle.
This mostly consists of patches that didn't quite make the last cycle. Lots
of interesting things under review currently.

Core:
- Add devm_iio_device_register/unregister.  I took some convincing on whether
  there would be many devices that really were simple enough to need no
  explicit actions on removal.  Turns out there are some.
- Move some stray docs to above the relevant implemenation.
- Drop a redundant repeated check on the fact the trigger has actually changed
  when there is a userspace attempt change it.

Drivers:
New drivers
- Freescale MPL3115A2 Pressure / temperature sensor

New functionality
- hid_sensors: add sensitivity support.

DT bindings
- tsl2563
- hmc5843

Cleanups
- Drop unused scan_type from viperboard adc driver.
- devm_iio_device_register used in viperboard, ad5421, ad5755, adis16130,
  adxrs450, vcnl4000, adis16220, ad7816, lpc32xx, adt7316, adis16060, isl29018
  and ad2s1200.  Note that this was proposed in a number of other drivers
  and this revealed a number of missorderings in remove functions.  Also for
  now I have blocked this on any device that any hardware suspend suport on
  the basis that we probably want to power down devices if they have no driver
  support loaded.

----------------------------------------------------------------
NeilBrown (1):
      iio:magnetometer:hmc5843 - add basic dt support

Peter Meerwald (4):
      iio: Drop scan_type from viperboard adc driver
      iio: Minor kerneldoc fix for iio_trigger_write_current()
      iio: Remove redundant check that new trigger is different from old
      iio: Add Freescale MPL3115A2 pressure / temperature sensor driver

Sachin Kamat (16):
      iio: core: Implement devm_iio_device_{register,unregister}
      iio: core: Move kernel doc to the right location
      iio: adc: mcp3422: Use devm_iio_device_register
      iio: adc: viperboard: Use devm_iio_device_register
      iio: dac: ad5421: Use devm_iio_device_register
      iio: dac: ad5755: Use devm_iio_device_register
      iio: gyro: adis16130: Use devm_iio_device_register
      iio: gyro: adxrs450: Use devm_iio_device_register
      iio: light: vcnl4000: Use devm_iio_device_register
      staging: iio: adis16220: Use devm_iio_device_register
      staging: iio: ad7816: Use devm_iio_device_register
      staging: iio: lpc32xx_adc: Use devm_iio_device_register
      staging: iio: addac: Use devm_iio_device_register
      staging: iio: adis16060: Use devm_iio_device_register
      staging: iio: isl29018: Use devm_iio_device_register
      staging: iio: ad2s1200: Use devm_iio_device_register

Sebastian Reichel (1):
      iio:light:tsl2563: Add DT support

Srinivas Pandruvada (4):
      iio: hid-sensors: accelerometer: Add sensitivity
      iio: hid-sensors: gyro : Add sensitivity
      iio: hid-sensors: light/als : Add sensitivity
      iio: hid-sensors: magnetometer : Add sensitivity

 .../devicetree/bindings/iio/light/tsl2563.txt      |  19 ++
 .../bindings/iio/magnetometer/hmc5843.txt          |  17 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 Documentation/driver-model/devres.txt              |   2 +
 drivers/iio/accel/hid-sensor-accel-3d.c            |  12 +
 drivers/iio/adc/mcp3422.c                          |   9 +-
 drivers/iio/adc/viperboard_adc.c                   |  20 +-
 drivers/iio/dac/ad5421.c                           |  12 +-
 drivers/iio/dac/ad5755.c                           |  12 +-
 drivers/iio/gyro/adis16130.c                       |   9 +-
 drivers/iio/gyro/adxrs450.c                        |  14 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |  11 +
 drivers/iio/industrialio-core.c                    | 101 +++++++
 drivers/iio/industrialio-event.c                   |   6 +
 drivers/iio/industrialio-trigger.c                 |  28 +-
 drivers/iio/light/hid-sensor-als.c                 |  11 +
 drivers/iio/light/tsl2563.c                        |   4 +
 drivers/iio/light/vcnl4000.c                       |   9 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |  12 +
 drivers/iio/pressure/Kconfig                       |  12 +
 drivers/iio/pressure/Makefile                      |   1 +
 drivers/iio/pressure/mpl3115.c                     | 329 +++++++++++++++++++++
 drivers/staging/iio/accel/adis16220_core.c         |   7 +-
 drivers/staging/iio/adc/ad7816.c                   |  12 +-
 drivers/staging/iio/adc/lpc32xx_adc.c              |  12 +-
 drivers/staging/iio/addac/adt7316-i2c.c            |   6 -
 drivers/staging/iio/addac/adt7316-spi.c            |   6 -
 drivers/staging/iio/addac/adt7316.c                |  12 +-
 drivers/staging/iio/addac/adt7316.h                |   1 -
 drivers/staging/iio/gyro/adis16060_core.c          |  10 +-
 drivers/staging/iio/light/isl29018.c               |  13 +-
 drivers/staging/iio/magnetometer/hmc5843.c         |   7 +
 drivers/staging/iio/resolver/ad2s1200.c            |  10 +-
 include/linux/hid-sensor-ids.h                     |   8 +
 include/linux/iio/iio.h                            |  81 +----
 35 files changed, 598 insertions(+), 238 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2563.txt
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/hmc5843.txt
 create mode 100644 drivers/iio/pressure/mpl3115.c
