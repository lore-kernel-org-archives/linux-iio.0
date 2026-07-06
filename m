Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3272379EFE
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337179; cv=none; b=iv+7sACzZeixjrHHmv9EMYflUr44EZB1ULM1n89lkGNmzGVePaDIHqgFJE9ac+psBmFPeoXVXb+QXOpJF1v7aXTkGQBWBtTqcx6Z4bZ37z+nCPdZ27STe9eK5EBG4jrtTtT9VslQEd+KeX/im6wAXmB55V6gXxtBWZ3o6TeV35I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337179; c=relaxed/simple;
	bh=Sm3ttHl2A1SZwU/SlTdF93ZxDPe1dVfuw8JKsQGMEPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3FThvd4Kh0OTtWP4lnYjhb7SkjOXB3nHIe5udN7St+YD6WALybQPkry0I0f+briH8TZvj9YNdRUKknfb+Qdb+/g2m6R3PesBVySnZ8h+Z5FV4cdtWL/F3XT/Toj94kh4ND4a18gG/cnhPRXwKLPHTAjOHP1pSPVEMRh89hwlMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfE4Gfx5; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfE4Gfx5"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aeb91c003eso3130632e87.3
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 04:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783337176; x=1783941976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOicUTiPTvh274hpQgk0H4KwMXnqfRQ1+lUCQuogkaE=;
        b=JfE4Gfx55Qdh9FA69eTqz5qPvrBycCHhybSxauOsfe4sqOgu1dgQwZUt7qEL3FA78m
         mnghyZtk0A8lqE/aonTAJtZTtSKBWio1Y1cB9vnl2QfqJHvDV6Dcg33yiYG535m7ZQZU
         tImPMUbawWx8T3JR18FH1YmBACt0C+YXoVWziUtJFTQT/LSG/k7waq/1gdateL99hiLG
         /uKCyknCn/lEvq0YDcSQKnb+A1leDMR4z+OySHJPydo25MsE1htPc5V98QdoSx2b/IQF
         V9eEAzfd78OImjX9Zwz2IHdJErzOMxIqxUCuy4cpnZ88Wsoa0iCIpnDKAt0ggY+DhJlC
         XwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783337176; x=1783941976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NOicUTiPTvh274hpQgk0H4KwMXnqfRQ1+lUCQuogkaE=;
        b=Lcpo8Lx7ZiZC4qiaYSxO6qs1xUAIqbRUA47YxQLqZ3KqimQsO4w5ALU997zkxTSUZR
         ubpi0ZsXgOf8MVsR7Bmv+pkHhuAedqGTzxtZa2Iv+9adoR0ym183NW4ow+91Sw2+VQp9
         Kb02hQjjl+o8zhDZ1LYyoiRPzYelD4ZOowez90zbsq6RKaccrgFrsOFKs6xmOFV+WRM1
         zsdcvq4pn27n6JUFhWn8po+rVqJGjvW8hmtUl38ebNZ05hmx7Y5i2d8uTuHg5e3/ai53
         0d0vUDx32gnZyoOqk21oV5PVeYdXAnldsAwlMvitiX7e8sECbpQjN2KJHjpE0/s2yKBM
         s6Kw==
X-Gm-Message-State: AOJu0YzKxkIE73DDrvo1N8wv2LA7gpdgBfUXXJGNi/u3VTe0+kTOD9d8
	xQ8bHI3xhL7o2+/8DEWOAhkA8L/HPQGvTWx3RjV0iYDw4WDkS0YdDrUXP6EJEpJzCwDQdw==
X-Gm-Gg: AfdE7cnRyGbz6zgLcibORZFKBz4T+B6Edllrn8PxyrahLOnWNhmvK2p+lC6j59biZhz
	tA8UOzT4AvtvaTXjgnPr6yNRYTw9I3VMHDXwSGSgDwJIQXyRcgRSL/wJfVJPsRkf/ZmEf8ppJoW
	VMuK+8MCkGbSQNXy65m6+zuxR0PNPZY8jTHFHNTpPbhvvVXNxrmmFwkmyTlnupIFKM6YCf8SWAK
	ldwPE3xRccCwdgbMnf37ri3N9k5prK418BMkkR/72IU4C7A8TpdiKeemBZ0Du8Vajqtw6V1sImu
	4OxWyGGskvaW8LfO0MG71sfxqzF0w646D5+EgK9S5kvJfUKJ1x7R6D94LcY9kPLWY/0krFpKIf7
	HioXSv51P9Yj/gGNjwS3J1ps3t/Noeyb8BLv7pE4hPucQf1CifTJR/UWtBjUd09gr/XGez9bxdg
	6ykI74lOtZhO19oL2NQ17isIOBgIDiD3CracMLjh4tERu+Qw==
X-Received: by 2002:a19:5515:0:b0:5ae:bb35:c956 with SMTP id 2adb3069b0e04-5aed50c863bmr1077809e87.56.1783337175940;
        Mon, 06 Jul 2026 04:26:15 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed1377075sm2730755e87.28.2026.07.06.04.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 04:26:15 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: ti,ads1298: add ADS1299 EEG ADC variants
Date: Mon,  6 Jul 2026 14:26:13 +0300
Message-ID: <20260706112614.1262241-2-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260706112614.1262241-1-shofiqtest@gmail.com>
References: <20260706112614.1262241-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADS1299, ADS1299-4, and ADS1299-6 share the same SPI interface
and register map as the ADS1298 ECG ADC family but are designed for
EEG and biopotential measurement.  Key differences from ADS1298:
- PGA gain up to 24x (vs 12x for ADS1298)
- Internal reference is always 2.4V (no 4V option)

Add compatible strings and update the vref-supply description to
document the ADS1299 reference voltage behaviour.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 .../devicetree/bindings/iio/adc/ti,ads1298.yaml   | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
index 71f9f9b745cbc..202776cee73ff 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
@@ -4,11 +4,15 @@
 $id: http://devicetree.org/schemas/iio/adc/ti,ads1298.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Texas Instruments' ads1298 medical ADC chips
+title: Texas Instruments ADS1298/ADS1299 biopotential ADC chips
 
 description: |
-  Datasheet at: https://www.ti.com/product/ADS1298
-  Bindings for this chip aren't complete.
+  ADS1298/ADS1298R: 8-channel, 24-bit ECG ADC. Max 12x PGA gain.
+  Datasheet: https://www.ti.com/product/ADS1298
+
+  ADS1299: 4/6/8-channel, 24-bit EEG/biopotential ADC. Max 24x PGA gain.
+  Channel count is discoverable from the ID register at runtime.
+  Datasheet: https://www.ti.com/product/ADS1299
 
 maintainers:
   - Mike Looijmans <mike.looijmans@topic.nl>
@@ -17,6 +21,7 @@ properties:
   compatible:
     enum:
       - ti,ads1298
+      - ti,ads1299
 
   reg:
     maxItems: 1
@@ -33,8 +38,7 @@ properties:
 
   vref-supply:
     description:
-      Optional reference voltage. If omitted, internal reference is used,
-      which is 2.4V when analog supply is below 4.4V, 4V otherwise.
+      Optional reference voltage. If omitted, internal reference is used.
 
   clocks:
     description: Optional 2.048 MHz external source clock on CLK pin
@@ -75,5 +79,6 @@ examples:
           spi-max-frequency = <20000000>;
           spi-cpha;
         };
+
     };
 ...
-- 
2.51.1

