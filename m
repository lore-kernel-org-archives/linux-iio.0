Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616623;
	b=GQuGM2bymXnXMeQC9x/rq8yDq1DrHrarFegkhib3X9TTu5ob5jXYv4W7fa/DnHByxZNM
	 zOOMBDVuASd2nBRTyrWBW5/vBgNWo9VJbMeRjr8Oy/HBArYtEmCRqISoBX7EPLyScI9sh
	 nM1W9jlkI0SZIGG5aoAxjhRELV5KOghhB72HDqwEImyASAn1Z0TnM96kdZw0uFGGoqi0F
	 Tm1y/52vc2I+d8YjqCgk+c74aVeLtVL4yycsTebKVlDQJTgckpFFI8hv+xcgiI4CwMOHc
	 juLmZHYlo3zlWUv4oG/z/+XbEJwEF49Icvg5sE1Txovis/IXEfvZUucTqGFdXXtApFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=KKiLkuiHStesk5TE8OyB7f604YZ0z47hf89flcQlAyI=;
	b=5WbC2YUq6YPFQdvqIKII+lwFpHrO0WSxVaCN5TVl48WWE5zWOTs5adZOQxtPcXgB8moz
	 st6xZs98t9ZUTotLAOcCPHc2QrZdpjYLnA16CcdzwqK/YK/s/z6sCgGzx22bEDk5Hp5z/
	 4gKBgQp7nV180/QSZoPgjX/r+EKqWcRnfCKX7cbOW8D2VdxsBrHxfbR/7fveU5jwoYlxy
	 GnSc/Ks41L1CBLsSfjuJSRTkIPL+Rhfr8F7AmxZBkdblGUeuoK734d3KJeVSISL07ON3H
	 RKsPeK2UtNcEh0IJ9dhJnCUUmmS5quhdGuhyF2DqMaT5mzX+/LolRgyZjBRmucAbZQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="gg/btqQS";
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6315606A335
	for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 14:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6315606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gg/btqQS
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so4769163f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 06:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795616621; x=1796221421; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KKiLkuiHStesk5TE8OyB7f604YZ0z47hf89flcQlAyI=;
        b=gg/btqQS5JggZWL3TBR5DJZDXCrqBrKtiCDjEW3U1VgUBoIKe/l0584+imxrJZ3Qml
         GW+Z9qFJDUSQolFMA4ISs3sWUKXpeKX4V44CMTWwUCKE7KcjCoDktCxaEDL4ZXV3wjA5
         kLOVWN2tWPwrtu2uMg6xL7whDmSwfN9W1sOYybgw2bDqmm3K8EbEgaVPdn1jSJJ2NVkX
         ajq+L0ei0ME3Pf99yPOR31DhDDyp6wweFXm/hvGih1zNycY0kNpgKzhOVzHIrEsGyjIM
         YPJ8gzEZ83xabgHMKdMnKX3d6JDh5Bp6MF8ktuthl0nK+liF8D5D9xyjGKqmkHDqaWGu
         UMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795616621; x=1796221421;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KKiLkuiHStesk5TE8OyB7f604YZ0z47hf89flcQlAyI=;
        b=2W7BSDUNogZUaVj0fWMSk9z3sWc1ny5H0bCoT+LseekTuzf1gJxCDv6m7OMLgEoJ/g
         OhkutI74YvJS/0iTHkcAEnejTv23EahadYsPLbO1rREDqk3sfbfE8qfDyrb2mKeKdrXZ
         9DLql+L4JOwJgLXd+zSgTQOSi4uCdxJN566JATYGJfkiKIwaxRvEFr4lEUs5O9/EZck/
         4ACv6Ei+xgNOsfRmIkYBeocMCT7Zuq9b+tTlSjQFHNAqTj9EBnl7e0RyiOJ1qtseA60+
         83rJymm4VxegeubuxzG1HGCHhTxUY72O4i5ABz0vEMyr7qNRG1tjO6TUaMhM24jz+EAL
         jVOw==
