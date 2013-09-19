Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43362 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628Ab3ISTgF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 19 Sep 2013 15:36:05 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v2 05/15] staging:iio:hmc5843: Tighten comments
Date: Thu, 19 Sep 2013 21:35:50 +0200
Message-Id: <1379619360-8150-6-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1379619360-8150-1-git-send-email-pmeerw@pmeerw.net>
References: <1379619360-8150-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/magnetometer/hmc5843.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index d953107..2d89549 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -51,15 +51,11 @@ enum hmc5843_ids {
 #define HMC5843_RANGE_GAIN_DEFAULT		0x01
 #define HMC5843_RANGE_GAIN_MAX			0x07
 
-/*
- * Device status
- */
+/* Device status */
 #define HMC5843_DATA_READY			0x01
 #define HMC5843_DATA_OUTPUT_LOCK		0x02
 
-/*
- * Mode register configuration
- */
+/* Mode register configuration */
 #define HMC5843_MODE_CONVERSION_CONTINUOUS	0x00
 #define HMC5843_MODE_CONVERSION_SINGLE		0x01
 #define HMC5843_MODE_IDLE			0x02
@@ -75,18 +71,14 @@ enum hmc5843_ids {
 #define HMC5843_RATE_BITMASK			0x1C
 #define HMC5843_RATE_NOT_USED			0x07
 
-/*
- * Device measurement configuration
- */
+/* Device measurement configuration */
 #define HMC5843_MEAS_CONF_NORMAL		0x00
 #define HMC5843_MEAS_CONF_POSITIVE_BIAS		0x01
 #define HMC5843_MEAS_CONF_NEGATIVE_BIAS		0x02
 #define HMC5843_MEAS_CONF_NOT_USED		0x03
 #define HMC5843_MEAS_CONF_MASK			0x03
 
-/*
- * Scaling factors: 10000000/Gain
- */
+/* Scaling factors: 10000000/Gain */
 static const int hmc5843_regval_to_nanoscale[] = {
 	6173, 7692, 10309, 12821, 18868, 21739, 25641, 35714
 };
-- 
1.8.4

