Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792560305;
	b=ZWfxgCEBXqjolV5F13knlrbXxq+DX2K+mU3qcYErp/mU9TeWU00aqjNR/mo2Lu9QU7KW
	 FHdduc+MqJz5WqDVWCR/+tBZZalalbNwi51Vb/bhna5XKkL+Ct3HSwGzKlzHirS1BxnGY
	 VbwBahwtaP2YFkith4bnfRNa59ZMpt6l/RqW7cZTTvDyfN1yt7YSqneJUCDBEw5w+vY0h
	 POVdF/VkfneeSZjz6j8Fw+q2c3JnXo2ePpwltsAlLMC4Pq0ISTCymjlxIdqczd4A2fcKC
	 n4y5gA/uq6Ah/tEBLgfKqjAirRiMO8toG81ayuww3MwsYYqcfmubnbkzC4mIFBAM73Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792560305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QO11p1cdvBfNgfWBeER77MVqw8qS2d4+wBk/vDSDlTM=;
	b=02bUGO+xGCVD1v0m5ZNRavskdgmH1KGyQp7DTmLiD1YMvuVS/doiqvYSnSSvpq3y7XeU
	 ZhFCzDACcWqsvfYvnHYeJ3TddXOYsOHscSXmGfD60jAKdllBXfoVYajvilIjLwIMZlsN+
	 Ed/pKv2JnLLAIrNd1OGHpL3s7of8/GTiwMCoDOQuf9EVACtrecKe9pwj//glAB9aHqa5A
	 O3HaYhBmT7ZRzIoD7wNyCdFWLNz0hR280cvxZLb085BjgmqeDok0Okh7E091qHWoMlvYZ
	 ld8ArQV10u7Sg2o0uRiH5c3MaS+SAHzQIyhDYiUNLJksF6WQmwKqdwNBtiPkApsIq/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gExZuUhk;
	arc=none smtp.remote-ip=209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCDF606A31D
	for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 05:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBCDF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gExZuUhk
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5bcb1f1358aso239527e87.1
        for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 22:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792560303; x=1793165103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QO11p1cdvBfNgfWBeER77MVqw8qS2d4+wBk/vDSDlTM=;
        b=gExZuUhkSHZ8RiSOZBDjxhHa6r4jx4Y4hhffO2HQqZCp2azJr/32CTUe+2ixB/ngsB
         l6nIgYyhfn+N1GQPLcSJUwmK4VGvOcG6SP/WfxqGuVjADDPIA6dScBH78LLRk+YalCk9
         d0U8oIdYI8kCZUclwapRe6Tqes48kUpKNhEQwRd8jCUW5NW/1FeIUzGDDDc23NLjg16D
         amdTdepRbt+fO8zyhfAyVofoJ+ncQVyCsTNyFv0M0+DgRaR/lPXQESqcDTcqFe+BF3mR
         83cuVQy/WWMmsToaMZluNvmr9LHjhC+hBm0zPdQiqzbcJriPKalP35h2uPcjWITcyAvV
         7aYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792560303; x=1793165103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QO11p1cdvBfNgfWBeER77MVqw8qS2d4+wBk/vDSDlTM=;
        b=lMaDoUAHqGryNKT/BNm1aCglB2lXJ35muYhESPhptcJlrG63UjEmt5vwPEW1LYLFA0
         eVkkAGq4l0yQIY3xsHhc+HvQPD7ae9TcXJZr8AWctsOMuzk6yOzw+0kk9BNYwy3+6HvB
         ashsSGSTZ6iNZ4gAA3jvG6OariCatq9vk/FAjRJtpt4RmJGEIiCqhqYujOLGDnO4IXp9
         mhJceAYKRGtTsZXjI88C95e+OuP3hy4fEw3gANXq44Wz5eS61JTvx1C3e4yDMwrmvvgU
         0OJ69fh01m+eXkTBqkre6AwsJBfQA8zPyDg55KGHkmnDeIw02tLiA20yhNSRXzpN4uDK
         WMIQ==
X-Forwarded-Encrypted: i=1; AKwUvBxNsuPt/EHuHj/2WPJd7W+yX2uIr2r88L6vkku/2wQ4Tri4oOqsIWD+dfyF5MzyfdjjiQidZoTpumk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJh4CrPxSnvV54DTSJoy8g69r6+kn1gVy3FmrvJC53Lx90Iit2s
	AQEIIGU6h+ZC8tfBCJ054b0K2kWpVGnofC2skhqpOb0AweQSS9jQgSd4
