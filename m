Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C9673463
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 18:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783795476; cv=none; b=hL09SFeaz5vKaUmklbydrhJIfqHx11SZM7Zju59ww22xRX2XJMLnu3ft3IxQMPExFPOXnlM9IlHhv1NWwUE8qC0rqzIJTfNhE6mTghdDzNkm3DyzsPG8hNOCCDaCT/h6pyhPRVJ41cr0XQ8ANRq3YrAK2j5/4LnfQ6xpcG7369s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783795476; c=relaxed/simple;
	bh=U2YoNQx/hGloZRC8McPJss1WdTnU2vgI7Fy7zmdhFok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRmcaEZ8CKCsvpK+7sDsqphiciwQ2NLHkykPvSvQiIA0i2h0NSHnB6bQEsCO3aZykljn2Xr9OZfoO8Dqrf515I+zUxuELXKRZjtK3DJjDJhJnMxZtRHjOlOhlyrNCG3skgstHbU+JJg+mA02luOpsaQu5PW3PWHG1bq/hhsTYn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqtGvXEV; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqtGvXEV"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f365afc5aso85402f8f.0
        for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 11:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783795473; x=1784400273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L/Qd/2tRCLWffwMQFEM05180CiTbv4f9HSRyN2+W50k=;
        b=TqtGvXEVhRjrovZs/mqpAa2ChnYVIgm+pldiDBazdDcC3St1AYEjU4oLJ4jvFpUMa4
         lVn1rnJ/WRv88ZqMNnVN3pYcY6L81TMo/Xq1rlKmSQvYJGKpRifo5wld1BrRsf1f7uDG
         9fY68IuC1nqF3Gd23zh0uU9r8v6cb6UasK0PSt7bzEOfSJBZzXltfTzd7QFjQ2ka1XD2
         p+L5BRRgH4K7YuQolNK+QmLcSiguao4VZNg5z7O58nPtxqT2LjcxtJagW0g+pPiezE7B
         B6optOoqbZRmXLjqPc819xKS2/H6YT/fZzV7wLVPAf3EvrsEHdo9i1QIuns1oLMSQTDq
         ICzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783795473; x=1784400273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L/Qd/2tRCLWffwMQFEM05180CiTbv4f9HSRyN2+W50k=;
        b=d5GdBiQrAwuXn8qTPs9M0AJlD24p8U+XIycsR76Fu0ShGLRXrV1TS/PIxhXQYm574G
         LLoZBDbCrmFdZyHs6bbJWu9kdb/IukTjSJyZWdqBcUT62O2U5hhc5FDcRk2kP0rOuYr8
         7lq1lvvDr766+RPc+u2MuQvn/OxVtyEh/MyBF5qNB1lQEk0f6Gpymt+Xv3z/zj4aByUs
         85qKwVADmwKo8C3z149U5sgeUoMbMapt4hFl2yyydyTmIGfllZpG3LJkd7LQsey9ryZV
         86MDkgeLwy4QmOX6a2JjSnqirk7agFwtzmclOlRoFPQDV4XYbzG8YgSQFjc+/1+7cXqx
         MXaw==
X-Gm-Message-State: AOJu0YxHFvP6JwHutf9HG12+oxhQ3wD7T/AUWflvJJau8UQJqJhcj8/J
	wmgEaTFTCmAP8ggriGjo2LyVkSzwessNKI/4oCGLorEwrdF8HsbytZPH5tygqv6c
X-Gm-Gg: AfdE7cljnCKe4J4+KwwnH2r9TSP+HgHVPzxHOEi9uOdiCLOSbd9UNi9T2oL/oR9sF6o
	FoC4bWj2AqSSbCxD9T7wjrKewokjxnzKQIH95rczBcy+NGbX3nily2ZiqB2BsR3uoeZep0eA8Ql
	sSQRRO7cyQDn49FgLqy4bqaGaAGDeeUCS9DNMmJJWBWIl+AXqStr0Ah+RbuTZIptVLFuVAMqz9M
	tLHZ2bY0va1URbrzj/VunAmdNECfIq5mXXvfQKLh0XYw4FvoMgUv2Fz9/XFhb/2ERkaL0TZwjz/
	zbkhKbz8P/qBqmIAPSsvSqPb/7DHnjKOuDmgSIXrCrBuWa3hnIYtCizeyLcx9fFdIOpaj48s8q0
	JelncoIz4ZHiyqsOD9GzlfpskngHn1Bzu4CdzjDlJCuz/m0l8DX0JWIKAJgwlvB89C3ln7ZJK6y
	nJ+JTk6QR0wbIwGXT32fxsTH/FR5qN0eykO3QcdHAhGosfjoA=
X-Received: by 2002:a5d:5d12:0:b0:47f:2bce:6f38 with SMTP id ffacd0b85a97d-47f2dcc6586mr3421934f8f.28.1783795473510;
        Sat, 11 Jul 2026 11:44:33 -0700 (PDT)
Received: from MSI-LINUX.kielce.vectranet.pl ([2a02:2a40:27ec:2900:e6c9:27be:161c:632d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d780csm70825745f8f.11.2026.07.11.11.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 11:44:33 -0700 (PDT)
From: Jakub Szczudlo <jakubszczudlo40@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	antoniu.miclaus@analog.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	duje@dujemihanovic.xyz,
	jic23@kernel.org,
	jishnu.prakash@oss.qualcomm.com,
	jorge.marques@analog.com,
	joshua.crofts1@gmail.com,
	krzk+dt@kernel.org,
	linusw@kernel.org,
	jakubszczudlo40@gmail.com,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	mike.looijmans@topic.nl,
	nuno.sa@analog.com,
	robh@kernel.org,
	sakari.ailus@linux.intel.com,
	wens@kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v6 2/3] dt-bindings: iio: adc: ti,ads1100: add support for ADS1110
Date: Sat, 11 Jul 2026 20:44:13 +0200
Message-ID: <20260711184414.1013686-3-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260711184414.1013686-1-jakubszczudlo40@gmail.com>
References: <20260711184414.1013686-1-jakubszczudlo40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register layouts are the same as for ADS1100 but ADS1110 have different
data rates and have internal voltage reference that is always 2.048V.
Also correct order of ads so they will be sorted alphabetically.

Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/iio/adc/ti,ads1100.yaml        | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
index 970ccab15e1e..28c5e2dd0ad6 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
@@ -4,19 +4,23 @@
 $id: http://devicetree.org/schemas/iio/adc/ti,ads1100.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: TI ADS1100/ADS1000 single channel I2C analog to digital converter
+title: TI ADS1100 and similar single channel I2C Analog to Digital Converters
 
 maintainers:
   - Mike Looijmans <mike.looijmans@topic.nl>
 
 description: |
-  Datasheet at: https://www.ti.com/lit/gpn/ads1100
+  Datasheets:
+    - https://www.ti.com/lit/gpn/ads1000
+    - https://www.ti.com/lit/gpn/ads1100
+    - https://www.ti.com/lit/gpn/ads1110
 
 properties:
   compatible:
     enum:
-      - ti,ads1100
       - ti,ads1000
+      - ti,ads1100
+      - ti,ads1110
 
   reg:
     maxItems: 1
-- 
2.47.3

