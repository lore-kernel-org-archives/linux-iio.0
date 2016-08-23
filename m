Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37025 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758061AbcHWVvB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Aug 2016 17:51:01 -0400
To: Greg KH <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] First round of new drivers, features and cleanups for IIO in
 the 4.9 cycle.
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5796c08f-9fc2-e8e1-4851-afad7ff2c02d@kernel.org>
Date: Tue, 23 Aug 2016 22:41:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 0ddfd857130d16b1fb1e45c5ab2321a65738d70b:

  drivers:iio:accel:mma8452: removed unwanted return statements (2016-07-05 21:05:01 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.9a

for you to fetch changes up to 87557ade38f3d465f4935d63d74a7590e7d69e1a:

  iio: accel: kxsd9: Add device tree bindings (2016-08-21 20:41:05 +0100)

----------------------------------------------------------------
First round of new features, device support and cleanups for IIO in the 4.9 cycle.

Device support

* ak8974
  - New driver and bindings for this 2009 vintage magnetometer (it was very
    popular back then!)
* atlas-ph-sensor
  -  ORP sensor support(I had to look up what one of these was)
* cio-dac
  - New driver for Measurement Computing DAC boards
* dmard06
  - New driver for Domintech DMARDO6 accelerometer. Also vendor prefix.
* dmard09
  - New driver for Domintech DMARD09 accelerometer.
* maxim-thermocouple
  - max6675 and max31855 new driver
* mt6577 auxdac
  - new driver for this Mediatek chip mt2701, mt6577 and mt8173 have this
    hardware.
* ti-adc161s626
  - new driver for this TI single channel differential ADC.
* vcnl4000
  - support vcnl4010 and vcnl4020 which are compatible for all features
    currently supported by this driver.

New features

* Core
  - Allow retrieving of underlying iio_dev from a callback buffer handle.
    This is needed to allow client drivers to perform operations such as
    configuring the trigger used.
* hid-sensors
  - asynchronous resume support to avoid really long resume times.
* kxcjk-1013
  - add the mysterious KIOX000A ACPI id seen in the wild.
* Tools
  - lsiio now enumerates processed as well as raw channels.

Cleanup

* ad7298
  - use iio_device_claim_direct_mode and friends to simplify locking around
    mode switching and drop some boilerplate.
* ad7793
  - use iio_device_claim_direct_mode and friends to simplify locking around
    mode switching and drop some boilerplate.
* ade7854
  - checkpatch fixups (alignment of parameters)
* atlas-ph-sensor
  - use iio_device_claim_direct_mode and friends to simplify locking around
    mode switching and drop some boilerplate.
  - Switch to REGCACHE_NONE as there are no useful register to cache.
* bma180
  - use iio_device_claim_direct_mode and friends to simplify locking around
    mode switching and drop some boilerplate.
* hdc100x
  - Add mention of the HDC1000 and HDC1008 to the Kconfig help text.
* isl29018
  - Add driver specific prefixes to defines and function names.
  - Remove excessive logging.
  - Drop newlines which add nothing to readability.
  - General tidying up of comments.
  - Drop I2C_CLASS_HWMON as irrelevant to driver.
* isl29028
  - Add driver specific prefixes to defines, enums and function names.
  - Drop comma's from available attribute output as not ABI compliant.
  - Drop I2C_CLASS_HWMON as irrelevant to driver.
* kxsd9
  - devicetree bindings.
* mag3110
  - This one wasn't locking to protect against mode switches during
    raw_reads.  Use the iio_claim_direct_mode function to fix this buglet.
* maxim-theromcouple
  - Fix missing selects for triggered buffer support in Kconfig.
* nau7802
  - Use complete instead of complete_all as only one completion at a time.
* sx9500
  - Use complete instead of complete_all as only one completion at a time.
* us5182d
  - Add a missing error code asignment instead of checking the result of
    an already checked statement.
* vcnl4000
  - Use BIT macro where appropriate.
  - Refactor return codes in read_raw callback.
  - Add some missing locking for concurrent accesses to the device.

----------------------------------------------------------------
Aleksei Mamlin (2):
      devicetree: bindings: Add vendor prefix for Domintech Co., Ltd.
      iio: accel: Add support for Domintech DMARD06 accelerometer

Alison Schofield (7):
      staging: iio: light: isl29018/28: remove I2C_CLASS_HWMON .class setting
      iio: adc: ad7793: use iio helper function to guarantee direct mode
      iio: adc: ad7298: use iio helper function to guarantee direct mode
      iio: humidity: hdc100x: add HDC1000 and HDC1008 to Kconfig
      iio: accel: bma180: use iio helper function to guarantee direct mode
      iio: magnetometer: mag3110: claim direct mode during raw reads
      iio: temperature: add Kconfig selects for triggered buffer

Christophe Chapuis (1):
      iio: accel: kxcjk-1013: add the "KIOX000A" ACPI id

Christophe JAILLET (1):
      iio: light: us5182d: Add missing error code assignment before test

Daniel Wagner (2):
      iio: adc: Use complete() instead of complete_all()
      iio: sx9500: Use complete() instead of complete_all()

Jelle van der Waa (1):
      iio: accel: add support for the Domintech DMARD09 3-axis accelerometer

Johanna Abrahamsson (1):
      staging: iio: ade7854: checkpatch fixes (alignment of parameters)

Linus Walleij (3):
      iio: magn: DT bindings for AK8974
      iio: magn: add a driver for AK8974
      iio: accel: kxsd9: Add device tree bindings

Matt Ranostay (7):
      iio: temperature: add support for Maxim thermocouple chips
      tools: iio: lsiio: enumerate processed channels
      iio: buffer-callback: allow getting underlying iio_dev
      iio: adc: ti-adc161s626: add support for TI 1-channel differential ADCs
      iio: chemical: atlas-ph-sensor: switch to iio_device_*_direct_mode helpers
      iio: chemical: atlas-ph-sensor: switch to REGCACHE_NONE regmap tree
      iio: chemical: atlas-ph-sensor: add ORP feature

Peter Meerwald-Stadler (13):
      iio: light: vcnl4000: Mention and check support for VCNL4010 and VCNL4020
      iio: light: vcnl4000: Use BIT() macro
      iio: light: vcnl4000: Cleanup read_raw() returns
      iio: light: vcnl4000: Add missing locking
      staging: iio: isl29018: Prefix #defines
      staging: iio: isl29018: Remove excessive output messages
      staging: iio: isl29018: Drop newlines
      staging: iio: isl29018: Cleanup of comments
      staging: iio: isl29018: Prefix remaining functions
      staging: iio: isl29028: Prefix #defines
      staging: iio: isl29028: Prefix stuff
      staging: iio: isl29028: Expose scale and sample frequency available without comma
      staging: iio: isl29028: Prefix functions

Srinivas Pandruvada (1):
      iio: hid-sensors: use asynchronous resume

William Breathitt Gray (1):
      iio: Add IIO support for the Measurement Computing CIO-DAC family

Zhiyong Tao (2):
      dt-bindings: auxadc: Add binding document for Mediatek auxadc.
      iio: adc: mt2701: Add Mediatek auxadc driver for mt2701.

 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 .../devicetree/bindings/iio/accel/dmard06.txt      |  19 +
 .../devicetree/bindings/iio/accel/kionix,kxsd9.txt |  22 +
 .../devicetree/bindings/iio/adc/mt6577_auxadc.txt  |  29 +
 .../devicetree/bindings/iio/adc/ti-adc161s626.txt  |  16 +
 .../bindings/iio/chemical/atlas,orp-sm.txt         |  22 +
 .../bindings/iio/magnetometer/ak8974.txt           |  29 +
 .../iio/temperature/maxim_thermocouple.txt         |  21 +
 .../devicetree/bindings/soc/mediatek/auxadc.txt    |  21 -
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |  13 +
 drivers/iio/accel/Kconfig                          |  21 +
 drivers/iio/accel/Makefile                         |   2 +
 drivers/iio/accel/bma180.c                         |   9 +-
 drivers/iio/accel/dmard06.c                        | 241 ++++++
 drivers/iio/accel/dmard09.c                        | 157 ++++
 drivers/iio/accel/kxcjk-1013.c                     |   1 +
 drivers/iio/adc/Kconfig                            |  25 +
 drivers/iio/adc/Makefile                           |   2 +
 drivers/iio/adc/ad7298.c                           |  20 +-
 drivers/iio/adc/ad7793.c                           |  10 +-
 drivers/iio/adc/mt6577_auxadc.c                    | 291 +++++++
 drivers/iio/adc/nau7802.c                          |   2 +-
 drivers/iio/adc/ti-adc161s626.c                    | 248 ++++++
 drivers/iio/buffer/industrialio-buffer-cb.c        |  24 +-
 drivers/iio/chemical/Kconfig                       |   1 +
 drivers/iio/chemical/atlas-ph-sensor.c             |  81 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |  22 +-
 drivers/iio/dac/Kconfig                            |   9 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/cio-dac.c                          | 144 ++++
 drivers/iio/humidity/Kconfig                       |   8 +-
 drivers/iio/light/Kconfig                          |   6 +-
 drivers/iio/light/us5182d.c                        |   2 +-
 drivers/iio/light/vcnl4000.c                       |  72 +-
 drivers/iio/magnetometer/Kconfig                   |  16 +-
 drivers/iio/magnetometer/Makefile                  |   1 +
 drivers/iio/magnetometer/ak8974.c                  | 863 +++++++++++++++++++++
 drivers/iio/magnetometer/mag3110.c                 |  23 +-
 drivers/iio/proximity/sx9500.c                     |   2 +-
 drivers/iio/temperature/Kconfig                    |  16 +
 drivers/iio/temperature/Makefile                   |   1 +
 drivers/iio/temperature/maxim_thermocouple.c       | 281 +++++++
 drivers/staging/iio/light/isl29018.c               | 134 ++--
 drivers/staging/iio/light/isl29028.c               | 103 ++-
 drivers/staging/iio/meter/ade7854.c                |  40 +-
 include/linux/hid-sensor-hub.h                     |   1 +
 include/linux/iio/consumer.h                       |  12 +
 tools/iio/lsiio.c                                  |   3 +-
 49 files changed, 2816 insertions(+), 273 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/dmard06.txt
 create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc161s626.txt
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,orp-sm.txt
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt
 delete mode 100644 Documentation/devicetree/bindings/soc/mediatek/auxadc.txt
 create mode 100644 drivers/iio/accel/dmard06.c
 create mode 100644 drivers/iio/accel/dmard09.c
 create mode 100644 drivers/iio/adc/mt6577_auxadc.c
 create mode 100644 drivers/iio/adc/ti-adc161s626.c
 create mode 100644 drivers/iio/dac/cio-dac.c
 create mode 100644 drivers/iio/magnetometer/ak8974.c
 create mode 100644 drivers/iio/temperature/maxim_thermocouple.c
