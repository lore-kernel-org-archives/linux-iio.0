Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:43396 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522AbbKKSjY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 11 Nov 2015 13:39:24 -0500
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 2DC1120AFB
	for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2015 19:39:22 +0100 (CET)
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, christoph.muellner@theobroma-systems.com,
	mfuzzey@parkeon.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Martin Kepplinger <martink@posteo.de>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: [PATCH 3/3] iio: mma8452: remove unused register description
Date: Wed, 11 Nov 2015 19:38:14 +0100
Message-Id: <1447267094-2248-3-git-send-email-martink@posteo.de>
In-Reply-To: <1447267094-2248-1-git-send-email-martink@posteo.de>
References: <1447267094-2248-1-git-send-email-martink@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 drivers/iio/accel/mma8452.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 38652e1..eb2b2c2 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -58,7 +58,6 @@
 #define MMA8452_FF_MT_COUNT			0x18
 #define MMA8452_TRANSIENT_CFG			0x1d
 #define  MMA8452_TRANSIENT_CFG_HPF_BYP		BIT(0)
-#define  MMA8452_TRANSIENT_CFG_CHAN(chan)	BIT(chan + 1)
 #define  MMA8452_TRANSIENT_CFG_ELE		BIT(4)
 #define MMA8452_TRANSIENT_SRC			0x1e
 #define  MMA8452_TRANSIENT_SRC_XTRANSE		BIT(1)
-- 
2.1.4

