Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:60591 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085Ab3G0PcE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 27 Jul 2013 11:32:04 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Shubhrajyoti Datta <shubhrajyoti@ti.com>
Subject: [PATCH 1/9] staging:iio:hmc5843: Drop I2C detection code
Date: Sat, 27 Jul 2013 17:31:44 +0200
Message-Id: <1374939112-18237-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1374939112-18237-1-git-send-email-pmeerw@pmeerw.net>
References: <1374939112-18237-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I2C is generally not probed for devices

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Shubhrajyoti Datta <shubhrajyoti@ti.com>
---
 drivers/staging/iio/magnetometer/hmc5843.c | 33 ------------------------------
 1 file changed, 33 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 86c6bf9..e5999d4 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -53,14 +53,6 @@ enum hmc5843_ids {
 };
 
 /*
- * Beware: identification of the HMC5883 is still "H43";
- * I2C address is also unchanged
- */
-#define HMC5843_ID_REG_LENGTH			0x03
-#define HMC5843_ID_STRING			"H43"
-#define HMC5843_I2C_ADDRESS			0x1E
-
-/*
  * Range gain settings in (+-)Ga
  * Beware: HMC5843 and HMC5883 have different recommended sensor field
  * ranges; default corresponds to +-1.0 Ga and +-1.3 Ga, respectively
@@ -185,10 +177,6 @@ static const char * const hmc5883_regval_to_sample_freq[] = {
 	"0.75", "1.5", "3", "7.5", "15", "30", "75",
 };
 
-/* Addresses to scan: 0x1E */
-static const unsigned short normal_i2c[] = { HMC5843_I2C_ADDRESS,
-					     I2C_CLIENT_END };
-
 /* Describe chip variants */
 struct hmc5843_chip_info {
 	const struct iio_chan_spec *channels;
@@ -621,25 +609,6 @@ static const struct hmc5843_chip_info hmc5843_chip_info_tbl[] = {
 	},
 };
 
-static int hmc5843_detect(struct i2c_client *client,
-			  struct i2c_board_info *info)
-{
-	unsigned char id_str[HMC5843_ID_REG_LENGTH];
-
-	if (client->addr != HMC5843_I2C_ADDRESS)
-		return -ENODEV;
-
-	if (i2c_smbus_read_i2c_block_data(client, HMC5843_ID_REG_A,
-				HMC5843_ID_REG_LENGTH, id_str)
-			!= HMC5843_ID_REG_LENGTH)
-		return -ENODEV;
-
-	if (0 != strncmp(id_str, HMC5843_ID_STRING, HMC5843_ID_REG_LENGTH))
-		return -ENODEV;
-
-	return 0;
-}
-
 /* Called when we have found a new HMC58X3 */
 static void hmc5843_init_client(struct i2c_client *client,
 				const struct i2c_device_id *id)
@@ -756,8 +725,6 @@ static struct i2c_driver hmc5843_driver = {
 	.id_table	= hmc5843_id,
 	.probe		= hmc5843_probe,
 	.remove		= hmc5843_remove,
-	.detect		= hmc5843_detect,
-	.address_list	= normal_i2c,
 };
 module_i2c_driver(hmc5843_driver);
 
-- 
1.8.3.4

