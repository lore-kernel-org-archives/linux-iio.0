Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:50664 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755124AbcKJJ0Z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Nov 2016 04:26:25 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v3 12/28] staging: iio: tsl2583: fix comparison between signed and unsigned integers
Date: Thu, 10 Nov 2016 04:25:48 -0500
Message-Id: <1478769964-7065-13-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
References: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixed warning found by make W=2:

warning: comparison between signed and unsigned integer expressions
[-Wsign-compare]

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index d482a84..be3cbae 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -510,7 +510,7 @@ static ssize_t in_illuminance_lux_table_show(struct device *dev,
 					     struct device_attribute *attr,
 					     char *buf)
 {
-	int i;
+	unsigned int i;
 	int offset = 0;
 
 	for (i = 0; i < ARRAY_SIZE(tsl2583_device_lux); i++) {
@@ -541,7 +541,8 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	int value[ARRAY_SIZE(tsl2583_device_lux) * 3 + 1];
-	int n, ret = -EINVAL;
+	int ret = -EINVAL;
+	unsigned int n;
 
 	mutex_lock(&chip->als_mutex);
 
@@ -719,7 +720,7 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
 		break;
 	case IIO_CHAN_INFO_CALIBSCALE:
 		if (chan->type == IIO_LIGHT) {
-			int i;
+			unsigned int i;
 
 			for (i = 0; i < ARRAY_SIZE(gainadj); i++) {
 				if (gainadj[i].mean == val) {
-- 
2.7.4

