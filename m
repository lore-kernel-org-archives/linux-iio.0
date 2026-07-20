Received: from MTA-11-3.privateemail.com (mta-11-3.privateemail.com [198.54.122.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6763E43F8B2;
	Mon, 20 Jul 2026 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.122.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784568901; cv=none; b=Z7FAsRH6oXQiEbjMKVoGq7cPLQiz1HzWBCmzKdaON+wUeZxOwtNjwljnip4PHamJ2GjAjHl0kPOVcfOiwHd5PI2kSQje1I2qv+ctmveTzRvw95qpKaZMUsrwIbY/TmI0NJXpbssj835FaynafPOIf72QBEpL0+Ywnvu6kI/EYNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784568901; c=relaxed/simple;
	bh=KC2N0m9PC2Lo7auhaRMiKObomRDsbr7lrqlo9r3C8zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOleeJBNgnXWayBwMvnJ/WcKF82Z0Edw0InEoNewRwl80jvGkSVGPx6VoTzZvusn9MDTquCwAg0bjZyTOuI/80MovYrOk/uCnP6RajeISRzwO0EIlHgH4XczHAGNGdkaQW8EfesUtTXVjIuv3cJzmJllgLmf+dLTSt+YfCWmBr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.122.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (K8S-PROD-WORKER-10 [87.215.145.39])
	by mta-11.privateemail.com (Postfix) with ESMTPA id 4h3nhD1pJQz3hhTX;
	Mon, 20 Jul 2026 13:34:35 -0400 (EDT)
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
Subject: [PATCH 1/2] dt-bindings: iio: imu: icm42600: add icm42630
Date: Mon, 20 Jul 2026 19:34:10 +0200
Message-ID: <20260720173411.82979-2-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720173411.82979-1-jorijnvdgraaf@catcrafts.net>
References: <20260720173411.82979-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TDK InvenSense ICM-42630 is a 6-axis IMU of the ICM-42600 family,
found e.g. in the Fairphone 6. Document its compatible.

A fallback compatible to a sibling is not usable: the part reports its
own WHOAMI register value, which software validates against the
compatible.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 119e28a833fd..add3a7fef09d 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -31,6 +31,7 @@ properties:
       - invensense,icm42602
       - invensense,icm42605
       - invensense,icm42622
+      - invensense,icm42630
       - invensense,icm42631
       - invensense,icm42686
       - invensense,icm42688
-- 
2.55.0

