Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E0D372EFA
	for <linux-iio@vger.kernel.org>; Sat,  5 Sep 2026 05:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788587616; cv=none; b=l4xBdXwZa1U38lNcniii04CfVl5jPSpDfh5PXSFaIUYnISDJtUJkeV63SmkQ1SRjvo39ZRcUF35EWKJJMURSvTOLXb90S9WjJbyPn0bqoWAV8XdN0auE/OiU9obAUBd8EZ+tDM+xfIe5tizszxV9IVxIqnBvhtMhUz63fGAXsxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788587616; c=relaxed/simple;
	bh=2OwrC8ngY4tjaQzu5GKHL+hXuds3sFtg2SG5EfUZZGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VnCdB2QI6n+9nfMpSwQT5c9AcrXNZO833JF+nyqpr0Ywv7FIL1Hg03d6vj2qPTEEAbejlNh2rIh3CEWEuA82738OMe2h1e2FimRt4ZpfIj807cpv09TPv3ZIVgJjkZDwb2yVWkBpZ0h/fj7r3PxqIEKZxnFvJLoqJFMkhnnZH74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=orzkP8Ag; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orzkP8Ag"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-86d43cdee51so22926187b3.2
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2026 22:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788587614; x=1789192414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FiCaIn1GD6n0V382lVMeuTNtZLz4CdPIy/SmqTEx/n8=;
        b=orzkP8AgCWPo63a5Rkz5QAuTkudN1Z4gmwHUkmUDU0P8CnnShcGfLRD3kCv0IlfnuD
         G0Y3vtrpEYNfYxx+4JvNpztYgBn3tavKpGhcHMMof0/XmlZJy2YXprio3ttKpdhbROYT
         NZMuk/MR8qCsRPxTg9EnjcMAqjGvaTe9xuxzl+6D42n+hxV01HMnvRt57C6RiZZOo/0h
         GJ4Kg5/J4CZ/Ad6GQ1M2SrBzK+gOcWCUe/bmQouCXdridpFqeixsxF2+mIf6NH53GfXh
         4Sf9Own8WNi5B1RmnZ0f7MSVuVaum/vXIMIaYIPfQJpLFAJ52u4BPIM6fcwT98uI9lMD
         EHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788587614; x=1789192414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FiCaIn1GD6n0V382lVMeuTNtZLz4CdPIy/SmqTEx/n8=;
        b=OEp/cu7iWe1H2f0YI3MFp+l7mKsKccbSmYOBjVXFGpvBt3VyZ+4GNDPsZwiFJlVN3k
         vSqz1I55Re4YzF6gTQGUS8wwa9fjbQsWZtb1ggYyQqtSegs2IQZPptDuD52EeOCgjp+r
         xSkfB6qzX2bs1VifiDWnZwgiTANMDPMp48idwn2qhdsljnRa/BuUtdNw/v/qOdp/MaV4
         en95ApiiCgWRCLn78lN10F9DP0Fxyo1VYQppZGJFsqr1BcRA6cQwTdGo5yT5uRHqWX7Y
         wcW/8MBCZPzdgMeeA8JCuKzt/J6THS/qCWVPUgGyEU0222SImiRIfKb5bM45KF1d6tPo
         n85w==
X-Forwarded-Encrypted: i=1; AKwUvBwWn7HEVVGVu7Hkmp/2k2MHFzDAJtVsxQtnyIZAHbh6/bWfkiON4EBuDYAQjJ6mUJ3ZMoIbn6iVRZw=@vger.kernel.org
X-Gm-Message-State: AFuF++nLwxjesLHuzeL7V3HYcbQZWGmxIywDjRmGv2T3M5SIq/sCY/kQ
	T0ftX5xv8p2SnFYT9WpnPiMzo39aRdmj5pPeSjV3TNJ6WuaNZiRn50u6DjummyZzNH8=
X-Gm-Gg: AYBFou01lk/pb9X/IAux/RMrxV6kJiN7jDsx6g6Adm7Yidfb19h+IAxbD1rL59D9Dpg
	ZD/vQeIzjOqbAc0BtCy89btfT7PspehuMw3DpJ0DpFQfvv59i3N8akW3GMJzFODsabGWsU44usT
	mLp+oN73dxO29+ATOlSNE6HAG+Qc1z678YVQyN9GulohAjTUg28SAYY23xgF75jmFVApMmbQ2zU
	CscrJJ5I4tqR/APeA7im69seOtJh0kCEahEshUviVrtOzjHn8Fu+x6nU/y5YhNNfAhJP4Ei7Pb/
	7qPWRq5CdQDIxkFsnuzwaRlw1l94ly2WNQF5qfVKANPW1z12olSfb4gq51V/IvhCHod/MUTj37X
	RracY4Jqpf4KUxJqfxDO4pnOUiC6LXLX2CO7ee+unUMK4s8ZI48LvPxTkp1zYp57Fn0ravrBt+k
	2pDLWSAxnz6jYO6i+CVisECt8MJgUDtfR5RYnvX1C6x78=
X-Received: by 2002:a05:690c:4017:b0:873:5bb2:6c31 with SMTP id 00721157ae682-8735bb26ef2mr16592757b3.56.1788587614064;
        Fri, 04 Sep 2026 22:53:34 -0700 (PDT)
Received: from localhost ([2600:1700:5431:250::1e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714ab73f23sm33173687b3.33.2026.09.04.22.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 22:53:33 -0700 (PDT)
From: Chang Yu <marcus.yu.56@gmail.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Chang Yu <marcus.yu.56@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: light: add as7343
Date: Fri,  4 Sep 2026 22:53:25 -0700
Message-ID: <a516f5bdfaf9a2cee9e22b80c17fb42f860afdf2.1788586814.git.marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788586814.git.marcus.yu.56@gmail.com>
References: <cover.1788586814.git.marcus.yu.56@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding for AMS AS7343 which is a 14-channel multi-spectral sensor
with i2c address of 0x39.

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
 .../bindings/iio/light/ams,as7343.yaml        | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ams,as7343.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml b/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
new file mode 100644
index 000000000000..fb996160cf8d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/ams,as7343.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMS AS7343 14-Channel Multi-Spectral Sensor
+
+maintainers:
+  - Chang Yu <marcus.yu.56@gmail.com>
+
+description: |
+  The AMS AS7343 is a 14-channel multi-spectral sensor with i2c address of 0x39.
+  https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
+
+properties:
+  compatible:
+    enum:
+      - ams,as7343
+
+  reg:
+    description:
+      I2C address of the device (0x39).
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        as73211@74 {
+            compatible = "ams,as7343";
+            reg = <0x39>;
+        };
+    };
-- 
2.55.0

