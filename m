Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638A2374A04
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 20:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781123717; cv=none; b=u/IztX8ovCVkLCORHir+nYKuIjKLYy+57Fx0tk4Z14Y04LTipjKqkHROzOqd1kbNmNEoiiAFu56c8J9sHBFeKCzKm4qSVXzNBMUwJKpBquT93zuMp0XZqAe9s2/Utg2NtrlZZEztIjs8odsazioMLyDkyqnRA5C/0ox9jirRQmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781123717; c=relaxed/simple;
	bh=BTzMq5e9Ct1iS05RorpLyh1aN78tCIlpP86CvhH3+is=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KdspvvfScBzeN/qznZaRrxC1zEk7nuuBZ/i/71gSZNiGAUS6hEgarDsl+JulywXr9wBiV+mqm5nO/lo0PSlg2PRpdmIi8ssEAmPidptvESstBMc46aZFtxNRGG24WLwXLJkNb56EVadElXdGni//QUBtwkPAWZ3B6fk1XO5DVvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=bR9OwaPG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="bR9OwaPG"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b3637b90so62262405e9.3
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 13:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781123713; x=1781728513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66sbIWl/UECZcngzqfN9gySpU5b7WSWy5FgqX8acPdE=;
        b=bR9OwaPGrCNAswHGpzz0pCPzNxKXHZej3zLR0U85mxg+XIKGVtbrxgjrIJYQyavweD
         S525G0TR8jWbu+Wf71qCF4P0JwQmDwZ+2L9EkSNIdOMuuRyR2l2JmsPlnSZMpkcYOSc9
         jVKJUaZrIyW7rHtzZXJdrXkDG6drkDVZ5FyhhgujdFl5hAwciyYuXfSK1KW1rhw4riqH
         rHIi7ey28ayJJSmqNQgV5W2FVSc9vuZuej3qAvQ4udg4CPy9wmmBLh1z/68ULcooPjXb
         eHipuGLZw4P73Cz79X6s2URewHD8SouQ7EtTu3y7pmqbyZOLh0h8RNkMvDDZgxT6Rw8d
         mCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781123713; x=1781728513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=66sbIWl/UECZcngzqfN9gySpU5b7WSWy5FgqX8acPdE=;
        b=SwdcaQlSm/bSVLIMywkl8Psbps0I01mkmAsnMOartwDvIaYBUh9orpKTB5BoptX9mg
         sCH9wiFOua/yivYOqGRnUVq924Xxm8Ph4j+iOFRJuX3At1sDTdUnw8k4kCCy1NIfMnOE
         FcKDAhE6SoBUUnwXBMaz9eLZAA6ZZimnPkpBnf1U5Lpw6pd5LBqdle25uwEfr6riw5ZG
         28ASSfsNy2ufGZQYyDkvK1j1fokQru+a7pa/gf3wC344/KgK+B9FA8mGHwN7zgKenmnZ
         bdqmp5AqdBLEavz3EQYpDBTqJumvKvZeqNb9WBfel3adYw/VpqPCXh9zZMFOO26IC5Dk
         +LNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/eI+HXNrFy+OHLV8Fggdf8aea0cyv5GWeBUK+kwfKkE6qBn3k9roMSoG21gtXhfxJSJvb9cBJ6Nh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWHFLFvQzT0q3RATyicD9TSIq+eaZ3k3Yl/OJOrAwbf+QBstI9
	FwLAaTW27JUf4byjg5tl7oPfl2EJfMMysXo6ukmbO17UiHbvD/HwM2MGYZA4+n4C80A=
X-Gm-Gg: Acq92OFjrI6o8hVMArvgXO8CHZODPhM7CDejiGp5/aUUW08IAonF7HeXcsG9H1lvxmo
	A/qWqOaGy5cT2tIfuW6XrDM34MVST8aWBccZf/ndfmc360BA+wMAR6icN2hP1jepJS2S91U4Dll
	5r9KmC5gvHcBcIVxBWGZp8C/H4gBNmrrYGpVEeDtZOnDPU2LyNk+MgECtQMwussgIQsQNgjN5wG
	P3lEhDpEJBu90U7azeggzZQWlyMNQ7W2DS2X1fTOZ/b0PNpwaXKu2dCulqSAmGovWrkmIZgmj46
	ipsif+quB2bVuMu9raFkCzq3Qocib0wXx99sCAbVlL875pkebFLkwwcMZowTTw4K964/b9JPXJ4
	EyueAbrut95RlN1HmfqUfRe/FM0b+LRqUSBFSPzxE3ViGn8jZtrtDExxJF5sCHYyhZrtm9XAZjZ
	T564VH83ohP2fwdiD/zGa8gqozG8QgDNmuwk2DnIq1Pw==
X-Received: by 2002:a05:600c:529b:b0:48e:6db3:ff2e with SMTP id 5b1f17b1804b1-490c4e0219emr371553115e9.15.1781123713488;
        Wed, 10 Jun 2026 13:35:13 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:202:c9ff:fe53:eda4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490dc4715e4sm62390975e9.0.2026.06.10.13.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 13:35:13 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 10 Jun 2026 22:35:08 +0200
Subject: [PATCH v5 03/10] m68k: add DAC modules base addresses
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-wip-stmark2-dac-v5-3-b76b83366d5c@baylibre.com>
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

Add DAC controller 0 and 1 base addresses.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 arch/m68k/include/asm/m5441xsim.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/m68k/include/asm/m5441xsim.h b/arch/m68k/include/asm/m5441xsim.h
index f48cf63bd782..f5acc962bb95 100644
--- a/arch/m68k/include/asm/m5441xsim.h
+++ b/arch/m68k/include/asm/m5441xsim.h
@@ -191,6 +191,11 @@
 #define MCFEPORT_EPPAR		0xfc090000
 #define MCFEPORT_EPIER		0xfc090003
 #define MCFEPORT_EPFR		0xfc090006
+/*
+ * DAC Modules.
+ */
+#define MCFDAC_BASE0		0xfc098000
+#define MCFDAC_BASE1		0xfc09c000
 /*
  *  RTC Module.
  */

-- 
2.54.0

