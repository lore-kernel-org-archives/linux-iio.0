Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:53374 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756457AbcEaVIY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 31 May 2016 17:08:24 -0400
From: Luis de Bethencourt <luisbg@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, knaack.h@gmx.de, lars@metafoo.de,
	jic23@kernel.org, ciorneiioana@gmail.com,
	janani.rvchndrn@gmail.com, afd@ti.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: [PATCH 1/2] staging: iio: accel: fix error check
Date: Tue, 31 May 2016 22:08:03 +0100
Message-Id: <1464728884-29686-1-git-send-email-luisbg@osg.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

sca3000_read_ctrl_reg() returns a negative number on failure, check for
this instead of zero.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
Reviewed-by: Andrew F. Davis <afd@ti.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
---

Patch corrected thanks to comments from Andrew F. Davis and Jonathan Cameron.
https://lkml.org/lkml/2016/5/31/862

Thanks,
Luis

 drivers/staging/iio/accel/sca3000_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index a8f533a..ec12181 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -594,7 +594,7 @@ static ssize_t sca3000_read_frequency(struct device *dev,
 		goto error_ret_mut;
 	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL);
 	mutex_unlock(&st->lock);
-	if (ret)
+	if (ret < 0)
 		goto error_ret;
 	val = ret;
 	if (base_freq > 0)
-- 
2.5.1

