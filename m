Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A61E3DBD51
	for <linux-iio@vger.kernel.org>; Tue,  6 Oct 2026 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791281407; cv=none; b=LvPmlyw1tNdocgzJELzkpPZIRcIjn/rnO/NDV20nFHpQHiEY0GzZdciYhAi2a/1XTR9DkOVivaMwF1RMmS6SLcO4X3eOu2ZYwmyDUGACAq7sRGRkvGq+K0/USJP7neoFg27teYQuedxgP79x3o7r4QwJv1MZZmuvPYWbjVdgNJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791281407; c=relaxed/simple;
	bh=Ms8KrmobsNmTMFpJ/93IDugaXmnB156D0bOZprPcjCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCaNJ1BNCEG3XeOLdzZ7xwwLh+v4Mba4AAFSgw9HDk15qbv3xz1p0PzZFK9Pn84UmAak56rFmsMhu2kfSW3SZwXCBuNFhkYxeSzE0nsskd0FWbJkrM3DNe30GZaCZZAxVPgdLdqTixLznyT4ZNs6wA4n7mPOJXYaSE7P7sHbiOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i27o4WWa; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i27o4WWa"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8819033dbadso297456b3a.0
        for <linux-iio@vger.kernel.org>; Tue, 06 Oct 2026 03:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791281405; x=1791886205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=txtCljEVWe/u/jv1SP0sOmdyVcE1LpT4sX5ouMHqrXk=;
        b=i27o4WWa3tiBGgwrIiSTv1J8NuZDhYrPmdaH/ngo8BpaL9iEVyG0iJFRwUrcHzIfi/
         6fUEZ80uAavpzSovF01XflS2y00XCztZHaQ1YAQYZYw+HupD4VMOzRYnjsYj+06Aeuqd
         2w9eRoPYr88MpzGJNVm7l5dtnjhfcgKlqXIhOBSsfzqKd2mQ+apytejPzUKfCgDPC6o5
         nyCOYMHHlAllhqqenxjELmDg0EDesH5hyoLaDcUZ75u5m/AdIKqKinmKdefSZdgUr1xC
         LgA5UCV3ElLygK1WAXhMSZorssDGxxP/f9zufltKRPKvdvXNPE8M+98++BYRO92ny+qC
         kiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791281405; x=1791886205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=txtCljEVWe/u/jv1SP0sOmdyVcE1LpT4sX5ouMHqrXk=;
        b=17EXrmTWoV5sjGU06RewfMHmLGN2O4vqWImbtjIGoowmUZ+P1OdLXpbCoiStupnRsm
         wkckZf/mnbbG5l3Co1G3aUlPfYxy03FkGr3CuyKARPbW/Ww1sBjfk8KezcAkLGM7INW1
         5MWaxisbMGQUoCswBNgPxYTkU7NwipLC1r8IrpaR9fpPunEU5QbGYhJNDp0Z+xivt7Ub
         5dF2zALlD0Dc21xXwtb2zZ66tbrHksMDQrWtdniwuHh7YD6God5j08j1jWTgsk1hT0tI
         X45cNzRCybSLw3XaVwcwFh20X0RV3YybP3WXKs0AP+aZoP13WLliwFUTSoVK1vQDd+GT
         Ng5A==
X-Forwarded-Encrypted: i=1; AKwUvBwnvzLmS8Ze9/BscmbLLQsY7sDwzW9t/tBm1ZeWbsWD7BtWQQ9lkhr+yf9k1pXfwU3N3MEH7wJWgGw=@vger.kernel.org
X-Gm-Message-State: AFuF++nSmxTgvqUmKP+oe1qbIKjM2htBR1wkBf6LyJuTaiQ4x3cGnEhe
	llWeEVvp5RR/TomyQ/EToE2kIvFbvJAmg1gm68hxz8PfABNeMIND4Okd
