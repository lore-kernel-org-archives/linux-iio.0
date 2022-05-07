Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013E8C433F5
	for <linux-iio@archiver.kernel.org>; Sat,  7 May 2022 17:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386616AbiEGRic (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 7 May 2022 13:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbiEGRib (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 May 2022 13:38:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61BD205F8;
        Sat,  7 May 2022 10:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651944884; x=1683480884;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X0ItBNJz50nkKAhRztUipXfBqiaaq+mP7b+UDMO9LAo=;
  b=HklHAe+KlzqqLLiVNZVCmUv4DcjcdlbLab8k9le5F2zqHTv+C8QFYe8K
   yEc+b7TLcX5SciW4R6ZAtpPRn+g5vncXmLBGFgNILmWK8VN8lWLqOw2L3
   niCn3BWiL3HrB8LY6djveWmBm79s8VwLxGuJu9t7T1bgABSpRRnoVy1xM
   Hkv/8ONL25v/vRgmmY4f+3mVNM3UM6Dz/N6jtdIkttbJCZG9gDam8C3PD
   lV0qZ9YIa9/qaCUlpobkBzICm/Fsrd0vNwALEUby+ZFZAvoWmIYvSejxR
   rynTUEzazNDZIFrr8MuSmfMbkQr5C7SKqJXVpv1HJefDKYhJSn8YGl2a7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10340"; a="268631047"
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="268631047"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 10:34:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="518537172"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 07 May 2022 10:34:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0C58F155; Sat,  7 May 2022 20:34:43 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: imu: st_lsm6dsx: Switch from of headers to mod_devicetable.h
Date:   Sat,  7 May 2022 20:34:40 +0300
Message-Id: <20220507173440.29053-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There is nothing directly using of specific interfaces in this driver,
so lets not include the headers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
index 8d4201b86e87..35556cd04284 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
@@ -6,11 +6,11 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/i3c/device.h>
 #include <linux/i3c/master.h>
 #include <linux/slab.h>
-#include <linux/of.h>
 #include <linux/regmap.h>
 
 #include "st_lsm6dsx.h"
-- 
2.35.1

