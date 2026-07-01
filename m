Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A06B33F8AD
	for <linux-iio@vger.kernel.org>; Wed,  1 Jul 2026 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782915458; cv=none; b=X0C4JNVppiZhZqVB62sKsCBate987jJdqf/xX9KTSKGJEqOTiNLUSbqXCHJzJkTAmLrY51GEHytJJqpDNzA6P3TAxLVS7eOoPhu6N5gdmXddt2dqEP6sTR04xKiUXW5/Io26MfWo1t47wIOvoQWCU3WmrJlswvvno0L2yW2Kq8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782915458; c=relaxed/simple;
	bh=JjQuJ+WAC4HyNOpJNX50DDwFBWBZkz8SWnUBsgssTIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LykEi43/6p/ilgW/hHFZHB/oICJulnQ8Y4xM/ma7fjnuhhHjjtbREKu8fl7q0uzh+QyIdAAmn3ckbDPVGKedKX0tzFNLYFru7DX56m5d7S9nq1v39uU1jC8C54DDWgtK7iKo8hH/vXCiA4CKZmX9KjqtrelLLJ27xqhCnNF/4cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=UpqciPM2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="UpqciPM2"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4938d5f86f3so5123155e9.1
        for <linux-iio@vger.kernel.org>; Wed, 01 Jul 2026 07:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782915450; x=1783520250; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KoOn6a9eFPu3j3lxjvRT84RKODlbnmxk6NgG22+hUT4=;
        b=UpqciPM241qKU7ikPwKLJP0lF6t1c9tADKmI/TNuA9ENSaLPunUZLymaIFoFiotdJ4
         w4ywjDafA1/iWGsiuESDhmlEJeUOoS6wfsA00mICku/taSVoLCzhQntJcuS8vF7vn4xp
         ClqV3KGp4kFACdoqm8alnED9y0L7Fq1xYgJtTGe0hN8jE73mXW/IxC1IdzLDmtXu9YFu
         p+1Mk6hvRIUSM/TcoPpPfWSapFAWIfCRrXaMObqyAZxvt2sMfYKAd0+KWIrpJovHVybY
         SmOredL+XplAFYjgSqY2zk3tw77tBHI5eKV9JejR724bRJ+K+16I8+I9dZCH2sNXZpzE
         8zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782915450; x=1783520250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KoOn6a9eFPu3j3lxjvRT84RKODlbnmxk6NgG22+hUT4=;
        b=ZXUWnu/vLsnJzayyBqN1+kh8Dzbm6e0SmFIxXCQrLwIMPTVupb1L9m2RO3ME3uaGpw
         LR/IvH/Xyo0cNUQykWqy8WaxkTnybEKm18bSyUbFaZUpmr4Pjt+Z1wO7m7FpOx1wUfdC
         5IWo4jxDwiEOc1mjrp/INlLYD128qo/+mo0UKsEejPJ+Ly6GoLJteELAUD+Tw9yfcCi9
         IigGKpCGqAl57eQiHlbit486GVfzleAdml8OKbqVaeqLXj6k/aHFwkqA1a2nxJadk5ts
         /Dh9RZlKjPpTwKVccKDu05SV9EyP2AuY1ntRC+D2afUzrEgVG7Njng2aa7oiipMS/zQq
         /msQ==
X-Forwarded-Encrypted: i=1; AFNElJ9L13JqGTs0mcqFiBCpGKI/ZtUp07ocjp2OHF/U8CYaVpXVevIvJobbFcRlf3NiRT7WkTpV1GW61pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnSkPmlHL9ftuf4kOE3jZ8tvkSie50wq0DDVhYz0d+Y0rs0df6
	EQl515EpY9QBSjU5nBp2/rT60wyZePzLA2HEjuvuH9yO+mFL++gsnXuaZYUSzPAeLG4=
X-Gm-Gg: AfdE7cmtRAUxU+Laxn1xW4wXYOjMg2QK5yrml9qBmr8ZlllbAopD/lcOmlF9zWcUruY
	Ur5RUWy0Pkt5wutNIN6nGNuiDJDsLqMOofLeHGIMELI2KnEjSZ+BTKtVL/C9tUm1DLH/r8uV/3r
	x9OzjWKvQAG85EQSpYCgKG3exwS0rspReJBvS1aaCczhKANDN6fMyYNJn5jCC87Y6DzqzTrDGeR
	urgM3UPhjWHKWqiFzkqJrvuxfbmF0atRTGMU+voYuFcbegNGIxJUIHGgY8xeW0mRQsvnR21n6Fy
	zSwkfEQe+3Xwband61KY+Cw3TxptrsSmtvjL5csp30k9rwyELmTUcWwAHL79DW8+YGud3MUwipk
	iHhYzfcyVsEd+W3aHNczTJ0xL7XaUSu0UAEo440c7QfIsLri3gf8TQCWhkg8fDqD0KwuRvNEMDB
	qF21HRaxrI0wVd4FpjjI3FiKzNzuUvYdmoMqKsjUBtjfXxAmtU0QOB
X-Received: by 2002:a05:600c:4f83:b0:493:c064:316f with SMTP id 5b1f17b1804b1-493c230bb07mr25432565e9.3.1782915450355;
        Wed, 01 Jul 2026 07:17:30 -0700 (PDT)
Received: from [192.168.0.2] (host93-7-32-195.dimensionesrl.eu. [195.32.7.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be81df2asm152552155e9.12.2026.07.01.07.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 07:17:29 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 01 Jul 2026 16:17:24 +0200
Subject: [PATCH v7 2/2] m68k: defconfig: update stmark2 defconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-wip-stmark2-dac-v7-2-ff8fdcc8010a@baylibre.com>
References: <20260701-wip-stmark2-dac-v7-0-ff8fdcc8010a@baylibre.com>
In-Reply-To: <20260701-wip-stmark2-dac-v7-0-ff8fdcc8010a@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
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

