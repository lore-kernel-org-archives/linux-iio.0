Return-Path: <roberta.dobrescu@gmail.com>
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	daniel.baluta@intel.com,
	dan.carpenter@oracle.com,
	kbuild@01.org,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH] staging: iio: light: isl29018: Add missing mutex_unlock on error path
Date: Tue, 28 Apr 2015 20:09:27 +0300
Message-Id: <1430240967-2459-1-git-send-email-roberta.dobrescu@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch fixes the following warning:

drivers/staging/iio/light/isl29018.c:386 isl29018_write_raw() warn:
inconsistent returns 'mutex:&chip->lock'.
 Locked on:   line 374
 Unlocked on: line 386

Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/staging/iio/light/isl29018.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 435d417..08ca9a4 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -370,8 +370,10 @@ static int isl29018_write_raw(struct iio_dev *indio_dev,
 		break;
 	case IIO_CHAN_INFO_INT_TIME:
 		if (chan->type == IIO_LIGHT)
-			if (val != 0)
+			if (val != 0) {
+				mutex_unlock(&chip->lock);
 				return -EINVAL;
+			}
 			ret = isl29018_set_integration_time(chip, val2);
 		break;
 	case IIO_CHAN_INFO_SCALE:
-- 
1.9.1
