Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35552 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbcCRPvo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 18 Mar 2016 11:51:44 -0400
Received: by mail-wm0-f66.google.com with SMTP id l124so7093268wmf.2
        for <linux-iio@vger.kernel.org>; Fri, 18 Mar 2016 08:51:44 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, stefan.eichenberger@netmodule.com
Subject: [PATCH 1/2] iio: adc: max1363: add missing adc to max1363_id
Date: Fri, 18 Mar 2016 16:51:03 +0100
Message-Id: <1458316264-18244-1-git-send-email-stefan.eichenberger@netmodule.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

max11644-max11647 had an enum value but were not added to the max1363_id,
so they where not selectable in the devictree.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@netmodule.com>
---
 drivers/iio/adc/max1363.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 929508e..b5d28c0 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1680,6 +1680,10 @@ static const struct i2c_device_id max1363_id[] = {
 	{ "max11615", max11615 },
 	{ "max11616", max11616 },
 	{ "max11617", max11617 },
+	{ "max11644", max11644 },
+	{ "max11645", max11645 },
+	{ "max11646", max11646 },
+	{ "max11647", max11647 },
 	{}
 };
 
-- 
2.0.4

