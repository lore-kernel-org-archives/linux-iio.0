Return-Path: <ldewangan@nvidia.com>
From: Laxman Dewangan <ldewangan@nvidia.com>
To: gregkh@linuxfoundation.org, jic23@cam.ac.uk, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [RESEND PATCH V2] staging: iio: light: of: Fix vendor prefix of isl29018/isl29028
Date: Tue, 24 Apr 2012 11:41:38 +0530
Message-Id: <1335247898-31710-1-git-send-email-ldewangan@nvidia.com>
List-ID: <linux-iio@vger.kernel.org>

ISL29018/ISL29028 is from Intersil Corporation and making the
vendor prefix for this part as "isil" for OF compatibity.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
Changes from V1:
- Vendor prefix is now "isil"

As per Greg's request, resending this patch, removing 2/4 as this can
be go independently.

 drivers/staging/iio/light/isl29018.c |    2 +-
 drivers/staging/iio/light/isl29028.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 073e899..1ec2dac 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -596,7 +596,7 @@ static const struct i2c_device_id isl29018_id[] = {
 MODULE_DEVICE_TABLE(i2c, isl29018_id);
 
 static const struct of_device_id isl29018_of_match[] = {
-	{ .compatible = "invn,isl29018", },
+	{ .compatible = "isil,isl29018", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, isl29018_of_match);
diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index 4ac49aa..7057d9b 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -542,7 +542,7 @@ static const struct i2c_device_id isl29028_id[] = {
 MODULE_DEVICE_TABLE(i2c, isl29028_id);
 
 static const struct of_device_id isl29028_of_match[] = {
-	{ .compatible = "isl,isl29028", },
+	{ .compatible = "isil,isl29028", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, isl29028_of_match);
-- 
1.7.1.1
