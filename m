Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B104AD7C3
	for <linux-iio@vger.kernel.org>; Mon,  5 Oct 2026 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211501; cv=none; b=O07i0KMCEnzQUyrFa9Fc3WwA+niRd2f/o8zfdnYFYHioRdZkk/1S3zjcbcak2fm/1N475xkprHn6agIoK9Gx8RxrMxYEx7M3nK5mmx1nSLZoq9Sx9+GE8YAMk0Bw7gB/yjgHLcvbTFhJj8SzKfJMBz8N52IaagU1io/UMyapLhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211501; c=relaxed/simple;
	bh=00xXxje2eYXvEpO2aJYOgU4qt/GQxE31+kafasRoRlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yk8VCPNHy2PM1uvW6Stku3KDhr0dpXJifHQDsMADi3U4apimGNtKutqgEsyAEvxe+nhJ9J0Bu3RkTc2SOBNExS5xzFKZ6+d1Lr08lUGQvgdl1GCP94H3yDc7480T7gHufCJhugzvCe/JN9Cyo5piEPBnTHbQ9E++80cgNV7zGj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nyn1rR8o; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nyn1rR8o"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A31344E41196;
	Mon,  5 Oct 2026 14:44:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 718D7601A5;
	Mon,  5 Oct 2026 14:44:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 577B710330276;
	Mon,  5 Oct 2026 16:44:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791211481; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hMxdyexo4l5HGhUgo/GUwSIuZrTtepiSoK2kHWK7s6c=;
	b=nyn1rR8oRE4aPwTZXiMD/1foVMK3/NIA66cWBRs5aMR4uclQhrI/MFPoIXwtKw4So342IY
	QQu6Vxye3eEekQDvhYgnsrxdAf6Pbf6j5r9Gw/mTqvmnWUEwhKw623T4bXanpOX8cpY4Nv
	w6dDRvntr0mdmgQVFRlKfPcWAXDYzG9HjFh1YS5sl9LIygr0dOhCgcibk/NkpZeao8Yv9c
	j1B+BmFhAPP2nFA/86L1gv2A4LUvrsWKonUCmc30QcE/QlsHWB5DblTWok++EijVpOZaha
	Yeg4GLz8lk+4QMg/3Elkpmb/kOUao/9AkfXfAjMNv2KGyZoNK3kbRV7guVxuMA==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Mon, 05 Oct 2026 16:44:19 +0200
Subject: [PATCH 1/2] dt-bindings: iio: ti,tmp117: describe interrupts for
 TMP117
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-add-tmp117-notif-v1-1-c6cef6fad64c@bootlin.com>
References: <20261005-add-tmp117-notif-v1-0-c6cef6fad64c@bootlin.com>
In-Reply-To: <20261005-add-tmp117-notif-v1-0-c6cef6fad64c@bootlin.com>
To: Puranjay Mohan <puranjay@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1443;
 i=thomas.bonnefille@bootlin.com; h=from:subject:message-id;
 bh=00xXxje2eYXvEpO2aJYOgU4qt/GQxE31+kafasRoRlo=;
 b=owGbwMvMwCV2Z+MHT+XNR6wYT6slMWQd3n5heu7pF+svKTWnXIlmO/x0uW/HbsvDDtckBOJcJ
 X6cLH/6saOUhUGMi0FWTJHlgn9qicDiE8Yp6WETYeawMoEMYeDiFICJrORk+KemEJ8Qpngy8+3v
 55snBu3c4STuZr7zBMPR2o7DrQ9aNmkw/HcpvtPX2+7zVbB6s66uTL17tPrnJaxaVnucE5YG9/B
 eZwQA
X-Developer-Key: i=thomas.bonnefille@bootlin.com; a=openpgp;
 fpr=D04F657410A3C83364675691DCB1F04923B3C43A
X-Last-TLS-Session-Version: TLSv1.3

The TMP117 can send alerts when the temperature crosses a low or high
limit. This triggers an interrupt on the ALERT pin.

Add the optional interrupts property.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
index 7fb3e68207919..68ee936722ded 100644
--- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
@@ -30,6 +30,11 @@ properties:
   reg:
     maxItems: 1
 
+  interrupts:
+    description: |
+      Interrupt line connected to the ALERT output of the sensor.
+    maxItems: 1
+
   vcc-supply:
     description: provide VCC power to the sensor.
 
@@ -45,6 +50,8 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -52,6 +59,8 @@ examples:
         tmp117@48 {
             compatible = "ti,tmp117";
             reg = <0x48>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
             vcc-supply = <&pmic_reg_3v3>;
         };
     };

-- 
2.55.0

