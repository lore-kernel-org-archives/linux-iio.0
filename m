Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 0/3] Add support for BMC150 magnetometer
Date: Fri, 17 Apr 2015 13:50:27 +0300
Message-Id: <1429267830-13681-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This adds support for Bosch BMC150 magnetometer.

Irina Tirdea (3):
  iio: core: Introduce IIO_CHAN_INFO_CALIBREPETITIONS
  iio: magn: Add support for BMC150 magnetometer
  iio: magn: bmc150_magn: Add devicetree binding documentation

 Documentation/ABI/testing/sysfs-bus-iio            |   10 +
 .../bindings/iio/magnetometer/bmc150_magn.txt      |   20 +
 drivers/iio/industrialio-core.c                    |    1 +
 drivers/iio/magnetometer/Kconfig                   |   14 +
 drivers/iio/magnetometer/Makefile                  |    2 +
 drivers/iio/magnetometer/bmc150_magn.c             | 1060 ++++++++++++++++++++
 include/linux/iio/iio.h                            |    1 +
 7 files changed, 1108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt
 create mode 100644 drivers/iio/magnetometer/bmc150_magn.c

-- 
1.9.1
