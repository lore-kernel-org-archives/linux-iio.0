Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:45553 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754477AbaGaCiI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 30 Jul 2014 22:38:08 -0400
From: Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v1 0/1] iio: jsa1212: Add JSA1212 proximity/ALS sensor
Date: Wed, 30 Jul 2014 19:34:21 -0700
Message-Id: <cover.1406773841.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Please let me know your review comments.

PATCH v1 changes:

1. Simplified the driver design based on Jonathan Cameron comments.
2. Removed the ALS/proximity event support from the initial driver
   and decided to submit it as seperate patch later.
3. Also addressed review comments from Peter Meerwald

Kuppuswamy Sathyanarayanan (1):
  iio: jsa1212: Add JSA1212 proximity/ALS sensor

 drivers/iio/light/Kconfig   |   10 +
 drivers/iio/light/Makefile  |    1 +
 drivers/iio/light/jsa1212.c |  558 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 569 insertions(+)
 create mode 100644 drivers/iio/light/jsa1212.c

-- 
1.7.9.5

