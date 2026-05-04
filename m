Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D49538C2C1;
	Mon,  4 May 2026 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888115; cv=none; b=mwFGBiGBynGBA28AtwyB5iW4WFOFCLoJ4dkwqZGjAd4H3YYL64N9y0AsoU+qdLGCS2TJZdHnTbAdKCVePlHn1QXjZNHj6jTrygkDQaPKKF3/wjlHYtbxFo6B7LaRkymXznjMpZ8GGlzEdLMkgjf+ASWO4XES5DoQ8Cuwiyv3EKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888115; c=relaxed/simple;
	bh=CzRxCirSvigglYe3sgSHFTfrkTCymawT3CZT6OJhV8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o94AMbA39dfxGqs+mrrSyGKrKKr9QxgS4EP/ldsCMLFM6wSMKaeIRbGRS8dbsR7S54R8sgJdA7pclJR+WpGjPW9anTrm6xfo/+c4YYoildnccd196Gd79EKlK3HbLKcxoxoTJZhtOnrzSEDQ9mYfwsA6O1pSXtVs9baf3FEMvuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LY+JXoIU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LY+JXoIU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F4B9C32781;
	Mon,  4 May 2026 09:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777888115;
	bh=CzRxCirSvigglYe3sgSHFTfrkTCymawT3CZT6OJhV8c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LY+JXoIUfuxrj+2/bJ0YTG3JDkF7rNpOXovc9ivAggkeASsFHAedEND0PjrA5GPPS
	 oyqAw0QfwEBVib7A1XR4lwB/Nd0P4z0NU1ULNNYBCCveABwKNs9OkeJ/ZOfeYX6a80
	 K32STrhvWLx8pti5qEeb83ZFmkl9R4qqIcRF4CVHsH5DSCl1+H3RL9NqxIRoTQ/+1T
	 /pr8KnZWNYFizy5cXbhIiuWtE6+/u4QC5Sts+Ok6LqL59rJ/IAam5fo1euMCS0KH+t
	 /Ro8G9unm1LD1RKiGy367e07onCcQiDEOuawRBvJ+C9K6t7JoWYL3UeeueHB/MN9Dh
	 yHXn6yHKoDqeA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686B2CD3438;
	Mon,  4 May 2026 09:48:35 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 04 May 2026 11:48:26 +0200
Subject: [PATCH v4 14/17] iio: magnetometer: ak8975: consistently use
 'data' parameter
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-magnetometer-fixes-v4-14-a291c2a7c71a@gmail.com>
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
In-Reply-To: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777888112; l=3406;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=LxVBVHjGbJ5kfuufAZAJrGZpW4vqzoL13ekQ8xspHYU=;
 b=0NpOKLHisAizi5TSSbK7Gvp0/l7lvE4RjRnljF9CL/ratlV7ZEXANJt1gAB8/DHcC1CoJ1YlJ
 IefX61bzZJ1Bx1UIsdoHS3F10bldmbGpvl1X2hzfvyGE5Z8Q4sXNMun
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Some of the functions use 'client', some use 'data', and some use both.
Refactor the driver to consistently use 'data' in all cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index b857f45d0e28b82c9e5be840140f85ee13b3a14b..6fba20c613aa40b07771fe9d7ebfc29d8a2a2b7d 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -474,9 +474,10 @@ static void ak8975_power_off(const struct ak8975_data *data)
  * Return 0 if the i2c device is the one we expect.
  * return a negative error number otherwise
  */
-static int ak8975_who_i_am(struct i2c_client *client,
+static int ak8975_who_i_am(const struct ak8975_data *data,
 			   enum asahi_compass_chipset type)
 {
+	struct i2c_client *client = data->client;
 	u8 wia_val[2];
 	int ret;
 
@@ -598,10 +599,9 @@ static int ak8975_setup_irq(struct ak8975_data *data)
  * Perform some start-of-day setup, including reading the asa calibration
  * values and caching them.
  */
-static int ak8975_setup(struct i2c_client *client)
+static int ak8975_setup(struct ak8975_data *data)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct ak8975_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
 	int ret;
 
 	/* Write the fused rom access mode. */
@@ -702,8 +702,7 @@ static int wait_conversion_complete_interrupt(struct ak8975_data *data,
 	return ret > 0 ? 0 : -ETIMEDOUT;
 }
 
-static int ak8975_start_read_axis(struct ak8975_data *data,
-				  const struct i2c_client *client)
+static int ak8975_start_read_axis(struct ak8975_data *data)
 {
 	int irq_timeout_ms = 100;
 	int timeout_ms = 500;
@@ -711,8 +710,7 @@ static int ak8975_start_read_axis(struct ak8975_data *data,
 	int ret;
 
 	/* Set up the device for taking a sample. */
-	int ret = ak8975_set_mode(data, MODE_ONCE);
-
+	ret = ak8975_set_mode(data, MODE_ONCE);
 	if (ret < 0) {
 		dev_err(&client->dev, "Error in setting operating mode\n");
 		return ret;
@@ -745,7 +743,7 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 
 	mutex_lock(&data->lock);
 
-	ret = ak8975_start_read_axis(data, client);
+	ret = ak8975_start_read_axis(data);
 	if (ret)
 		goto exit;
 
@@ -856,7 +854,7 @@ static void ak8975_fill_buffer(struct iio_dev *indio_dev)
 
 	mutex_lock(&data->lock);
 
-	ret = ak8975_start_read_axis(data, client);
+	ret = ak8975_start_read_axis(data);
 	if (ret)
 		goto unlock;
 
@@ -997,7 +995,7 @@ static int ak8975_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	ret = ak8975_who_i_am(client, data->def->type);
+	ret = ak8975_who_i_am(data, data->def->type);
 	if (ret) {
 		dev_err(&client->dev, "Unexpected device\n");
 		return ret;
@@ -1005,7 +1003,7 @@ static int ak8975_probe(struct i2c_client *client)
 	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
 
 	/* Perform some basic start-of-day setup of the device. */
-	ret = ak8975_setup(client);
+	ret = ak8975_setup(data);
 	if (ret) {
 		dev_err(&client->dev, "%s initialization fails\n", name);
 		return ret;

-- 
2.47.3


