Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2D13A3E68
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507747; cv=none; b=LUyN85k4nDurBuoMKtCFap63oiwu8jlG2GDzBBORKCyKZf7UAjiPIqiX8P3z4ChvbLKsyQ1jXzWabg4AHCExMy0WMSwdksrSkNg0taf2fbbRKTs8GuL+hPzEDqbP6CYnCEkzPLeAP/Cwew9OMvQN+wGnyXNGCb2NZQ9gv/dBWu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507747; c=relaxed/simple;
	bh=UfXzx5BgEiFmY8xtUYGsQMzJjKu+5JtClaz1wjBQ504=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SprpHdpxFfafRFn33+SjO5Js3h+qwliGVSwKutGhZtEK+2jwnXFxqp3U1ZVl2qmZzoNY4EpsQV3iU9VbXDH/IGDCKGtQBEWsfZnpvZD3Kmi9LuMx4iDf+sl5vGXtsTnbo/3AyDvWyeCDe8QCysz1AryN2tUP2BX8QiISnqWnaEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2/eOiYI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2/eOiYI"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891cd5927dso4188235e9.0
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 06:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778507745; x=1779112545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgAxNlMr/HpF+J2fm2SfA2hsTJzgeAIWyP4P54Eph0E=;
        b=S2/eOiYIc3VyoE5JFkem6mAGPlYJvcAlOHc6O3NS6LgfGmPUqB8cIDknxAXSFIemi3
         /nr5OpgOh/RLKtMmLGnMUR/0v5VGOkEA8lJf+eB0PW6T4DljiKCGc22/qptZ+1kBEAte
         +dZlldBQHAzoS6lNi9UJhq45R8XqZSP0oighbES2Wov7TOKz95EHRPdBvShoe17y4m8/
         n/Fsqr4iLODJsEnAUluxxaRiTbA9yuMnaAf2F5xyn5E6cUHttD+zXFiEkKBA1ZLdYSDm
         AMcq9bfcPaxqheJ3R19TgB2KPENd5RGTdxlzwgSJV2W1cxfcN77zfNPrj45VAhJVUdMs
         f3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778507745; x=1779112545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GgAxNlMr/HpF+J2fm2SfA2hsTJzgeAIWyP4P54Eph0E=;
        b=E+CtIIZIOlf41dAcS6SOjhm4TVBftMY1DRWWzHKefojOlQm7fpd+xejjDUq2lDPrsp
         mX8YD/+PGuUgExTCptKQNRt047NsN+IO7/CG3/fIPAflQlbqg+obSuQKg+D8aST9cSpG
         qqa7PAnRzrwlXDEKQskvwZJo++J6mygCSAjyY+9qlsY5V1hw1cJ346agi7iAQbOHFTDZ
         i+0rxHBQ9NaEIosXH9e7QZctn6X13vfjACRRgzFOEt6/81HU4AU9x2wpeeK69ZGD2X98
         v6AHnTmQPu3R7O7FMDuZR9o7tKbsJ8ujof7c+9I/CyyYxO5mMKkAaBvZFinr3bZAMXie
         +Q5g==
X-Forwarded-Encrypted: i=1; AFNElJ8Gq93/Vuy9ML61B7Tc1n9+NQLr5iet+sgXFqVS5W0DV3I/35d4niNsmiSHeFurslGbtMDa/RZOTys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWJ+r3im1WrCCtZvsmg2N+A44YUv3iu5eonszbCHhe1QaShdxG
	oLt3O/+9JqsUq7jV9ZmTOGxAgzqSFX6KS8O4p8imgXqE1NiHhtWKrUuv
X-Gm-Gg: Acq92OGG3JBYugPQ9CkgwBcqXougYbFuxoPCXB91Fj3y/w1ilwb9VisW3rvitiL3mJp
	h0WApGDRkHgOY9if5tPiZhMy4RxOI2gpxyIqnepOvOzpeOhclphDlFVB2nv4sHlslGrruaJqAxa
	He9Yn2lYA7Uhc1s6MpFPmI5vlSS2+5XV3c684eaIouXVXlWIu2Hdn3DMjCsTFqHwjKpkMmRYj04
	n1bIRPp3R/unIj4j/wfdSZWRogqGQ/GTOuMMILaMzJ4exCiMzQeUSZGiUqO3tBJX9GuwABCyqZ1
	p7EP2yve5AXOgebmKbYqmYH8rKq7U6Z5ZGOOBI6WZ626x0rRkJseD2ETeDWH7tHIO8XvkXWygGH
	FgtNhR29myXSRcpDf35UEtsC/hmjjSshgQPD1pwpTLFhzerKcrPSsl/s76mzHY4H3t3xV14TixM
	rfBXk+vikKKnkV0NzQhIFg24Ttld/aNZr63lD6xAl6ZqdJ
X-Received: by 2002:a05:600c:3046:b0:488:a2ac:a338 with SMTP id 5b1f17b1804b1-48e51f4a1d4mr114506625e9.5.1778507744872;
        Mon, 11 May 2026 06:55:44 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d8d30dbsm102474235e9.1.2026.05.11.06.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:55:44 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	hcazarim@yahoo.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH v2] iio: gyro: bmg160: wait full startup time after mode change at probe
Date: Mon, 11 May 2026 11:40:20 +0500
Message-Id: <20260511064020.362-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260511062755.30-1-sozdayvek@gmail.com>
References: <20260511062755.30-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bmg160_chip_init() calls bmg160_set_mode(BMG160_MODE_NORMAL) and
then waits only 500-1000 us. Per the BMG160 datasheet
(BST-BMG160-DS000-07 Rev. 1.0, May 2013), the start-up and wake-up
times (tsu, twusm) are 30 ms.

The same file already waits BMG160_MAX_STARTUP_TIME_MS (80 ms)
in bmg160_runtime_resume() after the same set_mode(NORMAL)
operation. The 500 us value at probe was likely a unit mix-up;
the old comment said "500 ms" while the code used microseconds.

Reuse the same constant via msleep() and add a code comment
explaining the datasheet basis for the wait. Without this,
register writes that follow the mode change can hit the chip
before it is ready.

Fixes: 22b46c45fb9b ("iio:gyro:bmg160 Gyro Sensor driver")
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
v2:
- Use msleep() instead of msleep_interruptible() so the wait is not
  cut short by signals during probe (per Andy)
- Add a code comment with the datasheet basis for the 80 ms wait
  (per Andy)

 drivers/iio/gyro/bmg160_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 38394b5f3..6d9019451 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -258,8 +258,14 @@ static int bmg160_chip_init(struct bmg160_data *data)
 	if (ret < 0)
 		return ret;
 
-	/* Wait upto 500 ms to be ready after changing mode */
-	usleep_range(500, 1000);
+	/*
+	 * Wait for the chip to be ready after switching to normal mode.
+	 * The BMG160 datasheet (BST-BMG160-DS000-07 Rev. 1.0, May 2013)
+	 * specifies a start-up / wake-up time (tsu, twusm) of 30 ms; use
+	 * BMG160_MAX_STARTUP_TIME_MS (80 ms) as a safety margin, matching
+	 * what bmg160_runtime_resume() already does.
+	 */
+	msleep(BMG160_MAX_STARTUP_TIME_MS);
 
 	/* Set Bandwidth */
 	ret = bmg160_set_bw(data, BMG160_DEF_BW);
-- 
2.43.0

