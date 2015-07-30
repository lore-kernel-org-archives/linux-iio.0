Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mano-163-71-shared.jabatus.fr ([109.234.163.71]:41606 "EHLO
	mano-163-71-shared.jabatus.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754753AbbG3KAD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jul 2015 06:00:03 -0400
From: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	ludovic.tancerel@maplehightech.com, William.Markezana@meas-spec.com
Subject: [PATCH V2 0/6] iio: TSYS01, TSYS02D, HTU21, MS5637, MS8607 Measurement Specialties driver development
Date: Thu, 30 Jul 2015 11:25:39 +0200
Message-Id: <1438248345-25820-1-git-send-email-ludovic.tancerel@maplehightech.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is the resubmission of patches for measurement specialties drivers.
The format of patchset has been moved into several incremental patches as requested, plus the other feedback.
The list of changes are :
        - Split into multiple patches
        - the split of MS8607 into 2 drivers based on htu21 ans ms5637
        - Alignment of units for processed channels
        - Documentation of private ABI
        - kernel-doc for exported functions
        - Other minor changes from feedback

Please have a look,
and thanks a lot for your feedback.

Regards,
Ludovic

revision history
----------------
v2      Split ms8607/Align units/Document private ABI/ kernel-doc ABI
v1      initial post

Ludovic Tancerel (6):
  Add iio: meas-spec sensors common part
  Add iio: tsys01 meas-spec driver support
  Add iio: tsys02d meas-spec driver support
  Add iio: htu21 meas-spec driver support
  Add iio: ms5637 meas-spec driver support
  Add iio: ms8607 meas-spec driver support

 Documentation/ABI/testing/sysfs-bus-iio-meas-spec |  15 +
 drivers/iio/common/Kconfig                        |   1 +
 drivers/iio/common/Makefile                       |   1 +
 drivers/iio/common/ms_sensors/Kconfig             |   6 +
 drivers/iio/common/ms_sensors/Makefile            |   5 +
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c    | 634 ++++++++++++++++++++++
 drivers/iio/common/ms_sensors/ms_sensors_i2c.h    |  54 ++
 drivers/iio/humidity/Kconfig                      |  11 +
 drivers/iio/humidity/Makefile                     |   1 +
 drivers/iio/humidity/htu21.c                      | 254 +++++++++
 drivers/iio/pressure/Kconfig                      |  28 +-
 drivers/iio/pressure/Makefile                     |   1 +
 drivers/iio/pressure/ms5637.c                     | 192 +++++++
 drivers/iio/temperature/Kconfig                   |  22 +
 drivers/iio/temperature/Makefile                  |   2 +
 drivers/iio/temperature/tsys01.c                  | 232 ++++++++
 drivers/iio/temperature/tsys02d.c                 | 193 +++++++
 17 files changed, 1650 insertions(+), 2 deletions(-)
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

