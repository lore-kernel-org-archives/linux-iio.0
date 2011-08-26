Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 00/12] staging:iio: New stuff and reworks.
Date: Fri, 26 Aug 2011 11:16:23 +0100
Message-Id: <1314353795-7437-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi All,

This is the interesting series of the day. I could have broken
it down futher, but then it would mostly be single patches.

A fair bit of this you will have seen before, but this is the form
I intend to send to greg if no one shouts.

So what's here:

1) Add in_/out_ prefixes to all channels generate via iio_chan_spec.
   We will need a cleanup series adding them to all the stuff provided
   directly by the drivers.  (what fun).
2) Docs for the above

3) Endian description for scan elements.  Here we have a cpu version
   internally. Note that will not be leaving staging. All drivers
   should get it right themselves.

4) Reorganize the default scan mask settings so that they won't cause
   trouble (will insert a separate patch here to handle the issue Michael
   has found with adis16400.

5) Bitmaps for channel masks.  This is fiddly, but does allow for devices
   with a lot more channels so we need to do this or something similar.

6) 64bit event codes.  Gives us more space and avoids the reuse issues
   with the previous 32bit ones. Very few disadvantages and a lot of
   advantages!

7) rework the attribute registration.  This is invasive and nasty but
   necessary if we want udev to know attributes have been created. Upshot
   of that discussion about allowing empty groups in sysfs (which was
   the wrong way to solve this). Side effect is we can get rid of that
   hideous regdone trick that was in lots of drivers.

8) Make the address element of iio_device_attr 64 bit to allow for new
   long event codes. Makes life a lot easier in some corner cases.

9) the EV_BIT macro had some odd naming. Trivial fix.

10) Get ready for CDC (capacitance to digital convertors) being handled
    properly.

11) Differential channel handling rework.  the IIO_VOLTAGE_DIFF channel
    type was a bad idea.  Allow all channel types to be differential by
    adding an explicit flag.  This means that the differential CDCs
    are much cleaner. Requires updating all previous differential users.
    Whilst there cleared out some IIO_CHAN macro usage as that's slowly
    going away.

What fun,

All comments welcome.

Jonathan

