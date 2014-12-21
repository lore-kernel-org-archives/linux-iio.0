Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:1097 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752368AbaLUAnT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 20 Dec 2014 19:43:19 -0500
From: Octavian Purdila <octavian.purdila@intel.com>
To: linux-iio@vger.kernel.org
Cc: Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH v2 00/11] iio: add support for hardware buffers
Date: Sun, 21 Dec 2014 02:42:25 +0200
Message-Id: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This 2nd patch set brings a new approach to hadware buffers, as a
result of the feedback from the first patch set. It also fixes a few
issues in the bmc150 refactor patches found during the review.

It builds on the patch of Josselin and Yannick but with the timeout
parameter removed, as the poll timeout can be used instead (for
non-blocking reads).

In order to provide support for hardware buffers a driver must expose
a watermark trigger, a function to set the watermark level in hadware
and a function to flush the hardware buffers. It must also expose the
maximum number of samples that the hardware buffer can hold. When the
watermark trigger is set the driver must make sure that the hardware
buffer is operational so that we can hold samples until the watermark
level is reached. When the watermark level is reached (the watermark
triggered is activated) and when the flush operation is called, the
driver must read all of the entries from the hardware buffers and
store then in the device buffer.

>From the userspace point of view, to enable hardware buffers, the
application must set the device buffer and the watermark level to an
appropriate value then switch to using the watermark trigger. At that
point the data will be hold in the hadware buffer and the processor
will not be interrupted until the hadware buffer level reaches the
watermark level. 

The application can force a flush operation when reading from the
device and there is not enough data available to satisfy the
request. This allows the application to balance power-consumption and
latency by setting a poll timeout and forcing a non-blocking read when
the poll timeout expires which allows the application to retrieve any
samples stored in the hardware buffer.


Josselin Costanzi (1):
  iio: add watermark logic to iio read and poll

Octavian Purdila (10):
  iio: buffer: fix custom buffer attributes copy
  iio: buffer: refactor buffer attributes setup
  iio: add support for hardware fifo
  iio: bmc150: refactor slope duration and threshold update
  iio: bmc150: refactor interrupt enabling
  iio: bmc150: exit early if event / trigger state is not changed
  iio: bmc150: introduce bmc150_accel_interrupt
  iio: bmc150: introduce bmc150_accel_trigger
  iio: bmc150: introduce bmc150_accel_event
  iio: bmc150: add support for hardware fifo

 Documentation/ABI/testing/sysfs-bus-iio  |  32 ++
 drivers/iio/accel/bmc150-accel.c         | 919 ++++++++++++++++++++-----------
 drivers/iio/industrialio-buffer.c        | 179 ++++--
 drivers/iio/kfifo_buf.c                  |  11 +-
 drivers/staging/iio/accel/sca3000_ring.c |   4 +-
 include/linux/iio/buffer.h               |   9 +-
 include/linux/iio/iio.h                  |  17 +
 7 files changed, 819 insertions(+), 352 deletions(-)

-- 
1.9.1

