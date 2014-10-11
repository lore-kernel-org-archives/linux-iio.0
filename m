Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:54203 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795AbaJKDf3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 10 Oct 2014 23:35:29 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 0/4] BMC 150 driver updates
Date: Fri, 10 Oct 2014 20:35:30 -0700
Message-Id: <1412998534-31971-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

v1
Rebase to the latest tree
Spilt the patch for event spec dir change

v0
initial submission

Srinivas Pandruvada (4):
  iio: accel: bmc150: Error handling when mode set fails
  iio: accel: bmc150: Send x, y and z motion separately
  iio: accel: bmc150: set low default thresholds
  iio: accel: bmc150: Fix iio_event_spec direction

 drivers/iio/accel/bmc150-accel.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

-- 
1.9.1

