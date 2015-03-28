Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34081 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbbC1GhZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2015 02:37:25 -0400
Received: by pdbni2 with SMTP id ni2so117926336pdb.1
        for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2015 23:37:25 -0700 (PDT)
From: Darshana Padmadas <darshanapadmadas@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com, daniel.baluta@intel.com,
	Darshana Padmadas <darshanapadmadas@gmail.com>
Subject: [PATCH] iio: imu: Use iio_trigger_get for indio_dev->trig assignment
Date: Sat, 28 Mar 2015 12:07:14 +0530
Message-Id: <1427524634-5677-1-git-send-email-darshanapadmadas@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch uses iio_trigger_get to increment the reference
count of trigger device, to avoid incorrect assignment.

This patch refers to a similar situation encountered through the
following discussion:
http://www.spinics.net/lists/linux-iio/msg13669.html

Signed-off-by: Darshana Padmadas <darshanapadmadas@gmail.com>
---
 drivers/iio/imu/adis_trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
index e0017c2..f53e9a8 100644
--- a/drivers/iio/imu/adis_trigger.c
+++ b/drivers/iio/imu/adis_trigger.c
@@ -60,7 +60,7 @@ int adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
 	iio_trigger_set_drvdata(adis->trig, adis);
 	ret = iio_trigger_register(adis->trig);
 
-	indio_dev->trig = adis->trig;
+	indio_dev->trig = iio_trigger_get(adis->trig);
 	if (ret)
 		goto error_free_irq;
 
-- 
1.9.1

