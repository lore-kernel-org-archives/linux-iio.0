Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751346AbdGWM1u (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 23 Jul 2017 08:27:50 -0400
Date: Sun, 23 Jul 2017 13:27:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PULL] First round of fixes for IIO in the 4.13 cycle
Message-ID: <20170723132746.7cfe718a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 41f1830f5a7af77cf5c86359aba3cbd706687e52:

  Linux 4.12-rc6 (2017-06-19 22:19:37 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.13a

for you to fetch changes up to 737cc2a593782df6846b3cab7e0f64384f58364a:

  iio: aspeed-adc: wait for initial sequence. (2017-07-23 12:02:40 +0100)

----------------------------------------------------------------
First set of IIO fixes for the 4.13 cycle.

* ad2s1210
  - Fix negative angular velocity reads (identified by a gcc 7 warning)
* aspeed-adc
  - Wait for initialization sequence to finish before enabling channels.
  Without it no channels work.
* axp288
  - Revert a patch that dropped some bogus register mods.  No one is entirely
  sure why but it breaks charging on some devices.
  - Fix GPADC pin read returning 0. Turns out a small sleep is needed.
* bmc150
  - Make sure device is restored to normal state after suspend / resume
  cycle.  Otherwise, simple sysfs reads are broken.
* tsl2563
  - fix wrong event code.
* st-accel
  - add spi 3-wire support. Needed to fix the lsm303agr accelerometer
  which only had 3 wires in all cases.  Side effect is to enable optional
  3-wire support for other devices.
* st-pressure
  - disable multiread by default for LPS22HB (only effects SPI)
* sun4i-gpadc-iio
  - fix unbalanced irq enable / disable
* vf610
  - Fix VALT slection for REFSEL bits - ensures we are using the
  right reference pins.

----------------------------------------------------------------
Akinobu Mita (1):
      iio: light: tsl2563: use correct event code

Arnd Bergmann (1):
      staging:iio:resolver:ad2s1210 fix negative IIO_ANGL_VEL read

Hans de Goede (3):
      iio: adc: Revert "axp288: Drop bogus AXP288_ADC_TS_PIN_CTRL register modifications"
      iio: adc: axp288: Fix the GPADC pin reading often wrongly returning 0
      iio: accel: bmc150: Always restore device to normal mode after suspend-resume

Lorenzo Bianconi (2):
      iio: pressure: st_pressure_core: disable multiread by default for LPS22HB
      iio: accel: st_accel: add SPI-3wire support

Mykola Kostenok (1):
      iio: aspeed-adc: wait for initial sequence.

Quentin Schulz (1):
      iio: adc: sun4i-gpadc-iio: fix unbalanced irq enable/disable

Stefan-Gabriel Mirea (1):
      iio: adc: vf610_adc: Fix VALT selection value for REFSEL bits

 drivers/iio/accel/bmc150-accel-core.c           |  9 +-----
 drivers/iio/accel/st_accel_core.c               | 32 +++++++++++++++++++
 drivers/iio/adc/aspeed_adc.c                    | 26 +++++++++++++++
 drivers/iio/adc/axp288_adc.c                    | 42 ++++++++++++++++++++++++-
 drivers/iio/adc/sun4i-gpadc-iio.c               |  3 +-
 drivers/iio/adc/vf610_adc.c                     |  2 +-
 drivers/iio/common/st_sensors/st_sensors_core.c | 29 +++++++++++++++++
 drivers/iio/light/tsl2563.c                     |  2 +-
 drivers/iio/pressure/st_pressure_core.c         |  2 +-
 drivers/staging/iio/resolver/ad2s1210.c         |  2 +-
 include/linux/iio/common/st_sensors.h           |  7 +++++
 include/linux/platform_data/st_sensors_pdata.h  |  2 ++
 12 files changed, 143 insertions(+), 15 deletions(-)
