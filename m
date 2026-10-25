Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792955720;
	b=HYw3UGG+uQWoVgYveM5k7Hv3RQXwe5mTwVJHCL/4/fm5MTRQOsuc8ZT41GavBNois4K/
	 wV/0VyX9f3YZD8hR7QwhaBacAvSD5Ac+1n2DuPcP/yuWHPv+kHIXfoSZbCDl69zneZWE8
	 DuYtz5MW56onTZEjAHu00su4HCTqFuqlRd8yocuPL7+q43EuSHJBlTN9GwsyrZnezRisI
	 9F9D6pSyA2in3V77bBX3lZmNGRsGfJ3rcA7hnXZ503XmUeQsPMxB41A3MI1LR9iGvJ3vG
	 ep8NNp5/e5zeksQz8R9mHIsZ3VM8XIJeboB9yxtEgHXroFBJJfARTtPiZPt/7S/6L9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792955720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZNcBLqWAyNJp/9Ob/qdifA0LjCwb6pxRLzUpAFt2R8M=;
	b=BMULeKWdLn0jVJDfFltx83VjwtytBvFXWUZ9Vi0IKRrjWlemBgvTybCjd2ofc89uGJ9q
	 owaBtpzy0Dq2mvA0eHi0HG8kBgaBndXeJ2RRWk2eT0KUyCAaUk57dGyQkFhA559zoXj1/
	 Cc55Pj8EJqTCI5nl1VtNCBGGFAeMIPKKCaO1VruoklUlMrGB/wpCy5lIPQ2Is/rDNwD63
	 +P1MFacYsZKinbBCYgIJCq6VwcmR6p1pQLHNnGOzliIynmZpDPH24ja+DXaRo9LP9uwBp
	 b3YumBXN1EGtbnadqx72zP7egS7YhHJjpott+JkzVXAO9Ks+AdFANpm+pJtVhjLoKOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N8pkrUGe;
	arc=none smtp.remote-ip=209.85.167.54
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D46606A31D
	for <linux-iio@vger.kernel.org>; Sun, 25 Oct 2026 19:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92D46606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N8pkrUGe
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5bc18f54abbso300901e87.1
        for <linux-iio@vger.kernel.org>; Sun, 25 Oct 2026 12:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792955718; x=1793560518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZNcBLqWAyNJp/9Ob/qdifA0LjCwb6pxRLzUpAFt2R8M=;
        b=N8pkrUGeiYT1k6wkM0LXvk4AZeGpUoGdqHa1tEHKmz3I4f9HVTKjxpXzABIy7d4GKH
         84yIdL0EjaYBfs77J72pVKB67AJZA6co2SkII8zjgkdDOU1+EmsCJlu9goMqzSEiXW1T
         kMTgND8A7f+LkkcRIFuTbapGjkj8D7Z2dl8w1A6+F8kwacoBVdMg7gcClyDxfDg/F3vK
         2/HwaRK5dApqNop9RjeCrWLy+MJ1dTyoJTsW2ZtSmYF+UvZMFVmbql9P90OZ/x5WbKX9
         RINxIm2Bca1geYUTpJEGVTY5IqxipKrBYJmnlerWKWDrossJ29skAlc5uPJrNDjuulXo
         55/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792955718; x=1793560518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZNcBLqWAyNJp/9Ob/qdifA0LjCwb6pxRLzUpAFt2R8M=;
        b=23I9x/I4ofkuTptHshhwuP1oOW+xTqY2vUDI8tESuVNrPCAcpXxjnPmymPXu8331dB
         NuNNP3q0PzXq3y7/JFmn3Fwh1uZC7yRleCwjRa1w8gF26TPSjpqq9I8E7/OIS0iyxDGZ
         M88yHUQKiqaS/aFiZFiO/Rz4gtFNQINvd58cZ/f663seHVANcaHPd643YLmrJ7y81h9C
         jSrT0NJ4cj71d/34vwG9M/tBkvGDRSz1VdCDxtAoun4AdmwISV0Za6vyXfO8bLJt/3tl
         oqIYd8rqASlHKQKXOCEYwWUmLmE9Vpzcmfueni0eUfBqO5aTVmG9lU5eeL0aBJBILIvr
         Efbg==
