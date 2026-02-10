Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A2936654E
	for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770731482; cv=none; b=UwtHfEFT8krL3QMv/zvrymGdCZd5AXKbA2d0cpaIoe192Mo9pBCqPeiE7EWQrXNGLaqVmjBPJUzBkdX43Nz0BmSWojYvSexvwXaaj7fvC4jdqHF84YFEwTHfdSO3DiF8Ffeiz76gZrWJoI/0uaAEdkf9P1tglY9I7fcAY9CwVWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770731482; c=relaxed/simple;
	bh=+rqvg27v8pxK14HPLogSisNdDT4go7iA15kgpg74nVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4XJjtu1LJw3BeNCtWCZcFQwDrfi4HaKF1F5QODxdGlz0JmRfMg4cnTSaQ85j3932tr9rblZ91+7DqPZXuRxQwFCoVMoS04exuF7ndV92xNUnL7PD6cIiunQJ6hVzKk264hqZJQDCCW17GpflNGkbKn/htj+csOtcIlIkwT9k1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vpo93-0005dJ-HX; Tue, 10 Feb 2026 14:51:13 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vpo92-0005d3-0M;
	Tue, 10 Feb 2026 14:51:12 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vpo92-00000008VNf-3HvE;
	Tue, 10 Feb 2026 14:51:12 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: [PATCH v6 04/12] iio: dac: ds4424: rename iio_info struct to avoid ambiguity
Date: Tue, 10 Feb 2026 14:51:02 +0100
Message-ID: <20260210135110.2027073-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210135110.2027073-1-o.rempel@pengutronix.de>
References: <20260210135110.2027073-1-o.rempel@pengutronix.de>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
changes v6:
- no changes
changes v5:
- add Reviewed-by: Andy
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

