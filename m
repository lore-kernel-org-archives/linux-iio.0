Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00943AD53B
	for <linux-iio@vger.kernel.org>; Sun,  3 May 2026 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810217; cv=none; b=tRPaUBlZobf72e9ZM1iXO2SUXW1jMjbs2nQ/qxn1UjQK6Pn7pdbE/FM4+km//vMgDuMGPJ38a3mUDsp8B1t6kWMiEUgo+vcj3JZn8QRYh2k+L3taP+pij77/8fHBRz1bT7CBggjhr3Ak+0V54u//VQBhvtr1QJPbC2/Ut6WrLaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810217; c=relaxed/simple;
	bh=WCLmJv0TuyoCPe5fY1tMyic3ZulSQKRkwgkbREGxp4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fn2D+ezzkle4IWIN2iD7JpVmYEcrmmmNZECzR8k3tUzvl9SPM1pQ/uLENP3IPlwfIg+NYadUH0pN/PADWqNhxGWt89OMtsyumZ4v+vh85PItAzKLc4kYqLQwmY49I4swuWdjAeX03RS05efBXXT/ESDMw6AIpnrdsOVgB8H0NOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goU6gLEK; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goU6gLEK"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c80148ae949so211702a12.2
        for <linux-iio@vger.kernel.org>; Sun, 03 May 2026 05:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777810215; x=1778415015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qA9kbxgmrtt9myna//5BeoIpHJyNBXuDKkpos5wjQ7w=;
        b=goU6gLEKw+OhWiBpaHHbLaR90SBD/ImsYoWf9tMeSq1KgRpM2THJYPvQizCe9xaDWb
         YItWx+Da9UH8PF8sOldo9Rarx0Om1tg0BSa8mHWY7v0qtIQYUvkCN5oiKq8DzGd2jRqM
         4PjV5ZOmv8Nbm4gdjqY7l9EkgWH+gMV7hN/dZeKfYnrQ8AJjwwJaswGBAKgfdcaINpcE
         0RF2PzVDpKKk1E+cEERDieNiISKEXmNRhqsaPOOaN4IaN20heJGwYpquUGFgf4s4SZsP
         b8CiL0wEkmB9399smPdyB0V0jjpT2LOiUG09l4srhzkraemuWj/M9z4Z99CJb2fX6Lg6
         H34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777810215; x=1778415015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qA9kbxgmrtt9myna//5BeoIpHJyNBXuDKkpos5wjQ7w=;
        b=EpG41SO65PAXeYAwDr4xKQ+/eN7NU9J7hUqDuONkknSLpsyWJHSxHjbFwxrV1qOsa/
         amRlzOL+eUooRhUPBu8Xvby6WCyA4+JAGojY6hqyWkm8zAgRIKYH3HHvwTwETdQA6x7A
         1m55U1f0kksQeohSXB727sSkLP9Y3PWGul5RGOMlQa6vR/khwaQrouM4xo1iGRh89bcf
         sQdRU6ocYPnXZ2ZQhrvhwKVNlFzCARs53fYshGvgzV+PnU0kHwtP6wSJzSHgLz6gqzZn
         mAXz8nO+LpsDneIFx4YtUilMdw1z9iyDF1Vc5jSmyc4njQkWGL8ptQIY+XVvW0Ozb68M
         QCsA==
X-Forwarded-Encrypted: i=1; AFNElJ+PLhVjN5VnA35DFYmtcQVwfijQgxmq8CmuWzPcHUqGCOSHRDVft54UK4pMbQEztoQ2gSnpQPjhPx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDgJq7KEagWtkBlPlMMPTr0caxjm2LYC1BRqQe6Z0kC/5fq4Lh
	u9hqTkUAeNnphl8iiNCiGtlA0nzFnhdp40wvI2gEH1M3H5Q+psqyOAjq
X-Gm-Gg: AeBDieu5V9rVHjeya6AXyX/uHtuXvXH8SHrA4x44VL7iDIFeRIKrZPaYnexoSoYj205
	+okzt5/pKrGbWq1v6aUoGyrCWH6GvAVhLBkcWD6v/hqk5MRxgXkWSHCTs35FMECSffYR9hMVp6C
	Fi4dTfJWEzczz+keeJrtu46xJvXvQPr9OksOn73fLpb+rSXQtaFz62+LEnEaJx6w6W6I2eWVAUg
	RvxEk2M2t0ebf3sJOjy7PK3Mj2jsoBOVEa4XcTuKdtOIzQIOcaP/H8cw6US6KxOMyNLqO/EaB46
	fwDWn9Nm/Iqqpp54CTj2l0jd9yJ9t+e3a890GhogmdOSx/NlLKwTeqau5DAa8p9g+pWy+orUL24
	wyTZEtRUhEnk/bDoUXBiwUkMa1xM54liadF/RK7Cx6iX5LUCrLmjtlfCBSd4toS1U3lygs9T+Ii
	mf9SJ1qBPD2U7FQW4skVGCph7kb1w599GPx73LnikCB3cXC3DAGRndaD5e/pVTkG34vH6fhKf90
	rx13soDqQlPU+D6K/9IKPnw2zzL9B5j56C5yLdGPa/c0Q5rMJvx3giD7I1bwSQsuHoT+LSW8rKs
	L4w9Hw==
X-Received: by 2002:a05:6a20:7290:b0:39b:d937:8020 with SMTP id adf61e73a8af0-3a7f1c52686mr5876488637.42.1777810215055;
        Sun, 03 May 2026 05:10:15 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8357c4f4530sm1474364b3a.9.2026.05.03.05.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 05:10:14 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 02/11] dt-bindings: iio: adc: hx711: add VSUP supply property
Date: Sun,  3 May 2026 17:39:31 +0530
Message-ID: <20260503120949.80292-3-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260503120949.80292-1-piyushpatle228@gmail.com>
References: <20260503120949.80292-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the optional VSUP supply used by the HX711 on-chip regulator.

Keep this separate from the HX710B support so the existing HX711
binding extension stands on its own.

No functional change for existing users.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
index 1ea60dff98d5..a8eaa1f18de5 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
@@ -33,6 +33,10 @@ properties:
     description:
       Analog supply voltage (AVDD).
 
+  vsup-supply:
+    description:
+      Supply voltage for the on-chip regulator (VSUP).
+
   clock-frequency:
     description:
       Controls the SCK bit-bang timing. The value is used to derive the
-- 
2.43.0

