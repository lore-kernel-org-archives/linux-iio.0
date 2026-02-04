Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4488821D585
	for <linux-iio@vger.kernel.org>; Wed,  4 Feb 2026 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213652; cv=none; b=Ass7WzGuhRVSGbzgkEemGrtECEVHXqznEn+6r9VVJFDnmnBOYCsUmXr9o15OSC09OiDcXXI463PWn3wLgvvETtm8OBL4cICLZeIIdbSxYxKaPlip0rIWaSZI2S3IzI9wVGmkJeYHrTZLFw1AC4kiHM2tRu8NCmw3AgJzJO6NsMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213652; c=relaxed/simple;
	bh=3umYrMYF2S5YkVxqwraaeCVEJSfgzL+AOgaGzlN8ifw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3EsPCW/slxFK7r2ct0L2nQJeo69I1NwmlyA9G6pU8zOzNYAqXCKQH9JbSitPXzYrMXbxg3WGbxnxPoCkHewzBnowk1iScQbuv8+VW35zCb4geCOJYZPlP1y7fO+faVVDV7IGp8RfhsW4kNd51Kk/eBn+lRkKedVc5PCmjfKciI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vndR1-0001Qj-HO; Wed, 04 Feb 2026 15:00:47 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vndR1-0045FG-1Q;
	Wed, 04 Feb 2026 15:00:46 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vndR0-00000001dfo-2kUT;
	Wed, 04 Feb 2026 15:00:46 +0100
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
Subject: [PATCH v5 03/13] iio: dac: ds4424: ratelimit read errors and use device context
Date: Wed,  4 Feb 2026 15:00:35 +0100
Message-ID: <20260204140045.390677-4-o.rempel@pengutronix.de>
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

Replace pr_err() with dev_err_ratelimited() in the RAW read path to avoid
log spam on repeated I2C failures and to include the device context.

Use %pe to print errno names for faster debugging. Use the parent
device context to identify the physical hardware causing the error.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
changes v5:
- no changes
changes v4:
- no changes
changes v3:
- Use indio_dev->dev.parent to reference the physical device.
- Remove redundant space in error message: "channel %d: %pe".
- This patch now precedes regmap refactoring.
changes v2:
- Update error message
- Rebase against regmap refactoring
---
 drivers/iio/dac/ds4424.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index 596ff5999271..36286e4923af 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -100,8 +100,9 @@ static int ds4424_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		ret = ds4424_get_value(indio_dev, &regval, chan->channel);
 		if (ret < 0) {
-			pr_err("%s : ds4424_get_value returned %d\n",
-							__func__, ret);
+			dev_err_ratelimited(indio_dev->dev.parent,
+					    "Failed to read channel %d: %pe\n",
+					    chan->channel, ERR_PTR(ret));
 			return ret;
 		}
 
-- 
2.47.3

