Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30685 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933639AbbHLIWb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 12 Aug 2015 04:22:31 -0400
From: sdliyong@gmail.com
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	cristina.opriceana@gmail.com, tolga.ceylan@gmail.com,
	k.kozlowski@samsung.com, sdliyong@gmail.com,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] staging: iio: hmc5843: Set iio name dynamically based on i2c name
Date: Wed, 12 Aug 2015 16:20:30 +0800
Message-Id: <1439367630-8964-1-git-send-email-sdliyong@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Yong Li <sdliyong@gmail.com>

Load the driver using the below command:
echo hmc5983 0x1e > /sys/bus/i2c/devices/i2c-?/new_device

In sysfs, the iio name is hmc5843, however the i2c name is hmc5983,
they are inconsistent.

With this patch, the iio name will be the same as the i2c device name

Signed-off-by: Yong Li <sdliyong@gmail.com>
---
 drivers/staging/iio/magnetometer/hmc5843_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/magnetometer/hmc5843_i2c.c b/drivers/staging/iio/magnetometer/hmc5843_i2c.c
index ff08667..3b03644 100644
--- a/drivers/staging/iio/magnetometer/hmc5843_i2c.c
+++ b/drivers/staging/iio/magnetometer/hmc5843_i2c.c
@@ -59,6 +59,7 @@ static const struct regmap_config hmc5843_i2c_regmap_config = {
 static int hmc5843_i2c_probe(struct i2c_client *cli,
 			     const struct i2c_device_id *id)
 {
+	cli->dev.driver->name = id->name;
 	return hmc5843_common_probe(&cli->dev,
 			devm_regmap_init_i2c(cli, &hmc5843_i2c_regmap_config),
 			id->driver_data);
-- 
2.1.0

