Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A7227AC45
	for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 05:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782364851; cv=none; b=KMaswn3EGCUgnanche/LrvqVPKEuryT0lJeXdbtSfIYONAzgA7zN9mc/wcQiFyq+5rT7KRtBBb6FFfjiLyT44hBxsQ0VMsyjivDg3L7fxcXmykrBuB1WWjHB78NtQR3aT/fKfi165KSyIren9A/WH1d/mnxbpyUBcnvLLyK/MQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782364851; c=relaxed/simple;
	bh=oMGffqXvVB7R2bEw42xeETVE3hp9hgCzT3y/Cg8jnnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GwpiNldH2abQo0XunmJYFjmGfPEBmxvYVPTfca2F1gh/gCeni/9+8pJYKkFbrNFdtXKD9DKvY8V8is3UIQ6Z8FqpAdpHb4urs7n4p48XBKvs7pqaZmCkk1eIhA/7GCk0Y9fLOVm9rVbccnkPkzrxruk4MNIIrA6qpl63teRPwH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8GUYaWz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8GUYaWz"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso12434375e9.2
        for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 22:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782364848; x=1782969648; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6xbPviIa+we2MhoBCaHuKBDWvLJKlfq7TuHTlTN5Fhs=;
        b=J8GUYaWzq1A80U1dqiy3cdpg4pQXccPPR2Kn1EZEa3oWp/L4fg1/KLZPVRl2ek33MF
         erhzJBJUYQ6BVjx1Z5Gcie9CfEbzbxpaerHYpfHD03a01nmAFkA3fKtZvGuZfT/7GgMy
         NmYmr08EKo1GYLGGGnifnpY1z+lrkSu9UlxSR9A2HTAcLzehUuiwG4IvStJp+EIiMJuI
         QeH5/iqeKZ9XCtSEKrOF8vKgM+7ZW+0q1B8VsD5glMqB4A1dpz4biRGinKCcuDuxJYvz
         64EWjrm6YRZjIZN8OxMLY4elu57EMuhIlVcFk/Cqbzf2z3kOiInbaO+153ZPpSkBrGk/
         mFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782364848; x=1782969648;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6xbPviIa+we2MhoBCaHuKBDWvLJKlfq7TuHTlTN5Fhs=;
        b=okRQYkSdJxmzjTAcQCPAhI8o0Z0Ln1LgEf6q9Q1jzIBfcUGmL4e/FcNXpjBibIb/Tg
         4gDy4m0dYJja4ee7QL5cob2SSWndiPg+DoaZIVXhICpVFlVj98+4XbMb/OTrZp0TCO0/
         R825BChg39mUMtY+7OISHR1bcid2ZjxWP4isT82ZhP2qRx+kGyHNRDsiD94Bit2HHe3V
         T8d2PEQwB2GIt8PNkLkiAa6ONH/6fiZd0e+ojzLxRSbrEHDV9brRZxFAFN6vrp7gqP2a
         IyIWUY1z9MUhK3Ixq2LSBhnm0ziO/feYPOev5azsLmoFy1gowISE8fZz82XaQgs508gj
         Oi0w==
X-Gm-Message-State: AOJu0Yw+/71ZamrAwd1VuS3Pyd7sMYxtyuMnoDpTeEZnuUmskXxDkgtT
	m6ePNJ7SGF5yPMpokT3zeyAW8uJaEH+TG1kvgh8uNwrnYqqh3e+Nt5IcDGIp+w==
X-Gm-Gg: AfdE7cl9XYt3qzNfkxNQmbkDCfcXB9bgOmA8WF41f3mM47gmwW98PW2/G1WaGsod3ur
	C/oYO95owRBzeA/DF3jjmK7Cxuzu1rfuaIZkTkiEUPY33lg42BsAsOqShpMiYWWTH7rJYeVDaTD
	Yu9DhNxCvUsZKrU2+YufrstlEO3XYSXtoNQoJ8kVHV7MBqYe0jk0LTwSBZAOYMTbOq7dem+Ea4V
	uBGZkDquAU4bd5imF+0vjpQj9j8SKKndONHBw9QLxNdR8LQuuRvnMR6UWiazmTXOq9RiDdwVpNn
	eXKvsmbSwehZMssAdrXFwXp/UG85Bzlu0RZftan2V0vXi/CtREpIq7/AgjmT07O90GKTyNdJc0z
	KcX9GEF8fZpmgefeTx7w3tuT4TVXC7hdZOcFn6tkL4ghLKC8GzweD3HwJr+UpvD4M6PiLpXIB9N
	EuhQVyGV7XjTrGQc0KyQmCkIX/Ni17+H6R7drwEtuopOWtjaESSYcv5fBVknpMCdtoSjeR/XkXX
	fUj1qFFGSp+yrUf0yyiSbcqkEsyy4YIwbgD1Mqx+djyLZ3EUEb7lRxXCkHq+5Zvm3Utfe7R2Ikc
	Kde5Tgvsjw==
X-Received: by 2002:a05:600c:8518:b0:492:62d8:2da8 with SMTP id 5b1f17b1804b1-49266884adfmr9065665e9.29.1782364847711;
        Wed, 24 Jun 2026 22:20:47 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492660a32ddsm24966165e9.1.2026.06.24.22.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 22:20:47 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 25 Jun 2026 07:20:45 +0200
Subject: [PATCH 3/3] iio: light: al3320a: add missing REGMAP_I2C to Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-fix-al3xxx-kconfig-v1-3-d41cbc0c3cf4@gmail.com>
References: <20260625-fix-al3xxx-kconfig-v1-0-d41cbc0c3cf4@gmail.com>
In-Reply-To: <20260625-fix-al3xxx-kconfig-v1-0-d41cbc0c3cf4@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 David Heidelberg <david@ixit.cz>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782364844; l=704;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=oMGffqXvVB7R2bEw42xeETVE3hp9hgCzT3y/Cg8jnnU=;
 b=yqJuH/qJqJT/zJ1npJXMXIMxTuz5H5Sp61eL/EDjAZYw1uYtZO82MiAiUuuipzDWwQ5csDeoE
 kNtZZ7l7f1uAdiC6JP2bHRDrUVqOyfPm5VGJitm5p1rsGuO2NCevQAh
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The Kconfig entry for the al3320a is missing a `SELECT REGMAP_I2C`,
causing build failures.

Fixes: 1850e6ae7f91 ("iio: light: al3320a: Implement regmap support")
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 4ba3151ebea7..f23bbce12c72 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -67,6 +67,7 @@ config AL3010
 
 config AL3320A
 	tristate "AL3320A ambient light sensor"
+	select REGMAP_I2C
 	depends on I2C
 	help
 	  Say Y here if you want to build a driver for the Dyna Image AL3320A

-- 
2.54.0

