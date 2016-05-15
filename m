Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34250 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbcEOSha (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 May 2016 14:37:30 -0400
Date: Sun, 15 May 2016 11:37:27 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, mranostay@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: jsa1212: remove unneeded i2c check functionality
 test
Message-ID: <20160515183717.GA2674@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This driver does not call i2c_smbus_read|write_byte_data(),
so remove the corresponding functionality test. It uses regmap
to handle byte transfers transparently.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
Found & fixed by inspection based on same defect recently fixed
in light/tpl0102 driver.


 drivers/iio/light/jsa1212.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/light/jsa1212.c b/drivers/iio/light/jsa1212.c
index 99a6281..e8a8931 100644
--- a/drivers/iio/light/jsa1212.c
+++ b/drivers/iio/light/jsa1212.c
@@ -325,9 +325,6 @@ static int jsa1212_probe(struct i2c_client *client,
 	struct regmap *regmap;
 	int ret;
 
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
-		return -EOPNOTSUPP;
-
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
-- 
2.1.4

