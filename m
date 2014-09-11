Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52498 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752555AbaIKANH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 10 Sep 2014 20:13:07 -0400
From: Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v4 0/1] iio: jsa1212: Add JSA1212 proximity/ALS sensor
Date: Wed, 10 Sep 2014 17:09:17 -0700
Message-Id: <cover.1410393352.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Please let me know your review comments.

PATCH v4 changes:

1. Removed unused register defines
2. Used standard endian conversion function instead of custom one.
3. Replaced register default value constants with appropriate bit value macros.
4. Removed iio user interfaces before powering off the device in remove function.

PATCH v3 changes:

1. Replaced status flags with bool values.
2. Added regmap suppport to avoid adding custom i2c register update routine.
3. Also addressed some minor comments from Jonathan Cameron

PATCH v2 changes:

1. Combined ALS/PXS enable/disable functions into a single routine.
2. Removed extra debug messages.
3. Also addressed review comments from Peter Meerwald

Kuppuswamy Sathyanarayanan (1):
  iio: jsa1212: Add JSA1212 proximity/ALS sensor

 drivers/iio/light/Kconfig   |  10 +
 drivers/iio/light/Makefile  |   1 +
 drivers/iio/light/jsa1212.c | 487 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 498 insertions(+)
 create mode 100644 drivers/iio/light/jsa1212.c

-- 
1.9.1

