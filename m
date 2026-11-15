Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794733894;
	b=aiBVIAfgqejG0OrxrzCemuGC5dVQ0Ke5vq43shIp+5QRYCx7qMO03GmR/8nwwEPfhKz/
	 mA5Vn6LWWP06NK6Jq+563iFUIQEoBf5ubP5Fw1iX2SfKFF/Wl/A0KuBWaCqTtjqmYi8ME
	 MYYiuFUxVogRH11hUGHuUdNnnP5Wy5kuLQqcl3mt7GAqwKPXj9S2NrMkje1FGfvVBy9xJ
	 1QqWmoZibSC9pNIHyDoLr8YCW00r7252LzkYVWc2t5NE7McI91ik+tqv1beMR+0mX9TjP
	 IEhb0Ys7B7WPrc5bWEWf+Zx11K5w9CixjFcYA7EouMiKUZctnTCTarVxfGgVH/LeEpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794733894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KvSzSzK4RKteaHZ6/hsaC8V/11ClDZu+swGpFBPSid8=;
	b=hOAMg+rMW0eTQFfbNil5KzvYwiFxfBOLebkQAZu3LgM5Ms0eyHqJ57b1CCJS4f3NBiUd
	 NMtLJMEswO06JCFhwYNeWY7n1GSMTlPOjEaS4h0bqN0pSmugqrujWwtW/AtmK++G3Nm1z
	 jQaUqHmLXflSJK/Xy265PAz9UpzkCpBRR1nhDoPHt+o159woSzEutk/s3saJeXkg2dBdK
	 lFoE7QtCNy8L3fbP+a5WqQOxYcJnh39y5vF4mSq2diw5umsVHWm9CrEvDQvi39OwBwCtR
	 BCM2clnIoyu4CAQTCip+QGKqpQQNsnqLtp0amDWMhHx1sJlaE7vu5Mf9lhwyUwepFXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VhcnB8H2;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EAD606A338
	for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 09:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3EAD606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VhcnB8H2
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c247f6687dcso472231866b.2
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 01:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794733892; x=1795338692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KvSzSzK4RKteaHZ6/hsaC8V/11ClDZu+swGpFBPSid8=;
        b=VhcnB8H2O2+aHJtEWWYXkj17gc4oRvabqTbRsHIW9PCroWlszw8zzmnKUuHwftGIUT
         jqxuYsWhxegfsoPv3F4fqngCnsVD6tEp1LAOs3y7z355+oPtPzqAfmLC0MISVhdaEVqY
         Vp3/elUXaFa84KCT/vxVK4oeGxtSkPvrVxWO9Prz5CPE/sceYXN0zw2nQTxu5TAS9+Gm
         IQzeMyq6YhKnezCrPXGRkSwyG+RO99kjGg1lL5iEvI2x24Xk8jtWQqmfVpqZdYG8+mNN
         plunPJ8sk7+Df3B7m5besr0VQZZabn2Un4TMuxw3IAORbduQf/+AK4N5EFOuSlJcIhmZ
         qWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794733892; x=1795338692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KvSzSzK4RKteaHZ6/hsaC8V/11ClDZu+swGpFBPSid8=;
        b=qKPrsOROkD/dAHhzIyiYKupt9nHD1/NaI3tRFPtIJnMVaAHSAkeHdIr+CiGOC6wfcw
         KDt8O6Wk3pXMSA42bSqKXycHwQiRk7rgpA600HsVUx58mEuJqO843Rwhcv5nBLR1olQb
         s2zQogZF06S/mog7bsN/DdGAWpt4AT052FzBAu2c8WWqjoCTITtVQX510hfpIR3mtUYe
         513YbNafJePv0jpbkzDZQ5Lj7JE7UWZOMwpZUWlAsCFEwtjxKzD/YV8nTpheq7MCnhCM
         RFtjxa44WkFXer20tRTE4QMKrYHpAfg6tezL049U7W/kl+8cya4BXC+qQLuNXywa9rOM
         ZzLw==
