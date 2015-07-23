Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 0/2] bmc150 magnetometer cleanup
Date: Thu, 23 Jul 2015 20:15:00 +0300
Message-Id: <1437671702-20994-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

A couple of small cleanup patches starting from Hartmut's series.
There are no conflicts with the rest of Hartmut's patches, so they
can be applied in any order.

Irina Tirdea (2):
  iio: magn: bmc150_magn: add locking comment for runtime resume
  iio: magn: bmc150_magn: do not set power state twice when setting
    trigger state

 drivers/iio/magnetometer/bmc150_magn.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

-- 
1.9.1
