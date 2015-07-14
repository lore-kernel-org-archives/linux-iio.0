Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: daniel.baluta@intel.com,
	viorel.suman@intel.com,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] MMC35240 magneto fixes
Date: Tue, 14 Jul 2015 17:56:51 +0300
Message-Id: <1436885814-29155-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Found while testing with a compass Android app.

Jonathan, this is a follow up of the first patch in this series,
initially sent for review before merged window was closed:
See: https://lkml.org/lkml/2015/6/21/68

Daniel Baluta (2):
  iio: magnetometer: mmc35240: Fix crash in pm suspend
  iio: magnetometer: mmc35240: Fix SET/RESET mask

Viorel Suman (1):
  iio: magnetometer: mmc35240: fix SET/RESET sequence

 drivers/iio/magnetometer/mmc35240.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

-- 
1.9.1
