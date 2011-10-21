Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [V2 PATCH 0/2] staging:iio: header reorganization
Date: Fri, 21 Oct 2011 12:49:36 +0100
Message-Id: <1319197778-32347-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Since V1:

Merged Lars-Peter's patch adding ioctl.h as needed.
Added patch for event_data types as technically that's
just needed to keep userspace happy rather than causing
possible compile problems.

V1 message:

ssue brought up by Lars-Peter Clausen. This is a varient of what
he suggested.

io/iio.h for driver stuff (has to include types.h)
	Sub files for the bits drivers may or may not use
	iio/sysfs.h
	iio/buffer.h (contents of current buffer_generic.h)
	(obviously anything offering events will need events.h as well)
iio/types.h for the enums that matter to both
	iio_chan_type, iio_modifier
iio/events.h for the event code stuff
	IIO_EVENT_CODE and friends.  + everything in chrdev.h  So this
	is the stuff that userspace cares about.
	Also include iio_event_type, iio_event_direction

Thus iio drivers include iio.h + as required
events.h
sysfs.h
buffer.h

in kernel users (once that interface is merged) will need inkern.h
which will pull in types.h

Userspace will need just events.h (which pulls in types.h) to get
everything they need to know about.  Buffer userspace access doesn't
currently need any core defines. All information about the data
format is passed through sysfs.

Jonathan Cameron (1):
  staging:iio: header reorganization

Lars-Peter Clausen (1):
  staging:iio: Use userspace types for iio_event_data

 drivers/staging/iio/accel/adis16201_core.c      |    2 +-
 drivers/staging/iio/accel/adis16203_core.c      |    2 +-
 drivers/staging/iio/accel/adis16204_core.c      |    2 +-
 drivers/staging/iio/accel/adis16209_core.c      |    2 +-
 drivers/staging/iio/accel/adis16240_core.c      |    2 +-
 drivers/staging/iio/accel/lis3l02dq_core.c      |    3 +-
 drivers/staging/iio/accel/sca3000_core.c        |    3 +-
 drivers/staging/iio/accel/sca3000_ring.c        |    2 +-
 drivers/staging/iio/adc/ad7192.c                |    2 +-
 drivers/staging/iio/adc/ad7280a.c               |    1 +
 drivers/staging/iio/adc/ad7291.c                |    1 +
 drivers/staging/iio/adc/ad7298_core.c           |    2 +-
 drivers/staging/iio/adc/ad7298_ring.c           |    2 +-
 drivers/staging/iio/adc/ad7476_core.c           |    2 +-
 drivers/staging/iio/adc/ad7476_ring.c           |    2 +-
 drivers/staging/iio/adc/ad7606_core.c           |    2 +-
 drivers/staging/iio/adc/ad7606_ring.c           |    2 +-
 drivers/staging/iio/adc/ad7793.c                |    2 +-
 drivers/staging/iio/adc/ad7816.c                |    1 +
 drivers/staging/iio/adc/ad7887_core.c           |    2 +-
 drivers/staging/iio/adc/ad7887_ring.c           |    2 +-
 drivers/staging/iio/adc/ad799x_core.c           |    3 +-
 drivers/staging/iio/adc/ad799x_ring.c           |    2 +-
 drivers/staging/iio/adc/adt7310.c               |    2 +-
 drivers/staging/iio/adc/adt7410.c               |    1 +
 drivers/staging/iio/adc/max1363_core.c          |    3 +-
 drivers/staging/iio/adc/max1363_ring.c          |    2 +-
 drivers/staging/iio/addac/adt7316.c             |    1 +
 drivers/staging/iio/buffer.h                    |  227 ++++++++++++++++++++++
 drivers/staging/iio/buffer_generic.h            |  228 -----------------------
 drivers/staging/iio/cdc/ad7150.c                |    2 +-
 drivers/staging/iio/chrdev.h                    |   25 ---
 drivers/staging/iio/dac/ad5504.c                |    1 +
 drivers/staging/iio/events.h                    |   73 +++++++
 drivers/staging/iio/gyro/adis16260_core.c       |    2 +-
 drivers/staging/iio/iio.h                       |   39 +----
 drivers/staging/iio/iio_simple_dummy.c          |    3 +-
 drivers/staging/iio/iio_simple_dummy_events.c   |    1 +
 drivers/staging/iio/impedance-analyzer/ad5933.c |    2 +-
 drivers/staging/iio/imu/adis16400_core.c        |    2 +-
 drivers/staging/iio/industrialio-buffer.c       |    2 +-
 drivers/staging/iio/industrialio-core.c         |    2 +-
 drivers/staging/iio/kfifo_buf.h                 |    2 +-
 drivers/staging/iio/light/tsl2563.c             |    1 +
 drivers/staging/iio/meter/ade7758_core.c        |    2 +-
 drivers/staging/iio/ring_sw.h                   |    2 +-
 drivers/staging/iio/sysfs.h                     |   43 -----
 drivers/staging/iio/types.h                     |   49 +++++
 48 files changed, 396 insertions(+), 367 deletions(-)
 create mode 100644 drivers/staging/iio/buffer.h
 delete mode 100644 drivers/staging/iio/buffer_generic.h
 delete mode 100644 drivers/staging/iio/chrdev.h
 create mode 100644 drivers/staging/iio/events.h
 create mode 100644 drivers/staging/iio/types.h

-- 
1.7.7
