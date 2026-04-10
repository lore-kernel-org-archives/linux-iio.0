Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075F036D9EC
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775849869; cv=none; b=Q6FqK/vEAxtMYiU3GP0QBbt8EF71qO94DAp7OWG1/Hwbe/qctUvULz2qFsyYw6IYcdEYqcYxzMZKHVMal3JJayBBuNOY24990WuRqKj0nOIXuvo1A7FmtxZDxIsWRKfUGivtDb9mrbxF+Fg5rxFAedCKZxVK+RqtKMXxWMegy6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775849869; c=relaxed/simple;
	bh=Sk5uJThbctTNJzRrItA1Vwwv5l8iLfmstVpvpWhYbSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGEABDIbMOcNbggU4YG+SwZ7LmiibD8fRvCE+qForT9EckKb3FZYLesrISmoim8DtC6o6TYeRfAc8mudDLttvP3WQ2em4fHSi1u5ABRjbtqI12rGIbeRSzBtJd1gmnXYIiF1JtZw7z6nc0q1Yd+L60lOrqOq28nCdUKym/AcYKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9wLy0WV; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9wLy0WV"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43b949bf4easo1476522f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 12:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775849866; x=1776454666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzOwvKvv3Hd2Go+LjEAGjiSaoWQ+l/GJDY67S5SfPKc=;
        b=A9wLy0WVSkhEvQOTzGhXBnD5DDVMaAW3+73JC8hHNMnput10KSyKapD+LDqsfEb6vv
         C/8Hh59XqURyDFVnJM1EnZp8ceo1eroFm1EI/2TEbsWUtiPV6HWhozCgtZJazwyLoKQp
         i4bc0Tv7/ZVbWGfff63iIa+pRqUOUF4m3MljQwmozRgwBGcOeuAH7CN0FsxDMytzi1fr
         KlTtR/StQSns0hnRyoS/71EEfDYBBa4mr7QiLyfkyXsm7HWAxbd84bgAKyldFkj4ygdu
         Zb7D4mPPiZ3UVGlFnKOvBUZ+iBsxs7y2daFFOgbaSzip6Y5pu3YalVp1/QwIdEdn/UXc
         Xl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775849866; x=1776454666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uzOwvKvv3Hd2Go+LjEAGjiSaoWQ+l/GJDY67S5SfPKc=;
        b=sW/XSqamYcZznm5XVLqI3auNeVorfHlSqmxnxXhpKWyfwPAmOyzOjBfxpOXiFPYlwt
         fCGoNLR/DVtRd+ExJQb0UmRRTccjRM9I+zkzpijJql7Wnhwt7wOaQBPnqMRkrhgs0hwC
         EdRu9fGbdpsGrqNJJ8S2vxQXdNasJA/IYkNNuJMyjaW6zdnuflTSSmoUpG3Y9V/iL99t
         JWnzHAqLfxqNxTEDwCv2HIxWD34Co4Do/m3q80cKpMr0ZYkWhFGqEsdnr486CW9Z9fKc
         qPfcHqUJl6AnXoFdhYqIB1d6V27NaW2KLH2ZMAr3RmSQZHI+08vrwZzmNUHqxP33N5ja
         mzSg==
X-Forwarded-Encrypted: i=1; AJvYcCUOwm8TFu1tA2KuwDdtc7lWKc9eUmH/N5V/Ex+nGmmBUOKRgElJvepRxD8KuI6O3jST8r6CKj1R3vE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMGzxCd7u5xwKWHGkC1VQZDZ1A2Rhr0LH+eC6G+472+VeSLD1+
	xgzEaMvM6B1vZuq5l5EwwkU81tXpPI2OZs5+9pe5FTKcVnfHAYsqRcZC
X-Gm-Gg: AeBDiesaWugrd0mXIHF6N4WZvzLe6xPm0JR4NABCAqGsHpGQd+wDYugudhEYVX9oNBT
	MgqXt6j9lKv668/b+/DpmeEUmYEGVZ9ewY8Fs++qJMgdIoazIZeQyinvy7eIzx+kDDwnGZfMTLc
	Serum7xojUsDeWUkx/WE4qzdJG1Boq/oKaJbOH+jceq7Lo1X2wamPffN2X/kq6IgVQe7ekMm6lZ
	+PKie2Y6iDQXXGAIazIc9hHHXwUXaerJteX0qFhfNEmnCJ1Q5Ekh4eUNPHq8yzR+ZG8H9s46/3b
	B86IJRJY8kzY540gDLj0O5WiS22EfYBRCor603rM+uc24E+WrZXxAZXrV1sA201nJ907sOMZeJB
	mSTIwai3W+KBZ7cJ2hU53jekq9ZerIvq1VcTWbij598IZ8Y+Zc8wa8jzZh39UDlV1BOlck/vUqQ
	oJ++yL9nt60mdb6tir/8zN3copGZHy69ou/Kv+EaXX3C3g4HVPzgrjWDQMgm0RWDWxQFLNC3lY8
	ejqQczf0qajPpWfPlNbBOg=
X-Received: by 2002:a05:6000:2287:b0:43c:f257:c706 with SMTP id ffacd0b85a97d-43d649800d5mr6892009f8f.23.1775849866302;
        Fri, 10 Apr 2026 12:37:46 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50044sm9690425f8f.25.2026.04.10.12.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 12:37:45 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH 3/7] iio: dac: ad5758: Use devm_mutex_init()
Date: Fri, 10 Apr 2026 20:37:33 +0100
Message-ID: <20260410193737.35905-4-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410193737.35905-1-devnexen@gmail.com>
References: <20260410193737.35905-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_mutex_init() which is helpful with CONFIG_DEBUG_MUTEXES.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/iio/dac/ad5758.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
index 4ed4fda76ea9..8e6fb46cce4d 100644
--- a/drivers/iio/dac/ad5758.c
+++ b/drivers/iio/dac/ad5758.c
@@ -851,7 +851,9 @@ static int ad5758_probe(struct spi_device *spi)
 
 	st->spi = spi;
 
-	mutex_init(&st->lock);
+	ret = devm_mutex_init(&spi->dev, &st->lock);
+	if (ret)
+		return ret;
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad5758_info;
-- 
2.53.0

