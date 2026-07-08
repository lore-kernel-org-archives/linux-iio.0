Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF37632E141
	for <linux-iio@vger.kernel.org>; Wed,  8 Jul 2026 03:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783479995; cv=none; b=U1o+NyOopOK5dw12hD8Mh6hOgR9+6E/h9QkGdMyesZhMy4BrZIA7qyUdVbhy8RpCNNyc6KevoRy9l8uvywVkfiVzfCB4Qps9qjsRQva+F2wIN9hB5d8pBigqcnE0ybRxpQ4bqACUZXQgx5FewzcYDcZQzX7TX8OkKXi7pTYh6wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783479995; c=relaxed/simple;
	bh=IuBPO6cEbZCj+He2MrVVMVNP0++DMFyTpWWomPkHa7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DZwgAUMXcVw5X1XlL8taHEW44OJS+Whcv0uNDew9wGLWkI307Lj2UlsXTVNFhSKsdBTys5YJd27yN42QICSPYAKB9GfNtY1kyfX9ZuuWrhkyETQ1DhSDoYnFJ2+pjk3/b4lEp978qfnLO9J41Lj43tgTWZOSTLvM4ggXuqDS41g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=gOnkZ7qr; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="gOnkZ7qr"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8483d01240bso149519b3a.2
        for <linux-iio@vger.kernel.org>; Tue, 07 Jul 2026 20:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1783479991; x=1784084791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Z20ouYQOBhn4ZXilsDJAI2tbn5DOlUdKjSxNm7DnCQ=;
        b=gOnkZ7qrcvaWoeOS8KXqwd04Nwo4MCCEpZRD/rkmKhvXH2YsFkUYtnSIFhgdjpiGr0
         fSjn/lEAz9kjnXvFlQCr9xrsuVykuT3lPgCeOeUoyEupzabLjNhFe51qMazn+aN3LXsk
         8TyawkNOzmgifWwgIAeyF8+GyyrgcNQ+3SCzXw+GgC2c0IeuEQ2HFiWT9v3UY3w03aUL
         QgRCMu64m1+O6N3aBt4ZTnPsROWaPxbRLkFdiyAVW6bb2Eni1Zwypx/qR6BZd7O0oQcQ
         uDXCvaw2LgfvIbUVSyJVlItWbW/q3welXnyg3KFEJoiSh8Uyp3/2fdsvUAgYvlbv2bFM
         /BSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783479991; x=1784084791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Z20ouYQOBhn4ZXilsDJAI2tbn5DOlUdKjSxNm7DnCQ=;
        b=d0cpHFoDl2BkI67KFtf3BvGxS54TlZQfjOUVuuhLf/QXX0WBGriNylfnsvq+yiiTIW
         MGXvQKFlI975SFq5mdLg/Hgvqy5jxHJwly9cHiJzHEK1AuQBctjvZZ/W1EhDJPpiFu64
         sUytb5NQfWGIUfm/dnSGq1gWwb4VBkUoIZ27YatjolYlStLCiQGc5CWl2AtrbsQqjqU8
         s2cO1ImwNNdvL1e/fin/P/ZoJf7xTBeimPGoQvYmayb+yJTGOCPcyRC5eBgoaIlnMpgE
         rBIhs05AfB0UFMfxWEu9T+AZ1P2vwGGGVvPwZHpHathk+vekQRc6xwoh1ZbqrmfjaH/X
         wvaA==
X-Forwarded-Encrypted: i=1; AHgh+RpYop4oYiZ2j6IzANnVIVWHmpE7zrDpbAlUZnsTHRKZygPjEDQWqddxORtKUxQaactcfwoCYkGTwIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy9w4kV829vhgQM+Ql8mh4m7SL2/lWiEW54woByM+YxdwGrx+W
	Pd/Ey336Fhbfzonv6j9+BW1TF2gzSIQyLxjVzzIiAwzsCmFVQq0o2nZGWZUMITWIyl0=
X-Gm-Gg: AfdE7ckKWJbqjuQzKWupZln7M1a0MrVJmI9hTJ32TWJx4YF+HZXUpxa8s5mkP1QdoZf
	pjdTCwu+eSk6yIhKj338VTg49CzV+M44cdmZLcJHH7H23mrnE94AZSRyvC/CQJ5O6M9bmw8zxxI
	52Eb1AdRJrkoWIxf7lGzzRlGR7vHk1q3ygvSDLjPESwwMh5ADDf3cZvh8FA0o24WH80PAYKcGST
	Jpf1thvSabQKYJN9TlYAlOzS4/bvwrb0Ch4W62lHrhhEpMvmP6NNTYWSGqjmfNlobsVwZ92gddB
	hdvZWCpha0y6XDWzJjZosQhZDV7xtzHxJtPNylXM93RE6zKSM4wlPY89p8mGpCDYnK80kIw6Tv5
	N4nZVstzCCB5TS/VssxgK5s0XPhD87yopBGwu85fj28/lF+NAC7vTezyaYYPfrNOmCQpmNO0YNg
	==
X-Received: by 2002:a05:6a21:3383:b0:3bf:b960:6fc4 with SMTP id adf61e73a8af0-3c0bccd3a30mr584976637.30.1783479990537;
        Tue, 07 Jul 2026 20:06:30 -0700 (PDT)
Received: from CaxaCaio.localdomain ([187.35.188.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm10951847eec.18.2026.07.07.20.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:06:30 -0700 (PDT)
From: Caio Groff <caio.groff@usp.br>
X-Google-Original-From: Caio Groff
To: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com,
	antoniu.miclaus@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	andy@kernel.org
Cc: Caio Groff <caio.groff@usp.br>,
	linux@analog.com,
	linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: accel: adxl372: replace manual bitfield ops with FIELD_GET()
Date: Wed,  8 Jul 2026 00:06:11 -0300
Message-ID: <20260708030727.1378063-1-caio.groff@usp.br>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Caio Groff <caio.groff@usp.br>

v2: add missing blank line after reg_val_l assignment

Replace manual bit shifting and masking with FIELD_GET()
macros for clarity and consistency with kernel coding style.

Signed-off-by: Caio Groff <caio.groff@usp.br>
---
 drivers/iio/accel/adxl372.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index e375d068a3f5..daf5813ff50e 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -150,6 +150,11 @@
 #define ADXL372_Y_AXIS_EN(x)			((x) & BIT(1))
 #define ADXL372_Z_AXIS_EN(x)			((x) & BIT(2))
 
+/* ADXL372_TIME_INACT */
+#define ADXL372_TIME_INACT_MASK_H  GENMASK(15, 8)
+#define ADXL372_TIME_INACT_MASK_L  GENMASK(7, 0)
+
+
 /*
  * At +/- 200g with 12-bit resolution, scale is computed as:
  * (200 + 200) * 9.81 / (2^12 - 1) = 0.958241
@@ -577,8 +582,8 @@ static int adxl372_set_inactivity_time_ms(struct adxl372_state *st,
 		scale_factor = st->chip_info->inact_time_scale_low_ms;
 
 	res = DIV_ROUND_CLOSEST(inact_time_ms, scale_factor);
-	reg_val_h = (res >> 8) & 0xFF;
-	reg_val_l = res & 0xFF;
+	reg_val_h = FIELD_GET(ADXL372_TIME_INACT_MASK_H, res);
+	reg_val_l = FIELD_GET(ADXL372_TIME_INACT_MASK_L, res);
 
 	ret = regmap_write(st->regmap, ADXL372_TIME_INACT_H, reg_val_h);
 	if (ret < 0)
-- 
2.53.0

