Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:48299 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934069AbcCNL3R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 14 Mar 2016 07:29:17 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 7129120A60
	for <linux-iio@vger.kernel.org>; Mon, 14 Mar 2016 12:29:12 +0100 (CET)
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Martin Kepplinger <martink@posteo.de>
Subject: [PATCH 2/2] iio: mma8452: use runtime pm instead of device specific autosleep
Date: Mon, 14 Mar 2016 12:26:29 +0100
Message-Id: <1457954789-4885-2-git-send-email-martink@posteo.de>
In-Reply-To: <1457954789-4885-1-git-send-email-martink@posteo.de>
References: <1457954789-4885-1-git-send-email-martink@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

What is this autosleep?
-----------------------
It slows down the device after x seconds of inactivity. The thing is, we have
really achieved almost the same by runtime pm.

differnces are:

autosleep
 * uses more power during inactivity
 * the first read after inactivity slightly faster
 * complicated to understand for the user
 * no documented sysfs interface (afaik)
 * complicated to read and maintain

runtime pm
 * already merged in mma8452
 * uses less power during inactivity
 * first read after inactivity slower
 * easy to use. well documented.
 * easy to maintain and understand

The two approaches solve the same problem. runtime pm has more advantages
than autosleep and comes quite close to it's behaviour anyways. As I see it,
autosleep, even if somehow supported, would never be used anyways.

So resolve this issue by "ignoring" autosleep.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
Reviewed-by: Martina Kepplinger <martina.novakovic@zoho.com>
---
 drivers/iio/accel/mma8452.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index d0eeba0..375e45f 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -17,7 +17,7 @@
  *
  * 7-bit I2C slave address 0x1c/0x1d (pin selectable)
  *
- * TODO: orientation events, autosleep
+ * TODO: orientation events
  */
 
 #include <linux/module.h>
-- 
2.1.4

