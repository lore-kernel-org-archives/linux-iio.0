Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795340056;
	b=kxrDM2OA+r42Vww6DbkaN6T6W1uf6+FZxgTctDE19LJZ/hShGXh9D8DGKEwk8YEV2AO2
	 oEzbnTYHT1JzzBEu6Ob8/l8qyANNIcSd6Lf2XTlsxwuRLeDYls4WGoxNi7Ba9oubFAq3R
	 lSp7XtBv9jpRSdM0ohTucx+oNgUW7RQkGTzhI6qjQLgvaqKp+cYzqvbeKFBOurUHBI5HQ
	 znE1BR4HAzkOgbNN2uDsz0IiQAc6jHStnSrVN8/L44jEbeSZFKGPI8Qdpc4IR5+FQ7odF
	 0simFfby7jVmV/cVgAG12t9fhzIQc80cwiVetZ/oMe3HNsaCl1vg9DN1BO+41yCvPzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795340056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+2xrspYuu+FL47jccjzdtxpgEf6qiE/xXRLpMfETdrM=;
	b=LkKJeVXNPXSwz7R5g8IsUdCc52KkGbXW31d/PUFY0Ea2aGwr+SswhhcBqtXqfF2wiJTa
	 Nquo6/EhesW3HQJRsMypRbkjvsuNRVe5WEoIWQNXqT826GW4UiZcGMC+UjBfGNcc3ZXio
	 KBiTUloNJ7Zp5/LMZuypjU1mnkUYOseYE5sQ0yCdIE4o076ptEZcQM18FGw3n7cldtMCI
	 4EUcNju7TKrbDfFQeEwF+ODtiB+5eiQFI/dIH9qLuzUKu4r/ckXbmVH/TSGK9dPlFDKxL
	 gDw+1L2aRAu+OsnvCduRMibQl694RxTbC0IS5J7mEJGtnYUYNpyLcGoN0vAMBFTmLhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bmjpe7XS;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4AF606A330
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 09:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E4AF606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bmjpe7XS
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so20887985e9.3
        for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 01:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795340054; x=1795944854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+2xrspYuu+FL47jccjzdtxpgEf6qiE/xXRLpMfETdrM=;
        b=bmjpe7XSigsNo/RmiY/EbMiiQNhopFLdUm/1jAJvD+kMQAWiRIwUHz+tmo3w/+zYHr
         fMQDJYRSqoj1mI8kaASKDRaoyWIZboEO/enrNzaavHO4BbahVNAYjcWCsi0W3WCSDfcX
         XYFmLk9tITHWlRWyb8N9hQ7IklRjgIn9NdQLI6Oykom4Z4uPKXNpvk1PQCDIheMkbO6k
         3u8YwMJyYsZxnoR1h5HB+DeGrSW2cHlLfueuH+kWJ1VlbF59wMtBehHTL3tS8SUL9rPo
         gylPAHC/ETCivXluHRfK6894vm6BwUy+sfxydJT6fGfoLnye3Ze42R6+UfXwtRJZ5zNf
         beVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795340054; x=1795944854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+2xrspYuu+FL47jccjzdtxpgEf6qiE/xXRLpMfETdrM=;
        b=DefD7rBmGEMMsGUSvtSQmTXm12aCCDCWy04P8i4d8Iv9tn8TBxNB+2z2+1JSeLIhNO
         MfyTem/2zQjcls4aF3iBJymJsvT5SwXkMO22R7CmHaZafcEFrzxZ/Qnz048I7VS8Y70/
         sgb/ohTosoqHf8j/9ymqDhLwBKrvmwWNrSHVcazNpU5l4oDkolVqYlIq6EqgdovQO5T1
         ZfOQElM1LNhbfW/99J7eKCiHuEos0T7sLBhxZo0IiHCEHIH/ghOv7koYxWJs/UvZQpQM
         SdA2thLqj3fbgMmJdkCc+TTsKTJ+EPJshgNl/YhGEsaVn/UL5Y5OidkrhgTXdG6WPK7N
         zV1w==
X-Forwarded-Encrypted: i=1; AL+hErEGCL4dcvvFv9A7c/t5MlHC3EdzHJRoW7EWcFfKAdEXkbv05AE5rCtt9s/m8DO+sKUfWhHdeO+aTNs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HkluFq47OLNU36JPLvA0GFOuRB8hWmuerR+Df+3F/xKybs6pl
	VOopLQEvwAN/LaEN2Nixq3i9bfmM3jVcF7hYA0mcKE6ALb2Lt3nxrmudWnj4twObWaQmVfQKfKV
	q7Km1IgjWsTG5
