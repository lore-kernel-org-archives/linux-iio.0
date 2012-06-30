Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:35185 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036Ab2F3TGR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jun 2012 15:06:17 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/4 V3] staging:iio: Add support for multiple buffers
Date: Sat, 30 Jun 2012 20:06:03 +0100
Message-Id: <1341083167-30515-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes since V2.

Improved handling of error conditions in the buffer insertion and
removal code.  (suggested by Lars-Peter).  I want to take another
look at these, but didn't want to keep people from testing this
in the meantime.

Also a number of minor fixes that came up during testing.

Thanks,

Jonathan

Jonathan Cameron (4):
  staging:iio: Add support for multiple buffers
  staging:iio:in kernel users: Add a data field for channel specific
    info.
  staging:iio: add a callback buffer for in kernel push interface
  staging:iio: Proof of concept input driver.

 drivers/iio/Kconfig                             |   6 +
 drivers/iio/Makefile                            |   1 +
 drivers/iio/adc/at91_adc.c                      |   4 +-
 drivers/iio/buffer_cb.c                         | 115 +++++++
 drivers/iio/industrialio-buffer.c               | 378 ++++++++++++++++--------
 drivers/iio/industrialio-core.c                 |   1 +
 drivers/iio/inkern.c                            |   1 +
 drivers/staging/iio/Kconfig                     |  11 +
 drivers/staging/iio/Makefile                    |   1 +
 drivers/staging/iio/accel/adis16201_ring.c      |   4 +-
 drivers/staging/iio/accel/adis16203_ring.c      |   6 +-
 drivers/staging/iio/accel/adis16204_ring.c      |   3 +-
 drivers/staging/iio/accel/adis16209_ring.c      |   3 +-
 drivers/staging/iio/accel/adis16240_ring.c      |   4 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c      |   3 +-
 drivers/staging/iio/adc/ad7192.c                |   3 +-
 drivers/staging/iio/adc/ad7298_ring.c           |   5 +-
 drivers/staging/iio/adc/ad7476_ring.c           |   2 +-
 drivers/staging/iio/adc/ad7606_ring.c           |   3 +-
 drivers/staging/iio/adc/ad7793.c                |   3 +-
 drivers/staging/iio/adc/ad7887_ring.c           |   2 +-
 drivers/staging/iio/adc/ad799x_ring.c           |   3 +-
 drivers/staging/iio/adc/max1363_ring.c          |   2 +-
 drivers/staging/iio/gyro/adis16260_ring.c       |   3 +-
 drivers/staging/iio/iio_input.c                 | 221 ++++++++++++++
 drivers/staging/iio/iio_input.h                 |  23 ++
 drivers/staging/iio/iio_simple_dummy_buffer.c   |   5 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c |   3 +-
 drivers/staging/iio/imu/adis16400_ring.c        |   2 +-
 drivers/staging/iio/meter/ade7758_ring.c        |   3 +-
 include/linux/iio/buffer.h                      |  24 +-
 include/linux/iio/consumer.h                    |  48 +++
 include/linux/iio/iio.h                         |   2 +
 include/linux/iio/machine.h                     |   2 +
 34 files changed, 734 insertions(+), 166 deletions(-)
 create mode 100644 drivers/iio/buffer_cb.c
 create mode 100644 drivers/staging/iio/iio_input.c
 create mode 100644 drivers/staging/iio/iio_input.h

-- 
1.7.11.1

