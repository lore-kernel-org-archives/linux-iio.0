Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD583E1725
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 08:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178427; cv=none; b=fcu7HVog9NMagz/bkeDutuE7gAmk/Tc7yYqNON1GxY5Cpg6rMYw9xlzlzbZyoMqy3Lf51h7nXt5vMEX1DDHebQa6uYW7GHK1IhtGxddtJdg25eb7AnI0M0Peq52SmAzSGcQOqaSzszZedawaCKXcT2a7yYOkrYmnUgD/m2tf5yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178427; c=relaxed/simple;
	bh=755YHSNB020xn/WL9Uaf35pqykrGOszYXTBeJvFREJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=egE8IOdhsYn6UHqyF9f+K9ad7pTlpO8evqAhBlywX4JXNmGE4suwVJk/rC/6ngRFbXXvmq3LuBgt6uhqT9J00K7QDgEoTe0CsIfRWbHPCxw2T30nFmttybbebv/+ENwvNFVc2OrnxRP0dlsKdvj3F8Q1pE0mQz19hdAkojfgs7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=J14ErDiz; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="J14ErDiz"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d73422431so2175785f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 01:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779178425; x=1779783225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+C9WQL1Cl4N940J9CJLlBz+Cm3toA5nD1kOJtDKP94=;
        b=J14ErDizLTT16hSbkhI6rRKjQNuOqkuEh3bvBgYTZMyz2mf3agSaM34nl4UfgrUG95
         PjgjA2mE9FcUgf/MssAXtD2cRDUQFlsnTCBavFAHZ7S3t8l7gjCiLSqtGA3yZCocryQt
         Zq9lKXNK/9nVZP0Es3B7Nk9NeBDnLb6n3rl+MfuSvFV4gPe7+dfFMxeupK80Lwa/glZx
         IJuh3sGH00vd8UCUXOxN86bSaApiIFK+OJFlfX3L0MBk/FwP/P23hSGOZNNsDson035T
         WJnLSNsn88+iTQ5hyIJOSQE+sgctUHIhDUA1T47J0eo7LAwA2OBJ7sLPWa5AFtBT0Yh4
         hZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779178425; x=1779783225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H+C9WQL1Cl4N940J9CJLlBz+Cm3toA5nD1kOJtDKP94=;
        b=KdSdOJs2o7ZmDH6FCXQ894qTTP3mtcP9IdmC5mIWlXrmPGt1IJreEeNnbwSfHqC2n9
         ktBt8JnoX8a6xREfpGHNtGP4tGrq8OpCl2ZTqjTJQ/tOAASrAVjEu4kqtBh7rHn8V0iG
         MacqXSjmzPm9nCXP1NiTRuhjcC3rdSSuggCJPphgXD1mz2w8wNe6PIfYcJtCgAILgBdU
         Ngdl61RIjh7YaYFCBBH43wPwg6SDa0LF1XYIly3bNbGha13GpZIefAzaorubt2CH2OgS
         jLfZc17ZE1MXnBX9sExBsmiuJonoHHx3GTPZulbEyMju7knkr491+Q4TzN92lCVT/d3+
         4PUw==
X-Forwarded-Encrypted: i=1; AFNElJ/r0fA22hn1ewYNQjzBy5F2CMEJmIOAn1A8Yv0gA/tY3kbtRqRvxbzTwlJ9Ew/h4EWbxfkY2InDUnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwopuEz5C9vg4sMlhTdMi3lGp0zEnCXCgDX3IYUuwoB0fQ/Z8jY
	iP/i3s5XdqlIapmqOrq/IxbG/4kBRQ7VCOe4UWBZUwt5To7kiBsV98Jr5AEyi2Isk6c=
