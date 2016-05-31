Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:52730 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbcEaTsE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 31 May 2016 15:48:04 -0400
From: Luis de Bethencourt <luisbg@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, knaack.h@gmx.de, lars@metafoo.de,
	jic23@kernel.org, ciorneiioana@gmail.com,
	janani.rvchndrn@gmail.com, afd@ti.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: [PATCH] staging: iio: accel: remove impossible condition
Date: Tue, 31 May 2016 20:47:50 +0100
Message-Id: <1464724070-20123-1-git-send-email-luisbg@osg.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

val is set to the value of ret right after ret is checked. If ret is not
zero it goes to error_ret. So only value ret can have is zero, which makes
the switch (val & 0x03) only match the case 0x00. Removing the switch and
since val is only used for this, removing val as well.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 drivers/staging/iio/accel/sca3000_core.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index a8f533a..94656f6 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -586,7 +586,7 @@ static ssize_t sca3000_read_frequency(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct sca3000_state *st = iio_priv(indio_dev);
-	int ret, len = 0, base_freq = 0, val;
+	int ret, len = 0, base_freq = 0;
 
 	mutex_lock(&st->lock);
 	ret = __sca3000_get_base_freq(st, st->info, &base_freq);
@@ -596,20 +596,8 @@ static ssize_t sca3000_read_frequency(struct device *dev,
 	mutex_unlock(&st->lock);
 	if (ret)
 		goto error_ret;
-	val = ret;
 	if (base_freq > 0)
-		switch (val & 0x03) {
-		case 0x00:
-		case 0x03:
-			len = sprintf(buf, "%d\n", base_freq);
-			break;
-		case 0x01:
-			len = sprintf(buf, "%d\n", base_freq / 2);
-			break;
-		case 0x02:
-			len = sprintf(buf, "%d\n", base_freq / 4);
-			break;
-	}
+		len = sprintf(buf, "%d\n", base_freq);
 
 	return len;
 error_ret_mut:
-- 
2.5.1

