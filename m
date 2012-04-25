Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:43700 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab2DYOzI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Apr 2012 10:55:08 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/5] IIO: Move the core out of staging.
Date: Wed, 25 Apr 2012 15:54:55 +0100
Message-Id: <1335365700-1138-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Greg,

Here is the promised patch series.

I stalled it for a few days over whether we should switch some of the
Kconfig selects to depends.  Lars-Peter talked me out of it arguing
it made little sense to users.  There are some cleanups to be made
there but they can occur at a later date.

Clearly there are lots more docs to move, but some of those need going
over with a fine toothed comb as they have rotted somewhat.  We'll
work on that in the near future.

Thanks,

Jonathan

Jonathan Cameron (5):
  staging:iio:documentation pull a few sysfs entries out of main docs.
  staging:iio:Documentation Trivial typo fixes.
  IIO: Move core headers to include/linux/iio
  IIO: Move the core files to drivers/iio
  IIO: Move the core abi documentation from staging

 .../ABI/testing}/sysfs-bus-iio                     |   27 +---------
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    1 +
 drivers/iio/Kconfig                                |   51 ++++++++++++++++++++
 drivers/iio/Makefile                               |   10 ++++
 drivers/{staging => }/iio/iio_core.h               |    0
 drivers/{staging => }/iio/iio_core_trigger.h       |    0
 drivers/{staging => }/iio/industrialio-buffer.c    |    6 +-
 drivers/{staging => }/iio/industrialio-core.c      |    6 +-
 drivers/{staging => }/iio/industrialio-event.c     |    6 +-
 drivers/{staging => }/iio/industrialio-trigger.c   |    6 +-
 drivers/{staging => }/iio/inkern.c                 |    8 ++--
 drivers/{staging => }/iio/kfifo_buf.c              |    3 +-
 .../staging/iio/Documentation/iio_event_monitor.c  |    2 +-
 .../staging/iio/Documentation/sysfs-bus-iio-ad7192 |   20 ++++++++
 drivers/staging/iio/Kconfig                        |   44 +----------------
 drivers/staging/iio/Makefile                       |    6 --
 drivers/staging/iio/accel/adis16201_core.c         |    6 +-
 drivers/staging/iio/accel/adis16201_ring.c         |    4 +-
 drivers/staging/iio/accel/adis16201_trigger.c      |    4 +-
 drivers/staging/iio/accel/adis16203_core.c         |    6 +-
 drivers/staging/iio/accel/adis16203_ring.c         |    4 +-
 drivers/staging/iio/accel/adis16203_trigger.c      |    4 +-
 drivers/staging/iio/accel/adis16204_core.c         |    6 +-
 drivers/staging/iio/accel/adis16204_ring.c         |    4 +-
 drivers/staging/iio/accel/adis16204_trigger.c      |    4 +-
 drivers/staging/iio/accel/adis16209_core.c         |    6 +-
 drivers/staging/iio/accel/adis16209_ring.c         |    4 +-
 drivers/staging/iio/accel/adis16209_trigger.c      |    4 +-
 drivers/staging/iio/accel/adis16220_core.c         |    4 +-
 drivers/staging/iio/accel/adis16240_core.c         |    6 +-
 drivers/staging/iio/accel/adis16240_ring.c         |    4 +-
 drivers/staging/iio/accel/adis16240_trigger.c      |    4 +-
 drivers/staging/iio/accel/kxsd9.c                  |    4 +-
 drivers/staging/iio/accel/lis3l02dq_core.c         |    8 ++--
 drivers/staging/iio/accel/lis3l02dq_ring.c         |    8 ++--
 drivers/staging/iio/accel/sca3000_core.c           |    8 ++--
 drivers/staging/iio/accel/sca3000_ring.c           |    6 +-
 drivers/staging/iio/adc/ad7192.c                   |   10 ++--
 drivers/staging/iio/adc/ad7280a.c                  |    6 +-
 drivers/staging/iio/adc/ad7291.c                   |    6 +-
 drivers/staging/iio/adc/ad7298_core.c              |    6 +-
 drivers/staging/iio/adc/ad7298_ring.c              |    6 +-
 drivers/staging/iio/adc/ad7476_core.c              |    6 +-
 drivers/staging/iio/adc/ad7476_ring.c              |    6 +-
 drivers/staging/iio/adc/ad7606_core.c              |    6 +-
 drivers/staging/iio/adc/ad7606_par.c               |    2 +-
 drivers/staging/iio/adc/ad7606_ring.c              |    6 +-
 drivers/staging/iio/adc/ad7606_spi.c               |    2 +-
 drivers/staging/iio/adc/ad7780.c                   |    4 +-
 drivers/staging/iio/adc/ad7793.c                   |   10 ++--
 drivers/staging/iio/adc/ad7816.c                   |    6 +-
 drivers/staging/iio/adc/ad7887_core.c              |    6 +-
 drivers/staging/iio/adc/ad7887_ring.c              |    6 +-
 drivers/staging/iio/adc/ad799x_core.c              |    8 ++--
 drivers/staging/iio/adc/ad799x_ring.c              |    6 +-
 drivers/staging/iio/adc/adt7310.c                  |    6 +-
 drivers/staging/iio/adc/adt7410.c                  |    6 +-
 drivers/staging/iio/adc/lpc32xx_adc.c              |    4 +-
 drivers/staging/iio/adc/max1363_core.c             |   10 ++--
 drivers/staging/iio/adc/max1363_ring.c             |    6 +-
 drivers/staging/iio/adc/spear_adc.c                |    4 +-
 drivers/staging/iio/addac/adt7316.c                |    6 +-
 drivers/staging/iio/cdc/ad7150.c                   |    6 +-
 drivers/staging/iio/cdc/ad7152.c                   |    4 +-
 drivers/staging/iio/cdc/ad7746.c                   |    4 +-
 drivers/staging/iio/dac/ad5064.c                   |    4 +-
 drivers/staging/iio/dac/ad5360.c                   |    4 +-
 drivers/staging/iio/dac/ad5380.c                   |    4 +-
 drivers/staging/iio/dac/ad5421.c                   |    6 +-
 drivers/staging/iio/dac/ad5446.c                   |    4 +-
 drivers/staging/iio/dac/ad5504.c                   |    6 +-
 drivers/staging/iio/dac/ad5624r_spi.c              |    4 +-
 drivers/staging/iio/dac/ad5686.c                   |    4 +-
 drivers/staging/iio/dac/ad5764.c                   |    4 +-
 drivers/staging/iio/dac/ad5791.c                   |    4 +-
 drivers/staging/iio/dac/max517.c                   |    4 +-
 drivers/staging/iio/dds/ad5930.c                   |    4 +-
 drivers/staging/iio/dds/ad9832.c                   |    4 +-
 drivers/staging/iio/dds/ad9834.c                   |    4 +-
 drivers/staging/iio/dds/ad9850.c                   |    4 +-
 drivers/staging/iio/dds/ad9852.c                   |    4 +-
 drivers/staging/iio/dds/ad9910.c                   |    4 +-
 drivers/staging/iio/dds/ad9951.c                   |    4 +-
 drivers/staging/iio/gyro/adis16060_core.c          |    4 +-
 drivers/staging/iio/gyro/adis16080_core.c          |    4 +-
 drivers/staging/iio/gyro/adis16130_core.c          |    4 +-
 drivers/staging/iio/gyro/adis16260_core.c          |    6 +-
 drivers/staging/iio/gyro/adis16260_ring.c          |    4 +-
 drivers/staging/iio/gyro/adis16260_trigger.c       |    4 +-
 drivers/staging/iio/gyro/adxrs450_core.c           |    4 +-
 drivers/staging/iio/iio_dummy_evgen.c              |    4 +-
 drivers/staging/iio/iio_hwmon.c                    |    4 +-
 drivers/staging/iio/iio_simple_dummy.c             |    8 ++--
 drivers/staging/iio/iio_simple_dummy_buffer.c      |    6 +-
 drivers/staging/iio/iio_simple_dummy_events.c      |    6 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |    6 +-
 drivers/staging/iio/imu/adis16400_core.c           |    6 +-
 drivers/staging/iio/imu/adis16400_ring.c           |    4 +-
 drivers/staging/iio/imu/adis16400_trigger.c        |    4 +-
 drivers/staging/iio/light/isl29018.c               |    4 +-
 drivers/staging/iio/light/isl29028.c               |    4 +-
 drivers/staging/iio/light/tsl2563.c                |    6 +-
 drivers/staging/iio/light/tsl2583.c                |    2 +-
 drivers/staging/iio/light/tsl2x7x_core.c           |    6 +-
 drivers/staging/iio/magnetometer/ak8975.c          |    4 +-
 drivers/staging/iio/magnetometer/hmc5843.c         |    4 +-
 drivers/staging/iio/meter/ade7753.c                |    4 +-
 drivers/staging/iio/meter/ade7754.c                |    4 +-
 drivers/staging/iio/meter/ade7758_core.c           |    6 +-
 drivers/staging/iio/meter/ade7758_ring.c           |    4 +-
 drivers/staging/iio/meter/ade7758_trigger.c        |    4 +-
 drivers/staging/iio/meter/ade7759.c                |    4 +-
 drivers/staging/iio/meter/ade7854-i2c.c            |    2 +-
 drivers/staging/iio/meter/ade7854-spi.c            |    2 +-
 drivers/staging/iio/meter/ade7854.c                |    4 +-
 drivers/staging/iio/meter/meter.h                  |    2 +-
 drivers/staging/iio/resolver/ad2s1200.c            |    4 +-
 drivers/staging/iio/resolver/ad2s1210.c            |    4 +-
 drivers/staging/iio/resolver/ad2s90.c              |    4 +-
 drivers/staging/iio/ring_sw.c                      |    2 +-
 drivers/staging/iio/ring_sw.h                      |    2 +-
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c  |    4 +-
 drivers/staging/iio/trigger/iio-trig-gpio.c        |    4 +-
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    |    4 +-
 drivers/staging/iio/trigger/iio-trig-sysfs.c       |    4 +-
 {drivers/staging => include/linux}/iio/buffer.h    |    2 +-
 {drivers/staging => include/linux}/iio/consumer.h  |    2 +-
 {drivers/staging => include/linux}/iio/driver.h    |    0
 {drivers/staging => include/linux}/iio/events.h    |    2 +-
 {drivers/staging => include/linux}/iio/iio.h       |    2 +-
 {drivers/staging => include/linux}/iio/kfifo_buf.h |    4 +-
 {drivers/staging => include/linux}/iio/machine.h   |    0
 {drivers/staging => include/linux}/iio/sysfs.h     |    0
 {drivers/staging => include/linux}/iio/trigger.h   |    0
 .../linux}/iio/trigger_consumer.h                  |    0
 {drivers/staging => include/linux}/iio/types.h     |    0
 137 files changed, 376 insertions(+), 358 deletions(-)
 rename {drivers/staging/iio/Documentation => Documentation/ABI/testing}/sysfs-bus-iio (97%)
 create mode 100644 drivers/iio/Kconfig
 create mode 100644 drivers/iio/Makefile
 rename drivers/{staging => }/iio/iio_core.h (100%)
 rename drivers/{staging => }/iio/iio_core_trigger.h (100%)
 rename drivers/{staging => }/iio/industrialio-buffer.c (99%)
 rename drivers/{staging => }/iio/industrialio-core.c (99%)
 rename drivers/{staging => }/iio/industrialio-event.c (99%)
 rename drivers/{staging => }/iio/industrialio-trigger.c (99%)
 rename drivers/{staging => }/iio/inkern.c (98%)
 rename drivers/{staging => }/iio/kfifo_buf.c (99%)
 create mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-ad7192
 rename {drivers/staging => include/linux}/iio/buffer.h (99%)
 rename {drivers/staging => include/linux}/iio/consumer.h (99%)
 rename {drivers/staging => include/linux}/iio/driver.h (100%)
 rename {drivers/staging => include/linux}/iio/events.h (99%)
 rename {drivers/staging => include/linux}/iio/iio.h (99%)
 rename {drivers/staging => include/linux}/iio/kfifo_buf.h (70%)
 rename {drivers/staging => include/linux}/iio/machine.h (100%)
 rename {drivers/staging => include/linux}/iio/sysfs.h (100%)
 rename {drivers/staging => include/linux}/iio/trigger.h (100%)
 rename {drivers/staging => include/linux}/iio/trigger_consumer.h (100%)
 rename {drivers/staging => include/linux}/iio/types.h (100%)

