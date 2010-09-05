Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: manuel.stahl@iis.fraunhofer.de,
	drivers@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [RFC PATCH 0/4] staging:iio:adis16350 various updates and fixes
Date: Sun,  5 Sep 2010 23:20:14 +0100
Message-Id: <1283725218-15157-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

The first patch fixes a bug in the current driver.  It assumes
all devices supported can do burst reads.  At least if the data
sheets are to be believed this is only available in the newer
models.

Patch 2 fixes an issue that has snuck into a number of drivers.
The use of an event for the trigger code on lis3l02dq was needed
because it uses the same physical line for datardy and threshold
interrupts (though not at the same time).  This device has two
physical lines. In my view it is reasonable to assume anyone wanting
both datardy triggering and events can select at compile time which
comes out of which pin (or if only one pin is connected, they can
set what it does.) Right now I haven't put the platform data in place
to do this.  This needs to be tested before I send this patch set
to Greg.

Patch 3 puts in event support.  It's complex, but then what the
device has some complex abilities. Still if anyone can see any
simplifications without breaking the interface I would definitely
like to hear them!

Patch 4 is trivial fix picked up by sparse whilst checking
the other patches.

Thanks,

Jonathan Cameron (4):
  staging:iio:adis16350 add non burst buffer fill and fix burst logic
  staging:iio:adis16350 move datardy trigger to straight interrupt.
  staging:iio:adis16350 Add optional event support
  staging:iio:adis16350 add missing registration of temp_offset attr

 drivers/staging/iio/adc/adc.h               |    8 ++-
 drivers/staging/iio/gyro/gyro.h             |   31 +++++++---
 drivers/staging/iio/imu/Kconfig             |    7 ++
 drivers/staging/iio/imu/Makefile            |    1 +
 drivers/staging/iio/imu/adis16350.h         |   64 +++++++++++++++++----
 drivers/staging/iio/imu/adis16350_core.c    |   54 +++++++----------
 drivers/staging/iio/imu/adis16350_ring.c    |   85 +++++++++++++++++++++++----
 drivers/staging/iio/imu/adis16350_trigger.c |   52 +++++------------
 drivers/staging/iio/sysfs.h                 |   17 +++++-
 9 files changed, 216 insertions(+), 103 deletions(-)
