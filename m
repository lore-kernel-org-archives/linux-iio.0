Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8967 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751044AbaHHRuO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 8 Aug 2014 13:50:14 -0400
From: Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3 0/1] iio: jsa1212: Add JSA1212 proximity/ALS sensor
Date: Fri,  8 Aug 2014 10:46:48 -0700
Message-Id: <cover.1407516896.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Please let me know your review comments.

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

 drivers/iio/light/Kconfig   |   10 +
 drivers/iio/light/Makefile  |    1 +
 drivers/iio/light/jsa1212.c |  487 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 498 insertions(+)
 create mode 100644 drivers/iio/light/jsa1212.c

-- 
1.7.9.5

