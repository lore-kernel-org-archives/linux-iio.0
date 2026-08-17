Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966694657FD
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986578; cv=none; b=Qy2F2/fCOGEPGR1d51LFp7UCcynZq4hip3/PMVOxLLZK8LRfOlfKhsdAT4BYdyXCVK26tB6/OmmZXQ6JkLcj1MwldeYVtwTAyFbds6rtbewBlKlQLGYsmGlVSrv/uztSQd5t2Fm14+ukdlvAOv1sH5PCXZKlC0vGqJasnpVg49Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986578; c=relaxed/simple;
	bh=1R5l13nGG6wWHikYX00pgeDaQL/koWmDsWy7xRip0mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LxN8coUE9G6qkkufJoSfBG/8vFUEkQskhkDN8NRd3GZn3KREi64fkI9uDo7fCZVVmSB/0KYAB/CsCfBkXv1MuV4VPXiqODTF5dHZJxWMSlE0aClXyb30p/fiQvg2kRRG+2w2VOeag9O1u95coZm7SfJwp91gJpYHRWawyTGTI9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=hq86TSva; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="hq86TSva"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786986568; x=1787245768;
	bh=YDw3oSWzWK2HKj3WDtK2LZKQG57DcwUjfSlLHo7+tI8=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=hq86TSvaSDn3h7sVZIz3+YLqGEiZlDB2iVUSxtBjhcZtc+zGicecg/C5GvRzlyJG1
	 f1/7lN5bSL230n6fVSNCtN+1ZxX/aFXFR0Vq83Hdz4mh51FeIw43FHr64ty4oogMxu
	 6QWN8TRKFLdds4wVYE//2tB7PqmoxNwLo5fAcIq7kXB7b/vDaUovMMsFZKJDUPKc30
	 xWzcvj6Li17J11BGblbFSR+3fh6VACnugCv1uKYO+p8ec/QrcZLkxZYcW5Wln3P/I4
	 XplqJ5dqeTxfhsUuI3Ku4xwC1YMVhFDaXMtt7JTMP0apLp3h1rkJG7pZoJxZfZu2Ug
	 dWxCJm0qUr0OQ==
X-Pm-Submission-Id: 4hNzpH1HGSz2Sd3d
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 17 Aug 2026 19:08:57 +0200
Subject: [PATCH v5 8/8] dt-bindings: iio: light: ltr501: Make
 proximity-near-level conditional
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-liteon-ltr329-v5-8-6f71ab2b0588@geanix.com>
References: <20260817-liteon-ltr329-v5-0-6f71ab2b0588@geanix.com>
In-Reply-To: <20260817-liteon-ltr329-v5-0-6f71ab2b0588@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, 
 Maslov Dmitry <maslovdmitry@seeed.cc>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
 Thomas Gleixner <tglx@kernel.org>, Pan Chuang <panchuang@vivo.com>, 
 Yangtao Li <frank.li@vivo.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786986543; l=1013;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=1R5l13nGG6wWHikYX00pgeDaQL/koWmDsWy7xRip0mg=;
 b=j8qhxhnD7DmoVLMc+1w+09j/Jua2MPzO2c0MX+idZCTpPCXoqEUYo3R+6715JkcG7DHrYA6JH
 meNiAWz7uu2D8S7FI2epGzQt4N2hvV/oEThWZQ6wjK4JMYLmBXtLIwb
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

The proxmity-near-level attribute is only supported by ltr501 and ltr559
chips.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 .../devicetree/bindings/iio/light/liteon,ltr501.yaml         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
index 73c32b33d886..20abd7da080d 100644
--- a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
+++ b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
@@ -48,6 +48,18 @@ allOf:
       properties:
         interrupts: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - liteon,ltr301
+              - liteon,ltr303
+              - liteon,ltr329
+    then:
+      properties:
+        proximity-near-level: false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>

-- 
2.55.0

