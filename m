Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5281736EA82
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775849873; cv=none; b=Y925fhQ6B0GfSDaFLaB+mJ+4+H5clYDnlPX6cBixURfas3GsXkTi1iVR1yVcacHHej1VeJFd+kNck8mTFpl9vsKbgus5UHJuxP15TbxYTDZrW/Oxjk8wq+t6oeGclDYKJ35uOMcH0z5u1kEBluZrL5z4+OCHN7DGkuWc4LT0cLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775849873; c=relaxed/simple;
	bh=6s9j8lFJVKaqFtemurG+Y2mbQCRSqgKPjbyIU1ouWOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbESadXxvViaRYbsjUTLP3exlC7L6l5xdEJ8m0OpkQ98RoVI8eZ1BhlU+aPfT6Rocij9Tp+YzPUHmQNTbon2ck59czpVZzOxt5PXNsq5uyk2661/s9Tf8jHHI6gj2lPN1oCyRz+A4LDyATPTSTyA06acmwugY3NFKAZn1Wzyg9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gckdfWKg; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gckdfWKg"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43b8982c2f4so1461250f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 12:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775849868; x=1776454668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPY+ZBbnQA+kudqzFJYrRG/OaRqNB3ArwF97VW+T+x0=;
        b=gckdfWKg71oNRP3vtZo2AoUmBYjIfWZ/bi7JXERuxsJ9vxkrFxmyrF8NPxxSLEL1H2
         m0OtHj94OGLWApn24YrnAkkFDC0kmR/HQjPziL5Y9XHEgP3+oO5++d0BjKUMwYKW9UZa
         pyh6LBoe4pFVgnXFd8pDef1XrOuh8nsp1V3whMT5MAP3NsDcMmHeVgs4uBcwTpEasKNv
         EaLTywSgvo0CvA1oibiQw+rDLwnhJXEz/eiNU+QplwPw5jpYtNGoqaKFSl/wqIMXAGrT
         NvCwsAlXTuCf5BaFr2MLyiH0LFNT1ZHXXGUXgFXQcLvdr8I7L9HD+IH1hPwjsLgssyF3
         7cUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775849868; x=1776454668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wPY+ZBbnQA+kudqzFJYrRG/OaRqNB3ArwF97VW+T+x0=;
        b=J+Kx3FZsLrZV/WaIz8/if7qls3JjzJe0GnuEn34T3d04Rsi1aAjxVQqiFSIIjMxljC
         c1tBr4FsLYXuksi1pXWYiATMS2G8SLNDp9GBIERjltcxKxVhx0ApMGCsUPpkdDiX0i4a
         IM39nvkAbQt8/An8dE7AZUOJ5TmSxT4/511WiCmo/R2hM6Fk5BA1r+9TUmdx9VimI+w8
         O7NC5dAsFim8Pvacnmre1WK7Ro/FwtFBDOwI/xya9x+q3pNSTHNa6WB+TPhScEEjlGdZ
         FBuyJIe9lrDOh4Mwg7Ur07iz/Kws0GUvEvSAb2LYI1dL+CZSosiODvcygCyJBw3MvXhT
         6+mA==
X-Forwarded-Encrypted: i=1; AJvYcCXh/8/993Hm9Cn3jO5653MG3l5twAOvKpAvDfAMBKdJw5GvpevUkrGDtblu8LZnm7Eu6c2eXe/DelU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYtQBqzZdOlOj2cafdBB1II+c8MDP6GRSjljbFIY6E5Did269G
	RZwRCSOm8JDWVkUlfbiezKUXougHZJX1R9sgJv1EJHhDk1gVdNv9TW0y
X-Gm-Gg: AeBDietvcqeCNBJ05bTcXP8dG87bAgYvIZsS5XCF50U0er1kLKKuQHepVQmn+A7JQor
	oeTogxDr/3+hJrvSF1POERWwle187hxKdvwFCmH/lLCo9wgVtO8/r2IOxIa8aeJq16JwupjBKiY
	CXegBapR/g8aFFrXzccgwtbtpcIhHDlnkzK1H2GqcUXiqaAEXBc57DsUtyfvVulCTuYVQ/Ukjv1
	IcPgWW82zEVJGswW6/2ZcIdFop25OCsOYWaYH+GRcado6jKOdYu+SKNtvAc9e0sodJhri3Yefwd
	WQXbMpCrUZ75b+7VxEyykG1mnqVN0DQ2Oflb+dvnx3bcyimh4bd4x3L3uxE3XuIZQsllbeUCa4p
	x7aiLIYJJZG2nU3M9+xl8daM1T4lGewdpCHs3GpYac/N3ECNDGVvJAwUW8WhGpZnC8bXtfQw/a9
	ucx0HLQGEvo7efBmJwZ9xqTwUf7gBgxRX5c7PojNaR7wjl6vprqWbuXyjqeNla4qbWqlW72Gws4
	2gUNCF3sCZY
X-Received: by 2002:a05:6000:2f86:b0:43b:87bf:89cc with SMTP id ffacd0b85a97d-43d642cb604mr6653298f8f.49.1775849867625;
        Fri, 10 Apr 2026 12:37:47 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50044sm9690425f8f.25.2026.04.10.12.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 12:37:47 -0700 (PDT)
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
Subject: [PATCH 4/7] iio: dac: ad5755: Use devm_mutex_init()
Date: Fri, 10 Apr 2026 20:37:34 +0100
Message-ID: <20260410193737.35905-5-devnexen@gmail.com>
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
 drivers/iio/dac/ad5755.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index d0e5f35462b1..cc6d56140d66 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -827,8 +827,9 @@ static int ad5755_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->num_channels = AD5755_NUM_CHANNELS;
 
-	mutex_init(&st->lock);
-
+	ret = devm_mutex_init(&spi->dev, &st->lock);
+	if (ret)
+		return ret;
 
 	pdata = ad5755_parse_fw(&spi->dev);
 	if (!pdata) {
-- 
2.53.0

