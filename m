Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90B539B49D
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776430206; cv=none; b=qIt7/4qYsEumZst1BQlDkoNiQsmkGlaFnArQrQCIgFWcKTezgSTfWtqjVLIluEii/TNx3QiwwWZG4KpsQ3mqIGeZpcmY6ze8rPX0gOuQBTvuv0tYkI1kPqaYCHZoTl+2GW0P2RZBVD7S2rWNEnifeYN8jLXJzyD4JA6LKvV5zMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776430206; c=relaxed/simple;
	bh=eZR5tp/JVNyN8jS3XqnnGvESQT8G/3eV0xYXffxiDdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fbXcC6UL8FpGj0FLO0cN2PCYtE1A56ev/9YCtTG2f8mpLTqKcqg1VpL4VLK/ydR6rb3coh35qHU+ylId+q4BaNV5Px4qpNCgH9+EUpejWpmxzwrxyD6+JpxNYQBJo6aq+Dqyp68PIvWrqTJld77Odd287h0fVzkbj0/XBc/+gls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwXno3R2; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwXno3R2"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36146ae9dd4so79490a91.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 05:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776430205; x=1777035005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/tHnp+bIyGjKlYK+3tXrqFm9DxnpPAtI6FJ4Q5u3nY=;
        b=WwXno3R2FkghZUg12QYmJ1H/niUVt6kxSAaJ9yisLglAH1kKMEJneZusAARe8VQk2X
         goGmBzw7yirU5lJJ0Aqs3t/knJV2YUxSUXlxCZUQKiohySBH7irevkIaPPtMPXrewL5K
         lOQInKHHHZVdI9HjCTkpIfJH9hW4D725bKkzvSpzIYQpI+7ySH8IHfCaKyFvT+1LE6e0
         +KzMklFmMFJkm8hk9dc1cAwRwBV7CcOHeOyvcj1+HHsGtu7w5x+NtRX8P7dCmsOzG1EL
         tVcEbraF8k7JgsuVE3eeYZFkQ72Iy8GgnJLQzE1gIvD0X3kxKLewsCo0d/jCsj520lTm
         Dp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776430205; x=1777035005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t/tHnp+bIyGjKlYK+3tXrqFm9DxnpPAtI6FJ4Q5u3nY=;
        b=jSqKsEzNZYW4zMEf9D7ozZjoHCpffIq0cZj8px8KoQ6HtUknFcu2VvkX4oCnnfkH6Y
         iEwwjv4l/TyAfZPe4F3cqngci2u66len2k0AS6hOka/VUM8Z37/zKdFUVQ4F82C1fsm6
         B53cDPpkCHnr5rSEr7QhMP8TiLAckeRK+J/HsdIr2YXnaH4Jg1FgNUWbi09gL55DJU2e
         PLuL/1MDLxQmKjARpbclFlg6ili3tM4dalTHDEdOgpO3fP/ntdvrp2pBYXxFPpCaFDp9
         jdFW95ID17CjEafOLtmZea4GGzlQMZSoSU/0oC76btaR2JFWffDFcfbK72cFfSpvvxjK
         S+Zw==
X-Forwarded-Encrypted: i=1; AFNElJ+jOyZB4vpoZaK/mdB8LtdOBWM0wBbVfpq0MfmIkyw7OzKO+SfFTMRVX27O2Qr+eynla//mZbAVVm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk7aRalDLLuu28H0PG+o344GQduXbs+DYS1/dHoxBb2reZkfw3
	7ozqVDFU7Y1bdAmhb1NtKrf5WF4DWo52fBExlR5zT2qexv5Jp6NRfpWI
X-Gm-Gg: AeBDiesg8ncZ2l3lpd05HCbCeNGTcox2sB2jTerOssCMayUhGnjcKz2tgQ6hn3i9ht5
	SiapRk81A5gkPNNJCGp7E20ZLuFNhErcJZDeZzfNRv6qIVUO0GOKYiljEZEJ9fvcN39+6fqwdro
	HB1Qq1vBxC9kmcLIaLbt03aZD6eh/3HKIF7pQ7RBXDILW0fzA2ZyW9h2MC5bSDrKjhCcLw9U+bU
	E/91KtpFoMONclhJJNb5CE+ExLeNDvS8VRHwPrdyxdISJLfve/9gOVWEGbSvK5+eyyo5koPRFMC
	faAeLYNBG6XenLsgDaTqA543JEGBVbsie3xFNbn39wVWq4SGxE67A93hMe+QzVTaP/dOjcHP4eo
	WiFGVMG0MgHDqfYVehEtKCMmpCmc5aq/dYRJTdYwCKZ+O7eac8sp2lGeeVJxEdfKDNTEQxlUbEG
	GGUItW+8Mg6YUhw5izt0VaWviAB2S3xNof3ImIXhjZbMWTu3u7jGC3UVYbP3c=
X-Received: by 2002:a17:90a:d446:b0:35c:1f29:712f with SMTP id 98e67ed59e1d1-3614049a328mr2711834a91.24.1776430205310;
        Fri, 17 Apr 2026 05:50:05 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cb92sm19428855ad.50.2026.04.17.05.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 05:50:04 -0700 (PDT)
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
Subject: [PATCH v2 7/8] iio: accel: adxl372: Use devm-managed mutex initialization
Date: Fri, 17 Apr 2026 18:19:23 +0530
Message-Id: <20260417124924.353189-8-sanjayembedded@gmail.com>
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
 drivers/iio/accel/adxl372.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 545a21e5a308..1a6ba94f54f4 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -1299,7 +1299,9 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
 	st->irq = irq;
 	st->chip_info = chip_info;
 
-	mutex_init(&st->threshold_m);
+	ret = devm_mutex_init(dev, &st->threshold_m);
+	if (ret < 0)
+		return ret;
 
 	indio_dev->channels = adxl372_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl372_channels);
-- 
2.34.1

