Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4711F390CA6
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241170; cv=none; b=WK77Jxm29fGaBMQpaVrb7TOLdgAtgAvJ6KY1COF0soosbbPh10pO8d+51+xSdJZKodW9ciZdDD3Fx50OHMP4dQVLo18LlGGL7x/3PfSK4sSIbwcuu3qJb/D1bK0SQX0+dT58jTsNNlAsRM3AEe4NYtYVipQFxs90SfTqzabA9oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241170; c=relaxed/simple;
	bh=BTzMq5e9Ct1iS05RorpLyh1aN78tCIlpP86CvhH3+is=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qFufN9Em8N5+tP19uVJ4GBN8uiX9P7YPNNzKvkXE6soeNQxZEsxbxivuME9kuPi976DZXe7HaC8QP1qjnaEtceW5TSgvErv2oMpCutBC4DJ6MgJQPOwH7CKBCiuNLwH3EXZYrZg/bqlre4TIupn9AYDjQv9NshEEuBix+AKZsxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Tu1e1dBs; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Tu1e1dBs"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4904fd4f6aeso77385235e9.2
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 08:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780241163; x=1780845963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66sbIWl/UECZcngzqfN9gySpU5b7WSWy5FgqX8acPdE=;
        b=Tu1e1dBsbhudy0j5pDCUrqNL83wd8xkR9Gide4qAjwPG8PF1bXDCA+6n0tICSxJc4B
         isYHaDka6A/Xa0mzVds+QNdS8L8ewPZaRix3XxhmdYWPQBDch32+3KCFP87osOkPFNJZ
         ZSLVY3K+mcRJhTv8dN0aX3YhvNEBwB1dyKqURiTkl81Y5hVrBIfaT3r7zm5et1GFbnuU
         QIFLgzdDPdXPT99RO8r1PSKpCo+TR+TA/e98WJ1EGWzfYV0I0rrRDFyTxkRm+VApBhXI
         +Q1zgAkI2Z7GyjhhmpqbRTnMdxT+CmNT8/Am45xObhlhLk0olu+wdgIhZGfWL3oYj7NG
         21AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780241163; x=1780845963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=66sbIWl/UECZcngzqfN9gySpU5b7WSWy5FgqX8acPdE=;
        b=D3FLg0AvLU5Hz8Q4LQLoeNWqRvL/8ukdvNV4ftBgkUePpU0t6CS/vifKMcs2Gc17VM
         jW2gVqp67c0bl/r5/CQza9W2jH09PNimqCDWT9hGPQftFTxung57vv5U3LRP9y1oU+Fx
         MTNNCHBWhNtrY9BPIu0VCifRt9hMXJ/tbvRw4TDtL1O380g7yDg1rqwfsOrs+V+eCPGP
         hwtMxGtmP64i3MRmT8Teja8eZhBvTJNUUxjyicswJQ9hTK0EZGe8rAnshMk5KUPGTBSC
         cI39Kr3pqp9G5/AonLNSSy7FIIzKUTn6bEaNfhlu6/OWUyBmfh4JIMCKGTGfCtTzhS6R
         ImyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ixUShU9xgQxZGAuXEx6ppi5HYv+meEJo8Iqx4Cdwy21OAB24uZemYtkOdh622nVB8eyAt7gKD+6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiGrkLmByF0S+n71j5IrR/aZws8maVl7696DcltFvv+8YdC9x8
	Pkfy9DokK3W7EFRmHej2Z29NhLqICjD3HX1km4/twpbktwOyroPKvxpWMPGjss9MDhA=
X-Gm-Gg: Acq92OH8P3RTsjRonyxOhNds6CELpkMAFnhF2AXWqQSopj5s85vkh4JzJAXNuso3ABy
	+P+fwQFgUSCGlD/dxBLQZAxz7kd509YWmRxul4Y04RNyM9dw17Gm6MzStQaITdv/b0s3BzTAh/1
	yRJbGe+F0yzxHfAf2c8pGnkWvYe+CObf/EpNyNoFad+oEWHX2qbZvWRA7mIZqRfpyD/WxU6tWNp
	2tD5//WstUdewdRi2FInNld8sdfmp2RG2WwS5gL4FIUK5Z0/PtvgDWwUMaapfuB/PNKrZgHRNwb
	xf2vISdkTPRNUMnhK7B1EBe1QhOYMjcwSUiChgtzgUlqGJ/saHMiYgzOdSDFdvfXSwVGGWgCk6u
	BA+MF1kaUo2+Hq2pSI+iooa1UxM7t/0+MEtgDkw+F/sKOMncyA+5FNq3fy/V+DMj9HvtFCUQjMO
	ptkGIRFvu69cNhRnLDpqye6J5hpcw0kpc6fvDMNqzX5A==
X-Received: by 2002:a05:600c:8b77:b0:48a:9428:5522 with SMTP id 5b1f17b1804b1-490a293a0b1mr146990245e9.16.1780241163614;
        Sun, 31 May 2026 08:26:03 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:202:c9ff:fe53:eda4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cf0dsm18526622f8f.17.2026.05.31.08.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 08:26:03 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Sun, 31 May 2026 17:25:58 +0200
Subject: [PATCH v4 05/11] m68k: add DAC modules base addresses
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-wip-stmark2-dac-v4-5-7e65ab4215dd@baylibre.com>
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

