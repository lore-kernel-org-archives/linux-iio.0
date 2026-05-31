Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217DB345CBC
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241172; cv=none; b=JK1hzeoT+q34dSqkhgIUxCjSJWxXwbao6Ah9etyWD9M73YZN/bv/+esWGD1GSVnOaLGoQveZv1iXsff3vx+GHAF9hJGmTPng+ebPfQndvLFY3cSscRotdJeI8tEf05gPu9gPceETvDoZ/g84mD3YtiVTav3+TLHE2U7eYhhwCNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241172; c=relaxed/simple;
	bh=n0b364dDBrWM4RGQrGIAbMsbTV+2t0ZGtLdE7nGAO9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QgLdn46uDGjuMp3ZV59jtg78Sa5ajXSmPIJjMAZGRrCeMUI72xJnI3lvG7HoBgiBI/45nOBMQb1Xzjd+QKHIZ4MyGiJkLCDHDfBu3rkfEzbM7yNhQ3JZHUtKrmELPXIkkGhATikaNfDYYRdraHPaRsZgqwUQ45L4rUX8+Dw2S/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=bmJU5wg1; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="bmJU5wg1"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4600ddc4017so370326f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 08:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780241165; x=1780845965; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqVoCiMOeXwzd334lL+Kbbn+xeppyD+CHd7jRk3nty8=;
        b=bmJU5wg1NywS0wT9foLNQJ921i36DrPOPf6ANWS9bSuIHKxO2yi9daow3RPFqcmRh6
         yLWC1bsJhHvr/toa3HiEV4YHIasqIKmIjnXiPcUp+jvkbKmT7Ba0/4+ibdBoiyaGiOu3
         Lr5EzDxHHcsZFLSyRK6Ti7ReEyEWgFBR65Evrhe8QieIUwjQ08WQLxm0xKu19m/14KTG
         dPu67wRFwDJ1sUdL6d36laS4an/FWesCwebMBIwC0BANvfOAvq5ZxMPYjcG4EjkpwvHu
         VHT2r/W8Q3+29+7tNa34iRf27NtaZ5p/6uV8cu0MvY1kZVlvTUpYaLnQZciDO2wbaECz
         h9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780241165; x=1780845965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mqVoCiMOeXwzd334lL+Kbbn+xeppyD+CHd7jRk3nty8=;
        b=b5Y7dD9F997KZs9msHm67jGStBUnLvmJk011/8DK7lMX1AXpRdlFoMGfjktqVoRwhU
         YTAje5sXbF/NWD5bAvbdbcZYYJP96nSXhtoDMy7LtGXEkomoSEr62be8pE1y+wJo+T8X
         9ixxgr9yqeOZReL8NmLJ9UrirX/f6oxUrEHGso1O3K2g6QXnWoKN4TdxDlqNmbTLghQt
         8YmdXBMKIyhnvPDb2W/V4LUZBNFpJDM7Am6e0o5C5X4yytB/ctkYcXt6UJXldlIs0YNW
         02OvXlP8fmnrSRYXx2RM73QBjKUKrcj8WHDEBiZ+86qMbdevXbOwGoCWprhJzsVs3n6X
         STNA==
X-Forwarded-Encrypted: i=1; AFNElJ9XRILCgrhAl/4hnu8utI1bH/qz6hL7YXQ1NQ9hDvufIDwjOnNIq2aKrx2GVJ+k/2ELDOBxZFWXE74=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVbSjIOh1RRvDJw/MoCw8zQRQNsVMkamSeeyy6C3AEEMpKBXHR
	rheJXpzzFE5+Ik3VL22bEWoyiXnAaAvh+OBREU/B3jzg6vaLWPoTEqzRSahlqBVHQd8=
X-Gm-Gg: Acq92OF3GLlrUT0wLIUYDnLNkeQycY+x/NrPaJ65zvwYA9p8/tbajpi2CVAi/nOniNh
	/3xNUwMwUFQqnvi9HEs9BPu8mNg+36miKEBrt99UAzE9L/uBEVFXcesEqSWSqus9JOkoMgGeILz
	Hs7xRF/oX+pqKu9MR5EMisbDy1N2bRair6eeh8xTTv6QPDeWHnB42R22sYVh8icbFEv+PG7WiAq
	HyQVTJmAX4sRjJuQugNYMDLqLZvV90ABPgOJDPbuoQP7Zz9cKCOOUMwMbt3gOg8o6fg2n47oLIX
	J9lGYNQPkZc/4+aj/9Nj5V6QBsPxQUzTeBf47V0cfd+HFI501GYpaxAn6k80w7a+WA5quH/uYX5
	Vkgyxv0lTk9SsLDNG3nslAs/57dCbRKJoTlmWIZ4/VpV7SKXZ0CWeDCA/cESWCmHKaEHa9unlS2
	Yj0T6DxGF0bdO8UMAJU5zqADb4CxfsZmn+7qg8eXge1A==
X-Received: by 2002:a05:6000:228a:b0:45e:f780:6181 with SMTP id ffacd0b85a97d-45ef7806726mr11531989f8f.23.1780241164634;
        Sun, 31 May 2026 08:26:04 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:202:c9ff:fe53:eda4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cf0dsm18526622f8f.17.2026.05.31.08.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 08:26:04 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Sun, 31 May 2026 17:25:59 +0200
Subject: [PATCH v4 06/11] m68k: mcf5441x: add CCM registers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-wip-stmark2-dac-v4-6-7e65ab4215dd@baylibre.com>
References: <20260531-wip-stmark2-dac-v4-0-7e65ab4215dd@baylibre.com>
In-Reply-To: <20260531-wip-stmark2-dac-v4-0-7e65ab4215dd@baylibre.com>
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

Add CCM module register offsets.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 arch/m68k/include/asm/m5441xsim.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/m68k/include/asm/m5441xsim.h b/arch/m68k/include/asm/m5441xsim.h
index f5acc962bb95..9ce2cbb05316 100644
--- a/arch/m68k/include/asm/m5441xsim.h
+++ b/arch/m68k/include/asm/m5441xsim.h
@@ -125,6 +125,26 @@
 #define MCFPM_PPMHR1		0xfc040038
 #define MCFPM_PPMLR1		0xfc04003c
 #define MCFPM_LPCR		0xec090007
+
+/*
+ * Chip Configuration Module (CCM).
+ */
+#define MCF_CCM_CCR		0xec090004
+#define MCF_CCM_RCON		0xec090008
+#define MCF_CCM_CIR		0xec09000a
+#define MCF_CCM_MISCCR		0xec09000e
+#define MCF_CCM_CDRH		0xec090010
+#define MCF_CCM_CDRL		0xec090012
+#define MCF_CCM_UOCSR		0xec090014
+#define MCF_CCM_UHCSR		0xec090016
+#define MCF_CCM_MISCCR3		0xec090018
+#define MCF_CCM_MISCCR2		0xec09001a
+#define MCF_CCM_ADCTSR		0xec09001c
+#define MCF_CCM_DACTSR		0xec09001e
+#define MCF_CCM_SBFSR		0xec090020
+#define MCF_CCM_SBFCR		0xec090022
+#define MCF_CCM_FNACR		0xec090024
+
 /*
  *  UART module.
  */

-- 
2.54.0

