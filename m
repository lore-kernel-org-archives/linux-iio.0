Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/4 V6] staging:iio: Add support for multiple buffers (testing required!)
Date: Wed, 31 Oct 2012 10:30:27 +0000
Message-Id: <1351679431-7963-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Same as V5 but with the changes from Lars-Peter's review to close some
memory leaks and catch up with some changes in the subsystem that had
passed this by.  It should also now be possible to disable the
timestamp! (oops).

Thanks to Lars for his work reviewing my patches and also for his
excellent work reviewing in general! Without him the whole subsystem
would be moving a lot slower.


Again, more testing would be good (thanks for those who already
have).

In quick summary this is needed to do interrupt driven in kernel
clients as it adds the option to push to multiple 'buffer' interfaces.
Note that some of these may not actually do any buffering but rather
push directly into another subsytem (the example is input).

I would like to merge at least the first 3 patches early in this cycle.
What I need is some testing across a reasonable range of devices.  Review
is welcome of course as well!

The complexity in this set is entirely in the changes to industrialio-buffer.c
concerning how we go about adding and removing client buffers.  To do this
we need to work out which scan mask is appropriate given the requests of
all the given buffers (and whether we can satisfy it).  I've been testing
with the max1363 driver which probably has the most complex set of available
scan masks.  Thus when a new buffer is added or one is removed the whole
buffer set are torn down and built up again.  This may be undesirable for
some applications but should occur only rarely.

The example driver is for bridging to the input subsystem and still needs
some work, but that can occur later in this merge cycle whereas the changes
to the core really want to go in asap.

Changes since v3 

Rebased and added other drivers that have occured whilst this patch series
has been languishing in my local tree.

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
 drivers/iio/accel/hid-sensor-accel-3d.c         |  15 +-
 drivers/iio/adc/ad7266.c                        |   3 +-
 drivers/iio/adc/ad7476.c                        |   2 +-
 drivers/iio/adc/ad_sigma_delta.c                |   2 +-
 drivers/iio/adc/at91_adc.c                      |   3 +-
 drivers/iio/buffer_cb.c                         | 113 +++++++
 drivers/iio/gyro/hid-sensor-gyro-3d.c           |  15 +-
 drivers/iio/industrialio-buffer.c               | 380 ++++++++++++++++--------
 drivers/iio/industrialio-core.c                 |   1 +
 drivers/iio/inkern.c                            |   1 +
 drivers/iio/light/adjd_s311.c                   |   3 +-
 drivers/iio/light/hid-sensor-als.c              |  15 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c   |  15 +-
 drivers/staging/iio/Kconfig                     |  11 +
 drivers/staging/iio/Makefile                    |   1 +
 drivers/staging/iio/accel/adis16201_ring.c      |   2 +-
 drivers/staging/iio/accel/adis16203_ring.c      |   2 +-
 drivers/staging/iio/accel/adis16204_ring.c      |   2 +-
 drivers/staging/iio/accel/adis16209_ring.c      |   2 +-
 drivers/staging/iio/accel/adis16240_ring.c      |   2 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c      |   2 +-
 drivers/staging/iio/adc/ad7298_ring.c           |   2 +-
 drivers/staging/iio/adc/ad7606_ring.c           |   2 +-
 drivers/staging/iio/adc/ad7887_ring.c           |   2 +-
 drivers/staging/iio/adc/ad799x_ring.c           |   2 +-
 drivers/staging/iio/adc/max1363_ring.c          |   2 +-
 drivers/staging/iio/gyro/adis16260_ring.c       |   2 +-
 drivers/staging/iio/iio_input.c                 | 225 ++++++++++++++
 drivers/staging/iio/iio_input.h                 |  23 ++
 drivers/staging/iio/iio_simple_dummy_buffer.c   |   5 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c |   4 +-
 drivers/staging/iio/imu/adis16400_ring.c        |   5 +-
 drivers/staging/iio/meter/ade7758_ring.c        |   2 +-
 include/linux/iio/buffer.h                      |  24 +-
 include/linux/iio/consumer.h                    |  48 +++
 include/linux/iio/iio.h                         |   2 +
 include/linux/iio/machine.h                     |   2 +
 39 files changed, 743 insertions(+), 208 deletions(-)
 create mode 100644 drivers/iio/buffer_cb.c
 create mode 100644 drivers/staging/iio/iio_input.c
 create mode 100644 drivers/staging/iio/iio_input.h

-- 
1.7.12.4
