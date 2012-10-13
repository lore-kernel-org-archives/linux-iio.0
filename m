Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 5/7] staging:iio:adc:max1363 white space cleanup
Date: Sat, 13 Oct 2012 10:34:49 +0100
Message-Id: <1350120891-28593-6-git-send-email-jic23@kernel.org>
In-Reply-To: <1350120891-28593-1-git-send-email-jic23@kernel.org>
References: <1350120891-28593-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/max1363.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363.c b/drivers/staging/iio/adc/max1363.c
index 3217753..2f8d433 100644
--- a/drivers/staging/iio/adc/max1363.c
+++ b/drivers/staging/iio/adc/max1363.c
@@ -765,9 +765,9 @@ static int max1363_read_event_config(struct iio_dev *indio_dev,
 				     u64 event_code)
 {
 	struct max1363_state *st = iio_priv(indio_dev);
-
 	int val;
 	int number = IIO_EVENT_CODE_EXTRACT_CHAN(event_code);
+
 	mutex_lock(&indio_dev->mlock);
 	if (IIO_EVENT_CODE_EXTRACT_DIR(event_code) == IIO_EV_DIR_FALLING)
 		val = (1 << number) & st->mask_low;
@@ -969,8 +969,6 @@ static struct attribute_group max1363_event_attribute_group = {
 	.name = "events",
 };
 
-#define MAX1363_EVENT_FUNCS						\
-
 static int max1363_update_scan_mode(struct iio_dev *indio_dev,
 				    const unsigned long *scan_mask)
 {
@@ -1388,8 +1386,6 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 	},
 };
 
-
-
 static int max1363_initial_setup(struct max1363_state *st)
 {
 	st->setupbyte = MAX1363_SETUP_AIN3_IS_AIN3_REF_IS_VDD
-- 
1.7.12.2
