Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7B22EC08C
	for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 20:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769200733; cv=none; b=hi3UG+T6qvOUWM5vnyAlOMV/AK2x8zMRMYYQ5Nd0k+mjguyC3RZen4GIhiO3mhQdjSglD4egpMt4SbXPQ1BWaE/TcDJRoxc6g92ZHLUBtEfhzIQbgCFuOqPxm23SYYZDm4aZwDoXxOyqTlrqGOVgfvCeoyKNAyS+C6CFibSctD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769200733; c=relaxed/simple;
	bh=xGdA4shyG2YCvuBGh2md3PDf5DNCGZXwZPSKvqxMkg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QNl+1mBfRT4Qkmw06L4yOhmARoei/UU3BnFMVUNGxvgw4mdBmx9RAGsLVTG7mDmAGQstlHbOv0wqItZcL4n17r4VRj2BB79r+Z7JXL4TfDhnJOq6+TaTABrEU95BNPsiaii5I/Z9hql2dLP2Vq4K7IllU8Av07SUIEBRPcRGpyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Re5pUkn2; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Re5pUkn2"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-3f9ebb269c3so1208225fac.3
        for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 12:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769200728; x=1769805528; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4D5V2WHoyTIzltxmYXn2Y2Bh1DMbRJSg1M2EQIKXDAk=;
        b=Re5pUkn2qs5xraFNfWCHwGERp2ObHMdwej+DhjY5fO5QYiO28jZw6qIfA11clvvdOP
         CWKcAzxeKxJILzkSgw6nbPFNG5trUf16vMhBgk0w4MNEYQ9AGJPbjQuRfQlF7gMutJp6
         OvaF7mHq3ppovSX62doZ7lN+BymX1vxYj1+LYzbq3cAJdK9Tw2G1Qjcsd9Z4tfSXI98L
         pvUFMBo9e26Kwt6RjLARQz5pQVCpJcB3N3H01bKQ9qp1AfYTNO9APhJZ89nx0KBq1XK2
         gTXEJXVfjT6yqruCAvX3oOfyq2WDL7Xk4+fwqvsdrzck9E6UrEAGK+gowzzz3Smur0uH
         8u5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769200728; x=1769805528;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4D5V2WHoyTIzltxmYXn2Y2Bh1DMbRJSg1M2EQIKXDAk=;
        b=b90St6dCOC0LgpQlIGPkVii7akxPGuXDXOLEpWcX/wiIlz8R5gcw3qepKCIRPVDl4X
         MK4sRpISSUinA/pgHYUCSHVmtAERvFStxuGXF73IH0qSZJg5sbbO/Ri09DKXpkRqdsHC
         7O/XIIdR3OFeONDm23hEC/KiEmZVvbEyvC3zB+vhgg5GuTMXuBsjrnLdH+ThzU0+DMZ0
         K2bM6B2v0oWTETnPfRM14qjN+rX70KtNAYY2MgggvZtvNX3cUaKEcnnCT4MMvuopI0D7
         jpRtlJT0wkJ1WI2GegFJi/59AAhS2PWEYjppgasxQqe57G2VEn2PWHltXaj2IASZksSP
         CxHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF8nOLYUH2hFAY9XuPLT92Kvwa/0YSnJvFhWhYuX7Kuea9upl+OuUAq9a+QwfszYBB9v28o6d2o6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNNZoZ6HAOscG02WRNo9EuT7UdMUI4XtMbj1l8E+88bzscr1BG
	q9JGDO9qetuoZcpYzygTXlqtnkG6mOQcNtV8EgNNmAujfEEimZGfgpha3rzzRaVdvTo=
