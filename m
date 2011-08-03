Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:52726 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751995Ab1HCJLl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 3 Aug 2011 05:11:41 -0400
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
To: gregkh@suse.de
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: [PATCH] drivers:staging:remove the unused label error_ret
Date: Wed, 3 Aug 2011 17:10:28 +0800
Message-Id: <1312362628-27127-1-git-send-email-gaowanlong@cn.fujitsu.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

remove the unused label error_ret in ad5791.c.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 drivers/staging/iio/dac/ad5791.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
index 64770d2..5b00b70 100644
--- a/drivers/staging/iio/dac/ad5791.c
+++ b/drivers/staging/iio/dac/ad5791.c
@@ -381,7 +381,6 @@ error_put_reg_pos:
 	if (!IS_ERR(reg_vdd))
 		regulator_put(reg_vdd);
 
-error_ret:
 	return ret;
 }
 
-- 
1.7.6

