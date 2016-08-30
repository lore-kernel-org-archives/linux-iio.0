Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35132 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751518AbcH3ISq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Aug 2016 04:18:46 -0400
Received: by mail-lf0-f52.google.com with SMTP id f93so7981760lfi.2
        for <linux-iio@vger.kernel.org>; Tue, 30 Aug 2016 01:18:46 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Giuseppe BARBA <giuseppe.barba@st.com>
Subject: [PATCH] iio: st_sensors: fix errorcheck for regulators
Date: Tue, 30 Aug 2016 10:18:39 +0200
Message-Id: <1472545119-8092-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We were checking the return code of vdd when we should be checking
vdd_io. My mistake, mea culpa.

Cc: Giuseppe BARBA <giuseppe.barba@st.com>
Reported-by: Giuseppe BARBA <giuseppe.barba@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 41bfe1c5f4e9..285a64a589d7 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -247,9 +247,9 @@ int st_sensors_power_enable(struct iio_dev *indio_dev)
 	}
 
 	pdata->vdd_io = devm_regulator_get(indio_dev->dev.parent, "vddio");
-	if (IS_ERR(pdata->vdd)) {
+	if (IS_ERR(pdata->vdd_io)) {
 		dev_err(&indio_dev->dev, "unable to get Vdd_IO supply\n");
-		err = PTR_ERR(pdata->vdd);
+		err = PTR_ERR(pdata->vdd_io);
 		goto st_sensors_disable_vdd;
 	}
 	err = regulator_enable(pdata->vdd_io);
-- 
2.7.4

