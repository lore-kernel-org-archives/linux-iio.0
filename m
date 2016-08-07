Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:36696 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751672AbcHGJZx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 7 Aug 2016 05:25:53 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jikos@kernel.org, jic23@kernel.org
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com
Subject: [PATCH v4 7/7] MAINTAINERS: Add Intel ISH
Date: Sun,  7 Aug 2016 02:25:39 -0700
Message-Id: <1470561939-14278-8-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1470561939-14278-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1470561939-14278-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add maintainer entry for Intel Integrated Sensor Hub

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 20bb1d0..68cbb2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6077,6 +6077,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
 S:	Supported
 F:	drivers/idle/intel_idle.c
 
+INTEL INTEGRATED SENSOR HUB DRIVER
+M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
+M:	Jiri Kosina <jikos@kernel.org>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/intel-ish-hid/
+
 INTEL PSTATE DRIVER
 M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
 M:	Len Brown <lenb@kernel.org>
-- 
2.7.4

