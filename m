Received: from outbound11.mail.transip.nl (outbound11.mail.transip.nl [136.144.136.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14973352F87;
	Thu,  4 Jun 2026 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567592; cv=none; b=VSDJToINViyUg84B2ixkDhRcWq/lNHw2lF4vwhjrcB6k8uSG9p5TBK/WhF4LdnIYYQgkjk4qA6ZeXgKlGqMjGQpc2fQgF2bLTc/6JwNRP2yGUuVvPZAlHBvvRL7Y2quGEDwZlLwXbk+upXtFHdIxhRqr+XUApY+7qAMg5LdnILA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567592; c=relaxed/simple;
	bh=hLMSJkLaFcgr9nifWBGyhT3a2LjIiAbZE2LYvUbhrcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TyOczASNse1VZPZjXfomzttYneZ80WcJcq9S+zKWLezWsqGNDmTUHTvXEBmQYYIxrMo/2z9P2MLvk+ZI9Ai5p+02J7SUZ/C92G/I+cUBotxr+E/PrzoKVUXHTDTUkLNZnux8VfTy3HmLPvuw9wh1Da8sb9uby5u0JOqRCfg+gaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=vIenSS77; arc=none smtp.client-ip=136.144.136.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="vIenSS77"
Received: from submission11.mail.transip.nl (unknown [10.103.8.162])
	by outbound11.mail.transip.nl (Postfix) with ESMTP id 4gWKwD6gK2zkQP0C;
	Thu,  4 Jun 2026 12:06:20 +0200 (CEST)
Received: from herrie-desktop.. (180-93-184-31.ftth.glasoperator.nl [31.184.93.180])
	by submission11.mail.transip.nl (Postfix) with ESMTPA id 4gWKwD1p0Yz3R3nyx;
	Thu,  4 Jun 2026 12:06:20 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	tomasborquez13@gmail.com,
	masneyb@onstation.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herman van Hazendonk <github.com@herrie.org>
Subject: [PATCH v3 3/3] iio: light: isl29018: support cover-glass gain compensation via DT
Date: Thu,  4 Jun 2026 12:06:17 +0200
Message-ID: <20260604100617.3486541-4-github.com@herrie.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604100617.3486541-1-github.com@herrie.org>
References: <20260604100617.3486541-1-github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission11.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1780567580; h=from:subject:to:cc:
 references:in-reply-to:date:mime-version;
 bh=85+MdLr3OIbGUYUhr0bZoSZqPIhO6EkXOi7pDmhyjqw=;
 b=vIenSS77dzrgPZzgXuEI0fwnl2sYqt3fDUJ/1N7hS8mPFzknJyLE6i8RXjeUfukP9tRnos
 dxmwv+/En0tUehUr/VBiGbk/GakKSdHDUrykjxjvMkICX39bTH6w2CHgJMK57OXGhvbLbv
 KTCgFRU91vLA54KMTeWpp27uTRcw7vrP0pNsUUpGWuwPcj+zgTs7cnyRMH2Q19wLoUZ3TJ
 UDsKwY2VbeC1Cth2NULecd9zndu+rzlmnW05xQClXiYcmHxE0kU0uoNp7bltFmBsFAI7Au
 Iqvql2zwgMC8MeItyJJH815tXqJeJVmDh8ifc8e7xAPp+73C0PZUdSr3LKn/Sg==
X-Report-Abuse-To: abuse@transip.nl

Boards that mount the ISL29018 behind tinted or coated cover glass
experience optical loss that effectively reduces the sensor's apparent
sensitivity.  The existing in_illuminance0_calibscale sysfs attribute
can correct for this at runtime, but firmware knows the loss factor at
design time and there is no way to seed it without a userspace helper.

Add support for an optional "isil,cover-comp-gain" device-tree property
that initialises calibscale at probe time.  If the property is present
but cannot be read, probe returns an error via dev_err_probe() so the
root cause is visible in the log.  If absent, calibscale defaults to 1
(unity gain, matching the previous behaviour).  Userspace can still
override the value at runtime through the sysfs attribute.

The approach follows the precedent set by the TSL2563 driver.

Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
---
 drivers/iio/light/isl29018.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index f3312ad670d9..9daacb9b02bc 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -711,10 +711,13 @@ static int isl29018_probe(struct i2c_client *client)
 	struct iio_dev *indio_dev;
 	const void *ddata = NULL;
 	const char *name;
+	struct device *dev;
 	int dev_id;
 	int err;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
+	dev = &client->dev;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -733,8 +736,16 @@ static int isl29018_probe(struct i2c_client *client)
 	mutex_init(&chip->lock);
 
 	chip->type = dev_id;
-	chip->calibscale = 1;
 	chip->ucalibscale = 0;
+	if (device_property_present(dev, "isil,cover-comp-gain")) {
+		err = device_property_read_u32(dev, "isil,cover-comp-gain",
+					       &chip->calibscale);
+		if (err)
+			return dev_err_probe(dev, err,
+					     "invalid isil,cover-comp-gain\n");
+	} else {
+		chip->calibscale = 1;
+	}
 	chip->int_time = ISL29018_INT_TIME_16;
 	chip->scale = isl29018_scales[chip->int_time][0];
 	chip->suspended = false;
-- 
2.43.0

