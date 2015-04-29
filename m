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
Subject: [PATCH v3 0/4] Add support for BMC150 magnetometer
Date: Wed, 29 Apr 2015 21:16:36 +0300
Message-Id: <1430331400-25528-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This is the third version for adding support for Bosch BMC150
magnetometer. It contains fixes suggested by Jonathan.

Changes in v3:
 - a couple of small fixes suggested by Jonathan

Changes in v2:
 - renamed IIO_CHAN_INFO_CALIBREPETITIONS to IIO_CHAN_INFO_OVERSAMPLING_RATIO
 - split the main patch in two patches: one that adds main functionality and
another that adds oversampling_ratio
 - fixed driver code and device tree bindings according to Jonathan's review
 - updated the available sampling frequencies depending on oversampling_ratio

Irina Tirdea (4):
  iio: magn: Add support for BMC150 magnetometer
  iio: magn: bmc150_magn: Add devicetree binding documentation
  iio: core: Introduce IIO_CHAN_INFO_OVERSAMPLING_RATIO
  iio: magn: bmc150_magn: add oversampling ratio

 Documentation/ABI/testing/sysfs-bus-iio            |   12 +
 .../bindings/iio/magnetometer/bmc150_magn.txt      |   22 +
 drivers/iio/industrialio-core.c                    |    1 +
 drivers/iio/magnetometer/Kconfig                   |   14 +
 drivers/iio/magnetometer/Makefile                  |    2 +
 drivers/iio/magnetometer/bmc150_magn.c             | 1109 ++++++++++++++++++++
 include/linux/iio/iio.h                            |    1 +
 7 files changed, 1161 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt
 create mode 100644 drivers/iio/magnetometer/bmc150_magn.c

-- 
1.9.1
