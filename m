Return-Path: <masneyb@onstation.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Subject: [PATCH v2 4/8] staging: iio: isl29018: combine two return statements into one
Date: Mon, 10 Oct 2016 03:19:58 -0400
Message-Id: <1476084002-29683-5-git-send-email-masneyb@onstation.org>
In-Reply-To: <1476084002-29683-1-git-send-email-masneyb@onstation.org>
References: <1476084002-29683-1-git-send-email-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

Use the return value from isl29018_set_integration_time() as the return
value for isl29018_chip_init() since this is the last piece of work
inside that function.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29018.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 132de8e..6b6c761 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -616,12 +616,10 @@ static int isl29018_chip_init(struct isl29018_chip *chip)
 
 	status = isl29018_set_integration_time(chip,
 			isl29018_int_utimes[chip->type][chip->int_time]);
-	if (status < 0) {
+	if (status < 0)
 		dev_err(dev, "Init of isl29018 fails\n");
-		return status;
-	}
 
-	return 0;
+	return status;
 }
 
 static const struct iio_info isl29018_info = {
-- 
2.5.5
