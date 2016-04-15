Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5999 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904AbcDOOLA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 15 Apr 2016 10:11:00 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org, irina.tirdea@intel.com
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	daniel.baluta@intel.com, geert@linux-m68k.org,
	vlad.dogaru@intel.com, octavian.purdila@intel.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 0/2] Introduce SPI support for BMC150 chip
Date: Fri, 15 Apr 2016 17:13:08 +0300
Message-Id: <1460729590-18886-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

First patch splits the current architecture into a common part
and a bus specific part. Second patch adds SPI support.

We will have 3 modules:

* bmc150_magn.ko - exposes core functionality
* bmc150_magn_i2c.ko - instantiates I2C regmap and uses core
* bmc150_magn_spi.ko - instantiates SPI regmap and uses core

Daniel Baluta (2):
  iio: magn: Split bmc150 driver in common/i2c parts
  iio: magn: bmc150: Introduce SPI support

 drivers/iio/magnetometer/Kconfig           |  31 ++++--
 drivers/iio/magnetometer/Makefile          |   3 +
 drivers/iio/magnetometer/bmc150_magn.c     | 155 ++++++++++++-----------------
 drivers/iio/magnetometer/bmc150_magn.h     |  11 ++
 drivers/iio/magnetometer/bmc150_magn_i2c.c |  77 ++++++++++++++
 drivers/iio/magnetometer/bmc150_magn_spi.c |  68 +++++++++++++
 6 files changed, 247 insertions(+), 98 deletions(-)
 create mode 100644 drivers/iio/magnetometer/bmc150_magn.h
 create mode 100644 drivers/iio/magnetometer/bmc150_magn_i2c.c
 create mode 100644 drivers/iio/magnetometer/bmc150_magn_spi.c

-- 
2.5.0

