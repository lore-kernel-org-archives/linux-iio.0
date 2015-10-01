Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.les.jabatus.fr ([109.234.163.36]:52886 "EHLO
	mail.les.jabatus.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891AbbJAONy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 1 Oct 2015 10:13:54 -0400
From: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	William.Markezana@meas-spec.com
Cc: ludovic.tancerel@maplehightech.com
Subject: [PATCH v4 0/7] iio: TSYS01, TSYS02D, HTU21, MS5637, MS8607, Measurement Specialties driver developments
Date: Thu,  1 Oct 2015 16:13:35 +0200
Message-Id: <1443708822-8580-1-git-send-email-ludovic.tancerel@maplehightech.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is the resubmission of patches for measurement specialties drivers.
	- TSYS01 : Temperature sensor
	- TSYS02D : Temperature sensor
	- HTU21 : Temperature & Humidity sensor
	- MS5637 : Temperature & Pressure sensor
	- MS8607 : Temperature, Pressure & Humidity sensor

The list of changes relative to previous patchset are :
	- Clean-up function names in common driver part.
	  Update all drivers accordingly
	- Comment serial number reading
	- Kernel documentation and other minor changes
	- Rename compatible for ms8607
	- Split last patch into 2 for typo correction into MS5611

Thanks a lot for your feedback.

Regards,
Ludovic

revision history
----------------
v4	Clean-up namings. One new patch split for MS5611 typo correction
v3	Minor corrections. Remove ms8607 Kconfig
v2	Split ms8607/Align units/Document private ABI/ kernel-doc ABI
v1	initial post

Ludovic Tancerel (7):
  Add meas-spec sensors common part
  Add tsys01 meas-spec driver support
  Add tsys02d meas-spec driver support
  Add htu21 meas-spec driver support
  Add ms5637 meas-spec driver support
  Add ms8607 meas-spec driver support
  Typo correction in ms5611 Kconfig

 Documentation/ABI/testing/sysfs-bus-iio           |  10 +
 Documentation/ABI/testing/sysfs-bus-iio-meas-spec |   8 +
 drivers/iio/common/Kconfig                        |   1 +
 drivers/iio/common/Makefile                       |   1 +
 drivers/iio/common/ms_sensors/Kconfig             |   6 +
 drivers/iio/common/ms_sensors/Makefile            |   5 +
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c    | 651 ++++++++++++++++++++++
 drivers/iio/common/ms_sensors/ms_sensors_i2c.h    |  66 +++
 drivers/iio/humidity/Kconfig                      |  13 +
 drivers/iio/humidity/Makefile                     |   1 +
 drivers/iio/humidity/htu21.c                      | 253 +++++++++
 drivers/iio/pressure/Kconfig                      |  17 +-
 drivers/iio/pressure/Makefile                     |   1 +
 drivers/iio/pressure/ms5637.c                     | 190 +++++++
 drivers/iio/temperature/Kconfig                   |  22 +
 drivers/iio/temperature/Makefile                  |   2 +
 drivers/iio/temperature/tsys01.c                  | 230 ++++++++
 drivers/iio/temperature/tsys02d.c                 | 191 +++++++
 18 files changed, 1666 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-meas-spec
 create mode 100644 drivers/iio/common/ms_sensors/Kconfig
 create mode 100644 drivers/iio/common/ms_sensors/Makefile
 create mode 100644 drivers/iio/common/ms_sensors/ms_sensors_i2c.c
 create mode 100644 drivers/iio/common/ms_sensors/ms_sensors_i2c.h
 create mode 100644 drivers/iio/humidity/htu21.c
 create mode 100644 drivers/iio/pressure/ms5637.c
 create mode 100644 drivers/iio/temperature/tsys01.c
 create mode 100644 drivers/iio/temperature/tsys02d.c

-- 
2.3.7

