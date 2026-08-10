Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8126C43800D
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 19:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389708; cv=none; b=rUqh3518DjkIU9xteyrxDDjnNv2zlOQwv6JwvbX0wE0fTGY9LcLhBXyjFq+YbCrRBJ9Ibm+dYZ0hOXNzSFXcyxoXwl/8Y3CX1B6hyg5QFw/EdnVncCLeWMbcqHXySVqh95ZxCKUKi6ItuRe5O0l56Znve6MPjA/MmZK6eKgnUNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389708; c=relaxed/simple;
	bh=uD1oO4cs8uZhXoXFc8b/g7W+blWteUgwWte21V3SUJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lds6obApyCQz/1wsXcHCJsfzLKfE5Tp9Hfnf8oBqjl45qhPkgCBG8FVAvi2MtvA4aCiH7OtP6m6GNRpBIqdwq+oKx67Lv8J1DVrAbvMaI0Zaa/YiKl0P0wBiE2DdSkF6SWiXclbaKsgc/Bw+sNpbuUT+4eVp89Brx65Q2ugUv6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dr54znNp; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dr54znNp"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-664a09bc459so3172957d50.1
        for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 12:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786389705; x=1786994505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EuRXCZdD9fwaj8LGoLIYzfFtr1/F5wEoiyIlug7kGCM=;
        b=Dr54znNpnJ9lSnX/BPN0mrLom8wrblMKURKpffQ6kpe7zumzu6wzfeaUVfmRlHiaaB
         1Htf2+Iji5VHNiZR75CLbioHeoJSev21d1oGxo7tCJ9iz2pFzKq1/pWh1q9qWsAXGh/2
         yC689Wg3CtYL/SRlTYe89kyTNN/OY9TaCXNGyulm34nDApXGjrsejDgMfcXvvHLjajhO
         hcsBFdNGppqPEXL8sF3ty5Gn479xqznxj3gvb4hHHc3eQNUq6OK0yCH3cnP4EarTTf3y
         CL5Caq+PU6WUbhg1t/gfilAnUegeN59XrDbvhSa5l61Ijmh7LwjQjVaIjUg/nxMXLgul
         7WVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786389705; x=1786994505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EuRXCZdD9fwaj8LGoLIYzfFtr1/F5wEoiyIlug7kGCM=;
        b=pQyfVM29ugcI8spMrTS46U2NQUrMeUEQ1QERBvFqiYSrxZa5RpxtX1qFAeUjsGX630
         O3MMMRh7EDip7XdBzLWIP2uUgchuOLsPpWuku+2AKcoYOhw3GZV4CphjuldLKk35saSn
         1L0JRqU7EB5bubOOY6QD3jkhnnweMpPXsZUN8RzwGR+t0iSjSgMT5Zt4HKuIfXv8dMxR
         w1RauwMsUUhxBNR/RAPzrSs/NBRw6jjlw3IkJp+3hlpHaSPAX1RJ4Wbn3ganCITUMC/C
         tl1knHt2ve1OxcBIO6PDhOCwEC8h8/80ZPi5xEcvOwhg5LpA3PCQxR9c6auJiV1mFxpS
         Rg8A==
X-Forwarded-Encrypted: i=1; AHgh+Rq1DjiBg5YXwm9HBuc3Imkc5sWU8lO8+B41/3cD9YVE4CQ250dSzVEIG3qe+vUboGSPL5rkh44Icho=@vger.kernel.org
X-Gm-Message-State: AOJu0YycoZxvi7pzjqoeHhwG1vfGiTqmyyG7Qm2Z4HlAocvWFlgNZL7R
	+pUkwiygcq4Mt9rIJLp3zodXWJEqVY0+dQkHs+V1dtapnO8cWawePACg
