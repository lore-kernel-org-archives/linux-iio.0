Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-191.synserver.de ([212.40.185.191]:1085 "EHLO
	smtp-out-191.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537Ab2KEJ5G (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 5 Nov 2012 04:57:06 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/7] staging:iio:ad7887: Use proper kernel doc
Date: Mon,  5 Nov 2012 10:56:43 +0100
Message-Id: <1352109406-7206-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1352109406-7206-1-git-send-email-lars@metafoo.de>
References: <1352109406-7206-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use proper kernel doc to document the platform data struct.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7887.h | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7887.h b/drivers/staging/iio/adc/ad7887.h
index b9078fc..78b06a3 100644
--- a/drivers/staging/iio/adc/ad7887.h
+++ b/drivers/staging/iio/adc/ad7887.h
@@ -12,21 +12,20 @@
  * TODO: struct ad7887_platform_data needs to go into include/linux/iio
  */
 
+
+/**
+ * struct ad7887_platform_data - AD7887 ADC driver platform data
+ * @en_dual: Whether to use dual channel mode. If set to true AIN1 becomes the
+ *	second input channel, and Vref is internally connected to Vdd. If set to
+ *	false the device is used in single channel mode and AIN1/Vref is used as
+ *	VREF input.
+ * @use_onchip_ref: Whether to use the onchip reference. If set to true the
+ *	internal 2.5V reference is used. If set to false a external reference is
+ *	used.
+ */
 struct ad7887_platform_data {
-	/*
-	 * AD7887:
-	 * In single channel mode en_dual = flase, AIN1/Vref pins assumes its
-	 * Vref function. In dual channel mode en_dual = true, AIN1 becomes the
-	 * second input channel, and Vref is internally connected to Vdd.
-	 */
-	bool				en_dual;
-	/*
-	 * AD7887:
-	 * use_onchip_ref = true, the Vref is internally connected to the 2.500V
-	 * Voltage reference. If use_onchip_ref = false, the reference voltage
-	 * is supplied by AIN1/Vref
-	 */
-	bool				use_onchip_ref;
+	bool en_dual;
+	bool use_onchip_ref;
 };
 
 #endif /* IIO_ADC_AD7887_H_ */
-- 
1.8.0

