Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751044AbcIKQ3a (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Sep 2016 12:29:30 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] iio: accel: mma7660: fix missing MODULE_DEVICE_TABLE(i2c)
Date: Sun, 11 Sep 2016 18:29:26 +0200
Message-Id: <20160911162926.22538-1-hdegoede@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add missing MODULE_DEVICE_TABLE(i2c) this fixes autoloading on
devicetree using systems.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/mma7660.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
index 0acdee5..03beadf 100644
--- a/drivers/iio/accel/mma7660.c
+++ b/drivers/iio/accel/mma7660.c
@@ -251,6 +251,7 @@ static const struct i2c_device_id mma7660_i2c_id[] = {
 	{"mma7660", 0},
 	{}
 };
+MODULE_DEVICE_TABLE(i2c, mma7660_i2c_id);
 
 static const struct acpi_device_id mma7660_acpi_id[] = {
 	{"MMA7660", 0},
-- 
2.9.3

