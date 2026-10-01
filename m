Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEB6397E96
	for <linux-iio@vger.kernel.org>; Thu,  1 Oct 2026 03:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790824160; cv=none; b=HumrP8fhkLin2L0pxQEP6vimG0JVRJKYdeErMOXKAAx3gslm12RyobN6UXkDJN6Nwl1qnE0L5ST50D+CVDxb9kpx8dkET8TymibplwqFYrTVwjZEGocimN++Fk4ASsSXJzyYqCQcfoPnEwEwQyVBCnpw4aAeWw70xJ1gqtw2iYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790824160; c=relaxed/simple;
	bh=+Y6ho4fGnS+OOcq2D1geI15LucrZk6rDnmXB/fX3KrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wd9q8Q5e7oEVFRGMCnmuvy44gq3KZGCXon1QSz92fDnzo/EF6mvmf4Rt9dyi3WS4LCESTvK33jDzneMd9z+noZJ55qwvPWVoA6YXKCw4lhsJKhbMeR3nmHlDdX13RG3aqrc8eCDVKfpRuGhLg6m/l+sp8odBZUFGL7uMxOhCkoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q1mgWLsw; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q1mgWLsw"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so33527515e9.1
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 20:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790824155; x=1791428955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s1xaYOvgfuKPDqlqGi9mu0d7G4P5AdYn7w9BHWtqREA=;
        b=q1mgWLswOInuXiNLP0e8ys1PsHWWvwHaN4g6NgR5w8haqpvYG4dwewdJ/8YAezYMX3
         7imKNw6VOlRE/VNdeRPVvK2l5uZ8Qq27pC6RnghT/25ms6uumvVHuddUJVGpNE8ctYAF
         arA0GOySYndWA2vRcWifXyK/3t0oNpFEEpSK+F+WXg1WUf4RJlzmLnm8hIGJ0AAKTyTt
         LvYnnwmsorcBl1+C8blDmeMYhTRANuhlVaNIlBYF3newTx+wtcpPU8UVmbyAzF3qm6+d
         wa5d0ki5qngFYLjdNG5AjXIkeO3XUPkCkyRnmulQ5nGTstANT3lshGQdYAH3bHBLoQ3J
         m07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790824155; x=1791428955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s1xaYOvgfuKPDqlqGi9mu0d7G4P5AdYn7w9BHWtqREA=;
        b=C8o7jDYqntEU57urmjsd9r349dpg/CvccopbE29/J9t7NcRsK2+5SzoYewAGzgFBOE
         WZHyr66g9Jad8dhU1xMVjL/dhy0xnAhQAmw0V2K3sL6vGcuUk0xpW1eXROsendOJiBcL
         8gbIuSZfK6SyG+jFZCXN9HwFtEqglAKcbQQMJLbSNurXdYwCEqer9Tlj4JZh4wS2sKbj
         RAAssQBA1bEBZQPEYAFlEjyj3wLZpmGJVaG1yvV8HeN2I5y40V+dH8bT757Ua/y3yk7W
         Bb8IkDWtQ+wg85hAXJAEeDusOgcd60YH7At06Ltf8/T0nb6b4/edpVYVaBbHfqADj2/8
         ebZA==
X-Gm-Message-State: AFuF++m9tJXF5q7DDEnOtNnMUlBUbxS70zjUfr6i38uMPYmYnDbdL/Ro
	XYVv2txTnMlVqNWphbn+4WPQucpOwGADTKmaeypvY0cUe/F8GO7+M6D6sTE8X/v92jU=
X-Gm-Gg: AYBFou2mHdwzqpQ3B4Ber8conzNljRJeTyeujEOlKLkJuV/cG14qq9r+e4OFD7GchuZ
	Z4iNlMS4bvz7QKV3RJ6KV94ZGbT61JTBbJp8qeMBkIOiLTET66VFvSbQFEinocusDkyienmifx3
	oY/X7GXdLbMWO7xOGS72Z/DWushphyS5cfX0B0g/A5ENgUledzChOhW3slAPPLpVQrmQ71+srfH
	YCe6LkhVP0AFeeediuLC4cmM1cE3wQOaQ074rKQSPIOla6DXu4dEv2QZZXTfqGCC3Df57O5eCpY
	x74pXxqcl+SOdVutj+A7CZOH+F1w7fGS4ENpviRVRoUBV+3/zY7iV/Xb7aJT0udQvceJazw0QWS
	f5nFlw3vOgq0e9QeK8HZz4GzAzT0/AJ6nZVfs+/qQLi3GMTXmPb9IdzFWAUF3Y8A7E2rWz0Bysh
	YYCzsr1w1S+ukVSO8JIpOFFxDlVGj0ULctzvGcXS4HAS1DnEdnU2n1kW54jcFl8UfkS8gQ+C37A
	jHjL6mb54J9TrRJs90x/QgQpGrSw0LNd+dgAKvJrcIxE7yW1bHMSZo0DAzpqw==
X-Received: by 2002:a05:600c:3548:b0:4a0:8f:7e42 with SMTP id 5b1f17b1804b1-4a01affad8amr46885985e9.13.1790824155497;
        Wed, 30 Sep 2026 20:09:15 -0700 (PDT)
Received: from [127.0.1.1] ([94.4.85.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f9145e6sm27091885e9.5.2026.09.30.20.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 20:09:15 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Thu, 01 Oct 2026 04:09:12 +0100
Subject: [PATCH 1/4] dt-bindings: iio: adc: samsung,exynos: Add Exynos850
 compatible
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-exynos850_adc-v1-1-791b3516bb9d@linaro.org>
References: <20261001-exynos850_adc-v1-0-791b3516bb9d@linaro.org>
In-Reply-To: <20261001-exynos850_adc-v1-0-791b3516bb9d@linaro.org>
To: Sam Protsenko <semen.protsenko@linaro.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3

The Exynos850 SoC contains an ADC block within the CMGP block.
While similar to existing Exynos ADC v2 blocks, its data register is
located at a different base offset (0x08) hence a new compatible.

Add "samsung,exynos850-adc" to the devicetree bindings to differentiate
it from existing Exynos ADC variants.

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
2.51.0

