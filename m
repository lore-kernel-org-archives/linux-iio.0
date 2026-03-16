Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C9A377EB8
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651656; cv=none; b=tJ59cOxfJyHjKObgiOmEL5Oekpj9QEkJz7aaCpdP/SV8jJCwW0Bn9/UU8qBOJpfljfjUlzF+t0FboeRaQND3MC0g3/ItDLdO+U0AlKTBEHtkTU7kH3kBL7Xqkl/z4TFFDFt/lXNWIlBLxApIeoRvzK/053jdPpPt0yxIVZsKNgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651656; c=relaxed/simple;
	bh=GX7rEU5ZjBw1ZH5RUS5Uw7wSvvBW+V6Qd58RceL8a+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqXmM1sONCrMDvYMHcH2PMTUspg4rG40S0hlcAdjnK+d0PWm2dUDppDiN+HXrieCPkWL4M1lcYFhXL9qGmcNbr9VKvAGkXKs1fdodS/vINkaeEBLnbCwahIiH4OMdHkGAq/W0YDLMrtx9ZpRSmph7arg4Bn69//nkzRV2JDjWGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KU6We+z5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KU6We+z5"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ab46931cf1so38544505ad.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 02:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773651655; x=1774256455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UKNGqPVlKd4WYam9XxH2hwncXWBagNhbIFnzEHlaJc=;
        b=KU6We+z5TK46SHO2ZQNWKk7NVv/zBOIY584j2yQsutAFm+KvrYZxE6XiNi2F8Cq8Kn
         ToJkMpo+8naQC0k2KfRAW9IvBhUm/SeAsaOfMz7GsOkoh8hi1hlnGfVdkzBmgzI1jcWz
         ereWaSw5xfvq4WiRwFIufJrd4jcgvCcaLa5GXaxsViV0bQkMkJGVM6YWQXGwLrBm14on
         8jMRVDubnty+BcK5F6LNFBZDjT3wm3zXruWwM24PWijaOdr3rJPAUDmEmLbR1Ba8vJgG
         rWMQ6EQPUMD32UjUlPtTztYVLWSEDWiRdHMl2lh1E86YqNI3E6ciWLbmUcC9VxJYOuZQ
         Ro+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773651655; x=1774256455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5UKNGqPVlKd4WYam9XxH2hwncXWBagNhbIFnzEHlaJc=;
        b=qeYaWYZlAVlC7VR7N2s+dQNCKpY7QPx74tqFP33ikekEuBTOLyhh5mHE5Vm6qL+M7f
         fFBlRsZiggVtLsexNpxONnAIEuFU0j8cFybHJu1jXDuZqCHJKIEdCgWULVj0IRtNQdI0
         QsGbHDtShEErPPg9cLmjzdgqBDmk9kg60Ju20PKftON1snwHunab9MoCvH0lxiydtOKT
         /Ngh8uNQjwSC+VoDGUcILMA5qXsxONGYosmUH92ykxnnZYK4V/7JoEJvFSa7yumLNa/l
         +UBjeestbdSPowFOGINO4LpO1h21/1/rl9eMToffxK9v4Bh+e9rRUq7g2e5/WVBeFzvF
         Q5pg==
X-Forwarded-Encrypted: i=1; AJvYcCVEAHi6BFLgx4Npg9A0p4XFk7p7c6bGgr6u9Oc+tKArKgZSgveGq/BD4He3EFm5wCuSn4GwvpPUXxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys+Ki8i/+6kZ+Mle5RqKAMNzrNWPuckq6WHSYO8Ewgf53MkYSf
	PKIaOWJ4x7pde/x5VY39mZfQSrAVajnrru5Lg8gGiOHSVH1/AATqJXFE
X-Gm-Gg: ATEYQzzpUQ3Xh+oi8NIfTsR1QOI8CMaUszkPGXSXtPBHjjeEnDsxuoVo0MSiEDwHrEk
	Iqkd4I2fViOzyHwDFaVne1WxoaUNVITWMwtB0bF4JlW9cvFR8VpSMfEEs/J8LBkv/Z5/m4BHQEG
	tGq/A2cFv0yG2RzNtoWeqLWl3WoTBrTyLX/3w1cOvDGMhbq78LOu5RVnlengEfGd0g3ictCH0za
	ulagDfGBM77xMyA6ANlQwRE08kscodDHP7rUDLvlyaqgdvc4lsnWXD8wiUjeCPJa8FRwj4+YVwg
	JhfzQ321kGK5COnY5mBVZBPZyVN6RznWZ4chaCT6xGQNN6k4IX4RyYriX7vW12xXKiu6BmkAMzD
	/13nqQWq1yl6TFURV4K1Zm0aEQQYeRE0dnu/aV4Cb4ViOUWx+hufuOQLlmR73efCXgI2LMvr6fo
	qmFXviY9urGeOFIDdJBbhVTYZs
X-Received: by 2002:a17:903:186:b0:2ae:47b0:dc80 with SMTP id d9443c01a7336-2aeba48f0eamr151254845ad.11.1773651654933;
        Mon, 16 Mar 2026 02:00:54 -0700 (PDT)
Received: from fedora ([2401:4900:1f33:4eeb:289f:fcde:6da5:35e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece868172sm98105835ad.89.2026.03.16.02.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:00:54 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	i.shihao.999@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com
Subject: [PATCH v5 03/14] iio: adc: add an article and use digitize instead of digitalize
Date: Mon, 16 Mar 2026 14:30:11 +0530
Message-ID: <20260316090023.14691-4-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316090023.14691-1-i.shihao.999@gmail.com>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use digitize instead of digitalize, which is the correct technical term,
and add an article for clarity.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/adc/ti_am335x_adc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index a1a28584de93..1516dd332f90 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -113,10 +113,10 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
	 * There are 16 configurable steps and 8 analog input
	 * lines available which are shared between Touchscreen and ADC.
	 *
-	 * Steps forwards i.e. from 0 towards 16 are used by ADC
-	 * depending on number of input lines needed.
+	 * Steps forward, i.e. from 0 towards 16, are used by ADC
+	 * depending on the number of input lines needed.
	 * Channel would represent which analog input
-	 * needs to be given to ADC to digitalize data.
+	 * needs to be given to ADC to digitize data.
	 */
	for (i = 0; i < adc_dev->channels; i++) {
		int chan;
--
2.53.0
