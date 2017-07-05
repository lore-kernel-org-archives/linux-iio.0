Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33625 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbdGEVOb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jul 2017 17:14:31 -0400
From: Jack Andersen <jackoalan@gmail.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jack Andersen <jackoalan@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v5 2/3] mfd: dln2: Add cell for initializing DLN2 ADC
Date: Wed,  5 Jul 2017 11:12:47 -1000
Message-Id: <1499289168-14392-2-git-send-email-jackoalan@gmail.com>
In-Reply-To: <1499289168-14392-1-git-send-email-jackoalan@gmail.com>
References: <1499289168-14392-1-git-send-email-jackoalan@gmail.com>
In-Reply-To: <b5ede0cc2cb36695b86edf44c0dddbc4736a6420>
References: <b5ede0cc2cb36695b86edf44c0dddbc4736a6420>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jack Andersen <jackoalan@gmail.com>
---
 drivers/mfd/dln2.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index 704e189..a22ab8c 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -53,6 +53,7 @@ enum dln2_handle {
 	DLN2_HANDLE_GPIO,
 	DLN2_HANDLE_I2C,
 	DLN2_HANDLE_SPI,
+	DLN2_HANDLE_ADC,
 	DLN2_HANDLES
 };
 
@@ -663,6 +664,12 @@ static int dln2_start_rx_urbs(struct dln2_dev *dln2, gfp_t gfp)
 	.port = 0,
 };
 
+/* Only one ADC port supported */
+static struct dln2_platform_data dln2_pdata_adc = {
+	.handle = DLN2_HANDLE_ADC,
+	.port = 0,
+};
+
 static const struct mfd_cell dln2_devs[] = {
 	{
 		.name = "dln2-gpio",
@@ -679,6 +686,11 @@ static int dln2_start_rx_urbs(struct dln2_dev *dln2, gfp_t gfp)
 		.platform_data = &dln2_pdata_spi,
 		.pdata_size = sizeof(struct dln2_platform_data),
 	},
+	{
+		.name = "dln2-adc",
+		.platform_data = &dln2_pdata_adc,
+		.pdata_size = sizeof(struct dln2_platform_data),
+	},
 };
 
 static void dln2_stop(struct dln2_dev *dln2)
-- 
1.9.1

