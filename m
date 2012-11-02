Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45790 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755483Ab2KBKoj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 2 Nov 2012 06:44:39 -0400
Message-ID: <5093A416.1080409@kernel.org>
Date: Fri, 02 Nov 2012 10:44:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for v3.7-rc1 set 2
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 98f9c3c137cea016c57c9fd60b3caf88eb34e4cd:

  iio: Remove duplicates for light/ in Kconfig and Makefile (2012-10-19 19:44:06 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.7b

for you to fetch changes up to 7243b785c43d9aedc7a584dab81bb3f26989d6a1:

  iio: hid-sensor: Use __devexit annotation for remove() (2012-11-02 09:57:57 +0000)

----------------------------------------------------------------
Second round of fixes for IIO in 3.7 cycle, applies to 3.7-rc1.

A mixed bag of fixes mainly for drivers but with one core
double free fix.

* A couple of little fixlets for the hid-sensors drivers.
* Incorrect return value in adt7410
* Fix up support for the adis16334 in the adis16400 driver.
  Turned out there were some bits and bobs that need to be
  handled different for this part.  This seems like a large
  patch series but this is mostly because an additional chip
  specific callback is needed to handle the variations.
* Double free in industrialio-event.c
* Ancient bug in tsl2563 in which the interrupt disable code
  was inverted (i.e. it enable the interrupts)

Jonathan

----------------------------------------------------------------
Axel Lin (2):
      iio: hid-sensor: Return proper error if kmemdup fails
      iio: hid-sensor: Use __devexit annotation for remove()

Derek Basehore (1):
      tsl2563: fixed bug with disabling interrupts

Julia Lawall (1):
      drivers/iio/industrialio-event.c: eliminate possible double free

Kirill A. Shutemov (1):
      iio: hid-sensors: convert HID_SENSOR_ENUM_BASE_QUIRKS to bool

Lars-Peter Clausen (5):
      staging:iio:adt7410: Fix adt7410_set_mode return value
      staging:iio:adis16400: Fix adis16334 sampling frequency control
      staging:iio:adis16400: Fix product id check
      staging:iio:adis16400: Remove now duplicated chip_table entry
      staging:iio:adis16400: Set the PROD_ID flag for the adis16334

 drivers/iio/accel/hid-sensor-accel-3d.c            |  10 +-
 drivers/iio/common/hid-sensors/Kconfig             |   2 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |   6 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |  10 +-
 drivers/iio/industrialio-event.c                   |   7 +-
 drivers/iio/light/hid-sensor-als.c                 |   9 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |  10 +-
 drivers/staging/iio/adc/adt7410.c                  |   2 +-
 drivers/staging/iio/imu/adis16400.h                |  12 +-
 drivers/staging/iio/imu/adis16400_core.c           | 145 ++++++++++++++-------
 drivers/staging/iio/light/tsl2563.c                |   4 +-
 11 files changed, 132 insertions(+), 85 deletions(-)
