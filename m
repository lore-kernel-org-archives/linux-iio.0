Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:59891 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752137AbbFELBa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 5 Jun 2015 07:01:30 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org, pmeerw@pmeerw.net
Cc: daniel.baluta@intel.com, knaack.h@gmx.de, lars@metafoo.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v2 1/6] iio: magnetometer: mmc35240: i2c device name should be lower case
Date: Fri,  5 Jun 2015 14:03:10 +0300
Message-Id: <1433502195-30296-2-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1433502195-30296-1-git-send-email-daniel.baluta@intel.com>
References: <1433502195-30296-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is the standard convention for i2c device name and
also this is the name used in some Intel platforms DT
files.

Fixes: abeb6b1e7b ("iio: magnetometer: Add support for MEMSIC MMC35240")
Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/magnetometer/mmc35240.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index aa6e25d..417eca1 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -490,7 +490,7 @@ static const struct acpi_device_id mmc35240_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, mmc35240_acpi_match);
 
 static const struct i2c_device_id mmc35240_id[] = {
-	{"MMC35240", 0},
+	{"mmc35240", 0},
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, mmc35240_id);
-- 
1.9.1

