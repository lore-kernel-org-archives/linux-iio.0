Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Octavian Purdila <octavian.purdila@intel.com>,
	Markus Pargmann <mpa@pengutronix.de>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 0/6] Driver optimizations in trigger handler
Date: Thu, 24 Mar 2016 11:29:25 +0200
Message-Id: <1458811771-25217-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This patchset adds optimization of i2c transactions in trigger handler
for bmc150, bmg160 and kxcjk-1013 drivers. It also introduces the
usage of available_scan_masks.

The code for bmc150 and bmg160 drivers is a rewrite of a previous
version [1] that takes into account the usage of regmap. The code
for kxcjk-1013 is the same as in the previous patch [1],
but included here for merging (since the
i2c_smbus_read_i2c_block_data_or_emulated API has been merged in
the iio tree).

[1] https://lkml.org/lkml/2015/8/12/609

Adriana Reus (2):
  iio: accel: kxcjk-1013: use available_scan_masks
  iio: accel: kxcjk-1013: optimize i2c transfers in trigger handler

Irina Tirdea (4):
  iio: accel: bmc150: use available_scan_masks
  iio: accel: bmc150: optimize transfers in trigger handler
  iio: gyro: bmg160: use available_scan_masks
  iio: accel: bmg160: optimize transfers in trigger handler

 drivers/iio/accel/bmc150-accel-core.c | 25 ++++++++++++-------------
 drivers/iio/accel/kxcjk-1013.c        | 24 ++++++++++++------------
 drivers/iio/gyro/bmg160_core.c        | 24 ++++++++++++------------
 3 files changed, 36 insertions(+), 37 deletions(-)

-- 
1.9.1