Jonathan Cameron (12):
  staging:iio: ABI rework - add in_ or out_ prefix to channnels
  staging:iio:Documentation sysfs-bus-iio add in and out prefixes
  staging:iio:scan element types: introduce endian description to the
    data format.
  staging:iio:various move default scan mask setting after ring
    register or remove
  staging:iio: Switch the channel masks to bitmaps so as to allow for
    more channels.
  staging:iio:events - new 64 bit code structure and push out drivers.
  staging:iio: rework of attribute registration.
  staging:iio:attrs - make address a u64 to allow event codes to be
    used.
  staging:iio:naming in the EV_BIT macro fix.
  staging:iio: Add capacitance type and average_raw chan info.
  staging:iio:add adaptive event types and missing extract_type macro.
  staging:iio: Differential channel handling - use explicit flag rather
    than types.

 drivers/staging/iio/Documentation/sysfs-bus-iio |  536 +++++++++++-----------
 drivers/staging/iio/accel/adis16201_core.c      |   16 +-
 drivers/staging/iio/accel/adis16201_ring.c      |    9 -
 drivers/staging/iio/accel/adis16203_core.c      |   17 +-
 drivers/staging/iio/accel/adis16203_ring.c      |    7 -
 drivers/staging/iio/accel/adis16204_core.c      |   18 +-
 drivers/staging/iio/accel/adis16204_ring.c      |    7 -
 drivers/staging/iio/accel/adis16209_core.c      |   16 +-
 drivers/staging/iio/accel/adis16209_ring.c      |   10 -
 drivers/staging/iio/accel/adis16240_core.c      |   15 +-
 drivers/staging/iio/accel/adis16240_ring.c      |    8 -
 drivers/staging/iio/accel/lis3l02dq_core.c      |   26 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c      |   10 +-
 drivers/staging/iio/accel/sca3000_core.c        |   16 +-
 drivers/staging/iio/accel/sca3000_ring.c        |    4 -
 drivers/staging/iio/adc/ad7150.c                |   20 +-
 drivers/staging/iio/adc/ad7192.c                |   14 +-
 drivers/staging/iio/adc/ad7280a.c               |   26 +-
 drivers/staging/iio/adc/ad7291.c                |   12 +-
 drivers/staging/iio/adc/ad7298_core.c           |   18 +-
 drivers/staging/iio/adc/ad7298_ring.c           |    4 +-
 drivers/staging/iio/adc/ad7476_core.c           |   16 +-
 drivers/staging/iio/adc/ad7606_core.c           |   17 +-
 drivers/staging/iio/adc/ad7745.c                |   18 +-
 drivers/staging/iio/adc/ad7793.c                |  210 ++++++---
 drivers/staging/iio/adc/ad7816.c                |   15 +-
 drivers/staging/iio/adc/ad7887.h                |    4 +-
 drivers/staging/iio/adc/ad7887_core.c           |   20 +-
 drivers/staging/iio/adc/ad7887_ring.c           |   10 +-
 drivers/staging/iio/adc/ad799x.h                |    4 +-
 drivers/staging/iio/adc/ad799x_core.c           |   19 +-
 drivers/staging/iio/adc/ad799x_ring.c           |   18 +-
 drivers/staging/iio/adc/adt7310.c               |   12 +-
 drivers/staging/iio/adc/adt7410.c               |   11 +-
 drivers/staging/iio/adc/adt75.c                 |   12 +-
 drivers/staging/iio/adc/max1363.h               |    8 +-
 drivers/staging/iio/adc/max1363_core.c          |  263 +++++------
 drivers/staging/iio/adc/max1363_ring.c          |   22 +-
 drivers/staging/iio/addac/adt7316.c             |   13 +-
 drivers/staging/iio/chrdev.h                    |    2 +-
 drivers/staging/iio/dac/ad5504.c                |   40 +-
 drivers/staging/iio/dac/ad5624r_spi.c           |    1 -
 drivers/staging/iio/dac/ad5686.c                |   83 ++---
 drivers/staging/iio/dac/ad5791.c                |    2 +
 drivers/staging/iio/gyro/adis16060_core.c       |    8 +-
 drivers/staging/iio/gyro/adis16080_core.c       |    9 +-
 drivers/staging/iio/gyro/adis16260_core.c       |   24 +-
 drivers/staging/iio/gyro/adis16260_ring.c       |    7 -
 drivers/staging/iio/iio.h                       |   77 +++-
 drivers/staging/iio/iio_core.h                  |    3 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c |   18 +-
 drivers/staging/iio/imu/adis16400_core.c        |   16 +-
 drivers/staging/iio/imu/adis16400_ring.c        |    9 +-
 drivers/staging/iio/industrialio-core.c         |  448 +++++++++----------
 drivers/staging/iio/industrialio-ring.c         |  223 +++++++---
 drivers/staging/iio/industrialio-trigger.c      |    8 +-
 drivers/staging/iio/light/tsl2563.c             |   21 +-
 drivers/staging/iio/meter/ade7753.c             |   15 +-
 drivers/staging/iio/meter/ade7754.c             |   16 +-
 drivers/staging/iio/meter/ade7758.h             |    2 +-
 drivers/staging/iio/meter/ade7758_core.c        |   20 +-
 drivers/staging/iio/meter/ade7758_ring.c        |    2 +-
 drivers/staging/iio/meter/ade7759.c             |   12 +-
 drivers/staging/iio/resolver/ad2s1210.c         |    1 +
 drivers/staging/iio/ring_generic.h              |   67 +---
 drivers/staging/iio/sysfs.h                     |   46 ++-
 66 files changed, 1334 insertions(+), 1347 deletions(-)

-- 
1.7.3.4
