Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0912C3FC5A4
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497842; cv=none; b=sIU3l0XsHWaxaO0WJEcFaSflPf4/dRicoDa0m4aENL2qap9jqNnbgiSKf7a6hA1vfTCGdPx7Ljyj+mpEdDJwb+9HyK1Aqt67+gNjKxKECaCkNPN+FXPNarsnvu4pLAyLOQdY6aL1TLr99+Gg6CSa1KAxpKQVy7FEe4YH9uE+TO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497842; c=relaxed/simple;
	bh=LRUvSV70q0AFA1Wddwi0DnOPUeCXzMEzhUYihJPrra4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsLRLpYIo6Fbl1TWYydxQFHYSFjJ8W6ntL2zt9N/nLcMtaNwFwbvZuHxVpItLCRJq05Rx5BLDzDZg9rUE72xoSkbCKLjyFL70AUlpgeFy5wUWz2W2hQLez/Y8z5cnXvUDevLUWCuvj0k4l7vV+G9JGSAxr22iVGEKkYtg2EEVVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZPezHEx; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZPezHEx"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4758bd3731bso874288f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 04:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785497834; x=1786102634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zjX+fB5UFRlHcf7n2PcBZQATegbj+CND3nwA4wOUKpg=;
        b=PZPezHExEBGXpPucbGCrGI3qEv6HhZbk3cO0A07owg9hVNeVDKpvgEblijobHeo2Qf
         ug1PzFM07iguzoh+X/cKsZEYtT1ycAGC9To6T0JnjjIdJcmOCLPR4GsqImSYkLTSDuyV
         P7h5FPYeBfVcWIRmWfsH8m6cPaCai3dMeyCbyGo25xeSgqXrkk1dSJpLC7eZDaEeB+Kd
         S9W1o15ZkIh895WqGqvelQUJZWZF8bNmHt96k50gx+INtdOfvopG0QHT3c+ln1lAAsK3
         OXpZ+ArxTMrVnSWdntzB8moyA2DQyhFIsisUyHYO27ZcNdLpVxYZijBhRG6f6NEsMm9T
         94+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497834; x=1786102634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zjX+fB5UFRlHcf7n2PcBZQATegbj+CND3nwA4wOUKpg=;
        b=LVSnfDbxx1MphlOKdioGd/4tcxQxg0xop7SwWb7FvhoCMBtEWUlaJvURzqfUlWu6Ii
         NJx/s5RBuUBmGBLQqlAxDT2bSC+oWoWqNUOyud4LJ8OxsYqleuXfUHBXUCiNsCOOzzAk
         3yyeojVHILw76zez9ROWrQ9HsXUlVSkn7cns3BdtyBxuY+K52chX17yTUY0Ss1S2Dj4E
         2KzMonncQQnyQyQtNqYlT8W35Pj0W7bJxF+H4vim1GE0R6kBafUYTN32yrk/RYxytecS
         dCvWllV9YrhNAHCLzbFee4tu4HnmPCyel2rhCk9P3alRo6LbOq0cV1hzKqAuJ1/T1SgH
         QS2g==
X-Forwarded-Encrypted: i=1; AHgh+Ro4ePJM3vRSyAGS9lk4/qYUgQWking5rVeDvJ9TLuEvY4179Xn5hLwFmzzmYeX2x4wrZ142U3lPd/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTdspUkMn1Wi0jSRU7rzQ7XeQ1KuBS9nmENrUV1UYBW+8sR8jd
	+dZkxhz+lHyNdU3X1Z6xxP3x/VUF/o6i21jhxGwOHZ3L/e6vhpiU+1hK
X-Gm-Gg: AR+sD11SiCgam+9IMDWsUdbRYsyb00ldaPfT5CDzPFhb/Us7ssCy/1YN84/YTNElMgB
	zW92OAPZVO16RcnOuYDio22GbXK/CkrSXHekeq1Y/tTV+tVHgKzPG8cc6rO06yy5edcatJ4p8Rc
	xx2MUFuDocLTNXsbjbb5LJhyooosU1V+eUisyddZZBReWCFfuxwx4fV28eOtpw988dD5/mtvW2j
	mCvLoG1GsQ/e4Y+YeaKN4CsoDbOSxy4njHxFOSeVRwXOHVPTTpTRfCmhEylg2+KrzViiSgIiyf6
	QfDDfIxOkaeAD1tSafNx9bHVbASvR6wGzN2LMZxnY4vrqiZsQXMT3mRPTftR6beR6qunIn4dXYj
	jfGfiAyQbAdqb/Jfszpw9TRBy6JwYiKhXyeIgiw5XEbwzbQpC2MItdlpgInGdQGYalLChDyLURR
	4sfe9ih3VVYHrfLDagjBD/hBIk+Ub8KOloY0LIC3HoC6eW0Ku4Doz+ltGcookt+WcCb23odsRXe
	gtjoTy/BQ==
X-Received: by 2002:a5d:5f85:0:b0:47f:70b2:7321 with SMTP id ffacd0b85a97d-47fd32fcb20mr3516082f8f.27.1785497834285;
        Fri, 31 Jul 2026 04:37:14 -0700 (PDT)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm3670646f8f.34.2026.07.31.04.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:37:13 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v6 10/14] mfd: lm3533: Set DMA mask
Date: Fri, 31 Jul 2026 14:36:28 +0300
Message-ID: <20260731113632.158440-11-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731113632.158440-1-clamor95@gmail.com>
References: <20260731113632.158440-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Missing coherent_dma_mask assigning triggers the following warning in
dmesg:

[    3.287872] platform lm3533-backlight.0: DMA mask not set

Since this warning might be elevated to an error in the future, set
coherent_dma_mask to zero because both the core and cells do not utilize
DMA.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 2a63df034171e..9233da7ce0996 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -479,6 +479,10 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
 				   LM3533_BOOST_FREQ_MAX);
 	lm3533->boost_freq = lm3533->boost_freq / (500 * KILO) - 1;
 
+	/* LM3533 and child devices do not use DMA */
+	i2c->dev.coherent_dma_mask = 0;
+	i2c->dev.dma_mask = &i2c->dev.coherent_dma_mask;
+
 	return lm3533_device_init(lm3533);
 }
 
-- 
2.53.0

