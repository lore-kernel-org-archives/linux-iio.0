Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D4E466B52
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521480; cv=none; b=B8IgvlN+cWnvrNBJI0x0cu00zd1kM6aKklABw3oUlhNi33M1l2+mCrFlsZVw+PspUfICyPeJSV4QnazFJB/WehGBIAEwoIGaGh1bzJNPxqSmI4iW+EVX3mPnJEgLrk23ty5xzA5UOv/jW+n+m0W7yMvUJP36q9AjHGHpjPjR694=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521480; c=relaxed/simple;
	bh=E6aqh8+T12bRYg/I7oKlm+pFeDSPhmjn3uy2gMkP4v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElZjdQquED1Dkk4dDp/ZijUZbeohgUWXWqr5YVVoE9/UCTlPQqwEhyvg15YlR+fLnQ8IX1antrUWjUuvN4Jeob9wv9VrJq20M+JHp1QrwoMTwwk9tXyqFcwbwI5tqvudRO0+dgVO9N2eP2xGKKrtcSbvei0NXMTkRM9LFsGUMTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXlQQ0gI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXlQQ0gI"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bab82d75fdso25097385ad.2
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 10:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778521478; x=1779126278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+cPMvGUMQLb7n51EIv7e2LMS6MgRiFBSfjF2HeBPNI=;
        b=BXlQQ0gImDdlq7oBfZ5XKwWaRdN3KOrPjVqdiP2IoFf3Ckz2C5/Qhb1VdZqPeFNR63
         JhUI74jl9T6VQwBcENLHc/+tGG47E1LHaNwSB11YIH3pHCM/nsqv6nHlAy8ftNnZxzC8
         QScUPLnRAe+/Q76rgpJUeQzwTY+1icNLn5dOiBz3yrjhvEe7PrfsRzv/VyCIXmeVTBM7
         HR7YYduq2J1/U2QcqgQruLgoTKuKvlH8NL27qXnXuntG48BPsAUJfr3esxYiBMzsxj/e
         r6IuRnxT56cvoG/wtgcWB6yJglK6ogaX3NjZkkNfRYHYx3CGdiTTcmhxNgyz8hCr2Q81
         MMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778521478; x=1779126278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W+cPMvGUMQLb7n51EIv7e2LMS6MgRiFBSfjF2HeBPNI=;
        b=T1IxKOqBAoYAajzyCHBM72iZeKGgJ6xGY8gDnDXUquagbIX1tzduOzBsPIv6sXryYA
         /GiGZhLL6u6Txx6Xyqo/Kh4ZMc8TwZT57r9n77XvatSvKanZ4wUrXtvGsmDdfa0WE+ZK
         kbyoLDaEybIo6MZcKP37iYHpJdo1O6Nn/MGc88UyPu7BQerF123om1ss9325snws/vId
         1rqdbhPQtG5BM7VQteHy7UhvjR8iGwGtst968flW3fM64oNyAk/g1wgFOFIm6CgMPVKY
         LKUIAZb7JBHGVD8GUlmq6yFRpKs2ZGloVZvT9mp6r4at7WjS3SOkxMqzZxQhlGxbbhVd
         Z/SA==
X-Forwarded-Encrypted: i=1; AFNElJ8KozIBTHX8ZmRh/ewlsa5C/qJ4rCbFBsDK/JUp5AWyGdbWrRcPtysGh7ulpv08dixmEhLADIYZK58=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtsNB9L9+7YyGfA2tiP4rTGmI9ZbNNILidmBJwGgDB2PV54f3t
	FMeevZbJ3ci9r3rX+rgLoJ12cyHByr+kJZhd2YuujG4i4z4hgDR7Bh+h
X-Gm-Gg: Acq92OEgzwDqDXBv/XhcoQ8RGr9H/ppwJuk2KbPMiDUvbGiBZ0IWeLsoQEDrbZCFBiK
	cdW/A2sltnSvzFWO+mLh/uyx1YuZrFZ6puv2PM/Wdnz97aYSZQhNIAf/sjbIeuJgzA1BsjHZQe8
	dAA7arzun7n8/+mz8R1KFOuQALPLXp/8be23NLS9JljkG+dVGc9PuyqnbYbnV82YB8VMFYqeeKA
	aUkLW1fDO2oRt3xonQFFNJiLrYIxXK1hfY+Gx7jGIv1N+DVsmHA7TXvqU+Bp/DrCeNDhgIE+a9C
	kPiW9Nz+C9eloQ/WB5An/QoLzv+IZdrDTVKqDOorFxKGwY4ijvRqgJvDcWKkKXVRWCIAdeH/vD5
	P78BU1id3wDuqWYU8uBN28dBCqM9GSOkh0XpCQAxXztjoNkuKMBm1TWXXYsFUPRms9V5TdkTTep
	dAh9dniWM6hrRJkXA4hx1lBtoAcFxBAbBCOIHyUdI0RZKgXHbWUZSeXrSes2ssUDACUDPycf2b/
	KWNu7QH27FU5652UqUoD3qnRjpG3wgoKI5tqUPUoxn9Ek1smBUU+riQF0PV
X-Received: by 2002:a17:903:283:b0:2b2:4b4e:e4d2 with SMTP id d9443c01a7336-2bc7a9c7762mr106560255ad.15.1778521478295;
        Mon, 11 May 2026 10:44:38 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e365a1sm106838425ad.44.2026.05.11.10.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:44:37 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: jic23@kernel.org
Cc: ak@it-klinger.de,
	andriy.shevchenko@linux.intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 v8 03/11] dt-bindings: iio: adc: hx711: add RATE GPIO property
Date: Mon, 11 May 2026 23:13:28 +0530
Message-ID: <20260511174342.123820-4-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511174342.123820-1-piyushpatle228@gmail.com>
References: <20260511174342.123820-1-piyushpatle228@gmail.com>
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
index a8eaa1f18de5..9134bbe41379 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
@@ -37,6 +37,13 @@ properties:
     description:
       Supply voltage for the on-chip regulator (VSUP).
 
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
@@ -61,6 +68,7 @@ examples:
         compatible = "avia,hx711";
         sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
         dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
+        rate-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
         avdd-supply = <&avdd>;
         clock-frequency = <100000>;
     };
-- 
2.43.0

