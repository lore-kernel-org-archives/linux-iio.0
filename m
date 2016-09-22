Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:53938 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755862AbcIVJnY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2016 05:43:24 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] io:pressure: zpa2326: remove redundant "DEBUG" ifdef
Date: Thu, 22 Sep 2016 11:42:30 +0200
Message-Id: <20160922094253.2202232-1-arnd@arndb.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The -Wempty-body gcc warning triggers in the newly added zpa2326 driver:

drivers/iio/pressure/zpa2326.c: In function 'zpa2326_dequeue_pressure':
drivers/iio/pressure/zpa2326.c:578:3: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]

The use of an empty statement behind 'if (...)' is harmless here, but
it shows that the dev_dbg() macro is not used correctly: when the "DEBUG"
macro is not set, dev_dbg() already defaults to a no-operation, though
one that lets the compiler know that the arguments are used, and lets
it check the format string.

Fixing this also simplifies the driver.

Fixes: 03b262f2bbf4 ("iio:pressure: initial zpa2326 barometer support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/pressure/zpa2326.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index 19d2eb46fda6..c720c3ac0b9b 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -147,12 +147,8 @@ struct zpa2326_private {
 #define zpa2326_warn(_idev, _format, _arg...) \
 	dev_warn(_idev->dev.parent, _format, ##_arg)
 
-#ifdef DEBUG
 #define zpa2326_dbg(_idev, _format, _arg...) \
 	dev_dbg(_idev->dev.parent, _format, ##_arg)
-#else
-#define zpa2326_dbg(_idev, _format, _arg...)
-#endif
 
 bool zpa2326_isreg_writeable(struct device *dev, unsigned int reg)
 {
-- 
2.9.0

