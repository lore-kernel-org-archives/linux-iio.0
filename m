Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55378 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957AbaFETa4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 5 Jun 2014 15:30:56 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] iio: accel: kxcjk1013 3-axis accelerometer driver
Date: Thu,  5 Jun 2014 12:31:50 -0700
Message-Id: <1401996711-23963-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

v1 and v2
Addressed formatting and endianess issue 
identified by Peter Meerwald

v0
base version
Srinivas Pandruvada (1):
  iio: accel: kxcjk1013 3-axis accelerometer driver

 drivers/iio/accel/Kconfig      |  12 +
 drivers/iio/accel/Makefile     |   1 +
 drivers/iio/accel/kxcjk-1013.c | 729 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 742 insertions(+)
 create mode 100644 drivers/iio/accel/kxcjk-1013.c

-- 
1.7.11.7

