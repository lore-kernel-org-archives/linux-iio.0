Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Adriana Reus <adriana.reus@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 0/2] kxcjk-1013 driver optimizations
Date: Mon, 16 Feb 2015 20:21:47 +0200
Message-Id: <1424110909-16878-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Adds optimization of i2c transactions in trigger handler and
usage of available_scan_masks for kxcjk-1013.

Adriana Reus (2):
  iio: accel: kxcjk-1013: use available_scan_masks
  iio: accel: kxcjk-1013: optimize i2c transfers in trigger handler

 drivers/iio/accel/kxcjk-1013.c | 50 ++++++++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 11 deletions(-)

-- 
1.9.1
