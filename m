Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37641 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbdINVTz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Sep 2017 17:19:55 -0400
From: Paolo Cretaro <paolocretaro@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, gwendal@chromium.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Cretaro <paolocretaro@gmail.com>
Subject: [PATCH] iio: cros_ec: Remove unused variable
Date: Thu, 14 Sep 2017 23:19:22 +0200
Message-Id: <20170914211922.29097-1-paolocretaro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix gcc warning:
cros_ec_baro.c:130:25: warning: variable ‘ec_device’ set but not used

Signed-off-by: Paolo Cretaro <paolocretaro@gmail.com>
---
 drivers/iio/pressure/cros_ec_baro.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index 48b2a30f57ae..5fd32ad6c64d 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -127,7 +127,6 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
-	struct cros_ec_device *ec_device;
 	struct iio_dev *indio_dev;
 	struct cros_ec_baro_state *state;
 	struct iio_chan_spec *channel;
@@ -137,7 +136,6 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
 		dev_warn(dev, "No CROS EC device found.\n");
 		return -EINVAL;
 	}
-	ec_device = ec_dev->ec_dev;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
 	if (!indio_dev)
-- 
2.14.1

