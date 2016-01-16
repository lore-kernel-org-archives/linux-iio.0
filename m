Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:54062 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752147AbcAPOgm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 16 Jan 2016 09:36:42 -0500
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id E500A20ABA
	for <linux-iio@vger.kernel.org>; Sat, 16 Jan 2016 15:36:40 +0100 (CET)
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, christoph.muellner@theobroma-systems.com,
	mfuzzey@parkeon.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Martin Kepplinger <martink@posteo.de>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: [PATCH 2/3] iio: mma8452: whitespace cleanup
Date: Sat, 16 Jan 2016 15:35:21 +0100
Message-Id: <1452954922-2266-3-git-send-email-martink@posteo.de>
In-Reply-To: <1452954922-2266-1-git-send-email-martink@posteo.de>
References: <1452954922-2266-1-git-send-email-martink@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 drivers/iio/accel/mma8452.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 77b71c2..843169e 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -85,8 +85,8 @@
 #define  MMA8452_INT_FF_MT			BIT(2)
 #define  MMA8452_INT_TRANS			BIT(5)
 
-#define  MMA8452_DEVICE_ID			0x2a
-#define  MMA8453_DEVICE_ID			0x3a
+#define MMA8452_DEVICE_ID			0x2a
+#define MMA8453_DEVICE_ID			0x3a
 #define MMA8652_DEVICE_ID			0x4a
 #define MMA8653_DEVICE_ID			0x5a
 
-- 
2.1.4

