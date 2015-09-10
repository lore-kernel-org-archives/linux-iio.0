Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34180 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbbIJGbW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 Sep 2015 02:31:22 -0400
Received: by padhy16 with SMTP id hy16so33731879pad.1
        for <linux-iio@vger.kernel.org>; Wed, 09 Sep 2015 23:31:22 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [RFC v4 0/4] iio: new chemical sensor framework and channel types
Date: Wed,  9 Sep 2015 23:30:50 -0700
Message-Id: <1441866654-10381-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from RFC v3:
* Add missing Kconfig

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
 drivers/iio/chemical/Kconfig                       |  15 ++
 drivers/iio/chemical/Makefile                      |   6 +
 drivers/iio/chemical/vz89x.c                       | 245 +++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |   2 +
 include/uapi/linux/iio/types.h                     |   2 +
 11 files changed, 318 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-vz89x
 create mode 100644 drivers/iio/chemical/Kconfig
 create mode 100644 drivers/iio/chemical/Makefile
 create mode 100644 drivers/iio/chemical/vz89x.c

-- 
1.9.1

