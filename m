Received: from out-2uec-a106.jellyfish.systems (out-2uec-a106.jellyfish.systems [63.250.43.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A591E1024
	for <linux-iio@vger.kernel.org>; Sun, 23 Aug 2026 00:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787445561; cv=none; b=ntLmnLIUWAo1RPGZD9zWdW4RplPlgEuUBSLzvQChdzKpVisP09mqGscXNKTbcCIhP1MHvLiftyWe529anyspiuRBnaUaWpJELni6j635zzMGK9IXLIz8OGeMRYmxBtcbGHdJlnOh1vacFq0FK91vRA5DfH3vLlE1aOK/35kPBlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787445561; c=relaxed/simple;
	bh=/fwlB3mZ7oOlrc6UmNl0+D4YT+UrZyvZqvTW0ELXY7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvNfBQ7cNQi2x2dovhdMGa8CVt1Z4zgtEbozrFVDu0nPwabAQfE7p9OLjvTO9XmM575O1BGyw81Wsd3hHuVnQGWlVnC43TPXjZWCr/ZL2gvPqFbBN102ixAH169z7B0/ravvh/9jx+7Y/rIBHsz+zat/IVJ+hRmLxh1BK5gN9JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=63.250.43.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hSFQX6MsRz8sWP;
	Sun, 23 Aug 2026 00:33:40 +0000 (UTC)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Jonathan Cameron <jic23@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Luca Weiss <luca.weiss@fairphone.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 3/3] dt-bindings: iio: imu: icm42600: add icm42630
Date: Sun, 23 Aug 2026 02:33:20 +0200
Message-ID: <20260823003320.62192-4-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823003320.62192-1-jorijnvdgraaf@catcrafts.net>
References: <20260823003320.62192-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: jorijnvdgraaf@catcrafts.net

The TDK InvenSense ICM-42630 is a 6-axis IMU of the ICM-42600 family,
found e.g. in the Fairphone 6. Document its compatible with the
ICM-42631 as fallback: TDK confirmed the part is similar to the
ICM-42631 and driven by the same driver without modification. The
dedicated compatible records the exact part so a difference can still
be handled if one surfaces (the part has no public datasheet).

Link: https://lore.kernel.org/all/BE1P281MB1426D6579C0E2709574549B6CEC22@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM/
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
No changes in v5.
v4: rebased over the icm42607 and mount-matrix changes to this file
(no content change); added Conor's Acked-by.
No changes in v3.
v2: restructured to the icm42631 fallback form; Jean-Baptiste's v1
Acked-by lapsed with the rework.

 .../bindings/iio/imu/invensense,icm42600.yaml | 24 +++++++++++--------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 81b6e85decd5..9e22b603d47f 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -26,16 +26,20 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - invensense,icm42600
-      - invensense,icm42602
-      - invensense,icm42605
-      - invensense,icm42607
-      - invensense,icm42607p
-      - invensense,icm42622
-      - invensense,icm42631
-      - invensense,icm42686
-      - invensense,icm42688
+    oneOf:
+      - enum:
+          - invensense,icm42600
+          - invensense,icm42602
+          - invensense,icm42605
+          - invensense,icm42607
+          - invensense,icm42607p
+          - invensense,icm42622
+          - invensense,icm42631
+          - invensense,icm42686
+          - invensense,icm42688
+      - items:
+          - const: invensense,icm42630
+          - const: invensense,icm42631
 
   reg:
     maxItems: 1
-- 
2.55.0

