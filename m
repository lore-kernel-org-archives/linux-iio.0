Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/3] staging:iio:Fixes and minor abi related cleanups
Date: Wed, 14 Sep 2011 13:01:22 +0100
Message-Id: <1316001685-13375-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi Greg,

The 3rd patch fixes some fallout from reorganizing the sysfs attribute
registration. I failed to note a side effect of shuffling when
the device was registered later was that the iio device id (internal
to IIO) wasn't allocated before it was used to build trigger names.
Fix was a simple matter of shifting where that allocation occured to
creation ouf an iio device rather than registration of one.

The other two are cleanups of attribute naming for things that aren't
registered through the iio_chan_spec structure arrays for whatever
reason.  The documentation for this is already there.

Thanks,

Jonathan

Jonathan Cameron (3):
  staging:iio:tree wide.  abi fixup for in_ out_ prefix introduction.
  staging:iio:adc:ad7606 add channel type specification to range
    attributes.
  staging:iio: move id and device name setting to iio_device_allocate.

 drivers/staging/iio/accel/adis16204_core.c      |   12 ++--
 drivers/staging/iio/accel/adis16240_core.c      |    4 +-
 drivers/staging/iio/accel/sca3000_core.c        |   10 ++--
 drivers/staging/iio/accel/sca3000_ring.c        |    4 +-
 drivers/staging/iio/adc/ad7192.c                |    9 ++--
 drivers/staging/iio/adc/ad7280a.c               |   12 ++--
 drivers/staging/iio/adc/ad7606_core.c           |   15 +++---
 drivers/staging/iio/adc/ad7745.c                |   36 +++++++-------
 drivers/staging/iio/adc/ad799x_core.c           |   60 +++++++++++-----------
 drivers/staging/iio/dac/ad5446.c                |   26 +++++-----
 drivers/staging/iio/dac/ad5504.c                |   43 ++++++++--------
 drivers/staging/iio/dac/ad5624r_spi.c           |   30 ++++++------
 drivers/staging/iio/dac/ad5686.c                |   30 ++++++-----
 drivers/staging/iio/dac/dac.h                   |    2 +-
 drivers/staging/iio/dac/max517.c                |   25 +++++----
 drivers/staging/iio/impedance-analyzer/ad5933.c |   32 ++++++------
 drivers/staging/iio/industrialio-core.c         |   25 +++++-----
 drivers/staging/iio/magnetometer/hmc5843.c      |    4 +-
 drivers/staging/iio/meter/ade7753.c             |   10 ++--
 drivers/staging/iio/meter/ade7754.c             |   10 ++--
 drivers/staging/iio/meter/ade7758_core.c        |   10 ++--
 drivers/staging/iio/meter/ade7759.c             |   10 ++--
 drivers/staging/iio/sysfs.h                     |    6 +-
 23 files changed, 217 insertions(+), 208 deletions(-)

-- 
1.7.3.4
