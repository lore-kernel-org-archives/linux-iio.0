Received: from mail.imp.bg.ac.rs (mail.imp.bg.ac.rs [147.91.50.100])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A68386C30;
	Fri, 20 Mar 2026 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.91.50.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019445; cv=none; b=pQuh/nWlrK+uDZjJf1+ivH5qq1Fe3GNnBF/QvdC/5D2bLeBPyrc1OwbvYWS4bxOYG4AtrbQ6R0ufHUN965i580EhBc2vjHxI613p1gL9Xo7vUZJaNfHD82UsPvW7t3/+YE+u7yyxdiQpTvT6/j9ydpXFqUcGDj9E6pFMNgXoxqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019445; c=relaxed/simple;
	bh=zPYILTzsqjxa//iTx4+AhMkuBkF1RuazYPCTxYCHD98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TdmEbB6QkcuGp82ELfbhEzx7gkToBdISl8sRM6775Mns3fmUemJBXlD150He6OMU76h0+XATA9uz3su2rdu9KZDJw4+KtudLYj+gt6+EOAeIT1Y7SGaNWvSAla2MmdfBIyzL3XxjNvGlv+u7tHqk/bAQuo83KlNosds78rcZVaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pupin.rs; spf=pass smtp.mailfrom=pupin.rs; dkim=pass (1024-bit key) header.d=pupin.rs header.i=@pupin.rs header.b=DKZp2UGS; arc=none smtp.client-ip=147.91.50.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pupin.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pupin.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pupin.rs header.i=@pupin.rs header.b="DKZp2UGS"
Received: from localhost (localhost [127.0.0.1])
	by mail.imp.bg.ac.rs (Postfix) with ESMTP id DF0B3140C678A;
	Fri, 20 Mar 2026 16:10:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pupin.rs; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=dkim20260301; t=1774019433; bh=zPYILTzsqjx
	a//iTx4+AhMkuBkF1RuazYPCTxYCHD98=; b=DKZp2UGSQ0ISsxpXQyJRgUtyKRU
	atDP4nTbw4UYg5ZQdHIKLdb+19RFWZ17IDQiQLHlMFy8VFaMC/yqMEw9gyF1q5D9
	mPR6BtSqSjRUzQECocWJ1Hh9gWcOoO1KUxQjeBEU8pWNe/HBb/THys3SEjA1zfBD
	VLnzgjUtX6BhACeQ=
X-Virus-Scanned: amavis at imp.bg.ac.rs
Received: from mail.imp.bg.ac.rs ([127.0.0.1])
 by localhost (mail.imp.bg.ac.rs [127.0.0.1]) (amavis, port 10024) with LMTP
 id T2JmcpXxCL6z; Fri, 20 Mar 2026 16:10:33 +0100 (CET)
X-Comment: SPF check N/A for local connections - client-ip=147.91.52.78; helo=phyvm-virtualbox; envelope-from=david.marinovic@pupin.rs; receiver=jic23@kernel.org 
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.imp.bg.ac.rs B131F140C272C
Received: from phyvm-VirtualBox (unknown [147.91.52.78])
	by mail.imp.bg.ac.rs (Postfix) with ESMTPS id B131F140C272C;
	Fri, 20 Mar 2026 16:10:33 +0100 (CET)
From: =?UTF-8?q?David=20Marinovi=C4=87?= <david.marinovic@pupin.rs>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	michael.hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Marinovic <david.marinovic@pupin.rs>
Subject: [PATCH v3 2/3] dt-bindings: iio: dac: ltc2632: add LTC2654 compatible strings
Date: Fri, 20 Mar 2026 16:09:47 +0100
Message-ID: <20260320150957.105571-3-david.marinovic@pupin.rs>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260320150957.105571-1-david.marinovic@pupin.rs>
References: <20260318135736.91564-1-david.marinovic@pupin.rs>
 <20260320150957.105571-1-david.marinovic@pupin.rs>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Marinovic <david.marinovic@pupin.rs>

