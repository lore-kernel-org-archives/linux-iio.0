Return-Path: <mtitinger@baylibre.com>
From: Marc Titinger <mtitinger@baylibre.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: daniel.baluta@intel.com,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Marc Titinger <mtitinger@baylibre.com>
Subject: [RFC 0/2] ABI: IIO: proposal for AVERAGING_RATIO support
Date: Tue, 17 Nov 2015 11:44:08 +0100
Message-Id: <1447757050-4214-1-git-send-email-mtitinger@baylibre.com>
List-ID: <linux-iio@vger.kernel.org>

This is an attempt to document/define simple downsampling/averaging
features for some ADC devices.

As discussed in https://lkml.org/lkml/2015/11/16/566

As an illustration, Patch 2 is an instance of implementation
using ina226.

Marc Titinger (2):
  ABI: iio: support AVERAGING_RATIO setting
  iio: ina2xx: convert AVERGING ratio setting from generic sysfs attr to
    ABI

 Documentation/ABI/testing/sysfs-bus-iio | 13 +++++++++
 drivers/iio/adc/ina2xx-iio.c            | 47 +++++----------------------------
 drivers/iio/industrialio-core.c         |  1 +
 include/linux/iio/iio.h                 |  1 +
 include/linux/iio/sysfs.h               |  9 +++++++
 5 files changed, 30 insertions(+), 41 deletions(-)

-- 
1.9.1
