Return-Path: <masneyb@onstation.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Subject: [PATCH v2 5/8] staging: iio: isl29018: remove blank line for consistency
Date: Mon, 10 Oct 2016 03:19:59 -0400
Message-Id: <1476084002-29683-6-git-send-email-masneyb@onstation.org>
In-Reply-To: <1476084002-29683-1-git-send-email-masneyb@onstation.org>
References: <1476084002-29683-1-git-send-email-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

Remove blank line between MODULE_DEVICE_TABLE() and its corresponding
structure for consistency with the other device table entries.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29018.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 6b6c761..917dd8b 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -821,7 +821,6 @@ static const struct i2c_device_id isl29018_id[] = {
 	{"isl29035", isl29035},
 	{}
 };
-
 MODULE_DEVICE_TABLE(i2c, isl29018_id);
 
 static const struct of_device_id isl29018_of_match[] = {
-- 
2.5.5
