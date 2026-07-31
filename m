Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C54374735;
	Fri, 31 Jul 2026 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528114; cv=none; b=JXyriZLpxc7+XaaIdv9O0U/v5ZhUiygpirwvdI3hmG9TxOkfAxOYLbs85EPOXGoXTWVn4g/hTfrD+65ZFuwLursx5TwDCrFmGSH+Q2VAaNKJnvtmcsMatjfWPyt9HbE4NEA/eyDN6fghUjn5GkGxXGp0pDfpSO27SHjw3ACTw8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528114; c=relaxed/simple;
	bh=6wI+mOZ03CkSvZCM+53RJSLLsG4UFvAUoJZgcw9/Qgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZJDRZUi8XEBgVuf3E0dx9L6/YsFaoh+hp37AqLhZO3JvnxUKBwXQSF8UAf9CzhRqM8MXQWyA+2CNFoCw0wkDZWaCcFRNEy+T5fmx1CADfJLWeYaNLlFqQjQvx/Y0zFOXY0FD5zg+5r1OoSokoWDbVD3MPkHcY+rmj5qPpedze0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=g5yT0HTl; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="g5yT0HTl"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B567542B9A;
	Fri, 31 Jul 2026 21:53:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1785527618; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=KkGbmdD+W+9yFhdjVY2AD0OrffAvSw2aWIDzcq2xPM0=;
	b=g5yT0HTlpwLRno7Jlfr8H5kkYR3G1o//aT07lVKGEWDoTCt6WscVdwcEbStV35ZfaG5qci
	pKMtwwAGFDh1OfoDTerM1zc4ZWpC+Hx91wMEydFjN+PCNUy0DuPaAxZZHBvQed9oaJMc7y
	MX/1KF4em1c0NuRgoXKmAOzzE4zrCQxMS4r9s0MH+7WNbSt8rKH3vowL83UtoRB7ZRxkuH
	cgEGODjHFD+IygpaVlxTYKIgiD5KgRh5tYVqbVqGV3Z9c/ipKwdyrmc0Ui8J3FZHv/irqA
	tjEASUSJtvYr/FRFbCa+jurXHZZA7bBcEXMCIwvz6tfTVJCp/DKinq8IbqJD0A==
From: Philip Mueller <philm@manjaro.org>
To: Thierry Reding <thierry.reding@gmail.com>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] iio: imu: bmi270: fix typo found in dc757dc
Date: Fri, 31 Jul 2026 21:53:25 +0200
Message-ID: <20260731195325.44453-5-philm@manjaro.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731195325.44453-1-philm@manjaro.org>
References: <20260731195325.44453-1-philm@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Fixes a typo found in dc757dc.

Fixes: dc757dc1572d ("iio: imu: bmi270: Match PNP ID found on newer GPD firmware")
Cc: stable@vger.kernel.org # 6.18+
Signed-off-by: Philip Mueller <philm@manjaro.org>
---
 drivers/iio/imu/bmi270/bmi270_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
index 839e71b65f05..9bdd4d7a821f 100644
--- a/drivers/iio/imu/bmi270/bmi270_i2c.c
+++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
@@ -42,7 +42,7 @@ static const struct acpi_device_id bmi270_acpi_match[] = {
 	/* GPD Win Mini, Aya Neo AIR Pro, OXP Mini Pro, etc. */
 	{ "BMI0160",  (kernel_ulong_t)&bmi260_chip_info },
 	{ "BOSC0160", (kernel_ulong_t)&bmi260_chip_info },
-	/* GPD Win Max 2 2023(sincice BIOS v0.40), etc. */
+	/* GPD Win Max 2 2023 (since BIOS v0.40), etc. */
 	{ "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },
 	/* OrangePi Neo 2026 (since BIOS BCPH01_V1.20), etc. */
 	{ "BOSC0260", (kernel_ulong_t)&bmi260_chip_info },
-- 
2.55.0

