Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:59643 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab3ALKfh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Jan 2013 05:35:37 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: jbrenner@taosinc.com, amit.kucheria@verdurent.com,
	pmeerw@pmeerw.net, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 4/5] staging:iio:tsl2563 drop pointless forward declaration
Date: Sat, 12 Jan 2013 10:35:23 +0000
Message-Id: <1357986924-11471-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1357986924-11471-1-git-send-email-jic23@kernel.org>
References: <1357986924-11471-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/light/tsl2563.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 1a3092a..b91d9bb 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -677,8 +677,6 @@ static int tsl2563_read_interrupt_config(struct iio_dev *indio_dev,
 	return !!(ret & 0x30);
 }
 
-static struct i2c_driver tsl2563_i2c_driver;
-
 static const struct iio_info tsl2563_info_no_irq = {
 	.driver_module = THIS_MODULE,
 	.read_raw = &tsl2563_read_raw,
-- 
1.8.1

