Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/4 V2] staging:iio: Add support for multiple buffers
Date: Wed, 30 May 2012 20:36:30 +0100
Message-Id: <1338406594-14550-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

This is basically a rebase of the series from a few months back.
I held this one off as it's 'interesting and invasive'.

Basically this adds a level of indirection to the path between
the hardware and the software buffers.  This allows us to have
multiple buffers each with their own demuxer.  Clearly the
hardware has to be configured to provide all the channels
anyone is interested in, but then the flow looks something like.

Data ---> Demux1 ---> subset of data --> buffer1
 |
 -------> Demux2 ---> subset of data --> buffer2.

Note the demuxers should be very nearly transparent
if all the data is going on to the relevant buffer.

So you may ask ' Why?'  In short - it allows us to
do clean data flow to multiple consumers such as an
IIO buffer, input, hwmon etc for devices running in
an trigger driven mode.

I also have a few thoughts on basic in kernel filtering
dependent on new buffer implementations.

Anyhow. Whilst the patch is relatively large it mostly
boils down to code for tearing down all current buffers,
reconfiguring the device and then building them all back
up again.

The input driver shoes the sort of client we might have.
(It probably needs more work) I'd like to get the
first three patches in the linux-next asap so they
get lots of testing prior to the next merge window.

Hence if anyone has time to take a look that would be
great!

Jonathan

Jonathan Cameron (4):
  staging:iio: Add support for multiple buffers
  staging:iio:in kernel users: Add a data field for channel specific
    info.
  staging:iio: add a callback buffer for in kernel push interface
  staging:iio: Proof of concept input driver.

 drivers/iio/Kconfig                             |    6 +
 drivers/iio/Makefile                            |    1 +
 drivers/iio/buffer_cb.c                         |  115 ++++++++
 drivers/iio/industrialio-buffer.c               |  335 +++++++++++++++--------
 drivers/iio/industrialio-core.c                 |    1 +
 drivers/iio/inkern.c                            |    1 +
 drivers/staging/iio/Kconfig                     |   11 +
 drivers/staging/iio/Makefile                    |    1 +
 drivers/staging/iio/accel/adis16201_ring.c      |    4 +-
 drivers/staging/iio/accel/adis16203_ring.c      |    6 +-
 drivers/staging/iio/accel/adis16204_ring.c      |    3 +-
 drivers/staging/iio/accel/adis16209_ring.c      |    3 +-
 drivers/staging/iio/accel/adis16240_ring.c      |    4 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c      |    3 +-
 drivers/staging/iio/adc/ad7192.c                |    3 +-
 drivers/staging/iio/adc/ad7298_ring.c           |    5 +-
 drivers/staging/iio/adc/ad7476_ring.c           |    2 +-
 drivers/staging/iio/adc/ad7606_ring.c           |    3 +-
 drivers/staging/iio/adc/ad7793.c                |    3 +-
 drivers/staging/iio/adc/ad7887_ring.c           |    2 +-
 drivers/staging/iio/adc/ad799x_ring.c           |    3 +-
 drivers/staging/iio/adc/max1363_ring.c          |    2 +-
 drivers/staging/iio/gyro/adis16260_ring.c       |    3 +-
 drivers/staging/iio/iio_input.c                 |  176 ++++++++++++
 drivers/staging/iio/iio_input.h                 |   23 ++
 drivers/staging/iio/iio_simple_dummy_buffer.c   |    5 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c |    3 +-
 drivers/staging/iio/imu/adis16400_ring.c        |    2 +-
 drivers/staging/iio/meter/ade7758_ring.c        |    3 +-
 include/linux/iio/buffer.h                      |   24 +-
 include/linux/iio/consumer.h                    |   48 ++++
 include/linux/iio/iio.h                         |    2 +
 include/linux/iio/machine.h                     |    2 +
 33 files changed, 651 insertions(+), 157 deletions(-)
 create mode 100644 drivers/iio/buffer_cb.c
 create mode 100644 drivers/staging/iio/iio_input.c
 create mode 100644 drivers/staging/iio/iio_input.h

-- 
1.7.10.2
