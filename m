Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:63678 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753166AbbFOVsq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 15 Jun 2015 17:48:46 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Octavian Purdila <octavian.purdila@intel.com>,
	Laurentiu Palcu <laurentiu.palcu@intel.com>
Subject: [PATCH 0/3] bmc150-accel fixes and cleanup
Date: Mon, 15 Jun 2015 23:48:23 +0200
Message-Id: <cover.1434404216.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series adresses some issues that got introduced this year, as well as
some that checkpatch.pl pointed out.

Hartmut Knaack (3):
  iio:accel:bmc150-accel: fix counting direction
  iio:accel:bmc150-accel: make use of mask definition
  iio:accel:bmc150-accel: code style cleanup

 drivers/iio/accel/bmc150-accel.c | 95 +++++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 44 deletions(-)

-- 
2.3.6

