Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2354312834
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111281; cv=none; b=tlnXdrHcRA1UlxcO0/yvFr9zWmAg6rVF4EEhAVZSf78vj95KYEuRt22gZ483fEraw3t51ZobGLHN3l8369V4CUeaAHLO8pHuKnCQCBtMC31zm74eKv8RqbO/VunBHspLdTeztfyGlphzLzpldKybGoZNubtgZZpc5Nb5Gt8wU7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111281; c=relaxed/simple;
	bh=PIdksg1G07VqhZfWxWeVIPUH6eFQdZq3KZLVRtFrqR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkBtENAsJT8N+OyH2qKyHRjGxT2rWhR6zxMnnyRJClY1hNZVpzz1vy586RLKwBOV/cNl1iuD40Enklb0DiPiA1WZH9kEFxvh1rIukJvTKeWoGqR++zK2CWF+jKdxeT8XQZ6buSAslZs7gcS5alTTl4PAaL6SvJha4ofioG70gKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vnCnr-0003ld-QA; Tue, 03 Feb 2026 10:34:35 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vnCnr-003slY-31;
	Tue, 03 Feb 2026 10:34:35 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vnCnr-0000000Ah9n-0nsS;
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
Subject: [PATCH v4 07/13] iio: dac: ds4424: use fsleep() instead of usleep_range()
Date: Tue,  3 Feb 2026 10:34:27 +0100
Message-ID: <20260203093434.2548978-8-o.rempel@pengutronix.de>
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

The DS4422/DS4424 and DS4402/DS4404 datasheets do not specify a minimum
delay between power-up (POR) and the availability of the I2C interface.

The driver previously used `usleep_range(1000, 1200)` to enforce a ~1ms
delay. Replace this with `fsleep(1000)` to allow the kernel to select the
most efficient sleep mechanism (usleep or msleep) while retaining the
existing conservative delay to ensure device readiness.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v4:
- New patch
---
 drivers/iio/dac/ds4424.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index 5709d8a39d7b..94803885d735 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -241,7 +241,13 @@ static int ds4424_probe(struct i2c_client *client)
 		return ret;
 	}
 
-	usleep_range(1000, 1200);
+	/*
+	 * The datasheet does not specify a power-up to I2C ready time.
+	 * Maintain the existing conservative 1ms delay to ensure the
+	 * device is ready for communication.
+	 */
+	fsleep(1000);
+
 	ret = ds4424_verify_chip(indio_dev);
 	if (ret < 0)
 		goto fail;
-- 
2.47.3

