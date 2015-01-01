Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:60431 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbbAASNl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jan 2015 13:13:41 -0500
From: Stefan Wahren <stefan.wahren@i2se.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC] iio: inkern: add out of range error message
Date: Thu,  1 Jan 2015 18:13:24 +0000
Message-Id: <1420136004-2058-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If the DT contains an invalid channel specifier then the probe of
iio_hwmon fails with the following message:

iio_hwmon: probe of iio_hwmon failed with error -22

So it's better to print out the relevant channel specifier in
error case to locate the problem.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/iio/inkern.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 866fe90..30a8d9c 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -116,8 +116,11 @@ static int __of_iio_simple_xlate(struct iio_dev *indio_dev,
 	if (!iiospec->args_count)
 		return 0;
 
-	if (iiospec->args[0] >= indio_dev->num_channels)
+	if (iiospec->args[0] >= indio_dev->num_channels) {
+		dev_err(&indio_dev->dev, "invalid channel index %u\n",
+			iiospec->args[0]);
 		return -EINVAL;
+	}
 
 	return iiospec->args[0];
 }
-- 
1.7.9.5

