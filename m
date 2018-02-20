Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750781AbeBTIRa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 20 Feb 2018 03:17:30 -0500
Date: Tue, 20 Feb 2018 08:17:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PULL] First round of IIO fixes for the 4.16 cycle.
Message-ID: <20180220081726.35366466@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit a66a4e8e01f3b607a9aa5b5ed9ca588b4c3a962e:

  staging: pi433: Cleanup codestyle, indent statements after case labels (2018-01-10 19:29:34 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.16a

for you to fetch changes up to 4cd140bda6494543f1c1b0ccceceaa44b676eef6:

  iio: buffer: check if a buffer has been set up when poll is called (2018-02-17 16:54:58 +0000)

----------------------------------------------------------------
First round of IIO fixes for the 4.16 cycle.

One nasty very old crash around polling for buffers that aren't there
- though that can only cause effects on drivers that support events
but not buffers.

* buffer / kfifo handling in the core.
  - Check there is a buffer and return 0 from poll directly if there
    isn't.  Poll doesn't make sense in this circumstances, but best to close
    the hole.
* ad5933
  - Change the marked buffer mode to a software buffer as the meaning of
    the hardware buffer label has long since changed and this uses a front
    end software buffer anyway.
* ad7192
  - Fix the fact the external clock frequency was only set when using the
    internal clock which was less than helpful.
* adis_lib
  - Initialize the trigger before requesting the interrupt.  Some newer
    parts can power up with interrupt generation enabled so ordering now
    matters.
* aspeed-adc
  - Fix an errror handling path as labels and general ordering were wrong.
* srf08
  - Fix a link error due to undefined devm_iio_triggered_buffer_setup.
* stm32-adc
  - Fix error handling unwind squence in stm32h7_adc_enable.

----------------------------------------------------------------
Alexandru Ardelean (2):
      staging: iio: adc: ad7192: fix external frequency setting
      staging: iio: ad5933: switch buffer mode to software

Andreas Klinger (1):
      iio: srf08: fix link error "devm_iio_triggered_buffer_setup" undefined

Christophe JAILLET (1):
      iio: adc: aspeed: Fix error handling path

Fabrice Gasnier (1):
      iio: adc: stm32: fix stm32h7_adc_enable error handling

Lars-Peter Clausen (1):
      iio: adis_lib: Initialize trigger before requesting interrupt

Stefan Windfeldt-Prytz (1):
      iio: buffer: check if a buffer has been set up when poll is called

 drivers/iio/adc/aspeed_adc.c                    |  7 ++++---
 drivers/iio/adc/stm32-adc.c                     |  7 ++++---
 drivers/iio/imu/adis_trigger.c                  |  7 ++++---
 drivers/iio/industrialio-buffer.c               |  2 +-
 drivers/iio/proximity/Kconfig                   |  2 ++
 drivers/staging/iio/adc/ad7192.c                | 27 +++++++++++++++++--------
 drivers/staging/iio/impedance-analyzer/ad5933.c |  4 +---
 7 files changed, 35 insertions(+), 21 deletions(-)
