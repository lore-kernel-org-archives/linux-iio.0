Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:39946 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751060AbdBICEl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 8 Feb 2017 21:04:41 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        ldewangan@nvidia.com
Subject: [PATCH 5/7] staging: iio: isl29028: add copyright
Date: Wed,  8 Feb 2017 20:54:29 -0500
Message-Id: <20170209015431.17380-6-masneyb@onstation.org>
In-Reply-To: <20170209015431.17380-1-masneyb@onstation.org>
References: <20170209015431.17380-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add Brian Masney's copyright to the header for the several rounds of
staging cleanups that has been done to this driver.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29028.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index ddd604d..68b76b0 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -3,6 +3,7 @@
  * ISL29028 is Concurrent Ambient Light and Proximity Sensor
  *
  * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2016-2017 Brian Masney <masneyb@onstation.org>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
-- 
2.9.3

