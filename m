Return-Path: <maxin.john@gmail.com>
Date: Fri, 2 Sep 2011 00:24:13 +0300
From: "Maxin B. John" <maxin.john@gmail.com>
To: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
	Bryan Freed <bfreed@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: light: Fix compiler warning in tsl2563.c
Message-ID: <20110901212413.GA3371@maxin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

  CC [M]  drivers/staging/iio/light/tsl2563.o
drivers/staging/iio/light/tsl2563.c: In function 'tsl2563_probe':
drivers/staging/iio/light/tsl2563.c:736: warning: 'id' may be used 
uninitialized in this function

Also fixes the tsl2563_read_id().

Signed-off-by: Maxin B. John <maxin.john@gmail.com>
---
diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index f25243b..f8f787d 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -225,9 +225,9 @@ static int tsl2563_read_id(struct tsl2563_chip *chip, u8 *id)
 
 	ret = i2c_smbus_read_byte_data(client, TSL2563_CMD | TSL2563_REG_ID);
 	if (ret < 0)
-		return ret;
+		return -EIO;
 
-	return 0;
+	return ret;
 }
 
 /*
@@ -697,7 +697,7 @@ static int __devinit tsl2563_probe(struct i2c_client *client,
 	struct tsl2563_platform_data *pdata = client->dev.platform_data;
 	int err = 0;
 	int ret;
-	u8 id;
+	u8 id = 0;
 
 	indio_dev = iio_allocate_device(sizeof(*chip));
 	if (!indio_dev)
@@ -709,15 +709,17 @@ static int __devinit tsl2563_probe(struct i2c_client *client,
 	chip->client = client;
 
 	err = tsl2563_detect(chip);
-	if (err) {
+	if (err < 0) {
 		dev_err(&client->dev, "device not found, error %d\n", -err);
 		goto fail1;
 	}
 
 	err = tsl2563_read_id(chip, &id);
-	if (err)
+	if (err < 0) {
+		dev_err(&client->dev, "id reading failed, error %d\n", -err);
 		goto fail1;
-
+	}
+	id = err;
 	mutex_init(&chip->lock);
 
 	/* Default values used until userspace says otherwise */
