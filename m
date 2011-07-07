Return-Path: <bfreed@google.com>
From: Bryan Freed <bfreed@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: jic23@cam.ac.uk, gregkh@suse.de, rklein@nvidia.com,
        linux-iio@vger.kernel.org, Bryan Freed <bfreed@chromium.org>
Subject: [PATCH v1 4/4] staging:iio:light:isl29018: Fix the "Init of isl29018 fails" failure.
Date: Thu,  7 Jul 2011 12:01:57 -0700
Message-Id: <1310065317-3872-5-git-send-email-bfreed@chromium.org>
In-Reply-To: <1310065317-3872-1-git-send-email-bfreed@chromium.org>
References: <1310065317-3872-1-git-send-email-bfreed@chromium.org>
List-ID: <linux-iio@vger.kernel.org>

The I2C clientdata is set to indio_dev instead of chip as of a couple weeks ago.
Correct the calls to i2c_get_clientdata() accordingly.
Otherwise the driver fails to initialize.

Signed-off-by: Bryan Freed <bfreed@chromium.org>
---
 drivers/staging/iio/light/isl29018.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 070e94d..426b6af 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -68,7 +68,7 @@ static int isl29018_write_data(struct i2c_client *client, u8 reg,
 {
 	u8 regval;
 	int ret = 0;
-	struct isl29018_chip *chip = i2c_get_clientdata(client);
+	struct isl29018_chip *chip = iio_priv(i2c_get_clientdata(client));
 
 	regval = chip->reg_cache[reg];
 	regval &= ~mask;
@@ -158,7 +158,7 @@ static int isl29018_read_sensor_input(struct i2c_client *client, int mode)
 static int isl29018_read_lux(struct i2c_client *client, int *lux)
 {
 	int lux_data;
-	struct isl29018_chip *chip = i2c_get_clientdata(client);
+	struct isl29018_chip *chip = iio_priv(i2c_get_clientdata(client));
 
 	lux_data = isl29018_read_sensor_input(client,
 				COMMMAND1_OPMODE_ALS_ONCE);
@@ -450,7 +450,7 @@ static const struct attribute_group isl29108_group = {
 
 static int isl29018_chip_init(struct i2c_client *client)
 {
-	struct isl29018_chip *chip = i2c_get_clientdata(client);
+	struct isl29018_chip *chip = iio_priv(i2c_get_clientdata(client));
 	int status;
 	int new_adc_bit;
 	unsigned int new_range;
-- 
1.7.3.1
