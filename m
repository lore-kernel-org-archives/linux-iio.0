Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33180 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919AbbIIGN3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Sep 2015 02:13:29 -0400
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [RFC v3 0/4] iio: new chemical sensor framework and channel types
Date: Tue,  8 Sep 2015 23:13:36 -0700
Message-Id: <1441779220-8834-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from RFC v2:
* Proper usage of IIO_CHAN_INFO_OFFSET values for VOC and CO2 channels
* Return CO2 offset that combines the 400 ppm offset and -13 value correction

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
 drivers/iio/chemical/vz89x.c                       | 245 +++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |   2 +
 include/uapi/linux/iio/types.h                     |   2 +
 10 files changed, 303 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-vz89x
 create mode 100644 drivers/iio/chemical/Makefile
 create mode 100644 drivers/iio/chemical/vz89x.c

-- 
1.9.1

