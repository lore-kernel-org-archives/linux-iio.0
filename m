Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D34382F13
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651662; cv=none; b=uNJ84P+3/kiyKrx/VA4JaJqN0qw/kO3KpkrI+aTCKE5V6TwF/xHMWAWHEkCgBKXR/eCXTLiAYyJQ3A4YGfxXC1vowt2K74arO+jTLVcs/gnrEwv005LQcy33ZuJ6FGI0Q9h6z61l/LZEjGfUNjt40UAXlGx56BkYnj3TB6FjryQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651662; c=relaxed/simple;
	bh=0ksxJ3OhWzcJfgmpJ6pDHY6DyAVS55+2Ng2u6o7g2GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l10+d0hFPZ0D+kCHshdhaR+sCPDFe0mkdZ2dz2qIbnVY2s4XyN1/wbspO9ftndpOO9PzM2//GdCoCrLKxhUuq4+TP2/W2rSJlevL9EG/jKsLnuI+0FUKOds9mSdICifnnUfOUBNxY1tVS0zK827LpDfduOk65RUNYfe/N0Xxn5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYuYwrCR; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYuYwrCR"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c736261ee8dso1409494a12.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 02:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773651661; x=1774256461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDI2tglqS3BuTerfhDJcUTpl1wJIbtGimcX2fk6CAC8=;
        b=fYuYwrCRkZlC8LW5M3sOJY3ggQajFblzoGAeOBkx3aYxmKevRPEJ4rs9BK0sioMZsm
         y4DzwZDEARNMixCxvHToOEA6UGdsKvfV5a9NprkTFw4lQHIdcB0TWkGSpPhl0Nt5n9KE
         3z/uIS/TFlYE2eFioWINKzBAFOj1HokruoQISpgb1tgHEOwqpsRpohwarsz0zxlDlGD1
         mZK8dwchNKmHifniT4DHSWrH+I9Fm6i9oH4DplK+tXgtjtPLZpy2TjkB8Va8L25O7u61
         kGCKcB3P+oYSLnfH4PIkmk820p/iDCyjqZxY0A+0r8Dgg1VVT2JinCPMUhKIQNOKEfxq
         KncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773651661; x=1774256461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VDI2tglqS3BuTerfhDJcUTpl1wJIbtGimcX2fk6CAC8=;
        b=Yh41zICXc1QP0weh7hybWd4nFlZ2unk8P7Vi9usbK8nJmz7v71oi73juWzpF1QOj8e
         ocfgF6c1oSQVNY3jMY6piGPMuqvggiMcJ0bQnPgzSQP+MGkK6YP07Ozl/AgDezjMtkz4
         j4D3xlxjxdG7vFQQpG7WCSNnGcpUizBOpwjxgDcxewm8tXwuVPnbpQNsSdykgXv/QfwW
         hsh9sQcTB9/Sw1JSVrG2+167x15bu2zlcm1w8KYDVcVZHuZpWGpSTDu/9NlPksbKLSJ6
         LKELmJtLDEfyqUOiDhHWhP+7LFo7br2QXlDiyyBTr53hBxmRdRDNqdc3aMUBLHd3e5++
         4/Lg==
X-Forwarded-Encrypted: i=1; AJvYcCVwaFHjabUvgzm93itlmLp+gFn2MvVfImHUKoIXA67Z3VVjjP3fpXyGLayI39nfdtT1ijvdMXYXjbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr8bz72AK0VivlsTG9fSIij3EtTMbIPqH6ZtEDYm596zyC4MrQ
	POhl7Y6g6VolDktRfJkxhnKRDIOwhrYqJtrZMKWCH2bNRsvHMExWxM1O
X-Gm-Gg: ATEYQzzi4/WE4NcDMhRj/jza3zpjqxqVXaZYrU24VyeHJ9+8kUH7hJ0B7hwjDXLBdOA
	NnB5NJjkY/B1eY/pjs+FAmHw+37TKJpW7ZHx19Si6cZjVqgEYv7Lr/tdrokR4i10l179574rCpp
	BBQ4UlYnFcops6QVxbtvGruXCe91AadVjk+n7StZFwtdgxciAUvaXLFrnmTIZCMh8yM/yMBjVCD
	1z3QVGjd8GyKHcM45UbPsN3apjgW9+zbnfe3mwAxZ6ErxwABXSaTo0JfRNmlzG6TBJY8AnGymGn
	HO4koMVeDCcYUxaqyEYpUcT3EOg96gaPQ9RwTVuNskuuSN+HcD2ULAgvwOdl9Qu4gaS7cXwnj/P
	hCrP9WkFOJuVcbuTsRA/UmXJltwqI8Z1lYiituU+0WopZfQcgfOkMXiyz7sFr9ZMrsQhwYr/Hg/
	oDIN0A/Vx4smXuw1m5qCBlz03O
X-Received: by 2002:a17:902:f708:b0:2ae:ceb0:d5ed with SMTP id d9443c01a7336-2aeceb0dafbmr98178645ad.45.1773651660990;
        Mon, 16 Mar 2026 02:01:00 -0700 (PDT)
Received: from fedora ([2401:4900:1f33:4eeb:289f:fcde:6da5:35e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece868172sm98105835ad.89.2026.03.16.02.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:01:00 -0700 (PDT)
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
Subject: [PATCH v5 04/14] iio: imu: fix typo from adjustement to adjustment
Date: Mon, 16 Mar 2026 14:30:12 +0530
Message-ID: <20260316090023.14691-5-i.shihao.999@gmail.com>
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

Fix incorrect spelling in a comment.

- adjustement -> adjustment

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
index 6aee6c989485..47394594d17a 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
@@ -125,7 +125,7 @@ static int inv_magn_init(struct inv_mpu6050_state *st)
	}

	/*
-	 * Sensitivity adjustement and scale to Gauss
+	 * Sensitivity adjustment and scale to Gauss
	 *
	 * Hadj = H * (((ASA - 128) * 0.5 / 128) + 1)
	 * Factor simplification:
--
2.53.0
