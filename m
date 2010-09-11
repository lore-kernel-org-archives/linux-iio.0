Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Michael.Hennerich@analog.com,
	Robin.Getz@analog.com,
	manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [RFC PATCH 0/6] staging:iio:imu driver merges, fixes and new features.
Date: Sat, 11 Sep 2010 15:58:14 +0100
Message-Id: <1284217100-2469-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

The first 4 are repeat postings but are now complete (oops).

Cleaning up this driver set has been on my todo list for a while
and I've finally had a bit of time to see what could be done to
reduce the huge amount of repeat code found in the 3 IMU drivers.

This is an RFC for two reasons. Firstly I haven't tested this as
fully yet and will do so before merging.  I will do a whole
lot more testing on the adis16350 that I have.  Coverage of the
adis16300 and adis16400 would be great if anyone can do so.
I also haven't done full testing on all the build combinations yet.
(there is at least one known issue to clean up!)
Secondly the event patch in particularly has some elements not seen
elsewhere before that I would like people to consider.

Right now, only the adis16350 and adis16360 famillies are supported
by the event support patch.  I'll add support for the other parts
at a later date unless someone else beats me to it (hint!).  Note
this patch now actually contains the adis16350_event.c file that
was missing previously.

There is one effective change to all but the adis16400 ABIs.
When we originally proposed the [m]_<type>_<modifier>_en
attributes for scan modes I very carefully stated that the index
[m] for a given device would not necessarily cover all values between
0 and the highest present.  It was exactly this possible driver
merge that motivated that arguement. By allowing indexes to be
missed, we can have single drivers supporting various subsets of
sensor elements.  Here the devices are such that some interleaving
is possible.  This reduces the storage required for the event code,
so I have done it where possible.  Note the addition
of new devices to this driver in future may change this again!

As ever, all comments welcome.  Any tested-bys with a part number
would be particularly welcome.

Should be trivial to add the adis16367 and adis16385 to this driver.
Does anyone have one of these parts to test?

Jonathan Cameron (6):
  staging:iio:adis16350 add non burst buffer fill and fix burst logic
  staging:iio:adis16350 move datardy trigger to straight interrupt.
  staging:iio:adis16350 Add optional event support
  staging:iio:adis16350 add missing registration of temp_offset attr
  staging:iio:adis16300 merge into adis16350 driver
  staging:iio:adis16400 merge into adis16350 driver

 drivers/staging/iio/adc/adc.h               |    8 +-
 drivers/staging/iio/gyro/gyro.h             |   31 +-
 drivers/staging/iio/imu/Kconfig             |   30 +-
 drivers/staging/iio/imu/Makefile            |    9 +-
 drivers/staging/iio/imu/adis16300.h         |  184 -------
 drivers/staging/iio/imu/adis16300_core.c    |  756 ---------------------------
 drivers/staging/iio/imu/adis16300_ring.c    |  220 --------
 drivers/staging/iio/imu/adis16300_trigger.c |  125 -----
 drivers/staging/iio/imu/adis16350.h         |  117 ++++-
 drivers/staging/iio/imu/adis16350_core.c    |  287 +++++++++--
 drivers/staging/iio/imu/adis16350_event.c   |  499 ++++++++++++++++++
 drivers/staging/iio/imu/adis16350_ring.c    |  167 +++++-
 drivers/staging/iio/imu/adis16350_trigger.c |   40 +-
 drivers/staging/iio/imu/adis16400.h         |  208 --------
 drivers/staging/iio/imu/adis16400_core.c    |  752 --------------------------
 drivers/staging/iio/imu/adis16400_ring.c    |  231 --------
 drivers/staging/iio/sysfs.h                 |   17 +-
 17 files changed, 1067 insertions(+), 2614 deletions(-)
 delete mode 100644 drivers/staging/iio/imu/adis16300.h
 delete mode 100644 drivers/staging/iio/imu/adis16300_core.c
 delete mode 100644 drivers/staging/iio/imu/adis16300_ring.c
 delete mode 100644 drivers/staging/iio/imu/adis16300_trigger.c
 create mode 100644 drivers/staging/iio/imu/adis16350_event.c
 delete mode 100644 drivers/staging/iio/imu/adis16400.h
 delete mode 100644 drivers/staging/iio/imu/adis16400_core.c
 delete mode 100644 drivers/staging/iio/imu/adis16400_ring.c

-- 
1.7.2.2
