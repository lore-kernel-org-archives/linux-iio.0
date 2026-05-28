Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193853B7746
	for <linux-iio@vger.kernel.org>; Thu, 28 May 2026 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779963420; cv=none; b=bqhC8kbVn8z+q3XtkifNCbU+6mrVSJcxY2MG2t56TlbiMuGBVGpn7UpRRyARvaazzUQcnrdtEemTeeKqOsmdSr2Crfpm0vPACLj28sUJ2ld6RNldNbf25kJzUVk+j9vWxGeYv5emP9CZG10hn1hRq4IlF/OeveDMIapOW6z67no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779963420; c=relaxed/simple;
	bh=x4stweEjQxppyPVctumRNhEzYCy0dzoef5jpr4KI7/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KR0Iqd6CjGaPoncEWZAUCGT5U2Pgdmh4EoHGgiNXD7bkgmS4NrPDwPXEFs5n67nohSTyKYQnCzRtB+v/y3zV0VtLtxdtzKiD3B6vhllqnOB2FO2Ewr1gLV0fWGGOp2kXKmMCNH8Wofqtrc594o+gkOwLYD1riDOyDi3V3ei810c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=o/jqGtAj; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="o/jqGtAj"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d7645adbdso7685606f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 28 May 2026 03:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779963416; x=1780568216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1DoSbZfG7H4Ei1TfdvUW7X/sPaGi5bqrJwAmd5q/gRM=;
        b=o/jqGtAjvU0tnRnr5DuDCxJYLxPkiCB8uDsioXQBJKmPlmgD8sYjGYPx2yZVUyBBv0
         PTWdXpJtFT93FiTJK9ce1+nKpY258zOsRzI6lPBSjZ4cQGYEinT99HpZbANi9/Tv1XD3
         Tzvrl3wrPIUHz8/6TneVJL3PddkLp2bXoNgFc19veO/DdwzHvmAB538CyZ535Jk8Rv6D
         YyYklst+ZJrcO68KwDeIhp9bGsfdG+kx8Nz4DSJr2yAMaqpfZOW3bzHk99XxSggNBblr
         JyCZQuV1uGRQ6FeSa7chdZV5bRr0cgcnd/vn9bTAhQeUOul+vtbqLnul4fIKu/4VevfR
         +0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779963416; x=1780568216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DoSbZfG7H4Ei1TfdvUW7X/sPaGi5bqrJwAmd5q/gRM=;
        b=Og+SCr1s8YKNBz6pnO7lN9GNBuqca3j8zEKPNI9OVovQ1Ku+SGjpdEDxb3/d2x4Vvl
         27h7OCYDr9fKS7CtaPGMx3IjGJ9s8P9z0jLNolIqRe/pnxh+BoDQQc6Tmh7AVcQoXRUs
         /0O891qZl4So0fQ4jPu2u2VU39mh3IACbgxmPIZO0oCIavFdwrxhfvIyRdnYU8qVt0wG
         a9rXyJ/MIUPxjh7l3R0/F3Z7FiZYdNgHvWoZmhWSJa3dKj0wTgMyxo1HarWR/sRYWbbd
         zez0yI7VcXr6FHQ/KnJfu/xJIbxH4g3IH9TtJBfNTZBCJLnUzXFOxh23bbskxgs8Yu0x
         nJLw==
X-Forwarded-Encrypted: i=1; AFNElJ+jWoXO7yBFh0kFkVCdTyGAEZhRC1Gry+yBKTncZs/KlOfrMmbEk6boK1fQis4Wksl1QFwMRlVQT04=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK69Htlr2EvO3jTSux7nlaZ335SWCdqKw90qaVhEZsuD8iCALt
	nnWZBN4HExrisHX4K+Ei+/r0T5Z0lkmigwcqpNVxbub4jD/Rxpq9HXWNe0Deeh860KU=
X-Gm-Gg: Acq92OG+gn8P6xKov5r+fckCEMLPuoFTekn5O+yAOauveO9WbTn0wDgNCwnLjPpCIZF
	UE4mc0Lb8GvQqb8tOMxVFaC8DwFM3uTdDhav0WwR6pomNdu+s8rkC88MGK7Rxesvm9KGIFQd5cL
	UmipqEThsoBZLnwkSabltHg4Pei23VZqRxNdx1U9KiomfltAdUvegtlPAEWJUexps4hNFqtaTxP
	G69QtbJwFJ0UISISCWfWaXJ1hVJtPw+hHnLXIfvwNdsoD+QGWZuvMijd2uUMEJZw8LBtWZroo+B
	VxPAhPPazNbIvaBeNCZrZ3pk6Enb7+fvTnhPVdjPgpKj6hoQwkiCsOHdvUuFC5Fwp8KwZjDOoeT
	wUhQ6rpADDLo4ajbAcOhWXbK4BX8+XuQ5i5RMCGIwUDHYaA8UnxBec44vmeFOx6/L49F3WNCVwh
	Lo95LddfNmQ9jGoN0rGc0gZho4U7zhobcQtAI5lQn1elssX19rAWzKDaQ44Wp0afGb4gpITh771
	gTlzK8MoyTa4UjXofz+BZAN0hW3bEhYeYHg
