Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:58096 "EHLO
	TX2EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427Ab1D2LHw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Apr 2011 07:07:52 -0400
Received: from mail61-tx2 (localhost.localdomain [127.0.0.1])	by
 mail61-tx2-R.bigfish.com (Postfix) with ESMTP id 900908A8388	for
 <linux-iio@vger.kernel.org>; Fri, 29 Apr 2011 11:07:51 +0000 (UTC)
Received: from TX2EHSMHS018.bigfish.com (unknown [10.9.14.248])	by
 mail61-tx2.bigfish.com (Postfix) with ESMTP id 6F94B123804F	for
 <linux-iio@vger.kernel.org>; Fri, 29 Apr 2011 11:07:51 +0000 (UTC)
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <drivers@analog.com>,
	<device-drivers-devel@blackfin.uclinux.org>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 3/6] IIO: GYRO: ADXRS450: Add missing parity bit generation
Date: Fri, 29 Apr 2011 12:58:38 +0200
Message-ID: <1304074721-18159-3-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1304074721-18159-1-git-send-email-michael.hennerich@analog.com>
References: <1304074721-18159-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Add missing parity bit generation. Failure to add the parity bit
caused half of the register accesses to fail.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/gyro/adxrs450_core.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index c02e3ef..5671276 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -59,6 +59,9 @@ static int adxrs450_spi_read_reg_16(struct device *dev,
 	st->tx[2] = 0;
 	st->tx[3] = 0;
 
+	if (!(hweight32(be32_to_cpu(*(u32 *)st->tx)) & 1))
+		st->tx[3]  |= ADXRS450_P;
+
 	spi_message_init(&msg);
 	spi_message_add_tail(&xfers[0], &msg);
 	spi_message_add_tail(&xfers[1], &msg);
@@ -103,6 +106,10 @@ static int adxrs450_spi_write_reg_16(struct device *dev,
 	st->tx[1] = reg_address << 1 | val >> 15;
 	st->tx[2] = val >> 7;
 	st->tx[3] = val << 1;
+
+	if (!(hweight32(be32_to_cpu(*(u32 *)st->tx)) & 1))
+		st->tx[3]  |= ADXRS450_P;
+
 	spi_message_init(&msg);
 	spi_message_add_tail(&xfers, &msg);
 	ret = spi_sync(st->us, &msg);
-- 
1.6.0.2


