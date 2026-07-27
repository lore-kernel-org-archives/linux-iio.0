Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B2941DE18
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171061; cv=none; b=hMqx9XO2FDnbJ4ITZYOPlr9Yqs8AFMMcFRqirHc6HKbvyq6xB05RG2agABUU8u0LWOhRPD1AOrz5bXbTQMDv5swicTg7Ao1bddEPCNSiw9Qn7WCHEGBRy/BphR3d+vAAbskw26GQ0yT3KFeDZCzcA1vv+cCcP/YzeJrEaG8Qimw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171061; c=relaxed/simple;
	bh=gZAVNAenNNe8ShNpW+y1uL8RlMk/a2pYRFQS9VthVm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeqGe8OmafhQbPfa6DgEz7i3DatXnyfza33qTdCeglRfvB2aWAx1RqC3HB9aZXyZUUMHBL6QI2M2E0eSK1B/PdMcbfuqhBApcd9zrSQT5Ys91KLoEzHPOlh6oZm5H0Dt/SqeuoEcuLwJV/ysQ9bYYV1CSA7gaXeKpUBzGmojLRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTz6HfVY; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTz6HfVY"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-495c63c4141so1680555b6e.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785171053; x=1785775853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a0mdfiM3qjdIeg57ItkPiqiLUsLGffK5s/s59dcT3jw=;
        b=DTz6HfVYjKZwqsYQBa4s+GSIuxx2+DUCn1NdEvWwZq4gbc46p9Q+9Usg7ZzBnyvB56
         hUoNiGLnQvCfgQQYJ3mkdKIJlivlAKRMc+CTiMakSczEy7HxzIUfJZ0pdJeDdm52Qqxm
         p0PcQw/0o/G+yi7cngsFM/BesdYPXyD+S4gG0CNZxoNlDCFj/aBeS5YEobve5A5Eu5Wc
         7ysbqExSa5HID70cQoWoJrVFef3VP/sieA8qAMbCtFGf1+yOBk5uosrPH1Vf/jwwYJDI
         slh82DQY6Slp8+ug3AeOjyAi8YDhRraWcvxPQYcMWkhyqGRUKFYP2IPBZVpLJBkIOXIH
         jPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785171053; x=1785775853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a0mdfiM3qjdIeg57ItkPiqiLUsLGffK5s/s59dcT3jw=;
        b=fuZSgCqoJ4lWFB3Si10GSvTpCOQM06B1+xp5A/55QZk8Bz2uaH5QPwPIWBChlOus5B
         S79H9O3LspC9Cr1MQgSzNSFucm93oqBuiVj/60sgSYbs8r4qn45E+WETI9Lu355A+jj5
         ja69SC3CrA5j9otVa6vWprMHSSADI1ZBXGdR4jh4x/15Pv2vbAoBtvJ3QzYR+/vaLIQn
         mLnkd1cv/htZquikbQVXkGuyAEsytVc4WP8FQdOgXHG6oLyUPjXtfb/VluajIKRtQku8
         fbZN1DPNCXUUCsdWiSur2thElwaw+mignWkuRBNqVDjjjuoGJIoIFO73m56peywQbX+E
         N53g==
X-Gm-Message-State: AOJu0YwlzxrUa1f1eEasZjI3f88ftSB7O4RTKYAKd4OTQEcoph1QZFFY
	bgrsGgjfrOxIdWLkEy9qDqweHY6BtZFt8KfArZJcXOVrcZtC2zE8nY16jP5M5Q==
X-Gm-Gg: AR+sD12BgB+GIVYv2nrmVBMuqrlcUxKR/7GX+Yo+CruWHIW5Z4/m1YE87ZGuQEhNzSU
	yIOo3VbxbSCT0PyqaLFZSSRaGj++8WcOThYg2hZVEF2JxUrXbT2FxHtUCkYlUGry6SXv9uF+0Yp
	Y0fAO3FPk1UN/Vfx4lGCgv2QrdIYe7N2K98X2Ek1VpM5Bp3XqymA91P/suzSbjanziPRpgDQKSE
	hGD3j+N1BjMwMW7qmNvWpsa3WUizgnMeUdBSDaRovqgC3drH3Djgtfyy+eQljtjjwiI7ZVGoh1M
	WnNbMBYp+MQeHfbAMuyFC8lPSCxLMGVLjSExEApaGI6QVIQfEESoqvmdnh5QxflDgvzelaqBriq
	WTQZavXCB3lTi1RjlniXlvuke12Fo5L99s5jg49Itz25YSl3vlKEVMIKdD8e4zKmKwwiy1zlRla
	pMuABBYopxOcJjs5+pCkQS2vGyhi2IVnd9XF716RZPqw==
X-Received: by 2002:a05:6808:f87:b0:497:e7e2:757a with SMTP id 5614622812f47-4ab6a2c4052mr8192276b6e.31.1785171053539;
        Mon, 27 Jul 2026 09:50:53 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:30e7:7cd7:b59:5863])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ab0c7a1912sm11395050b6e.2.2026.07.27.09.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:50:52 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V20 9/9] arm64: dts: rockchip: Add icm42607p IMU for RG-DS
Date: Mon, 27 Jul 2026 11:48:13 -0500
Message-ID: <20260727164815.65190-10-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727164815.65190-1-macroalpha82@gmail.com>
References: <20260727164815.65190-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add the Invensense ICM42607P IMU for the Anbernic RG-DS. Mount-matrix
was tested with iio-sensor-proxy and reports correct orientation.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3568-anbernic-rg-ds.dts | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-anbernic-rg-ds.dts b/arch/arm64/boot/dts/rockchip/rk3568-anbernic-rg-ds.dts
index 8d906ab02c5f..b770bfd5268d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-anbernic-rg-ds.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-anbernic-rg-ds.dts
@@ -871,7 +871,13 @@ aw87391_pa_r: audio-codec@5b {
 		sound-name-prefix = "Right Amp";
 	};
 
-	/* invensense,icm42607p at 0x68 */
+	icm42607p: imu@68 {
+		compatible = "invensense,icm42607p";
+		reg = <0x68>;
+		mount-matrix = "-1", "0", "0",
+			       "0", "1", "0",
+			       "0", "0", "-1";
+	};
 };
 
 &i2c3 {
-- 
2.43.0

