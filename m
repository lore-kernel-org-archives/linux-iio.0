Return-Path: <teodora.baluta@intel.com>
From: Teodora Baluta <teodora.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	daniel.baluta@intel.com,
	teodora.baluta@intel.com,
	dan.carpenter@oracle.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: mmc35240: fix sampling freq and add support for new chip
Date: Mon, 29 Jun 2015 15:44:49 +0300
Message-Id: <1435581891-1730-1-git-send-email-teodora.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

The first patch fixes the sampling frequencies for mmc35240 and the second adds
support for mmc34160 magnetometer. These two patches are not related, but they
are sent as a patch series in order to apply them cleanly.

Teodora Baluta (2):
  iio: magnetometer: mmc35240: fix available sampling frequencies
  iio: magnetometer: add mmc34160 magnetometer driver

 drivers/iio/magnetometer/Kconfig    |   5 +-
 drivers/iio/magnetometer/mmc35240.c | 255 +++++++++++++++++++++++++++---------
 2 files changed, 198 insertions(+), 62 deletions(-)

-- 
1.9.1
