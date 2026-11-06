Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.31.26.27
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957635;
	b=koGSZpL/pBDDv8uomlqoDHQ+uUwHTV7xCiEhFpteDKYVq8dhyvD2v9H22ZNIE6hsX6VC
	 XI3OrHjMlDvYGqk6PkGGkY6JKhMO5dqdhgdEoihIfQCnhKiBxtnQksTSCqgq//aAHWoiu
	 Q5UC70UDVPiDkrycxPQeq6LoIA5dZSNLgjiZBMsErWPWj+Hmyfr4zEgh1DNUJR4JsSG57
	 j4ZjyKajK3IrRwv31alz6e+k4mNQhfBMMVMgIu7mtnoN94gbJJaMN1SGJOpkc24lNUyNq
	 6sYK4FqtnSOBSz2Ny9/eOqDD+o+PU1cWAyiPc2OONGLvq7NXjAFktkBoqHmWLH80b6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957635;
	h=DMARC-Filter:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=quGIdAlr6cVbKO+/sUYwx3r9laCtkrX2RSOwIZ+MluE=;
	b=XHEGuq4t+3bC1PUWVxbfsOb9Gs9h7A2t6xpvl6UM1MKmo2j79zA2lrBGYLXIeW7zsJZf
	 he7Zd6p1kUdJGIRXWqAd0b6m9G/ksTkx8OVCnFptGmP3Rj8YJbbjzLDmpRc3+MiNlKUdc
	 a4gTphGLIJaSTjw46kQW/LP30nH/iYzqWPWO3lZxdIuT7gNfODmQwY/reDgheyZmNeMfS
	 eb2Wa6QhGlLBqykBkeA+bXoH0LcFxS5mzqkJnqEIVch8aXxv6PazH060KoAttdze6oUu5
	 Kb6dBrZbHusWgeJatxoBhnEIOYhFg7sA+a3iQC+Yj9fkLBcsLAmzgINB5OE8OZspOlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rudorff.com;
	spf=pass smtp.mailfrom=rudorff.com;
	arc=none smtp.remote-ip=193.31.26.27
Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F613606EE9D;
	Fri,  6 Nov 2026 09:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F613606EE9D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [127.0.1.1] (dynamic-002-211-221-196.2.211.pool.telefonica.de [2.211.221.196])
	by rudorff.com (Postfix) with ESMTPSA id 7277F404D7;
	Fri,  6 Nov 2026 10:33:46 +0100 (CET)
From: Christoph Rudorff <chris@rudorff.com>
Date: Fri, 06 Nov 2026 10:33:26 +0100
Subject: [PATCH v5 1/3] dt-bindings: iio: light: gp2ap002: add leda power
 supply
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-iio-light-gp2ap002-v5-1-070631a7252c@rudorff.com>
References: <20261106-iio-light-gp2ap002-v5-0-070631a7252c@rudorff.com>
In-Reply-To: <20261106-iio-light-gp2ap002-v5-0-070631a7252c@rudorff.com>
To: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Christoph Rudorff <chris@rudorff.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0

According to datasheet page 8 "Recommended external circuit",
it has tree pins that need power: vio, vdd and leda ("vled" !)

Signed-off-by: Christoph Rudorff <chris@rudorff.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
---
 Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml
index 99bddf31cbed..643021f1d820 100644
--- a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml
+++ b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml
@@ -33,6 +33,9 @@ properties:
   vio-supply:
     description: VIO power supply a phandle to a regulator
 
+  leda-supply:
+    description: LED anode power supply a phandle to a regulator
+
   io-channels:
     maxItems: 1
     description: ALSOUT ADC channel to read the ambient light

-- 
2.39.5

