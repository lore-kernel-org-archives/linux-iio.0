Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.31.26.27
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797361;
	b=ws4AxFenT//985ltlggmym4cA10DU0av0IDJ2OCh/N5/5Lyqx+WIkPGG95QsMY+4whzI
	 hemgYN12rX7UqwkPfG3SiA9ci7YZX7IB9vFWzTAywyOoDoJgy3HuLg9FCGI1Jj2fsKPvq
	 LNUJTT4AvDTl0W7ic940OxhnfpnQXSmZ/mo3EQMQFn27D1u/3QvKrQAgVe/TwMtev2sKf
	 xZS4MwOjzJ/+j3EpPuL4bQLifrCGlDYtJ8vsce92FOxRfeFeA0H5g4SAUpORRWZBA0Jdr
	 Ghqi12gXx5zOQLUdSMjliw5ef6MgaX6mz/jyvpAW4cOrEcQyr6EAUcmwfVvO3TlnMOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797361;
	h=DMARC-Filter:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=c1OuhDiewUAbHXO64NggE/LilZbXwU/F2X7rcv+/qJU=;
	b=YaqK/Fa+cJNKAw3JrK0bN+eQGghRetz3lvl5huP+j/IeQAGDVwK06aAkRz9EPz02XXsX
	 BvWY6zFxRe+Ts0RulMU3qSe533xIYeBk2RUwDUQ9h9E80AE9oD8v3hujV0fzekHawM4TF
	 dAlv12w34DEBL3e0D/cNv9ymUfGOdz6mQ7SwNDbhp9G0h+UGwt82MODx10JGtQukWAEfV
	 vLc9KDDy94nnLs59rpAYRo7dfpMf8xEg/18c1vnriiqbAG73ngorW27x1vx2JeWQE9lgH
	 XzmkAy7YaSFAnP24Gh7CoE6ImVgO5kbxViEYsLCkYZg4EDGEnyn3YzW8UBblPMJXK7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rudorff.com;
	spf=pass smtp.mailfrom=rudorff.com;
	arc=none smtp.remote-ip=193.31.26.27
Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A81606EEA5;
	Wed,  4 Nov 2026 13:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34A81606EEA5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [127.0.1.1] (dynamic-002-211-221-196.2.211.pool.telefonica.de [2.211.221.196])
	by rudorff.com (Postfix) with ESMTPSA id 5B6C240B45;
	Wed,  4 Nov 2026 14:02:38 +0100 (CET)
From: Christoph Rudorff <chris@rudorff.com>
Date: Wed, 04 Nov 2026 14:02:27 +0100
Subject: [PATCH v4 1/3] dt-bindings: iio: light: gp2ap002: add leda power
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
Message-Id: <20261104-iio-light-gp2ap002-v4-1-fa1cbaad2ce5@rudorff.com>
References: <20261104-iio-light-gp2ap002-v4-0-fa1cbaad2ce5@rudorff.com>
In-Reply-To: <20261104-iio-light-gp2ap002-v4-0-fa1cbaad2ce5@rudorff.com>
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
it has tree pins that need power: vio, vdd and leda ("vled" !)

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Christoph Rudorff <chris@rudorff.com>
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