X-Forwarded-Encrypted: i=1; AL+hErF7B0pLifwZd2FNHF7wpWlsFz8eqhLZjdS9iV4k0FK07658XO+VPe60JxKgtrjcUX54XVHp+fnAx/U=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vJkrfdWW1Aa/C/G09XuuBC/jQf2nnxrSV1tIfgVbDlXF7F8AP
	mPV6Yg6fEbCFgIOEesmv+Z9ktjQTNOwjVehWZomogFCmfb5/gjHgW15MUP0VNoL9bcQ=
X-Gm-Gg: AZFdTZfNXB8pQ0Cn4Rv2MP3HcbbJkWYyOHsiyewmgy724mTfQZqbxsma8XASQ9d8PQf
	cbvTThzQImdHjdeF41Gpdd2PgLwoeh+INY3GQeHxxLcCQgdCiOLT/BHqcGALG4cCPaW/wEUGJzP
	BhPIJiOYhP7qhwL8hnoQ8/UX9Ijyt6FVxdIRjC8RKhWFFm0qmfke1LODtKaApCpofqfKjB3MH0x
	VZ0QsI0I4BVWIJ/ZNDxPmIOg8NXOPz3IkyvKECPhiA8mYlg9K88I+kBMcvx88izDwhSxLBbFXDx
	qVfVrhQW3r1TPXWY4j7NWjRy2pmbYUy8HGNM0Nw8K0Tm9qFVn6yv/gXmhs9FTMCY2/aDPPbunX/
	K+bbzrVl4ZysTzhNtvVsVo1NdR4ZgBeuIjpPgXjc1b258Anw/u8CTuhbXerk6UMvISMwoGJR4o/
	DXK1CeGZP4iClUW8U8ZEf0IF9+jwIlOGAzn+wAB3Cb51zAekuTymX/bd5HNUWqyo5x7/YEGOEnH
	+vhYuLbC9CdsUBkC9BQCcVMGeLCgsex6kIXqpKsJzq4SzTP9g5CDBD7pr8WJu/T0MIK/W0XqL94
	eCz/f0FJQ2UbpBqiSWC92yb/onN1MY+bHVoNnjt2R0NDbWoEDJzj/EfEPEgLvQO0yRTQGftoj1K
	CKz0eKgyjuPQTqs6EYydEyQ==
X-Received: by 2002:a05:6000:41d2:b0:48b:1296:52ec with SMTP id ffacd0b85a97d-4abb0c5d65amr34428066f8f.18.1795616620901;
        Wed, 25 Nov 2026 06:23:40 -0800 (PST)
Received: from [127.0.1.1] ([2a02:c7c:5e34:8000:720:5dc9:500c:65bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bc8ce06sm33638667f8f.47.2026.11.25.06.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:23:40 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Wed, 25 Nov 2026 14:23:33 +0000
Subject: [PATCH v2 1/5] dt-bindings: iio: adc: samsung,exynos: Add
 Exynos850 compatible
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-exynos850_adc-v2-1-26de1c6f1717@linaro.org>
References: <20261125-exynos850_adc-v2-0-26de1c6f1717@linaro.org>
In-Reply-To: <20261125-exynos850_adc-v2-0-26de1c6f1717@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 Sam Protsenko <joe.skb7@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3

The Exynos850 SoC contains an ADC block within the CMGP block.
While similar to existing Exynos ADC v2 blocks, its data register is
located at a different base offset (0x08) hence a new compatible.

Add "samsung,exynos850-adc" to the devicetree bindings to differentiate
it from existing Exynos ADC variants.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
index def879f6ed20..90a220e3b78d 100644
--- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
@@ -18,6 +18,7 @@ properties:
           - samsung,exynos3250-adc
           - samsung,exynos4212-adc                # Exynos4212 and Exynos4412
           - samsung,exynos7-adc
+          - samsung,exynos850-adc
           - samsung,s3c6410-adc
           - samsung,s5pv210-adc
       - items:

-- 
2.53.0

