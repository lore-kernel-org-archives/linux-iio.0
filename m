Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB9E382283
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787173095; cv=none; b=WxbgXy5KfVv46V1PMggb6B1P05Iv8WxNaz9GvI6RYQyDeIdCcDlGrdCXf4odxKUXO92sJLCj99Pj3D7H6v6itxW8o2UxvnR2KdkrWiqbrlZWWGu41pkslKXAYktVlJOirIkfC3ujEqZnY57SKL3ifpYkl/zFkufrkvd/eM8rneA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787173095; c=relaxed/simple;
	bh=4yOAcHCi9um0K8UTl3s2TjwG/mb+CyVD7wWEW1YbriM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lij24Eh+PDsI6IjPsol6KeFk4dfIvS2CwzREt8EsEvrfWZD0gxD3GLMgAcP45lrN1pHl1vVj2SH6Qxmhvj+I0ZVa5ux0X7St79lnWtB3zkZFAa5iRJ8SmgcrKEJsECB/nWNpbDx2lGHSGemGcyzH9lLdT033f4XNeyRuRYQ07sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwzrVC2y; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwzrVC2y"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-977168e4f3dso1166204241.0
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 13:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787173093; x=1787777893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=58Z3XVoKaJQbEkvkG1Y4mEaTnnepGYJ8EOpBbp+pok0=;
        b=PwzrVC2ykJqMgE40Hyig/XgBOkPYDjTnj8dtEm37E1jXxZXNd7sbDbetMUBj6Q1LZ6
         clqwpbGpzlOsGoMperUzIIFmCF22go3RFWBYhrd0SEVc1D5FsdGu6HrC9E1s1LC8zJ4r
         rNfWYVvY1/8Nv9qblWD7HSydOfWx38KVqpHzK4XyLP5ez7rFnvbJIfLnAYYslmCCm87B
         UJAuwr9+LD9sPwNvlvVmz3b3b49rAi5MaATk2E4PGhPzOW6meMMmcZuKyh03hMNN+ZPr
         FExCbUji6kAKFM/6yBlH693pDdsKofwqLRJQdE2iyBWyJCex8dUsegy+uxyumLk3wPX9
         rl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787173093; x=1787777893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=58Z3XVoKaJQbEkvkG1Y4mEaTnnepGYJ8EOpBbp+pok0=;
        b=jvlACQ4SAJJbU1R8Jp1eLF01UYFtCoVQcqZy/PeRsLn9DEC+Ne4SEUZCEt+Ou2fOFF
         dSwtH6CWgacPD4Br9ulsMtpRnVbv7E6LZ9ZVNIG1paP4oejlmJxrN0w22o2JV8yH439i
         QRgKmDcZ8L1O/hFIAWtigtAGUkCR8Aj5wneFRQ+dl2H1eJhPeuqbVjEUYza1+odUrNI6
         2tzddLyXHZ3Qz0ljsnpxnlE66dafy5UiA1py8+QFWkumtlhHBq+QkYwaQ7CSHE8S5vgm
         l1pfqTJ5nP2/OKEOOrTK94kErkKKETliCVJ6Pq3wFu/mNb36v+XnvWe2WDhpMD3hrlsY
         qGwQ==
X-Forwarded-Encrypted: i=1; AHgh+RoAmFeTauGXOcavWpwh1Gz//WJK/Bqrkf19J88jsKI+G6EoG/RB27O3JYjZ5dTkvCkrfs7GOrQdbMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBmvJrW6thCrTU7CDWER8OL5C7M1QYxGvgNHvjzh3KjMcOdGXZ
	GR/LOd2u80dvG6afFAOC0440Q5qkd+nTBHRP55iPH2mP84cQnAHNMuIn
