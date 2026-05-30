Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F9C34BA42
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160824; cv=none; b=gMnYRw4bquM16p1h9DUAs359LEejftFWRS61ilGcwNau8q9IqyB4PFM0Vf4BgUOVm/16XilQrAK0u/s/LdVBZiUiEbfRUrkH+k7asDUWKwb2GqQYCOnMSJtq7YQNLIW/5sQK7F1ghk4ENpSfHPnPfrZLIakBNBqyIvcd9vysR0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160824; c=relaxed/simple;
	bh=wMgstDTG3Htg8sV956v99iFXbhtolrOjZNrDTHpa1gg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CR7LOjYZi4drsLYy9dK/J+/dJMphtu6BcxXupSAthOQKhxfyfgYzcq9qS+ea/ouEzDRUEbPb56Vl3wUusimMUSpM1IZj5+fnhUlBQOaJFZevFwcdv4092kjLbtTNWwwUUB43CEkECFh5Sa9bRNO5rECxvQ5souEvb07vBDcvn1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oe42Okgf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oe42Okgf"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490a7682635so185625e9.3
        for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 10:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780160822; x=1780765622; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=auC75XiHji4m/5c8v8bWvJiaMsYrhK57f/6mbMWrQHo=;
        b=Oe42OkgfqGsZq6fjXivRoOVeVThhwPpLde6FSKxqRi4RDRYpE/P1Ym8hTmJd2KJtdW
         vHASFVbLKO1NE9GuTFPFT+Vpj2dkCcL50ryUThZ4oOW5PG+S4EVh+jKBzQV9fY2B5wI0
         u1DlUo7iagudWn5UJmsdwGgaADWy6F/ab+Z9T4q+4oEIjQkmFFpAgc35Sm4zgVSd9QMO
         X4+S20HNlBI6/mMymxVx2so425n+6LhZ+h3XG3T/uCh1M3wDwN0lqFb1UZvh+eevNPfl
         hsGvPdUC4QWZ0gwbaMuea4yNqb380Ve/GbjYMwRPAkGFZxYoV0XG5GhvvW4kTFlGSk7x
         BMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780160822; x=1780765622;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=auC75XiHji4m/5c8v8bWvJiaMsYrhK57f/6mbMWrQHo=;
        b=p6qNMqdxWD2WeYQFJpaXGTETolwCR/yaS+fm/1fK9Vhad+lTQZCsQKQJqCAxrCGk1w
         OxS3Heac8d/QQPwdrKMycUSUmjxl4WT10A8DQFMW6dGLP4aHjn5E0d0wyGuDwLmQxfXq
         xKsIr7TvmKbHEPAn6Y3Ts+1wLpeZaHCe6ZyS2OprDfNArkISs5NmrZHJK/4K1nL8Xli3
         GEKKZoH+CYg/aXniYS41nPZTJc4Ztr1i/j2KsFD5XTgkZxF5fPKsHaWQjBQeqyVf7+nX
         ictR6s4xIowjxvYQcHtVPneRgxS/+HumKMDofLab+UvBMlbvAkpAP9SX3s+OhT2Bty5T
         MYZQ==
X-Gm-Message-State: AOJu0Yyc05IrCegruKSy5LruAo/N+7SAH0ABqkxi988Ek0CfPTvhSjxH
	RuXgMZh6e0R4Oo0Gv2y7QB/zlac/1/VpxVEiT/w7FHPawr9spZcwmO9t
X-Gm-Gg: Acq92OE5KjeqCiFi1G5KrfzOnnLdDltCQr0YavzuLm3EXA7FQSyo0V+sgc4DFEesxPv
	Cf9pzH6buZcBfQjoEvO6KuwESVjWDaOINze0Z98rKtMhzWya5/A8pfvzb8BRpNK4t1dH83IDrL4
	Zb8MkCiZzxa/MCCCaKVYRhEV0aor++ByFQ9VxrJ2vZXTcWgEdAynpYJpmZhvcXMZ82I7+vMToTT
	YS5tkwnOvFnOlEG5YoEfCOY4nolm/7dIDKwVtpPj2crFRCk7JMVgtHlkbAoda9AVzLyaveFJEG7
	HQ0FGbIlVinzhmgo0SKzxAzC/o5pbuNHqTNnfuMnS7PE/t7jphxh4Qj4418AropcogU0QCOixXJ
	4xYqJ4RkchdssKHA7FMezjWvvNdde5nBDddqKliPMB1P/eV2LoyFub+TXss/XomM6CorWtpnDAC
	cYGZeoqVF6V9SX009mjGLby1jlQFYC8I1ux1wdSGo99wyQJzTyfNzfsC2jgVN2NWjMzxwf3VBCx
	mYuAHKd/y5wL+qwxM/6yfmwFV+RCZMrqhsTVh72Vn1StRC3aygUBXdsFianCfrEof0CF8GJ/VH7
	j59UtB+4f65wY7FfGJwtfpvqaDW3747ajkw227hsCFfJeQO6hETCuvEGRzTaKQ==
X-Received: by 2002:a05:600c:2158:b0:490:58ef:ce9b with SMTP id 5b1f17b1804b1-490a293df77mr50416235e9.16.1780160821738;
        Sat, 30 May 2026 10:07:01 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0:c287:187e:fb7a:66a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909cab0e79sm229144675e9.13.2026.05.30.10.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 10:07:01 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 30 May 2026 19:06:46 +0200
Subject: [PATCH v3 1/2] dt-bindings: iio: light: veml6030: add veml3328
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-veml3328-v3-1-dd562eaee8d9@gmail.com>
References: <20260530-veml3328-v3-0-dd562eaee8d9@gmail.com>
In-Reply-To: <20260530-veml3328-v3-0-dd562eaee8d9@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780160820; l=1857;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=wMgstDTG3Htg8sV956v99iFXbhtolrOjZNrDTHpa1gg=;
 b=aiW0KkSaI1EzHq1fpZ2Hs227JRUPIyp3AMZ1jRq1ky1jyrMeKlAlTifLyOLVIclJzLphK5Rm4
 5vfpCsm3qdUAb0CSSGnOpCB5EmZZ0k3fW59ij1g4ynpvfnROpu/vsD6
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The Vishay VEML3328 is an RGBCIR light sensor that shares similar
devicetree properties as other existing VEMLxxxx sensors in the
kernel.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
index 4ea69f1fdd63..0041e1db6838 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/light/vishay,veml6030.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: VEML3235, VEML6030, VEML6035 and VEML7700 Ambient Light Sensors (ALS)
+title: VEML3235, VEML3328, VEML6030, VEML6035 and VEML7700 Ambient Light Sensors (ALS)
 
 maintainers:
   - Rishi Gupta <gupt21@gmail.com>
@@ -21,6 +21,7 @@ description: |
 
   Specifications about the sensors can be found at:
     https://www.vishay.com/docs/80131/veml3235.pdf
+    https://www.vishay.com/docs/84968/veml3328.pdf
     https://www.vishay.com/docs/84366/veml6030.pdf
     https://www.vishay.com/docs/84889/veml6035.pdf
     https://www.vishay.com/docs/84286/veml7700.pdf
@@ -29,6 +30,7 @@ properties:
   compatible:
     enum:
       - vishay,veml3235
+      - vishay,veml3328
       - vishay,veml6030
       - vishay,veml6035
       - vishay,veml7700
@@ -79,6 +81,7 @@ allOf:
         compatible:
           enum:
             - vishay,veml3235
+            - vishay,veml3328
             - vishay,veml7700
     then:
       properties:

-- 
2.54.0

