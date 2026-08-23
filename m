Received: from mail.zlab.su (mail.zlab.su [109.73.193.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450CF3CB559;
	Sun, 23 Aug 2026 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.193.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787488606; cv=none; b=qg/QeRpmnSHyt9ZDTkcmAIEmd4UbnrY7Sin4758uJpszpphkmVA8/5q9LDMctixzLpfMaYP4JMmupn896X3u2/EwpyyFusD77SK7K6uVqpxN/4uOpW1eBA6qaM7ziyT/5mMhBGCRlN2E6ML1YYtMPXLJIfemBFfRVv1RT1h4rAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787488606; c=relaxed/simple;
	bh=nb21CGdTcvNZIWFfrkpjg3HoqUk7MmJQ7vhcZAoQmIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9d0DMU19oXCv5dqiM6tsNAK5ZAnSmzEafBG5swIiIr6lGutCzVhtT792My5uU6aOqdmt/eX1WHjTMFL6bsriBa+GNNSsYtg0/PwW0t7W0lYTiaIow+sZHiKAvMlFgKL1/FrjF0HhFq8z4uu0W0izwLk0odeC0S0vctnIA+QTHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zlab.su; spf=pass smtp.mailfrom=zlab.su; dkim=pass (2048-bit key) header.d=zlab.su header.i=@zlab.su header.b=TF49ASep; arc=none smtp.client-ip=109.73.193.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zlab.su
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zlab.su
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zlab.su header.i=@zlab.su header.b="TF49ASep"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 35A7DBFD8D;
	Sun, 23 Aug 2026 15:21:39 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zlab.su; s=dkim;
	t=1787487701; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Xyd94O5ucYyASZOwn/menIsiXveXzi9oR7nKej3n2Ig=;
	b=TF49ASepgpcLcF9HdLr1/hObVNd/CtTttC1CbR4Sk/Q4M0bOqdD61PbIXhaa2IfXAIKuj4
	ITz3UtbRnnpe7ZbAkshx7ULIl7DUqiUqslvox8r8zjDMRcn8gKq/fVwOIqGGUSjebVwM20
	AWkAiaqQjOprwJodnjMTJTNl8DyAtlq8NnESWhZAjVdS4fs0GJHVQxxW3f1Xzoc/bbSt9i
	1CAC42+NcMBtv85IWZ0PKD8VR+1TFS5ypyoOEPULDRAcSM6oEklSiOiiVXXI8nmCjdxDRa
	AOqvMMbPAvq1pO8trRogTO7v3KaHnRwHpR7xRujziFnzr/di7Wsa0Wt/+G+cDA==
From: Vladislav Leonov <vlad@zlab.su>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vladislav Leonov <vlad@zlab.su>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Simon Glass <sjg@chromium.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: iio: adc: rockchip-saradc: Group single-entries into an enum list
Date: Sun, 23 Aug 2026 15:20:33 +0300
Message-ID: <20260823122039.20831-3-vlad@zlab.su>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260823122039.20831-1-vlad@zlab.su>
References: <20260823122039.20831-1-vlad@zlab.su>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Group single-entries into an enum list

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Vladislav Leonov <vlad@zlab.su>
---

Changes in v2:
- Patch introduced in v2.

 .../bindings/iio/adc/rockchip-saradc.yaml           | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
index f0551d665916..78ec9a33da24 100644
--- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
@@ -12,15 +12,16 @@ maintainers:
 properties:
   compatible:
     oneOf:
-      - const: rockchip,saradc
-      - const: rockchip,rk3066-tsadc
-      - const: rockchip,rk3399-saradc
-      - const: rockchip,rk3528-saradc
+      - enum:
+          - rockchip,saradc
+          - rockchip,rk3066-tsadc
+          - rockchip,rk3399-saradc
+          - rockchip,rk3528-saradc
+          - rockchip,rk3562-saradc
+          - rockchip,rk3588-saradc
       - items:
           - const: rockchip,rk3506-saradc
           - const: rockchip,rk3528-saradc
-      - const: rockchip,rk3562-saradc
-      - const: rockchip,rk3588-saradc
       - items:
           - enum:
               - rockchip,rk3576-saradc
-- 
2.47.3

