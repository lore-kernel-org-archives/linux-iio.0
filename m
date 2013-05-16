Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 18.mo1.mail-out.ovh.net ([46.105.35.72]:60091 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751511Ab3EPSJq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 May 2013 14:09:46 -0400
Received: from mail94.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id 5F8A8FF9454
	for <linux-iio@vger.kernel.org>; Thu, 16 May 2013 15:55:01 +0200 (CEST)
Date: Thu, 16 May 2013 15:54:55 +0200
From: Alexandre Relange <alexandre@relange.org>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, trivial@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: Correct HID light sensor name in comments
Message-ID: <20130516135455.GA16014@Pinea-Alexandre>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original driver was pasted from accelerometer driver, but the name
of the ID was not changed. This patch fixes this comment.

Signed-off-by: Alexandre Relange <alexandre@relange.org>
---
 drivers/iio/light/hid-sensor-als.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 80d68ff..cdc2cad 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -31,7 +31,7 @@
 #include "../common/hid-sensors/hid-sensor-trigger.h"
 
 /*Format: HID-SENSOR-usage_id_in_hex*/
-/*Usage ID from spec for Accelerometer-3D: 0x200041*/
+/*Usage ID from spec for Ambiant-Light: 0x200041*/
 #define DRIVER_NAME "HID-SENSOR-200041"
 
 #define CHANNEL_SCAN_INDEX_ILLUM 0
-- 
1.8.2.2

