Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C8E3CBE7C;
	Wed, 15 Jul 2026 08:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103845; cv=none; b=D69FbC4KDe5FT4+P9EP9QdlMuNHlybbRVl4NTUBygDtwZ1Q1A3OvAPgjXBJi7H73bn3VwJyNNlOhOp8GQ9+wEHLuD9x0LRb9Qw1wx+4TGrmRfd3Ts1u302ZAN1udvOm3sta0E8SgifohYglZdj+E2ZG9pO83GQVmu0eP3zMIFPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103845; c=relaxed/simple;
	bh=feUXKoU1OigzdRs8cwri1uskaBwwc5Ly4ocsOXChL5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jfH7BkhyiaH+RUCXKEye6MeORSYvu+BVEjsDzDWc7h2PQ8aznCfTkgU4vugqx7uxA5eMxZ1Wa2loDmxm40+caaNbxfVr717YWWy3yZTlZPf8E0KKFDxkRyGHsDDWcOIrblfjWNdNYxyCBrJwB1ikHYymw/ahJlDyGA3UoTiLMEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=WxoMRVMe; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="WxoMRVMe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1784103833; x=1784363033;
	bh=5B+E/oOoq7h8vHYA+0lGPxncQ4PnLMN7/YIu4Ypf8mc=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=WxoMRVMefz6EEe5jU5AcVZy1XIwrc6CxfGLIUfeiRRBxm0EOTHZ1bRIPtXOaJbAc2
	 47INkihSsASRI1mV/3Gowiipr+f/Yke2tYWTBSYpFHccn1JRdBC0PEtYx8T3gJd3l/
	 Uxk2G/kti7gUjd7RkWQH6YbRQ7bhOnIyc9vQsb+/vpsNmkOkvK4VIAzD8/JzvEKfpk
	 eC3aHgaSzP3hrnLkyYBLHKxPFqr2G8YFfAtE9wx8XWTx60WgP7VwZfu6i8QYd0K6Pg
	 mA8+Cod3adu3NV+ClA+PVWEPllIpZwMpk6wcCubw4dOq5svlv4/6aSSXC3JEyTmuQf
	 9++tzyKwLjqGw==
X-Pm-Submission-Id: 4h0Tj45ZJCz2ScPw
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 15 Jul 2026 10:23:49 +0200
Subject: [PATCH 2/3] dt-bindings: iio: light: ltr501: Add ltr329 compatible
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-liteon-ltr329-v1-2-31f027051594@geanix.com>
References: <20260715-liteon-ltr329-v1-0-31f027051594@geanix.com>
In-Reply-To: <20260715-liteon-ltr329-v1-0-31f027051594@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, 
 Maslov Dmitry <maslovdmitry@seeed.cc>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Esben Haabendal <esben@geanix.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784103828; l=759;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=feUXKoU1OigzdRs8cwri1uskaBwwc5Ly4ocsOXChL5o=;
 b=JJLR2vWI6lCKKiFAprlkqVa+T6yWuUsJgkVWJltq6apORLXnU4dYAHxt+vjCWLfkD3ACqd6oH
 LlB88Ka7trNDS2AY6d801jhIXs4A3UUXrgWp2oBlHtkyaduYOlUrlNN
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

LTR-329ALS-01 is an ambient light sensor similar to LTR-303ALS-01, but
without interrupt support.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
index ab9bb68dd736..76e81eba7ea4 100644
--- a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
+++ b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
@@ -19,6 +19,7 @@ properties:
       - liteon,ltr559
       - liteon,ltr301
       - liteon,ltr303
+      - liteon,ltr329
 
   reg:
     maxItems: 1

-- 
2.55.0

