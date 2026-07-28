Received: from MTA-09-4.privateemail.com (mta-09-4.privateemail.com [198.54.127.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE1739EB73;
	Tue, 28 Jul 2026 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785264309; cv=none; b=iisCZiMm+zATT0lcSPIKcEzTFyWBiMqSaCfEoeXcKkjGegkfjLtClhjIp/KynQgYfWH8xaFnKZbFeQosfN6I9QvLIfbDy5Ll5fN3DSD21sMAmEYfz5yivIqpIlhWI/uUp1T/EkcbCpIF9jwsr1PgQwQ/piyB5OT3K6C2wsZCxq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785264309; c=relaxed/simple;
	bh=YhI6hKgTdyUNBBn9Al23hvQ2sKjhgAGSmLBho4+N9tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cn47wAL017PcgAAjoJKHDDQbyJPo+cBjWpNpscGmi8O295WscuCVW0TM60sGJ5ehsyUuQDyzgmVxYmwWQeeQLx9pKZGaI0nYfRT2vPP0KknCyuF4MTFrpQC53C+9HFNsdi8fu7sQuHR8NKDohTtirE89ddumjqtRpsOEjjgGKWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.127.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (K8S-PROD-WORKER-14 [87.215.145.39])
	by mta-09.privateemail.com (Postfix) with ESMTPA id 4h8ksb3B4Bz3hhTQ;
	Tue, 28 Jul 2026 14:44:50 -0400 (EDT)
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
Subject: [PATCH v3 3/3] dt-bindings: iio: imu: icm42600: add icm42630
Date: Tue, 28 Jul 2026 20:43:51 +0200
Message-ID: <20260728184351.75015-4-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728184351.75015-1-jorijnvdgraaf@catcrafts.net>
References: <20260728184351.75015-1-jorijnvdgraaf@catcrafts.net>
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
No changes in v3.
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

