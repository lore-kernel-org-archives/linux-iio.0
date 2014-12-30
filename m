Return-Path: <roberta.dobrescu@gmail.com>
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: octavian.purdila@intel.com,
	daniel.baluta@intel.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH v2] iio: frequency: ad9523: Increase sleep time in ad9523_store_eeprom
Date: Tue, 30 Dec 2014 20:44:34 +0200
Message-Id: <1419965074-3929-1-git-send-email-roberta.dobrescu@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch increases sleep time in ad9523_store_eeprom to 20ms since
it isn't timing critical. It fixes the following checkpatch.pl warning:
WARNING: msleep < 20ms can sleep for up to 20ms

Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
---
Changes since v1:
	* Increase sleep time in msleep instead of using usleep_range
	* Change subject and commit message accordingly

 drivers/iio/frequency/ad9523.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 7c5245d..50ed8d1 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -445,7 +445,7 @@ static int ad9523_store_eeprom(struct iio_dev *indio_dev)
 
 	tmp = 4;
 	do {
-		msleep(16);
+		msleep(20);
 		ret = ad9523_read(indio_dev,
 				  AD9523_EEPROM_DATA_XFER_STATUS);
 		if (ret < 0)
-- 
1.9.1
