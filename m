Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:37146
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754023AbdCMUAX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 16:00:23 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 11/17] iio: dac: max5821: Set .of_match_table to OF device ID table
Date: Mon, 13 Mar 2017 16:59:11 -0300
Message-Id: <20170313195917.12190-12-javier@osg.samsung.com>
In-Reply-To: <20170313195917.12190-1-javier@osg.samsung.com>
References: <20170313195917.12190-1-javier@osg.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The driver has a OF device ID table but the struct i2c_driver
.of_match_table field is not set.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/iio/dac/max5821.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
index 86e9e112f554..6bc1835b899d 100644
--- a/drivers/iio/dac/max5821.c
+++ b/drivers/iio/dac/max5821.c
@@ -392,6 +392,7 @@ MODULE_DEVICE_TABLE(of, max5821_of_match);
 static struct i2c_driver max5821_driver = {
 	.driver = {
 		.name	= "max5821",
+		.of_match_table = of_match_ptr(max5821_of_match),
 		.pm     = MAX5821_PM_OPS,
 	},
 	.probe		= max5821_probe,
-- 
2.9.3

