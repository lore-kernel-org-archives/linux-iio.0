Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751951AbeEGRCi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 May 2018 13:02:38 -0400
Date: Mon, 7 May 2018 18:02:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org
Subject: [PULL] First set of IIO fixes for the 4.17 cycle.
Message-ID: <20180507180221.0efedf77@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 8b438686a001db64c21782d04ef68111e53c45d9:

  iio: st_pressure: st_accel: pass correct platform data to init (2018-03-10 16:28:05 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.17a

for you to fetch changes up to 76974ef9d1bf397b7bb97892a3b3bc516a1fc2c2:

  iio: adc: select buffer for at91-sama5d2_adc (2018-04-21 15:57:10 +0100)

----------------------------------------------------------------
First round of IIO fixes for the 4.17 cycle.

* core
  - fix up some issues with overflow etc around wrong types
    for some fo the kfifo handling functions.  Seems unlikely
    this would be triggered in reality but the fixes are simple
    so let's tidy them up.  Second patch deals with checking
    the userspace value passed for length for potential overflow.
* ad7793
  - Catch up with changes to the ad_sigma_delta core and use
    read_raw / write_raw iwth IIO_CHAN_INFO_SAMP_FEW to handle
    sampling frequency control.
* at91-sama5d2
  - Channel config for differential channels was completely broken.
  - Missing Kconfig dependency for buffer support.
* hid-sensor
  - Fix an issue with powering up after resume due to wrong reference
    counting.
* stm32-dfsdm
  - Fix an issue with second writes of the oversampling settings
    failing.
  - Fix an issue with the sample rate being set to half of requested
    value when particular clock source is used.

----------------------------------------------------------------
Eugen Hristev (2):
      iio: adc: at91-sama5d2_adc: fix channel configuration for differential channels
      iio: adc: select buffer for at91-sama5d2_adc

Fabrice Gasnier (2):
      iio: adc: stm32-dfsdm: fix successive oversampling settings
      iio: adc: stm32-dfsdm: fix sample rate for div2 spi clock

Hans de Goede (1):
      iio: hid-sensor-trigger: Fix sometimes not powering up the sensor after resume

Martin Kelly (2):
      iio:buffer: make length types match kfifo types
      iio:kfifo_buf: check for uint overflow

Michael Nosthoff (1):
      iio: ad7793: implement IIO_CHAN_INFO_SAMP_FREQ

 drivers/iio/adc/Kconfig                            |  1 +
 drivers/iio/adc/ad7793.c                           | 75 +++++++---------------
 drivers/iio/adc/at91-sama5d2_adc.c                 | 41 ++++++++++--
 drivers/iio/adc/stm32-dfsdm-adc.c                  | 17 ++++-
 drivers/iio/buffer/industrialio-buffer-dma.c       |  2 +-
 drivers/iio/buffer/kfifo_buf.c                     | 11 +++-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |  8 +--
 include/linux/iio/buffer_impl.h                    |  6 +-
 8 files changed, 93 insertions(+), 68 deletions(-)
