Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:33517 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744AbcFAT0D (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 1 Jun 2016 15:26:03 -0400
From: Luis de Bethencourt <luisbg@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: [PATCH v2] staging: iio: ad5933: fix order of cycle conditions
Date: Wed,  1 Jun 2016 20:25:54 +0100
Message-Id: <1464809154-14868-1-git-send-email-luisbg@osg.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Correctly handle the settling time cycles value. The else branch is an
impossible condition, > 1022 in the else branch of > 511. Flipping the order.

Based on the Table 13 at the bottom of Page 25 of the Data Sheet:
http://www.analog.com/media/en/technical-documentation/data-sheets/AD5933.pdf

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 9f43976..170ac98 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -444,10 +444,10 @@ static ssize_t ad5933_store(struct device *dev,
 		st->settling_cycles = val;
 
 		/* 2x, 4x handling, see datasheet */
-		if (val > 511)
-			val = (val >> 1) | (1 << 9);
-		else if (val > 1022)
+		if (val > 1022)
 			val = (val >> 2) | (3 << 9);
+		else if (val > 511)
+			val = (val >> 1) | (1 << 9);
 
 		dat = cpu_to_be16(val);
 		ret = ad5933_i2c_write(st->client,
-- 
2.5.1

