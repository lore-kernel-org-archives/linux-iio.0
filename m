Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B63136607A
	for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770731482; cv=none; b=SguFLHt+kFYKX+ZA9L3Lw9V6uQDQU9yrDNSvPt7xhayNoiTooMgOz6dZ0dIF06qHaeGSeN/8OTeWQRtRemeaq/wZ/DB1vCd2Dp89JwrfHCXYsSDUTYqNgjQcr5VX7Qlrtg/YfjqqX+utjJlfrqaTwa64WYpFkAipD2CYt3SDhYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770731482; c=relaxed/simple;
	bh=jRf2iO2tRAl/oQKlTgLi5mreQQ1i9qqO8otfRBReonE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gjt32Q9pmFPxyk2eEHF3Mh8CTkvmIlKqNo7k9PBowD82yKU9UG+2xo8PRY/o8OZO6L5lvtasGX0BlyufPgtFclR2VUV3F8lFOezMckWXgEf71vhQieqELqspTdv7ObuW3ep0zzGTkk6LhRQ9Fu2lsGllsXb/HzB/ceES6LhqPi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vpo93-0005dG-HX; Tue, 10 Feb 2026 14:51:13 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vpo92-0005cy-05;
	Tue, 10 Feb 2026 14:51:12 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vpo92-00000008VNL-30fw;
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
Subject: [PATCH v6 02/12] iio: dac: ds4424: ratelimit read errors and use device context
Date: Tue, 10 Feb 2026 14:51:00 +0100
Message-ID: <20260210135110.2027073-3-o.rempel@pengutronix.de>
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

Replace pr_err() with dev_err_ratelimited() in the RAW read path to avoid
log spam on repeated I2C failures and to include the device context.

Use %pe to print errno names for faster debugging. Use the parent
device context to identify the physical hardware causing the error.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
changes v6:
- no changes
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

