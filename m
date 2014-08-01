Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49149 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774AbaHAQnW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 1 Aug 2014 12:43:22 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 0/2] kxcjk-1013 updates after last review
Date: Fri,  1 Aug 2014 09:49:20 -0700
Message-Id: <1406911762-6503-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This address review comments:
1.
Re: [PATCH 4/6] iio: accel: kxcjk-1013: Set adjustable range: Date 07/27/14
Changes:
- Changed defines to enums
- use set function for setting range in kxcjk1013_chip_init, instead of hard coding


2.
Re: [PATCH 3/6] iio: accel: kxcjk-1013: support runtime pm: Date 07/27/14
- Fix compile errors when RUNTIME PM is not defined
Other changes
- Remove module parameters and use autosuspend feature of runtime PM


Srinivas Pandruvada (2):
  iio: accel: kxcjk-1013: support runtime pm
  iio: accel: kxcjk-1013: Set adjustable range

 drivers/iio/accel/kxcjk-1013.c | 308 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 259 insertions(+), 49 deletions(-)

-- 
1.9.1

