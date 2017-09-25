Return-Path: <SRS0=urO0=A2=gmail.com=harinath922@kernel.org>
From: Harinath Nampally <harinath922@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amsfield22@gmail.com,
	martink@posteo.de
Subject: [PATCH v3 2/3] iio: accel: mma8452: Rename time step look up struct to generic name as the values are same for all the events.
Date: Mon, 25 Sep 2017 06:40:07 -0400
Message-Id: <1506336008-4480-3-git-send-email-harinath922@gmail.com>
In-Reply-To: <1506336008-4480-1-git-send-email-harinath922@gmail.com>
References: <1506336008-4480-1-git-send-email-harinath922@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Improves code readability, no impact on functionality.

Signed-off-by: Harinath Nampally <harinath922@gmail.com>
---
 drivers/iio/accel/mma8452.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 3472e7e..74b6221 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -284,7 +284,7 @@ static const int mma8452_samp_freq[8][2] = {
 };
 
 /* Datasheet table: step time "Relationship with the ODR" (sample frequency) */
-static const unsigned int mma8452_transient_time_step_us[4][8] = {
+static const unsigned int mma8452_time_step_us[4][8] = {
 	{ 1250, 2500, 5000, 10000, 20000, 20000, 20000, 20000 },  /* normal */
 	{ 1250, 2500, 5000, 10000, 20000, 80000, 80000, 80000 },  /* l p l n */
 	{ 1250, 2500, 2500, 2500, 2500, 2500, 2500, 2500 },	  /* high res*/
@@ -826,7 +826,7 @@ static int mma8452_read_thresh(struct iio_dev *indio_dev,
 		if (power_mode < 0)
 			return power_mode;
 
-		us = ret * mma8452_transient_time_step_us[power_mode][
+		us = ret * mma8452_time_step_us[power_mode][
 				mma8452_get_odr_index(data)];
 		*val = us / USEC_PER_SEC;
 		*val2 = us % USEC_PER_SEC;
@@ -883,7 +883,7 @@ static int mma8452_write_thresh(struct iio_dev *indio_dev,
 			return ret;
 
 		steps = (val * USEC_PER_SEC + val2) /
-				mma8452_transient_time_step_us[ret][
+				mma8452_time_step_us[ret][
 					mma8452_get_odr_index(data)];
 
 		if (steps < 0 || steps > 0xff)
-- 
2.7.4
