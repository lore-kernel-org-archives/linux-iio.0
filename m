Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:54656 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224Ab1H3LYi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 30 Aug 2011 07:24:38 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/7] staging:iio: character device merge
Date: Tue, 30 Aug 2011 12:32:42 +0100
Message-Id: <1314703969-15275-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Greg,

This is the first of the more interesting sets for IIO this round.
What we have here is another one of the changes Arnd Bergmann suggested.
(we have nearly caught up with everything in his review!)

It merges all of our character devices per hardware device down into one.
That device supports an ioctl (documentation for that dropped for now
as it would touch a doc file that doesn't have any staging related
elements) that is used to request an anonfd for the event interface.

Anyhow, this has been on linux-iio for quite a while and Michael has been
hammering it with his Analog devices parts without problem hence I'm
sending it on to you now.  We need to do some documentation for this
as well and that will follow sometime soon (IIO events were never well
documented in the first place - oops)

Thanks,

Jonathan

Text of pervious posting was:

Hi All,

I thought I'd best give this series one last airing before sending on
to Greg.  Note I'll be dropping the ioctl region patch for now as
there may be issues with reserving that for a staging driver?

Anyhow does what it says on the tin.

Michael, can you give me a tested by on this stuff (guessing you have
been given your iio-blue.git fixes etc).

Thanks,

Jonathan

And the one before that:


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
  staging:iio:kfifo buffer - push structure definition down into
    implementation.
  staging:iio:chrdev.h rationalization.
  staging:iio: remove specific chrdev for event reading. Get fd from
    ioctl on buffer.
  staging:iio: squash chrdev handler remains into users.
  staging:iio: push the main buffer chrdev down to the top level.
  staging:iio: remove now defunct header definitions and add some
    statics
  staging:iio:Documentation sysfs-bus-iio update for chrdev merge.

 drivers/staging/iio/Documentation/generic_buffer.c |   12 +-
 drivers/staging/iio/Documentation/iio_utils.h      |    2 +-
 drivers/staging/iio/Documentation/sysfs-bus-iio    |  573 ++++++++++----------
 drivers/staging/iio/accel/adis16201_core.c         |    6 +-
 drivers/staging/iio/accel/adis16203_core.c         |    6 +-
 drivers/staging/iio/accel/adis16204_core.c         |    6 +-
 drivers/staging/iio/accel/adis16209_core.c         |    6 +-
 drivers/staging/iio/accel/adis16240_core.c         |    6 +-
 drivers/staging/iio/accel/lis3l02dq_core.c         |    6 +-
 drivers/staging/iio/accel/sca3000_core.c           |    7 +-
 drivers/staging/iio/accel/sca3000_ring.c           |   23 +-
 drivers/staging/iio/adc/ad7150.c                   |    1 +
 drivers/staging/iio/adc/ad7192.c                   |    6 +-
 drivers/staging/iio/adc/ad7298_core.c              |    4 +-
 drivers/staging/iio/adc/ad7476_core.c              |    4 +-
 drivers/staging/iio/adc/ad7606_core.c              |    4 +-
 drivers/staging/iio/adc/ad7745.c                   |    1 +
 drivers/staging/iio/adc/ad7793.c                   |    6 +-
 drivers/staging/iio/adc/ad7816.c                   |    1 +
 drivers/staging/iio/adc/ad7887_core.c              |    4 +-
 drivers/staging/iio/adc/ad799x_core.c              |    6 +-
 drivers/staging/iio/adc/adt7310.c                  |    2 +
 drivers/staging/iio/adc/adt7410.c                  |    2 +
 drivers/staging/iio/adc/adt75.c                    |    1 +
 drivers/staging/iio/adc/max1363_core.c             |   10 +-
 drivers/staging/iio/addac/adt7316.c                |    2 +
 drivers/staging/iio/chrdev.h                       |   52 +--
 drivers/staging/iio/dac/ad5504.c                   |    1 +
 drivers/staging/iio/gyro/adis16260_core.c          |    6 +-
 drivers/staging/iio/iio.h                          |    3 +-
 drivers/staging/iio/iio_core.h                     |   39 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |    8 +-
 drivers/staging/iio/imu/adis16400_core.c           |    6 +-
 drivers/staging/iio/industrialio-core.c            |  279 ++++++-----
 drivers/staging/iio/industrialio-ring.c            |  220 +++-----
 drivers/staging/iio/kfifo_buf.c                    |   34 +-
 drivers/staging/iio/kfifo_buf.h                    |    8 -
 drivers/staging/iio/meter/ade7758.h                |    5 +-
 drivers/staging/iio/meter/ade7758_core.c           |    6 +-
 drivers/staging/iio/meter/ade7758_ring.c           |    4 +-
 drivers/staging/iio/ring_generic.h                 |   28 +-
 drivers/staging/iio/ring_sw.c                      |   25 +-
 42 files changed, 644 insertions(+), 787 deletions(-)

-- 
1.7.3.4

