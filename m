Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from box.matheina.com ([104.236.11.237]:43542 "EHLO box.matheina.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762491AbdADCAO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Jan 2017 21:00:14 -0500
From: Scott Matheina <scott@matheina.com>
To: linux-kernel@vger.kernel.org
Cc: Scott Matheina <scott@matheina.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH] staging:iio:addac Fixes Alignment should match open parenthesis
Date: Tue,  3 Jan 2017 19:50:24 -0600
Message-Id: <1483494633-6239-1-git-send-email-scott@matheina.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixes style issue where Alignment doesn't match open parenthesis

Signed-off-by: Scott Matheina <scott@matheina.com>
---
 drivers/staging/iio/addac/adt7316-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index 0ccf192..f66dd3e 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -93,7 +93,7 @@ static int adt7316_i2c_multi_write(void *client, u8 reg, u8 count, u8 *data)
  */
 
 static int adt7316_i2c_probe(struct i2c_client *client,
-		const struct i2c_device_id *id)
+			     const struct i2c_device_id *id)
 {
 	struct adt7316_bus bus = {
 		.client = client,
-- 
2.7.4

