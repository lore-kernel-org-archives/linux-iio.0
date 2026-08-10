Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0473439CCF4
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 07:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786345929; cv=none; b=LTm9/+rdzmcOMvOzVNcSfdT7DL8awKJ08WjXkPencgWYqZUL3t/oFVG5aV2S6aZ9ozk5Oluu2cLhiKteBO6oZBXWf3oZ4x0oGwC/Lm2w71xiNH0Twm45lwuyJpLTSZX39EAgjFOsCf4ZBQniK2ef9hebHrBEzY+GUJ9Bm8yzUZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786345929; c=relaxed/simple;
	bh=o5iaLeFqSZ3DLAGb4lZGano5lsRIsQ2wcPO34rBTfwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KDok98IywTh9vP67TeEXEQ2CS5u8r+L/fMEfOPCpvHM2WMMwrwlNYa65vTaDFUGfSPVJ9/Mu2D4S1i6peTax9m9NnKmJBDqnCrh4YbZJcv1A/BHGvHjYuspnOHG2+Uww/hTQN1mk1l8nZZlJLqvcg1Yis+taLbKdUibAQIbV+V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=6zrMpT73; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="6zrMpT73"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786345891; x=1786605091;
	bh=et8X/0cNTKAUwbY1yFIg2ogxv7G6qK1WtyOm3RNtKUQ=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=6zrMpT735L16NV45pTDpNlQ45ImJv76trSiqp38yljj+hAreZfYBzglHPivOaxmuP
	 ut75G7Fgsklww5ORGLqsSRmy1BnDltMJgNw+tMYNcJRuNG533Lc/9Ks7peBAoBu8NN
	 6Xki/ZLO1YfRMbcZWwU/lkPBi8xleEehoto6CGn7F8RJX3AaOfH+HVvUmSbHkZNfSY
	 L8CLI3+xAsc4RYzHCJFJ1i2cAjdnoUWWhqXUMEJWTcuthaBGE0Kt5aCQKpH13OmidR
	 g+ZKUNiNB0d/xhHEYpcjco54b2LrFkoU5DhFnJ0t+LvUdVsGgIoTVbtwVmAhH2Xoub
	 5Y/ocqgjHb8Lw==
X-Pm-Submission-Id: 4hJQsb1CnHz1DFFP
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 10 Aug 2026 09:11:13 +0200
Subject: [PATCH v4 3/7] dt-bindings: iio: light: ltr501: Add ltr329
 compatible
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-liteon-ltr329-v4-3-8bd3dfd15280@geanix.com>
References: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com>
In-Reply-To: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com>
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
 Jonathan Cameron <jic23@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786345884; l=921;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=o5iaLeFqSZ3DLAGb4lZGano5lsRIsQ2wcPO34rBTfwQ=;
 b=hno8JNCNv4CSmvvm7i3WBp/8ZyreLLMMVuHZ+fco6KqhuFGqt5TKlZSWhS1ZFrD0xrclidGYL
 Oi4BF18EWDDC/V5M/93nmT4R+1J3sPiPoVKWmnKAMd9b2TfoH+zEGRj
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

LTR-329ALS-01 is an ambient light sensor similar to LTR-303ALS-01, but
without interrupt support.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
index 6234e2eaec2e..8c9d6cee55b4 100644
--- a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
+++ b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
@@ -17,6 +17,7 @@ properties:
     enum:
       - liteon,ltr301
       - liteon,ltr303
+      - liteon,ltr329
       - liteon,ltr501
       - liteon,ltr559
 

-- 
2.55.0

