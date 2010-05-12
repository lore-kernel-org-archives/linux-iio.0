Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/2] adis16220 driver
Date: Wed, 12 May 2010 21:53:43 +0100
Message-Id: <1273697625-9685-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Another nice clean driver from Barry.  For those who weren't following
the adis16220 capture event thread, this is a somewhat odd device.
Events or a software trigger result in high frequency capture of 1024
elements from the accelerometer and 2 adc channels.

I am far from convinced that the binary read attributes are a good
way to handle this (see the afore mentioned thread for my views).
Others comments on those aspects are most welcome.  For now Barry
as gone with this approach as the easiest way of making this device
driver work and useful.

As ever I've munged the original driver from the blackfin
tree in all sorts of horrible ways (renaming, checkpatch fixes
etc).  This time there was a big change that I think should work
but can't test.  This got rolled into the second patch with
some additional tidying up.

If Barry can sign off on the first and ack the second that would
be great.  All the previous drivers posted here are now in
staging-next.

Anyhow, enjoy ;) I'm guessing this might be the last new driver
before the merge window opens, so probably the last one to go
in to 2.6.35 (if this one doesn't excite comments that might
hold it up).

Barry Song (1):
  staging:iio: adis16220 vibration sensor driver

Jonathan Cameron (1):
  staging:iio: adis16220 extract bin_attribute structures from state

 drivers/staging/iio/accel/Kconfig          |    7 +
 drivers/staging/iio/accel/Makefile         |    3 +
 drivers/staging/iio/accel/accel.h          |    6 +
 drivers/staging/iio/accel/adis16220.h      |  147 ++++++
 drivers/staging/iio/accel/adis16220_core.c |  670 ++++++++++++++++++++++++++++
 5 files changed, 833 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/accel/adis16220.h
 create mode 100644 drivers/staging/iio/accel/adis16220_core.c