Add compatible strings for the LTC2654 quad-channel DAC family.

The LTC2654 devices are 4-channel, 16-/12-bit DACs with an internal
reference and SPI interface. They use the same 24-bit SPI command
format as the LTC2632/2634/2636 family.

The 16-bit variants (LTC2654-L16 and LTC2654-H16) require new
compatible strings, as no existing compatibles support 16-bit
resolution.

The 12-bit variants (LTC2654-L12 and LTC2654-H12) are register-
compatible with LTC2634-L12 and LTC2634-H12 respectively, and can
use them as fallback compatibles.

Changes added for:
- lltc,ltc2654-l16: 16-bit, 2.5V internal reference
- lltc,ltc2654-l12: 12-bit, 2.5V internal reference (fallback to lltc,ltc2634-l12)
- lltc,ltc2654-h16: 16-bit, 4.096V internal reference
- lltc,ltc2654-h12: 12-bit, 4.096V internal reference (fallback to lltc,ltc2634-h12)

Signed-off-by: David Marinovic <david.marinovic@pupin.rs>
---
 .../bindings/iio/dac/lltc,ltc2632.yaml        | 57 ++++++++++++-------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml b/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
index 733edc7d6d17..50a9cbb44e36 100644
--- a/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
@@ -4,36 +4,49 @@
 $id: http://devicetree.org/schemas/iio/dac/lltc,ltc2632.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Linear Technology LTC263x 12-/10-/8-Bit Rail-to-Rail DAC
+title: Linear Technology LTC263x and LTC2654 Rail-to-Rail DAC
 
 maintainers:
   - Michael Hennerich <michael.hennerich@analog.com>
 
 description: |
-  Bindings for the Linear Technology LTC2632/2634/2636 DAC
-  Datasheet can be found here: https://www.analog.com/media/en/technical-documentation/data-sheets/LTC263[246].pdf
+  Bindings for the Linear Technology LTC2632/2634/2636/2654 DAC
+  Datasheet can be found here:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/LTC263[246].pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/2654f.pdf
 
 properties:
   compatible:
-    enum:
-      - lltc,ltc2632-l12
-      - lltc,ltc2632-l10
-      - lltc,ltc2632-l8
-      - lltc,ltc2632-h12
-      - lltc,ltc2632-h10
-      - lltc,ltc2632-h8
-      - lltc,ltc2634-l12
-      - lltc,ltc2634-l10
-      - lltc,ltc2634-l8
-      - lltc,ltc2634-h12
-      - lltc,ltc2634-h10
-      - lltc,ltc2634-h8
-      - lltc,ltc2636-l12
-      - lltc,ltc2636-l10
-      - lltc,ltc2636-l8
-      - lltc,ltc2636-h12
-      - lltc,ltc2636-h10
-      - lltc,ltc2636-h8
+    oneOf:
+      - enum:
+          - lltc,ltc2632-l12
+          - lltc,ltc2632-l10
+          - lltc,ltc2632-l8
+          - lltc,ltc2632-h12
+          - lltc,ltc2632-h10
+          - lltc,ltc2632-h8
+          - lltc,ltc2634-l12
+          - lltc,ltc2634-l10
+          - lltc,ltc2634-l8
+          - lltc,ltc2634-h12
+          - lltc,ltc2634-h10
+          - lltc,ltc2634-h8
+          - lltc,ltc2636-l12
+          - lltc,ltc2636-l10
+          - lltc,ltc2636-l8
+          - lltc,ltc2636-h12
+          - lltc,ltc2636-h10
+          - lltc,ltc2636-h8
+          - lltc,ltc2654-l16
+          - lltc,ltc2654-h16
+      - items:
+          - enum:
+              - lltc,ltc2654-l12
+          - const: lltc,ltc2634-l12
+      - items:
+          - enum:
+              - lltc,ltc2654-h12
+          - const: lltc,ltc2634-h12
 
   reg:
     maxItems: 1
-- 
2.50.1

