Return-Path: <vlad.dogaru@intel.com>
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: irina.tirdea@intel.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH 0/2] iio: bmc150: buffer cleanup and support for a new chip
Date: Fri, 12 Jun 2015 11:31:37 +0300
Message-Id: <1434097899-13984-1-git-send-email-vlad.dogaru@intel.com>
List-ID: <linux-iio@vger.kernel.org>

These aren't really related, but I've posted them as a series in the interest
of applying them cleanly.

Vlad Dogaru (2):
  iio: magn: bmc150: decouple buffer and trigger
  iio: magn: bmc150: add support for bmc156

 drivers/iio/magnetometer/bmc150_magn.c | 71 +++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 31 deletions(-)

-- 
1.9.1
