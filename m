Return-Path: <roberta.dobrescu@gmail.com>
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: octavian.purdila@intel.com,
	daniel.baluta@intel.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH] iio: industrialio-event: Fix typo 's/dynically/dynamically/'
Date: Fri, 16 Jan 2015 00:24:14 +0200
Message-Id: <1421360654-1390-1-git-send-email-roberta.dobrescu@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
---
 drivers/iio/industrialio-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 0c1e37e..db0cc4f 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -404,7 +404,7 @@ static inline int __iio_add_event_config_attrs(struct iio_dev *indio_dev)
 {
 	int j, ret, attrcount = 0;
 
-	/* Dynically created from the channels array */
+	/* Dynamically created from the channels array */
 	for (j = 0; j < indio_dev->num_channels; j++) {
 		ret = iio_device_add_event_sysfs(indio_dev,
 						 &indio_dev->channels[j]);
-- 
1.9.1
