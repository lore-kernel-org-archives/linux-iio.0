Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:37416 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752657AbaFKWD4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 11 Jun 2014 18:03:56 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3] iio: AK09911 : 3 axis compass support
Date: Wed, 11 Jun 2014 15:06:31 -0700
Message-Id: <1402524392-26488-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

v3
Comments by Lars
- use sign_extend32
- extra space
- alignment
- cast for const char*
 
v1 and v2
Addressed formatting, endianess and clamp issues
identified by Peter Meerwald

v0
base version

Srinivas Pandruvada (1):
  iio: AK09911 : 3 axis compass support

 drivers/iio/magnetometer/Kconfig   |  10 ++
 drivers/iio/magnetometer/Makefile  |   1 +
 drivers/iio/magnetometer/ak09911.c | 327 +++++++++++++++++++++++++++++++++++++
 3 files changed, 338 insertions(+)
 create mode 100644 drivers/iio/magnetometer/ak09911.c

-- 
1.7.11.7

