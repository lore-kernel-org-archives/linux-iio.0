Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:49603 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754963AbcCNL3Q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 14 Mar 2016 07:29:16 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 7059D20996
	for <linux-iio@vger.kernel.org>; Mon, 14 Mar 2016 12:29:11 +0100 (CET)
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Martin Kepplinger <martink@posteo.de>
Subject: [PATCH 1/2] iio: mma8452: add i2c_device_id for mma8451
Date: Mon, 14 Mar 2016 12:26:28 +0100
Message-Id: <1457954789-4885-1-git-send-email-martink@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This was forgotten about and is added for consistency now

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 drivers/iio/accel/mma8452.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 305ed0e..d0eeba0 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1535,6 +1535,7 @@ static const struct dev_pm_ops mma8452_pm_ops = {
 };
 
 static const struct i2c_device_id mma8452_id[] = {
+	{ "mma8451", mma8452 },
 	{ "mma8452", mma8452 },
 	{ "mma8453", mma8453 },
 	{ "mma8652", mma8652 },
-- 
2.1.4

