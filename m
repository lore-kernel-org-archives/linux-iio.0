Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09FB3C2791
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776712533; cv=none; b=rWGCMsurcIycP7D7Bl+KmXRzrUmyJs2FyEs5S6f5mvMN9Z39RYOOxr9/An1RRgBhq6jOVc6cPC/W+0JYzuHbAwDxVgOty+kfLB9tsGxpjwixvouobdGr262j7NDvEJVnNtfSbn1WFXZAVYJIvn/k7vbJa+szcURVoj/BhCmHUvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776712533; c=relaxed/simple;
	bh=puDbpFO+Ona/yCRKTmXUGVusrLGDPA0yQoyPW5FpQTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qhPIwXz1UdSwtMP4GYRUnUdtjik9qh6XLeEqrkVuU8tJFLazUbSKIWTvljcV+0HQJPj83qchuy6q8Fxwd7Rt7GtkU/vwo1L/7UUA8z4iD2t4xhToLBKVqY8Ztr7uz94P8Fz9vIWUnuE8fU3+C6+13GTCiHLri3IbUcmLUwNFdBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=GmPQfyC1; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="GmPQfyC1"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12c6df0b9bbso6823518c88.1
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 12:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776712530; x=1777317330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJMjKAzmd0ZGw+2i8vTyDDgqtvY0yFeWru2DDMsblHM=;
        b=GmPQfyC1YDk1biaR+6zbgEWm1T8nlmFyqmrIjqc9d9/wUkX9HxZRA1UoGQ7PKij2ex
         CUcc/KKP8N+OCdCM9l4qi/z4dufxY6gFfLBwO6+Y1Qbw4IBJ7ihFAivrA/7gh1L/0774
         lltJ78S6oUjR/Up3+Mg+m5Bmdg89DCOblwB8uFQe9mtUC+kH/f+sfdw77BGk2de3X4je
         YyqHxn2cLSYAPJTB4ivwqYsZjDtFWPQdQCsPvOKVatvSk+v2lufKe2soPMGNr8pvnSAe
         RyWyGtmVohc4pRH+0fnaGIneKmGK5OLeXScZa5FwtOMmO5zME7ThYOUnChpPI3ACcqR6
         xheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776712530; x=1777317330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MJMjKAzmd0ZGw+2i8vTyDDgqtvY0yFeWru2DDMsblHM=;
        b=H4iCr06og88UedNtmmksv5ahjwPUkHzrGfNpYTc61qM0vLVHGktAy5jhqtoG/O0Uyy
         u1Pv2HAWNE3W1o67/b62nN3hcUo9Irw0LLoL2IKWDW2jmog7CeJLsf/quO4WR0b4M3CI
         OFDQ9I8lZDX8RCD5mHL0vbXuH2FD6dj+16alqddi4XtjY75hhx9iF9/soVJyR4dN6/e+
         Oe8sMphYIvMa94+FUXH0vLXmm930Yei/czrXDTPpaU1BHzAOa4pLOvPOPO7mMswQClce
         9CvuO2SM5n92XyPk8R7deVdblGpn62egvx1Hu4cM26dPYcVxYpO2/TrdWZODR1IgrXJg
         477w==
X-Forwarded-Encrypted: i=1; AFNElJ9+HJFAXxNRkNbbQLo+vu2pMEkSDoMIvmsy4QbA2HZO+dggtvYmZP5CS12n6TTG0+WzHW8jmivrQNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHBu88SdF3XTN9kkuMwP32FA8iPAOQ0lMnkPnkkIjZHzOEiP7P
	OmM2Q/iXT62DzuoIyeuX9zPbwODSIrkFDWuSpk+UA5zQ4Aa3EE4Oiis4XFmrml8n1xY=
