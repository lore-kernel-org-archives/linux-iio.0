Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9D53DD872
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779706315; cv=none; b=AiWwMCA3gQTw0Zh4lidx0tLfRBcyecbUXLoyVW0wwh+oN9fHARQEip1eC+YKW1QIdNEeFz1MW9P/mS5Dp82AyuNVi71T1ZEaOPzp4BdzpwXPEv2y5F8nhlWCxJdpWE7kuJyt/n5I3ML1gF5h0L1WxjGD5uVQJebezmKR9iCERbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779706315; c=relaxed/simple;
	bh=EoAF4YHy3iYTq0qtbpAuxEpwDtw0CacTgV3exikXeKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IohkL0on5OoimVdqFRcEII87nVkbt05d72q8OR5pVn0r8dYqBGexITLJAylGCW57yw9OI5LDmYI9DZwAWg0phkw2kGQ2WwUR7u96/yRDodqV0kfx79DsDTam5Y71PfsCLNDK/a79Zu9MXQYT69krqQNI15rQgyhiPZ0HzTrsLQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxJzXkQ5; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxJzXkQ5"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3664df30f53so5622753a91.1
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 03:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779706313; x=1780311113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygX2OtS8jtfRsEiUpxVA4rgdEOhC6dRMuJ3m7A2/544=;
        b=HxJzXkQ5rxe5Rd4uWXWIjPaVgR8KxN2cTumIZeaZaned0FATuWmH5u1zHCv/QvRi5O
         5G9gQTUmxUuBHEAhqx0uuZbc2BPkyvgg3cGWkptYjBw2Z+5GW5oVlkTHxAeusqSCFxUL
         a1B9lNbgtdBjdN92/a1eo1L3szpdMoAMfg7Tdnkm7M5tFA/gOWbc5z0unohNAYgwKPVD
         UPg+lxO78OZGb5aeM926Dgu8tiis/9OE/UI9zYY5X2rvQGNwXGNS3tkJPwC5Nd4ogDgM
         CTpSnxobVtT/N/xgsQAh2igywtKiGIibsVaDPz6jSXeUbbcNlTnIrh8XCL1ztQE0hDe6
         eCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779706313; x=1780311113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ygX2OtS8jtfRsEiUpxVA4rgdEOhC6dRMuJ3m7A2/544=;
        b=MDV/7IA8miaeMiB/o/fdnjqCymri1Z7dtk4zkpJIWG1axLt3nJPdyAF6n+pm+WZgFt
         PTIqZnwQPzl4BTKCGrA7NBUS5/fbeRgFVzQROpl39/3VHmN4RepR9yB0n1QdAr0yA0Lp
         T2czc+UoeduW86MhsR37MICUa1WvA0rx5ZM/TkO6MF14QKWC0BYZtg2t0o2A6lT1Ktt6
         v2GGoSfNEBGzUl36rgXqSWiapv6yFQe33kILJorJ1VCcNGH7PQfHVapb3I7N+pXkAtXv
         M/93qR7GMF6dvpqYZu2tHmmR8wXJNpLn7FaSh7KgcVYSHLfhX4P7ljUJ9BvLt2oD1bVN
         t4/g==
X-Gm-Message-State: AOJu0YyKy/Clx+JVC90lKiKPKe5cMVE4HfgNiWjQxLCJaOzvmgksYYLz
	UcaB+oo8yNzzd7A0SZCAHoo6bXFsmh5em+d/cjBrfN8rPQn4pXSJcXOSZWowsBy4
X-Gm-Gg: Acq92OFBBNsKYedPG2/RNxA7hw2BTSivTCJkN/xIFQ56ufhqPfwLlbXTns5NNTXSK04
	I06M+9Qw0YnPofcNLK2RmoztdLoC/JQ+VcIintNg9Ox/igZSa6xk+E3DuPIDhX9NZ33StK1SM5V
	xljYNRxcJtm4pMQfWnfK5HjzfglgULeTUdROv5SPoCeXX/0DM/YTJOjLrOgIr/7AAGM/QFmAoLd
	lVLLZe8k5xDFqRDJCrFVLMIp9A6gO9x2LugPHzUbEXMnkouu0KG3bjyNNlSrzDvxP+OLuJVlUrX
	HgTGdxh5V6GgUHELG5hSLigaE1d+uEeDoi1wBYVuDddQYglTVCuLqIWmnybwDXjOB/mC64uIfiO
	RuGUqpyjf0C135eiT/KPfDyYDj7A+eyl7oJxG/A6/IfOorimNrXZtAGMWG0Rd7wZ0lqMvMXldpB
	5m+ty1mQTUDfGn9HGHtNnjEyYRxGhQyPbsAWDWh9cOWAeYI9zwNxSbMAHZNjFx0OH7uqiP4kf5i
	mrtQr06AXdy+Hq/0bpFzfOBefxWeDU39ohaZV7X+g==
X-Received: by 2002:a17:90a:dfce:b0:369:932a:2b6d with SMTP id 98e67ed59e1d1-36a67402bccmr11933827a91.6.1779706313343;
        Mon, 25 May 2026 03:51:53 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:2011:e829:fadd:33b:8fc3:b2c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a7265a001sm9302388a91.7.2026.05.25.03.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:51:51 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	ak@it-klinger.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Subject: [PATCH v10 03/11] dt-bindings: iio: adc: hx711: add RATE GPIO property
Date: Mon, 25 May 2026 16:21:19 +0530
Message-ID: <20260525105127.180156-4-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525105127.180156-1-piyushpatle228@gmail.com>
References: <20260525105127.180156-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the optional RATE pin GPIO used to select the HX711 output
data rate.

Update the example to show the property in use.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
index 0baf620e9057..099235b5fd54 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
@@ -46,6 +46,13 @@ properties:
       one channel monitors the DVDD-AVDD difference for battery level
       detection.
 
+  rate-gpios:
+    description:
+      GPIO connected to the RATE pin. When driven low the output data
+      rate is 10 SPS; when driven high it is 80 SPS. If omitted the
+      RATE pin state is determined by the board wiring.
+    maxItems: 1
+
   clock-frequency:
     description:
       Controls the SCK bit-bang timing. The value is used to derive the
@@ -70,6 +77,7 @@ examples:
         compatible = "avia,hx711";
         sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
         dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
+        rate-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
         avdd-supply = <&avdd>;
         clock-frequency = <100000>;
     };
-- 
2.43.0