X-Gm-Gg: AYBFou1Qmqo9hmI1KK4/viMzG4vCiA8hju5zQYhNUid+6h8bvmu/AI9BO79GCIbTLne
	4Jt6SOA/QDfr9CgPunXaqU7A5GcHV1y3bUACTIs4vmgKbNpns/EM+3gDGBA2/Z1XVtkrg61qsrj
	1GpowdDiR5j3AoD7n48e0LaI2Vgj82GJRNfXikDzGACyOrETFknFiWNzxNO1Z75cb3N1u9NdTRa
	v5MZSspjqMQHvFSFAkBgQhbjiz/2x5aE+uYAzaXZ6zP2RuVtjRXN8uqe3VXn79MaGe7W9zUEKnV
	KwBZriZNL0eTgEQ0Me26HHo6r/mb39Qay87ceKRa7eFkqJRp0r6HWFmPZ7pqVffQP2DZDUfV4BE
	ls6OFOfUiL/E6kCQ7/GMiDoFONISORL1k76SZRiJ7F3rdDAyD32HSjdQHlSy40ZnnfvlA9wPNA0
	hVcscYM9VpVuZlA+XLcmGy99Tn2f2oJVuXq5+9a7thSAPOd7Z1kdKEuya9VNmxEuUaRMd8q5Umh
	sZ2EPT0LggWtJCzNKg+I3GfeFcUEosglb6SZyRZ+kcOENtxllEob3g04B9oA9DVaAvC7ubMImfJ
	QYThACKmgNu34ztxMVmutGC8pqGRS9xu6e9WLoHW8Qx8Zgzgxn484+qDnVj9eNpx
X-Received: by 2002:a05:6512:6686:10b0:5bf:a2b5:b1f8 with SMTP id 2adb3069b0e04-5bfa2b5c70emr124342e87.0.1792560302719;
        Tue, 20 Oct 2026 22:25:02 -0700 (PDT)
Received: from yantra.. (nekmmqvnobjree8k203-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:ed79:febf:8fd2:e723])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfa11f6dddsm284385e87.18.2026.10.20.22.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 22:25:02 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2] iio: adc: qcom-spmi-adc5-gen3: fix lock annotations on mutex helpers
Date: Wed, 21 Oct 2026 08:24:35 +0300
Message-ID: <20261021052435.112686-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 5b63d0ae94cc ("compiler-context-analysis: Remove Sparse
support"), __acquires() and __releases() only feed context analysis.
Their argument is parsed before the function body, where only dev is in
scope, so with analysis enabled for this file the build fails:

  error: use of undeclared identifier 'adc'

These helpers take and drop the lock for the ADC_TM driver, which only
sees their declarations in the header. Naming the lock there would
mean exposing struct adc5_chip, and with no annotation at all the
analysis flags the unbalanced locking. Mark both __context_unsafe().

Fixes: baff45179e90 ("iio: adc: Add support for QCOM PMIC5 Gen3 ADC")
Cc: Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Assisted-by: LLM
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
v2: explain __context_unsafe() in commit message (Andy)
v1: https://lore.kernel.org/linux-iio/20261003214516.128573-1-zoone.rupert@gmail.com/

Found by building with CONTEXT_ANALYSIS_qcom-spmi-adc5-gen3.o=y, which the
driver does not set today. Build tested only, no hardware here.

 drivers/iio/adc/qcom-spmi-adc5-gen3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
index c68c6c5f6aca..6a3cabedf4e8 100644
--- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -663,7 +663,7 @@ static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
 }
 
 void adc5_gen3_mutex_lock(struct device *dev)
-	__acquires(&adc->lock)
+	__context_unsafe(/* returns with adc->lock held */)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
 	struct adc5_chip *adc = iio_priv(indio_dev);
@@ -673,7 +673,7 @@ void adc5_gen3_mutex_lock(struct device *dev)
 EXPORT_SYMBOL_NS_GPL(adc5_gen3_mutex_lock, "QCOM_SPMI_ADC5_GEN3");
 
 void adc5_gen3_mutex_unlock(struct device *dev)
-	__releases(&adc->lock)
+	__context_unsafe(/* releases adc->lock */)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
 	struct adc5_chip *adc = iio_priv(indio_dev);

base-commit: 43ffda3c7f8456bbe641ae8249a077a361b97880
-- 
2.43.0

