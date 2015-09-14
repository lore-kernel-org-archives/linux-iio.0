Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35585 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868AbbIND0I (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 13 Sep 2015 23:26:08 -0400
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v5 0/4] iio: new chemical sensor framework and channel types
Date: Sun, 13 Sep 2015 20:26:10 -0700
Message-Id: <1442201174-10975-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from v4:
* Add IIO_MOD_CO2 and IIO_MOD_VOC modifiers
* Updated IIO_RESISTANCE and IIO_CONCENTRATION documentation
* Moved the decimal point shifting to the scale value versus the reading

Matt Ranostay (4):
  iio: chemical: Add IIO_CONCENTRATION channel type
  iio: resistance: add IIO_RESISTANCE channel type
  devicetree: add SGX Sensortech vendor id
  iio: chemical: add SGX VZ89x VOC sensor support

 Documentation/ABI/testing/sysfs-bus-iio            |  19 ++
 .../ABI/testing/sysfs-bus-iio-chemical-vz89x       |   7 +
 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/chemical/Kconfig                       |  15 ++
 drivers/iio/chemical/Makefile                      |   6 +
 drivers/iio/chemical/vz89x.c                       | 237 +++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |   4 +
 include/uapi/linux/iio/types.h                     |   4 +
 11 files changed, 296 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-vz89x
 create mode 100644 drivers/iio/chemical/Kconfig
 create mode 100644 drivers/iio/chemical/Makefile
 create mode 100644 drivers/iio/chemical/vz89x.c

-- 
1.9.1

