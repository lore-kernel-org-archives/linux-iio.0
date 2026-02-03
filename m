Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2512313532
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111281; cv=none; b=f+npV9diM7UUoAb+kZtMIG58PyaljBDlr3MzzLZAdWj7tH75rjG3NXygMXsV1TvFjmXpaM/nAsZRxhIRu/QCNavxFyCcFDJHXHVqbfa3aUEZCbcsaCwKEaZjMDXFjJ07QgOGLOXXEXnNixZjfhzcm1YXMHzg77ut8HXMAMTCVe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111281; c=relaxed/simple;
	bh=s7gzttavYRalNBWaV3Y5eMOcje/0ExAyLEKkNNtV2J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJ/Oyj+Vz3yAKTLNtJ9OVgD/V4KVyYFapoShXmP/mvhXnjYoJNxgkEcx/jwRsS5D3yuUk3mBUQ4aBf0IiyYf0x8MYARTbOz58V7l3AnlTck0NzbzYE/tnfXPlQkoOb5+kBHUGllmXFSxsxHdi9WrbxSDJzShNoeIPyR93ZvDWF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vnCnr-0003lb-Q9; Tue, 03 Feb 2026 10:34:35 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vnCnr-003slU-38;
	Tue, 03 Feb 2026 10:34:35 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vnCnr-0000000Ah9R-0d1C;
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
Subject: [PATCH v4 05/13] iio: dac: ds4424: rename iio_info struct to avoid ambiguity
Date: Tue,  3 Feb 2026 10:34:25 +0100
Message-ID: <20260203093434.2548978-6-o.rempel@pengutronix.de>
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

Rename the static `ds4424_info` structure to `ds4424_iio_info`.

The previous name was generic and could be confused with chip-specific
data structures (like the upcoming `ds4424_chip_info`). The new name
explicitly indicates that this structure holds the IIO framework
callbacks.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v4:
- New patch
---
 drivers/iio/dac/ds4424.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index c03051dc763e..3385f39521d9 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -197,7 +197,7 @@ static int ds4424_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(ds4424_pm_ops, ds4424_suspend, ds4424_resume);
 
-static const struct iio_info ds4424_info = {
+static const struct iio_info ds4424_iio_info = {
 	.read_raw = ds4424_read_raw,
 	.write_raw = ds4424_write_raw,
 };
@@ -252,7 +252,7 @@ static int ds4424_probe(struct i2c_client *client)
 
 	indio_dev->channels = ds4424_channels;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->info = &ds4424_info;
+	indio_dev->info = &ds4424_iio_info;
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
-- 
2.47.3

