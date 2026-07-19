Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC1F373C0B;
	Sun, 19 Jul 2026 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784454723; cv=none; b=euXWM9o7ARFreNlqCwNnEmgKM+wntMs9gAnz+bFU+1VwAMNBYz/GaaN+bOtgtZaYj0qn3nziT/7wXcEBd7+4nqBq+VXCKtCtlJRCGGb/J/gXLieYWgE6iTw+NG6dQCCktdgGqDv7ILyinOI/ZK+TWFuorKr3WpOWY+ig2f3sHE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784454723; c=relaxed/simple;
	bh=xQ7i5O7xzqtX6gPknQYlgjTSO65uAy4SX/x/+L0kdKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mlcM3X7Py//Y1u+BBMjFofSEbuDpCemg5ArwveQ44or4zPhI+jI2tUr1kYFZgRSji9QO9mTj0NoK+nrEVZLNyxASnBXgNwbIwGcBGr4YDvIHbC8MJPD37QNtlqjNV51tZqm3W7S6S0VCfyCcC/Vwj/ni1e/ZzFOeS+6WF0G1kzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8zMjF4k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8zMjF4k"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 089D2C2BCFB;
	Sun, 19 Jul 2026 09:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784454723;
	bh=xQ7i5O7xzqtX6gPknQYlgjTSO65uAy4SX/x/+L0kdKM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=s8zMjF4kJjKSoBblQJW8sdKL/cQjFsoeMiDH2CjHRFILNQUf8cq/OedaOoRXU1t7K
	 jGwC8I16EqFz+rvO0/jtqjIdxvwE2zc2/IxKOUioLFvpfKoPMHIw8JYs1d8P5h1gc2
	 Mk0yo1aKzcaF/ASzdz6Bt4B9/CIxjDASE8OGSwUXEkbv8Sc00IfpwIOUTkRbPWTk+T
	 mI1Z6jhKEzBgMNvPL7jcYo0tuEw17PwsrY2fXChTNVHcv6ME1aXVlO2FFL4Hi1Qr3f
	 lFshIVymYTbNAd1rAUmcpAB2/LpngLCntxo0bRNCN9zlCcfEEudPRrBlsA9mQRmyfA
	 pqD6Sz8YtZABA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E040FC44512;
	Sun, 19 Jul 2026 09:52:02 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 19 Jul 2026 10:51:58 +0100
Subject: [PATCH 2/4] dt-bindings: iio: dac: ad5686: extend device support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-ad5686-extend-dev-support-v1-2-841ec75cf5d8@analog.com>
References: <20260719-ad5686-extend-dev-support-v1-0-841ec75cf5d8@analog.com>
In-Reply-To: <20260719-ad5686-extend-dev-support-v1-0-841ec75cf5d8@analog.com>
To: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784454721; l=2105;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=Ns24MscU2vZDNQferz6p0S9pqqd8IKrb5WBkwEhcXhc=;
 b=qu6jyXzAx/LKcXaOQ7rhVrFJsQuiHXJNmXwyF8+XfOc0EeHVK2jqeN5GbIp+6ZkRsIsiEFCwv
 Y6KznEmjsV9D58tlEGfAEc/daS1t92ZMMheYuma75EMkLFyFsVfP7Pz
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add compatible entries for AD5313R, AD5317R, AD5674, AD5679, AD5687,
AD5687R, AD5689, AD5689R. These devices have unique combination of channel
count, bit resolution and supported command set, so that fallback
compatibles are not used. Also, a small copy-and-paste error is fixed to
the title field.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
index 02e8c78e36d3..d1bb09054440 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/dac/adi,ad5686.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Analog Devices AD5360 and similar SPI DACs
+title: Analog Devices AD5686 and similar SPI DACs
 
 maintainers:
   - Michael Hennerich <michael.hennerich@analog.com>
@@ -14,10 +14,14 @@ properties:
   compatible:
     enum:
       - adi,ad5310r
+      - adi,ad5313r
+      - adi,ad5317r
       - adi,ad5672r
+      - adi,ad5674
       - adi,ad5674r
       - adi,ad5676
       - adi,ad5676r
+      - adi,ad5679
       - adi,ad5679r
       - adi,ad5681r
       - adi,ad5682r
@@ -28,6 +32,10 @@ properties:
       - adi,ad5685r
       - adi,ad5686
       - adi,ad5686r
+      - adi,ad5687
+      - adi,ad5687r
+      - adi,ad5689
+      - adi,ad5689r
 
   reg:
     maxItems: 1
@@ -84,10 +92,14 @@ allOf:
         compatible:
           contains:
             enum:
+              - adi,ad5674
               - adi,ad5676
+              - adi,ad5679
               - adi,ad5683
               - adi,ad5684
               - adi,ad5686
+              - adi,ad5687
+              - adi,ad5689
     then:
       required:
         - vref-supply

-- 
2.43.0


