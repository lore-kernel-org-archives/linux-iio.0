Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr680078.outbound.protection.outlook.com ([40.107.68.78]:35068
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726021AbeHTSMA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Aug 2018 14:12:00 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 1/3] iio: adxl372: Provide validate_trigger and validate_device callbacks
Date: Mon, 20 Aug 2018 17:53:43 +0300
Message-ID: <1534776823-18703-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch provides a validate_device callback for the trigger which makes
sure that other devices are rejected.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/accel/adxl372.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index d2fdc75..5a039ba 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -762,11 +762,24 @@ static int adxl372_dready_trig_set_state(struct iio_trigger *trig,
 	return adxl372_set_interrupts(st, mask, 0);
 }
 
+static int adxl372_validate_trigger(struct iio_dev *indio_dev,
+				    struct iio_trigger *trig)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+
+	if (st->dready_trig != trig)
+		return -EINVAL;
+
+	return 0;
+}
+
 static const struct iio_trigger_ops adxl372_trigger_ops = {
+	.validate_device = &iio_trigger_validate_own_device,
 	.set_trigger_state = adxl372_dready_trig_set_state,
 };
 
 static const struct iio_info adxl372_info = {
+	.validate_trigger = &adxl372_validate_trigger,
 	.read_raw = adxl372_read_raw,
 	.debugfs_reg_access = &adxl372_reg_access,
 	.hwfifo_set_watermark = adxl372_set_watermark,
-- 
2.7.4
