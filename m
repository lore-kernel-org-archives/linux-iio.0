Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/5] staging:IIO: kfifo based fifo implementation.
Date: Fri, 11 Feb 2011 13:09:08 +0000
Message-Id: <1297429753-6606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi Greg,

This patch set has been on linux-iio for a couple of months.

The intent in IIO was always to provide a number of buffer implementations
so that one could select the one that provides the features needed
for a particular application.  Sadly far too many drivers have
become attached to ring_sw which is to put it lightly, somewhat
dubious (seems to work but I wouldn't guarantee that and I wrote
it).  Anyhow, kfifo isn't ideal for every application, but it
makes a good starting point and opens up the possiblity of
other implementations.

What is a sensible default for a given driver is down to the
indvidual driver writers.

The first patch is a spot of restructuring needed to push down
some code into the sw_ring that should never have been in the core
(oops).

The lis3l02dq driver has been used as an example of the changes
need in drivers to add support for additional buffer implementations.

Final two patches are extensions of the example code. The first just
allows for event less buffers (such as this one) and the second adds
more arguements to make the whole example a bit more useful.

The changes since V1 are all pretty trivial:

* Additional help in Kconfig to illustrate when one might want to use kfifo.
* Logic fix for lis3l02dq Kconfig to ensure an empty buffer menu doesn't
  appear when buffers are completely disabled.
* Fix sparse warnings.

Please consider merging.

Some cleanup to the core will occur in a futures set (for example
stopping creation of an event chrdev for buffers that can't produce
any events).

Thanks,

Jonathan

V1 description:

This set is an update of the proof of concept I wrote a while back.
This time around I've simply used a byte stream buffer rather than
variable record sizes.  The first patch pushes some of the
exiting buffer code down into the ring_sw implementation to
make it simpler to provide other implementations.

What you gain by picking kfifo:
* Clean fast code for the underlying buffer.

What you loose:
* Events - userspace has to 'know' how often to read the buffer
  so as to not loose data.

Obvious difference is it is a fifo rather than a ring buffer.

This buffer should also lend itself to a simple implementation
of a store_n function which should be useful for devices with
a hardware ring which we then want to feed into a software one.


Jonathan Cameron (5):
  staging:iio:buffering move the copy to user on rip down into
    implementations
  staging:iio:kfifo buffer implementation
  staging:iio:lis3l02dq allow buffer implementation selection
  staging:iio: update example to handle case with no ring events
  staging:iio: buffer example - add lots more runtime parameters

 drivers/staging/iio/Documentation/generic_buffer.c |   63 +++++--
 drivers/staging/iio/Kconfig                        |    9 +
 drivers/staging/iio/Makefile                       |    1 +
 drivers/staging/iio/accel/Kconfig                  |   23 +++-
 drivers/staging/iio/accel/lis3l02dq.h              |   10 +
 drivers/staging/iio/accel/lis3l02dq_ring.c         |    9 +-
 drivers/staging/iio/industrialio-ring.c            |   25 +---
 drivers/staging/iio/kfifo_buf.c                    |  196 ++++++++++++++++++++
 drivers/staging/iio/kfifo_buf.h                    |   56 ++++++
 drivers/staging/iio/ring_generic.h                 |    2 +-
 drivers/staging/iio/ring_sw.c                      |   27 ++-
 drivers/staging/iio/ring_sw.h                      |    4 +-
 12 files changed, 366 insertions(+), 59 deletions(-)
 create mode 100644 drivers/staging/iio/kfifo_buf.c
 create mode 100644 drivers/staging/iio/kfifo_buf.h

-- 
1.7.3.4
