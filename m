Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934686AbeFYUoB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 Jun 2018 16:44:01 -0400
Date: Mon, 25 Jun 2018 21:43:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] First set of IIO fixes for the 4.18 cycle
Message-ID: <20180625214357.46b49977@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-4.18a

for you to fetch changes up to 2a221c04228bbf683fc8d3cb5d177aebb38b393c:

  iio: imu: inv_mpu6050: Fix probe() failure on older ACPI based machines (2018-06-24 14:50:52 +0100)

----------------------------------------------------------------
First set of IIO fixes for the 4.18 cycle.

* bmp280
  - Fix wrong relative humidity unit.
* buffer
  - Fix a function signature to match the function.
* inv_mpu6050
  - Fix a regression in which older ACPI devices won't have working
    interrupts due to lack of information on the interrupt type.
* mma8452
  - Don't ignore data ready interrupt when handling interrupts as will
    look like an unhandled interrupt.
* tsl2x7x/tsl2772
  - Avoid a potential division by zero.

----------------------------------------------------------------
Colin Ian King (1):
      iio: tsl2x7x/tsl2772: avoid potential division by zero

Hans de Goede (1):
      iio: imu: inv_mpu6050: Fix probe() failure on older ACPI based machines

Leonard Crestez (1):
      iio: mma8452: Fix ignoring MMA8452_INT_DRDY

Phil Reid (1):
      iio: buffer: fix the function signature to match implementation

Tomasz Duszynski (1):
      iio: pressure: bmp280: fix relative humidity unit

 drivers/iio/accel/mma8452.c                | 2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 ++
 drivers/iio/light/tsl2772.c                | 2 ++
 drivers/iio/pressure/bmp280-core.c         | 5 ++---
 include/linux/iio/buffer-dma.h             | 2 +-
 5 files changed, 8 insertions(+), 5 deletions(-)
