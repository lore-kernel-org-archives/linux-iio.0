Return-Path: <sathyanarayanan.kuppuswamy@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: jic23@kernel.org,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3 0/1] LTR301 ALS support
Date: Wed,  1 Apr 2015 21:24:26 -0700
Message-Id: <cover.1427948588.git.sathyanarayanan.kuppuswamy@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Following patch adds support for Liteon 301 Ambient light sensor.

Please let me know your review comments.

v1:
Extended LTR501 driver to support both LTR301 and LTR501 device.

v2:
1. Handled device id NULL case in probe
2. Changed pr_warn to dev_warn

v3:
1. Sent v2 before by mistake. So sending the final version of v2 as v3.

Kuppuswamy Sathyanarayanan (1):
  iio: ltr301: Add support for ltr301

 drivers/iio/light/Kconfig  |  2 +-
 drivers/iio/light/ltr501.c | 56 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 54 insertions(+), 4 deletions(-)

-- 
1.9.1
