Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: rklein@nvidia.com,
	linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio:isl29018 sparse and build warning fixes + trivial cleanup
Date: Mon, 11 Oct 2010 15:27:09 +0100
Message-Id: <1286807229-22102-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

gcc gives a couple of false positives on unassigned variables so lets
set them to 0.

As the values passed into set_range and set_resolution have already been
narrowed down we can do the conversion to unsigned int at passing into
the function slightly simplifying the matching code.

3rd change fixes warning about a signed parameter being passed
in when unsigned is expected.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

---
 drivers/staging/iio/light/isl29018.c |   26 ++++++++++++--------------
 1 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index f919cc1..ec02a85 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -84,18 +84,17 @@ static int isl29018_write_data(struct i2c_client *client, u8 reg,
 	return 0;
 }
 
-static int isl29018_set_range(struct i2c_client *client, unsigned long range,
+static int isl29018_set_range(struct i2c_client *client, unsigned int range,
 		unsigned int *new_range)
 {
-	static const unsigned long supp_ranges[] = {1000, 4000, 16000, 64000};
+	static const unsigned int supp_ranges[] = {1000, 4000, 16000, 64000};
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(supp_ranges); ++i) {
+	for (i = 0; i < ARRAY_SIZE(supp_ranges); ++i)
 		if (range <= supp_ranges[i]) {
-			*new_range = (unsigned int)supp_ranges[i];
+			*new_range = supp_ranges[i];
 			break;
 		}
-	}
 
 	if (i >= ARRAY_SIZE(supp_ranges))
 		return -EINVAL;
@@ -105,17 +104,16 @@ static int isl29018_set_range(struct i2c_client *client, unsigned long range,
 }
 
 static int isl29018_set_resolution(struct i2c_client *client,
-			unsigned long adcbit, unsigned int *conf_adc_bit)
+			unsigned int adcbit, unsigned int *conf_adc_bit)
 {
-	static const unsigned long supp_adcbit[] = {16, 12, 8, 4};
+	static const unsigned int supp_adcbit[] = {16, 12, 8, 4};
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(supp_adcbit); ++i) {
+	for (i = 0; i < ARRAY_SIZE(supp_adcbit); ++i)
 		if (adcbit >= supp_adcbit[i]) {
-			*conf_adc_bit = (unsigned int)supp_adcbit[i];
+			*conf_adc_bit = supp_adcbit[i];
 			break;
 		}
-	}
 
 	if (i >= ARRAY_SIZE(supp_adcbit))
 		return -EINVAL;
@@ -282,7 +280,7 @@ static ssize_t store_range(struct device *dev,
 	struct i2c_client *client = chip->client;
 	int status;
 	unsigned long lval;
-	unsigned int new_range;
+	unsigned int new_range = 0;
 
 	if (strict_strtoul(buf, 10, &lval))
 		return -EINVAL;
@@ -324,7 +322,7 @@ static ssize_t store_resolution(struct device *dev,
 	struct i2c_client *client = chip->client;
 	int status;
 	unsigned long lval;
-	unsigned int new_adc_bit;
+	unsigned int new_adc_bit = 0;
 
 	if (strict_strtoul(buf, 10, &lval))
 		return -EINVAL;
@@ -449,8 +447,8 @@ static int isl29018_chip_init(struct i2c_client *client)
 {
 	struct isl29018_chip *chip = i2c_get_clientdata(client);
 	int status;
-	int new_adc_bit;
-	unsigned int new_range;
+	unsigned int new_adc_bit;
+	unsigned int new_range = 0;
 
 	memset(chip->reg_cache, 0, sizeof(chip->reg_cache));
 
-- 
1.7.2.2
