Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr10137.outbound.protection.outlook.com ([40.107.1.137]:53184
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726147AbeHTNQt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Aug 2018 09:16:49 -0400
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH 1/5] iio: potentiometer: mcp4018: use the correct MODULE_LICENSE
Date: Mon, 20 Aug 2018 12:01:10 +0200
Message-Id: <20180820100114.22966-2-peda@axentia.se>
In-Reply-To: <20180820100114.22966-1-peda@axentia.se>
References: <20180820100114.22966-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The file is GPL v2 only.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/potentiometer/mcp4018.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
index 320a7c929777..5ab74a839982 100644
--- a/drivers/iio/potentiometer/mcp4018.c
+++ b/drivers/iio/potentiometer/mcp4018.c
@@ -190,4 +190,4 @@ module_i2c_driver(mcp4018_driver);
 
 MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
 MODULE_DESCRIPTION("MCP4018 digital potentiometer");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0
