Received: from out-2z4y-a131.jellyfish.systems (out-2z4y-a131.jellyfish.systems [198.54.127.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B5C453A30
	for <linux-iio@vger.kernel.org>; Wed, 26 Aug 2026 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787767225; cv=none; b=j9K9X7EYU1ffM4aTLt09OrXgTvikJ2ieruyrYk7AwDlTf07i4sVF+1SpCTOFbBSzYp0uG+vyhcidytv6XXPAuDJmJrTCEWK1R5d7Pb7pxx26DUGgsU6LvOm0WmwYtUlRSaK4NRz64BupYpncoUWz4fUqciUO0HA7lb/13msRLfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787767225; c=relaxed/simple;
	bh=n8EG6axqjMnfb5vB4Ik6vvRPTgDNmmVhOQoJ89A9+Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTNIcr13+z1fiC38px0lGAs7OBuslFRZTIfT2nPjB+r94bRuwvmcfRv7WoaRwymkeAiWsRd9aXRTN8MwFs/Q90Dqlp6hLJ10cj/dJeBSDFlapACvkTyut91KH3NcIhO2Ln+oPnkIEwoD2/FFwJ9NWdjW9YGFG6Mkj5eeXoVqHu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.127.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hVXMz6q3mz8sWP;
	Wed, 26 Aug 2026 17:54:23 +0000 (UTC)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>,
	Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 2/5] dt-bindings: iio: light: stk33xx: document the Sensortek STK36C61
Date: Wed, 26 Aug 2026 19:54:06 +0200
Message-ID: <20260826175409.326131-3-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826175409.326131-1-jorijnvdgraaf@catcrafts.net>
References: <20260826175409.326131-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: jorijnvdgraaf@catcrafts.net

The STK36C61 is a 3-in-1 ambient light / proximity / RGB colour sensor
found in the Fairphone 6. Its ambient light and proximity register
interface is compatible with the stk3310's, while the dedicated
compatible identifies the part, whose colour channels the fallback
does not describe.

Add sensortek,stk36c61 with a sensortek,stk3310 fallback, mirroring
the stk3013 entry, and widen the title and description to cover the
part.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
 Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
index e4341fdced98..0165a348918b 100644
--- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
+++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
@@ -4,14 +4,14 @@
 $id: http://devicetree.org/schemas/iio/light/stk33xx.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: |
-  Sensortek STK33xx I2C Ambient Light and Proximity sensor
+title: Sensortek STK33xx/STK36C61 I2C Ambient Light and Proximity sensor
 
 maintainers:
   - Jonathan Cameron <jic23@kernel.org>
 
-description: |
-  Ambient light and proximity sensor over an i2c interface.
+description:
+  Ambient light and proximity sensor over an i2c interface. The STK36C61
+  additionally provides RGBC colour channels.
 
 allOf:
   - $ref: ../common.yaml#
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - sensortek,stk3013
+              - sensortek,stk36c61
           - const: sensortek,stk3310
 
   reg:
-- 
2.55.0

