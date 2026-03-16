Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146663CFF77
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773682098; cv=none; b=EpAOJQwgoZAwpnRhN+rN8/KePtXCJQM2DMzczhQ/2ASi2A+/HNqrlLQ5vn1ArRkWeoqKDFNtGnysKJLbS3OozqgM3ljNV1F2imv4eCG0UE7fv6I2HbtI56ze8JIRTcSyvKBDEkH7TcuTxWZNK9oBCi2OAG6yxCh73ATyJx/Xmi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773682098; c=relaxed/simple;
	bh=zCblIchmXjb3frElJ0I3VjbD0ZXbwiADxhX1nXU93pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItSGS3I9Qcvd5qyBjqzfgQ8ddxZZEBHoevpyJEmoorShqYzuUh3fA5YRZ6erop0TOZOsiMhYzPON0oUON/lMNOcPSDUGPcEHh9c8CgUpaPasg4wmHjgQPKhrZVkVY3BQEVERmAG/EdxJJFc+Xw+MOwo7jP4V6bQTLbeb2Ie7veg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfBp7N4K; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfBp7N4K"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8296d553142so2191416b3a.3
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 10:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773682096; x=1774286896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bh2gOz8n44zuLbjupCs/AlgPlllh6tQEJHpw+6GRNJo=;
        b=IfBp7N4K3V7n7P1aCkamW+ikw0Cy+dW7kuB8+MP8/FHAL/UhGDql07aQ4GwQJwURoG
         B6rS2obfCLZPkOQBUe4Ef5px0GyxwDsLiDi1AghPP05UArIindM3TUEXzxtxPX5dnR0f
         N+Tht+nD7CYWTxuQ66mE0hHLHRv8f5NAcz2UTT1yIgjrTEw4OPBw0NQMJCM0a9URMs/M
         WLhd/yLqi7BzToWLyTZbFpmfd2pfcjAL/G2O3n+fJFiFB3p5J7edlUmMDXfWoH9hiv1m
         rJ9vJhh9GqmUoVL8uEXaJl9c/WbW1T2gTQWV4RqTZIfUhtWR4jzadWElMWmWQAHWyThO
         toJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773682096; x=1774286896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bh2gOz8n44zuLbjupCs/AlgPlllh6tQEJHpw+6GRNJo=;
        b=PmVtLQABcVxb8jx5to8luVA4lbdZZT37+ZjBOsx0V38fkN1tfPtu+rktsXVqvkvGin
         RpTtIQSN14irH68gKouPLTn2VasyAPFio7Yh9stWFGiyBlxvV3tB4EIDQLJKk5Lu/5AD
         Lip4HdymjjbRzAsE6kwb8vg82mbC5K1MwJdHohboQa78Amg6WbSiOmJGE2mLK/NUEYyo
         vbRNJycqWeaVOTnbyDP4YmlxTCEkuZ3RZq8X8uNMGhz6LepFpbeqLFwLjLYhU+R45TBo
         n5Xu46gFdTW3f1i5jpsBi8uzb33t1PHbYzgGVcVKHMsw1t9zfAMopkxzBL+CcJ++RewI
         +vig==
X-Forwarded-Encrypted: i=1; AJvYcCV/09+zRq4nLR1HnaR2mXWMPdt8kqnCXgagb1RNUG6Fvda7VEQLPwANkCpxq804xJ86rxENyOZ9Sr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsNGtmLleh09eIKUOKMBgotBwNCMXCVkc0QnvBuhvou7IgiaIx
	Wh90FObzRgizqGBPzH+84UACELPjYq4QhnMUsZIkg5xnCZONhzJaAjOiUL5Ykg==
X-Gm-Gg: ATEYQzx5tTiym93jUGXWyXU/KG3h1UW0CqzuwH1IJJrNzRJ/3C/gWDZSKJsrqApiuLy
	FoB3yk02PPMxMAVTtBgaxczDIN7sOfNfcnRRbwjBT2UKL1IYOVdH+GHJ2ZgwGlzYgdhGrcVwWaL
	Tiu8kShwmJ+8MSOBqIcyEjLzDKPOXkojkB9r3otwUnT0l1UQyCbR0s9/iRhqNoK6sxqCFvN5Bgg
	9pqPqnKSu4nNsLV4NT7jZD5cJ01rCJHekwlsm3f1q+2NKZSXMLg3ZLELoSRUdgleaszR5k0QplK
	tUZ0AJ1NoAEInVMACqExwIOWoVwtH6Uxz+8yKMCK/EwnC3EI3cbLgAQwUl0xnESCdCnw8oRX3sz
	8jlAAOCYXuFiG3HoVtcaZ+gHOs4ZjnAyPQ3Cn8+cHLHB+dgur7ehiI9bDjDLrC8FeEI8LEEn0mb
	bwnmNYn3OnbA623523Pcr0iitOXfYjrvYKberLne2L1+mEHwBx7NFKU4leOpS6VWDKE+Ms4fV6G
	KjI
X-Received: by 2002:a05:6a00:1a15:b0:7e8:43f5:bd4c with SMTP id d2e1a72fcca58-82a19937b84mr9450018b3a.56.1773682096234;
        Mon, 16 Mar 2026 10:28:16 -0700 (PDT)
Received: from atharv-HP-Pavilion-x360-2-in-1-Laptop-14-ek1xxx.. ([103.216.213.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07341986sm14016183b3a.32.2026.03.16.10.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:28:15 -0700 (PDT)
From: Atharv Dubey <atharvd440@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Atharv Dubey <atharvd440@gmail.com>
Subject: [PATCH 02/11] iio: ad7766: replace deprecated iio_push_to_buffers_with_timestamp()
Date: Mon, 16 Mar 2026 22:57:28 +0530
Message-ID: <20260316172735.11430-4-atharvd440@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316172735.11430-1-atharvd440@gmail.com>
References: <20260316172735.11430-1-atharvd440@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iio_push_to_buffers_with_timestamp() is deprecated. Replace it with
iio_push_to_buffers_with_ts(), which takes the buffer size as an
argument and helps avoid potential buffer overflows.

Signed-off-by: Atharv Dubey <atharvd440@gmail.com>
---
 drivers/iio/adc/ad7766.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
index 9e4a66477d2d..cc47b0474ceb 100644
--- a/drivers/iio/adc/ad7766.c
+++ b/drivers/iio/adc/ad7766.c
@@ -74,8 +74,8 @@ static irqreturn_t ad7766_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto done;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, ad7766->data,
-		pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, ad7766->data,
+		sizeof(ad7766->data), pf->timestamp);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.43.0

