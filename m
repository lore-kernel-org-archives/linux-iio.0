Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36835 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755156AbcHWVBY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Aug 2016 17:01:24 -0400
To: Greg KH <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] First round of IIO fixes for the 4.8 cycle.
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b8f6cdf6-3235-bafc-6aa8-3c21eb2b3d71@kernel.org>
Date: Tue, 23 Aug 2016 22:01:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 694d0d0bb2030d2e36df73e2d23d5770511dbc8d:

  Linux 4.8-rc2 (2016-08-14 19:11:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.8a

for you to fetch changes up to 3d4267a5a3a4b7619b80ad1839d8b3bedd8b7a8d:

  arm: dts: rockchip: add reset node for the exist saradc SoCs (2016-08-23 19:08:29 +0100)

----------------------------------------------------------------
First round of IIO fixes for the 4.8 cycle.

This is somewhat of a bumper set due to my unavailabilty earlier in the
month.  The only slightly unusual ones are the dts updates for the
rockchip adc reset.  The fix in the driver only makes sense with these
and the rockchip maintainer is happy with them going through IIO to
reach mainline.

Core stuff

* Fix an issue with a blocking op when !TASK_RUNNING. This been there
  a while and snuck in with seemingly minor additions to some core
  code paths.
* Tools
  - generic_buffer failed to initialize the channel array pointer thus
    in the case of no channels blows up trying to free a random memory
    address.
* sw-trigger:
  - Fix config group initialization when configfs is built as a module.

Drivers

* ad5933
  - Fix an incorrect overwrite of an error value.
* ad799x
  - A missed assignment of the update_scan_mode callback means buffered mode
    doesn't work on the ad7991, ad7995 or ad7999.
* ads1015
  - wrong pointer returned from i2c_get_clientdata (missmatch of assumptions)
* am2315
  - Timestamps are reported, but never actually acquired from anywhere
    (so always 0)
  - missing buffer selects in Kconfig
* am335x adc
  - Protect fifo1 from concurrent access.
  - Increase timeout waiting for ADC to be long enough in all cases.
* as3935
  - Timestamps are reported, but never actually acquired from anywhere
    (so always 0)
* at91
  - Fix reading of channel 3.
* atlas-ph-sensor
  - Typo means that the scale of electrical conductivity readings is way off.
* bma220
  - Timestamps are reported, but never actually acquired from anywhere
    (so always 0)
  - Missing buffer selects in Kconfig
* bmp280
  - pass the write pointer to PTR_ERR (i.e. the one that was just checked
    with IS_ERR).
  - suspend /resume crash due to wrong assumption about what dev_get_drvdata
    would return.
* hdc100x
  - It superficially appeared that smbus_read_byte commands would allow
  reading of the outputs in two goes.  In reality it doesn't work, but
  instead returns the same for the upper and lower bytes (nice catch from
  Alison!)
* kxsd9
  - Fix raw read return value to ensure it actually reports the value rather
  than a blank string.
* max44000
  - Missing buffer selects in Kconfig
* rockchip_saradc
  - Add use of reset controller to enforce a clean state of the ADC.
    Some bootloaders can leave it in an 'intersting' state and effectively
    frozen without this. A couple of associated dts updates.
* stk8ba50
  - Missing buffer selects in Kconfig
* stx104
  - Fix a possible race due to use of devm_iio_device_register when there
    was other stuff in the remove function.

----------------------------------------------------------------
Alison Schofield (6):
      iio: accel: bma220_spi: set up buffer timestamps for non-zero values
      iio: humidity: am2315: set up buffer timestamps for non-zero values
      iio: proximity: as3935: set up buffer timestamps for non-zero values
      iio: add Kconfig selects needed for triggered buffer compiles
      iio: humidity: hdc100x: fix sensor data reads of temp and humidity
      tools: iio: iio_generic_buffer: initialize channel array pointer

Anders Darander (1):
      iio: adc: at91: unbreak channel adc channel 3

Brian Norris (1):
      iio: fix sched WARNING "do not call blocking ops when !TASK_RUNNING"

Caesar Wang (3):
      iio: adc: rockchip_saradc: reset saradc controller before programming it
      arm64: dts: rockchip: add reset saradc node for rk3368 SoCs
      arm: dts: rockchip: add reset node for the exist saradc SoCs

Colin Ian King (1):
      iio: chemical: atlas-ph-sensor: fix typo in val assignment

Giorgio Dal Molin (1):
      iio:ti-ads1015: fix a wrong pointer definition.

Lars-Peter Clausen (2):
      iio: sw-trigger: Fix config group initialization
      iio: ad799x: Fix buffered capture for ad7991/ad7995/ad7999

Linus Walleij (2):
      iio: pressure: bmp280: fix runtime suspend/resume crash
      iio: accel: kxsd9: Fix raw read return

Phil Turnbull (1):
      staging: iio: ad5933: Return correct value for AD5933_OUT_RANGE.

Vignesh R (2):
      iio: adc: ti_am335x_adc: Protect FIFO1 from concurrent access
      iio: adc: ti_am335x_adc: Increase timeout value waiting for ADC sample

Wei Yongjun (1):
      iio: pressure: bmp280: fix wrong pointer passed to PTR_ERR()

William Breathitt Gray (1):
      iio: stx104: Unregister IIO device on remove callback

 .../bindings/iio/adc/rockchip-saradc.txt           |  7 ++++
 arch/arm/boot/dts/rk3066a.dtsi                     |  2 ++
 arch/arm/boot/dts/rk3288.dtsi                      |  2 ++
 arch/arm/boot/dts/rk3xxx.dtsi                      |  2 ++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  2 ++
 drivers/iio/accel/Kconfig                          |  5 ++-
 drivers/iio/accel/bma220_spi.c                     |  2 +-
 drivers/iio/accel/kxsd9.c                          |  1 +
 drivers/iio/adc/Kconfig                            |  1 +
 drivers/iio/adc/ad799x.c                           |  1 +
 drivers/iio/adc/at91_adc.c                         |  4 +--
 drivers/iio/adc/rockchip_saradc.c                  | 30 +++++++++++++++++
 drivers/iio/adc/ti-ads1015.c                       |  3 +-
 drivers/iio/adc/ti_am335x_adc.c                    | 16 ++++++---
 drivers/iio/chemical/atlas-ph-sensor.c             |  2 +-
 drivers/iio/dac/stx104.c                           | 38 +++++++++++++++++-----
 drivers/iio/humidity/Kconfig                       |  2 ++
 drivers/iio/humidity/am2315.c                      |  2 +-
 drivers/iio/humidity/hdc100x.c                     | 27 ++++-----------
 drivers/iio/industrialio-buffer.c                  | 23 +++++++++----
 drivers/iio/light/Kconfig                          |  2 ++
 drivers/iio/pressure/bmp280-core.c                 |  8 +++--
 drivers/iio/proximity/as3935.c                     |  2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |  2 +-
 include/linux/iio/sw_trigger.h                     |  2 +-
 include/linux/mfd/ti_am335x_tscadc.h               |  8 ++---
 tools/iio/iio_generic_buffer.c                     |  2 +-
 27 files changed, 141 insertions(+), 57 deletions(-)
