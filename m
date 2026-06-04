Received: from outbound0.mail.transip.nl (outbound0.mail.transip.nl [149.210.149.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C603783BB;
	Thu,  4 Jun 2026 05:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.210.149.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780552060; cv=none; b=mAOBsj3lzKGgP+ijzGQvfTQCaYsG7HKlkdl5tBFvWdgViAFnlUrRNyYw9x6abg7aFnX/1KxZqgHED/gFOnNJ0bLCEb5URrm27exCoq80Q9QQHQlE1IKZorf3SOHkMLjj+Y+0/Dztyq1YHr1xLIDwkDEVQuJpXt40ncuFfhyzswY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780552060; c=relaxed/simple;
	bh=s/tXcyivvK6qON6ZSiN21djSrCA0bh6zQnu2d2wq/60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orCmNnA4fGda6zHY3nHA57s4VcwcYNfMI7DjDeYHja+Wh6pQiexr+ybWnRaNKPkcrxrPkDeLt0nxwRuJRMmQ2aD7q/dHYZtHAyvvUaAVvkqkaN18EKBys+RMyMn6HfUPZoURL6TlhYXbEfMqercZOuVBjSsIhl2YTZ6WqoeqAtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=nB8/9O0d; arc=none smtp.client-ip=149.210.149.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="nB8/9O0d"
Received: from submission1.mail.transip.nl (unknown [10.100.4.70])
	by outbound0.mail.transip.nl (Postfix) with ESMTP id 4gWD9S6DZxzxNvB;
	Thu,  4 Jun 2026 07:47:24 +0200 (CEST)
Received: from herrie-desktop.. (180-93-184-31.ftth.glasoperator.nl [31.184.93.180])
	by submission1.mail.transip.nl (Postfix) with ESMTPA id 4gWD9S1PbszJjhYP;
	Thu,  4 Jun 2026 07:47:24 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	masneyb@onstation.org
Subject: [PATCH 1/1] iio: light: isl29018: support cover-glass gain compensation via DT
Date: Thu,  4 Jun 2026 07:47:23 +0200
Message-ID: <20260604054723.2983181-2-github.com@herrie.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604054723.2983181-1-github.com@herrie.org>
References: <20260604054723.2983181-1-github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission1.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1780552044; h=from:subject:to:cc:
 references:in-reply-to:date:mime-version;
 bh=UFASBU7YcGz8/4/7aM5eChG+sRY+dPXEb17D5i+c9Wg=;
 b=nB8/9O0dHdLT/A3ozj6IxVfGaVg0GnrlcxfNSkaYQ5QZ9C7VT1WnBZUda3+shSHmQCUN1s
 qyiGp3lHv+bePS5tzZDve9PKTf1oET/+SYQmspQIb0UqtxOM05ynl17ga/AG/Eu0ixKCVe
 SLeRidLk9klatWgbDAMSqvF63h6hm31yZS2QqdFDJeX0tafyMH+9NlurlsxzeP7a3ER3be
 +CcnedI3J4D3CbJZFdhR9EXNV1hZjyVuUZFO8taaEB3l8LXDVkd+eJJKr0yEtZsBZvzcSa
 WdGH4ooIuYVx8IRkcHwMGuBJGfUiibeq9gxYhq1qycoXVt0VuRQEplRUsgxiVQ==
X-Report-Abuse-To: abuse@transip.nl

Boards that mount the sensor under a tinted or coated cover glass need
to compensate for the optical loss before downstream consumers can map
the reading onto a useful lux range. The driver already exposes a
runtime knob through in_illuminance0_calibscale, but every user has to
re-apply it after every reboot (or rely on a board-specific udev rule),
and a power-of-two cover gain like 100x is a hardware constant of the
board rather than a policy choice that belongs in userspace.

Add an "isil,cover-comp-gain" device-tree property that seeds calibscale
at probe, mirroring the pattern tsl2563.c already uses for the same
class of problem (amstaos,cover-comp-gain). The default stays 1 so
existing systems are unaffected, and userspace can still re-tune via
the sysfs attribute afterwards.

Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
---
 .../devicetree/bindings/iio/light/isl29018.yaml     | 13 +++++++++++++
 drivers/iio/light/isl29018.c                        |  9 +++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/isl29018.yaml b/Documentation/devicetree/bindings/iio/light/isl29018.yaml
index 0ea278b07d1c..92ea2742bbd3 100644
--- a/Documentation/devicetree/bindings/iio/light/isl29018.yaml
+++ b/Documentation/devicetree/bindings/iio/light/isl29018.yaml
@@ -34,6 +34,19 @@ properties:
   vcc-supply:
     description: Regulator that provides power to the sensor
 
+  isil,cover-comp-gain:
+    description: |
+      Multiplier applied to the ambient-light reading at startup to
+      compensate for optical loss in the board's cover glass. Boards
+      that mount the sensor under a tinted or coated window typically
+      need a value between a few and a few hundred. The value seeds
+      in_illuminance0_calibscale, so it can still be retuned at
+      runtime through sysfs.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 65535
+    default: 1
+
 required:
   - compatible
   - reg
diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index b6ab726d1dae..427dbb639141 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -727,7 +727,16 @@ static int isl29018_probe(struct i2c_client *client)
 	mutex_init(&chip->lock);
 
 	chip->type = dev_id;
+	/*
+	 * Allow boards that mount the sensor behind tinted / coated cover
+	 * glass to bake the optical-loss compensation into firmware via
+	 * "isil,cover-comp-gain", following the precedent set by
+	 * tsl2563.c. The value seeds calibscale (default 1), so userspace
+	 * can still retune through in_illuminance0_calibscale.
+	 */
 	chip->calibscale = 1;
+	device_property_read_u32(&client->dev, "isil,cover-comp-gain",
+				 &chip->calibscale);
 	chip->ucalibscale = 0;
 	chip->int_time = ISL29018_INT_TIME_16;
 	chip->scale = isl29018_scales[chip->int_time][0];
-- 
2.43.0