X-Forwarded-Encrypted: i=1; AL+hErGGzojWZ1VAEwPF+x2gOqmEG61zcB6cvY1UzOBoHxdAh8SBGfZGvcm89w2XngzAoZ7yML8uzlk9KyA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/vywuhkGXVJIur/b8dLIdKBXgC5tonyViIltt2hHW2DEMuGKU+
	jLVMGYU8aRrvH27B1Y+XTssGgJJ87N/xdGNsuklxg5itv1zxn4368GT3
X-Gm-Gg: AYBFou01Y+ojxB13+febAnVZipOoXtiv3sqlTGN6f8YLQVTDCMqcZhX+SY6EuDToBGR
	j7tx/P+Kww+1B9B9jxWIh0Ndp5BhXM5lOYNQxJo9VhFrHuntMX9+DtymVF0fWOmVslKdRJ+EEwF
	HtjaiCT+AeCPpF17H+UeBzgCGLmOwy9qNt/WjeeU04atBYo8kHMK/hJ0Smd42djNKLxTpl6JbfL
	zxgY0rninrXEXOCuYbB4RsAEXiN1zelopGoNiH6rVR9VBFC3koULvGEDNnfeoX9zdVT1Ff7N/oh
	jwrYWiAY8pZlWlEq8BZRxuVkg/UohSg651V+YSALCW+olUkNQv2qvXGrL5OWjNjLPJMN/3lQ5jc
	67xeOncdzS7JWxCxTKK/QNgBGrNHk9832MlLoHf8LmCq52lTVn5jF88gD9KxTtYHIPQBcXmCyH9
	4Mw0s2djk4G48o9l/Q0VLfApI86gd3vFsspAKYgLHRbIm9UI5Vy22mCp4ORGi0M6OzGUcPNadH9
	WYjo5aw1nv85FuGhaAdnE37jpv/1vOA8NyruOdXLSZ3L7xJKSUL4hdRkXx6HEZf+uRiSqAAOT1Z
	IXEV2k8fo/so3czbNJhdDxrdygtb2vFj3cZqw2c87KT2KjdVp99hnf1NaMMEPDBkYMDxnqbpswc
	Kj2wVezg2+w==
X-Received: by 2002:a17:907:8e08:b0:c31:c767:ae0b with SMTP id a640c23a62f3a-c5095db2440mr698968966b.0.1794733892245;
        Sun, 15 Nov 2026 01:11:32 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b3dbaesm289392366b.32.2026.11.15.01.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 01:11:31 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	mfd@lists.linux.dev
Subject: [PATCH v2 1/4] regulator: dt-bindings: maxim,max8907: Document io-channel-cells property
Date: Sun, 15 Nov 2026 11:11:17 +0200
Message-ID: <20261115091120.108684-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261115091120.108684-1-clamor95@gmail.com>
References: <20261115091120.108684-1-clamor95@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Maxim MAX8907 has a built-in 8-channel ADC. It does not require any
Device Tree-based configuration and is folded into the main PMIC
node. Document the io-channel-cells property in PMIC's node to be able to
request channel data in the Device Tree using the phandle of the PMIC.

Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 Documentation/devicetree/bindings/regulator/maxim,max8907.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/maxim,max8907.yaml b/Documentation/devicetree/bindings/regulator/maxim,max8907.yaml
index ee1a305d1c210..ccdeb9ba21e26 100644
--- a/Documentation/devicetree/bindings/regulator/maxim,max8907.yaml
+++ b/Documentation/devicetree/bindings/regulator/maxim,max8907.yaml
@@ -27,6 +27,9 @@ properties:
 
   system-power-controller: true
 
+  "#io-channel-cells":
+    const: 1
+
   mbatt-supply:
     description:
       The input supply for MBATT, BBAT, SDBY, VRTC.
-- 
2.53.0

