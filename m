Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:54084 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752008AbdJSUGi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 19 Oct 2017 16:06:38 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH 04/13] staging: iio: tsl2x7x: remove unnecessary struct iio_dev definition
Date: Thu, 19 Oct 2017 16:06:23 -0400
Message-Id: <20171019200632.25820-5-masneyb@onstation.org>
In-Reply-To: <20171019200632.25820-1-masneyb@onstation.org>
References: <20171019200632.25820-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

tsl2x7x.h has a blank definition for 'struct iio_dev' that is not
needed. This patch removes that definition.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
index a216c6943a84..df00f2ec1719 100644
--- a/drivers/staging/iio/light/tsl2x7x.h
+++ b/drivers/staging/iio/light/tsl2x7x.h
@@ -23,8 +23,6 @@
 #define __TSL2X7X_H
 #include <linux/pm.h>
 
-struct iio_dev;
-
 struct tsl2x7x_lux {
 	unsigned int ratio;
 	unsigned int ch0;
-- 
2.13.6

