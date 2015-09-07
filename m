Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34879 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbbIGCi4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 6 Sep 2015 22:38:56 -0400
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [RFC v2 0/4] iio: new chemical sensor framework and channel types
Date: Sun,  6 Sep 2015 19:39:03 -0700
Message-Id: <1441593547-10896-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from RFC v1:
* Removed IIO_MOD_PPM/PPB modifiers
* Fixed issues with driver that would have caused null
  readings
* Return IIO_VAL_INT_PLUS_MICRO/IIO_VAL_INT_PLUS_NANO
  for CO2 and VOC channel readings
* Return IIO_VAL_INT_PLUS_MICRO for IIO_CHAN_INFO_OFFSET
* Add sysfs-bus-iio-chemical-vz89x documentation

Matt Ranostay (4):
  iio: chemical: Add IIO_CONCENTRATION channel type
  iio: resistance: add IIO_RESISTANCE channel type
  devicetree: add SGX Sensortech vendor id
  iio: chemical: add SGX VZ89x VOC sensor support

 Documentation/ABI/testing/sysfs-bus-iio            |  14 ++
 .../ABI/testing/sysfs-bus-iio-chemical-vz89x       |  30 +++
 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/chemical/Makefile                      |   6 +
 drivers/iio/chemical/vz89x.c                       | 236 +++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |   2 +
 include/uapi/linux/iio/types.h                     |   2 +
 10 files changed, 294 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-vz89x
 create mode 100644 drivers/iio/chemical/Makefile
 create mode 100644 drivers/iio/chemical/vz89x.c

-- 
1.9.1

