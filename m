Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA96737AA78
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 08:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777280116; cv=none; b=FrzYb8esgtLlfL+sPUxpQX13fD7TAs2K16t7/yEggkgYiXzYfPMGYbJJu8dEegRHijhj4rNAhL0wTkOiOsM+nVWdXC2XhDvRDb/+x3HOCdXb6D3eothEry0vw0dkyHlpk7RUtI2WnkQ1cULM/Iy5QytvkJsYsEug8HmIibpiz4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777280116; c=relaxed/simple;
	bh=ex/wBQ/ihuU0frMIpPPFc+k2MJG4Ygkspi/FZ5Lqphk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bvvSQWgzGH1JBI/H7hiQ7oN9ARYjGOF9qwd4TKJXUkQDLxhzKKrdbSbuj+cNGmyFM6BwXTVKFf4ShtTkpch17rDNrUvEojEJ930LBFvA/H8nM/oDYlZb98yxC5Mk4dQKis1Q3wewfF5fcFc8344b4PvJOHsf7J+eoCU/YJsWbCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdVr9G3A; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdVr9G3A"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso83015615e9.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 01:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777280111; x=1777884911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g+pkBk61K0bONezvT3hKFR4CsnavUHfQ0OwvNOKj+rk=;
        b=DdVr9G3AymhXnxKOZlcJH0uW/U9t8wcJcB2Q9gBKLj9agQUq9fJNk9G8r2l2KrIzj/
         2s0N4+qW/R1D6m38Bk4ED0z1xV400Cb7/HHRHED21Ax8zFNjjC0y1CRZ853EowaFIUXy
         BFR3gQKDrqwUfAXFZRSEcO+Fvx/bS321ZR0AXSUk0DuQrLjJgS24kxOMaalXrDhlZva4
         rXvKNkRBgH7MkV9uAU624mgk8l1mr+TUsrSwRKQpk2h/RtL5t8q/pOT7DL3TcFRNypwE
         MQkCbvWlLByfLRkcoS2KGdlFTqDUGjf7iDhFv9v1Pm2REVToX6EO8Z1oZ9yg5i+4AA6E
         xFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777280111; x=1777884911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+pkBk61K0bONezvT3hKFR4CsnavUHfQ0OwvNOKj+rk=;
        b=dGJh6TGKlnC0zhG0/4aepsJRd/R0enD90nqIZuhfx9niv2pw7VOeqBVC1rzy5BDLig
         2Un3L7+ld/+MamptMfMVG/IDXhS69vCpSoWh0svbgwC82AEIH45+UIcSY0bwR5MtwguZ
         3lS32ON0Ojxb8F33J4h2sIjhWundnWX/24yJfZuuKHszq+9UmgeXvNwGtwynoO3LMuLH
         bjSVm6T8PVlfDbDAQoaWiFCijd3SWevSV1wGS0WHEDDU92J1FLZR0BjzWc0a71xKWs4p
         yA3AT2zZoOVdHr9IWhzQZMRvXSe2vuPi06GNwf7aTApGwA7cyzChA50YqaQnlPsOnnvK
         h+Rg==
X-Gm-Message-State: AOJu0Yxm+PKk5yneiekQR+7OgGfgsIVhyaKSHFipdnE6AIXzyXJn78GF
	M5v8LkPOHx9VEWXBvqPTKppT2xHu9XBdWXXF7hCiJpz77/COJG/TXceV
X-Gm-Gg: AeBDievzQxXtQgqqBrf2kSbYq+Ti56ort/GclnShOGE5q8mqKwqQxKJvs4j7w+JZ4Z9
	hhowfqJlsAx2TATtMuw5gKqrTbztQFDgBrQv9i/33oexSLeMHvVfszSl0ClGexvQ3K8EzuSTTGy
	dO8inQmpD2PGpIUKGbAUzsdamYHFpxxR81ozV2ZYfeaahcj35vq+gYpyxe52EEl8mE2wWGyhHv/
	UZHv2jzoNlxUIxswFHOboRkuJ0w/44KvuxToLHgNP+6k5pTgNK6ziys+ReQcvSUfJhZN7/p29F/
	AX8brMYx40R5LWznSX/XtH7m8ut3fwvNyAxGoYJ2rjORbcVg0/Kiz34pzrixP2ROlBVpOe5nwbw
	XNE4q+bBJoS6joNCPetTzjTssCmRDtW2+v+pUOjSve4Lo1avEaVjnXGH4L+vkP5Q37UKjRvv3E2
	2XaPrti6jAFsgKgMxZ5lOmcTfXdUjQ0N70AZUmIWFnAn6HqSSiwmqSXyze2f4=
X-Received: by 2002:a05:600c:4a15:b0:489:1aed:1658 with SMTP id 5b1f17b1804b1-4891aed16d8mr269026355e9.23.1777280111056;
        Mon, 27 Apr 2026 01:55:11 -0700 (PDT)
Received: from localhost.localdomain ([196.235.152.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d5b1sm82248879f8f.30.2026.04.27.01.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 01:55:10 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] iio: adc: mt6359: fix unchecked return value in mt6358_read_imp
Date: Mon, 27 Apr 2026 09:54:57 +0100
Message-ID: <20260427085458.38546-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mt6358_read_imp(), the return value of regmap_read() is currently
ignored. This is problematic because if the bus read fails the variable
val_v remains uninitialized.

The function subsequently assigns this uninitialized stack value to
*vbat, leading to incorrect measurement results being reported to
the IIO subsystem without any error indication.

Update the function to check the return value of regmap_read(). Ensure
that mt6358_stop_imp_conv() is still called to clean up the hardware
state before returning the error code.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/iio/adc/mt6359-auxadc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
index 6b9ed9b1fde2..f927bff4a26a 100644
--- a/drivers/iio/adc/mt6359-auxadc.c
+++ b/drivers/iio/adc/mt6359-auxadc.c
@@ -497,10 +497,13 @@ static int mt6358_read_imp(struct mt6359_auxadc *adc_dev,
 		return ret;
 
 	/* Read the params before stopping */
-	regmap_read(regmap, reg_adc0 + (cinfo->imp_adc_num << 1), &val_v);
+	ret = regmap_read(regmap, reg_adc0 + (cinfo->imp_adc_num << 1), &val_v);
 
 	mt6358_stop_imp_conv(adc_dev);
 
+	if (ret)
+		return ret;
+
 	if (vbat)
 		*vbat = val_v;
 	if (ibat)
-- 
2.43.0