X-Gm-Gg: AeBDieu6BP4aLXWKQcfiO2RagJC7UvwxYR8Ci4Eg56ikXHCsF8e6o3Y6PWvsRnuhajZ
	M5qJ4fHuvgCYTl4dCheDCaQ81VTxdNnor5AgiSyvHQNK37uIb2+xxmX3fzfLqVW7+jJbjIJT0Rx
	VB0bKDhCUqIq/9PBOdmbUH7qfl307WAYQgyvzNYY+g1uCXRHvOTHCJvC7JhzLApHA06TAzUqZCP
	ZrSXYLKSN8Cm+3kp0CxKPtWZpIJep2Sf65zSQ2xoG1xjdDphnWCAn8TjCf9gOEJiBW8b9ZlkZd2
	3ltScYr2cq4V0FpASylWIPlkV6cfSFLZS/9t4WMu+6U8OXFbL9zMxEPzPK7MWe0wJsPi+Z+nYFx
	xvVyGbdgJN9cE0do/vPebmVs/v6sVvtaTTEd0q5hNDmjUPLRvHpbu5lzna5OMzoVgRP5AKwu1EL
	6e3XJGn1hoTV6jTPjiurboXdg4NgxsmV1vUr0ctjGbIopRXX1pjYK6fSnvpFmM
X-Received: by 2002:a05:7022:4199:b0:127:33e0:ea44 with SMTP id a92af1059eb24-12c73fab049mr8657195c88.29.1776712529453;
        Mon, 20 Apr 2026 12:15:29 -0700 (PDT)
Received: from avocado.. (mvx-177-92-77-170.mundivox.com. [177.92.77.170])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a2ac32sm16106846c88.15.2026.04.20.12.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 12:15:28 -0700 (PDT)
From: Marcelo Machado Lage <marcelomlage@usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com
Cc: Marcelo Machado Lage <marcelomlage@usp.br>,
	Vinicius Lira <vinilira@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 1/2] iio: adc: mcp3422: rewrite mask macros using bits.h macros
Date: Mon, 20 Apr 2026 16:14:54 -0300
Message-Id: <20260420191455.529923-2-marcelomlage@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420191455.529923-1-marcelomlage@usp.br>
References: <20260420191455.529923-1-marcelomlage@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rewrite MCP3422_CHANNEL_MASK, MCP3422_PGA_MASK, MCP3422_PGA_MASK
and MCP3422_CONT_SAMPLING using GENMASK() and BIT() macros from
bits.h.

The other macros MCP3422_SRATE_{240, 60, 15, 3} were not changed
because they are also used as array indices.

Signed-off-by: Marcelo Machado Lage <marcelomlage@usp.br>
Co-developed-by: Vinicius Lira <vinilira@usp.br>
Signed-off-by: Vinicius Lira <vinilira@usp.br>
---

v1 -> v2:
 - Split this change from the rest of the patch, following a request by Andy Shevchenko
v2 -> v3:
 - Sort marks in logical order, following a request by David Lechner
 - Delete the "/* Masks */" comment to avoid confusion, following a request by Jonathan Cameron

v1: https://lore.kernel.org/linux-iio/20260417005041.484742-1-marcelomlage@usp.br/
v2: https://lore.kernel.org/linux-iio/20260417165747.507487-1-marcelomlage@usp.br/

 drivers/iio/adc/mcp3422.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index 50834fdcf738..0cd0e7d39e39 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -13,6 +13,7 @@
  * voltage unit is nV.
  */
 
+#include <linux/bits.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
@@ -24,10 +25,10 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-/* Masks */
-#define MCP3422_CHANNEL_MASK	0x60
-#define MCP3422_PGA_MASK	0x03
-#define MCP3422_SRATE_MASK	0x0C
+#define MCP3422_CHANNEL_MASK	GENMASK(6, 5)
+#define MCP3422_SRATE_MASK	GENMASK(3, 2)
+#define MCP3422_PGA_MASK	GENMASK(1, 0)
+
 #define MCP3422_SRATE_240	0x0
 #define MCP3422_SRATE_60	0x1
 #define MCP3422_SRATE_15	0x2
@@ -36,7 +37,7 @@
 #define MCP3422_PGA_2	1
 #define MCP3422_PGA_4	2
 #define MCP3422_PGA_8	3
-#define MCP3422_CONT_SAMPLING	0x10
+#define MCP3422_CONT_SAMPLING	BIT(4)
 
 #define MCP3422_CHANNEL(config)	(((config) & MCP3422_CHANNEL_MASK) >> 5)
 #define MCP3422_PGA(config)	((config) & MCP3422_PGA_MASK)
-- 
2.34.1

