Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731500AbeHAUJf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 1 Aug 2018 16:09:35 -0400
Date: Wed, 1 Aug 2018 19:22:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 3rd set of new IIO device support, features, cleanups and
 fixes for the 4.19 cycle.
Message-ID: <20180801192232.3eb71a44@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is a somewhat sneaky late pull request given Linus has announced
a likely 1 week delay.  If it is too late I'll resend after the merge
window.  I merged in the fixes branch as those are primarily around
things queued for the merge window.

Particulary good to see the output of our Himanshu Jha, a GSOC student
who developed the bme680 driver.

New device support:
* bme680 gas sensor (with temperature, humidity and pressure)
  - new driver to support this device
* vcn4000
  - support vcnl4200 (lots of rework to allow this)
  - ids added for VCNL4010 and VCNL4020 sensors

New features:
* ad9523
  - support the various external signal options via gpios.

Cleanups and fixes
* ad_sigma_delta
  - unsigned long for a timeout.
* ad9523
  - fix a wrong return value that was indicating successful write failed
    and might lead to an infinite loop.
* si1133
  - fix an impossible test.
  - fix an uninitialsed variable by reading from the device in all paths.
* xilinx xadc
  - check for return values in clk related functions
  - limit the pcap clock frequency to supported ranges.
  - stash the irq to avoid calling platform_get_irq from the remove path.
  - ensure the irq is actually requested before we enable the hardware to
    output it.

----------------------------------------------------------------
Colin Ian King (1):
      iio: light: si1133 fix test for val being not zero or not one.

Himanshu Jha (1):
      iio: chemical: Add support for Bosch BME680 sensor

Jonathan Cameron (1):
      Merge branch 'fixes-togreg' into togreg

Lars-Peter Clausen (1):
      iio: ad9523: Fix return value for ad952x_store()

Manish Narani (4):
      iio: adc: xilinx: Check for return values in clk related functions
      iio: adc: xilinx: limit pcap clock frequency value
      iio: adc: xilinx: Remove platform_get_irq from xadc_remove function
      iio: adc: xilinx: Move request_irq before enabling interrupts

Maxime Roussin-B=C3=A9langer (1):
      iio: light: si1133: fix uninitialized resp variable

Michael Hennerich (1):
      iio: ad9523: support for external signals via gpios

Nicholas Mc Guire (1):
      iio: ad_sigma_delta: use unsigned long for timeout

Tomas Novotny (4):
      iio: vcnl4000: make the driver extendable
      iio: vcnl4000: add VCNL4010 and VCNL4020 device id
      iio: vcnl4000: warn on incorrectly specified device id
      iio: vcnl4000: add support for VCNL4200

 drivers/iio/adc/ad_sigma_delta.c   |   5 +-
 drivers/iio/adc/xilinx-xadc-core.c |  40 +-
 drivers/iio/adc/xilinx-xadc.h      |   1 +
 drivers/iio/chemical/Kconfig       |  23 +
 drivers/iio/chemical/Makefile      |   3 +
 drivers/iio/chemical/bme680.h      |  96 ++++
 drivers/iio/chemical/bme680_core.c | 959 +++++++++++++++++++++++++++++++++=
++++
 drivers/iio/chemical/bme680_i2c.c  |  85 ++++
 drivers/iio/chemical/bme680_spi.c  | 125 +++++
 drivers/iio/frequency/ad9523.c     |  32 +-
 drivers/iio/light/Kconfig          |   5 +-
 drivers/iio/light/si1133.c         |   5 +-
 drivers/iio/light/vcnl4000.c       | 220 ++++++++-
 13 files changed, 1558 insertions(+), 41 deletions(-)
 create mode 100644 drivers/iio/chemical/bme680.h
 create mode 100644 drivers/iio/chemical/bme680_core.c
 create mode 100644 drivers/iio/chemical/bme680_i2c.c
 create mode 100644 drivers/iio/chemical/bme680_spi.c
