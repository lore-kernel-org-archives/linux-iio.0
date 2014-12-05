Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	linux-kernel@vger.kernel.org,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 0/4] PM fixes for kxcjk-1013
Date: Sat,  6 Dec 2014 00:18:06 +0200
Message-Id: <1417817890-10252-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This is a small set of power manangement fixes for kxcjk-1013 accel driver,
mostly related to error handling.

Irina Tirdea (4):
  iio: accel: kxcjk-1013: always power on device in resume
  iio: accel: kxcjk-1013: only set power state if CONFIG_PM is defined
  iio: accel: kxcjk-1013: error handling when set mode fails
  iio: accel: kxcjk-1013: power off device if probe fails

 drivers/iio/accel/kxcjk-1013.c |   37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

-- 
1.7.9.5
