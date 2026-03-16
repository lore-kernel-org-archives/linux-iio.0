Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B796D13B5B3
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773682262; cv=none; b=j5IYeqtjrBuxiuckUZmJ5l+KhhBmxJaIny2G6kySHghmmY88aruObjXl0oJl1w/DsfsjgTynqD52D1/sHye2k9eipNN6H+qsNAIWtE61LY3yuTqlhuXxceBNu8ZCocElNxZKm6GXLPceQX4za48zms/5hn/2cSHntjnNDfimv8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773682262; c=relaxed/simple;
	bh=GfuDd9tF6IV8nBLO+naxXS2PxhDNa/HNUzReZ+d1sRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IljoflZ+ybfSs1QkbyU3LfZ6k3HgmWIuUYP4CPuxVarK1r1blilhoRXGfIBx2B/yWL+vabs+BnRrbFNGVJJa+F4D64x0iyTfd9lTOY0w1/K40q0wbEG4lUckboviibLHHQ3f9drg7qPCE/gnB6O7ASnwYrDHZ+6tGhrPGvDideQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2wA3a10; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2wA3a10"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8298fad2063so2815882b3a.3
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 10:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773682261; x=1774287061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vwgx3jFXFNmOTwQpk58uyyeAlvnfqO0zlmUCPEXpomE=;
        b=e2wA3a1024Qo9EKi3QpHjxb0PqEaWoJtm6jenMVyjygexkU3eMu2SKbGIGXm3GPt4I
         rkOvGJWDlnvmCN6RBVdPErGgITe7uWpXs7Vyt36U65ENVGLkale0bUuq1VCttiQdV9NI
         M4bwNSRYDiqHnlbYLmLe3Mloc3w8IuFv9tywef9+w5Av89rLXzWQoGaU/BrBgBWDoTPk
         dY5lgCj2GxaEHYRabpM5Y6OzDPezHdP+WpbzdOykKKvfdfT0zuovUr7Sedm8iI4Ij5i3
         5lPO6HOWxgs8w7Wbr7rxvsM60NhPSNPJj6GcMeM+xxzKIz9/AxISpzPEc8f+F5FZpj0c
         EFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773682261; x=1774287061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwgx3jFXFNmOTwQpk58uyyeAlvnfqO0zlmUCPEXpomE=;
        b=joZsM8KHaNiIrK7twytRbExSsh0krXBvT3joJN7dbCVfeB0yHAtq8N+J9AecyK2CQH
         s82S5UBSxig1C65SFtMKkZPWk3HWD7uKJzsBey9x7V4bySUwJTmQQwRBTFBB1Xwe2eUE
         tssqn40jCayeME+zPPkn1/JQNTmQcQUM1ZB96ksAJeN9wJzD4m1L+EwI1eTm/+UfdiDS
         MqylkaazidK+o4kh7gN3y7sHfcpjwOgi2ZLK27tqJxgmYRn0A+DtiFu03ai5n1zzMgaA
         qwv98wIyKGEeQrrSOAEmu0fWOJxvKbTfALvAAQGGksNe+LQAdW/jDuKgCttst4NhHLQ2
         Fw+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWT8faqAFfvHu2DKH86HAb10Yw96I6Ml9LJ9Ix2jPRsS8ZBb4+gRRI9mc+hNrp4F2gZUGoovrMAtHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YypxFE/pKX0Tuu9wLi8kEOnftM6E3KgGuf728G8+2KpMJ9HFJrt
	5ozkDmfFjrmiGRP9OGJ0iAfa5M+lFVDOPBFBWXDiaSmqehzjVT3WdhPJ
X-Gm-Gg: ATEYQzzeYqcQfS//yXBHEf5ACLVF3NINEhOxUR7/in5jX6M3DyLFbWURdqH/DGzsJTu
	oo0bgsavliULdH6VVg2OKSgybBWZ/HPljyama71d6uCwojWrfIc+0lCRLDakaqg2tDQWv2yuZ7L
	5puhHogcHPKCcmlB+UoRdAjSf4lVmDP8xnviv0ShI7YDMfhbaKIX5+bUMpf898g5oOCe0lfQeDP
	nEEd09R3Y4/qgt1C8IuO+GClHaU90yWeQRnVBEMCWnscrl3+rHF8gBT1Tbqvl7NE3O3e4rHmk3j
	oukQlWouuPH9TCedFa/IuaDeCpJbyVO+s7R2ZczrRpqulh0+ralQJDHag/FaCDznlWye3rkTTTs
	kQq9FpqmwrkDxAqCqB7L3Zva+Psmm48M866rNoRlNFSgyQO+z3L+DMHGdygpZvYoBHvzSsy5lNU
	LJvhNwr1Q++q8T6n5yAiskixcT36/yIqjwfi8/PYtmFH2ICr3a125/QxAlqtQrV09z3GPawuAIS
	2dk
X-Received: by 2002:a05:6a00:2e9a:b0:7e8:4398:b34f with SMTP id d2e1a72fcca58-82a198c6c3cmr13902644b3a.34.1773682260929;
        Mon, 16 Mar 2026 10:31:00 -0700 (PDT)
Received: from atharv-HP-Pavilion-x360-2-in-1-Laptop-14-ek1xxx.. ([103.216.213.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07382e6csm14369759b3a.54.2026.03.16.10.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:31:00 -0700 (PDT)
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
Subject: [PATCH 10/11] iio: adc : mt6360 : replace deprecated iio_push_to_buffers_with_timestamp()
Date: Mon, 16 Mar 2026 23:00:49 +0530
Message-ID: <20260316173049.12098-1-atharvd440@gmail.com>
X-Mailer: git-send-email 2.43.0
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
 drivers/iio/adc/mt6360-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
index e0e4df418612..b123251e3786 100644
--- a/drivers/iio/adc/mt6360-adc.c
+++ b/drivers/iio/adc/mt6360-adc.c
@@ -276,7 +276,7 @@ static irqreturn_t mt6360_adc_trigger_handler(int irq, void *p)
 
 		data.values[i++] = val;
 	}
-	iio_push_to_buffers_with_timestamp(indio_dev, &data, iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &data, sizeof(data), iio_get_time_ns(indio_dev));
 out:
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.43.0

