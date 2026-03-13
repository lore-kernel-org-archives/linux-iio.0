Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C5F36896F
	for <linux-iio@vger.kernel.org>; Fri, 13 Mar 2026 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773401905; cv=none; b=lEDBgGZsmTRbr+y6+j0I6eLdJhMDCdpGj3xWFi5J1hJWYGvUDk/qQM9YkAOAv+cLYoNkoZA8xydTUHjEbBHcYHI0MEux2djVuAZYPprU/AedIGPLvc24q3dMuMYFJDZHcBItGEhsU5tNZdIb+YRLRXz/fD9r783kBPVjlgr73zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773401905; c=relaxed/simple;
	bh=2L06vfLE0v6zHOIyvLLt10JdcVy2F2e9l4L3BNu+844=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYxQsgyva7eu5uD4Kvv9vfc5MRi4LzVqao3gqWPqjxdvmHfUgON94p60RYTrIrn7jwgnCpi6KTMa1CGVX9u+SlpyhMiyfYVvyb/OizWfLlXXaRukat8Lnt8hjyhm5p0gbXDJCn1tXZfkXx6991F2aQBDtusqqRHFxhnMDG3clMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8297310ce0aso1186295b3a.2
        for <linux-iio@vger.kernel.org>; Fri, 13 Mar 2026 04:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773401903; x=1774006703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=siAP7fGXMH2PyAde+5dOSRsHXBAV9rPfbB3DM9LuN3Y=;
        b=eXyInkwF8wjthiMMG/FxNJUkGfbJXtoXKvurLdrelpvJfmWn4zbClrpQB6wTv9Ujz3
         ToKnZ0jexq0BXicsukzX9Ch1mBqu+YYKE7Up4ZcPHoJfxm1f4ksZR2wB/cQJHMGzCs6v
         8vttPMXRIlGdWBH5qJxKrn8Wl8IJW7AGKYQ1BANqpV9Eew7d5GaAnNb9uxQdxXldanE3
         rIPi1EM1ffdwXYXoEC7w5ESckOQeOnSlZF4Jvbgi7TtvVIfDrqtHX7FOTb2dIfJOekeJ
         eNE85BenKWCWpb9lWRejpB0UfrNMd67JAr6LY8iA8HffEdHfkblI3D/esovZUmowPoTo
         dJKQ==
X-Gm-Message-State: AOJu0YwDaSq1B/fNYMMW0jzV2lLloLB/Wcu1bf1N70Cwb44ZFprax3n/
	SD1dwahXSNwfJ9Kg/k899N9gZsfPaLyNm5RH6Q1phJDFJ9YbX6+M3ecZTpQsFJVj3XbWwX34
X-Gm-Gg: ATEYQzzQs8/TICwTDKJZ2LYmOaGdL3khCF/WOV0E55qqTOzcjsGeJdqcVNyJPvplex+
	sg7tQmzCM1sR4xWTrV/otT1sfoQ3JLg2t806p1TTEfWbtW2dQE0MZYhoyZHM/2DrukWUy1ZfFSP
	sVcZa8xRwk52O4WSun3oKAGtVjqOJo73jm2yXvou60HtLHI9r589Dfe7lUSknYeJru2gHUUqXV6
	KDtliB4C1D2AePyAiSWkuuTqdAswwwR8+H+iKaOGwNUKKvaFy+rKTshr2ZXLkAoEqJyhMQqcQK8
	Hh6xZOvXHpO7LGRdkmWEa8PYvokDBxsPyt6bfvQyN2JbaS4ARUXjXMjb/NtLTQWsfeMbInN7Sv9
	HkMLFJEIuk/RXFT+GCBrltuxwto83dOuqD8J5uW418eHqzeJYEsoqEov+in+U4NeK3JEHYaKwE2
	DAhistrHqn+9y1EvZ3QEf3WJyIEs2SQ8sJ3JLatRkytXOsmYMVQLfngQvCcnpACMYYL3+dyo/OE
	QlrCC1iBPJsgQ==
X-Received: by 2002:a05:6a20:2588:b0:398:962e:83d7 with SMTP id adf61e73a8af0-398ecd32e67mr2778377637.43.1773401903176;
        Fri, 13 Mar 2026 04:38:23 -0700 (PDT)
Received: from archlinux ([103.135.252.26])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73ebb75624sm1669419a12.24.2026.03.13.04.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 04:38:22 -0700 (PDT)
From: Siratul Islam <email@sirat.me>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	Siratul Islam <email@sirat.me>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v5 1/2] dt-bindings: iio: proximity: add ST VL53L1X ToF sensor
Date: Fri, 13 Mar 2026 17:37:17 +0600
Message-ID: <20260313113737.151881-2-email@sirat.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313113737.151881-1-email@sirat.me>
References: <20260313113737.151881-1-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree binding documentation for the STMicroelectronics
VL53L1X Time-of-Flight ranging sensor connected via I2C.

Signed-off-by: Siratul Islam <email@sirat.me>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/iio/proximity/st,vl53l0x.yaml      | 7 +++++--
 MAINTAINERS                                                | 6 ++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml b/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
index 322befc41de6..0852259754f5 100644
--- a/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
@@ -4,14 +4,17 @@
 $id: http://devicetree.org/schemas/iio/proximity/st,vl53l0x.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: ST VL53L0X ToF ranging sensor
+title: ST VL53L0X/VL53L1X ToF ranging sensor
 
 maintainers:
   - Song Qiang <songqiang1304521@gmail.com>
+  - Siratul Islam <email@sirat.me>
 
 properties:
   compatible:
-    const: st,vl53l0x
+    enum:
+      - st,vl53l0x
+      - st,vl53l1x
 
   reg:
     maxItems: 1
diff --git a/MAINTAINERS b/MAINTAINERS
index 61bf550fd37c..a142a97be4cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25093,6 +25093,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
 F:	drivers/iio/proximity/vl53l0x-i2c.c
 
+ST VL53L1X ToF RANGER(I2C) IIO DRIVER
+M:	Siratul Islam <email@sirat.me>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
+
 STABLE BRANCH
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Sasha Levin <sashal@kernel.org>
-- 
2.53.0

