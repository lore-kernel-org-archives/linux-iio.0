Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:59442 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932451Ab0LSUdw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Dec 2010 15:33:52 -0500
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Michael.Hennerich@analog.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [RFC PATCH 0/5] Add kfifo based buffer implementation
Date: Sun, 19 Dec 2010 20:33:40 +0000
Message-Id: <1292790825-19156-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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
  staging:iio:buffering  move the copy to user on rip down into
    implementations
  staging:iio:kfifo buffer implementation
  staging:iio:lis3l02dq allow buffer implementation selection
  staging:iio: update example to handle case with no ring events
  staging:iio: buffer example - add lots more runtime parameters

 drivers/staging/iio/Documentation/generic_buffer.c |   63 +++++--
 drivers/staging/iio/Kconfig                        |    6 +
 drivers/staging/iio/Makefile                       |    1 +
 drivers/staging/iio/accel/Kconfig                  |   23 +++-
 drivers/staging/iio/accel/lis3l02dq.h              |   10 +
 drivers/staging/iio/accel/lis3l02dq_ring.c         |    9 +-
 drivers/staging/iio/industrialio-ring.c            |   23 +--
 drivers/staging/iio/kfifo_buf.c                    |  196 ++++++++++++++++++++
 drivers/staging/iio/kfifo_buf.h                    |   56 ++++++
 drivers/staging/iio/ring_generic.h                 |    2 +-
 drivers/staging/iio/ring_sw.c                      |   29 ++-
 drivers/staging/iio/ring_sw.h                      |    4 +-
 12 files changed, 363 insertions(+), 59 deletions(-)
 create mode 100644 drivers/staging/iio/kfifo_buf.c
 create mode 100644 drivers/staging/iio/kfifo_buf.h

