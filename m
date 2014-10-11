Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:18313 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751520AbaJKDdX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 10 Oct 2014 23:33:23 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 0/4] BMG160 updates
Date: Fri, 10 Oct 2014 20:33:24 -0700
Message-Id: <1412998408-31870-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

v1
Rebased to latest tree
Split patch for event dir fix to two

v0
Initial patches

Srinivas Pandruvada (4):
  iio: gyro: bmg160: Error handling when mode set fails
  iio: gyro: bmg160: Don't let interrupt mode to be open drain
  iio: gyro: bmg160: Send x, y and z motion separately
  iio: gyro: bmg160: Fix iio_event_spec direction

 drivers/iio/gyro/bmg160.c | 53 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 4 deletions(-)

-- 
1.9.1

