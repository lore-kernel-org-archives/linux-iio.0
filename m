Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from argos.tuxed.org ([176.9.87.227]:42178 "EHLO argos.tuxed.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752237AbcAPQOw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 16 Jan 2016 11:14:52 -0500
From: Alexander Koch <mail@alexanderkoch.net>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	mhornung.linux@gmail.com, dannenberg@ti.com, balbi@ti.com,
	fengguang.wu@intel.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Koch <mail@alexanderkoch.net>
Subject: [PATCH v2 1/3] iio: light: opt3001: extract int. time constants
Date: Sat, 16 Jan 2016 17:14:36 +0100
Message-Id: <1452960878-1727-2-git-send-email-mail@alexanderkoch.net>
In-Reply-To: <1452960878-1727-1-git-send-email-mail@alexanderkoch.net>
References: <1452960878-1727-1-git-send-email-mail@alexanderkoch.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Extract integration times as #define constants. This prepares using them
for delay/timeout length determination.

Signed-off-by: Alexander Koch <mail@alexanderkoch.net>
Signed-off-by: Michael Hornung <mhornung.linux@gmail.com>
---
 drivers/iio/light/opt3001.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 01e111e..aefbd79 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -65,6 +65,9 @@
 #define OPT3001_REG_EXPONENT(n)		((n) >> 12)
 #define OPT3001_REG_MANTISSA(n)		((n) & 0xfff)
 
+#define OPT3001_INT_TIME_LONG		800000
+#define OPT3001_INT_TIME_SHORT		100000
+
 /*
  * Time to wait for conversion result to be ready. The device datasheet
  * worst-case max value is 880ms. Add some slack to be on the safe side.
@@ -325,13 +328,13 @@ static int opt3001_set_int_time(struct opt3001 *opt, int time)
 	reg = ret;
 
 	switch (time) {
-	case 100000:
+	case OPT3001_INT_TIME_SHORT:
 		reg &= ~OPT3001_CONFIGURATION_CT;
-		opt->int_time = 100000;
+		opt->int_time = OPT3001_INT_TIME_SHORT;
 		break;
-	case 800000:
+	case OPT3001_INT_TIME_LONG:
 		reg |= OPT3001_CONFIGURATION_CT;
-		opt->int_time = 800000;
+		opt->int_time = OPT3001_INT_TIME_LONG;
 		break;
 	default:
 		return -EINVAL;
@@ -597,9 +600,9 @@ static int opt3001_configure(struct opt3001 *opt)
 
 	/* Reflect status of the device's integration time setting */
 	if (reg & OPT3001_CONFIGURATION_CT)
-		opt->int_time = 800000;
+		opt->int_time = OPT3001_INT_TIME_LONG;
 	else
-		opt->int_time = 100000;
+		opt->int_time = OPT3001_INT_TIME_SHORT;
 
 	/* Ensure device is in shutdown initially */
 	opt3001_set_mode(opt, &reg, OPT3001_CONFIGURATION_M_SHUTDOWN);
-- 
2.7.0