X-Gm-Gg: AZFdTZc535d0KjGx1hHL0Ri3CxF+K0dLKhHwzP6GCXgVSi22NNqbh/6kkjtG7qPWjOz
	PLJeva91L8ibA+o09Et7UjJ5DncBX4p88QOO2GYXFB4hRgi1MIukJNSO5+funaNT0KLScHJHXxD
	NuTwiim1Fe7iHSbR/26lfCZNf+REC3ZdIimVHFJDEt0hNmkJxbqPvXkDXn5BSddxDBRKy7Hu8bn
	5dxM3BapkOBFEfyoj90NA4LfZED42HwWMUrfrbTj8dyKCahB380MH3+2PvMcNctr/zCOM0viPs4
	dXJu08XqTpK0zI+DggR/G4a3bCpgBd2H56OHTrhkUi0GWRdZzTllYp4SsoZZumhM7HAQxhaCLLR
	UJpU6dFMcDPPmZRyoVMy4oGHgsAwce1Qb1+ckLf/3t89i0HwIKZok9Iyo983O97UlVB0W1S2d4a
	kid3KF5fMxhZX/VJZFk1kGUyqUFWfe5dVYPdU6XQYX4GV5PDneBRCUegHxGqQPUtnXjQewLqzKj
	62omNOuJInq3+wPWDiuqLgunFoBeuQFbYJin77qAL3Cb3d7mOUHT30zAI27tLfkjSaXfIJzwdo3
	Bszh480MOKhzJVjLq1iAlz1QG23jY267JX/zxe+o64fMXSKX0pEtSw+8NTxMxIkOYew3D4CrgkL
	5vsUXeHp+Ou4=
X-Received: by 2002:a05:600c:530f:b0:4bb:68b9:f615 with SMTP id 5b1f17b1804b1-4bb88810b22mr173144325e9.17.1795340054581;
        Sun, 22 Nov 2026 01:34:14 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884911e3sm291475195e9.6.2026.11.22.01.34.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 01:34:14 -0800 (PST)
From: Gerard Marull-Paretas <gerard@teslabs.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: magnetometer: Add MEMSIC MMC5603
Date: Sun, 22 Nov 2026 10:34:12 +0100
Message-ID: <20261122093412.71604-1-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MMC5603NJ is listed in trivial-devices.yaml, which allows no
properties besides the register address and interrupts. Boards need to
describe how the sensor is oriented, and the supply it runs from, which
is often switched on wearables.

Give it a binding of its own with a mount-matrix and its single VDD
supply, the package having no separate I/O supply pin.

Signed-off-by: Gerard Marull-Paretas <gerard@teslabs.com>
---

Notes:
    Checked with dtschema 2026.9: the steps of dt_binding_check run by hand (host make too old), yamllint and dt-check-style --mode=strict.

 .../iio/magnetometer/memsic,mmc5603.yaml      | 45 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 2 files changed, 45 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5603.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5603.yaml b/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5603.yaml
new file mode 100644
index 000000000000..039f53a5f912
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5603.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/memsic,mmc5603.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MEMSIC MMC5603NJ 3-axis magnetic sensor
+
+maintainers:
+  - Gerard Marull-Paretas <gerard@teslabs.com>
+
+properties:
+  compatible:
+    const: memsic,mmc5603
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor
+
+  mount-matrix:
+    description: an optional 3x3 mounting rotation matrix.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        magnetometer@30 {
+            compatible = "memsic,mmc5603";
+            reg = <0x30>;
+            vdd-supply = <&vdd_1v8_reg>;
+            mount-matrix = "-1", "0", "0",
+                           "0", "1", "0",
+                           "0", "0", "-1";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index a8b2b9deade4..17a32dd8772e 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -261,8 +261,6 @@ properties:
           - meas,tsys01
             # MEMSIC magnetometer
           - memsic,mmc35240
-            # MEMSIC 3-axis magnetometer
-          - memsic,mmc5603
             # MEMSIC 3-axis magnetometer (Support I3C HDR)
           - memsic,mmc5633
             # MEMSIC 3-axis accelerometer

base-commit: c44104f3642da720164042623e4832836aefdd8e
-- 
2.45.2

