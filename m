Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.assembling.jabatus.fr ([109.234.163.60]:47466 "EHLO
	mail.assembling.jabatus.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932302AbbIYN5G (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Sep 2015 09:57:06 -0400
From: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	ludovic.tancerel@maplehightech.com, William.Markezana@meas-spec.com
Subject: [PATCH v3 0/6] iio: TSYS01, TSYS02D, HTU21, MS5637, MS8607, Measurement Specialties driver developments
Date: Fri, 25 Sep 2015 15:56:39 +0200
Message-Id: <1443189405-18516-1-git-send-email-ludovic.tancerel@maplehightech.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is the resubmission of patches for measurement specialties drivers.
	- TSYS01 : Temperature sensor
	- TSYS02D : Temperature sensor
	- HTU21 : Temperature & Humidity sensor
	- MS5637 : Temperature & Pressure sensor
	- MS8607 : Temperature, Pressure & Humidity sensor

The list of changes are :
	- Remove ms8607 from Kconfig and document ms5637 and htu21 accordingly
	- Move heater_enable in sysfs-bus-iio
	- Minor corrections
	- Modify patchset presentation

Thanks a lot for your feedback.

Regards,
Ludovic

revision history
----------------
v3      Minor corrections. Remove ms8607 Kconfig
v2      Split ms8607/Align units/Document private ABI/ kernel-doc ABI
v1      initial post

Ludovic Tancerel (6):
  Add meas-spec sensors common part
  Add tsys01 meas-spec driver support
  Add tsys02d meas-spec driver support
  Add htu21 meas-spec driver support
  Add ms5637 meas-spec driver support
  Add ms8607 meas-spec driver support

 Documentation/ABI/testing/sysfs-bus-iio           |  10 +
 Documentation/ABI/testing/sysfs-bus-iio-meas-spec |   8 +
 drivers/iio/common/Kconfig                        |   1 +
 drivers/iio/common/Makefile                       |   1 +
 drivers/iio/common/ms_sensors/Kconfig             |   6 +
 drivers/iio/common/ms_sensors/Makefile            |   5 +
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c    | 645 ++++++++++++++++++++++
 drivers/iio/common/ms_sensors/ms_sensors_i2c.h    |  53 ++
 drivers/iio/humidity/Kconfig                      |  13 +
 drivers/iio/humidity/Makefile                     |   1 +
 drivers/iio/humidity/htu21.c                      | 254 +++++++++
 drivers/iio/pressure/Kconfig                      |  17 +-
 drivers/iio/pressure/Makefile                     |   1 +
 drivers/iio/pressure/ms5637.c                     | 191 +++++++
 drivers/iio/temperature/Kconfig                   |  22 +
 drivers/iio/temperature/Makefile                  |   2 +
 drivers/iio/temperature/tsys01.c                  | 231 ++++++++
 drivers/iio/temperature/tsys02d.c                 | 192 +++++++
 18 files changed, 1651 insertions(+), 2 deletions(-)
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