X-Gm-Gg: AZuq6aIa9SnOMFyZryQ4FiYqsHeYv9Ju2HSI4VJl5HSCy96qwrwbs9lfKRn3YPTWElY
	n8jb7S9YNl6PCCT7l/nNv8TQtxkytwRiOxL/74iLCBExPnMrDTeCeACdVPC1pHr7ls6szjzqFEo
	tlX+utlAzaQcGOK/r68E2faPUgrLGbheifpEI0BoE3bA3BCJZd4ac10wd2w+RQHEC9QrXLxiWRn
	6N6bVkFgaH4tsiMppfyvfr08yB8S//xNWVQq9udrafLovtVX2RsnNBYK23CuxqLT4Ub86SUaIuL
	b7yfyfHRE6KRvJdQhGWWVdE6rMf4jg3JeCikIWX5C8cbgJORMb1jwTg9uKPdTeIgkR5SfrorMFB
	Skgw97elUfI+Y4M3Fcxwh8oJ2Zt6Bi1q3i+4Y2bufoleYsY1YO4t2S9h1YaPNpOAu0rFMUcIZ6p
	gteg8eYitD5jTrfA==
X-Received: by 2002:a05:6820:807:b0:662:c553:f773 with SMTP id 006d021491bc7-662cab0af25mr1991010eaf.25.1769200728584;
        Fri, 23 Jan 2026 12:38:48 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:198f:2b50:c48:1875])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-408af888da1sm2167805fac.6.2026.01.23.12.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 12:38:48 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 23 Jan 2026 14:37:29 -0600
Subject: [PATCH v6 6/9] spi: dt-bindings: adi,axi-spi-engine: add
 multi-lane support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-spi-add-multi-bus-support-v6-6-12af183c06eb@baylibre.com>
References: <20260123-spi-add-multi-bus-support-v6-0-12af183c06eb@baylibre.com>
In-Reply-To: <20260123-spi-add-multi-bus-support-v6-0-12af183c06eb@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1434; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=xGdA4shyG2YCvuBGh2md3PDf5DNCGZXwZPSKvqxMkg8=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpc9wwf/DD6p6dx3xldEec+/4EaAeYpbAs1/F3J
 ScoCZH53nmJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaXPcMAAKCRDCzCAB/wGP
 wGrmB/9kc2C/18JRnJIfaukRhqgo7WOfAudo1S4mWl7ghysu38eESv1Ii+24C+i+pZDc5qvjOoe
 eI5v6HVsrrzLQQ5iAmky2qQZDSz8l7D2PiT+nD0rUiG/hN2XegaUWzToEo7AVFo6Oui6wRV30dS
 rDTdPbcYlpfCm6G2JYPHutG2zodpGo8OTbIXNh9yAoWIETW7RZv2baOeLrBS64VYV8rEWiVPS81
 aKlw9wc51pdMtySPTHQo6ZLDz7n29UXWIRrwNq3SAmZQDGJL/XhBxc8gOT+foVkeCgnueLDDqCy
 DuiA+Sz80qHv2DFurAScljF2UGTjeFn2Cn0yg125/WMnvhP/
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Extend the ADI AXI SPI engine binding for multiple data lanes. This SPI
controller has a capability to read multiple data words at the same
time (e.g. for use with simultaneous sampling ADCs). The current FPGA
implementation can support up to 8 data lanes at a time (depending on a
compile-time configuration option).

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v6 changes: none

v5 changes: none

v4 changes:
- Update to use spi-{tx,rx}-bus-width properties.
---
 .../devicetree/bindings/spi/adi,axi-spi-engine.yaml       | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
index 4b3828eda6cb..0f2448371f17 100644
--- a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
+++ b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
@@ -70,6 +70,21 @@ required:
 
 unevaluatedProperties: false
 
+patternProperties:
+  "^.*@[0-9a-f]+":
+    type: object
+
+    properties:
+      spi-rx-bus-width:
+        maxItems: 8
+        items:
+          enum: [0, 1]
+
+      spi-tx-bus-width:
+        maxItems: 8
+        items:
+          enum: [0, 1]
+
 examples:
   - |
     spi@44a00000 {

-- 
2.43.0

