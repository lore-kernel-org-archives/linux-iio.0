Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9CB3C2763
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837823; cv=none; b=OliCoO+2KVwc6aB/a9fetQrHNPTSKE0vGtnF2mOBwSGxjW6vHNoUI1+tqwWYpm8hw02BaZSOsf0dzkN/zGYMm5WlAyX9a+dCq4lw6jjbP6ps2gco79cK0VlXghgsMGWrpXgjjy+KL7Wb/WLrDGWMGk2NEJTTYIFTXVhRQh1tNFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837823; c=relaxed/simple;
	bh=mxyFmPwNypnb/i1vvxXGnnPTZWNSDKGqY59IT8MU9IU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sieEidHETeMnLfSBbA+meO+HwnGcp56p+ALGCcMJs6l38e7a4+ZyWcw/1o8mabk2Kgf8PsyBeBsbUavwbPxxUZpQI9FzGerM/YEIsO8GMTI7mwJeC77rHdbpP7V8sWYgp5/e+ITBn6iIWvlfRw7C4mwjr2RmnwLMZiACF4qXwy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBSnat+q; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBSnat+q"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79827d28fc4so23850987b3.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 09:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775837821; x=1776442621; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q34ZECdqnWZTzC8ru2SL9aBOUfVgsn1mbx9InWC6dPY=;
        b=OBSnat+qpmgp4JbLfKmkJafLt/inQ0uo+8941lAnJ0c3hrzvyo7jlcR4gKUa/BFCiD
         Dg2lWZvLD8zypaGOx8eDprWdY+iQdbpwnZjEyMrj3UJizHXk3fqiF1tseq2Q3WIi788B
         kyjAdAurVKcS6AiBmA7zsvFNm95zDIDPuS3A2v5xzzU+xhkD6O7Dn1aqcaNdeEX/hp1o
         PJswKt2hV3XLn1W0xdsnZNYst4uTkOb3Uh+MeTLedXAa4WIUlHTUuSM4EP/UUu2yvEqZ
         fLQat6/2e/zvKwEs1/6JY9+3cUhZMiNLDtv18HymO84qStPGSf5zbFWXYa2e9fzPh+q7
         p6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775837821; x=1776442621;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q34ZECdqnWZTzC8ru2SL9aBOUfVgsn1mbx9InWC6dPY=;
        b=l0ohavgEX2kgj1irI59QEAyUlreewVAPgMHPVmnbu9Jqa/oSNW19r2PH8PO1FuQm6/
         r8h2h3O9URa/msgowJD+ZMIXcMhkSAWvPDtlgo3kzYdkvkd8ZEOG83nu71qYbFpwYdur
         dczJojlcyJgPwqGEUlvlz1rVKRFAaQKQ6Mrzy7LmdF/egko0nZ35E1eYvfcE/xK93vFL
         S1zowOlxmNi4lMWot1a2tZR4noqgWDfgJMP1UBKnd5yBkN7VZphj/FBDQAl1fzgNP918
         SfQahxkwoIFiTQECyjk2jS5VflMrcg3HOmZ1cC8Y5rH2wxfa0X4SQptupdPaiGl7pfpl
         qQ1g==
X-Gm-Message-State: AOJu0YzglS/SVmBuQKY00d8ppY85niPdnSu0Pwe/L18JRAdK9kCkgfTv
	yrwQcTIlrpME62YNdEZ2yRj+aCxxNEMdhVNJlfsipe8QVy0ivjZYdaFs
X-Gm-Gg: AeBDieuloyddcTIbwBwMPrgi1jYl0bYHA5dsS9OBGPYIjdHe3btLN9ZWPjAMkmZiqOB
	ISshaaQ68wY1q6YA6rpfdrchIhceEKFBQDCBHvf2AAo3NuAMWkTfJ2K+iLid+iK6GdUcBodGXNq
	4RuoBOvKzHBrRgE71RcwjajL38VHm1Ul+VNa5mmP458zqfSaUyV3qvx7PMZwArE14GDlsklm5BZ
	WicU9GiWmgBDjhI59VLGbh1XW+DWBz9/JBn3ygo3ILzAIp+y6j9UXks1LBjCTc4QTfleT9rkjG0
	24Q+5FsotJoDVxc3ZSZpuOhdfvMb6JCHWffWmzyo+HA+pqAjEj6EJpbEIbncQ0ppJwrhFv26e7D
	Vt3FkloOrAYJtEHZPtgq7hrF7rBXQHKRg6MJ/rJrlux6126h8ZC5BxZ3TRpXZbN0Gr1RuADkEKe
	kRg39JjAJFOo2HxC9OSBVTpjvm4mCJLZMxWSxM
X-Received: by 2002:a05:690c:c511:b0:79d:dce:587d with SMTP id 00721157ae682-7af71281871mr43549567b3.30.1775837821421;
        Fri, 10 Apr 2026 09:17:01 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa05b48sm15408337b3.33.2026.04.10.09.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 09:17:00 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Fri, 10 Apr 2026 19:11:19 +0300
Subject: [PATCH v3 3/6] iio: light: vcnl4000: move device tree entries into
 one line
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-vcnl4000-drop-enum-v3-3-2ea2bc6f5dfb@gmail.com>
References: <20260410-vcnl4000-drop-enum-v3-0-2ea2bc6f5dfb@gmail.com>
In-Reply-To: <20260410-vcnl4000-drop-enum-v3-0-2ea2bc6f5dfb@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.15.1

Make device tree entries one line each to save space and LOC.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index cbe0a9e056ec..bbb84b71f226 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -2058,35 +2058,14 @@ static int vcnl4000_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id vcnl_4000_of_match[] = {
-	{
-		.compatible = "capella,cm36672p",
-		.data = &cm36672p_spec,
-	},
+	{ .compatible = "capella,cm36672p", .data = &cm36672p_spec, },
 	/* Capella CM36686 is fully compatible with Vishay VCNL4040 */
-	{
-		.compatible = "capella,cm36686",
-		.data = &vcnl4040_spec,
-	},
-	{
-		.compatible = "vishay,vcnl4000",
-		.data = &vcnl4000_spec,
-	},
-	{
-		.compatible = "vishay,vcnl4010",
-		.data = &vcnl4010_spec,
-	},
-	{
-		.compatible = "vishay,vcnl4020",
-		.data = &vcnl4010_spec,
-	},
-	{
-		.compatible = "vishay,vcnl4040",
-		.data = &vcnl4040_spec,
-	},
-	{
-		.compatible = "vishay,vcnl4200",
-		.data = &vcnl4200_spec,
-	},
+	{ .compatible = "capella,cm36686", .data = &vcnl4040_spec, },
+	{ .compatible = "vishay,vcnl4000", .data = &vcnl4000_spec, },
+	{ .compatible = "vishay,vcnl4010", .data = &vcnl4010_spec, },
+	{ .compatible = "vishay,vcnl4020", .data = &vcnl4010_spec, },
+	{ .compatible = "vishay,vcnl4040", .data = &vcnl4040_spec, },
+	{ .compatible = "vishay,vcnl4200", .data = &vcnl4200_spec, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, vcnl_4000_of_match);

-- 
2.53.0

