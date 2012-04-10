Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:53628 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757339Ab2DJUi2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Apr 2012 16:38:28 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org, greg@kroah.com,
	dmitry.torokhov@gmail.com, broonie@opensource.wolfsonmicro.com,
	alan@lxorguk.ukuu.org.uk, arnd@arndb.de, linus.walleij@linaro.org,
	maxime.ripard@free-electrons.com,
	thomas.petazzoni@free-electrons.com, zdevai@gmail.com,
	w.sang@pengutronix.de, marek.vasut@gmail.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [RFC PATCH 0/4 V2] Add push based interface for non userspace iio users
Date: Tue, 10 Apr 2012 21:38:10 +0100
Message-Id: <1334090294-23407-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes since V1

Fixups as per Dmitry's email.
New element for the mapping to allow us to pass consumer related channel
specific data to the consumer driver.  Here it's the fuzz etc bits for
input.

The input driver needs more testing, but I wanted this version out in
the hope that I would get some feedback on just how many drivers are
broken by the first patch!

That and I foolishly promissed an update earlier.  Might be dependent
on something in the various trees I sent out earlier. I've been lazy
and not checked but I have it after them locally.

Jonathan

previous version text:
This set is large and relatively invasive.  The first important thing
to verify is that the first patch doesn't break any of the existing
drivers.

Taking the patches in turn.  Firstly this currenty should only effect
devices with software buffers so when I say buffers that is what I mean
in this description.

1) Re route all pushing to software buffers via iio_push_to_buffers.
   We also need to modify drivers to make them aware of the fact that
   they may well be pushing to multiple buffers.  Where possible I
   have done this by making use of iio_sw_buffer_preenable and adding
   pre demux scan element size computation to the core (as this was
   repeated quite a few times in drivers).  Basically I've almost
   certainly broken someone's driver so please test this one!

2) Now all drivers (that support buffers at all) should handle multiple
   buffers we add a trivial call back buffer implementation. This simply
   calls a callback function with new scans of data as and when they
   are available.

3) A very rough and ready proof of concept for an input driver that
   uses iio in a similar way to the hwmon driver that merged a few
   days back. Clearly this needs more work!

One little question this 3rd patch raises is how we get board specific
details about channels into an iio consumer device.  Here I thinking
things like 'fuzz' values for input.

To that end what do people think of adding a void *consumer_data
pointer to the struct iio_chan_map structure?

Other than that it's worth noting that this interface uses
exactly the same interface from the point of view of board files
as the pull interface does. (Hopefully avoiding what proved the most
controversial bit last time!).

One other practical issue post this patch set is that we can currently
only have either polled or interrupt driven clients of iio devices
but not both.  I have some thoughts on how to deal with this as it
is obviously import to some SoC adc users.

Another future project will be making a cleaner break between those
buffering elements to do with the IIO direct userspace interface
and those used by other consumer drivers.  If it looks like we
bolted on the in kernel users side of things that is because we
did!

Jonathan

Jonathan Cameron (4):
  staging:iio: make all buffer access pass through the buffer_list
  staging:iio: add a callback buffer for in kernel push interface
  staging:iio:in kernel users: Add a data field for channel specific
    info.
  staging:iio: Proof of concept input driver.

 drivers/staging/iio/Kconfig                     |   18 +
 drivers/staging/iio/Makefile                    |    2 +
 drivers/staging/iio/accel/adis16201_ring.c      |    9 +-
 drivers/staging/iio/accel/adis16203_ring.c      |   11 +-
 drivers/staging/iio/accel/adis16204_ring.c      |    8 +-
 drivers/staging/iio/accel/adis16209_ring.c      |    9 +-
 drivers/staging/iio/accel/adis16240_ring.c      |    9 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c      |    9 +-
 drivers/staging/iio/adc/ad7192.c                |   27 +-
 drivers/staging/iio/adc/ad7298.h                |    1 -
 drivers/staging/iio/adc/ad7298_ring.c           |   31 +-
 drivers/staging/iio/adc/ad7476.h                |    1 -
 drivers/staging/iio/adc/ad7476_ring.c           |   40 +-
 drivers/staging/iio/adc/ad7606_ring.c           |   11 +-
 drivers/staging/iio/adc/ad7793.c                |   26 +-
 drivers/staging/iio/adc/ad7887.h                |    1 -
 drivers/staging/iio/adc/ad7887_ring.c           |   28 +-
 drivers/staging/iio/adc/ad799x.h                |    1 -
 drivers/staging/iio/adc/ad799x_ring.c           |   27 +-
 drivers/staging/iio/adc/max1363_ring.c          |    6 +-
 drivers/staging/iio/buffer.h                    |   24 +-
 drivers/staging/iio/buffer_cb.c                 |  115 +++++
 drivers/staging/iio/consumer.h                  |   48 ++
 drivers/staging/iio/gyro/adis16260_ring.c       |    8 +-
 drivers/staging/iio/iio.h                       |    8 +
 drivers/staging/iio/iio_input.c                 |  176 ++++++++
 drivers/staging/iio/iio_input.h                 |   23 +
 drivers/staging/iio/iio_simple_dummy_buffer.c   |   16 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c |   14 +-
 drivers/staging/iio/imu/adis16400_ring.c        |    6 +-
 drivers/staging/iio/industrialio-buffer.c       |  553 ++++++++++++++---------
 drivers/staging/iio/industrialio-core.c         |    1 +
 drivers/staging/iio/inkern.c                    |    1 +
 drivers/staging/iio/machine.h                   |    2 +
 drivers/staging/iio/meter/ade7758_ring.c        |   25 +-
 35 files changed, 840 insertions(+), 455 deletions(-)
 create mode 100644 drivers/staging/iio/buffer_cb.c
 create mode 100644 drivers/staging/iio/iio_input.c
 create mode 100644 drivers/staging/iio/iio_input.h

-- 
1.7.9.4

