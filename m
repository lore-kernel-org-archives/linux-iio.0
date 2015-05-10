Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38410 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbbEJUNe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 May 2015 16:13:34 -0400
Message-ID: <554FBBE9.4030106@kernel.org>
Date: Sun, 10 May 2015 21:13:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for the 4.1 cycle, round 1.
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit c610f7f772aa06ae2bd8e5ace87cde4d90f70198:

  Merge 4.0-rc7 into staging-next (2015-04-07 11:03:02 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.1a

for you to fetch changes up to 54b8e12ecddafabd0fc1e9a720e5a00907e2c28b:

  iio: light: hid-sensor-prox: Fix memory leak in probe() (2015-05-08 09:54:52 -0400)

----------------------------------------------------------------
The usual mixed bag of fixes for IIO in the 4.1 cycle.

One core fix

* Set updated for a iio kfifo was incorrectly set to false during a failed
  update, resulting in atttempts to repeat the failed operation appearing
  to succeed.

This time I've decided to list the driver fixes in alphabetical order rather
than 'randomly'.

* axp288_adc - a recent change added a check for valid info masks when
  reading channels from consumer drivers.
* bmp280 - temperature compensation was failing to read the tfine value, hence
  causing a temperature of 0 to always be returned and incorrect presure
  measurements.
* cc10001 - Fix channel number mapping when some channels are reserved for
  remote CPUs. Fix an issue with the use of the power-up/power-down register
  (basically wrong polarity). Fix an issue due to the missinterpretting the
  return value from regulator_get_voltage. Add a delay before the start bit
  as recommended for the hardware to avoid data corruption.
* hid pressure - fix channel spec of modfiied, but no modifier (which makes no
  sense!)
* hid proximity - fix channel spec of modified, but no modifier (which makes
  no sense!). Fix a memory leak in the probe function.
* mcp320x - occasional incorrect readings on dma using spi busses due to
  cacheline corruption. Fixed by forcing ___cacheline_aligned for the buffers.
* mma9551 - buffer overrun fix (miss specified maximum length of buffers)
* mma9553 - endian fix on status message. Add an enable element for activity
  channel. Input checking for activity period to avoid rather unpredictable
  results.
* spmi-vadc - fix an overflow in the output value normalization seen on some
  boards.
* st-snesors - oops due to use of a mutex that is not yet initialized during
  probe.
* xilinx adc - Some wrong register addresses, a wrong address for vccaux
  channel, incorrect scale on VREFP and incorrect sign on VREFN.

----------------------------------------------------------------
Alban Bedel (1):
      iio:st_sensors: Fix oops when probing SPI devices

Fabio Estevam (1):
      iio: light: hid-sensor-prox: Fix memory leak in probe()

Gabriele Mazzotta (1):
      iio: kfifo: Set update_needed to false only if a buffer was allocated

Irina Tirdea (5):
      iio: pressure: bmp280: fix temp compensation
      iio: accel: mma9553: fix endianness issue when reading status
      iio: accel: mma9551_core: prevent buffer overrun
      iio: accel: mma9553: add enable channel for activity
      iio: accel: mma9553: check input value for activity period

Ivan T. Ivanov (1):
      iio: adc: spmi-vadc: Fix overflow in output value normalization

Jacob Pan (1):
      iio/axp288_adc: add missing channel info mask

Michael Welling (1):
      iio: mcp320x: Fix occasional incorrect readings

Naidu Tellapati (4):
      iio: adc: cc10001: Fix the channel number mapping
      iio: adc: cc10001: Fix incorrect use of power-up/power-down register
      iio: adc: cc10001: Fix regulator_get_voltage() return value check
      iio: adc: cc10001: Add delay before setting START bit

Srinivas Pandruvada (2):
      iio: light: hid-sensor-prox: Fix modifier
      iio: pressure: hid-sensor-press: Fix modifier

Thomas Betker (4):
      iio: adc: xilinx: Fix register addresses
      iio: adc: xilinx: Fix "vccaux" channel .address
      iio: adc: xilinx: Fix VREFP scale
      iio: adc: xilinx: Fix VREFN sign

 drivers/iio/accel/mma9551_core.c                | 21 +++++++--
 drivers/iio/accel/mma9553.c                     | 18 +++----
 drivers/iio/accel/st_accel_core.c               |  1 +
 drivers/iio/adc/axp288_adc.c                    | 12 ++---
 drivers/iio/adc/cc10001_adc.c                   | 62 ++++++++++++++-----------
 drivers/iio/adc/mcp320x.c                       |  6 +--
 drivers/iio/adc/qcom-spmi-vadc.c                |  7 +--
 drivers/iio/adc/xilinx-xadc-core.c              |  5 +-
 drivers/iio/adc/xilinx-xadc.h                   |  6 +--
 drivers/iio/common/st_sensors/st_sensors_core.c |  2 -
 drivers/iio/gyro/st_gyro_core.c                 |  1 +
 drivers/iio/kfifo_buf.c                         |  3 +-
 drivers/iio/light/hid-sensor-prox.c             | 12 ++---
 drivers/iio/magnetometer/st_magn_core.c         |  1 +
 drivers/iio/pressure/bmp280.c                   |  1 +
 drivers/iio/pressure/hid-sensor-press.c         |  2 -
 drivers/iio/pressure/st_pressure_core.c         |  1 +
 17 files changed, 95 insertions(+), 66 deletions(-)
