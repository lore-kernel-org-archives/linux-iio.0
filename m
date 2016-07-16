Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35095 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbcGPC2t (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jul 2016 22:28:49 -0400
Date: Fri, 15 Jul 2016 19:28:47 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: ldewangan@nvidia.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: light: isl29018/28: remove I2C_CLASS_HWMON
 .class setting
Message-ID: <20160716022831.GA7636@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I2C_CLASS_HWMON is for a hardware monitoring chip wanting
auto-detection.  IIO drivers don't typically use .class. 
Remove it.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---
 drivers/staging/iio/light/isl29018.c | 1 -
 drivers/staging/iio/light/isl29028.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 80b6a9e..f47a17d 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -823,7 +823,6 @@ static const struct of_device_id isl29018_of_match[] = {
 MODULE_DEVICE_TABLE(of, isl29018_of_match);
 
 static struct i2c_driver isl29018_driver = {
-	.class	= I2C_CLASS_HWMON,
 	.driver	 = {
 			.name = "isl29018",
 			.acpi_match_table = ACPI_PTR(isl29018_acpi_match),
diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index a238b16..aa413e5 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -546,7 +546,6 @@ static const struct of_device_id isl29028_of_match[] = {
 MODULE_DEVICE_TABLE(of, isl29028_of_match);
 
 static struct i2c_driver isl29028_driver = {
-	.class	= I2C_CLASS_HWMON,
 	.driver  = {
 		.name = "isl29028",
 		.of_match_table = isl29028_of_match,
-- 
2.1.4

