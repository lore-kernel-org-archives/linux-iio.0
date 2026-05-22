Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3851B38C42A
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 21:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779484885; cv=none; b=HLDeYsY1zPyPTuhzRSvPL01Au48a8VSnq5NDHxvssBuca2HpTXsXKVwJbuNUbH7UjMBYOpWAXAjznQaLw5uc89KwANdGHymmWZ/aNze6Zp4+lNVYRHMjSvJR30zknRF/n3fYbPj/ziHpkvQ1JTQHYt3Ysko+GuFWT2+iI3RKRdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779484885; c=relaxed/simple;
	bh=n0b364dDBrWM4RGQrGIAbMsbTV+2t0ZGtLdE7nGAO9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YOJ3aDfdERc1GHb55LCDaU0vJQvPO/cJ4QMm5aol/fKqG5EUzyXW9m9SOzSN3hKu4o9gWLqwImFQanC4jwQZp1gE1onlacOCzUaji0ggvVCmmM8BpGNtcHNB99Ipi05A6rJMDXN1j/sVMlrra0+daAtPtfGugrexLXFRp1xixYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ZO4FYr6o; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ZO4FYr6o"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so43262365e9.1
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 14:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779484883; x=1780089683; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqVoCiMOeXwzd334lL+Kbbn+xeppyD+CHd7jRk3nty8=;
        b=ZO4FYr6oTr9bTsqj6oMS9YsAQ2HyOkUti7sIa3yPhA38DftElIH2y95jS6nWN7leQ7
         YjXS67fw/Wf2Y8YzhBohlsxNgnFBGbHOHrXy5JGbMlaVU0bo+mAJRX3grP1ocJBTLWaV
         pMxoKxWQMidhBwo91Fk4jhMcWlNTBu3iE2Ksin23VonH1MzaTBWCP/wZWUJgFG1NO7Fj
         iiQtscVCJR6Er4RgVKS2vtG4kCTqPbFmmRBfyG1rimCMjY1S7VqijW9zMAdUQhkVBhps
         8BIfxXai/pJNvRlmj5CehAi1zLfDPEhIfPM+NcuCK1CuSXxvJE6keol3vhB+XCL+AGLv
         3TGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779484883; x=1780089683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mqVoCiMOeXwzd334lL+Kbbn+xeppyD+CHd7jRk3nty8=;
        b=hyQPtuZz0xhZdfCUpJG7q6RHJBmenbTbRP4zJbg/v2JSH2LfhoWGA+vH1MrDU/mSyr
         9/rzXJODU8Dftkge1FafQly4Dah2Oxlma5WpDJaea+f04miJ8VIjxxvd2usAtIKZyLLW
         byi18QanDgse9bD0C+2hN4EaGapL/9ceyNpWnJrSUTupS+Rts+4N4GTPNuUlax1ASewk
         Ba9CRR+YkAIkkK+Y0Yn/J3F3TMpf70iov3pxg7uY0Ml1LNEf9DIoqO6IcB+oeR5azE51
         zdoYJZVIL1ulx8oUN5Au18qAdHFMATkbjn6P/yOGzbjlpsqjpaixJYZtwflW37Sfskll
         q8iA==
X-Forwarded-Encrypted: i=1; AFNElJ9JHwEdtpGHxfiXiAwYHW8DAKiCuTUcA0MjD5Q/cc5XD1JagZlNdR5kppE2aVuv0ij+XI5HJzOkLAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEM/z18pMw3vYmqaI/PohCi6xVyfjvCKb4b77wBhEyWSt9mztT
	koXVLrhaHm3lu4PelW16n8nZ64ZgiSmS8fMtVwtJlYiKHocORbZB9TqHyBKjGRY9TDg=
X-Gm-Gg: Acq92OE1JxBLtgm2ZDUZdDf8KwPvuUo+WTXysjIVPoKbqQiAhOyVt7af3Ph0xOiBI2z
	oHNFqmbCEvmKu+RoK+8+9MHG1nDo2slPNe1y9Csna3MLNQ/OBAmNMCMuH/nBVpwPQwIifZaUO3A
	bn1Q8GgfYLzAfmCjzQZCucWUjz8O0hQAS+kjIf5u8viRuTK92PPT4jcnl5L7dURefyYrVXooNvT
	b/ZgEdNIo6QP5ECUSImbHsuZBcMB5p269+iZdj5tS8InJO/c704G0A9Ubp08qH1U8cHBclYvQpX
	Z6I/NC/aEF/kr+FzvZcv5F7cZoiZb1hU3V61fYBDJ4e6Gk5DMvU8MdQiMoLNzzLnGSJtZUd1qAB
	UMYlf1o/qfqIetsoIG/lqA5LaPRnVmB5tCb2iruXyNM04dV0P+OFBBZrRSTx/f892Zg5h6ULEfL
	qK/EkVNbvwJbRYxhTnjDcA/nkK5460s9I=
X-Received: by 2002:a05:600c:3b07:b0:490:f7c:b19 with SMTP id 5b1f17b1804b1-490420f67f5mr63502345e9.0.1779484882631;
        Fri, 22 May 2026 14:21:22 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:62cf:84ff:feee:627])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454a0b82sm73312225e9.9.2026.05.22.14.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 14:21:22 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 22 May 2026 23:20:34 +0200
Subject: [PATCH v3 06/11] m68k: mcf5441x: add CCM registers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-wip-stmark2-dac-v3-6-16be0ad35a67@baylibre.com>
References: <20260522-wip-stmark2-dac-v3-0-16be0ad35a67@baylibre.com>
In-Reply-To: <20260522-wip-stmark2-dac-v3-0-16be0ad35a67@baylibre.com>
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

