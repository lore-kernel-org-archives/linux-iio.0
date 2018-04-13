Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45348 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbeDMQiY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2018 12:38:24 -0400
Received: by mail-qk0-f195.google.com with SMTP id f9so1803771qkm.12
        for <linux-iio@vger.kernel.org>; Fri, 13 Apr 2018 09:38:24 -0700 (PDT)
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH v2 07/14] staging: iio: ad7746: Remove unused defines
Date: Fri, 13 Apr 2018 13:36:44 -0300
Message-Id: <1523637411-8531-8-git-send-email-hernan@vanguardiasur.com.ar>
In-Reply-To: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/staging/iio/cdc/ad7746.c | 7 -------
 drivers/staging/iio/cdc/ad7746.h | 5 -----
 2 files changed, 12 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index f53612a..d39ab34 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -25,7 +25,6 @@
  * AD7746 Register Definition
  */
 
-#define AD7746_REG_STATUS		0
 #define AD7746_REG_CAP_DATA_HIGH	1
 #define AD7746_REG_VT_DATA_HIGH		4
 #define AD7746_REG_CAP_SETUP		7
@@ -38,12 +37,6 @@
 #define AD7746_REG_CAP_GAINH		15
 #define AD7746_REG_VOLT_GAINH		17
 
-/* Status Register Bit Designations (AD7746_REG_STATUS) */
-#define AD7746_STATUS_EXCERR		BIT(3)
-#define AD7746_STATUS_RDY		BIT(2)
-#define AD7746_STATUS_RDYVT		BIT(1)
-#define AD7746_STATUS_RDYCAP		BIT(0)
-
 /* Capacitive Channel Setup Register Bit Designations (AD7746_REG_CAP_SETUP) */
 #define AD7746_CAPSETUP_CAPEN		BIT(7)
 #define AD7746_CAPSETUP_CIN2		BIT(6) /* AD7746 only */
diff --git a/drivers/staging/iio/cdc/ad7746.h b/drivers/staging/iio/cdc/ad7746.h
index ea8572d..2fbcee8 100644
--- a/drivers/staging/iio/cdc/ad7746.h
+++ b/drivers/staging/iio/cdc/ad7746.h
@@ -13,11 +13,6 @@
  * TODO: struct ad7746_platform_data needs to go into include/linux/iio
  */
 
-#define AD7466_EXCLVL_0		0 /* +-VDD/8 */
-#define AD7466_EXCLVL_1		1 /* +-VDD/4 */
-#define AD7466_EXCLVL_2		2 /* +-VDD * 3/8 */
-#define AD7466_EXCLVL_3		3 /* +-VDD/2 */
-
 struct ad7746_platform_data {
 	unsigned char exclvl;	/*Excitation Voltage Level */
 	bool exca_en;		/* enables EXCA pin as the excitation output */
-- 
2.7.4

