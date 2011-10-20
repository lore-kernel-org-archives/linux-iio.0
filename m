Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/5] staging:iio: add demux support.
Date: Thu, 20 Oct 2011 17:29:24 +0100
Message-Id: <1319128169-3722-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Given earlier conversation about in kernel interfaces and how the
heck to move towards push interfaces.  I thought I'd take on
one of the small corners.  The ability to take an incoming scan
and only push on some elements to the buffer.

The intent is that we will then reallow multiple buffers
with new in kernel requests for push events creating these.

Then any registered demuxers will be run one after another
pushing the data on to whoever cares about about it.
There will need to be quite a lot of functions to handle
the description (or raw access to some / all of chan_spec).

It's also going to be 'interesting' to get the tear down
rebuild / put up dynamics write on the triggered capture.

Clearly we can also be much cleverer in grouping memcpy's
in the demux_table entries, but that's one for a later date
and my guess is that will work by creating it, then passing
the result and merging elements.

Anyhow this is a step in the right direction.

As a side effect it means that we can now move demuxing into the
core from the few drivers that were either doing it locally
(adis16400 - for burst reads) or not doing it (max1363 as here).

I've only sent this to linux-iio as it only matters there
right now.  I'll send a heads up to the other conversations
that are on going which this touches upon.

Jonathan

Jonathan Cameron (5):
  staging:iio:kfifo remove entirely pointless code.
  staging:iio:fine iio channel from scan index util function
  staging:iio: trigger fixes for repeat request of same trigger and
    allocation failure
  staging:iio: add demux optionally to path from device to buffer
  staging:iio:adc:max1363 use new demuxing support.

 drivers/staging/iio/adc/max1363_core.c     |    4 -
 drivers/staging/iio/adc/max1363_ring.c     |   27 ++-----
 drivers/staging/iio/buffer_generic.h       |   15 ++++
 drivers/staging/iio/iio.h                  |    8 ++
 drivers/staging/iio/industrialio-buffer.c  |  120 +++++++++++++++++++++++++++-
 drivers/staging/iio/industrialio-core.c    |   11 +++
 drivers/staging/iio/industrialio-trigger.c |   12 +++-
 drivers/staging/iio/kfifo_buf.c            |    9 +--
 8 files changed, 168 insertions(+), 38 deletions(-)

-- 
1.7.7
