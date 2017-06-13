Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753311AbdFMUFb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 13 Jun 2017 16:05:31 -0400
Date: Tue, 13 Jun 2017 21:05:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PULL] Second set of IIO fixes for the 4.12 cycle.
Message-ID: <20170613210528.0c8d7f20@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 3d51b956267343a65498704ada854c33c0f5e946:

  staging: ccree: add CRYPTO dependency (2017-05-25 14:44:25 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.12b

for you to fetch changes up to 7981dc07fe317e3506d706e5ef91b94da02656f4:

  iio: buffer-dmaengine: Add missing header buffer_impl.h (2017-06-13 20:56:05 +0100)

----------------------------------------------------------------
Second set of IIO fixes for the 4.12 cycle.

* buffer-dma / buffer-dmaengine
  - Fix missing include of buffer_impl.h after the split of buffer.h.
  No driver in mainline is currently using these buffers so it wasn't
  picked up by automated build tests.

* ad7152
  - Fix a deadlock in ad7152_write_raw_samp_freq as the chip_state lock
    was already held.
* inv_mpu6050
  - Add low pass filter setting for chips newer than the MPU6500.  None of
    use previously picked up no the fact it was different on these newer
    chips.  It is separately set for the acceleration on these parts.  There
    is no normal reason to set it differently so the userspace interface
    remains the same as for early parts.
* meson-saradc:
  - Fix a potential crash by NULL pointer dereference in
    meson_sar_adc_clear_fifo.
* mxs-lradc
  - Fix a return value check where IS_ERR is used on a function that returns
    NULL on error

----------------------------------------------------------------
Alexey Khoroshilov (1):
      staging: iio: ad7152: Fix deadlock in ad7152_write_raw_samp_freq()

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_mpu6050: add accel lpf setting for chip >= MPU6500

Martin Blumenstingl (1):
      iio: adc: meson-saradc: fix potential crash in meson_sar_adc_clear_fifo

Phil Reid (2):
      iio: buffer-dma: Add missing header buffer_impl.h
      iio: buffer-dmaengine: Add missing header buffer_impl.h

Wei Yongjun (1):
      iio: adc: mxs-lradc: Fix return value check in mxs_lradc_adc_probe()

 drivers/iio/adc/meson_saradc.c                     |  4 +--
 drivers/iio/adc/mxs-lradc-adc.c                    |  7 ++--
 drivers/iio/buffer/industrialio-buffer-dma.c       |  1 +
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 39 ++++++++++++++++++++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  3 ++
 drivers/staging/iio/cdc/ad7152.c                   |  6 +---
 7 files changed, 49 insertions(+), 12 deletions(-)
