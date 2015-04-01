Return-Path: <sathyanarayanan.kuppuswamy@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: jic23@kernel.org,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v1 0/1] LTR301 ALS support
Date: Tue, 31 Mar 2015 21:06:57 -0700
Message-Id: <cover.1427861152.git.sathyanarayanan.kuppuswamy@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Following patch adds support for Liteon 301 Ambient light sensor.

Please let me know your review comments.

v1:
Extended LTR501 driver to support both LTR301 and LTR501 device.

Kuppuswamy Sathyanarayanan (1):
  iio: ltr301: Add support for ltr301

 drivers/iio/light/Kconfig  |  2 +-
 drivers/iio/light/ltr501.c | 50 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 48 insertions(+), 4 deletions(-)

-- 
1.9.1
