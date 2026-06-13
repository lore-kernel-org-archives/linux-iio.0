Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65631245008
	for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 00:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781312298; cv=none; b=eBhbrs+W5ShAlG+xeq8z8K9KnaYvNiYzgi66WolUIVbYCLHyihgwWa6G6qZp4wWn78VwkD5o8lgFx4SOiYAJmbh/Bmouckxf4ZA+sUUMTlMGNGCf2YEMb8U9TlAS31wTSwp7zc6IjsgsEbUE8I4XTzmFHFh/WtcwZhJ0FYelYbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781312298; c=relaxed/simple;
	bh=4JkK0lG1GoAKEUw+xclyCrwEy0bo4h3OnzPD1CQIHII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtZf8ACZFYXMsSa7OM/zrWzIMEtR5vnSaN+B1v2VCYKMCCnPh8hbM/4V9Mla53He9GKzh3CMmtd17bmT7NMMzoQjdsl4u+GzNOwPd6b3hYmoSKCIER3Fzwo85XwfIAJSZ33J2nffiHMJGlSy1kCXWa5PKcbN9f7sez27raN3hEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dkkhe9N6; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dkkhe9N6"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-69e46524711so1039944eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 17:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781312296; x=1781917096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjgRrDs4U/LfhcpHjwNP4ZQVGC7Y6QM++jnEtid8htI=;
        b=Dkkhe9N62OZcmitmIUv+HkevEuE1mO8IZoyxA0pWdrHGj2D45S+2o2hDtyVzpky8Jb
         MY99L7SDDVwIuCOokdRI8jFTFNWfvqOykuyg9cPJGBJG+8DCZcz9hrBlEiCQnVCPbV2g
         sc8kPcTRZmd8cYp5ecyxqAPtZdghMu/Jp/6mw4td9a9OYsxSihovLEXFMAx5R1fvJX5w
         IsbMTmYRzpVMlJV8CbMqepxMwn2pD3CNNc/zriFfT3xmIohcS1/RD9Ms51VRg7XyTq/D
         lqcE80EQRBXU3vNs3O98f7Pw8Fl4hRuyKF8NjEVUfiAxFTWWeg+lBgi/6ehcydWqLC4n
         p3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781312296; x=1781917096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gjgRrDs4U/LfhcpHjwNP4ZQVGC7Y6QM++jnEtid8htI=;
        b=JRU2WvFVAIYrlfl42W0GlLWCUJ4IJJYazO4ty2LZSB9JFBM80iSqWMl3UbggvymJV2
         YJQzBIfZpBIGaVMfgwhjAGotSwv2EEPsppb61A8VaYt7QVq9zuk3D6AEr9awVK01JE3o
         VU/iTgrPUUOEOgUXKc+yfEd8QE2o6Go3J9TcKx197dI4e/mjNbqsWXljO3ANIwrtKHGN
         ws45pTugfXiIT881TKkGrgGWWwkOB+g8ymavB6ezz+aLOoZqWUBRTdBhCf1tkB4TmELl
         oYHasyz6XFe36Df+Ne2bwb94tXzF00snWVzRDxFsw82rtGC0HgGGBilKxzFyG1oW3hiA
         /IkA==
X-Forwarded-Encrypted: i=1; AFNElJ8azgIOVcnKrBo388ddjeScgxYxirYLbsdDNzgGSaexTUZYRUY23t8eTFHu6ZIl9PlfVUnxRZfxnVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaTO+KrU9FftEEckBpTbIAnBAOafMutrvlrTNnIgJEsfdmr9jQ
	cDp6Sj2VOhr+5tJAFbQDKF0lv8Ert2/aj0SrJmMHJXmrFC6FW8yXcOHB
