Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D5E3F0768
	for <linux-iio@vger.kernel.org>; Wed,  4 Feb 2026 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214637; cv=none; b=Eke8c/FCu3gcM7FMAhR0V7+ps3QmkOYMiJ4PyTnHiQ02swmbeWknaxiV26ZZanzUk0DF0v1Tq5A6hQXpbdYKzDd6L3VzTYvicHO9LzmkrnEQ0+9KTWH649gA/GsZ2F1xX4M/nzr1GIDxh9w1EgzUXtJFxCWAAE/NETEgsP4Q3ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214637; c=relaxed/simple;
	bh=56EXNUTDFHse8NqdweIFHbsmZRuvTlH93hBgq6Mzh6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOrh49JrhXDHpfALgc2fpNnyiWcWk20nrLNtab0su2uueF7OmV+qJClowZb17ouJaqSvwJxN6cVeJ/zhxNNKSBiDuqzPVGsPTWEvJnapf4CnfnB3pG8QL/XmUu0FAsDgmyYw4Ey9JmF/9MCcZwwC5JbmLuxCm3OfR/JxlcjmFS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vndR1-0001Qn-HO; Wed, 04 Feb 2026 15:00:47 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vndR1-0045FM-1d;
	Wed, 04 Feb 2026 15:00:46 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vndR0-00000001dgJ-30bJ;
	Wed, 04 Feb 2026 15:00:46 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: [PATCH v5 06/13] iio: dac: ds4424: use device match data for chip info
Date: Wed,  4 Feb 2026 15:00:38 +0100
Message-ID: <20260204140045.390677-7-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260204140045.390677-1-o.rempel@pengutronix.de>
References: <20260204140045.390677-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

Refactor the driver to use device match data instead of checking ID enums
in a switch statement.

Define a `ds4424_chip_info` structure to hold variant-specific attributes
(currently just the channel count) and attach it directly to the I2C and
OF device ID tables.

This simplifies the probe function and makes it easier to add support for
new variants like DS4402/DS4404.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v5:
- drop client->name change
changes v4:
- New patch
---
 drivers/iio/dac/ds4424.c | 41 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index 3385f39521d9..b6b8ab2d4b1f 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -34,9 +34,16 @@
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
 }
 
-enum ds4424_device_ids {
-	ID_DS4422,
-	ID_DS4424,
+struct ds4424_chip_info {
+	u8 num_channels;
+};
+
+static const struct ds4424_chip_info ds4422_info = {
+	.num_channels = DS4422_MAX_DAC_CHANNELS,
+};
+
+static const struct ds4424_chip_info ds4424_info = {
+	.num_channels = DS4424_MAX_DAC_CHANNELS,
 };
 
 struct ds4424_data {
@@ -205,10 +212,15 @@ static const struct iio_info ds4424_iio_info = {
 static int ds4424_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	const struct ds4424_chip_info *chip_info;
 	struct ds4424_data *data;
 	struct iio_dev *indio_dev;
 	int ret;
 
+	chip_info = i2c_get_match_data(client);
+	if (!chip_info)
+		return -ENODEV;
+
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -236,20 +248,7 @@ static int ds4424_probe(struct i2c_client *client)
 	if (ret < 0)
 		goto fail;
 
-	switch (id->driver_data) {
-	case ID_DS4422:
-		indio_dev->num_channels = DS4422_MAX_DAC_CHANNELS;
-		break;
-	case ID_DS4424:
-		indio_dev->num_channels = DS4424_MAX_DAC_CHANNELS;
-		break;
-	default:
-		dev_err(&client->dev,
-				"ds4424: Invalid chip id.\n");
-		ret = -ENXIO;
-		goto fail;
-	}
-
+	indio_dev->num_channels = chip_info->num_channels;
 	indio_dev->channels = ds4424_channels;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ds4424_iio_info;
@@ -278,16 +277,16 @@ static void ds4424_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ds4424_id[] = {
-	{ "ds4422", ID_DS4422 },
-	{ "ds4424", ID_DS4424 },
+	{ "ds4422", (kernel_ulong_t)&ds4422_info },
+	{ "ds4424", (kernel_ulong_t)&ds4424_info },
 	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, ds4424_id);
 
 static const struct of_device_id ds4424_of_match[] = {
-	{ .compatible = "maxim,ds4422" },
-	{ .compatible = "maxim,ds4424" },
+	{ .compatible = "maxim,ds4422", .data = &ds4422_info },
+	{ .compatible = "maxim,ds4424", .data = &ds4424_info },
 	{ }
 };
 
-- 
2.47.3

