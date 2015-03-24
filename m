Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 132.79-246-81.adsl-static.isp.belgacom.be ([81.246.79.132]:46612
	"EHLO viper.mind.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754469AbbCXPyq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2015 11:54:46 -0400
From: =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?=
	<vianney.leclement@essensium.com>
To: linux-iio@vger.kernel.org
Cc: =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?=
	<vianney.leclement@essensium.com>,
	"Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: [PATCH v2 1/7] iio: mlx90614: Refactor register symbols
Date: Tue, 24 Mar 2015 16:54:13 +0100
Message-Id: <1427212459-31585-2-git-send-email-vianney.leclement@essensium.com>
In-Reply-To: <1427212459-31585-1-git-send-email-vianney.leclement@essensium.com>
References: <1427212459-31585-1-git-send-email-vianney.leclement@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The defined registers only make sense when used for accessing RAM. Make
MLX90614_OP_RAM part of the symbol definition to avoid accidental access
to the wrong register.

Signed-off-by: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
Cc: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>
---
 drivers/iio/temperature/mlx90614.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index c8b6ac8..e2c6f1a 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -23,8 +23,8 @@
 #define MLX90614_OP_RAM 0x00
 
 /* RAM offsets with 16-bit data, MSB first */
-#define MLX90614_TA 0x06 /* ambient temperature */
-#define MLX90614_TOBJ1 0x07 /* object temperature */
+#define MLX90614_TA	(MLX90614_OP_RAM | 0x06) /* ambient temperature */
+#define MLX90614_TOBJ1	(MLX90614_OP_RAM | 0x07) /* object 1 temperature */
 
 struct mlx90614_data {
 	struct i2c_client *client;
@@ -42,13 +42,13 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
 		switch (channel->channel2) {
 		case IIO_MOD_TEMP_AMBIENT:
 			ret = i2c_smbus_read_word_data(data->client,
-			    MLX90614_OP_RAM | MLX90614_TA);
+			    MLX90614_TA);
 			if (ret < 0)
 				return ret;
 			break;
 		case IIO_MOD_TEMP_OBJECT:
 			ret = i2c_smbus_read_word_data(data->client,
-			    MLX90614_OP_RAM | MLX90614_TOBJ1);
+			    MLX90614_TOBJ1);
 			if (ret < 0)
 				return ret;
 			break;
-- 
2.3.3

