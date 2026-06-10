Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0B04968EC
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781123725; cv=none; b=tmIvdLKIosQI+e5fzWniiDTEAZtF5hvJKKsLcNdhup2a0CqPF4SeOKorY+1ZHl1/nIGL7GK1bwjjRuihQRjMfnMsbrJsmK7uPbhe/Tg8NGOt3tU6GO7v9SkrrXTWnogaOlC5HbTX6PblHKFK7lJoT27vmeTN+n2pQaGjRFPQjSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781123725; c=relaxed/simple;
	bh=JjQuJ+WAC4HyNOpJNX50DDwFBWBZkz8SWnUBsgssTIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oQgRSCSpI7MrTGR7Ej8OR6TCv1H2N2PIF9xVQND0fPd9KccHSuqj0bqhzDmAEV/dXPZbz8vqHxRyVaHCJ0crPdrd5skSoXqOYUGFrmpRX3A2feBeCYH1lnGSxpoJepECkoHLaKpFp1JL4yHKAHWPwdkW3wHuc3hyESRlRK5vuyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=igTB3EOP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="igTB3EOP"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490afc47455so38709605e9.2
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 13:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781123723; x=1781728523; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KoOn6a9eFPu3j3lxjvRT84RKODlbnmxk6NgG22+hUT4=;
        b=igTB3EOPZZPsECMO/Hv4FB1R1gbiXFqm40gZN/aaVQLyAcW7PS5/Tx0KuTwcbKtHeA
         +gQFI9ppAmqeQG6CFxnTrj56f9jhsIcaEosN1CjboWUs0L868AR2C7M6GseZuGZOBlPW
         cF23uYOF6rmOJgfLvvhl81ds0iqs1gi4rPxPwQxUlMsynyMLnoaeYCiiS//0z+IT5XT2
         YfxwUr+MHOPFo88ZIUNsulNc7u8GsOGoKcWElzcrtaeSqNE938CsPlEQZu3DCDPCFskA
         sx2G2D9WefUnNSB9i6P/DoQgcQJs4y4chRqLLNENiFCRPix0yCTzshzbkdEgsLkDjLA3
         m/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781123723; x=1781728523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KoOn6a9eFPu3j3lxjvRT84RKODlbnmxk6NgG22+hUT4=;
        b=FXC08IPeXakWxdzKMXt8+Z88p7YVHG8B1kmhjXney5txaWAqG+ar5GFYI5L+rHLmJD
         X7soaAtVOfJV0VhnJ0osyrQct4PPwBy7EESJ0zlyWNsujOTE8GNURV6M5q9mi1bUofFK
         WoxVrykBBQuwkdgp+gk3ar9z3WZDxxo/+N9kB8dmcOBAMnOAcbURAsVMLugbQ8UQhvCW
         qfHsk89IuMdlQDQBo3Xhcq750YRVbNpvgrqojceaiyKpD3bH1t+dLyE2oxOqQK1V89Sq
         ko7OLNnPFi/78ZFimH+1ZRXKPiTEZg2v3tp1wQ+Dcy3U2VfQtJatUhFQEUgWfZPWgY2k
         0KWQ==
X-Forwarded-Encrypted: i=1; AFNElJ95XFiSY760jDFfwUXmt8F3vQ8lbrqcpHm8EWmqLzBxmVheN1tzHL/rj7hgZOQIIEijABpnWdND3/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJAv09KHaJTQnUbeOtepw3OewT5bA8XydYPIbyrs4v9eJ9zOq9
	IWU+yKSvoH/3/eDj5kSM5+xWNPK2+C1H6xwzyFeWdlBQrTmHIHMJZn72ch2PMB/zHwU=
X-Gm-Gg: Acq92OF2BYM7Cu54z92vS9upzSbvaOn7+JjjdPJXABF6frXA2dvRpU/9Vk/bS3Ln1LH
	kESkl3sKsdnWapM4FJUHptmaa7+sX1S4+HQGPPdfkCf4kPS+RH7gu88RXBlnLI+0rPDvYiERXKa
	jyB2vzqa3DXwzXAjIaGwsaJE/D66rRdsPqGEjNCWMvA6tNk/bnLi2YcMBhg6OnaKDvn97vGyHbN
	iANBpNzabQHP3k6K2KiqicMdqql8hrFShm+lQhPEXb3an7HBjtx9DNhQ3MyMB8oqYVr2LqJ6eJn
	UYasq24p9zfkCTY9eLlZ4s9QTS5N4UT6pTxpUg+ebgba6t/sLbij06gQHMcXPvlw5FOOAuuJnq/
	ljpc09FXRYb9sYC8Jzxv7TE03WVVJpPYe+S8jeNPXAUf4bTZzdZsXMbXGUe+0pDLiDS6EFHMugf
	6cwtT3AD9HW4sjHpYX/y0a/eZ02upBfMB0KZ/9pufkWg==
X-Received: by 2002:a05:600c:4fd1:b0:490:b025:f324 with SMTP id 5b1f17b1804b1-490d723a47bmr117954105e9.32.1781123722748;
        Wed, 10 Jun 2026 13:35:22 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:202:c9ff:fe53:eda4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490dc4715e4sm62390975e9.0.2026.06.10.13.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 13:35:22 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 10 Jun 2026 22:35:15 +0200
Subject: [PATCH v5 10/10] m68k: defconfig: update stmark2 defconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-wip-stmark2-dac-v5-10-b76b83366d5c@baylibre.com>
References: <20260610-wip-stmark2-dac-v5-0-b76b83366d5c@baylibre.com>
In-Reply-To: <20260610-wip-stmark2-dac-v5-0-b76b83366d5c@baylibre.com>
To: Greg Ungerer <gerg@linux-m68k.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, 
 Arnd Bergmann <arnd@arndb.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.15.2

From: Angelo Dureghello <adureghello@baylibre.com>

Update stmark2 defconfig enabling MCF5441X DACs.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes for v5:
- move this patch after new Kconfig symbols are added
---
 arch/m68k/configs/stmark2_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/m68k/configs/stmark2_defconfig b/arch/m68k/configs/stmark2_defconfig
index b3fb95f73a95..3941113bc60b 100644
--- a/arch/m68k/configs/stmark2_defconfig
+++ b/arch/m68k/configs/stmark2_defconfig
@@ -76,6 +76,8 @@ CONFIG_DMADEVICES=y
 CONFIG_MCF_EDMA=y
 # CONFIG_VIRTIO_MENU is not set
 # CONFIG_VHOST_MENU is not set
+CONFIG_IIO=y
+CONFIG_MCF54415_DAC=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y

-- 
2.54.0

