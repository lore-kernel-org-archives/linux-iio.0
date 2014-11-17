Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23632 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983AbaKQSFI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 17 Nov 2014 13:05:08 -0500
From: Octavian Purdila <octavian.purdila@intel.com>
To: linux-iio@vger.kernel.org
Cc: srinivas.pandruvada@intel.com,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC 0/8] iio: add support for hardware fifo
Date: Mon, 17 Nov 2014 19:55:58 +0200
Message-Id: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi everybody,

I hope this RFC is a good starting point to discuss support for
hardware fifo in IIO. The main reason to support it is to reduce the
power consumtion, by allowing the CPU to enter deep sleep states for
longer periods of time.

Don't get discourage by the large number of patches most of them are
refactors in the bmc150 driver, to make it easier to add support for
the hardware fifo (basically to make adding interrupts and
events/triggers easier).

For discussing the hardware fifo stuff, only the first and last
patches are important: the first adds new IIO attributes so that we
can expose the hardware fifo and the last implements hadware fifo for
IIO (as an example of how would a device use the exposed attributes).

Note that the attributes can be exposed on a per device or per channel
basis, since it seems both types of hardware fifos exists: those that
store all data in a single fifo (temperature, accelerometer,
magnetometer, etc.) and those that have separate fifos for
accelerometer, gyroscope, etc. Thankfully, at the driver level we just
need to use the appropriate sharing level to support one mode or the
other.

Also note that this patch is orthogonal to the software watermark /
batching patch send on the list a while back.

Octavian Purdila (8):
  iio: add support for hardware fifo
  iio: bmc150: refactor slope duration and threshold update
  iio: bmc150: refactor interrupt enabling
  iio: bmc150: exit early if event / trigger state is not changed
  iio: bmc150: introduce bmc150_accel_interrupt
  iio: bmc150: introduce bmc150_accel_trigger
  iio: bmc150: introduce bmc150_accel_event
  iio: bmc150: add support for hardware fifo

 Documentation/ABI/testing/sysfs-bus-iio |  51 ++
 drivers/iio/accel/bmc150-accel.c        | 976 ++++++++++++++++++++++----------
 drivers/iio/industrialio-core.c         |   2 +
 drivers/iio/industrialio-event.c        |   2 +
 include/linux/iio/iio.h                 |  17 +
 include/linux/iio/types.h               |   2 +
 6 files changed, 739 insertions(+), 311 deletions(-)

-- 
1.9.1

