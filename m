Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34085 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619AbbIEFxR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Sep 2015 01:53:17 -0400
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [RFC v1 0/4] iio: new chemical sensor framework and channel types
Date: Fri,  4 Sep 2015 22:53:22 -0700
Message-Id: <1441432406-4761-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Initial RFC for new chemical sensor framework, IIO_CONCENTRATION,
and IIO_RESISTANCE channel types.

Important notes:
* Not been tested on real hardware yet but that isn't the main RFC reason and
  once hardware is in hand it will be verified
* Reason the IIO_CONCENTRATION type isn't in percent but has modifiers for ppm
  and ppb is the scale value for the latter would cause a integer overflow
  using IIO_VAL_FRACTIONAL

Matt Ranostay (4):
  iio: chemical: Add IIO_CONCENTRATION channel type
  iio: resistance: add IIO_RESISTANCE channel type
  devicetree: add SGX Sensortech vendor id
  iio: chemical: add SGX VZ89x VOC sensor support

 Documentation/ABI/testing/sysfs-bus-iio            |  16 ++
 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/chemical/Makefile                      |   6 +
 drivers/iio/chemical/vz89x.c                       | 237 +++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |   4 +
 include/uapi/linux/iio/types.h                     |   4 +
 9 files changed, 271 insertions(+)
 create mode 100644 drivers/iio/chemical/Makefile
 create mode 100644 drivers/iio/chemical/vz89x.c

-- 
1.9.1

