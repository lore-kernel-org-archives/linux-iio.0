Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4494421FF4C
	for <linux-iio@vger.kernel.org>; Wed,  4 Feb 2026 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213652; cv=none; b=B0Fbo+4IXU4nVy954fdGDkj90Cz5fMz+AI5TqgP9cPqEp0EKo0FW973dq5H8bsvsXFbEqUDvMKAg5RpfEcJ2UT+xAZenlmcSj+5x22ouz28whU90iPYHoQMoeMTgA7ptzRvV6xZeZb/cUp2iD5Gi/1SCZoo3Td8bl0K4kjSVfUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213652; c=relaxed/simple;
	bh=J8VEEpGK6fQEXh7dQ+A+V/sWX8djg2HIkzMrWlPT06o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYP4lDc7NuHekAy+02jfrR0znEP32Xmr3PsavorI/V3K/rVh05CIcc2emkyh18xXjaDiTfDyRQg7GgK8xpGKU7NETl1bt65iqNEyXAqhzvt6h1qJ5qyucVxbRwpbqcdQ3/bdyOBa28AwIfxkb2eVnm4+RanpN5ZhvL336VQxWVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vndR1-0001Qr-HP; Wed, 04 Feb 2026 15:00:47 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vndR1-0045FO-28;
	Wed, 04 Feb 2026 15:00:47 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vndR0-00000001dgU-36GH;
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
Subject: [PATCH v5 07/13] iio: dac: ds4424: use fsleep() instead of usleep_range()
Date: Wed,  4 Feb 2026 15:00:39 +0100
Message-ID: <20260204140045.390677-8-o.rempel@pengutronix.de>
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

The DS4422/DS4424 and DS4402/DS4404 datasheets do not specify a minimum
delay between power-up (POR) and the availability of the I2C interface.

The driver previously used `usleep_range(1000, 1200)` to enforce a ~1ms
delay. Replace this with `fsleep(1000)` to allow the kernel to select
the most efficient sleep mechanism while retaining the existing
conservative delay to ensure device readiness.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
changes v5:
- Add Reviewed-by: Andy ..
- Remove "(usleep or msleep)" from the commit message
- s/1000/1 * USEC_PER_MSEC
- Include <linux/time64.h> for USEC_PER_MSEC
changes v4:
- New patch
---
 drivers/iio/dac/ds4424.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index b6b8ab2d4b1f..00a719d43a17 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
+#include <linux/time64.h>
 
 #include <linux/iio/consumer.h>
 #include <linux/iio/driver.h>
@@ -243,7 +244,13 @@ static int ds4424_probe(struct i2c_client *client)
 		return ret;
 	}
 
-	usleep_range(1000, 1200);
+	/*
+	 * The datasheet does not specify a power-up to I2C ready time.
+	 * Maintain the existing conservative 1ms delay to ensure the
+	 * device is ready for communication.
+	 */
+	fsleep(1 * USEC_PER_MSEC);
+
 	ret = ds4424_verify_chip(indio_dev);
 	if (ret < 0)
 		goto fail;
-- 
2.47.3

