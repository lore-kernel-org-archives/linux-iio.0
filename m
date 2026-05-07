Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABBC28313D;
	Thu,  7 May 2026 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164569; cv=none; b=L9YBGcSRcdPtKHRRk4wBmxC2YNMU2q68XBkbHqLTODwv3fY1NPMqck6TYyexoyTwjOM8ZLY09ZnbBWPfqcu/obkq5KZKY/5od1K40g9SMJOD9ctPCCLMJUa5+CNr5lXzgSsVDC7iiMt39NvZ8Hh9S8g53XFhRIVlitLo+f7b8Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164569; c=relaxed/simple;
	bh=279KTUhgYtLiCj0FjFVAREjqNaNxek4+Xr1rBsCcc1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UkLfZhwdxIMkrpUboiDbWBOn2P6eC+vHP3ZWj6XWCdue4LLnbhUHrW1yQX20sH2BTtaLtJh8YNcjvgQrn2lFMBY7Dq4CTzgdZQg7PwIkJBw8B8WV/zYP0NLrtSeLC/2REoMinB7jUbvpbb06jPBq9/5GUXJPUjOETFJAC3Kk/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovhCvQHT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovhCvQHT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3DF2C2BCF6;
	Thu,  7 May 2026 14:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778164569;
	bh=279KTUhgYtLiCj0FjFVAREjqNaNxek4+Xr1rBsCcc1E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ovhCvQHTqLKdH1qUSEoWnZalI+P1X0lROi1byfDlMQDf26S1g3NFxTpzfk4keclhV
	 6WxBV4hbbcBSp9r6dP+XthKXvNW2mUMZrn3/h1ZBFMr+Ti1hnvsb74wH2Wtz31n/Es
	 khEeI+gZWf/0In0SsX2LTh51JVlQ2VvltzQb2wA57uaRsNkFmevWkW0nhfcOc5j8Nj
	 X/fK7IA+APS2Ue0ndiIxTe3zW0lyQOcpx5A4Qlb/qcHh5tgeUX2rF/mvSzDvvCcLqt
	 puOxSFEdNwttHT42aeU1oMFtZGymDWz1JIkyKFVoa5YCke+eDmZE7m0JVmWH6EYyIF
	 LFrbsxBm0I0Ng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2ADCD3444;
	Thu,  7 May 2026 14:36:09 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Thu, 07 May 2026 16:35:53 +0200
Subject: [PATCH 4/8] iio: magnetometer: ak8975: consistently use 'data'
 parameter
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-magnetometer-fixes-post-pickup-v1-4-37827ca68fb3@gmail.com>
References: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
In-Reply-To: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778164567; l=3366;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=aBXD1UqgNsG/B0TM6+2/HkyCvJBTEDR+pG1fondDO7Q=;
 b=7I1UR1HjOTylM2/T4A2ng3AWxqNThhbNwHMvWaRpVC9412OG5O3CH33YiXTFWuPx5ATLrC8eI
 wfWthoukwVdAX6Soq7PbssMICCte6ZwlLpPa/CNfjShR6hpCb0cvx/9
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
 drivers/iio/magnetometer/ak8975.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 1d8f448d5179fe9b33af989cc2f456ac91bc2f17..e575d252076acc3639cfbb718a76811636fe56d2 100644
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
@@ -706,12 +706,13 @@ static int wait_conversion_complete_interrupt(struct ak8975_data *data,
 	return ret > 0 ? 0 : -ETIMEDOUT;
 }
 
-static int ak8975_start_read_axis(struct ak8975_data *data,
-				  const struct i2c_client *client)
+static int ak8975_start_read_axis(struct ak8975_data *data)
 {
-	/* Set up the device for taking a sample. */
-	int ret = ak8975_set_mode(data, MODE_ONCE);
+	struct i2c_client *client = data->client;
+	int ret;
 
+	/* Set up the device for taking a sample. */
+	ret = ak8975_set_mode(data, MODE_ONCE);
 	if (ret < 0) {
 		dev_err(&client->dev, "Error in setting operating mode\n");
 		return ret;
@@ -744,7 +745,7 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 
 	mutex_lock(&data->lock);
 
-	ret = ak8975_start_read_axis(data, client);
+	ret = ak8975_start_read_axis(data);
 	if (ret)
 		goto exit;
 
@@ -856,7 +857,7 @@ static void ak8975_fill_buffer(struct iio_dev *indio_dev)
 
 	mutex_lock(&data->lock);
 
-	ret = ak8975_start_read_axis(data, client);
+	ret = ak8975_start_read_axis(data);
 	if (ret)
 		goto unlock;
 
@@ -994,7 +995,7 @@ static int ak8975_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	ret = ak8975_who_i_am(client, data->def->type);
+	ret = ak8975_who_i_am(data, data->def->type);
 	if (ret) {
 		dev_err(&client->dev, "Unexpected device\n");
 		return ret;
@@ -1002,7 +1003,7 @@ static int ak8975_probe(struct i2c_client *client)
 	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
 
 	/* Perform some basic start-of-day setup of the device. */
-	ret = ak8975_setup(client);
+	ret = ak8975_setup(data);
 	if (ret) {
 		dev_err(&client->dev, "%s initialization fails\n", name);
 		return ret;

-- 
2.47.3


