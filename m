Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1153382C9
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776445102; cv=none; b=Seu85Sz28Y72QIcimdUSjfGsrGw9NXzBZGb0wkyPHX9Ryng36r1bqvnVaGM8SYJ0gqWg5+0idL0IiXmTVFcXc8aOCHWOe7mS0t77QKhSK3Xt02ZUVCLUhte9u6iqc+wlDgr1k4IYkdF0UvXdaZz7IQVFpSXrLCTDd6muuBn0lzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776445102; c=relaxed/simple;
	bh=bviVzvpQp7ozMWIfNHfjVokT1in22wzNGj3dpuz+83s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g90QajcVRcw3Onns+q1g3DBjpgRlQsg0QcJCNruGR96EJ10Pgk5ywjXWCAn3W1yxdAXagp2kedLkjMUm6wEqjVZtzd8qlrfLhBbx2vmbRrKL7IAms4bWejJq5QZLc1FWUChGQbWXuF+Gt8b+De5R2tl49AGiIAJbJvLHP1+1r8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=DGIDu0Xe; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="DGIDu0Xe"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56e91f17a99so609901e0c.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 09:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776445098; x=1777049898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWrrh3WifBSAe/7scdSCjtHzLAuB6xD6Wart7VPQMFE=;
        b=DGIDu0XeYuCQSNRVIUgQi4x7FnYxghY3HV5N0v6LPlYqRPbeKR9DC1Hcpj7puIhded
         FYs7mCsDyiHZOVWwUeQl//EzXwGhPLV0erY35YCAcBSWOP798tntFORuBwWwtsrL4kCQ
         T6gW+xP3LPJXhoSW6CuAhzkM/a6SshKQM3S05RLX2hStLU2U8w/Bkt5PszLiFLqBxv5N
         NlrLE56uFwVzYcUPzxaWfuyhGCyRYrcH1vKaWfDiG24GFrWhgIJ/CThmLqaG9kZD8rKn
         0IoANJYwfmyl4Ax35u6h4LMJljNYJRglmRklmfq7KIBpjkEw/0f9lZaIJerWPg2Y4FQE
         7Vpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776445098; x=1777049898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mWrrh3WifBSAe/7scdSCjtHzLAuB6xD6Wart7VPQMFE=;
        b=lpIQpWgWOSgU/mxttTIOT2L3MCBgs8wHUUDrj1KfQFyagKVBpIzKYYFibZvMWUKsKv
         SYr95f7qEaLYHD5tZkv9elhXmfGcY0LUE1b+Ai1+h0Gemj8zZGZoB7Z31b3WrMu0YcrC
         3O/K6KJfN+GE6nEWOwDOCTwLaPUUZxJpGfoUDvyNSVrt85ZkZz7gPk5gVePclEy2Y2M1
         c38fs2XhADNj+2ML4HU6SU4/Pf6fHiIqXrKW1CJsTeLzS4Ihszkof7AyRm10S1D/3fUB
         FvkuWzu2udaj04UTo3YgurXSxgJ/sl4sKSNm0DdnonqxLTD7yi3LHJfzGrc/1DGegLtJ
         eEuQ==
X-Forwarded-Encrypted: i=1; AFNElJ/9xDeszvEtpAavt02mySjYx+SPsyQNsuKe8ZsWHEgiAmN7wc3MCSn2s8VEgnVYV7QEtnJWg5HODU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyZGCkccTG5aVDRU4+Kcrv8K7zURKNwTiwOOpeiAznKZeOutao
	vDU4fg0+kUwlxR55Allr8wx7FwZX1zkPWIANYynPCjlbd1ePvQAeiN9UUyMHC6M0p94=
X-Gm-Gg: AeBDietquLyt0urbFOCtlHLbGFB8Gj7xrRkqqr+nGxCUvDVmXLM9QkfY/+Pe5s8oppm
	O76gO4suHxZ3xtFomTTfOz48QzYWlElXchqr8mYjYxpK1Fate1km8NP+7uhN8YbaN+7nMC/G2sK
	pBnlSwnlGMjwY7layP2s/IgF4BOGYZf//VbR61a6SBrvfs8aOPMAPMaAte7sfs9SqyJK1ExzjLY
	2dG6aaHaWEfzqHkeP9n5bf9+us8YXhslSzVP0V6NjwpuCVvCFhNPnkKUSVo6RVifzV3R7uCVchA
	FGT/TOGyiDGWGvKRZ97cFUOYUGHY1q2fZvtCHR+wBRTRtKh7ms7UEp3VXUVZUUPDcXtv5GwGTIo
	TE3eItVOisiG4zBZBylweJD+67PN2YX8j4WpzZPvlBNZoegT+IHyH7L0lJGBOh/KDn0zKk/vjNM
	U+ElkJHokpI49cNE4isUQ4D9GC5N5A7U814TbZjjJAIvhtaJlnYeDTBw==
X-Received: by 2002:a05:6122:3d0c:b0:56f:1bbb:83d6 with SMTP id 71dfb90a1353d-56fa59d7ed7mr2207163e0c.10.1776445098330;
        Fri, 17 Apr 2026 09:58:18 -0700 (PDT)
Received: from avocado.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa91bf90fsm1195622e0c.1.2026.04.17.09.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 09:58:17 -0700 (PDT)
From: Marcelo Machado Lage <marcelomlage@usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com
Cc: Marcelo Machado Lage <marcelomlage@usp.br>,
	Vinicius Lira <vinilira@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 1/2] iio: adc: mcp3422: rewrite mask macros using bitfield macros
Date: Fri, 17 Apr 2026 13:57:46 -0300
Message-Id: <20260417165747.507487-2-marcelomlage@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417165747.507487-1-marcelomlage@usp.br>
References: <20260417165747.507487-1-marcelomlage@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rewrite MCP3422_CHANNEL_MASK, MCP3422_PGA_MASK, MCP3422_PGA_MASK
and MCP3422_CONT_SAMPLING using GENMASK() and BIT() macros from
bitfield.h.

The other macros MCP3422_SRATE_{240, 60, 15, 3} were not changed
because they are also used as array indices.

Signed-off-by: Marcelo Machado Lage <marcelomlage@usp.br>
Co-developed-by: Vinicius Lira <vinilira@usp.br>
Signed-off-by: Vinicius Lira <vinilira@usp.br>
---
 drivers/iio/adc/mcp3422.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index 50834fdcf738..59bf73304588 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -13,6 +13,7 @@
  * voltage unit is nV.
  */
 
+#include <linux/bits.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
@@ -25,9 +26,9 @@
 #include <linux/iio/sysfs.h>
 
 /* Masks */
-#define MCP3422_CHANNEL_MASK	0x60
-#define MCP3422_PGA_MASK	0x03
-#define MCP3422_SRATE_MASK	0x0C
+#define MCP3422_CHANNEL_MASK	GENMASK(6, 5)
+#define MCP3422_PGA_MASK	GENMASK(1, 0)
+#define MCP3422_SRATE_MASK	GENMASK(3, 2)
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

