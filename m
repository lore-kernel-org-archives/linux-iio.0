Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37365 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbdLACWL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Nov 2017 21:22:11 -0500
Received: by mail-pg0-f66.google.com with SMTP id y6so3848836pgp.4
        for <linux-iio@vger.kernel.org>; Thu, 30 Nov 2017 18:22:10 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: trivial@kernel.org, Daniel Axtens <dja@axtens.net>
Subject: [PATCH] iio: accel: kxsd9: add MODULE_LICENSE
Date: Fri,  1 Dec 2017 13:21:31 +1100
Message-Id: <20171201022131.26456-1-dja@axtens.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This fixes the following warning in an allmodconfig build:
WARNING: modpost: missing MODULE_LICENSE() in drivers/iio/accel/kxsd9-i2c.o

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/iio/accel/kxsd9-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
index 98fbb628d5bd..5e14262248b8 100644
--- a/drivers/iio/accel/kxsd9-i2c.c
+++ b/drivers/iio/accel/kxsd9-i2c.c
@@ -63,3 +63,5 @@ static struct i2c_driver kxsd9_i2c_driver = {
 	.id_table	= kxsd9_i2c_id,
 };
 module_i2c_driver(kxsd9_i2c_driver);
+
+MODULE_LICENSE("GPL v2");
-- 
2.11.0

