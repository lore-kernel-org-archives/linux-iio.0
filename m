Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CA83A542B;
	Sat, 17 Oct 2026 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.31.26.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258097; cv=none; b=IJN6DxqWii59GemOcvkFhQ7XLQYNLVD1HEcyJAuItlsUCA6ICZ90laelrycUNHSgbKDGRgoCINhrEddUoFILAyETFh1Qhl4Q8HWBcR01Y58J9ZlrDMiTqDKZ2CAumQ9rzQcrcPjFny75mn2pTzzuv3FpCkXHs6zOUdxWng6i8ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258097; c=relaxed/simple;
	bh=8xXC8+UyLJWGLwAt+gPInKDAc2YkKONSTC9ecJzc+qQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FWTrvi8Mw+TeNY1iANj/KPzvvaNYuvrjuoO/7x4w0WQN4j+54nu5eKFJLvf8mpuExOBkgZ3amgMbVT6M+xx59bp34eslijJ8dsRjvzkIyRFGrd7TFuJjczd5tIiUu08n1U/yUNduZRiAvG5RIM9DaY8jXDBcviZT0eZbuACpDI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com; spf=pass smtp.mailfrom=rudorff.com; arc=none smtp.client-ip=193.31.26.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [127.0.1.1] (dynamic-002-211-221-196.2.211.pool.telefonica.de [2.211.221.196])
	by rudorff.com (Postfix) with ESMTPSA id 1663B4094C;
	Sat, 17 Oct 2026 19:28:08 +0200 (CEST)
From: Christoph Rudorff <chris@rudorff.com>
Date: Sat, 17 Oct 2026 19:27:41 +0200
Subject: [PATCH v2 1/3] dt-bindings: iio: light: gp2ap002: add vled
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-iio-light-gp2ap002-v2-1-d6879767a446@rudorff.com>
References: <20261017-iio-light-gp2ap002-v2-0-d6879767a446@rudorff.com>
In-Reply-To: <20261017-iio-light-gp2ap002-v2-0-d6879767a446@rudorff.com>
To: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Christoph Rudorff <chris@rudorff.com>
X-Mailer: b4 0.16.0

According to datasheet page 8 "Recommended external circuit",
it can have tree supplies: vio, vdd and vled. As vdd and vled wants the
same voltage, they may be connected to a single supply.

Signed-off-by: Christoph Rudorff <chris@rudorff.com>
---
 Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml
index 99bddf31cbed..f5b2c6a4d7e3 100644
--- a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml
+++ b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml
@@ -33,6 +33,10 @@ properties:
   vio-supply:
     description: VIO power supply a phandle to a regulator
 
+  vled-supply:
+    description: LED power supply a phandle to a regulator
+      Optional. It may already be connected to VDD.
+
   io-channels:
     maxItems: 1
     description: ALSOUT ADC channel to read the ambient light

-- 
2.39.5

