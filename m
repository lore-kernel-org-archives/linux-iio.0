Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:55290 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752670Ab1HCJHQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 3 Aug 2011 05:07:16 -0400
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
To: gregkh@suse.de
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: [PATCH] drivers:staging: remove the unused label
Date: Wed, 3 Aug 2011 17:06:02 +0800
Message-Id: <1312362362-26767-1-git-send-email-gaowanlong@cn.fujitsu.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

remove the unused label error_ret in ad37854.c.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 drivers/staging/iio/meter/ade7854.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index b82659f..ac3f9d5 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -582,7 +582,6 @@ error_unreg_dev:
 	iio_device_unregister(indio_dev);
 error_free_dev:
 	iio_free_device(indio_dev);
-error_ret:
 	return ret;
 }
 EXPORT_SYMBOL(ade7854_probe);
-- 
1.7.6

