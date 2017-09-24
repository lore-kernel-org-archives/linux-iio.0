Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752416AbdIXQRa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Sep 2017 12:17:30 -0400
Date: Sun, 24 Sep 2017 17:17:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PULL] First set of IIO fixes for the 4.14 cycle.
Message-ID: <20170924171725.53810a7d@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit a575de2da5e20c31f4ffcb1df555c199ad77fc20:

  staging: rtlwifi: Reviewers fixes (2017-08-20 11:13:12 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.14a

for you to fetch changes up to f790923f146140a261ad211e5baf75d169f16fb2:

  staging: iio: ad7192: Fix - use the dedicated reset function avoiding dma from stack. (2017-09-24 16:58:37 +0100)

----------------------------------------------------------------
First round of IIO fixes for the 4.14 cycle

Note this includes fixes from recent merge window.  As such the tree
is based on top of a prior staging/staging-next tree.

* iio core
  - return and error for a failed read_reg debugfs call rather than
    eating the error.
* ad7192
  - Use the dedicated reset function in the ad_sigma_delta library
    instead of an spi transfer with the data on the stack which
    could cause problems with DMA.
* ad7793
  - Implement a dedicate reset function in the ad_sigma_delta library
    and use it to correctly reset this part.
* bme280
  - ctrl_reg write must occur after any register writes
  for updates to take effect.
* mcp320x
  - negative voltage readout was broken.
  - Fix an oops on module unload due to spi_set_drvdata not being called
    in probe.
* st_magn
  - Fix the data ready line configuration for the lis3mdl. It is not
    configurable so the st_magn core was assuming it didn't exist
    and so wasn't consuming interrupts resulting in an unhandled
    interrupt.
* stm32-adc
  - off by one error on max channels checking.
* stm32-timer
  - preset should not be buffered - reorganising register writes avoids
  this.
  - fix a corner case in which write preset goes wrong when a timer is
  used first as a trigger then as a counter with preset. Odd case but
  you never know.
* ti-ads1015
  - Fix setting of comparator polarity by fixing bitfield definition.
* twl4030
  - Error path handling fix to cleanup in event of regulator
    registration failure.
  - Disable the vusb3v1 regulator correctly in error handling
  - Don't paper over a regulator enable failure.

----------------------------------------------------------------
Akinobu Mita (1):
      iio: adc: ti-ads1015: fix comparator polarity setting

Christophe JAILLET (3):
      iio: adc: twl4030: Fix an error handling path in 'twl4030_madc_probe()'
      iio: adc: twl4030: Disable the vusb3v1 rugulator in the error handling path of 'twl4030_madc_probe()'
      iio: adc: twl4030: Return an error if we can not enable the vusb3v1 regulator in 'twl4030_madc_probe()'

Colin Parker (1):
      IIO: BME280: Updates to Humidity readings need ctrl_reg write!

Dragos Bogdan (2):
      iio: ad_sigma_delta: Implement a dedicated reset function
      iio: ad7793: Fix the serial interface reset

Fabrice Gasnier (3):
      iio: trigger: stm32-timer: preset shouldn't be buffered
      iio: trigger: stm32-timer: fix a corner case to write preset
      iio: adc: stm32: fix bad error check on max_channels

Lorenzo Bianconi (1):
      iio: magnetometer: st_magn: fix drdy line configuration for LIS3MDL

Lukas Wunner (2):
      iio: adc: mcp320x: Fix oops on module unload
      iio: adc: mcp320x: Fix readout of negative voltages

Matt Fornero (1):
      iio: core: Return error for failed read_reg

Stefan Popa (1):
      staging: iio: ad7192: Fix - use the dedicated reset function avoiding dma from stack.

 drivers/iio/adc/ad7793.c                        |  4 ++--
 drivers/iio/adc/ad_sigma_delta.c                | 28 +++++++++++++++++++++++++
 drivers/iio/adc/mcp320x.c                       | 25 ++++++++++++++--------
 drivers/iio/adc/stm32-adc.c                     |  2 +-
 drivers/iio/adc/ti-ads1015.c                    |  8 ++++---
 drivers/iio/adc/twl4030-madc.c                  | 14 +++++++++----
 drivers/iio/common/st_sensors/st_sensors_core.c | 11 +++++++++-
 drivers/iio/industrialio-core.c                 |  4 +++-
 drivers/iio/magnetometer/st_magn_core.c         |  4 ++++
 drivers/iio/pressure/bmp280-core.c              |  2 +-
 drivers/iio/trigger/stm32-timer-trigger.c       |  4 +++-
 drivers/staging/iio/adc/ad7192.c                |  4 +---
 include/linux/iio/adc/ad_sigma_delta.h          |  3 +++
 13 files changed, 87 insertions(+), 26 deletions(-)
