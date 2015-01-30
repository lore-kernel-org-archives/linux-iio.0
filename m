Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:60030 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750903AbbAaAA1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 30 Jan 2015 19:00:27 -0500
From: Octavian Purdila <octavian.purdila@intel.com>
To: linux-iio@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH v3 0/9] iio: add support for hardware fifo
Date: Sat, 31 Jan 2015 01:59:59 +0200
Message-Id: <1422662408-8149-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Here is the 3rd version of the patch that adds support for hardware
buffering.

I though a bit more about the watermark trigger approach and I still
think it is the right approach because:

 * it allows the application to enable or disable the FIFO

 * it avoids potential race conditions during configuration of the FIFO

 * an interrupt usually maps with a trigger, and since the FIFO
   watermark generates an interrupt it is natural to have a trigger for it

 * it matches well with the current trigger design, where only one
   trigger/interrupt can be active for one device

 * data is written to the FIFO based on the sampling rate and not
   based on a specific trigger; for example, it is at best confusing
   to have the any-motion trigger active while the FIFO is active

After the discussion with Jonathan I have decided to add a
hwfifo_watermark parameter to allow the application to change both the
device buffer watermark and the hardware fifo watermark as we want to
avoid dictating policy from kernel. I also think that it is important
for debugging and for allowing the application to use the right
settings depending on its goal (latency, power, etc.).

Other small changes since v2:

 * add a parameter to flush for the maximum number of samples to flush

 * fix a few comments

 * use indio_dev->active_scan_mask instead of buffer->scan_mask in the
   flush function

 * constify bmc150_accel_interrupts

 * use an anonymouse struct instead of struct
   bmc150_accel_interrupt_info and move it together with the
   initialization code

 * rewrote the slope code refactoring so that we update the registers
   when we enable the trigger

 * fix a potential division by zero spotted by Harmut

 * dropped the bmc150_accel_event patch


Josselin Costanzi (1):
  iio: add watermark logic to iio read and poll

Octavian Purdila (8):
  iio: buffer: refactor buffer attributes setup
  iio: add support for hardware fifo
  iio: bmc150: refactor slope duration and threshold update
  iio: bmc150: refactor interrupt enabling
  iio: bmc150: exit early if event / trigger state is not changed
  iio: bmc150: introduce bmc150_accel_interrupt
  iio: bmc150: introduce bmc150_accel_trigger
  iio: bmc150: add support for hardware fifo

 Documentation/ABI/testing/sysfs-bus-iio  |  40 ++
 drivers/iio/accel/bmc150-accel.c         | 752 +++++++++++++++++++------------
 drivers/iio/industrialio-buffer.c        | 225 +++++++--
 drivers/iio/kfifo_buf.c                  |  11 +-
 drivers/staging/iio/accel/sca3000_ring.c |   4 +-
 include/linux/iio/buffer.h               |   8 +-
 include/linux/iio/iio.h                  |  18 +
 7 files changed, 735 insertions(+), 323 deletions(-)

-- 
1.9.1

