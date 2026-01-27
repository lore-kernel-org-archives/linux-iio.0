Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBE632A3CC
	for <linux-iio@vger.kernel.org>; Tue, 27 Jan 2026 06:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769494188; cv=none; b=Ybv5bjgi7shNJE4BJICT236lirUQeLqgcqkndDXBAKc1tVInbG4c2DdXv94XTz/sjq8Kg+RpHgBEOvlbyG3ozFmeZ7gNlVrLdEkDqDMq+ARu8Tkx2QoYaPbGFwUm/GssAimz6JYvfAhnZc1uI7oUqbBoyJI1/lUPW2xnmCFkhl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769494188; c=relaxed/simple;
	bh=FgmAT561uv4OuDcGoVQH9E8QL+FuR3mXrkzMwJcAHlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1m9Nn5SxWRqPhdKmwyMgFbq0iPYk11oiMfNYmEJv58K6w995ZOszsxiMNZytGvwolEHY6996gSqBeibLJME+0pmbGjEdTt4tt89juGQXlu6kOn7JqVnAEr2VnBUAI8sObQWdycIe07qTABxNtAvo+d7l+DnjRoRJElDc4kFGmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vkcGk-0003pa-0A; Tue, 27 Jan 2026 07:09:42 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vkcGj-002hiK-2w;
	Tue, 27 Jan 2026 07:09:41 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vkcGj-0000000GQF2-0gUX;
	Tue, 27 Jan 2026 07:09:41 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	David Jander <david@protonic.nl>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v2 3/8] iio: dac: ds4424: add DS4402/DS4404 device IDs
Date: Tue, 27 Jan 2026 07:09:34 +0100
Message-ID: <20260127060939.3914006-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260127060939.3914006-1-o.rempel@pengutronix.de>
References: <20260127060939.3914006-1-o.rempel@pengutronix.de>
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

Add I2C/OF IDs for DS4402 and DS4404 and set the correct channel count.
Follow-up changes add per-variant scaling based on external Rfs.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
  - No changes.
---
 drivers/iio/dac/ds4424.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index a8198ba4f98a..072b7e6672cf 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -48,6 +48,8 @@ union ds4424_raw_data {
 };
 
 enum ds4424_device_ids {
+	ID_DS4402,
+	ID_DS4404,
 	ID_DS4422,
 	ID_DS4424,
 };
@@ -248,6 +250,12 @@ static int ds4424_probe(struct i2c_client *client)
 		goto fail;
 
 	switch (id->driver_data) {
+	case ID_DS4402:
+		indio_dev->num_channels = DS4422_MAX_DAC_CHANNELS;
+		break;
+	case ID_DS4404:
+		indio_dev->num_channels = DS4424_MAX_DAC_CHANNELS;
+		break;
 	case ID_DS4422:
 		indio_dev->num_channels = DS4422_MAX_DAC_CHANNELS;
 		break;
@@ -289,6 +297,8 @@ static void ds4424_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ds4424_id[] = {
+	{ "ds4402", ID_DS4402 },
+	{ "ds4404", ID_DS4404 },
 	{ "ds4422", ID_DS4422 },
 	{ "ds4424", ID_DS4424 },
 	{ }
@@ -297,6 +307,8 @@ static const struct i2c_device_id ds4424_id[] = {
 MODULE_DEVICE_TABLE(i2c, ds4424_id);
 
 static const struct of_device_id ds4424_of_match[] = {
+	{ .compatible = "maxim,ds4402" },
+	{ .compatible = "maxim,ds4404" },
 	{ .compatible = "maxim,ds4422" },
 	{ .compatible = "maxim,ds4424" },
 	{ }
-- 
2.47.3

