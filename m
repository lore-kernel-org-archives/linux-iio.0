Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	manuel.stahl@iis.fraunhofer.de,
	device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [RFC PATCH 0/7] IIO: Reduce to 1 the number of chrdevs per device
Date: Mon, 18 Jul 2011 14:49:57 +0100
Message-Id: <1310997004-22728-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This is another of Arnd's suggestions.

Some of the patches here are just pre conversion reworks to make the important
bit easier and some are cleanups of headers etc as a result of things not
being needed any more.

One little change I slipped in here:

devices now have iio:deviceX as their name so that we have something
sensibly named under /dev/

The important patches are 4 and 6.

4 uses Arnd's suggestion of an annon_fd obtained via ioctl on the buffer
chrdev to get a file for easy use for reading events.  This is a very neat
solution that lets us keep the actual event system separate from the data
stream without two chrdevs.

6. Moves the remaining single chrdev so it associated with the iio_dev rather
than the buffer.  This means we now only have two types of device (other than
weird ones like the sysfs trigger management node), triggers and devices.
Given either can exist independently, those two don't make sense to merge.

Anyhow, I'm far from convinced that the allocation / deallocation is now
correct and that there aren't any race conditions on removal od devices.
(then again I'm not convinced there weren't any of those before.)

Note I haven't ammended the nature of either 'chrdev' at all. There
is more to be done there.

Note, this is 3.2 material so no particular rush for comments.
Having said that, please do pull it into local trees and hammer it
nice and hard to see where I messed up.

For reference a minimal test app is:

#include <stdio.h>
/* little dirty test prog */
 #include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdint.h>

struct iio_event_data {
	int	id;
	int64_t	timestamp;
};


int main(int argc, char **argv)
{
	int ret;
	int fp;
	int data;
	int i = 0;
	FILE *evfp;
	struct iio_event_data ev;
	fp = open(argv[1], O_RDONLY);
	ret = ioctl(fp, 0, &data);
	/* So we have the fd (in theory) of the anon file */
	evfp = fdopen(data, "r");

	if (evfp)
		for (i = 0; i < 100; i++) {
			ret = fread( &ev, sizeof(ev), 1, evfp);
			printf("%d %lld\n", ev.id, ev.timestamp);
		}
	return 0;
}

Jonathan

Jonathan Cameron (7):
  staging:iio:trigger push functions that don't need to be generaly
    available down into the core.
  staging:iio:kfifo buffer - push structure definition down into
    implementation.
  staging:iio:chrdev.h rationalization.
  staging:iio: remove specific chrdev for event reading. Get fd from
    ioctl on buffer.
  staging:iio: squash chrdev handler remains into users.
  staging:iio: push the main buffer chrdev down to the top level.
  staging:iio: remove now defunct header definitions and add some
    statics

 drivers/staging/iio/Documentation/generic_buffer.c |   11 +-
 drivers/staging/iio/Documentation/iio_utils.h      |    2 +-
 drivers/staging/iio/accel/adis16201_core.c         |    6 +-
 drivers/staging/iio/accel/adis16203_core.c         |    6 +-
 drivers/staging/iio/accel/adis16204_core.c         |    6 +-
 drivers/staging/iio/accel/adis16209_core.c         |    6 +-
 drivers/staging/iio/accel/adis16240_core.c         |    6 +-
 drivers/staging/iio/accel/lis3l02dq_core.c         |    6 +-
 drivers/staging/iio/accel/sca3000_core.c           |    4 +-
 drivers/staging/iio/adc/ad7298_core.c              |    4 +-
 drivers/staging/iio/adc/ad7476_core.c              |    4 +-
 drivers/staging/iio/adc/ad7606_core.c              |    4 +-
 drivers/staging/iio/adc/ad7793.c                   |    6 +-
 drivers/staging/iio/adc/ad7887_core.c              |    4 +-
 drivers/staging/iio/adc/ad799x_core.c              |    4 +-
 drivers/staging/iio/adc/max1363_core.c             |    6 +-
 drivers/staging/iio/chrdev.h                       |   51 ----
 drivers/staging/iio/gyro/adis16260_core.c          |    6 +-
 drivers/staging/iio/iio.h                          |    4 +-
 drivers/staging/iio/iio_core.h                     |   39 +++-
 drivers/staging/iio/imu/adis16400_core.c           |    6 +-
 drivers/staging/iio/industrialio-core.c            |  273 +++++++++++---------
 drivers/staging/iio/industrialio-ring.c            |  220 ++++++-----------
 drivers/staging/iio/industrialio-trigger.c         |   30 ++-
 drivers/staging/iio/kfifo_buf.c                    |   43 ++--
 drivers/staging/iio/kfifo_buf.h                    |    8 -
 drivers/staging/iio/meter/ade7758_core.c           |    2 +-
 drivers/staging/iio/ring_generic.h                 |   28 +--
 drivers/staging/iio/ring_sw.c                      |   23 +--
 drivers/staging/iio/trigger.h                      |   39 ---
 30 files changed, 368 insertions(+), 489 deletions(-)

-- 
1.7.3.4
