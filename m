Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72049446BE0
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 19:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576368; cv=none; b=KR21AQFdeIPs7J6kXlLdf6R/Hi6ns8OfLp5thTWUBuegtuanvs4oPvFPTu5Wp0uBGdMKmNrBpgkkCTy/r6eyEeHALDzF7agvRM1MsJJ/Nd3j1B2njF9q+pad1bUuD2zE9zCYvifkW26aAXcuHE9kzXMhVRbkz59CTt9NJNSjjdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576368; c=relaxed/simple;
	bh=BIgF/MBWBkH+YrQaMxoT9KyYaoF+iLuNvKx4PL9FFaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f6albZM7LA3eH7ehDH5ozokMgo4jwSq61QwBYBqG80667KmEtEo23voRkJhh30CX90bdJWta3AjPv5lrdQW9cAZhy24ZUndSwJ1nEINZbTfBB4nVBxmAEn1lhZITyXKKq0HW7LldcYyduyETv37D9xuBvo7xsmOrUdRwOy/ABCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jhgh+rt3; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jhgh+rt3"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ca97d139d8dso4290955a12.2
        for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 12:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784576367; x=1785181167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G26pkiVGOQfvjhUhovAmEpMH2UgTqMGfpTU7jPDu8MQ=;
        b=Jhgh+rt3fxUkm4lKjwsoGfrDI/6qQ/27QJgL7mU6LLOFoiwOWzx4YQviwwlmV9hCQz
         m787Eg9X7GgCi6DlPYNNicHaBZnp3aXuqXguURISm8t2xnqSuyCIVOCmUDiHqsW2W02r
         bIi2ac93bj4l6xEAmcoZyZi5Z2ugZ7W/V7+UjyaST8Qqyc09cQXnDCeCFf+Nb9nHGwJ8
         F3HFM3jwd5wtdA1GDmr1oqF59C4tsUN2iuBuU59A0D/ASjuBecTZM+2bx14g+h+PC3Vu
         5SqUcaAkEJTxTYBlpQlWBFkTQ32N1JBaVJppht6aC6tpNa2C8qyYUuc4U8nAfFEod0Co
         4Sfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576367; x=1785181167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G26pkiVGOQfvjhUhovAmEpMH2UgTqMGfpTU7jPDu8MQ=;
        b=qV7/EOhWg+XnGSL68kv0WVdyE8mfancbP1UULc6G0Rwmb3ak6rG26Zg3XuOSfVWuFq
         nL5M7L/FmvuTPEWlHjdThSg9IeT9ggl8Qzk1n5eXYxkrJl/7WV6w2so26Zi1JxuMh9f6
         N0CMM4Dh27Pr6jDmgUwi57RwDC/FTUVSpN+rWA7dsS9IR9KxtlHA2KMSblasCg35jSi9
         5ldq7NYy/ymQ+ZHuiAOKm7xtQD/LZ50B/3Vcst/oNrtc2ZbuSee1PgQEINl53/PDPGsX
         GhE4CEetuv/j5eVFnrTrSDjrPuok0zYyUGns43PweHHrcXnrxwxYnGkcBbjR26nFwW3Y
         yWTA==
X-Forwarded-Encrypted: i=1; AHgh+Rp1/NUeONt30KPbeSPOlvgBOPUY3Z8psrXnPSk9jwqH6oMIveVHeNDzJv23NoaVgv5hxP1Tj6xkOFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3vQYI+EojktDlA442AhBdK5RMpNf/eEjpERMykQUmraxb2UrB
	L5TrhY+4x7zz8teF+Qy3fseFWzdNqxqHFWK61pnRZgJuVJZPMFW9sWM=
X-Gm-Gg: AfdE7cm3lCBkpDVsaQI/5CjG/6URvc9QYclrjrP7s2Ix1UomKmw180O8Ppf7AUFdwv2
	GNhTurwAP+Gv9/9g/0ZfGjzHmIWaZEU4yvFNDzeacrgjD58HhFWY7+7VoJXTe/9hsdGolQhhA+b
	4u6YKWZcJn8wgMaNJqR8u04JXhZWu6eP1Geq5XFxeq+m9CJ4xlvbl4ncB0KU5ci0HbzbkrI2X9U
	nqkZ5qUV8omGHw8HNk4D9H7ODvDfLi4jBOAdoVvWy/PGS/4jsMhDTUVMRZv6ptFg/OTRs/ozZOA
	wPkUeRz8hXVAijUzhvOHo+PgXAhLfsmz7Lg408gp9jGxrS/0ptANHe7CNV25NcKPTDnTEl/Fo1/
	gK6oziEWjzfSPdqaKYaGgObD/pUPoT/1pgfrOQ3wsxFCEA3PgnhvXD2cgrKPBfSUDdSxiBIVGMI
	cEVjiXEIFtsOKF2PQLWN6gTatMgDQALT5wXnyRzCTH
X-Received: by 2002:a05:6300:95:b0:3bf:e2f1:1b08 with SMTP id adf61e73a8af0-3c3ad9717d4mr16450850637.40.1784576366686;
        Mon, 20 Jul 2026 12:39:26 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce29ffb13sm33935340c88.6.2026.07.20.12.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:39:26 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v1 2/3] iio: light: gp2ap002: re-enable irq if runtime suspend fails
Date: Tue, 21 Jul 2026 01:09:10 +0530
Message-Id: <20260720193911.74919-3-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720193911.74919-1-nikhilgtr@gmail.com>
References: <20260720193911.74919-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gp2ap002_runtime_suspend() disables the irq before writing OPMOD. If
the write fails, the callback returns an error with the irq still
disabled while the PM core marks the device active again.

re-enable the irq before returning the error so the irq state matches
the active state the PM core restores.

Fixes: 97d642e23037c ("iio: light: Add a driver for Sharp GP2AP002x00F")

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/light/gp2ap002.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index ea971fec0b56..96dab4d1d8ac 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -650,6 +650,7 @@ static int gp2ap002_runtime_suspend(struct device *dev)
 	/* Disable chip and IRQ, everything off */
 	ret = regmap_write(gp2ap002->map, GP2AP002_OPMOD, 0x00);
 	if (ret) {
+		enable_irq(gp2ap002->irq);
 		dev_err(gp2ap002->dev, "error setting up operation mode\n");
 		return ret;
 	}
-- 
2.39.5

