Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D9136D9E7
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 12:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776430187; cv=none; b=BPMwNIFGPkvUGg6wCKSnbrr3qfYM0iY0OgoR4hBNinI/7QM7gfYHahynLEiIejJCbFRb2PiQZK5avAUbQvhadUHeIzbGZVZkO41IDSpRS7hhnDF71b8hmVAodMxutn1Ck3cIkxhQg4camgR+xULZSii8+UPmYwy+jNOJg4gjNLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776430187; c=relaxed/simple;
	bh=qXCjDz32Ejwsyc/QGNOrStXFdACb9FOwNTJl7zDbkvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WxOJLm52pVdIgBrI9+NRkbcisU13HYEkggRQ0/o8m9A8a8gmiTOrgwBkgR/2zXuaTWAmBPgI+9h5u/mwc/3YnzWk0mxxmCfgpbsKaqE2gXBr7CsKykmpUBQ0hzXZj5qtsAuBNzx0lj94L/lzzvO1JO/y3gWARQdEqBtGlKuhOXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wn8Qrdg4; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wn8Qrdg4"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ad4d639db3so3491775ad.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 05:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776430186; x=1777034986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTYsnC56M7LWSyOgDZjUbBdF1x0N0VfNXskukjfHF8Q=;
        b=Wn8Qrdg48QnteyAVVtQ/FPNM5D26qdTA0QjjZK+rm0i50wseqxdTizSJ3KF6ujQ0P/
         /4WPFKEaM/RFLUG/EKR3B+X6KM48CkOB1ikRqcoQXlii00BUGrpHcjHkYglmbGLHggw9
         docsmfatezXn/feYRAkxzdFu9j6Ukkvm9SmgJGwR7ViQCmof+x5chrpZ0niv/W3uss2v
         UMXMGMycyGvBmy1+6ZbZ2Pemlj9QAurgjF2ZnKjx97x/EqtE++LjS5fig4n8nI1wdAhT
         7nC826m1MmiS/inaaSnGp2a0iSrBrzZZDaFcAgPTmqJxxBB2F66dP0GZuYLain4vWPP0
         hVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776430186; x=1777034986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zTYsnC56M7LWSyOgDZjUbBdF1x0N0VfNXskukjfHF8Q=;
        b=D6AZv/Ktthq+Ij8g+b1+DUj3bO4ufvyHzDjJKj/mcOj9nbvgZQkXM0PiyrRUewOV6U
         q9SlUuw9HtC7vElxryM7Uth4GilkvHCO/Ov/dmqc7vWAtPp56wN6Ow84MAVdMu5Fb0YR
         MmKKyW0tyeUk1IxWZf5Fsnn9Wgeqhs3SbTkUOhLRFC+fvbFPsxyiXHMN60kmSaRjLeZn
         MM2jtikT8xjbfin7DGA7BT88kKrl4FC4IbMqL3w52HmXOERmIH2KBbCglrVjknTyBfa/
         b514EM9+R4dUGZcxi2TzkKS9q4n5YD8XyMnvZ0y6FX84TrZrar2wlYT/Sc7gS7TIPd2w
         GN8w==
X-Forwarded-Encrypted: i=1; AFNElJ8sm8oB99gWW66/d8tDOFcBdb1x3KwB/aZFRlyj55UC5CunQ2dJKnxFM+smj2rNzh3cpxTIds48Hpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9o/NZ8xFq1u06kVRJ9xMzfRUren3GZjwxbzYKJbtir3Ps34vA
	t9M72gI5CTe/gYCjf+8rg0ZoW1M8uMbg1+a5458NCba4iLMkvVLP48CO
X-Gm-Gg: AeBDieti6zSYobaf5ubFfDIu0HYta/iMFD7n/oMAJs42LFklGI/oZMiN7KzoDitkbb9
	OcIatHIHLZ5RTD2Xlqwwv6/klp+vgE/cA1+r0nfSoUBA8xKSfDSJWycurqzRsV59573T+BHpxyg
	q42wXYYet9l7FCq1mG+5DrUYeYukLzmRCb6Hvu0xdV6ihWA2N3HfPQ7reneMH6WtTLFQNtpvHFL
	bk+LmYFUOd5SuXcNE3ZQFFsETtz8XTIHaYkRQ91p2lYuZ0h8PJdPT2iXpOf+Krj8B2bTZhgjx1v
	uiR4mcu3YsHjketSZ04ivS6hZyZQoy9uFEuS6GTnV6DQe2IPbxHjriOSQNQACYuK5PidSyJZLrT
	W/4o9pIx52PlEwGcmL7ls6RNSCeVHICvx4L+tXGRqLnVIvyzSMasqpqg8PBd7J6L5u3FoHX93F1
	Hm+Vfx5Qu7yc24lRSLfrr92fciOvCXJ2K+o4Loydct04QLkG9go36CWC8qoA84JbnUo4fOVA==
X-Received: by 2002:a17:902:74c2:b0:2b0:6d33:e7c0 with SMTP id d9443c01a7336-2b5f9ecaea6mr22170285ad.1.1776430186117;
        Fri, 17 Apr 2026 05:49:46 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cb92sm19428855ad.50.2026.04.17.05.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 05:49:45 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	puranjay@kernel.org,
	cosmin.tanislav@analog.com,
	marcelo.schmitt@analog.com,
	antoniu.miclaus@analog.com,
	ramona.gradinariu@analog.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] iio: accel: adxl380: Use devm-managed mutex initialization
Date: Fri, 17 Apr 2026 18:19:19 +0530
Message-Id: <20260417124924.353189-4-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417124924.353189-1-sanjayembedded@gmail.com>
References: <20260417124924.353189-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Use devm_mutex_init() to tie the mutex lifetime to the device and
improve debugging when CONFIG_DEBUG_MUTEXES is enabled.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/adxl380.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index e7bb32fbc475..7dca5523091f 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -1967,7 +1967,9 @@ int adxl380_probe(struct device *dev, struct regmap *regmap,
 	st->chip_info = chip_info;
 	st->odr = ADXL380_ODR_DSM;
 
-	mutex_init(&st->lock);
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
 
 	indio_dev->channels = adxl380_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl380_channels);
-- 
2.34.1

