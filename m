Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7736C4A32
	for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771697355; cv=none; b=fh7HMMr2Xvb+ZlGmdCA621Vad+owQpnmqchNKv8LW3Z8D2WMLHuiMXxb3/ZpKlHGOjNs3r9pNh7RlaB2bilfOiZtwCiHDiposmt4xA/IUs6G05UUdF8FE+4o6Tc6o4HT31Y1C+KLelATHR9TIHslTx2A/DQW4IrE3ZDWOL44BwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771697355; c=relaxed/simple;
	bh=Y/RkG0UfYfithP+xjMMMzezYHNYm5gglQYGINrugAO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=g9irv2oWR6Rc0GWV1D8tIr9gZuXCnyG+iostukQf74N0K5hqgHxlX2z01sRHj3dxCaD2xx5xp1AnO+5wI2Y1gGiESl7MHLB4JSMmVBUxWQ6agBRVLJhSpUe2zrQNOme/WLQaZol8N/rBbH4hVbVLYLLiXSz1b60UZHwMJF3fEwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jm3FBTtq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm3FBTtq"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ad617d5b80so18445175ad.1
        for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 10:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771697354; x=1772302154; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5VDYBtsi3uJgUFJuA1Pc21GGucvtIIUrrdyTVKdBHoY=;
        b=jm3FBTtqpOytjUtPJVYL/mp78SrC8LcaSKPlwn3WOZ6/oM1ywMKJ9nC35eIo2pPfb5
         63MOyphoJFfZSF3U6TR0QKjzUDhriNUjsTVFTw7MeZHYcZKoA2k1DqjA1SSqIoKdAlEf
         4b2lOi5RX5+3M0OtE9kzO7XNP4juwO9eDO2oz0sCXaL2zpA6cS2pfdqE/Uxi9mPjbc5C
         XdG/G21dXQy5cljOCJc0UwSFwIHo9HTUt1QKLB/b0ggQIfS8aGv3golH+P0S1VHEm1xe
         ftHMd1aRz8txNC0rPZxnubnXC8b/6O3UMEfvoHuUMFiFUdVXqyShIBwvpipi2k7fl8pA
         CtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771697354; x=1772302154;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VDYBtsi3uJgUFJuA1Pc21GGucvtIIUrrdyTVKdBHoY=;
        b=TSICdBHYhQJicgU4e7cvSwZ52xcggvdVn1P1eeHS4gN2y6VCu7Gp8B6KWvqfM5coxj
         78aUIwh9a2Q/n8hXCrAlWuBI0xXapOWJTWucsT0WA7mcPRIaiCk7lNE53R8vacVTuk6B
         /9N9k5jxgrxFpl6wwB1kVUttDJHkwlpRN+pKqftOLq9QWSSj40MGcumlkf7iYP4/eTQr
         UqFNLKfcadL8BJR1XfabQbiJ05vMqrisCYC/KQhVUSl22J1ADV2vqtCd5IfSPxc2MK+Z
         A4p/NUSgIdv3eyRi3ZPTx2bcpS3SG0axWWQ4Y7wlNRrAN9Yz8UmXxKuPmqXj85XBIVWf
         bcXA==
X-Gm-Message-State: AOJu0YzAexIPsdcmTkGyatAYKrWX4HxazyV+emKRWpKlL7YhVegwBPs7
	/Yx8yOV3vLX+7JtKUxezLDr2q1HZtWM4wbPLxGOJwfX/66EFzz1mbAlM9v9HWyhErDw=
X-Gm-Gg: AZuq6aJnVOdBx4UhAXCJBSQ7WpgdYnkhWW2lOilfWIYtfYNcQkzdlkX4k4JP8ZBFBLE
	1Cpvx7rwsp2jPgN8lK3JFzSeK4WIaoIhyMRq8wzvCRsEPBcUz3TcBy0cfKZYWPUZv389sciwyF5
	09PXcocZPnmYnXTv7IndLC1qYr1K6MuRPfEKu1ygShrVRvuO4leofNaDOd/J2sF0X1lJPNFlSmE
	vv1GZY2tSLeTPd63hnuPO2qREijU6W/IGb8Js/Y0CzkJL0XTeVPHzcn4NM1fh4d6I5PaAdsrXkQ
	hcdv1lqw22M+PBx1qLafDY04e4v49Sg6FkI5fo2FHb5t16VXdBN5EaajcjOJIFhX2k7AzSJ/lFJ
	ph0u8YyaGSEIFmb4SU2NcCL4LwTveDIXjZXUrsL7nGw0r8/2GI0W+PTPI5RgiVXvbWKeXnPXH9s
	6eQrZ7w2QdwfStfTcZKLngSrynT6SsdPfJimtoXA==
X-Received: by 2002:a17:902:e750:b0:297:cf96:45bd with SMTP id d9443c01a7336-2ad7446412dmr27068775ad.19.1771697353810;
        Sat, 21 Feb 2026 10:09:13 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9008:ba52:cd9e:8578:84b4:4918])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503fcc5sm28023175ad.76.2026.02.21.10.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 10:09:13 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sun, 22 Feb 2026 02:09:08 +0800
Subject: [PATCH] iio: adc: nxp-sar-adc: Remove unnecessary type casting
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260222-nxp-sar-adc-v1-1-75e4cdb3ffb7@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMT0mWkC/x3MQQqAIBBA0avIrBvQAYW6SrQwm2o2JgohiHdPW
 r7F/w0KZ+ECi2qQ+ZUiTxwwk4Jw+3gxyjEMpMlpIsJYExaf0R8Bzayddzaw3R2MImU+pf63dev
 9AyWQyildAAAA
X-Change-ID: 20260222-nxp-sar-adc-1906a65ce5b6
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771697351; l=1003;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=Y/RkG0UfYfithP+xjMMMzezYHNYm5gglQYGINrugAO8=;
 b=tlMoKCkEiQG9BUQzdHRjzL1jYmKghIrBr2morPpwFHAJ+uATBWjNiCyJvRiwKOcKfI3mUaTOi
 gbxD6cVByhyDn1RUuJrvNPaKSjIvYg28JGkybJoikTjywnMri5wCKbw
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The readl_poll_timeout() macro returns a signed integer error code.

In nxp_sar_adc_calibration_wait(), the return value is casted to u32
before being returned as int, which is unnecessary.

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/iio/adc/nxp-sar-adc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
index 9efa883c277d..a6e4888a8464 100644
--- a/drivers/iio/adc/nxp-sar-adc.c
+++ b/drivers/iio/adc/nxp-sar-adc.c
@@ -247,7 +247,8 @@ static inline void nxp_sar_adc_calibration_start(void __iomem *base)
 
 static inline int nxp_sar_adc_calibration_wait(void __iomem *base)
 {
-	u32 msr, ret;
+	u32 msr;
+	int ret;
 
 	ret = readl_poll_timeout(NXP_SAR_ADC_MSR(base), msr,
 				 !FIELD_GET(NXP_SAR_ADC_MSR_CALBUSY, msr),

---
base-commit: d4906ae14a5f136ceb671bb14cedbf13fa560da6
change-id: 20260222-nxp-sar-adc-1906a65ce5b6

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

