Return-Path: <octavian.purdila@intel.com>
From: Octavian Purdila <octavian.purdila@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	adriana.reus@intel.com,
	linux-api@vger.kernel.org,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 0/3] allow better control for flushing the hardware fifo
Date: Wed, 29 Apr 2015 14:18:57 +0300
Message-Id: <1430306340-5026-1-git-send-email-octavian.purdila@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

The first patch is a small enhancement that makes it easier to add
hwfifo support in drivers.

The other two are adding new ABIs to allow on demand trigger of a
hardware fifo flush operation and to signal when the flush operation
has been completed. The user for this interface is Android's sensor
HAL.

Thanks,
Tavi

Octavian Purdila (3):
  iio: add hwfifo attributes helpers
  iio: allow better control for flushing the hardware fifo
  iio: accel: bmc150: add support for hwfifo_flush and flush events

 Documentation/ABI/testing/sysfs-bus-iio | 11 +++++
 drivers/iio/accel/bmc150-accel.c        | 71 +++++++++++++++++++++++----------
 include/linux/iio/sysfs.h               | 15 +++++++
 include/uapi/linux/iio/types.h          |  1 +
 4 files changed, 78 insertions(+), 20 deletions(-)

-- 
1.9.1
