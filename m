Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FE2414A13
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 11:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783336983; cv=none; b=mD7LPiJJdfUBg1FPGk75AuYverGtMH1xg6Zw3IOvH8C0ssiREDq2ae78GyYqGKOkcYuUcpxmNaQR7MHwXXSI8uiEpTxlK4h86GIUlbjfNsZj49taIErOMWF3D0r97TEmZEYKFBAk2g28h6QAcQiwJ4qkTdpoNNVKttMQKS2n5mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783336983; c=relaxed/simple;
	bh=iOMuK9aVJEuVUQ9b0cEhBJ/dAfR+iCvS89b2JQC8Y1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oO/JOQcfg8AmDCK4lzs7Dh6R/WG4HcgkxVT/72pws2o9YJl3MIiUGRbpApNPQYioX/eenpII9y1hDUVuvMUhs36NC/USBl3r+kBjlTKeZ42SnYNexHZpuoIi6qMAUmVbmk1gfZcH1EIa02r81Ksdv96aXnATkCs2Jl+jRaUMcGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6rBpw7A; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6rBpw7A"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aebf162770so2872943e87.1
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 04:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783336978; x=1783941778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EZLpAM4NkTG/jPbKI2f6Kpk8sjFPyxK/lycnX5c9HY=;
        b=f6rBpw7AJ3wqtWOKL1o8fzoAVWv/DXtJ5LulNwYCL1nxJ3xBxNwCR2c+YzlKcF49/h
         oNlACZIz8b+5pwCRdDbDlNSbrdyzZQBD2jnmHX+Q0F/5FImynWtu212UIVm5M3bb6eqx
         XV+uHNM7mcQgCh80UK+fWJCwt9836o2M+vVoAOJ3uUvR1/hHVpjEgKmQspeukPFljDoW
         Cn5VGrqZDBvBuwL2cYdrdLuoUb3I8Ysd9bRpCObRTeGws/ebFFv/v9l7CucP4s0Ib+AN
         K8CQy4auZCm3OLGMbUX1t+36oaFDfPgUrh0ipG8Gk6/g09/QSWKpZTPO8CdvBNQcktnG
         zfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783336978; x=1783941778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8EZLpAM4NkTG/jPbKI2f6Kpk8sjFPyxK/lycnX5c9HY=;
        b=UnkfM5IYoR1w7u0eS/vsXf2UHupZyUNNeVlTgRM13Fq+TzowvfJxBl4k57UJDdCK8u
         GsQsu6V6kIRq57nuFhXqp5A6BWcU/wwo3FKnFTDag93jFVOydFmR6mN8FhikDtfcq991
         vvP5+YNY6+XUrfMOCb1nm9GtY+2xZQzKlmilQtytCYQhlcDB6CdDRFK6rcT28Of+0a9p
         vESGCaVs6guTOxFv5LD2/F2/LuW+lcCM9AOPQT2V7id2Q6DqxzZjlp5jdMU3BXX/H4YX
         4whbwgLG0xPb9M8vko4xDS1JGUo0dAa9M1gmcMTJRr4Ql4mznps7a3+9Eeu5mp0AVvE0
         gf/Q==
X-Gm-Message-State: AOJu0YxKvrQO2A7TPdklIoNC0QQooJnKE+bg63f/q0Yz0qbj6KGyzEcI
	I3t9ayxtUJX95T1cGosYI7lmjP6+9IeKy0AvPqzcmKH/tg5pAICc5p0YhZVCTyKCsj1wGg==
X-Gm-Gg: AfdE7cmI59NfvTAFyGDwrMA9PB7PYtethWoXEWmcV4+fNLs5Y1qBmoFH5tpfoo8JgZ0
	1Jci0Ap68W/5Ulsmn+GE0WJU5ImhaiFxHUuWB4jxj9z7CroLJkSmUPaou1FSRGFW13ga+oDxaZq
	K19g6TTB12g4ccOvNyAHo6qV2FGaLWzW5jMhdg4Eark4q/RvEw6GAxfJ7vNq+nfDG85/rtsQw8Z
	heV/xySwNUmoC9zOPRanuXqrLHyx++cxn4G6K2ilOdHiTFOzqzVyTpEsjHt3tey8bmlOQKZ3/OT
	UL4tWd3YRDmvD9xjoiilhR4tRTYZvrzfFjCa2F6UAkrJjXi5yktAnVfGOcYjZ6STbYdNJvCJmYl
	/IcjHM8YZVI/jQXgoSi41MUJGosC4MDPu9nEqXXnI5rl97WZa+0Syk4COkZaKyIJXoPc54LzijF
	R6mWW7zXc+t8vojy4JR12F5/TxPb6VgMSY5t3T2LC3bXGLBA==
X-Received: by 2002:a05:6512:131d:b0:5ae:b6b6:3661 with SMTP id 2adb3069b0e04-5aecf4af799mr3342455e87.8.1783336977772;
        Mon, 06 Jul 2026 04:22:57 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13c3a22sm2739145e87.72.2026.07.06.04.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 04:22:57 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	krzysztof.kozlowski@linaro.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v6 3/3] MAINTAINERS: add entry for MAX86150 IIO health driver
Date: Mon,  6 Jul 2026 14:22:54 +0300
Message-ID: <20260706112254.1262002-4-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260706112254.1262002-1-shofiqtest@gmail.com>
References: <20260623140730.12574-1-shofiqtest@gmail.com>
 <20260706112254.1262002-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a maintainer entry for the MAX86150 combined ECG and PPG
biosensor driver.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3115538ce8291..361a7c8b99ead 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15863,6 +15863,13 @@ S:	Supported
 F:	Documentation/devicetree/bindings/power/supply/maxim,max77976.yaml
 F:	drivers/power/supply/max77976_charger.c
 
+MAX86150 ECG AND PPG BIOSENSOR DRIVER
+M:	Md Shofiqul Islam <shofiqtest@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
+F:	drivers/iio/health/max86150.c
+
 MAXIM MUIC CHARGER DRIVERS FOR EXYNOS BASED BOARDS
 M:	Krzysztof Kozlowski <krzk@kernel.org>
 L:	linux-pm@vger.kernel.org
-- 
2.51.1

