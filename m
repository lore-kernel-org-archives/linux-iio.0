Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:37247 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029AbcDTPmL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 20 Apr 2016 11:42:11 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [RFC PATCH 0/3] Introduce support for creating IIO devices via configfs
Date: Wed, 20 Apr 2016 18:45:23 +0300
Message-Id: <1461167126-23399-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

For testing purposes is nice to have a quick way of creating IIO devices.
This patch series introduces support for creating IIO devices via configs
(patch 1), allowing users to register "device types". For the moment we
support "dummy" device type (patch 2).

This is just a RFC in order to see if the interface is acceptable. We also
need a way to create IIO devices with configurable number of channels.

Patch 3 introduces configfs entries documentation for easier review.

Daniel Baluta (3):
  iio: Add support for creating IIO devices via configfs
  iio: dummy: Convert IIO dummy to configfs
  Documentation: iio: Add IIO software devices docs

 Documentation/ABI/testing/configfs-iio |  13 +++
 drivers/iio/Kconfig                    |   9 ++
 drivers/iio/Makefile                   |   1 +
 drivers/iio/dummy/iio_simple_dummy.c   |  98 ++++++------------
 drivers/iio/industrialio-sw-device.c   | 181 +++++++++++++++++++++++++++++++++
 include/linux/iio/sw_device.h          |  70 +++++++++++++
 6 files changed, 307 insertions(+), 65 deletions(-)
 create mode 100644 drivers/iio/industrialio-sw-device.c
 create mode 100644 include/linux/iio/sw_device.h

-- 
2.5.0

