Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48119 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755458AbbHYT7c (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 25 Aug 2015 15:59:32 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org, edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC PATCH v1 0/3] thermal: iio bindings
Date: Tue, 25 Aug 2015 12:58:29 -0700
Message-Id: <1440532712-5025-1-git-send-email-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

v1
- Change commit message to be more clear
- Split in three patches (First for thermal_iio.c, second to integrate
to thermal_core and third for user space governor).
- Removed IIO defines in thermal.h
- Removed direct push to buffers
- Other comments from Jonathan except introduce validate_trigger

v0
Base version for first review

Srinivas Pandruvada (3):
  thermal: iio device for thermal sensor
  thermal: use iio binding calls
  thermal: user space governor: Notification for IIO bindings

 drivers/thermal/Kconfig        |  11 ++
 drivers/thermal/Makefile       |   1 +
 drivers/thermal/thermal_core.c |   9 +-
 drivers/thermal/thermal_iio.c  | 341 +++++++++++++++++++++++++++++++++++++++++
 drivers/thermal/user_space.c   |   1 +
 include/linux/thermal.h        |  31 ++++
 6 files changed, 392 insertions(+), 2 deletions(-)
 create mode 100644 drivers/thermal/thermal_iio.c

-- 
2.4.3

