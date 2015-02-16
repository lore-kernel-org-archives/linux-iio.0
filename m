Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Adriana Reus <adriana.reus@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 0/2] bmg160 driver optimizations
Date: Mon, 16 Feb 2015 20:14:08 +0200
Message-Id: <1424110450-16398-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Adds optimization of i2c transactions in trigger handler and
usage of available_scan_masks for bmg160.

Changes in v2:
 - fallback to i2c word transactions if i2c block transactions are not supported
 - use available_scan_masks to let the iio core choose the values selected
by the user instead of doing the check in the driver's interrupt handler
 - check functionality for i2c byte and word read

Irina Tirdea (2):
  iio: gyro: bmg160: use available_scan_masks
  iio: gyro: bmg160: optimize i2c transfers in trigger handler

 drivers/iio/gyro/bmg160.c | 50 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 11 deletions(-)

-- 
1.9.1
