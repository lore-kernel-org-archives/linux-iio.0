Return-Path: <reyad.attiyat@gmail.com>
From: Reyad Attiyat <reyad.attiyat@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: Reyad Attiyat <reyad.attiyat@gmail.com>
Subject: [PATCH v5 0/4] iio: Add support for rotation from north
Date: Wed,  9 Jul 2014 14:30:09 -0500
Message-Id: <1404934213-2733-1-git-send-email-reyad.attiyat@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This series of patches modifies magn-3d driver to handle the rotation
from north usage. This is done by scanning the report and then building
the iio arrays (vals and channels) dynamically.

Changes from V4
I use the address field of struct iio_chan_spec to hold the array index
of the usage attribute. The scan_index field is generated when creating
an iio channel.

Reyad Attiyat (4):
  iio: Documentation: Add documentation for rotation from north sensor
    usage attributes
  iio: types: Added support for rotation from north usage attributes
  iio: hid-sensor-magn-3d: Scan for usage attributes before setting up
    iio channels
  iio: hid-sensor-magn-3d: Add support for rotation from north

 Documentation/ABI/testing/sysfs-bus-iio       |  82 +++++++++++
 drivers/iio/industrialio-core.c               |   4 +
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 199 ++++++++++++++++++++------
 include/linux/iio/types.h                     |   4 +
 4 files changed, 245 insertions(+), 44 deletions(-)

-- 
1.9.3
