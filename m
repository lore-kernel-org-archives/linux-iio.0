Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58868 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756047Ab3AFSMN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 6 Jan 2013 13:12:13 -0500
Message-ID: <50E9BE7A.90505@kernel.org>
Date: Sun, 06 Jan 2013 18:12:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO cleanups, new drivers and fixes (IIO set 1 for the 3.9
 cycle)
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:

  Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.9a

for you to fetch changes up to e07c6d170ccec9e7377a43a2999b87b860c642e9:

  hid: iio: rename struct hid_sensor_iio_common to hid_sensor_common (2013-01-06 11:48:11 +0000)

----------------------------------------------------------------
First round of IIO new stuff and cleanups for 3.9

Here we have:
* RTC driver for the hid-sensor hubs.  This is routed through here with
  agreement of Jiri Kosina and Andrew Morton.
* Some small patches doing dead code removal and fixing some comments.
* max1363 - move to the triggered_buffer helpers (basically duplicate code
  removal).
* lp8788 - parent device change from the i2c device to the intermediate mfd.

So the bulk of what we have is actually outside the IIO tree but the RTC
driver in question is dependent on some patches that directly effect IIO so
I am routing it through IIO with the agreement of the relevant maintainers
(Andrew is acting as maintainer of RTC at the moment).  The majority of
HID-sensor related code is in IIO and it now crosses 3 subsystems so it
was going to be a bit awkward whatever route it took.

----------------------------------------------------------------
Alexander Holler (4):
      iio: Add Usage IDs for HID time sensors.
      iio: merge hid-sensor-attributes.h into hid-sensor-hub.h
      rtc: add rtc-driver for HID sensors of type time
      hid: iio: rename struct hid_sensor_iio_common to hid_sensor_common

Alexander Stein (1):
      iio: Fix some comments

Kim, Milo (2):
      iio: lp8788_adc: fix a parent device in _probe()
      iio: lp8788_adc: fix parent device in kernel message

Marek Vasut (1):
      iio: mxs: Remove unused struct mxs_lradc_chan

Peter Meerwald (2):
      iio: cleanup buffer setup code in max1363 driver
      iio: max1363 comment and whitespace fixes

 drivers/iio/accel/hid-sensor-accel-3d.c            |   3 +-
 drivers/iio/adc/lp8788_adc.c                       |   6 +-
 drivers/iio/adc/max1363.c                          |  74 +-----
 .../iio/common/hid-sensors/hid-sensor-attributes.c |  11 +-
 .../iio/common/hid-sensors/hid-sensor-attributes.h |  57 ----
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |   5 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.h    |   2 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |   3 +-
 drivers/iio/light/hid-sensor-als.c                 |   3 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |   3 +-
 drivers/rtc/Kconfig                                |  16 ++
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-hid-sensor-time.c                  | 291 +++++++++++++++++++++
 drivers/staging/iio/adc/mxs-lradc.c                |   7 -
 drivers/staging/iio/iio_simple_dummy.c             |   4 +-
 drivers/staging/iio/iio_simple_dummy_buffer.c      |   2 +-
 include/linux/hid-sensor-hub.h                     |  38 +++
 include/linux/hid-sensor-ids.h                     |   9 +
 18 files changed, 385 insertions(+), 150 deletions(-)
 delete mode 100644 drivers/iio/common/hid-sensors/hid-sensor-attributes.h
 create mode 100644 drivers/rtc/rtc-hid-sensor-time.c
