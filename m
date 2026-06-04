Received: from outbound5.mail.transip.nl (outbound5.mail.transip.nl [136.144.136.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52893C2B9D;
	Thu,  4 Jun 2026 06:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555782; cv=none; b=EJxOnjlfa3Z633w0D5N0bdYirYi29V4YpyCIJCgocuBj0S7no+7yvP+b4TKRBnwX3/+wbhlXPN80r6P/iRE0kFGCQTLS4QXjbo4AFFl3Lc74zkeabJZAM0hNn6ltHZ9uvzBQxEFeqwl/grs7ixAYf+nma74/RhQVDkXDBolm0Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555782; c=relaxed/simple;
	bh=GDlQAT3cYToEReNmcajQLtUR7McouHtDMrrAESWLUvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSsZYOPVp5yZBS/G6Xc4Mfo9mrVl62uzRx+64pwQsHwkWQueOAc0WrAJfCyJeCIZBGolczAMxjB9J6N9QjLBZrsEuMeVVkNiDHadK73hfqhOtrDMnUzeEu5YKR7YRvhWDp1QOepSPgpIbjFwgxkCFOEYsxl05Tcjf0ooDzPJq80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=NO+qczqf; arc=none smtp.client-ip=136.144.136.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="NO+qczqf"
Received: from submission3.mail.transip.nl (unknown [10.100.4.72])
	by outbound5.mail.transip.nl (Postfix) with ESMTP id 4gWFY3741xzHX9t;
	Thu,  4 Jun 2026 08:49:27 +0200 (CEST)
Received: from herrie-desktop.. (180-93-184-31.ftth.glasoperator.nl [31.184.93.180])
	by submission3.mail.transip.nl (Postfix) with ESMTPA id 4gWFY33JmLzf52bQ;
	Thu,  4 Jun 2026 08:49:27 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	Herman van Hazendonk <github.com@herrie.org>
Subject: [PATCH v2 2/2] iio: light: isl29018: support cover-glass gain compensation via DT
Date: Thu,  4 Jun 2026 08:49:25 +0200
Message-ID: <20260604064925.3097108-3-github.com@herrie.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604064925.3097108-1-github.com@herrie.org>
References: <20260604054723.2983181-1-github.com@herrie.org>
 <20260604064925.3097108-1-github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission3.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1780555767; h=from:subject:to:cc:
 references:in-reply-to:date:mime-version;
 bh=RhMKmD2Z6+m6kTA0DtUwgKczmGIiIRM7SHsvV8llQjI=;
 b=NO+qczqfzugtoPHTVJH/he0y2R42sRVz9F405bFmADkGP+eMvbiTfdeyozhaYjIqHAEDgH
 28h0I14RfGZdkOm3U/umXaMK6VBpd7JSyUBGRrIH3KhZeKFSf4Xs74J2lAmheGVabNZU7D
 Xjr3Mmjijxcy/LQ2+PT/Rr8fK4b9MfQbdeZDH/TMxxVosyo2hvm7u1lIm4hw3h21bcZy5h
 wpa9cK2ArGQ2zXSK/KbktEkQN2RqQ7FFMmME7iR4m2IEvTm71n1uSBDLeX+WRQH6sadaOE
 rxSx1EFCKTW+Z4cGalvFh4/rqcGfiryGFIDSjnmdh0fyhgcM5JqOk2CvMv5PLA==
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
index eafdfd9c4635..6d2f1e9f59b5 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -728,7 +728,16 @@ static int isl29018_probe(struct i2c_client *client)
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

