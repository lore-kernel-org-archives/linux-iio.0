Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FAE3101CE
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111282; cv=none; b=B9EfrgH/bEYhqrcoEn8cQvh0CQcICSliaP9BvphCflOwftxMrz0F+xBa5hv2YzwzHcyfTgTrZvIvOHeQGj7T8304i29w7fPehtZWyoRzklpqE8aZIcPE0sHXxFK4lLob1onB5wVIDDzoHKi3KDAjwLNjLpU5ZC1y0NqSZDbtA24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111282; c=relaxed/simple;
	bh=Cv77hmMbLTpVDKjsQxYcJgHY1v9ruO+5hsF0i/QdGTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSM6ZbZRBXN3u5y11aLJd3Lx9EfjX6q/tzW6oJ7WxYz2LT5NEGFkeLTxH1ETtsI6Y5UqgKSy5CgrWoeNybFc0cNL86xXEOFTBHaH+YkSHP0dReVlwNUQRLpsIEvm8f18pegfzTALCiDRjwHNtt/cVgxIzAs4sNhV8nmjBrH3xdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vnCnr-0003lf-Q9; Tue, 03 Feb 2026 10:34:35 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vnCns-003sle-0L;
	Tue, 03 Feb 2026 10:34:35 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vnCnr-0000000AhAI-139M;
	Tue, 03 Feb 2026 10:34:35 +0100
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
Subject: [PATCH v4 10/13] iio: dac: ds4424: support per-variant output range limits
Date: Tue,  3 Feb 2026 10:34:30 +0100
Message-ID: <20260203093434.2548978-11-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203093434.2548978-1-o.rempel@pengutronix.de>
References: <20260203093434.2548978-1-o.rempel@pengutronix.de>
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

The DS4402/DS4404 variants operate with a 5-bit resolution (31 steps),
whereas the DS4422/DS4424 support 7-bit (127 steps).

Previously, the driver enforced a hardcoded 7-bit mask (DS4424_DAC_MASK)
for all variants. This allowed users to write values exceeding the 5-bit
range to DS4402/DS4404 devices, resulting in silent truncation or
undefined behavior.

Add a `result_mask` field to the chip_info structure to define the valid
data range for each variant. Use this mask to:
1. Correctly mask register values in read_raw().
2. Return -EINVAL in write_raw() if the input value exceeds the
   variant's capabilities.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v4:
- New patch
- Split from the original patch (v3) to isolate 5-bit vs 7-bit handling.
---
 drivers/iio/dac/ds4424.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index 31dcf6632b58..43a622575cb5 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -22,6 +22,7 @@
 #define DS4424_MAX_DAC_CHANNELS		4
 
 #define DS4424_DAC_MASK			GENMASK(6, 0)
+#define DS4404_DAC_MASK			GENMASK(4, 0)
 #define DS4424_DAC_SOURCE		BIT(7)
 
 #define DS4424_DAC_ADDR(chan)   ((chan) + 0xf8)
@@ -35,22 +36,27 @@
 }
 
 struct ds4424_chip_info {
+	u8 result_mask;
 	u8 num_channels;
 };
 
 static const struct ds4424_chip_info ds4402_info = {
+	.result_mask = DS4404_DAC_MASK,
 	.num_channels = DS4422_MAX_DAC_CHANNELS,
 };
 
 static const struct ds4424_chip_info ds4404_info = {
+	.result_mask = DS4404_DAC_MASK,
 	.num_channels = DS4424_MAX_DAC_CHANNELS,
 };
 
 static const struct ds4424_chip_info ds4422_info = {
+	.result_mask = DS4424_DAC_MASK,
 	.num_channels = DS4422_MAX_DAC_CHANNELS,
 };
 
 static const struct ds4424_chip_info ds4424_info = {
+	.result_mask = DS4424_DAC_MASK,
 	.num_channels = DS4424_MAX_DAC_CHANNELS,
 };
 
@@ -60,6 +66,7 @@ struct ds4424_data {
 	uint8_t save[DS4424_MAX_DAC_CHANNELS];
 	struct regulator *vcc_reg;
 	uint8_t raw[DS4424_MAX_DAC_CHANNELS];
+	const struct ds4424_chip_info *chip_info;
 };
 
 static const struct iio_chan_spec ds4424_channels[] = {
@@ -110,6 +117,7 @@ static int ds4424_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long mask)
 {
+	struct ds4424_data *data = iio_priv(indio_dev);
 	int ret, regval;
 
 	switch (mask) {
@@ -122,7 +130,7 @@ static int ds4424_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		}
 
-		*val = regval & DS4424_DAC_MASK;
+		*val = regval & data->chip_info->result_mask;
 		if (!(regval & DS4424_DAC_SOURCE))
 			*val = -*val;
 
@@ -137,6 +145,7 @@ static int ds4424_write_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int val, int val2, long mask)
 {
+	struct ds4424_data *data = iio_priv(indio_dev);
 	unsigned int abs_val;
 
 	if (val2 != 0)
@@ -145,7 +154,7 @@ static int ds4424_write_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		abs_val = abs(val);
-		if (abs_val > DS4424_DAC_MASK)
+		if (abs_val > data->chip_info->result_mask)
 			return -EINVAL;
 
 		/*
@@ -235,6 +244,7 @@ static int ds4424_probe(struct i2c_client *client)
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
+	data->chip_info = chip_info;
 
 	data->vcc_reg = devm_regulator_get(&client->dev, "vcc");
 	if (IS_ERR(data->vcc_reg))
-- 
2.47.3

