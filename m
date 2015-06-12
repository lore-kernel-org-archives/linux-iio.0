Return-Path: <vlad.dogaru@intel.com>
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: irina.tirdea@intel.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH 2/2] iio: magn: bmc150: add support for bmc156
Date: Fri, 12 Jun 2015 11:31:39 +0300
Message-Id: <1434097899-13984-3-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1434097899-13984-1-git-send-email-vlad.dogaru@intel.com>
References: <1434097899-13984-1-git-send-email-vlad.dogaru@intel.com>
List-ID: <linux-iio@vger.kernel.org>

The BMC156 is a slightly less capable version of BMC150 which lacks
support for magnetometer thresholds.  Since this driver does not support
those anyway, adding support is trivial.

Datasheet is available at
https://ae-bst.resource.bosch.com/media/products/dokumente/bmc156_1/BST-BMC156-DS000-01.pdf

Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
---
 drivers/iio/magnetometer/bmc150_magn.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index a0e64f1..cd00271 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -1089,12 +1089,14 @@ static const struct dev_pm_ops bmc150_magn_pm_ops = {
 
 static const struct acpi_device_id bmc150_magn_acpi_match[] = {
 	{"BMC150B", 0},
+	{"BMC156B", 0},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, bmc150_magn_acpi_match);
 
 static const struct i2c_device_id bmc150_magn_id[] = {
 	{"bmc150_magn", 0},
+	{"bmc156_magn", 0},
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, bmc150_magn_id);
-- 
1.9.1
