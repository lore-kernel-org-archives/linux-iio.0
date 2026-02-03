Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3654339A7F9
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111286; cv=none; b=cQgvBGL2R08jerGwz5bjO1hkN2xBZLJRwMrDC48rJn2B39l5jtj1ZNz/NVfDLCgqgCGsEHwa/ZMZD1PK7K/DjASdFxRsNtqhgM/pZZV6hGX4fgClDge9pKwcoiyVlws3P+YYg2/VGumKuvl28oh25bHYNCaLTlxIcyUkhZ54qIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111286; c=relaxed/simple;
	bh=6Od/OPIyLMOb7BaP297IgCCSECC+i1WrnMbE7x5Br88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dhEFxmv7mM8yzKAjtJpTd/XuDcNfMEBw7cyl924ULBNZbIV/fTiU/nslIkrOzeYkYH02+k+e50FVI2YnhShN63bDNhcltQTP+HvK4gOQCSZpiYK2sIAbZJKk6xEo1Q6g3OOEdN8b+5RC1ZVEJ5hh/fMCu9u4cS/AdXS3k7O2/TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vnCnr-0003le-Qe; Tue, 03 Feb 2026 10:34:35 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vnCns-003slc-0B;
	Tue, 03 Feb 2026 10:34:35 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vnCnr-0000000AhA8-0y8k;
	Tue, 03 Feb 2026 10:34:35 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Jander <david@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v4 09/13] iio: dac: ds4424: add DS4402/DS4404 device IDs
Date: Tue,  3 Feb 2026 10:34:29 +0100
Message-ID: <20260203093434.2548978-10-o.rempel@pengutronix.de>
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

From: David Jander <david@protonic.nl>

Add I2C/OF IDs for DS4402 and DS4404 and set the correct channel count.
Follow-up changes add per-variant scaling based on external Rfs.

Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: David Jander <david@protonic.nl>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
changes v3:
- Reset author to David Jander and added Co-developed-by tag for
  Oleksij Rempel to clarify roles
changes v2:
  - No changes.
---
 drivers/iio/dac/ds4424.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index 94803885d735..31dcf6632b58 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -38,6 +38,14 @@ struct ds4424_chip_info {
 	u8 num_channels;
 };
 
+static const struct ds4424_chip_info ds4402_info = {
+	.num_channels = DS4422_MAX_DAC_CHANNELS,
+};
+
+static const struct ds4424_chip_info ds4404_info = {
+	.num_channels = DS4424_MAX_DAC_CHANNELS,
+};
+
 static const struct ds4424_chip_info ds4422_info = {
 	.num_channels = DS4422_MAX_DAC_CHANNELS,
 };
@@ -282,6 +290,8 @@ static void ds4424_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ds4424_id[] = {
+	{ "ds4402", (kernel_ulong_t)&ds4402_info },
+	{ "ds4404", (kernel_ulong_t)&ds4404_info },
 	{ "ds4422", (kernel_ulong_t)&ds4422_info },
 	{ "ds4424", (kernel_ulong_t)&ds4424_info },
 	{ }
@@ -290,6 +300,8 @@ static const struct i2c_device_id ds4424_id[] = {
 MODULE_DEVICE_TABLE(i2c, ds4424_id);
 
 static const struct of_device_id ds4424_of_match[] = {
+	{ .compatible = "maxim,ds4402", .data = &ds4402_info },
+	{ .compatible = "maxim,ds4404", .data = &ds4404_info },
 	{ .compatible = "maxim,ds4422", .data = &ds4422_info },
 	{ .compatible = "maxim,ds4424", .data = &ds4424_info },
 	{ }
-- 
2.47.3

