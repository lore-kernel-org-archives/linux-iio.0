Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:33604 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756711AbcJNNnX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Oct 2016 09:43:23 -0400
Received: by mail-qt0-f176.google.com with SMTP id s49so74589291qta.0
        for <linux-iio@vger.kernel.org>; Fri, 14 Oct 2016 06:43:23 -0700 (PDT)
From: Crt Mori <cmo@melexis.com>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH] [BUGFIX] iio: ms65611_core: Fixes dereferencing regulator pointer
Date: Fri, 14 Oct 2016 15:43:14 +0200
Message-Id: <20161014134314.2608-1-cmo@melexis.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Change in handling of the regulator description means that static
checkers correctly assume we could be using dereferenced pointer to the
regulator. In reality we will never get the -ENODEV error, as current
behavior flow does not predict it, because:
If the device tree or board file does not define suitable regulators for
the component, it will be substituted by a dummy regulator, or, if
regulators are disabled altogether, by stubs.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/pressure/ms5611_core.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index a74ed1f..6bd53e7 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -392,17 +392,14 @@ static int ms5611_init(struct iio_dev *indio_dev)
 
 	/* Enable attached regulator if any. */
 	st->vdd = devm_regulator_get(indio_dev->dev.parent, "vdd");
-	if (!IS_ERR(st->vdd)) {
-		ret = regulator_enable(st->vdd);
-		if (ret) {
-			dev_err(indio_dev->dev.parent,
-				"failed to enable Vdd supply: %d\n", ret);
-			return ret;
-		}
-	} else {
-		ret = PTR_ERR(st->vdd);
-		if (ret != -ENODEV)
-			return ret;
+	if (IS_ERR(st->vdd))
+		return PTR_ERR(st->vdd);
+
+	ret = regulator_enable(st->vdd);
+	if (ret) {
+		dev_err(indio_dev->dev.parent,
+			"failed to enable Vdd supply: %d\n", ret);
+		return ret;
 	}
 
 	ret = ms5611_reset(indio_dev);
-- 
2.10.1

