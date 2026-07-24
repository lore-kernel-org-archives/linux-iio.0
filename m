Received: from MTA-13-4.privateemail.com (mta-13-4.privateemail.com [198.54.127.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E723AFCE1;
	Fri, 24 Jul 2026 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924905; cv=none; b=S9Jafc9g9Yf4fUE5+8YsVvKwu1ziv9o6kvhWTLMozXVfiSOfIjZL2k5/Z+4kyPonmMibypuDWVJFLK6gXmIPX1KqNa+XsMvv/B/MiNziCcP+SJ1FTXnJ5NS6h69Y6WppDuAyfaQttedtHsFWzxpbPv8/9oXf0WFGlHdHaNu/JDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924905; c=relaxed/simple;
	bh=XyrXRsyc30ir3fHv2V7fCrfaKeiF+YOfW7mtmSAJ2ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQc2bhYcI0pboPblxRNsushi59DDX6Ik+6mO9zJ2ddSnxGHfJ39UGdV4szci4KKGoRKmKT2LQJOU//8G15jwDHc5UlAb0HYZ2rRqECjp3p4Xnb1mJzDYEH68G2Fmpx2+tZ7O37nEP4ecJplwFayE5+RPKP3g+X2VK/Muf1AaQKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.127.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (K8S-PROD-WORKER-08 [87.215.145.39])
	by mta-13.privateemail.com (Postfix) with ESMTPA id 4h6KLb6TPQz3hhTw;
	Fri, 24 Jul 2026 16:28:06 -0400 (EDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] dt-bindings: iio: imu: icm42600: add icm42630
Date: Fri, 24 Jul 2026 22:27:07 +0200
Message-ID: <20260724202708.128267-4-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724202708.128267-1-jorijnvdgraaf@catcrafts.net>
References: <20260724202708.128267-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TDK InvenSense ICM-42630 is a 6-axis IMU of the ICM-42600 family,
found e.g. in the Fairphone 6. Document its compatible with the
ICM-42631 as fallback: TDK confirmed the part is similar to the
ICM-42631 and driven by the same driver without modification. The
dedicated compatible records the exact part so a difference can still
be handled if one surfaces (the part has no public datasheet).

Link: https://lore.kernel.org/all/BE1P281MB1426D6579C0E2709574549B6CEC22@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM/
Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
v2: restructure the compatible to document the icm42631 fallback and
rewrite the commit message accordingly; drop Jean-Baptiste's v1
Acked-by given the rework.
 .../bindings/iio/imu/invensense,icm42600.yaml | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 119e28a833fd..39d8afd8d4a6 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -26,14 +26,18 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - invensense,icm42600
-      - invensense,icm42602
-      - invensense,icm42605
-      - invensense,icm42622
-      - invensense,icm42631
-      - invensense,icm42686
-      - invensense,icm42688
+    oneOf:
+      - enum:
+          - invensense,icm42600
+          - invensense,icm42602
+          - invensense,icm42605
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

