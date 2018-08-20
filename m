Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr10137.outbound.protection.outlook.com ([40.107.1.137]:53184
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbeHTNQy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Aug 2018 09:16:54 -0400
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH 3/5] iio: envelope-detector: switch to SPDX license identifier
Date: Mon, 20 Aug 2018 12:01:12 +0200
Message-Id: <20180820100114.22966-4-peda@axentia.se>
In-Reply-To: <20180820100114.22966-1-peda@axentia.se>
References: <20180820100114.22966-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Drop the boilerplate license text.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/adc/envelope-detector.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/envelope-detector.c b/drivers/iio/adc/envelope-detector.c
index 4ebda8ab54fe..2f2b563c1162 100644
--- a/drivers/iio/adc/envelope-detector.c
+++ b/drivers/iio/adc/envelope-detector.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for an envelope detector using a DAC and a comparator
  *
  * Copyright (C) 2016 Axentia Technologies AB
  *
  * Author: Peter Rosin <peda@axentia.se>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 /*
-- 
2.11.0
