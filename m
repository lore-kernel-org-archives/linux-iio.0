Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:52008 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754482AbaHYIEx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Aug 2014 04:04:53 -0400
Received: by mail-we0-f176.google.com with SMTP id q58so12883463wes.35
        for <linux-iio@vger.kernel.org>; Mon, 25 Aug 2014 01:04:52 -0700 (PDT)
From: Johannes Pointner <johannes.pointner@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, 'Guenter Roeck' <linux@roeck-us.net>,
	"lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>,
	linux-iio <linux-iio@vger.kernel.org>
Subject: [PATCH] iio:inkern: fix overwritten -EPROBE_DEFER in of_iio_channel_get_by_name
Date: Mon, 25 Aug 2014 10:04:45 +0200
Message-ID: <1472905.aEm3bdqRZp@lenovobook>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch fixes the overwritten -EPROBE_DEFER return value in of_iio_channel_get_by_name.

Signed-off-by: Johannes Pointner <johannes.pointner@br-automation.com>
---
 drivers/iio/inkern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index c749700..f084610 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -178,7 +178,7 @@ static struct iio_channel *of_iio_channel_get_by_name(struct device_node *np,
 			index = of_property_match_string(np, "io-channel-names",
 							 name);
 		chan = of_iio_channel_get(np, index);
-		if (!IS_ERR(chan))
+		if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER)
 			break;
 		else if (name && index >= 0) {
 			pr_err("ERROR: could not get IIO channel %s:%s(%i)\n",
-- 
2.1.0
