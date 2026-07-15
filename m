Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9523CD8C9
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103844; cv=none; b=qVf+tOP7L3eoMbmTeNzzTiL0jv7eVSTaZP+P8xBK2BfBRaK7ocykdjFBM0QoOiqCyJ5LPQ4aHBKLkadgA3Uu2p+vdebyaTLMCFvD2/WNmWNgn4JNzIHA6DzHufd/cgceoNsjeL6OGH+5/GL0ST5u6tUMrCpA19NTrADNOa4UkFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103844; c=relaxed/simple;
	bh=ptiLm+CNIzLah7x8+408IhZd1o2PQjYIBj4oQIDGZjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=izSkRaTCApb9NiKKlHVtOmxyS3teky4wcLsnbpj25IykDnJY69DDEm6ixit6NzBYbcHfYftLCr5074NuleTF6gSfp+1Ag5yZFZ2+JtFv2u4skjr6/5/Dnn7/z2vRLhXNo4OlFVh0sAeaFphEhzGs+UokadyS5sNRXx9wfLXYtHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=ApxJG099; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ApxJG099"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1784103832; x=1784363032;
	bh=RIOQ5ssVhDJTh9QFgn+Z93atKpzQKchC8CMgcI3Y4aw=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ApxJG099PjrTcPDO8Hpnv4iZr6dV+hM+jVoHrLiRsPK2GWp0sgjofdIZXnsN0ndK+
	 n4hKpvzp2+G0WME2q+NH+H4mtKwkHNepb8CyfGx55OncHmbXrXP0rDaAd3uQut/CYW
	 gQtncNdPV5WiG5OLAMquvu35T+Ceayv1H4ttGqcvEjVJnMnW+vwXORmLKQBNbGkYMp
	 fjLjDfNz7trGE4y8RSMiqg73PhZ+B7yLMVlosImmnHE4tN7OT9bqdzhkRC4yU5lLRv
	 +YE/cb8uIn9Aq9CnI3o21EIKL3ZP519vJXGKLo48UWRmpKSSlbW6yTgb80uWvjbl04
	 ta5b0s+xIJ/Mg==
X-Pm-Submission-Id: 4h0Tj30JDPz2ScqT
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 15 Jul 2026 10:23:48 +0200
Subject: [PATCH 1/3] dt-bindings: iio: light: ltr501: Add missing ltr303
 compatible
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-liteon-ltr329-v1-1-31f027051594@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784103828; l=832;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=ptiLm+CNIzLah7x8+408IhZd1o2PQjYIBj4oQIDGZjk=;
 b=U4lutJHRFAErP2cjsFTVXVXBnQSKPFnhMVU9lxOuFyvs7uPARZOD5Dy9eJH1VpXhqK9WGgVyt
 r0hPbO23jSRBjhZw+12wZYKHhVXzUGorny3yj/G7lngpgppwyE+Lxue
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

When support for ltr303 was back in 2021, the bindings documentation was
not updated accordingly.

Fixes: 7d71d289e1ba ("iio: light: ltr501: Added ltr303 driver support")
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
index c8074f180a79..ab9bb68dd736 100644
--- a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
+++ b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
@@ -18,6 +18,7 @@ properties:
       - liteon,ltr501
       - liteon,ltr559
       - liteon,ltr301
+      - liteon,ltr303
 
   reg:
     maxItems: 1

-- 
2.55.0

