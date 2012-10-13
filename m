Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/7] iio:adc:max1363 cleanup and graduation from staging
Date: Sat, 13 Oct 2012 10:34:44 +0100
Message-Id: <1350120891-28593-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Dependent on the multiple buffers series just posted.
(only for fuzz though afaik)

I have been a little slack in moving my own drivers out of staging.
As ever it's do what I say, not what I do ;)

Anyhow, the big bits here are moving max1363 over kfifo from sw_ring
(I've been running this locally for at least 6 months).
Given that it has been impossible to build this driver without buffered
support for a long time and I have little motivation to make the work
again, I've assumed it will never happened and hence consolidated the
driver into a single file.

The other patches are straight forward tidying up and moving to cleaner
approaches taken in newer drivers + getting rid of some bit rot that
had occured by making minimal changes in the driver during core abi
changes.  This one has been with us from the start so it's hardly suprising
that a few corners had gotten messy.

Finally it moves the driver out of staging.

If anyone has time to take a look at these it would be a great help.

Jonathan

Jonathan Cameron (7):
  staging:iio:adc:max1363 ring_sw->kfifo conversion
  staging:iio:adc:max1363 consolidate files.
  staging:iio:adc:max1363 drop references to 'ring' given now using a
    fifo
  staging:iio:adc:max1363 make docs match the contents of
    max1363_chip_info
  staging:iio:adc:max1363 white space cleanup
  staging:iio:adc:max1363 cleanup regulator handling.
  iio:adc:max1363 move from staging.

 drivers/iio/adc/Kconfig                |   18 +
 drivers/iio/adc/Makefile               |    1 +
 drivers/iio/adc/max1363.c              | 1700 ++++++++++++++++++++++++++++++++
 drivers/staging/iio/adc/Kconfig        |   24 -
 drivers/staging/iio/adc/Makefile       |    5 -
 drivers/staging/iio/adc/max1363.h      |  177 ----
 drivers/staging/iio/adc/max1363_core.c | 1444 ---------------------------
 drivers/staging/iio/adc/max1363_ring.c |  139 ---
 8 files changed, 1719 insertions(+), 1789 deletions(-)
 create mode 100644 drivers/iio/adc/max1363.c
 delete mode 100644 drivers/staging/iio/adc/max1363.h
 delete mode 100644 drivers/staging/iio/adc/max1363_core.c
 delete mode 100644 drivers/staging/iio/adc/max1363_ring.c

-- 
1.7.12.2
