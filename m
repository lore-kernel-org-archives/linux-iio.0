Return-Path: <grundler@google.com>
To: Greg Kroah-Hartman <greg@kroah.com>, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] STAGING:iio:light: fix ISL29018 init to handle brownout
Cc: devel@linuxdriverproject.org, linux-iio@vger.kernel.org,
        bfreed@chromium.org, grundler@chromium.org
Message-Id: <20110809221815.0287B20817A@grundler.mtv.corp.google.com>
Date: Tue,  9 Aug 2011 15:18:14 -0700 (PDT)
From: grundler@google.com (Grant Grundler)
List-ID: <linux-iio@vger.kernel.org>

After a voltage brownout, sensor will now operate correctly.
    
Page 10 of ISL29018 data sheet and the Intersil Application Note 1534
describe the required initialization sequence:
1. Write 0x00 to register 0x08 (TEST)
2. Write 0x00 to register 0x00 (CMD1)
3. msleep(1)
4. program remaining registers as before

Signed-off-by: Grant Grundler <grundler@chromium.org>
Reviewed-by: Bryan Freed <bfreed@chromium.org>
---
Change was tested on ARM/Nvidia Tegra2 (T25) machines.
Diff below is against staging-2.6/staging-next.
Please apply.

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 426b6af..da5bb33 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -53,6 +53,10 @@
 #define ISL29018_REG_ADD_DATA_MSB	0x03
 #define ISL29018_MAX_REGS		ISL29018_REG_ADD_DATA_MSB
 
+#define ISL29018_REG_TEST		0x08
+#define ISL29018_TEST_SHIFT		0
+#define ISL29018_TEST_MASK		(0xFF << ISL29018_TEST_SHIFT)
+
 struct isl29018_chip {
 	struct i2c_client	*client;
 	struct mutex		lock;
@@ -457,6 +461,48 @@ static int isl29018_chip_init(struct i2c_client *client)
 
 	memset(chip->reg_cache, 0, sizeof(chip->reg_cache));
 
+	/* Code added per Intersil Application Note 1534:
+	 *     When VDD sinks to approximately 1.8V or below, some of
+	 * the part's registers may change their state. When VDD
+	 * recovers to 2.25V (or greater), the part may thus be in an
+	 * unknown mode of operation. The user can return the part to
+	 * a known mode of operation either by (a) setting VDD = 0V for
+	 * 1 second or more and then powering back up with a slew rate
+	 * of 0.5V/ms or greater, or (b) via I2C disable all ALS/PROX
+	 * conversions, clear the test registers, and then rewrite all
+	 * registers to the desired values.
+	 * ...
+	 * FOR ISL29011, ISL29018, ISL29021, ISL29023
+	 * 1. Write 0x00 to register 0x08 (TEST)
+	 * 2. Write 0x00 to register 0x00 (CMD1)
+	 * 3. Rewrite all registers to the desired values
+	 *
+	 * ISL29018 Data Sheet (FN6619.1, Feb 11, 2010) essentially says
+	 * the same thing EXCEPT the data sheet asks for a 1ms delay after
+	 * writing the CMD1 register.
+	 */
+	status = isl29018_write_data(client, ISL29018_REG_TEST, 0,
+				ISL29018_TEST_MASK, ISL29018_TEST_SHIFT);
+	if (status < 0) {
+		dev_err(&client->dev, "Failed to clear isl29018 TEST reg."
+					"(%d)\n", status);
+		return status;
+	}
+
+	/* See Intersil AN1534 comments above.
+	 * "Operating Mode" (COMMAND1) register is reprogrammed when
+	 * data is read from the device.
+	 */
+	status = isl29018_write_data(client, ISL29018_REG_ADD_COMMAND1, 0,
+				0xff, 0);
+	if (status < 0) {
+		dev_err(&client->dev, "Failed to clear isl29018 CMD1 reg."
+					"(%d)\n", status);
+		return status;
+	}
+
+	msleep(1);	/* per data sheet, page 10 */
+
 	/* set defaults */
 	status = isl29018_set_range(client, chip->range, &new_range);
 	if (status < 0) {
