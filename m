Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51366 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbcDCUea (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Apr 2016 16:34:30 -0400
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] Second set of IIO fixes for the 4.6 cycle.
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <57017E53.1070302@kernel.org>
Date: Sun, 3 Apr 2016 21:34:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 1d02369dba2cd9db110f0f35d9a777ee691e498b:

  Merge branch 'for-linus' of git://git.kernel.dk/linux-block (2016-03-24 20:00:44 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git iio-fixes-for-4.6b

for you to fetch changes up to b475c59b113db1e66eb9527ffdec3c5241c847e5:

  iio: gyro: bmg160: fix buffer read values (2016-04-03 11:21:33 +0100)

----------------------------------------------------------------
Second set of IIO fixes for the 4.6 cycle.

This lot are either dependent on patches from the merge window or just came
in recently enough that they ended up in this tree.

* core
  - The watermark for the buffers was given a value that meant that it was
    impossible to actually set the watermark to anything sensible.
* at91_adc
  - Fix a build config dependency on HAS_IOMEM
* bmc150
  - Fix wrong output on big endian systems
* bmg160
  - Fix wrong output on big endian systems
  - Fix an issue in which the regmap return value was stored to the buffer
    rather than the value actually being read in a bulk read.
* inv_mpu6050
  - Fix an indirect build config dependency on HAS_IOMEM
* max30100
  - Fix an error in fifo check condition that leads to a double read of the
    final reading.
* st_magn
  - Make sure ST_MAGN_TRIGGER_SET_STATE is always defined to avoid a build
    error for relatively obscure config combinations.

----------------------------------------------------------------
Arnd Bergmann (1):
      iio: st_magn: always define ST_MAGN_TRIGGER_SET_STATE

Irina Tirdea (4):
      iio: fix config watermark initial value
      iio: accel: bmc150: fix endianness when reading axes
      iio: gyro: bmg160: fix endianness when reading axes
      iio: gyro: bmg160: fix buffer read values

Krzysztof Kozlowski (1):
      iio: adc: Fix build error of missing devm_ioremap_resource on UM

Matt Ranostay (1):
      iio: health: max30100: correct FIFO check condition

Richard Weinberger (1):
      iio: imu: Fix inv_mpu6050 dependencies

 drivers/iio/accel/bmc150-accel-core.c | 7 ++++---
 drivers/iio/adc/Kconfig               | 1 +
 drivers/iio/gyro/bmg160_core.c        | 9 +++++----
 drivers/iio/health/max30100.c         | 3 ++-
 drivers/iio/imu/inv_mpu6050/Kconfig   | 3 +--
 drivers/iio/industrialio-buffer.c     | 1 +
 drivers/iio/magnetometer/st_magn.h    | 1 +
 7 files changed, 15 insertions(+), 10 deletions(-)
