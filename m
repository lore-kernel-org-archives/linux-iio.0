Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:54698 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965Ab2JMJe5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 13 Oct 2012 05:34:57 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 4/7] staging:iio:adc:max1363 make docs match the contents of max1363_chip_info
Date: Sat, 13 Oct 2012 10:34:48 +0100
Message-Id: <1350120891-28593-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1350120891-28593-1-git-send-email-jic23@kernel.org>
References: <1350120891-28593-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/max1363.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363.c b/drivers/staging/iio/adc/max1363.c
index dbfdc39..3217753 100644
--- a/drivers/staging/iio/adc/max1363.c
+++ b/drivers/staging/iio/adc/max1363.c
@@ -127,20 +127,19 @@ enum max1363_modes {
 
 /**
  * struct max1363_chip_info - chip specifc information
- * @name:		indentification string for chip
- * @bits:		accuracy of the adc in bits
- * @int_vref_mv:	the internal reference voltage
  * @info:		iio core function callbacks structure
+ * @channels:		channel specification
+ * @num_channels:       number of channels
  * @mode_list:		array of available scan modes
- * @num_modes:		the number of scan modes available
  * @default_mode:	the scan mode in which the chip starts up
- * @channel:		channel specification
+ * @int_vref_mv:	the internal reference voltage
  * @num_channels:	number of channels
+ * @bits:		accuracy of the adc in bits
  */
 struct max1363_chip_info {
 	const struct iio_info		*info;
-	const struct iio_chan_spec *channels;
-	int num_channels;
+	const struct iio_chan_spec	*channels;
+	int				num_channels;
 	const enum max1363_modes	*mode_list;
 	enum max1363_modes		default_mode;
 	u16				int_vref_mv;
-- 
1.7.12.2

