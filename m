Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:55791 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab1GYNSl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2011 09:18:41 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/7 V2] blue part 5: IIO: Reduce to 1 the number of chrdevs per device.
Date: Mon, 25 Jul 2011 14:18:34 +0100
Message-Id: <1311599921-15729-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

(for Arnd, the blue it is just the current IIO dev tree and this
is the middle of a fair number of other bits and bobs)

Also, updated the main documentation file.  Haven't checked the others
yet to see what else needs to change.

Changes since V1:

Basically fix the dumb issue with 'events' naming for the
sysfs directories and Arnds points about correct use of ioctls.

The ioctl docs patch is here, but probably won't merge just yet as
that file explicitly says it doesn't cover staging.  We'll nab the
range with the first round of stuff moving out of staging.

On going discussions about how to handle subdirs in sysfs mean I'll
be holding this one up for now. (Sysfs - export sysfs_create_subdir?
on lkml).

Thanks,

Jonathan

Jonathan Cameron (7):
  staging:iio:chrdev.h rationalization.
  staging:iio: remove specific chrdev for event reading. Get fd from
    ioctl on buffer.
  ioctl region for IIO.
  staging:iio: squash chrdev handler remains into users.
  staging:iio: push the main buffer chrdev down to the top level.
  staging:iio: remove now defunct header definitions and add some
    statics
  staging:iio:Documentation sysfs-bus-iio update for chrdev merge.

 Documentation/ioctl/ioctl-number.txt               |    1 +
 drivers/staging/iio/Documentation/generic_buffer.c |   12 +-
 drivers/staging/iio/Documentation/iio_utils.h      |    2 +-
 drivers/staging/iio/Documentation/sysfs-bus-iio    |  573 ++++++++++----------
 drivers/staging/iio/accel/adis16201_core.c         |    6 +-
 drivers/staging/iio/accel/adis16203_core.c         |    6 +-
 drivers/staging/iio/accel/adis16204_core.c         |    6 +-
 drivers/staging/iio/accel/adis16209_core.c         |    6 +-
 drivers/staging/iio/accel/adis16240_core.c         |    6 +-
 drivers/staging/iio/accel/lis3l02dq_core.c         |    6 +-
 drivers/staging/iio/accel/sca3000_core.c           |    7 +-
 drivers/staging/iio/accel/sca3000_ring.c           |   23 +-
 drivers/staging/iio/adc/ad7150.c                   |    1 +
 drivers/staging/iio/adc/ad7298_core.c              |    4 +-
 drivers/staging/iio/adc/ad7476_core.c              |    4 +-
 drivers/staging/iio/adc/ad7606_core.c              |    4 +-
 drivers/staging/iio/adc/ad7745.c                   |    1 +
 drivers/staging/iio/adc/ad7793.c                   |    6 +-
 drivers/staging/iio/adc/ad7816.c                   |    1 +
 drivers/staging/iio/adc/ad7887_core.c              |    4 +-
 drivers/staging/iio/adc/ad799x_core.c              |    6 +-
 drivers/staging/iio/adc/adt7310.c                  |    2 +
 drivers/staging/iio/adc/adt7410.c                  |    2 +
 drivers/staging/iio/adc/adt75.c                    |    1 +
 drivers/staging/iio/adc/max1363_core.c             |   10 +-
 drivers/staging/iio/addac/adt7316.c                |    2 +
 drivers/staging/iio/chrdev.h                       |   52 +--
 drivers/staging/iio/dac/ad5504.c                   |    1 +
 drivers/staging/iio/gyro/adis16260_core.c          |    6 +-
 drivers/staging/iio/iio.h                          |    3 +-
 drivers/staging/iio/iio_core.h                     |   39 +-
 drivers/staging/iio/imu/adis16400_core.c           |    6 +-
 drivers/staging/iio/industrialio-core.c            |  273 +++++-----
 drivers/staging/iio/industrialio-ring.c            |  220 +++-----
 drivers/staging/iio/kfifo_buf.c                    |   26 +-
 drivers/staging/iio/meter/ade7758.h                |    5 +-
 drivers/staging/iio/meter/ade7758_core.c           |    6 +-
 drivers/staging/iio/meter/ade7758_ring.c           |    4 +-
 drivers/staging/iio/ring_generic.h                 |   28 +-
 drivers/staging/iio/ring_sw.c                      |   25 +-
 40 files changed, 627 insertions(+), 769 deletions(-)

-- 
1.7.3.4

