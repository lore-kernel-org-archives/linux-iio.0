Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2 0/3] atlas-ph-sensor: add conductivity sensor support
Date: Thu, 19 May 2016 18:52:58 -0700
Message-Id: <1463709181-17528-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Changes from v1:
 * Add IIO_ELECTRICALCONDUCTIVITY type rather than do doing weird conversion to ppm
 * move device tree mapping table above probe for of_match_device

Matt Ranostay (3):
  iio: chemical: atlas-ph-sensor: reorg driver to allow multiple chips
  iio: electricalconductivity: add IIO_ELECTRICALCONDUCTIVITY type
  iio: chemical: atlas-ph-sensor: add EC feature

 Documentation/ABI/testing/sysfs-bus-iio            |   7 +
 .../bindings/iio/chemical/atlas,ec-sm.txt          |  22 ++
 drivers/iio/chemical/Kconfig                       |   8 +-
 drivers/iio/chemical/atlas-ph-sensor.c             | 257 ++++++++++++++++-----
 drivers/iio/industrialio-core.c                    |   1 +
 include/uapi/linux/iio/types.h                     |   1 +
 6 files changed, 236 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ec-sm.txt

-- 
2.7.4
