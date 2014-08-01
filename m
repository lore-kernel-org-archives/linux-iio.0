Return-Path: <sathyanarayanan.kuppuswamy@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v2 0/1] iio: jsa1212: Add JSA1212 proximity/ALS sensor
Date: Thu, 31 Jul 2014 20:02:47 -0700
Message-Id: <cover.1406861859.git.sathyanarayanan.kuppuswamy@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Please let me know your review comments.

PATCH v2 changes:

1. Combined ALS/PXS enable/disable functions into a single routine.
2. Removed extra debug messages.
3. Also addressed review comments from Peter Meerwald

Kuppuswamy Sathyanarayanan (1):
  iio: jsa1212: Add JSA1212 proximity/ALS sensor

 drivers/iio/light/Kconfig   |   10 +
 drivers/iio/light/Makefile  |    1 +
 drivers/iio/light/jsa1212.c |  490 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 501 insertions(+)
 create mode 100644 drivers/iio/light/jsa1212.c

-- 
1.7.9.5
