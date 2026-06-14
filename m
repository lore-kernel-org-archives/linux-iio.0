Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8A73A783B
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781443152; cv=none; b=JYUASgtFcJPiU7ySoDvBTEDdi7LsVWGgVQH80vX6yy6xepiuL0RsGJ3DjLthlARCf2FyO4x05No2HMzyo0Az4oWJJlLk3j9DV1oPr6cZvXRoX1t+cfro0JLK+G0Q4boPyHH8LHtG/tUuarHoZeOyLVh43WEW1h+YG7SW/n7aFrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781443152; c=relaxed/simple;
	bh=7pcoUaqIRd/7j3LmuNYVsOcOH1ehLxEGYjvlDt6Bx2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RuIuVRwwGIRbNnpNUITR0dZ/mbJfA7Tf1b1srOBM7xOBY8DJ6FEjGWr/NUEtNzABdZvErTrAWp2Q9b1m0EFajvv6wAkTcAKQvcChAGKqx4BR6aMPgJKUCBv5eEB6UGSWcwUHc9wxwr0Mg7P/CeHU+m86NcmsbHHEar0OvOfXdHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GluRpHHs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GluRpHHs"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490aaeabdb4so15466765e9.1
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 06:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781443149; x=1782047949; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WdfgrerpcVKTn3TB1SrSHpbmiiM+gPn9P9q/mBiS4XU=;
        b=GluRpHHsg+SOrnN6zDgwOWGyRJ/Nv1pgyIoYHMXmhpZat5fWihgIxqFqN/qknkMBmN
         kNmsM0jVwIIjMKwqSmZqdIMyrorUr/LJNREZCCsKaiRKNcujI5qwss4etILj4DPRwrsJ
         sJfWbXUMv6pwJTILt1jSO35SDVYDN1nZfxVdbPS2VEW4m7/4bF8eiK6Wfb24bxRLLa8/
         EURbtE8IELupMccJHIkp32WaNkkAZS+kD6++q0/3Qb9qAFxVEtHcI1F+WbNMVJ33O9pP
         eivGi1xcQzvI4KhbhwoX8zjiFGOGq0lPZa+MdA+WSRH6qJKbQpao3k9vrGOKY6dFibmR
         DsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781443149; x=1782047949;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WdfgrerpcVKTn3TB1SrSHpbmiiM+gPn9P9q/mBiS4XU=;
        b=CnaUWP0lbV24Qfc9XL7jJIUALp8PbEtAm9V1INsQdVlIAICIaV7CwKUZ1UcM67DMQV
         Sh82Ce8t1+wy66rt0ThuTkLp0D3Mn1248m65uwrJyO7Kj6zu2zEf3A4B5hC1mIVWbDGD
         7tgBV+PO2yzZFwLWSeT8jyk1jw7BTlx5utSQQ4ULKcBQR0gV9jEvCBznoj27Gqj1X8aI
         +IWYpsaKJ62/evqX4YRuk8a/xTJTWc0Tf+DA2Zz6piOr3ax+JPzOY4/4Labx01wKwuw5
         yczaOeAtgPEFQA73NjoQnxNzS5c6BzIqPHb+KlkSjVR5JhJ/nqXsR3Trw1NWYc+9MlkK
         FNJQ==
X-Gm-Message-State: AOJu0Yynd2VvhscrZHIGhS2pYnwFW9F0LUQJolq6/6EBW1Gu2pVp4rAA
	bm2Rb43X2YeAGuJTiDuvZ6NDA0NN5ezderJ6X8O5FL7VLk69N8VpWQxU
X-Gm-Gg: Acq92OFJ7KyM5Cema5U2MtIQuCi4YWQPPOtjdH7XFPWyjp0csnXPj2ieYe27wjaPhtM
	7Tztg3Za/5PhRP7MRSYO6LllOyWHrNwecplXemdI9djwFB79vUxARPMpCpFTbpdWJSo2HjThhQj
	pJwd9IAHY+8Cdj3HixXSY+Q0WSzUbYpTBOIjHx01R8838NF/g8+Ijpy/zqHfuJJTYMXp19JzIw/
	Ls4jUmPm1x1dNWbPJidrU1bR6Fvc4+yh4YOKb4yxTbWEi8V00hzX/u7UkaGrBUQR2RwkyChBINY
	jpbvfSEKjPdhBLE380qdQJRVYpggKy7Bbk53eKZZ4uBrtome3ncJw+o1Ml7JaWESDlX3I0pGESv
	jE8NJdspssjL4N2eI4giM4fBBJMGaQY3S0hAPLwDeFR4mkcS/9BTKqsnnCFcartAy8Fu6ClN/pQ
	/QNGwd3ihCTS5Z6QIO1ycHOtzWea6yv/flwQoe2fODFNtq2fxXIapv0MT4aSFs3g630psiV3PCt
	PXBv+fo+7ykeTrQfKQjxtYArlmaWuNj9wZ2oc73JU7njheJQItOPCZCInS+nDNh5NTKNuVIZkWW
	/qAc5AqH++T3H9cmxVFy6rUNrsdzsT2UnWHPOfrAYH5qqntd9J4=
X-Received: by 2002:a05:600c:474f:b0:490:d946:47cf with SMTP id 5b1f17b1804b1-4922005e1c4mr80233405e9.4.1781443149473;
        Sun, 14 Jun 2026 06:19:09 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0:c287:187e:fb7a:66a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922037055csm168406355e9.13.2026.06.14.06.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:19:09 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 14 Jun 2026 15:19:07 +0200
Subject: [PATCH v6 5/8] iio: light: opt3001: localize for loop iterator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260614-opt3001-cleanup-v6-5-e3f5901dcc26@gmail.com>
References: <20260614-opt3001-cleanup-v6-0-e3f5901dcc26@gmail.com>
In-Reply-To: <20260614-opt3001-cleanup-v6-0-e3f5901dcc26@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Maxwell Doose <m32285159@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781443145; l=1056;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=7pcoUaqIRd/7j3LmuNYVsOcOH1ehLxEGYjvlDt6Bx2o=;
 b=gR5sr15YoI2Fa18WFnZYG1sNCWyo24fzb4lc0Nlb6GxIsjtc9poi7Xac/3Psa2YmJcU/xXlwA
 2xNx9NYQOxFDseHjCNfdfLcVNtKVkQc8wSVjSIMCve8hucvPij2oUKi
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Localize loop iterator to tighten scope and improve code style
per checkpatch.pl report.

No functional change.

Reviewed-by: Maxwell Doose <m32285159@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 7aee251386e9..80a2ede91272 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -226,8 +226,7 @@ static const struct opt3001_scale opt3002_scales[] = {
 static int opt3001_find_scale(const struct opt3001 *opt, int val, int val2,
 			      u8 *exponent)
 {
-	int i;
-	for (i = 0; i < ARRAY_SIZE(*opt->chip_info->scales); i++) {
+	for (unsigned int i = 0; i < ARRAY_SIZE(*opt->chip_info->scales); i++) {
 		const struct opt3001_scale *scale = &(*opt->chip_info->scales)[i];
 		/*
 		 * Compare the integer and micro parts to determine value scale.

-- 
2.54.0

