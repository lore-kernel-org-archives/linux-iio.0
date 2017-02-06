Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:38601 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751416AbdBFQyW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 6 Feb 2017 11:54:22 -0500
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] MAINTAINERS: drop broken reference to i2c/trivial-devices
Date: Mon,  6 Feb 2017 17:54:11 +0100
Message-Id: <20170206165411.4796-1-wsa@the-dreams.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Due to RST rework, the reference to i2c/trivial-devices was changed, but the
result is broken. However, let's just drop the whole reference, since it
doesn't make sense in the first place to reference this "global" file
for a single driver.

Fixes: 8c27ceff3604b2 ("docs: fix locations of several documents that got moved")
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Kevin Tsai <ktsai@capellamicro.com>
Cc: Jonathan Cameron <jic23@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 023e4a8c3d104d..3c67142f17e913 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2974,7 +2974,6 @@ CAPELLA MICROSYSTEMS LIGHT SENSOR DRIVER
 M:	Kevin Tsai <ktsai@capellamicro.com>
 S:	Maintained
 F:	drivers/iio/light/cm*
-F:	Documentation/devicetree/bindings/i2c/trivial-admin-guide/devices.rst
 
 CAVIUM I2C DRIVER
 M:	Jan Glauber <jglauber@cavium.com>
-- 
2.10.2

