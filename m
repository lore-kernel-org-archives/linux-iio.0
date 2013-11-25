Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58559 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616Ab3KYUkT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Nov 2013 15:40:19 -0500
Message-ID: <5293B5B0.1060608@kernel.org>
Date: Mon, 25 Nov 2013 20:40:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 3.13 set 1
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit ed5d6ca0038f274aada1244358ad89b7941bdcbf:

  staging: drm/imx: fix return value check in ipu_add_subdevice_pdata() (2013-10-30 10:17:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/fixes-for-3.13a

for you to fetch changes up to 0ee005c7dc2803125275e24598f0fb37775a6af3:

  iio:accel:kxsd9 fix missing mutex unlock (2013-11-17 15:22:00 +0000)

----------------------------------------------------------------
First round of fixes for IIO in the 3.13 cycle.

The usual mixed bag of fixes.

* 3 cases where kconfig dependencies were missing.  We need to keep a closer
  eye on this in new drivers.

* hid_sensors was abusing the iio_dev->trigger pointer.  We had a round
  of clearing this out some time ago but this driver clearly slipped through.

* A misuse of the IIO_ST macro, in mcp3422, which we should really make a
  concertive effort to finish removing.

* Avoid a double free introduced by recent buffer reference counting in the
  one driver that (quite reasonably!) does things differently (am335x)

* A missing mutex_unlock in kxsd9 that means that driver has been non
  functional for some time and no one noticed (including me who for once
  actually has one of the supported devices).

* An incorrect assumption about the parameters of sign_extend32 in mcp3422.

So nothing controversial.  The only substantial patch is the hid_sensors
one and that is actually just adding a new pointer to the devices private
state then moving the code over to it.

----------------------------------------------------------------
Frank Zago (1):
      iio:accel:kxsd9 fix missing mutex unlock

Lars-Peter Clausen (1):
      iio: adc: ti_am335x_adc: avoid double free of buffer.

Peter Meerwald (5):
      iio: Fix sign extension table in mcp3422 driver
      iio: Fix mag3110 scan_type
      iio: Fix mag3110 Kconfig dependencies
      iio: Fix tcs3472 Kconfig dependencies
      staging:iio: Fix hmc5843 Kconfig dependencies

Srinivas Pandruvada (1):
      iio: hid_Sensors: fix crash during trigger unregister

Wei Yongjun (1):
      iio: at91: fix error return code in at91_adc_probe()

 drivers/iio/accel/hid-sensor-accel-3d.c             | 5 +++--
 drivers/iio/accel/kxsd9.c                           | 7 ++++---
 drivers/iio/adc/at91_adc.c                          | 1 +
 drivers/iio/adc/mcp3422.c                           | 8 ++++----
 drivers/iio/adc/ti_am335x_adc.c                     | 7 +++++--
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 9 ++++-----
 drivers/iio/common/hid-sensors/hid-sensor-trigger.h | 2 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c               | 5 +++--
 drivers/iio/light/Kconfig                           | 2 ++
 drivers/iio/light/hid-sensor-als.c                  | 5 +++--
 drivers/iio/magnetometer/Kconfig                    | 2 ++
 drivers/iio/magnetometer/hid-sensor-magn-3d.c       | 5 +++--
 drivers/iio/magnetometer/mag3110.c                  | 7 ++++++-
 drivers/staging/iio/magnetometer/Kconfig            | 2 ++
 include/linux/hid-sensor-hub.h                      | 3 +++
 15 files changed, 46 insertions(+), 24 deletions(-)
