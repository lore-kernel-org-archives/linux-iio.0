Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	ldewangan@nvidia.com,
	shubhrajyoti@ti.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH V2 00/25] staging:iio: move chan_spec conversions and general cleanup.
Date: Fri,  1 Jul 2011 11:10:51 +0100
Message-Id: <1309515076-12323-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

V2: Now with actually setting of num_channels (and indeed channels in one driver).
Oops. One additional patch to cover the same bug in adis16260.  
I'll cherry pick that one and send on to Greg asap as the bug is in mainline.
Included here for reference.


V1:
This series is intended to remove the last few users of accel.h, gyro.h, magnet.h
and adc.h.

There are a fair few cleanps along the way including some bug fixes.

A few of these drivers are still in 'interesting' condition, but this
is at least a step in the right direction. Taking them further probably
requires test hardware.  Note this set is build tested only.
(obviously for simple header removal that's enough, but others could do with
testing if anyone has the hardware).

All comments welcome.

At some point we'll want to do the same for dds, resolver, dac and light.
If anyone else wants to take one of those, feel free. *looks around hopefuly*


This sits on top of

staging:iio:triggers introduce iio_trigger_ops to take const bits out of iio_trig_structure.
+ the dev_data removal patch and the tsl2583 one that Jon is testing.

Thanks all - looking like 3.1 is going to be a cleanup cycle for IIO
rather than anything particularly ground breaking.  Of course it's
relatively early days yet!

Thanks,

Jonathan


All comments welcome.

Jonathan Cameron (25):
  staging:iio:accel:kxsd9 cleanup and conversion to iio_chan_spec.
  staging:iio: add quadrature correction to chan info types.
  staging:iio:gyro:adxrs450 move to iio_chan_spec registration
  staging:iio:gyro:adxrs450 make more use of spi_read and spi_write.
  staging:iio:gyro:adxrs450 squish some trivial single call point
    wrappers functions.
  staging:iio:gyro:adis16080 convert to iio_chan_spec.
  staging:iio:gyro:adis16260 remove some unused headers
  staging:iio:imu:adis16400 remove unused headers.
  staging:iio:magnetometer:ak8975 convert to iio_chan_spec + cleanups.
  staging:iio:magnetometer:hmc5843 iio_chan_spec conversion.
  staging:iio:magnetometer: remove unused header magnet.h
  staging:iio:gyro:adis16130 fix adis16130_spi_read which was never
    selecting the channel
  staging:iio:gyro:adis16130 drop control of adc resolution.
  staging:iio:gyro:adis16130 move to iio_chan_spec registration.
  staging:iio:gyro:adis16060 convert to iio_chan_spec
  staging:iio:gyro: remove gyro.h
  staging:iio:accel: usused header removals.
  staging:iio:inclinometer.h remove as now unused.
  staging:iio:adc: unused header removals.
  staging:iio:various  header includes that should never have been.
  staging:iio:accel:adis16204:  use peak_raw info_mask element + push
    some defs down from header.
  staging:iio:accel:adis16220 iio_chan_spec conversion.
  staging:iio:accel remove unused accel.h header.
  staging:iio:adc remove unused adc.h.
  staging:iio:gyro:adis16260 fix missing num_channels setup.

 drivers/staging/iio/accel/accel.h          |   87 -------
 drivers/staging/iio/accel/adis16201_core.c |    4 -
 drivers/staging/iio/accel/adis16201_ring.c |    1 -
 drivers/staging/iio/accel/adis16203_core.c |    3 -
 drivers/staging/iio/accel/adis16203_ring.c |    1 -
 drivers/staging/iio/accel/adis16204_core.c |   47 +++--
 drivers/staging/iio/accel/adis16204_ring.c |    1 -
 drivers/staging/iio/accel/adis16209_core.c |    3 -
 drivers/staging/iio/accel/adis16209_ring.c |    1 -
 drivers/staging/iio/accel/adis16220_core.c |  342 +++++++++++++++++-----------
 drivers/staging/iio/accel/adis16240_core.c |    2 -
 drivers/staging/iio/accel/adis16240_ring.c |    1 -
 drivers/staging/iio/accel/inclinometer.h   |   25 --
 drivers/staging/iio/accel/kxsd9.c          |  268 +++++++++-------------
 drivers/staging/iio/accel/lis3l02dq_core.c |    2 -
 drivers/staging/iio/accel/lis3l02dq_ring.c |    1 -
 drivers/staging/iio/accel/sca3000_core.c   |    1 -
 drivers/staging/iio/accel/sca3000_ring.c   |    1 -
 drivers/staging/iio/adc/ad7298_core.c      |    1 -
 drivers/staging/iio/adc/ad7476_core.c      |    1 -
 drivers/staging/iio/adc/ad7606_core.c      |    1 -
 drivers/staging/iio/adc/ad7780.c           |    1 -
 drivers/staging/iio/adc/ad7793.c           |    1 -
 drivers/staging/iio/adc/ad7887_core.c      |    2 +-
 drivers/staging/iio/adc/ad799x_core.c      |   13 +-
 drivers/staging/iio/adc/adc.h              |   42 ----
 drivers/staging/iio/adc/max1363_core.c     |   23 ++-
 drivers/staging/iio/gyro/adis16060_core.c  |  115 +++++-----
 drivers/staging/iio/gyro/adis16080_core.c  |   92 ++++----
 drivers/staging/iio/gyro/adis16130_core.c  |  144 ++++---------
 drivers/staging/iio/gyro/adis16260_core.c  |    4 +-
 drivers/staging/iio/gyro/adis16260_ring.c  |    1 -
 drivers/staging/iio/gyro/adxrs450_core.c   |  252 +++++++++------------
 drivers/staging/iio/gyro/gyro.h            |   85 -------
 drivers/staging/iio/iio.h                  |    3 +
 drivers/staging/iio/imu/adis16400_core.c   |    5 -
 drivers/staging/iio/imu/adis16400_ring.c   |    1 -
 drivers/staging/iio/industrialio-core.c    |    2 +
 drivers/staging/iio/magnetometer/ak8975.c  |  214 +++++++++---------
 drivers/staging/iio/magnetometer/hmc5843.c |   96 ++++----
 drivers/staging/iio/magnetometer/magnet.h  |   31 ---
 drivers/staging/iio/meter/ade7758_ring.c   |    1 -
 42 files changed, 793 insertions(+), 1129 deletions(-)
 delete mode 100644 drivers/staging/iio/accel/accel.h
 delete mode 100644 drivers/staging/iio/accel/inclinometer.h
 delete mode 100644 drivers/staging/iio/adc/adc.h
 delete mode 100644 drivers/staging/iio/gyro/gyro.h
 delete mode 100644 drivers/staging/iio/magnetometer/magnet.h

-- 
1.7.3.4