X-Gm-Gg: AYBFou1HT/sjm3eoGYVtVGMv+hRycwAEOXdcdoxzsP/lML+xSVM4MYuDgxosF4Ckzku
	X/coP8Ofh0WMTTxbiBEVCrEhhxzbD2L84tXnuvI2wJQfr5JOaCUXJmkVhBLFbGjFvcSTugGb2iJ
	q+to+O5cPbzhD2kgQEhHnh1I/sO4GOjOO9H+kutv7h6okKalzV7QGgTVcaHCLVk3s3cV210SZKA
	JuiIrHih/IW89crJ1sdoH6lQHhYJxTjubF6RowvwY8y87gfc8jJliqFStOYzsodECeoa1r5aG9h
	LEkirfeNd6uIs2BfHfOa35bOCEv5iQtDeRFFZLWmsSha6TOXaO+29FIs++LvQAfwyc9z/0YrXn3
	F1OC25MVt6Mj8pRCPeBMGGdY7aTaeuN504cPXvxk2KGS49wSUkpj+kMoCLdlscxwxT/nNiJnSVM
	PymJNE31mqW7cHKF8wlyttN5T/5CBlwIYGKSpqmLCV+Degy3U0qA67ABwHrlgTcNf2+5eNqWY4E
	IWru+ce4rgIjebkjOg=
X-Received: by 2002:a05:6a00:3004:b0:880:ec27:9826 with SMTP id d2e1a72fcca58-890dbc81240mr825118b3a.2.1791281405512;
        Tue, 06 Oct 2026 03:10:05 -0700 (PDT)
Received: from l (ec2-56-155-114-54.ap-northeast-3.compute.amazonaws.com. [56.155.114.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0b8f7198sm4592961b3a.9.2026.10.06.03.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:10:05 -0700 (PDT)
From: Liu Yufei <lyf98405@gmail.com>
X-Google-Original-From: Liu Yufei <lyf98405@gmail.com
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Yufei <lyf98405@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: proximity: Add Vishay VCNL36829
Date: Tue,  6 Oct 2026 18:09:42 +0800
Message-ID: <20261006100943.78971-2-lyf98405@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006100943.78971-1-lyf98405@gmail.com>
References: <20261006100943.78971-1-lyf98405@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liu Yufei <lyf98405@gmail.com>

Add devicetree binding for the Vishay VCNL36829 proximity sensor.

The VCNL36829 is a proximity sensor with an integrated VCSEL emitter
in a small package. It is controlled over I2C and has an interrupt
output. It is powered by two supplies, vdd and vddio.

Signed-off-by: Liu Yufei <lyf98405@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
v2:
- Collect Reviewed-by from Krzysztof.

 .../iio/proximity/vishay,vcnl36829.yaml       | 55 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/vishay,vcnl36829.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl36829.yaml b/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl36829.yaml
new file mode 100644
index 000000000..6f20537ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl36829.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/vishay,vcnl36829.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VISHAY VCNL36829 Proximity Sensor
+
+maintainers:
+  - Liu Yufei <lyf98405@gmail.com>
+
+description: |
+  Proximity sensor with VCSEL in an ultra thin small package with I2C
+  interface.
+  Datasheet: https://www.vishay.com/docs/80580/vcnl36829um.pdf
+
+properties:
+  compatible:
+    const: vishay,vcnl36829
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  vddio-supply: true
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vddio-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        proximity@60 {
+            compatible = "vishay,vcnl36829";
+            reg = <0x60>;
+            vdd-supply = <&vdd_reg>;
+            vddio-supply = <&vddio_reg>;
+            interrupt-parent = <&gpio>;
+            interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 8014b9f82..e6ef84b49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28754,6 +28754,11 @@ S:	Maintained
 F:	drivers/input/serio/userio.c
 F:	include/uapi/linux/userio.h
 
+VISHAY VCNL36829 PROXIMITY SENSOR DRIVER
+M:	Liu Yufei <lyf98405@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/proximity/vishay,vcnl36829.yaml
+
 VISHAY VEML3235 AMBIENT LIGHT SENSOR DRIVER
 M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
 S:	Maintained
-- 
2.53.0

