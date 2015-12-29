Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34402 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbbL2Loj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Dec 2015 06:44:39 -0500
Received: by mail-pf0-f195.google.com with SMTP id 65so8324117pff.1
        for <linux-iio@vger.kernel.org>; Tue, 29 Dec 2015 03:44:39 -0800 (PST)
From: Shraddha Barke <shraddha.6596@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Shraddha Barke <shraddha.6596@gmail.com>
Subject: [PATCH 5/5] Staging: iio: cdc: ad7150: Fix alignment should match open parenthesis
Date: Tue, 29 Dec 2015 16:57:31 +0530
Message-Id: <1451388451-10342-6-git-send-email-shraddha.6596@gmail.com>
In-Reply-To: <1451388451-10342-1-git-send-email-shraddha.6596@gmail.com>
References: <1451388451-10342-1-git-send-email-shraddha.6596@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix the checkpatch warning of alignment should match open
parenthesis.

Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
---
 drivers/staging/iio/cdc/ad7150.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 0b934f7..f6b9a10 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -160,8 +160,9 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev,
 
 /* lock should be held */
 static int ad7150_write_event_params(struct iio_dev *indio_dev,
-	 unsigned int chan, enum iio_event_type type,
-	 enum iio_event_direction dir)
+				     unsigned int chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
 {
 	int ret;
 	u16 value;
@@ -209,8 +210,9 @@ static int ad7150_write_event_params(struct iio_dev *indio_dev,
 }
 
 static int ad7150_write_event_config(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, enum iio_event_type type,
-	enum iio_event_direction dir, int state)
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir, int state)
 {
 	u8 thresh_type, cfg, adaptive;
 	int ret;
@@ -302,11 +304,11 @@ static int ad7150_read_event_value(struct iio_dev *indio_dev,
 }
 
 static int ad7150_write_event_value(struct iio_dev *indio_dev,
-				   const struct iio_chan_spec *chan,
-				   enum iio_event_type type,
-				   enum iio_event_direction dir,
-				   enum iio_event_info info,
-				   int val, int val2)
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int val, int val2)
 {
 	int ret;
 	struct ad7150_chip_info *chip = iio_priv(indio_dev);
@@ -365,9 +367,9 @@ static ssize_t ad7150_show_timeout(struct device *dev,
 }
 
 static ssize_t ad7150_store_timeout(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				    struct device_attribute *attr,
+				    const char *buf,
+				    size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7150_chip_info *chip = iio_priv(indio_dev);
@@ -580,7 +582,7 @@ static const struct iio_info ad7150_info = {
  */
 
 static int ad7150_probe(struct i2c_client *client,
-		const struct i2c_device_id *id)
+			const struct i2c_device_id *id)
 {
 	int ret;
 	struct ad7150_chip_info *chip;
-- 
2.1.4

