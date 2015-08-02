Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:59307 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751875AbbHBUoH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 2 Aug 2015 16:44:07 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	martink@posteo.de
Subject: [PATCH 2/7] iio:accel:mma8452: drop double include
Date: Sun,  2 Aug 2015 22:43:47 +0200
Message-Id: <91382bd835c10eaa15598d3ea3ca09d1a873f74d.1438483410.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438483410.git.knaack.h@gmx.de>
References: <cover.1438483410.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438483410.git.knaack.h@gmx.de>
References: <cover.1438483410.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

One inclusion of linux/iio/trigger_consumer.h is sufficient.

Fixes: 	ae6d9ce05691b ("iio: mma8452: Add support for interrupt driven triggers.")
Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/mma8452.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 245b95fc22be..153f26bc88dc 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -16,7 +16,6 @@
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/trigger_consumer.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
-- 
2.4.6

