Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 02/67] iio:adc:max1363 move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:16:19 +0000
Message-Id: <1362241044-3534-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/max1363.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 6c1cfb7..9e6da72 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -427,15 +427,15 @@ static const enum max1363_modes max1363_mode_list[] = {
 #define MAX1363_EV_M						\
 	(IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING)	\
 	 | IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING))
-#define MAX1363_INFO_MASK (IIO_CHAN_INFO_RAW_SEPARATE_BIT |	\
-			   IIO_CHAN_INFO_SCALE_SHARED_BIT)
+
 #define MAX1363_CHAN_U(num, addr, si, bits, evmask)			\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.indexed = 1,						\
 		.channel = num,						\
 		.address = addr,					\
-		.info_mask = MAX1363_INFO_MASK,				\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
 		.datasheet_name = "AIN"#num,				\
 		.scan_type = {						\
 			.sign = 'u',					\
@@ -456,7 +456,8 @@ static const enum max1363_modes max1363_mode_list[] = {
 		.channel = num,						\
 		.channel2 = num2,					\
 		.address = addr,					\
-		.info_mask = MAX1363_INFO_MASK,				\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
 		.datasheet_name = "AIN"#num"-AIN"#num2,			\
 		.scan_type = {						\
 			.sign = 's',					\
-- 
1.8.1.4
