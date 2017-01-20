Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:59680 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752615AbdATQ0S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Jan 2017 11:26:18 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Tsai <ktsai@capellamicro.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: cm3605: mark PM functions as __maybe_unused
Date: Fri, 20 Jan 2017 17:25:15 +0100
Message-Id: <20170120162530.3704498-1-arnd@arndb.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When CONFIG_PM_SLEEP is disabled, we get a harmless warning

drivers/iio/light/cm3605.c:292:12: error: 'cm3605_pm_resume' defined but not used [-Werror=unused-function]
drivers/iio/light/cm3605.c:281:12: error: 'cm3605_pm_suspend' defined but not used [-Werror=unused-function]

Marking the functions as possibly unused avoids the warning without
needing to add an #ifdef.

Fixes: 8afa505c1230 ("iio: light: add driver for Capella CM3605")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/light/cm3605.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/cm3605.c b/drivers/iio/light/cm3605.c
index 2d96543db1ef..980624e9ffb5 100644
--- a/drivers/iio/light/cm3605.c
+++ b/drivers/iio/light/cm3605.c
@@ -278,7 +278,7 @@ static int cm3605_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int cm3605_pm_suspend(struct device *dev)
+static int __maybe_unused cm3605_pm_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct cm3605 *cm3605 = iio_priv(indio_dev);
@@ -289,7 +289,7 @@ static int cm3605_pm_suspend(struct device *dev)
 	return 0;
 }
 
-static int cm3605_pm_resume(struct device *dev)
+static int __maybe_unused cm3605_pm_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct cm3605 *cm3605 = iio_priv(indio_dev);
-- 
2.9.0