X-Gm-Gg: AR+sD11WgvCmvH5o2MUzpm+P8w+6ntXaNhykP8/oaLZM4Vkwo61l9P9kgwG8uwxOtM3
	NjCFAhz1SYK2K4RyQt8kRx8kR2rPSHgS4XxARLbFG7yY1cLjyDPXpQcNBUrpmGEZ/MX8qRMOPPI
	+0O3EKJEMquJXhFWFynZGMwitGc5KEQBZoo0TRTlZDknbkIGkYPQaw5SbIwoFDUGvTJRrj6zjPc
	MmB/pVkT1hOeU6z+kYnjT4b+GeBAJJ3ZQ8mHBuyNfYMkWuqKyUSC9Ss5eb+RXGc+gIOODbrhXdv
	6LI/c8wUP5CR7rOxsKow2utfbKtgNIWCztmOKOuaOIjh97tex5whDnc7oKhcchQ/Vv7Aotejwo+
	idD0POxirqA/Zxl/7nJnYfF11/eBdtSlzXwbR+lbXpSqsfaqb//4+6X0ztFRMyNVwATvDtITFx7
	MNiW3IrWnOiCF8PH5nja/sDsU8XesC0MlJZ5RDDJMShGSvyHBfKFlRWMFLWdUtibIaCbJq0oolZ
	p7tAlIQ4dG4zSUD2pZwke7CwFo7mSOgJpVlGIzIdtcyyRPyEr/sctk=
X-Received: by 2002:a05:690e:4850:b0:667:b57b:8689 with SMTP id 956f58d0204a3-66b122c09cbmr2012592d50.15.1786389705290;
        Mon, 10 Aug 2026 12:21:45 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:82a2:5c54:b9f5:beef:8bf4])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acafa90basm6928863d50.16.2026.08.10.12.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:21:44 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mranostay@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-kernel-mentees@lists.linux.dev,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: iio: proximity: move LIDAR-Lite v2 out of trivial-devices
Date: Mon, 10 Aug 2026 16:18:40 -0300
Message-ID: <20260810192131.153495-2-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260810192131.153495-1-rodrigo.gobbi.7@gmail.com>
References: <20260810192131.153495-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PulsedLight LIDAR-Lite v2 is currently described as a trivial device,
but it is not one: besides the I2C interface it exposes a power-enable
pin and a mode-control pin.

The mode-control pin can trigger acquisitions and report the measured
distance through a PWM signal, entirely bypassing I2C. That usage is
bidirectional and non-cyclic, so it doesn't map onto any existing
binding for describing pin behaviour, and is intentionally left
undocumented here. The same pin can, however, also be used as a plain
status output while I2C remains the active interface, which is
described through the new interrupts property.

Move the device to a dedicated binding file and document the
power-enable, power-supply and interrupt properties that
trivial-devices.yaml has no way to express.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
 .../proximity/pulsedlight,lidar-lite-v2.yaml  | 64 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 2 files changed, 64 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml b/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
new file mode 100644
index 000000000000..e19c8d166b81
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/pulsedlight,lidar-lite-v2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Pulsedlight LIDAR-Lite v2 range-finding sensor
+
+maintainers:
+  - Matt Ranostay <mranostay@gmail.com>
+
+description: |
+  This binding covers the I2C interface of the Pulsedlight LIDAR-Lite v2
+  laser rangefinder.
+
+  Besides I2C, the mode control pin can also trigger acquisitions and
+  report the measured distance through a PWM signal, without using I2C
+  at all. That usage is bidirectional and non-cyclic, and is not
+  described by this binding. The same pin can also be used, while I2C
+  remains the active interface, as a plain status output signalling
+  when an acquisition has completed.
+
+  Datasheet:
+    https://github.com/PulsedLight3D/LIDAR-Lite-Documentation/blob/master/Docs/LIDAR-Lite-v2-Docs.pdf
+
+properties:
+  compatible:
+    const: pulsedlight,lidar-lite-v2
+
+  reg:
+    maxItems: 1
+
+  powerdown-gpios:
+    description: GPIO that can be driven low to shut off power to the device.
+    maxItems: 1
+
+  vdd-supply: true
+
+  interrupts:
+    description:
+      Mode control pin used as a status output, driven while the device is
+      busy performing an acquisition. Can be used to signal completion
+      instead of polling over I2C.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        lidar@62 {
+            compatible = "pulsedlight,lidar-lite-v2";
+            reg = <0x62>;
+            vdd-supply = <&vdd_5v0>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 435c4baab436..74b640c48598 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -396,8 +396,6 @@ properties:
           - onnn,adt7462
             # 48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
           - plx,pex8648
-            # Pulsedlight LIDAR range-finding sensor
-          - pulsedlight,lidar-lite-v2
             # Renesas HS3001 Temperature and Relative Humidity Sensors
           - renesas,hs3001
             # Renesas ISL29501 time-of-flight sensor
-- 
2.48.1

