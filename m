Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42009 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab2KDQXY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Nov 2012 11:23:24 -0500
Message-ID: <50969678.6020700@kernel.org>
Date: Sun, 04 Nov 2012 16:23:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL V2] IIO fixes for v3.7-rc1 set 2 (tiny fixes and regressions
 only)
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 98f9c3c137cea016c57c9fd60b3caf88eb34e4cd:

  iio: Remove duplicates for light/ in Kconfig and Makefile (2012-10-19 19:44:06 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.7b-take2

for you to fetch changes up to 6310e59fb73d94ed702912aa3eb14be38619913d:

  iio: hid-sensor: Use __devexit annotation for remove() (2012-11-04 16:00:56 +0000)

----------------------------------------------------------------
Second round (request 2) of fixes for IIO in 3.7 cycle, applies to 3.7-rc1.

A mixed bag of fixes mainly for drivers but with one core
double free fix.

* A couple of little fixlets for the hid-sensors drivers.
* Incorrect return value in adt7410
* Double free in industrialio-event.c
* Ancient bug in tsl2563 in which the interrupt disable code
  was inverted (i.e. it enable the interrupts)

Fixes for the adsi16400 driver have been postponed and will now be queued
up for the next merge window at Greg's suggestion given their large
size and invasive nature. The relevant code never worked so it
wasn't a regression.

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

Lars-Peter Clausen (1):
      staging:iio:adt7410: Fix adt7410_set_mode return value

 drivers/iio/accel/hid-sensor-accel-3d.c             | 10 +++++-----
 drivers/iio/common/hid-sensors/Kconfig              |  2 +-
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c |  6 ++----
 drivers/iio/gyro/hid-sensor-gyro-3d.c               | 10 +++++-----
 drivers/iio/industrialio-event.c                    |  7 +------
 drivers/iio/light/hid-sensor-als.c                  |  9 ++++-----
 drivers/iio/magnetometer/hid-sensor-magn-3d.c       | 10 +++++-----
 drivers/staging/iio/adc/adt7410.c                   |  2 +-
 drivers/staging/iio/light/tsl2563.c                 |  4 ++--
 9 files changed, 26 insertions(+), 34 deletions(-)
