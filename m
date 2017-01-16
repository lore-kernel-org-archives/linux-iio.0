Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36739 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbdAPFBO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2017 00:01:14 -0500
Date: Sun, 15 Jan 2017 21:01:10 -0800
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: daniel.baluta@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: bmi160: use variable names for sizeof() operator
Message-ID: <20170116050102.GA6310@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replace the types with the actual variable names when using the
sizeof() operator.  This is kernel preferred style as it protects
against future changes to variable type.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
 drivers/iio/imu/bmi160/bmi160_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 5355507..1e7c88b 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -338,9 +338,9 @@ static int bmi160_get_data(struct bmi160_data *data, int chan_type,
 	__le16 sample;
 	enum bmi160_sensor_type t = bmi160_to_sensor(chan_type);
 
-	reg = bmi160_regs[t].data + (axis - IIO_MOD_X) * sizeof(__le16);
+	reg = bmi160_regs[t].data + (axis - IIO_MOD_X) * sizeof(sample);
 
-	ret = regmap_bulk_read(data->regmap, reg, &sample, sizeof(__le16));
+	ret = regmap_bulk_read(data->regmap, reg, &sample, sizeof(sample));
 	if (ret < 0)
 		return ret;
 
@@ -405,8 +405,8 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
 
 	for_each_set_bit(i, indio_dev->active_scan_mask,
 			 indio_dev->masklength) {
-		ret = regmap_bulk_read(data->regmap, base + i * sizeof(__le16),
-				       &sample, sizeof(__le16));
+		ret = regmap_bulk_read(data->regmap, base + i * sizeof(sample),
+				       &sample, sizeof(sample));
 		if (ret < 0)
 			goto done;
 		buf[j++] = sample;
-- 
2.1.4

