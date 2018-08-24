Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33114 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeHYAAu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Aug 2018 20:00:50 -0400
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] iio: dac: ti-dac5571: provide of_match_table to driver
Date: Fri, 24 Aug 2018 22:24:59 +0200
Message-Id: <20180824202459.21855-1-marcus.folkesson@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the created list of of_device_id's as a match table.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/dac/ti-dac5571.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
index e39d1e901353..f6dcd8bce2b0 100644
--- a/drivers/iio/dac/ti-dac5571.c
+++ b/drivers/iio/dac/ti-dac5571.c
@@ -421,6 +421,7 @@ MODULE_DEVICE_TABLE(i2c, dac5571_id);
 static struct i2c_driver dac5571_driver = {
 	.driver = {
 		   .name = "ti-dac5571",
+		   .of_match_table = of_match_ptr(dac5571_of_id),
 	},
 	.probe	  = dac5571_probe,
 	.remove   = dac5571_remove,
-- 
2.18.0
