Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0123BBA0A
	for <linux-iio@vger.kernel.org>; Sun, 30 Aug 2026 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788109802; cv=none; b=byj8idoYjPiOxbduYtLI5RsU6eOdzkJCDVHVroyXE3zKhHitLU8qTOyvYGozjLZXOHVX6pBzTFQQGAjJpC8vi9SSg439TgazntWi+vTmpAhgUfB4vPPESNcDlgmA3uGNsYY41v6wdCCDdOtB08Rz4vyh5XVnX6MG9UeNz09m1kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788109802; c=relaxed/simple;
	bh=zIjaJlDsSX7uS944H/HVwdHa0XO6z3KgmisHgC5zCqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E7bVSXPOvjD+u69qOq59eU2tGjCwCx2rtMhDo1IysqyHIvnDOaB4wWTOQ91GWjvHxeW3ZR/LLBqzd0RaLErEeqhEz5gNFTnn3opp2Z/w5CsIw2+sMMzqRSD+QN9W0iCnJUiAtwqUVvuyygqHFz98gFzuFv2hpm5ZErn8oG3k76c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sE+fepPV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sE+fepPV"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d8fd3b729dso6862415ad.1
        for <linux-iio@vger.kernel.org>; Sun, 30 Aug 2026 10:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788109800; x=1788714600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Orid2veXjic0ZdavxQZhp9ZLIyVf/YFiysRR1StloQ=;
        b=sE+fepPVpWSyFqbvgx+uiu0D+DTpQEzReChsR6XryYgver0v0J5qlcbP8ttIB6Tctf
         BHd/154ZuFCNIiOKXODLL3UjS8rnBiGcNMwPVYVj2OI67culhv0SHCLcfUELZkGFOQMz
         tbuGyMQ7IhxRE0OgLJ/Yk764Y+FR31kUdyengBr6u3FTorkoppzci1o4bryFQ6BDeTnw
         LZDOxKGwUT2UF8S+1cJ4+PMLyogu4HfLT8+axo6L9JZ+S1iMBi5JahZtHF6FEH3zDgOS
         vu4gHRKRKvS9Ul6QWVwAL+J1/szyIaSUY83Mc/w5MsivtWvHVH1itstg4jEP0vVyq2kQ
         ZSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788109800; x=1788714600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Orid2veXjic0ZdavxQZhp9ZLIyVf/YFiysRR1StloQ=;
        b=BYqKhGEKnAnBDOxTLX5JYJ1BOVD574Wwb9C6NzV2j8gezSFGkeQ3146qxBCRusxu3k
         aCFhSHj5p+LZaVktFXuGa2zdLhPvWbVGUFxPVzQ0Rrb4ZDbHzi33SZg9Wrmib+HGkvLf
         pMGO39xK6l9UI/FOOTtR3AeWiBodUE2p6dQfXF9Zazwzmwh6vvklc6WsOpmgPmYonJFp
         FuxB+DZNC46Zg0EJEiC8uwt7JbRaBa5zPYmAukbzZrWX6u/eDa8w/p9yWGc0Joq3UZav
         k58McC84TaniAbna/iOvzv0A+yUA84C7ou21s3/vqSv0boXxFNCBJLmRXTRvu7/8OteL
         PC3A==
X-Forwarded-Encrypted: i=1; AKwUvBz4rR6gCA4zm3gS0A1ruBuvGqD6/hkqbDr8yDMFymOGLPBit7cUCWxCnYRJW+4q+YoJQBpKb2FjtXQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lv+pylEu3DiIKEpqRLZdteLMuAgcmFrY4cqcFFu4KZFMUa84et
	/IXniJtdnS/sEHFwUQm/abwx/sZXgW3r6sDbhWrDGDfsYuvRF/lIYf+L
X-Gm-Gg: AYBFou3U5AxMvPJFjKisIFYG3ZbDkHIm4+t+ILf4BmFXa1G3PPnz3q80olHUiOwNRRP
	w5mTd14PxvXw3hyFnx2f3VspXRCK58KtkdlxM83OIvTpw48RO8u0YqyDHVYsJVHOfvm73hvryO0
	1AgwScaAlwAVMA2RwD58KVE2n4gdCpH4w6f4rYPVaBawLOvgk/9SSRqkVKaGvqYQJ86lv9whWAq
	qXz0FcpQxfLpZ7vnLF1a/QBbswAx/dPEVzSQNdYk0gBfKGN+lnpBWoFaM2nbtzdkORKFzdFA9sh
	pSIgbr5LsYWPFqcgM1EqTergBC+uD1C8qwcwqL1wmrb5SOMDT46pwP/1j/m3yEhcP5EbpqzTozA
	fgi/2xAOntOjfF8Y7ooteTb61tQKSbrMAp1hmJM6m2wzQJI9cDaWeD9xtjoAdHnCGBqVUiVnRnD
	zWKQVH5PBO0Kf6GhbRYjW3f3etIYEg1ax3ZRH6MAQp0XZrMY9dcDjUpcvHLg==
X-Received: by 2002:a17:90a:110:b0:398:9be6:f999 with SMTP id 98e67ed59e1d1-3989be6fad3mr12628288a91.24.1788109800385;
        Sun, 30 Aug 2026 10:10:00 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:88d5:45ce:40e:490f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fcfa3asm17047101a91.6.2026.08.30.10.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 10:09:59 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v2 0/5] iio: adc: bcm_iproc_adc: use device-managed resources
Date: Sun, 30 Aug 2026 22:39:13 +0530
Message-ID: <20260830170919.470974-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

Changes since v1:

- Sort headers and make the driver IWYU compliant.
- Use devm_clk_get_enabled() and devm_add_action_or_reset() for
- clock and ADC cleanup.
- Use devm_mutex_init() and devm_iio_device_register(), removing
  the manual cleanup paths and remove() callback.

I checked the history of IPROC_ADC_AUXIN_SCAN_ENA and the related
iProc touchscreen driver. There is no documented dependency requiring
the bit to be cleared before tsc_clk is enabled.

I also checked the touchscreen driver's shared-register handling. It
enables tsc_clk before configuring the shared REGCTL2, and its
history does not indicate an ordering requirement involving
IPROC_ADC_AUXIN_SCAN_ENA.

Therefore, devm_clk_get_enabled() is used as suggested.

linux/delay.h is retained because the driver directly uses udelay().

---
Mohammad Shahid (5):
  iio: adc: bcm_iproc_adc: sort headers alphabetically
  iio: adc: bcm_iproc_adc: fix include dependencies
  iio: adc: bcm_iproc_adc: use devm-managed cleanup
  iio: adc: bcm_iproc_adc: use devm-managed mutex initialization
  iio: adc: bcm_iproc_adc: use devm_iio_device_register()

 drivers/iio/adc/bcm_iproc_adc.c | 62 ++++++++++++++-------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

-- 
2.43.0