X-Forwarded-Encrypted: i=1; AKwUvByR24yZeoK/NtO/J1czpDmI9b8Q2QKGS69g4Pfq9b6gY+QKjJRVB4BvExsG1PkBIj0m1JTW6AkYflg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmH8P5RrWJoMk+k4eQb5po//HI2QTYwk4QL6lkjJnhxWBS/zpY
	PkHZ/1ajHVlJ8hfuSFG5CKCIpflqqfGrs498v3laPBx0ygXnVsbqjTAi
X-Gm-Gg: AYBFou1K5RTlhEYzey/PW5JwOpjV+PRfvqi1hOoR4x/TtK8P3dcsk53azOhN3vfOBsr
	ZDMA6W7JtOvmcrW8C/AstuIFUWXdfILFr39EIm9CswHCtVcGJUg9bcvhoJwVJWUWO9u43RSCy66
	tsbj5FXXVJHhEHW9kexKKwMD4Xh4cwEI5AgktVLJNcqs+6wV67IpGRTlzOx2mynF9RC7w2OC9bT
	Ta+oB2NshlIvVjhucNXhBad4cCkuMAHbdvzN1pM7+ZQTEI29LqF+jloG7H5Yo2rbyGBIdl1RDN5
	qHbx6O4nBWSD+KRp0jyYpXtrHRfMuL1i5tl8AFEOAAK/GtVosSjR3r1ZeIlA92So9PDJYeyj2kn
	2KKWaOkHudRd9sdusy8bOryOjU0/4plf3ARCZJ8k++aFp70GYPzTstVNZk89nYnpH75nft6NuXr
	ROgySequ/9UiNmTsaqy8gT/36vekKMmlPRYqbA+W1X1+Mxi24urxYWiqdObJmuRdysmm/oTnI7m
	eRqLaC0c1nbvDNSrOxZWDY0CQJtvla0C8ZV2uqGGOC79gl/U2JnjDgGXf5bggGgNWSfBiQLor+0
	O+uoOYCI1mt0ZLmrgl4Tid1ABNEsd1nmXqjk4LylSKtnXCUou0mRr2j048+kT6SM/HAmx5Ua4pS
	UMq9+rys=
X-Received: by 2002:a05:6512:3e04:b0:5bf:a467:32ab with SMTP id 2adb3069b0e04-5bfb71d1366mr1553389e87.29.1792955717490;
        Sun, 25 Oct 2026 12:15:17 -0700 (PDT)
Received: from yantra.. (nekmmqusumz5xuyc5yb-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:b52c:35a:762:9323])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7a75a79sm1147287e87.39.2026.10.25.12.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 12:15:17 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Subject: [PATCH v3] iio: adc: qcom-spmi-adc5-gen3: fix lock annotations on mutex helpers
Date: Sun, 25 Oct 2026 21:15:10 +0200
Message-ID: <20261025191510.22261-1-zoone.rupert@gmail.com>
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

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
Cc: Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>

v3: drop Fixes tag (Jonathan), trailer cleanup (Andy)
v2: __context_unsafe() explained in commit message (Andy)
    https://lore.kernel.org/linux-iio/20261021052435.112686-1-zoone.rupert@gmail.com/
v1: https://lore.kernel.org/linux-iio/20261003214516.128573-1-zoone.rupert@gmail.com/

Found by building with CONTEXT_ANALYSIS_qcom-spmi-adc5-gen3.o=y, which the
driver does not set today. Enabling it comes later, with the IIO core
annotations. Build tested only, no hardware here. Patch and commit
message drafted with an LLM coding assistant.

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

base-commit: c9dbe2a47f635465c9985b7af74d2ae310e98125
-- 
2.43.0

