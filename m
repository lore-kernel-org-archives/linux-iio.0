Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283BB5947FF
	for <linux-iio@vger.kernel.org>; Tue,  8 Sep 2026 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888339; cv=none; b=m6aczhz8Dnm0SRayeNQlYFkAxSoblKCNJCT0BbSaZsdf7TYfbwBb/p12GOarFMurz3pyIeK0wEFEMRsGz1qT7Ma9vLMFApZoXizocTSlpgMBXBhQN0KN2DPwHjHx8HSjcqeLy3DT+RxClFQPImePjMErD8FXDkXdo5i7hBmnv1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888339; c=relaxed/simple;
	bh=lnMZlFsr2b7pcckby/9HTomjPCDw0OgChLIiwio7RjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flVpYnfTvksUysZPx3LVGVVkviwT4g3xTwXVgV0YqKOajoU+80ATq1Rn66jsZI5YU3jBcxH09lMHE7Ky2H1qqWKWp7MHR4hmNFskuYuq2YMsW6TeYQKBDMwwzdGIwJf3ZNsOPmr5yhWfnyxNpAu5cuY1ODXBhffWTr+YEInMkEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYw8rqYt; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYw8rqYt"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb751so167406a91.2
        for <linux-iio@vger.kernel.org>; Tue, 08 Sep 2026 10:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788888337; x=1789493137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eN6yqcpqAjYfvv8rc/zTcsykokPXr/AOywGzcoVI8dE=;
        b=ZYw8rqYtssNc0O0RM34kCCD2vqEhJk275t1Dnd2yI7JSmKdEHdn2+UM8gatQT0xCkj
         KzaVqiiEU/2Zl6YVy0/2moa6cpU8vdmVdROKxV/B3RGcAQFuc7OX+JvaMih5ThpY4wSj
         6ilEOm9w3ZvhHZZ7ash9ebwE+sH0dwkxoE76FUZuOKE/Cg2yVqJfZD4KeCPuK7xkW35z
         eFpbOMwDHElN8YGZQNzDydnMb9WRXlSpmvJImjbTir9dLtrSiY7XABr65mrjtXPMXyPH
         dOPigJewzD/VTp90LZU0SRk9eQyrYQqM4LkadGT4YI4zmIf7htBbM0IJSlhBxvlMCMAm
         NxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788888337; x=1789493137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eN6yqcpqAjYfvv8rc/zTcsykokPXr/AOywGzcoVI8dE=;
        b=rvIRvulast7R77Z7PpTChBOMl3zw0D7pyb5JxrAC+6ECrbIeEYuB/p29WzEOQ/ux8t
         whn9CUwaQ28k+GFvm3YLoAmxrxmXso24wBjEVURRs+q6QKP+wgQX9e6qneujpqWw4MXT
         8Ql2feZlQkviYEYWsut5aKMYisdHo+z5fsNiF5nXSIS0aVHlSXvRzW0+c29SkqjbsNQ9
         cACSU7QzGInxDcv/Y7rxtw/7t7dQtPxEoJEZWbNe07Pu59nKOSEXZusahd5VfzuvG2jp
         olbn1hSkr+O+I37piarz6+jgBP2CRy6M4pLwndXPOEIzJHBnxITCsMdq4oVRvfGEXlyy
         o1kQ==
X-Forwarded-Encrypted: i=1; AKwUvByJJ0C69tAiy5wPIlGUbb+8xp7MCYWlIBn0HF6GaDf9kPn3hyatHVb8rg3ac1keodTratr2TFT6yao=@vger.kernel.org
X-Gm-Message-State: AFuF++nb2m6Q8/DlhotEDvSlREf7g4f4lG/6z5IIpjmJbcY6S8pduYU8
	FlnBtJRx3r7pyM/tCuC9niKnJaMozkYqyQjuLtM/duJ/2IY+LDl3qsRP
X-Gm-Gg: AYBFou1sEdGKFaxPpLAkhZbt/xsBpo5/dkuUR/P1x4w9JpiVYKWgk2sSkh0KSOUw+ca
	byC96o7Z6rSttK6uh/0IlA12vr7WPQHW6Vnfm6QcSVnkqKRU/CqNywxasERjPx9P9qzJ3FlNRY/
	GY5x+E959J6Nh+GgUKrAU6HikK/iHOGzcU6AHSlo29R+bTIT+BjVztndgr1OBClc0CS9/OQAOj4
	1CDI01tc1H5AN6Z8SU3RobDFGIoanBs+HKLdxgBLQ6tD2uRDsVsxjLx4VlWezhTzJyU3o1T+QFZ
	dYiqlBO62SCfK2tzSFIVv9draayeex/5ulKx/5V6VCzBahBViYUgjYgrCWeGeLpdJaba5aEmLJi
	AwcHWKb8pUcbpfCxt17NxUj0wiiAL0fQE4DBed1lh93KPWzm4ZyeopFzLRyIHrTdnDrkrCth+cc
	PzZSiApkbJkdrQr/+Tcis9NQEyxGVuTC+w5f/Fzo+uiBpIwq3w3JB2uZTQ9d0=
X-Received: by 2002:a17:90b:2787:b0:38e:9eb2:9d43 with SMTP id 98e67ed59e1d1-39bac34331amr1274961a91.16.1788888337459;
        Tue, 08 Sep 2026 10:25:37 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:43ae:bf76:d99a:e5ff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33688cfc714sm19297176eec.20.2026.09.08.10.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:25:37 -0700 (PDT)
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
Subject: [PATCH v4 5/6] iio: adc: bcm_iproc_adc: use devm-managed mutex initialization
Date: Tue,  8 Sep 2026 22:53:58 +0530
Message-ID: <20260908172359.30003-6-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908172359.30003-1-mdshahid03@gmail.com>
References: <20260908172359.30003-1-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

Use devm_mutex_init() to tie the mutex lifetime to the device and
improve debugging when CONFIG_DEBUG_MUTEXES is enabled.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index ff271c7fb2de..9881a3104c26 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -525,7 +525,9 @@ static int iproc_adc_probe(struct platform_device *pdev)
 	adc_priv = iio_priv(indio_dev);
 	platform_set_drvdata(pdev, indio_dev);
 
-	mutex_init(&adc_priv->mutex);
+	ret = devm_mutex_init(dev, &adc_priv->mutex);
+	if (ret)
+		return ret;
 
 	init_completion(&adc_priv->completion);
 
-- 
2.43.0

