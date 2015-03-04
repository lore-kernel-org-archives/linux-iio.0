Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28567 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933133AbbCDR4R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 4 Mar 2015 12:56:17 -0500
From: Octavian Purdila <octavian.purdila@intel.com>
To: linux-iio@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH v5 0/3] iio: add support for hardware fifos
Date: Wed,  4 Mar 2015 19:56:10 +0200
Message-Id: <1425491773-28499-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Sorry for spawning a new patch set so quickly, but based on the
comments from Lars I rewrote the read watermark logic and the patches
are now hopefully easier to review than the previous patch set.

Changes since v4:

 * rewrite the watermark read logic to fix an undeflow issue and allow
   draining when the buffer is disabled

 * manipulate the watermark field under the device lock

 * use wake_up_interruptible_poll

 * bmc150: flush the fifo before disabling the buffer and take the
   device mutex when emabling/disabling the fifo


Changes since v3:

* remove hwfifo_length and make hwfifo_watermark read-only

* remove trigger for hardware fifo

* use the buffer watermark as a hint for the hardware fifo

* hwfifo_watermark is negative if the device does not support hardware
  fifo, 0 if hardware fifo is supported but currently disabled and a
  strictly positive value if hardware fifo is enabled in which case
  this is the watermark for the hardware fifo

* the hardware fifo is activated by the device driver when it makes
  sense (e.g. at buffer enable time if there is no conflicting
  trigger)

* move the hwfifo operations to struct iio_info

* remove the flush from the poll operation - it causes unnecessary
  flush operations

* move the wait condition logic in a separate function to make it more
  readable

* bmc150: make sure to check the I2C bus supports either full i2c or
  at least SMBUS i2c block read as fifo reads must do a burst read of
  the whole frame (all 3 axis)

* bmc150: rework the way we timestamp the samples stored in the fifo
  to account for sampling frequency variations from device to device



Josselin Costanzi (1):
  iio: add watermark logic to iio read and poll

Octavian Purdila (2):
  iio: add support for hardware fifo
  iio: bmc150_accel: add support for hardware fifo

 Documentation/ABI/testing/sysfs-bus-iio  |  40 ++++
 drivers/iio/accel/bmc150-accel.c         | 363 +++++++++++++++++++++++++++++--
 drivers/iio/industrialio-buffer.c        | 177 +++++++++++++--
 drivers/iio/kfifo_buf.c                  |  11 +-
 drivers/staging/iio/accel/sca3000_ring.c |   4 +-
 include/linux/iio/buffer.h               |   8 +-
 include/linux/iio/iio.h                  |  26 +++
 7 files changed, 581 insertions(+), 48 deletions(-)

-- 
1.9.1

