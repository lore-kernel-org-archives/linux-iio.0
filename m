Received: from out-2uec-a97.jellyfish.systems (out-2uec-a97.jellyfish.systems [63.250.43.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E358384243
	for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2026 00:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223931; cv=none; b=r1BZVdDD+jUhLwIRAU3ISscdiVBPfKspba2E8eOd8Q5bohZsQezHhFABQGGTnu7CNzrgAcmVxQ3lPPf7a60ez2j8fG11JunantI3zBzE70pUTCFjsEln/mm4vEowCbjeaCxa85w3N9P37X9qmJv6uQw+GvEvapB8jn+ZsP0RmiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223931; c=relaxed/simple;
	bh=n8EG6axqjMnfb5vB4Ik6vvRPTgDNmmVhOQoJ89A9+Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJVgQBa6UWhuqXABBgx1zHeucUB1lsOH+18XgwbS/smY8VkzrDWOBrJdSJJFc69pXEWnxOm+K9OIZq81zL5zPIcvz2SiJZj44QY4TMkcILCfs49w7qNF05vFDIovmL9E9BLdzMkYvAri7nJLS7zbuBrbynCv/e5x+a95PsVcZRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=63.250.43.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hYnPF1bVmz2x98;
	Tue, 01 Sep 2026 00:51:45 +0000 (UTC)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 2/5] dt-bindings: iio: light: stk33xx: document the Sensortek STK36C61
Date: Tue,  1 Sep 2026 02:51:11 +0200
Message-ID: <20260901005114.203062-3-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901005114.203062-1-jorijnvdgraaf@catcrafts.net>
References: <20260901005114.203062-1-jorijnvdgraaf@catcrafts.net>
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

