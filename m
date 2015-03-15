Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34754 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbbCOUKO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Mar 2015 16:10:14 -0400
Message-ID: <5505E723.2090205@kernel.org>
Date: Sun, 15 Mar 2015 20:10:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 4.0 set 3
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit abe46b8932dd9a6dfc3698e3eb121809b7b9ed28:

  staging: comedi: adv_pci1710: fix AI INSN_READ for non-zero channel (2015-03-01 19:25:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.0c

for you to fetch changes up to c1b03ab5e886760bdd38c9c7a27af149046ffe01:

  iio: core: Fix double free. (2015-03-14 18:54:14 +0000)

----------------------------------------------------------------
3rd set of IIO fixes for the 4.0 cycle.

* A double free occured on an error path in due to an event registration issue.
  The fix is the minimal change rather than possibly reworking this area of
  the core to give a more elegant solution (future work).
* A number of drivers were directly accessing indio_dev->buffer->scan_mask
  to identify the currently enabled channel set.  This may not be correct
  if we have additional clients on the push interface.  The correct option
  is indio_dev->active_scan_mask. This is fixed.
* bmc150 had incorrectly specified sampling frequency (a datasheet confusion
  as they are specified in terms of bandwith - e.g. half the sampling
  frequency).
* hmc5843 wasn't setting it's name and hence the name attribute was
  returning an empty string.
* inv_mpu6050 wasn't clearing the locally held timestamp buffer when the
  hardware fifo was reset. Also an inconsistency existed in the interface
  for the scale of the channels.  Magic numbers were written but real ones
  were used for the reads.  Now uses real numbers (i.e. not array indexes)
  for both.
* fix a missing dependency in the dummy driver. Previously shielded from
  the autobuilders by an earlier build error.

----------------------------------------------------------------
Adriana Reus (1):
      iio:inv-mpu6050: Fix inconsistency for the scale channel

Daniel Baluta (1):
      staging: iio: dummy: Fix undefined symbol build error

Marek Belisko (1):
      staging: iio: hmc5843: Set iio name property in sysfs

Martin Fuzzey (1):
      iio: core: Fix double free.

Octavian Purdila (1):
      iio: fix drivers that check buffer->scan_mask

Sathyanarayanan Kuppuswamy (1):
      iio: bmc150: change sampling frequency

Viorel Suman (1):
      iio: inv_mpu6050: Clear timestamps fifo while resetting hardware fifo

 drivers/iio/accel/bma180.c                      |  2 +-
 drivers/iio/accel/bmc150-accel.c                | 20 ++++-----
 drivers/iio/accel/kxcjk-1013.c                  |  2 +-
 drivers/iio/adc/at91_adc.c                      |  5 +--
 drivers/iio/adc/ti_am335x_adc.c                 |  3 +-
 drivers/iio/gyro/bmg160.c                       |  2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c      | 56 +++++++++++++------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c      | 25 ++++++-----
 drivers/iio/imu/kmx61.c                         |  2 +-
 drivers/iio/industrialio-core.c                 |  5 ++-
 drivers/iio/industrialio-event.c                |  1 +
 drivers/iio/proximity/sx9500.c                  |  2 +-
 drivers/staging/iio/Kconfig                     |  1 +
 drivers/staging/iio/magnetometer/hmc5843_core.c |  1 +
 14 files changed, 68 insertions(+), 59 deletions(-)
