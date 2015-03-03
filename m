Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52950 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752322AbbCCQSK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 3 Mar 2015 11:18:10 -0500
From: Octavian Purdila <octavian.purdila@intel.com>
To: linux-iio@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH v4 0/3] iio: bmc150: refactoring in preparation for hardware fifo support
Date: Tue,  3 Mar 2015 18:17:55 +0200
Message-Id: <1425399478-5464-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

Here is a new version for the remaining bmc150 refactor patches that
were not merged. I've also added to this set a fix from Sathya which
has been sitting in our tree.

As you requested, I've split the refactoring series from the hardware
fifo series. I will send the v4 hwfifo series shortly.

Thanks,
Tavi

Changes since v3:

* added enums for interrupts and triggers

* added fix from Sathya



Octavian Purdila (2):
  iio: bmc150: introduce bmc150_accel_interrupt
  iio: bmc150: introduce bmc150_accel_trigger

Sathyanarayanan Kuppuswamy (1):
  iio: bmc150: change sampling frequency

 drivers/iio/accel/bmc150-accel.c | 294 ++++++++++++++++++++++++---------------
 1 file changed, 178 insertions(+), 116 deletions(-)

-- 
1.9.1

