Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 06/12] staging:iio:addac:adt7316 make interrupt mask sane.
Date: Fri, 12 Aug 2011 16:55:32 +0100
Message-Id: <1313164538-1769-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313164538-1769-1-git-send-email-jic23@cam.ac.uk>
References: <1313164538-1769-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Coccinelle found this one. I'm not certain what
the intent is, but this fix makes no functional changes.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/addac/adt7316.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 637316f..c828b6f 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -203,7 +203,7 @@ struct adt7316_chip_info {
 #define ADT7316_TEMP_INT_MASK		0x1F
 #define ADT7516_AIN_INT_MASK		0xE0
 #define ADT7316_TEMP_AIN_INT_MASK	\
-	(ADT7316_TEMP_INT_MASK | ADT7316_TEMP_INT_MASK)
+	(ADT7316_TEMP_INT_MASK)
 
 /*
  * struct adt7316_chip_info - chip specifc information
-- 
1.7.3.4
