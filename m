Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:53659 "EHLO
	TX2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab1D2LHx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Apr 2011 07:07:53 -0400
Received: from mail37-tx2 (localhost.localdomain [127.0.0.1])	by
 mail37-tx2-R.bigfish.com (Postfix) with ESMTP id 130ADE48463	for
 <linux-iio@vger.kernel.org>; Fri, 29 Apr 2011 11:07:52 +0000 (UTC)
Received: from TX2EHSMHS018.bigfish.com (unknown [10.9.14.243])	by
 mail37-tx2.bigfish.com (Postfix) with ESMTP id EBB77718055	for
 <linux-iio@vger.kernel.org>; Fri, 29 Apr 2011 11:07:51 +0000 (UTC)
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <drivers@analog.com>,
	<device-drivers-devel@blackfin.uclinux.org>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 4/6] IIO: GYRO: ADXRS450: enforce sequential transfer delay of at least 0.1ms
Date: Fri, 29 Apr 2011 12:58:39 +0200
Message-ID: <1304074721-18159-4-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1304074721-18159-1-git-send-email-michael.hennerich@analog.com>
References: <1304074721-18159-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/gyro/adxrs450_core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index 5671276..d73acff 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -116,6 +116,7 @@ static int adxrs450_spi_write_reg_16(struct device *dev,
 	if (ret)
 		dev_err(&st->us->dev, "problem while writing 16 bit register 0x%02x\n",
 				reg_address);
+	msleep(1); /* enforce sequential transfer delay 0.1ms */
 	mutex_unlock(&st->buf_lock);
 	return ret;
 }
-- 
1.6.0.2


