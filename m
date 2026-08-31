Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289E43624CF
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210831; cv=none; b=o755/AdliNhwK4cy92JZ+WEhEmC7vFR18cnXrUfZInlBy7ki/XochLfQkior1vWeiEHDEMLehkEJ0NYJBGdRc61Fs3N2uJfq4/sz6I335l0o0Ylj/Ouc9ZD5R6H2C5KteBt/TLDSike3zDrwgoYuEAtC+lQX/wl+bkZkth2c7gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210831; c=relaxed/simple;
	bh=S0psc0GokPMG3r5dgQR0E3KceBkww71p70Ddzytet2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MnEbC97guZLQ0/047UV7yAiB9/aml2OS0nOFTZHwFPN/8qQ3+peolbJFCC0WcD6yMD3Mtdz9r6e4scgyjkhNnrE3CYWPXWXx3Ariy4+HS2PG53kTl/FlBbFecFYOVGxm6WduQm7LxIrVXXPNm58oWHqPkQWZzNEmel+OgAwVUNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsUCvcIA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsUCvcIA"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-499ae1c6471so29352645e9.3
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 14:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788210828; x=1788815628; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BZLzJmQwMgWXL3sbjVA8gM6zLJbXj/mUC/hE8T4vkRg=;
        b=ZsUCvcIAOm9+R+7fP964cvUGr2pBAikOpWVPIMDCxUgEmCJ2Ghmxfe2WL2yT1w9i4m
         xByidXN6nnmlnFnyVucnhQBfrbjJy91/aFCagWlLrzTou8FF9qbG/Yq/ang534ONic+l
         8tdYVoEFn1uq2Zzvl1O4DEAunyuNSsIUSECjmXAS40cU3ZwvVjzDwOV4rjMnW8vZOM79
         DMa58brj2alhMqpfBOJAZTLfMbhANm36+q/ODIzgFJ9Mc+luOPBj7hlCUWNHPzod4euM
         x92CzM3ZtA/HEAUbM+8rJzpYRn3i/PWZJuJPICwZJ/lRZEUMXtJKROvIMWIuyHUTRSPI
         aX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788210828; x=1788815628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BZLzJmQwMgWXL3sbjVA8gM6zLJbXj/mUC/hE8T4vkRg=;
        b=f/I8X6bNZ8pPt9f3s90IsZCbiz7Wdr0TT+TESFzsmkc2j+FO0S5KD27MdjM4AE7WGy
         kmDH+obnQnWKXPEZunbnXbbfQYCw6KSMQ+WHh1h7Fwp0m+39n7MjkO3tn86i7ELeuyEF
         g8SLEJ9l4+cj65w4zCCRmkHMdCBZREuBzMpL+wCNKOTKb4UiXi2tZlwax1W9Pf5aCQLa
         IynMNE/n2e8wd+LyERKrDkCexuXoscXMXI9ojnNUZRmNdzAbsew9mwu5swytkJ+tUU8K
         TWb6LV4QEGliwVU1KB/YTfa+uNW/s740yG+SKsWLwK5s9GIMPTgp39dthjxcKl+Qx6+B
         JRRQ==
X-Gm-Message-State: AFuF++keRIVMAvO2XwSBnMBMxB8PtOqE2xvK9ykJyjFetd679AeUoBVz
	+xYSIVboaWhIly6ZBixdoHB2BuxB9CiloOHwcIy289gtoYZaPFPcKA+P
X-Gm-Gg: AR+sD12w3czAn4Nb6TacnSoLSY6HH1wJMU2T2ojyR0Lv9G6lZwE9CNfEze6R8gmeAsu
	24q0O6oek+Z3To1yADyKwPoVjxWkFIkNMDYsANsu81n6OyzEI0+JRBFuqzG9Y7XjVpXWt8Sre78
	Dzz5I5XICsyBzurg+JMs73jNkzwga4sunARtLkMBhCtdY33HMOqYuAYIzP4UWEHwj88tuuPsx0F
	wMtkzV8T1ie2Y5YAnTrwp39ybK2hzLYnBJsrRcPgbRRYlFyrSmgSKrhIPR+B3soeo/9aCYDIxtx
	3QQQFq4/y16WPU9Bmo/f/IXvDgLBCMXvX60vPKsqkAPw3VBEsEFQCPwvjJvNxBtadS+TWBZybGO
	Nl6CjCOU4b54pJUj8G+/WN/f43UwWfRF4faOdZIDskfa2LtNhz9z1zZeIIY4Rg0OQzb++iSeLCs
	duFHvDwjeFNd1jyrGjYwa/GE65RKJiMvdNIqrcN7QvIK91ZISIfzd1d5nkaVGnLFQk9wZtBXRuV
	PNO4nZ0Y5CmxLgyNRHm8qo9vAJwKQtQHxfnEDbE1ravuw8IjMvOvkt8ydHnoP0gzbI6cfK3motg
	Gw/OB+HDLTd6Cf82TphDyuKqIZNuQ5ARXRVyB1eqS5w4FVos6dvHDacJ8PcUVYbpgZFS/U0CIhK
	leRBdwqH0p7bynD2VlbN3H430
X-Received: by 2002:a05:600c:6215:b0:499:593b:a15b with SMTP id 5b1f17b1804b1-49cdc422c50mr67567885e9.1.1788210828027;
        Mon, 31 Aug 2026 14:13:48 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce1754csm17695925e9.10.2026.08.31.14.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:13:47 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 31 Aug 2026 23:13:36 +0200
Subject: [PATCH v2 06/11] iio: temperature: tmp117: sort headers
 alphabetically
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-kernel-header-removal-v2-6-b92b580ef5eb@gmail.com>
References: <20260831-kernel-header-removal-v2-0-b92b580ef5eb@gmail.com>
In-Reply-To: <20260831-kernel-header-removal-v2-0-b92b580ef5eb@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788210819; l=928;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=S0psc0GokPMG3r5dgQR0E3KceBkww71p70Ddzytet2M=;
 b=Bi5LMlu2NHtnbcUH9zCVbESPx41H1U8BXpXZ7VyzptCnG7IBK55Vd7dRuuebmXwInnSyvrSP7
 qHuc2Y4CYJRDqghAnEANFvwE+YTiTlX9rQ/AqRs8a+nGc2t47B66E6f
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Sort the headers alphabetically to improve readability.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/temperature/tmp117.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
index 74cb8d62bef3..fed8af2d81eb 100644
--- a/drivers/iio/temperature/tmp117.c
+++ b/drivers/iio/temperature/tmp117.c
@@ -10,16 +10,16 @@
  */
 
 #include <linux/array_size.h>
+#include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
-#include <linux/module.h>
-#include <linux/bitops.h>
-#include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/limits.h>
+#include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 

-- 
2.55.0