X-Received: by 2002:a05:600c:3106:b0:490:6889:1ff with SMTP id 5b1f17b1804b1-4906889025dmr231608125e9.28.1779963415894;
        Thu, 28 May 2026 03:16:55 -0700 (PDT)
Received: from localhost (p200300f65f47db04e95e43453a0d1648.dip0.t-ipconnect.de. [2003:f6:5f47:db04:e95e:4345:3a0d:1648])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4908d80952asm20830595e9.1.2026.05.28.03.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 03:16:55 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>
Cc: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v1] iio: Use named initializers for platform_device_id arrays
Date: Thu, 28 May 2026 12:16:49 +0200
Message-ID:  <1a45a4aade700448d7b1c702210ff147aaf21f90.1779962510.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2568; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=x4stweEjQxppyPVctumRNhEzYCy0dzoef5jpr4KI7/o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqGBYRW94t166W07+K+D6+FcH6eSGvxuhaoJ2PR jJmgidiFGqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahgWEQAKCRCPgPtYfRL+ TgmuB/952mpqmszKxSoYMJ8I4cWrjlwjrB7qfIwSgQaQkvnSUjb6aWlmZNN8GZo1gMcb5kwBg6K CIr/lBH/Pbw7F/J1tbO6DzhopmzjPfaU7tNxCBVzI8AhjcWIoVRQr74VA05XBWypHMwdWAfZBq8 7Bv3NpBGkBlfF9k46ASmTqbJi/Xli3p98O7afScfz6+LCv8Y4I4NiiG0uZxbPdAx4uo9/U0IEtk mOK9grOwXEJ3pNU23HedR7bDSjgo25VwZJ6FZmDNBCTeZxyuHQE0ZbYeii642Fc8Qmt9v+xKtDE 3Z4RPVUP1LmbsrUEu2CtnUGG+22YwlA/HIGTnhJ5x82D0AIO
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Named initializers are better readable and more robust to changes of the
struct definition. This robustness is relevant for a planned change to
struct platform_device_id replacing .driver_data by an anonymous union.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

I recently sent a similar patch for i2c_device_id arrays. This is the
respective change for platform_device_ids.

Best regards
Uwe

 drivers/iio/adc/88pm886-gpadc.c   | 2 +-
 drivers/iio/adc/max77541-adc.c    | 2 +-
 drivers/iio/adc/sun4i-gpadc-iio.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/88pm886-gpadc.c b/drivers/iio/adc/88pm886-gpadc.c
index cffe35136685..4435f3d5e2b8 100644
--- a/drivers/iio/adc/88pm886-gpadc.c
+++ b/drivers/iio/adc/88pm886-gpadc.c
@@ -373,7 +373,7 @@ static DEFINE_RUNTIME_DEV_PM_OPS(pm886_gpadc_pm_ops,
 				 pm886_gpadc_runtime_resume, NULL);
 
 static const struct platform_device_id pm886_gpadc_id[] = {
-	{ "88pm886-gpadc" },
+	{ .name = "88pm886-gpadc" },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, pm886_gpadc_id);
diff --git a/drivers/iio/adc/max77541-adc.c b/drivers/iio/adc/max77541-adc.c
index 0aa04d143ad4..013da014bccd 100644
--- a/drivers/iio/adc/max77541-adc.c
+++ b/drivers/iio/adc/max77541-adc.c
@@ -175,7 +175,7 @@ static int max77541_adc_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id max77541_adc_platform_id[] = {
-	{ "max77541-adc" },
+	{ .name = "max77541-adc" },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, max77541_adc_platform_id);
diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 479115ea50bf..203459ca9907 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -679,9 +679,9 @@ static void sun4i_gpadc_remove(struct platform_device *pdev)
 }
 
 static const struct platform_device_id sun4i_gpadc_id[] = {
-	{ "sun4i-a10-gpadc-iio", (kernel_ulong_t)&sun4i_gpadc_data },
-	{ "sun5i-a13-gpadc-iio", (kernel_ulong_t)&sun5i_gpadc_data },
-	{ "sun6i-a31-gpadc-iio", (kernel_ulong_t)&sun6i_gpadc_data },
+	{ .name = "sun4i-a10-gpadc-iio", .driver_data = (kernel_ulong_t)&sun4i_gpadc_data },
+	{ .name = "sun5i-a13-gpadc-iio", .driver_data = (kernel_ulong_t)&sun5i_gpadc_data },
+	{ .name = "sun6i-a31-gpadc-iio", .driver_data = (kernel_ulong_t)&sun6i_gpadc_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, sun4i_gpadc_id);

base-commit: e7d700e14934e68f86338c5610cf2ae76798b663
-- 
2.47.3

