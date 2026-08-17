Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31624611C7;
	Mon, 17 Aug 2026 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986566; cv=none; b=GN1RMAaP0+SG/2KmrhafMJ80H1GWuAZrPzFihti8cMK4mufmqWZBgvS3KDJ3urOQRqAu446NX40furxQuyBgxpzuNl7PijCJ9wTkvQ+J+yMwQ+dDawoXABw5I0Gvo1tDkBjodr5+jhERsyMl02RY7qPuLPSD0L4tz5IGsdbruIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986566; c=relaxed/simple;
	bh=PuTIb/HEZgC6l6OXlGmoUtC0biKNrJnaiw8tuXLtSMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cMwhntSOvE0ZIdhJ585SURkl+EuRry4lwjUiOnC0ccNsHPV3AidSuTT13dFJgDeMGH6SYoUYnckAXhIqIER0V+VHOvKH2B4JOF0rphj/2YhP86uJwZDmhNRSLgsWVjkZQJuTvZvoSX7RnVrhVWtW/ff5VH5e+zcrZb7/fjN34BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=BQufvYEw; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="BQufvYEw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786986556; x=1787245756;
	bh=0DL6SYmMsTzpZ0aoIUNZ/PQEipTLLNLteJIMw/nMfTE=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=BQufvYEwNji1XYxW71kuBtKt5NR0D/pnODeLYmTi7+SqEaPthq9gzkhvs8OYj6kQq
	 hQ4Xv+P9s+1TtMh8HQrwbKe9TU4cq5T8T7eWG618ggIONKY8+43s/noYeMjD1omQ2T
	 BTL6WzKNqokkjeYaTa/SQ6EQQOzXg8T7ZjgK50SiPaKzlRavyhVLA98oawBM0EMNP1
	 8vfbNjES1SfF69XkZG/Rj6I4fhK7rY0EqsgBZyjR7BL/uA8RK3LL08vBYl/hTr8yni
	 jNcf8BrV+D0bzC4G4izF0B3vBtlOzb0KWy5DewU6CMK8fsqyyawSANVVWR/pVNygHq
	 yy8SrBKztuu1A==
X-Pm-Submission-Id: 4hNzp04TJtz1DDWf
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 17 Aug 2026 19:08:52 +0200
Subject: [PATCH v5 3/8] dt-bindings: iio: light: ltr501: Add ltr329
 compatible
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-liteon-ltr329-v5-3-6f71ab2b0588@geanix.com>
References: <20260817-liteon-ltr329-v5-0-6f71ab2b0588@geanix.com>
In-Reply-To: <20260817-liteon-ltr329-v5-0-6f71ab2b0588@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786986543; l=1480;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=PuTIb/HEZgC6l6OXlGmoUtC0biKNrJnaiw8tuXLtSMk=;
 b=lx861XqUGOYl3UBoLgDX+7yn3RBewikW5tcdg4TCu/TV6Dh9K9PsWymVEbwU/BjpAyra+QC5w
 7XuxcZuCyaFAOqvir7mnI10Ou7YT/s+OdRa5pV4BPTRuX7SF9FTsTq/
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

LTR-329ALS-01 is an ambient light sensor similar to LTR-303ALS-01, but
without interrupt support.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 .../devicetree/bindings/iio/light/liteon,ltr501.yaml    | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
index 6234e2eaec2e..73c32b33d886 100644
--- a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
+++ b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
@@ -9,14 +9,12 @@ title: LiteON LTR501 I2C Proximity and Light sensor
 maintainers:
   - Nikita Travkin <nikita@trvn.ru>
 
-allOf:
-  - $ref: ../common.yaml#
-
 properties:
   compatible:
     enum:
       - liteon,ltr301
       - liteon,ltr303
+      - liteon,ltr329
       - liteon,ltr501
       - liteon,ltr559
 
@@ -37,6 +35,19 @@ required:
   - compatible
   - reg
 
+allOf:
+  - $ref: ../common.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - liteon,ltr329
+    then:
+      properties:
+        interrupts: false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>

-- 
2.55.0