X-Gm-Gg: Acq92OGEUGOpDkWrdjxBNVOlIu8Zy8OEUYmu/GJXnBgp+QPQj02Z8ov9U7aZkIOd39j
	u4UoQBbBb60YbMHgK6WMM7CLnEfRAGRVjljkjOgXoSidPhZkW5BFHvK5pa9LAnRgDpSxCUkT/a1
	fIXz8WUE/sC5jz6o/upwEHdOc/WTaVLzUVVQ8h6yf3nHYy5c4wCBDjYWbxmOCtCVaqYUxCTbSBJ
	jXOr8Ya6xiySw+p9flUFLUa5lswd5dEnnYd8fqsSFctStn5GVdii5israhWiYRdLePT2qaAzyoc
	ytDXkltnkxnvlqvuJc0h4kNaOZaPlOH8H9OPRCNMgdoxhyI4ISX7b9EQWkTek4FY0nzpUQMQdPv
	IkXZQp2DpX6B5tKj3bv6icC6d2VBiLVDBVDDI6Rff+zc44NBhTVShL5srqXe4QH3F4CHvA63C6p
	0RTxYymZb0OTWtKL7uidf0sTk6fg2cE4HQhL058z42V+Sf6FMHuPqvnW1sYDhdmK8yxsjFuLP4M
	mLeAMz9EPBRqQk=
X-Received: by 2002:a05:6000:24c5:b0:45b:d2ff:4d4f with SMTP id ffacd0b85a97d-45e5c612fa3mr29818659f8f.40.1779178424685;
        Tue, 19 May 2026 01:13:44 -0700 (PDT)
Received: from localhost (p200300f65f47db0428dec7b135f55767.dip0.t-ipconnect.de. [2003:f6:5f47:db04:28de:c7b1:35f5:5767])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45da0a19a0csm41776596f8f.20.2026.05.19.01.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:13:44 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] iio: proximity: sx9360: Drop unused driver data
Date: Tue, 19 May 2026 10:13:08 +0200
Message-ID:  <871db08b55e227d60299f48726cca5eb81662c73.1779136001.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779136001.git.u.kleine-koenig@baylibre.com>
References: <cover.1779136001.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1405; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=755YHSNB020xn/WL9Uaf35pqykrGOszYXTBeJvFREJ8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqDBunEQ/lULJjls61FRfbzTz2U57ATEN5oiKTW sUhgUM0NrCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagwbpwAKCRCPgPtYfRL+ TgC6B/0T+P/pRjS6as2IY9TO7B9zVD2sD0D83otDXwB7Da5QVDfxFzKx239BqY4kHwEZL/n9D8a qaee4ULmawRzMs2EWaokOyc36cIstgqdTL4vLao8p2KDHpE+TJ+oPzbW9NrFefcpX3EtZxpREvr v1gwyH8fTa1xZ63x6RdijRqQ6eqFP8dpM7w1oE5tqg0IGR2alcwZHw2vFf3rXKiOahmGdxHSENa rPHyu8Fp1xk/0+Y/bPQgCZilfV7WMMZi9bjVdB3m15/sqgr3waCMemrock9J/gDgb4D4Zj3SDCy iNlrSFFi6XsFAqKAIL0NJyPj0sOuiwR3vE24cRdKd43Vliq5
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The value assigned in the three device_id entries (ACPI, of and i2c) are
unused, directly in the driver and also the sx_common support lib. Drop
them and while touching these arrays, convert to named initializers.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/iio/proximity/sx9360.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 4448988d4e7e..4b9498022b22 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -832,20 +832,20 @@ static int sx9360_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(sx9360_pm_ops, sx9360_suspend, sx9360_resume);
 
 static const struct acpi_device_id sx9360_acpi_match[] = {
-	{ "STH9360", SX9360_WHOAMI_VALUE },
-	{ "SAMM0208", SX9360_WHOAMI_VALUE },
+	{ .id = "STH9360" },
+	{ .id = "SAMM0208" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, sx9360_acpi_match);
 
 static const struct of_device_id sx9360_of_match[] = {
-	{ .compatible = "semtech,sx9360", (void *)SX9360_WHOAMI_VALUE },
+	{ .compatible = "semtech,sx9360" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sx9360_of_match);
 
 static const struct i2c_device_id sx9360_id[] = {
-	{"sx9360", SX9360_WHOAMI_VALUE },
+	{ .name = "sx9360" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sx9360_id);
-- 
2.47.3

