Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:13313 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964916AbbEMNaT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 13 May 2015 09:30:19 -0400
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
	irina.tirdea@intel.com, octavian.purdila@intel.com,
	linux-iio@vger.kernel.org
Cc: adriana.reus@intel.com, Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH 0/2] iio: gyro: bmg160: decouple buffer from triggers
Date: Wed, 13 May 2015 16:30:07 +0300
Message-Id: <1431523809-13824-1-git-send-email-vlad.dogaru@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Make it possible to use buffering with an external trigger.  Useful when
the interrupt pins are not wired in.

Vlad Dogaru (2):
  iio: gyro: bmg160: remove redundant field
  iio: gyro: bmg160: decouple buffer and triggers

 drivers/iio/gyro/bmg160.c | 67 +++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 31 deletions(-)

-- 
1.9.1

