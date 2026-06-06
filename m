Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A574A30E84F
	for <linux-iio@vger.kernel.org>; Sat,  6 Jun 2026 04:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780721918; cv=none; b=cY9bhwGBj5IesIuvbTLjhSMSTrWurAhz0ayLNmb2OY68LMzoeOjeCIHJeoujD9II4Yvdi2a1FfOvyLW75S1dt5cVtEndBWB3nsYDlIzRni6PkIzG0UXxt28B4Khx7uByXP6nGQ8npIcfc0LyRxkbB6OzwckDxJOKSefDHL9EtGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780721918; c=relaxed/simple;
	bh=Uj/we1VRlh8Apf/xbTm9Cclx4UJKJna7Lcylt5N9akk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVSIbMdSwLKxmY+rRyQFBIvqxJqg3fxrSu2cze63Up4D7e+9zY10Zp3gBQ7uFA6oXTyl+4gJH25ajNfwDgFLYqyIn/9qtvyqTNUmr9LZmyEK6QYPKdlY1MmYQCT8oBh798xpB677GqFKQyLbReN+C26E3AclZ3viaORzSG/GUpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/unh+1k; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/unh+1k"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69155ca09d8so478061a12.3
        for <linux-iio@vger.kernel.org>; Fri, 05 Jun 2026 21:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780721915; x=1781326715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRUfH60NeaMpCaCx84KeDTGgGO9ytSJVg0ZaUrTfvB4=;
        b=A/unh+1kjipGI8XGzFvTj3U7czU7f66fZb60gWItRppp86TQsnJc+ZhnwwWkEztngk
         ZXZdFKYNLTDYIFhMAFv4yK80g28YjCSYosSXktQqcM1Xbvw2X13FKQbo8kgMlLNOZBkQ
         sfBU9e/miezAaRfQ2dXRIlGPPCB/hlsxZurDJx0phhXKefFiALFQFJ8cWwCLPlV7Jx0l
         pVbxBKCYwhIvUQ80WgzxZ78SY60O6A9sHgIXpvtbK+FXiyaRiJc5K41Oqxhttp6Lajhl
         urzHYMnon6ajDNumWML8ydBCUy1XktRrDxurAkQ1FYfPQtIWEa9x71i1AhNSPFdoEIKK
         SHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780721915; x=1781326715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gRUfH60NeaMpCaCx84KeDTGgGO9ytSJVg0ZaUrTfvB4=;
        b=JT4vi7sT+zAf6y+0aROHTEMJWWEpVFT3BRPSgvy86ReCudNgLAN3UWm4nSGmMityOc
         A4mm6Uqs9WxUTQSedNDtnB0wK8jsd/KDgIw87fdDCipnP/tilTrufLWaSZJxsnx4jk/e
         fyk34YNoud//gYzfx3aOzpbgLoG4fAFOO5bpeedMkBNQKoDEpt0feWWhEAQbKgZ6q9jK
         2AEM1qCQQsbJDJ4kj7SNXLZGDEhPUvL9mV2l6P3/mepba+p/uyK7WzAQpM5H0soQg5Nl
         1a8EDvM3/Ksy1cS9N0siY23G9EXK7Ln94jLtvxsrSxZj02DOF3y9U73/j4mntFWsGdGw
         0+ew==
X-Forwarded-Encrypted: i=1; AFNElJ+94AdbXZHtMpW/HWG2miDvpIYY+Fs77jDavRHz+rzPdLudC2h6qSwVmAuFbOu42adVMSwojM0nYRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLoabARjMz4KOHM0J10NjsAsevhNukaRNyGGoYhS74HtGbz8Rk
	Egs4+rMEIrxHnlPqNS0lkbgBpDZ/uYJMd2rYKmR5gVBnzglHgy4xgWNp
X-Gm-Gg: Acq92OHnjmO4LzOev0hsMhVpQxcYbeBchkIHk4LpqLNVfKY8ALKrMOUi0feZoULMqOE
	gjOgJQmX1g8TlsLyWChEEbAt6+1gx89zXlmdBo/54uDYE5hqVn8fvHQC1G6pBGq7/r9hDZuLX61
	a2LVLXIIokzFsilYrIKOUM7STv2JpzddCoWigBfQDJAf+Ov+OthmjEdI6VMWyV7233xo7iDmcGf
	h73R8fLiEGr1S+gRoUfnM9VIVJvACNhOBFJh+CycsaZcxJjSwc46ZGlvC/EZrXB01VqTotlrWRb
	SZmAdtxnSdi0tHU1vtrTVg+wP9TbnTEL8ZmyfP+s849gJGGQCukL6QKi1G2UEV36NsDagMLFE2O
	HotjL5I5IESYeM7LAM/uNQ2CA/JYbc2ml2WoSmnZ8Ig/baYn1wH7QaOFAT7KREvl12pPn/XmDhr
	RXVgGUHt8YqTodGqekNT5N7Ik=
X-Received: by 2002:a17:907:e117:b0:bed:62c1:ec with SMTP id a640c23a62f3a-bf3704783c0mr169855366b.13.1780721915036;
        Fri, 05 Jun 2026 21:58:35 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 21:58:33 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v4 10/14] mfd: lm3533: Set DMA mask
Date: Sat,  6 Jun 2026 07:57:34 +0300
Message-ID: <20260606045738.21050-11-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606045738.21050-1-clamor95@gmail.com>
References: <20260606045738.21050-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Missing coherent_dma_mask assigning triggers the following warning in
dmesg:

[    3.287872] platform lm3533-backlight.0: DMA mask not set

Since this warning might be elevated to an error in the future, set
coherent_dma_mask to zero because both the core and cells do not utilize
DMA.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 500cec3cceba..5d17da1d998b 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -489,6 +489,10 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
 				   LM3533_BOOST_FREQ_MAX);
 	lm3533->boost_freq = lm3533->boost_freq / (500 * KILO) - 1;
 
+	/* LM3533 and child devices do not use DMA */
+	i2c->dev.coherent_dma_mask = 0;
+	i2c->dev.dma_mask = &i2c->dev.coherent_dma_mask;
+
 	return lm3533_device_init(lm3533);
 }
 
-- 
2.53.0

