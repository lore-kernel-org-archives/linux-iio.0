Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34780 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbbKIO0e (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Nov 2015 09:26:34 -0500
From: Nizam Haider <nizamhaider786@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, marex@denx.de, stefan.wahren@i2se.com,
	kristina.martsenko@gmail.com, ciorneiioana@gmail.com,
	hamohammed.sa@gmail.com, alexandre.belloni@free-electrons.com,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Nizam Haider <nizamhaider786@gmail.com>,
	Nizam Haider <nijamh@cdac.in>
Subject: [PATCH] iio: adc: mxs-lradc: Prefer using the BIT macro
Date: Mon,  9 Nov 2015 19:56:02 +0530
Message-Id: <1447079162-12531-1-git-send-email-nizamhaider786@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replaces bit shifting on 1 with the BIT(x) macro

Signed-off-by: Nizam Haider <nijamh@cdac.in>
---
 drivers/staging/iio/adc/mxs-lradc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index d997d9c..5f1375c 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -324,7 +324,7 @@ struct mxs_lradc {
 #define	LRADC_DELAY_TRIGGER(x) \
 				(((x) << LRADC_DELAY_TRIGGER_LRADCS_OFFSET) & \
 				LRADC_DELAY_TRIGGER_LRADCS_MASK)
-#define	LRADC_DELAY_KICK			(1 << 20)
+#define	LRADC_DELAY_KICK			BIT(20)
 #define	LRADC_DELAY_TRIGGER_DELAYS_MASK		(0xf << 16)
 #define	LRADC_DELAY_TRIGGER_DELAYS_OFFSET	16
 #define	LRADC_DELAY_TRIGGER_DELAYS(x) \
-- 
1.8.1.4

