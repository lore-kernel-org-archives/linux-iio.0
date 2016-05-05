Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43372 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755496AbcEETkQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 5 May 2016 15:40:16 -0400
To: Greg KH <gregkh@linuxfoundation.org>
Subject: [PULL] IIO fixes for 4.6d (inv mpu6050 acpi regression)
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9a501e31-9b99-0c88-8bff-9590fdd1b107@kernel.org>
Date: Thu, 5 May 2016 20:40:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 431adc0aeca68d257bd705db50f73e4c19e5690d:

  Merge tag 'iio-fixes-for-4.6c' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2016-04-26 14:58:46 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.6d

for you to fetch changes up to 393dbe4e18dd5b17b3952c7d36ac88f61ec40924:

  iio: imu: mpu6050: Fix name/chip_id when using ACPI (2016-05-04 08:44:27 +0100)

----------------------------------------------------------------
Fourth set of IIO fixes for the 4.6 cycle.

This last minute set is concerned with a regression in the mpu6050 driver.
The regression causes a null pointer dereference on any ACPI device
that has one of these present such as the ASUS T100TA Baytrail/T.

The issue was known but thought (i.e. missunderstood by me)
to only be a possible with no reports, so was routed via the normal merge
window.  Turns out this was wrong (thanks to Alan for reporting the crash).

The pull is just for the null dereference fix and a followup fix
that also stops the reported name of the device being NULL.

* mpu6050
  - Fix a 'possible' NULL dereference introduced as part of splitting the
  driver to allow both i2c and spi to be supported.  The issue affects ACPI
  systems with this device.
  - Fix a follow up issue where the name and chip id both get set to null if
  the device driver instance is instantiated from ACPI tables.

----------------------------------------------------------------
Daniel Baluta (1):
      iio: imu: mpu6050: Fix name/chip_id when using ACPI

Matt Ranostay (1):
      iio: imu: mpu6050: fix possible NULL dereferences

 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 30 +++++++++++++++++++++++++++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c |  3 ++-
 2 files changed, 29 insertions(+), 4 deletions(-)
