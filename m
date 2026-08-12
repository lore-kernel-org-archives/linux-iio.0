Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE6846EC73
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553096; cv=none; b=Xwsit8ndxI1PCRmGGtEcXDLuyXYyKNpTOFWM8Z5PP7cc9yXt0SvfVB788wh2BPQ1BjHEh5I6JQEPV4uCPBSnMj6O4KOPsksQ6Vio04i/LbCXMC9q4dgMpmLD5YEQGSIkavs8abniLxvXz6h6APZi82+fdNBc03NcOWbsqbHjFWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553096; c=relaxed/simple;
	bh=KqU7hUX6EEnvGvvXp6tf05FdZonTZfQ28JEGxpEGpyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nK2s5ihFxDJNOQzVFXn9903JXatIikpHmBqIdJ9EDn08JLJlngOjiF/4FLAl2zMxx7+2GSnWzviTgQ6dGLmIwDSHMJN6t0jJdvy6UYDgWN3HCn0Dn+X8+2j6ATAvXCjf6jehuFV18FkrI+BCCezII12iqkPgZXViU2aUsAMqivE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcBPDYcn; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcBPDYcn"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so1065037a12.0
        for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 09:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786553094; x=1787157894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nAYjNEgUAHuckjfKebSgoAzLO2c7KwVpNw4ZzJakepY=;
        b=DcBPDYcndhL1YJyNEYXf13gUmOR2fHQalnG+42YPHE6qJJ58UrVAvMUG563f4UqMUB
         zCbqL03ki1Gn9c9JWzOAOmsVS3rlbY2cIUtEr2LIn1Gs/tVDGALvVWZZ4Tbg0McDnvVm
         3Cg4tAy2jBtfjmWdpLkRimxE/yIRynCOHUPTDc+HdOC9Tu2/LO15Cy5Cap61y0Bs/m7c
         sTKLYQNJrI1NPkOHIvgL1M/cFCc2bZKI7JWnSJ0eoPenx8/w1hifng+w+fpdDoxyUMz/
         erH6hYvJ3pwBUtO74k6ldEfeCbzbIsbWFaGgd99py41FRVJNRjgQxMDDo6mY9pD35NO5
         lPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786553094; x=1787157894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nAYjNEgUAHuckjfKebSgoAzLO2c7KwVpNw4ZzJakepY=;
        b=N2zTLtJpO35BSGAXgbwwQ1UlsMnBA3qfxryigEw/4T+RWs3nUlw8DjizmrbB7poWFr
         I9cb+d1NfS8HBIrzr9HtQnVwCsl+yIXsFZSOBoatlpCS6XdpNnLeL7xXHDyHjUTDbIPI
         R5J3JUAFeJ4uisz3ONG400g0TCYDWA+W1NAWO9c1Ds0RynTbJTOWkqzCNuWfL4DU0Ade
         fQTiAwvYxrgcy6gXIrxYOORGhNDAOtFXFViBsMoP19ducnjPOR1OEbo8Gd4iGtHMceao
         4rg/ruA/kw85NWPkpApHUNb68ZpuC5t78c/vGtncJkXfCeVhvsYhsIpSODCe9fennylj
         O2bg==
X-Forwarded-Encrypted: i=1; AHgh+RoveFYTLvVAb36j4or6o+MvvhcI6r2h9dH/Ri5WUkI5GJ/EvSId+26gT6RKHO4Zg1gTStvTSmx9L/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTGyoPyVxtTSkfme3wDvLfDYvrpu8jq7V73+DFtO9NrXPS/v7Y
	kfG/F7zCjnPAhLOfeDbv6e3xO460JRGE2SJKDO8rEpGNVJAonZuyeTr0
X-Gm-Gg: AR+sD10QUAi+rLvHbNKwKXT0gR/1uqTZVcxD38de18r/n/HcEMjiGD97coLADutE9Do
	7MNzmZBRnyIrbf7Xm68cDQSeE47MGnKIJOvkhF9TmWs+IAiAQo28cMrOwIk/bvR6Voa6HV3jq4R
	0AJtFbsCNq19gvG+o0B2vXqvbAcYzUH3ZI/ZzOmnwj6u//us0aH/jRuDJNPzB2PQssC84jJ4S+9
	CoGCWOAcoWYw8IGcucpnvpomrYMqE964TkMVDrbtt+3AJy+O5C2EQCeGxFTFXp7xJA0MXiPgRnb
	H7ee64Hx0q+kImz+SSY4Xj8V6c8P45jTktiqZZE0XtZpPLJVsVPW5pxmNfF5ZeJ+VygbPzSUbRh
	Ydy6EqaonB5wfvhKW+Wwk+cqlXp/Zqi3Qk4SHGjZ/B883EiLMpScd1X6KxlchAoHP0UrXyedzjV
	p1PGIYGKzfs119zzctczyesJX+25IDJtE/6OedxhVi3BGFl/a0hLkwvNyFHhQUAK86v3+W17c1P
	Ur//lkelCTQiOD0eGiRnoTf3Y+tue1YPe8=
X-Received: by 2002:a05:6a20:a10c:b0:3c4:397a:69aa with SMTP id adf61e73a8af0-3cc3f764199mr6486915637.31.1786553093808;
        Wed, 12 Aug 2026 09:44:53 -0700 (PDT)
Received: from debian.ari ([47.30.26.35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf40f7151sm12462621eec.12.2026.08.12.09.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:44:53 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v3 1/8] iio: adc: ti-ads1015: use DEFINE_RUNTIME_DEV_PM_OPS()
Date: Wed, 12 Aug 2026 22:14:26 +0530
Message-Id: <20260812164433.23011-2-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260812164433.23011-1-architanant5@gmail.com>
References: <20260812164433.23011-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated SET_RUNTIME_PM_OPS() with the modern
DEFINE_RUNTIME_DEV_PM_OPS() macro. This allows for the removal of the
macro automatically handles dropping unused functions when PM is
disabled.

Update the driver struct to use pm_ptr() to avoid unused variable
warnings.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 8a272af69f7d..9cd620b71429 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -1066,7 +1066,6 @@ static void ads1015_remove(struct i2c_client *client)
 			 ERR_PTR(ret));
 }
 
-#ifdef CONFIG_PM
 static int ads1015_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -1087,12 +1086,11 @@ static int ads1015_runtime_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-static const struct dev_pm_ops ads1015_pm_ops = {
-	SET_RUNTIME_PM_OPS(ads1015_runtime_suspend,
-			   ads1015_runtime_resume, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(ads1015_pm_ops,
+				 ads1015_runtime_suspend,
+				 ads1015_runtime_resume,
+				 NULL);
 
 static const struct ads1015_chip_data ads1015_data = {
 	.channels	= ads1015_channels,
@@ -1147,7 +1145,7 @@ static struct i2c_driver ads1015_driver = {
 	.driver = {
 		.name = ADS1015_DRV_NAME,
 		.of_match_table = ads1015_of_match,
-		.pm = &ads1015_pm_ops,
+		.pm = pm_ptr(&ads1015_pm_ops),
 	},
 	.probe		= ads1015_probe,
 	.remove		= ads1015_remove,
-- 
2.39.5

