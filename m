Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752147AbcIDRfj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Sep 2016 13:35:39 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Teodora Baluta <teodora.baluta@intel.com>
Cc: linux-iio@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] iio: accel: mxc6255 add support for the mxc6225
Date: Sun,  4 Sep 2016 19:35:32 +0200
Message-Id: <20160904173532.18994-1-hdegoede@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The mxc6225 is fully compatible with the existing mxc6255 driver,
add support for it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/mxc6255.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mxc6255.c b/drivers/iio/accel/mxc6255.c
index 97ccde7..50343a7 100644
--- a/drivers/iio/accel/mxc6255.c
+++ b/drivers/iio/accel/mxc6255.c
@@ -26,6 +26,7 @@
 #define MXC6255_REG_YOUT		0x01
 #define MXC6255_REG_CHIP_ID		0x08
 
+#define MXC6225_CHIP_ID			0xe5
 #define MXC6255_CHIP_ID			0x05
 
 /*
@@ -154,7 +155,11 @@ static int mxc6255_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	if (chip_id != MXC6255_CHIP_ID) {
+	switch (chip_id) {
+	case MXC6225_CHIP_ID:
+	case MXC6255_CHIP_ID:
+		break;
+	default:
 		dev_err(&client->dev, "Invalid chip id %x\n", chip_id);
 		return -ENODEV;
 	}
@@ -171,12 +176,14 @@ static int mxc6255_probe(struct i2c_client *client,
 }
 
 static const struct acpi_device_id mxc6255_acpi_match[] = {
+	{"MXC6225",	0},
 	{"MXC6255",	0},
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, mxc6255_acpi_match);
 
 static const struct i2c_device_id mxc6255_id[] = {
+	{"mxc6225",	0},
 	{"mxc6255",	0},
 	{ }
 };
-- 
2.9.3