X-Gm-Gg: AR+sD10Ix5bjnuFrTjFPf1/Do0MoJStSpMhn3FxbWVBauydQy8ji7Z0JNA6C4/rozRf
	GKLGbyQaQwDY+nQnqhRyNygw0uP8qrBzEdDjuhUNeyyANCoWdibUp3f8yFXHxm0cp0Df7a8bUfz
	PM8diCahvh0WE/ripX+lWi4Ioo/hbPs9eC8oYUnIsK5YPf76iNNcPWZc54W2i6oz6o5GvE8RxzR
	xqMmx6XUjxti8itm0j5juNq9+SdS2JIBSMwIiNOzznYFVX+1YzL7ZOjGOxux7405o+5CP8yNiLM
	ilaF+Ma8nMK6fUuWFlAo+ChyAEReuvxj0sluQpCc2lffiPvhh51zu8GTTNx1eri1zxPppldDyV1
	+pybEG1XxEGy7zZhFc8j8CHWCbLES94BNL9yY/6I4myj++Bm+zXsWnmiXGToJA3FadyyYRzDIrm
	H+ekG0dxDvQT0ArrdIUPTBmzn4BJus79C9YRsJgYxzqLDjEhX0N3gaumrnxsQ+4K0hBLNehCTsI
	00gjKCqxTvde+mKHhfxBrThhdUkeRAJYPdT8PVtTxHV
X-Received: by 2002:a05:6102:6ce:b0:738:fd01:5b60 with SMTP id ada2fe7eead31-777f897904amr3350181137.3.1787173092636;
        Wed, 19 Aug 2026 13:58:12 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:82a2:3443:53b2:2e07:b3bf])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-777ddc844besm3616259137.11.2026.08.19.13.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 13:58:11 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matt@ranostay.sg
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-kernel-mentees@lists.linux.dev,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] dt-bindings: iio: proximity: document LIDAR-Lite v3 fallback compatible
Date: Wed, 19 Aug 2026 17:55:18 -0300
Message-ID: <20260819205751.166030-3-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260819205751.166030-1-rodrigo.gobbi.7@gmail.com>
References: <20260819205751.166030-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PulsedLight was acquired by Garmin, who now sells the LIDAR-Lite v3.
It is pin-compatible with the v2, and the driver already matches it
directly: commit b257c1a45e99 ("iio: pulsedlight-lidar-lite-v2: add
lidar-lite-v3 property") added a "grmn,lidar-lite-v3" of_device_id
entry.

Document it with "pulsedlight,lidar-lite-v2" as a fallback compatible.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../proximity/pulsedlight,lidar-lite-v2.yaml   | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml b/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
index 491960bb3a0e..dd739319b9eb 100644
--- a/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
@@ -4,15 +4,15 @@
 $id: http://devicetree.org/schemas/iio/proximity/pulsedlight,lidar-lite-v2.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Pulsedlight LIDAR-Lite v2 range-finding sensor
+title: Pulsedlight/Garmin LIDAR-Lite range-finding sensors
 
 maintainers:
   - Matt Ranostay <matt@ranostay.sg>
   - Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
 
 description: |
-  This binding covers the I2C interface of the Pulsedlight LIDAR-Lite v2
-  laser rangefinder.
+  This binding covers the I2C interface of the Pulsedlight/Garmin
+  LIDAR-Lite v2 and v3 laser rangefinders.
 
   Besides I2C, the mode control pin can also trigger acquisitions and
   report the measured distance through a PWM signal, without using I2C
@@ -21,12 +21,18 @@ description: |
   remains the active interface, as a plain status output signalling
   when an acquisition has completed.
 
-  Datasheet:
+  Datasheets:
+    https://static.garmin.com/pumac/LIDAR_Lite_v3_Operation_Manual_and_Technical_Specifications.pdf
     https://github.com/PulsedLight3D/LIDAR-Lite-Documentation/blob/master/Docs/LIDAR-Lite-v2-Docs.pdf
 
 properties:
   compatible:
-    const: pulsedlight,lidar-lite-v2
+    oneOf:
+      - items:
+          - enum:
+              - grmn,lidar-lite-v3
+          - const: pulsedlight,lidar-lite-v2
+      - const: pulsedlight,lidar-lite-v2
 
   reg:
     maxItems: 1
@@ -57,7 +63,7 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
         lidar@62 {
-            compatible = "pulsedlight,lidar-lite-v2";
+            compatible = "grmn,lidar-lite-v3", "pulsedlight,lidar-lite-v2";
             reg = <0x62>;
             vdd-supply = <&vdd_5v0>;
         };
-- 
2.48.1

