Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36665 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeIBAHb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Sep 2018 20:07:31 -0400
From: Tomasz Duszynski <tduszyns@gmail.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: bh1750: switch to SPDX identifier
Date: Sat,  1 Sep 2018 21:51:44 +0200
Message-Id: <20180901195144.11389-1-tduszyns@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Drop boilerplate license text and use SPDX identifier instead.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 drivers/iio/light/bh1750.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
index a814828e69f5..493ca7420602 100644
--- a/drivers/iio/light/bh1750.c
+++ b/drivers/iio/light/bh1750.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ROHM BH1710/BH1715/BH1721/BH1750/BH1751 ambient light sensor driver
  *
  * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Data sheets:
  *  http://rohmfs.rohm.com/en/products/databook/datasheet/ic/sensor/light/bh1710fvc-e.pdf
  *  http://rohmfs.rohm.com/en/products/databook/datasheet/ic/sensor/light/bh1715fvc-e.pdf
-- 
2.18.0