X-Gm-Gg: Acq92OFrjH6XVI/u3FGdqnAZBQOsAwLjsH1J+7K+ZJ4K7r6t47pyTMdf0C4O+sjpPRr
	fH06z3WaSCOMQRHvo8L9fFuzd9pK17YR1HF5p+WUhUBLh62WC+hgQ7E/hfCGbeyMw35EKpql9Oi
	ynbfH0cGWbM4L5CFEFy2hji+swQ0gJ12hjydyx0tOEKJiMaW6RdDpi4xhLTkXsQotDc/FaE5a4z
	cnl0h6XZ3kYK5BtbDveqF3j/4+FxB/pkqMM5h0SnjfOF8SEBuPnQTiO/gV0cz9wazpJ99CCaa36
	lY4C2KkCcvv/ZXyksLFuLnYidjVLcmjXrkVbF67p8MgWWkGLGDJmHQGuzYe092wh/HD891EnPjB
	JcGF0egJHtiwjw7Hb7zfVlGjOT3hzo68NkomE0F3I+E0qxV8AiydmPF5s+ThyEg1Q7M438phpm1
	rpczJipUaSLy7ggsa32anuiopqpn/talOEvpe+gILpTv7/SnwmvsqtH997MQ==
X-Received: by 2002:a05:6820:811:b0:69e:43a2:349 with SMTP id 006d021491bc7-69edc78cffdmr3361367eaf.47.1781312296313;
        Fri, 12 Jun 2026 17:58:16 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4426abf260dsm3150731fac.6.2026.06.12.17.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 17:58:15 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/LPC32XX SOC SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Cc: Sangyun Kim <sangyun.kim@snu.ac.kr>,
	Kyungwook Boo <bookyungwook@gmail.com>,
	Jaeyoung Chung <jjy600901@snu.ac.kr>
Subject: [PATCH 1/2] iio: adc: lpc32xx: Initialize completion before requesting IRQ
Date: Fri, 12 Jun 2026 19:58:10 -0500
Message-ID: <20260613005812.160572-2-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613005812.160572-1-m32285159@gmail.com>
References: <20260613005812.160572-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the report from Jaeyoung Chung:

"lpc32xx_adc_probe() in drivers/iio/adc/lpc32xx_adc.c registers its
interrupt handler with devm_request_irq() before it initializes
st->completion with init_completion(). If an interrupt arrives after
devm_request_irq() and before init_completion(), the handler calls
complete() on an uninitialized completion, causing a kernel panic.

The probe path, in lpc32xx_adc_probe():

    iodev = devm_iio_device_alloc(&pdev->dev, sizeof(*st)); /* st kzalloc-zeroed */
    ...
    retval = devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
                              LPC32XXAD_NAME, st);           /* register handler */
    ...
    init_completion(&st->completion);                       /* initialize completion */

lpc32xx_adc_isr() calls complete():

    complete(&st->completion);

If the device raises an interrupt before init_completion() runs,
complete() acquires the uninitialized wait.lock and walks the zeroed
task_list in swake_up_locked(). The zeroed task_list makes list_empty()
return false, so swake_up_locked() dereferences a NULL list entry,
triggering a KASAN wild-memory-access."

Fix the chance of a spurious IRQ causing an uninitialized pointer
dereference by moving init_completion() above devm_request_irq().

Fixes: 7901b2a1453e ("staging:iio:adc:lpc32xx rename local state structure to _state")
Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
Reported-by: Kyungwook Boo <bookyungwook@gmail.com>
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
Closes: https://lore.kernel.org/linux-iio/20260610115700.774689-1-jjy600901@snu.ac.kr/
Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/adc/lpc32xx_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
index 43a7bc8158b5..db3a602327ff 100644
--- a/drivers/iio/adc/lpc32xx_adc.c
+++ b/drivers/iio/adc/lpc32xx_adc.c
@@ -179,6 +179,8 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	init_completion(&st->completion);
+
 	retval = devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
 				  LPC32XXAD_NAME, st);
 	if (retval < 0) {
@@ -197,8 +199,6 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, iodev);
 
-	init_completion(&st->completion);
-
 	iodev->name = LPC32XXAD_NAME;
 	iodev->info = &lpc32xx_adc_iio_info;
 	iodev->modes = INDIO_DIRECT_MODE;
-- 
2.54.0

