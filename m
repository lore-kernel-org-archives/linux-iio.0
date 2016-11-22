Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mxout012.mail.hostpoint.ch ([217.26.49.172]:64087 "EHLO
        mxout012.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754446AbcKVA61 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Nov 2016 19:58:27 -0500
From: Reto Schneider <reto@reto-schneider.ch>
Subject: [PATCH 2/2] iio: adis16203: Fix copyright year
To: linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, linux-iio@vger.kernel.org
Message-ID: <c828757d-55c2-7f28-c38a-1b20b733a408@reto-schneider.ch>
Date: Tue, 22 Nov 2016 01:42:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Reto Schneider <code@reto-schneider.ch>
Date: Mon, 12 Oct 2015 01:44:51 +0200
Subject: [PATCH 2/2] iio: adis16203: Fix copyright year

The copyright year can not be in the future.

Signed-off-by: Reto Schneider <code@reto-schneider.ch>
---
 drivers/staging/iio/accel/adis16203_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index f32c900..bd8119a 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -1,7 +1,7 @@
 /*
  * ADIS16203 Programmable 360 Degrees Inclinometer
  *
- * Copyright 2030 Analog Devices Inc.
+ * Copyright 2010 Analog Devices Inc.
  *
  * Licensed under the GPL-2 or later.
  */
-- 
2.10.2
