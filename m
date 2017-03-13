Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:37193
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752183AbdCMUAm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 16:00:42 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
        Martin Klepplinger <martink@posteo.de>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Constantin Musca <constantin.musca@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 16/17] iio: accel: mma7660: Add OF device ID table
Date: Mon, 13 Mar 2017 16:59:16 -0300
Message-Id: <20170313195917.12190-17-javier@osg.samsung.com>
In-Reply-To: <20170313195917.12190-1-javier@osg.samsung.com>
References: <20170313195917.12190-1-javier@osg.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/iio/accel/mma7660.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
index 3a40774cca74..a53469f7bbab 100644
--- a/drivers/iio/accel/mma7660.c
+++ b/drivers/iio/accel/mma7660.c
@@ -253,6 +253,12 @@ static const struct i2c_device_id mma7660_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, mma7660_i2c_id);
 
+static const struct of_device_id mma7660_of_match[] = {
+	{ .compatible = "fsl,mma7660" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mma7660_of_match);
+
 static const struct acpi_device_id mma7660_acpi_id[] = {
 	{"MMA7660", 0},
 	{}
@@ -264,6 +270,7 @@ static struct i2c_driver mma7660_driver = {
 	.driver = {
 		.name = "mma7660",
 		.pm = MMA7660_PM_OPS,
+		.of_match_table = of_match_ptr(mma7660_of_match),
 		.acpi_match_table = ACPI_PTR(mma7660_acpi_id),
 	},
 	.probe		= mma7660_probe,
-- 
2.9.3

