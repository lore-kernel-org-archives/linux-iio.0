Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892E01A9FA4
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773910810; cv=none; b=WSHhjnkROqob+UviYZ0TcrwPpLppEdsva4CVpnDErroSeE6pR+SZ2B+HvrkgZlxxfoAfPfIw//Me19NXVoZfnzrAHB7kBDGrznn1c4SNFnaLJeONmldycdVZWFItAflVu/NS0rk/KPAxZsy6E1QTVbExUOjbJar/2wGAS+sY8pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773910810; c=relaxed/simple;
	bh=cOaR4benzuy/tAa9av2Gyt32qaUQDdgMGTX8iWpnFq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KZAPJSxmCuYIwYjx20cjKgbZSu5gWynbDP9UYYLjC3jI/l/MwQJ6m2VT96yrQuvPpoNov7BP4tKM4G+P1/r8QBf2AQXOyqpQ0ScnYDFS47Xfx1IJcWEBrsCfSQvnc7o2xRrna6QxidVRclOFhMUf+4Z5Fk7mIVPUr5TFvS8WYtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONAVyZQV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONAVyZQV"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4836cd6e0d4so1024805e9.3
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 02:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773910808; x=1774515608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IFxMhx4qfOMJRpou8F5/5c/Jt9bsxqJx29PwWkr7lhM=;
        b=ONAVyZQVoWKGKRLziL2sRYsQtcnt/O4wvnOZy7Yq0NFs7Dv5BQjUVibLnGNXTsfTZo
         qVf07z5hPRVCAGRVW+nmcsvtFR4bXmDJ/zTIwIXonaL0HCZ45ga9Y0L2TKFOtpJDQUiu
         xDZ7bAjROHBAu+JFPvzATxLhER+Caw3KtqRW2AEzXmPsXeD9V9lUDWPKIq4PmhI4J4Jw
         envBiklOvbGb76pnQDQHco3u2C4z7Kh+QTsirUl35evCImyVlICWTETAy82nYmCGvtDp
         sr6L+SGsvJ4uLFe6Nlc4Rfm4a7j1crRKrvne0OtJWWb19g7G5+zTtgQZ7B1WD1vKKJVR
         8Aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773910808; x=1774515608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFxMhx4qfOMJRpou8F5/5c/Jt9bsxqJx29PwWkr7lhM=;
        b=pkl4+5tOp4n3hABzl1/+9RKDM8YiBSG1CIbvEqQQ2U0fBps/55SFZm3SbFQos4Tegg
         Z/Q864221nVf2AJpiwOgCzWeIMgYvjkSpenvO+ussmq2W5RYzOxGaE/ZqQ94oQf+3C4V
         A2yMm4GX6lk0MmHC0r0RNJcPKTa8NrrqekEncCWuqlWJGhKg77FZwzqob4mZNbmGenJy
         OBEjwcCX14cmw9ee2cW9664U4d9i974NzbLt9zRbrkfrW5drIYuV92wNajzd08SFnOM/
         NCeIj0jTAkRuVQrjzYrPAg67Tqy8aHGX39GFykAbfVWMwQl0YH6uXBDefcPM+twXnHe6
         g9dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn4Lv+zGccYh1eEfjokUSDfM4a37pKwl6IYGgPKmkIfr1Z3vmC7d3fCQTDP86eRJtXc5GFJGhd7UM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBFikWpkGQ7CZfxde9zE59YegOUwUZVOycsId/nQCsP8hJgbyg
	pOfjq5yoLFRu5Q06lIj1DQh5QMuxNdhFv+zaqrF+osyNXQqYofyFeP67
X-Gm-Gg: ATEYQzx0YxDpAbXCcKwJKvyqn1rb69yMBhqyqoXq+Xhro8o0PhVJjnSOq40nVIXatYd
	Hjakfwd5V9l+2bLDYSUPTqoNnNVNhwd+7+vY7Aq7ArhoTQVatbX5YI8K28zTwpuhivX2Qj6iwCp
	ihU75dshif3baUDvqeqdFUPX7SpefLmMwVFQed4YxAhN7/NCTz7ljQsz3lmeOgiKqcFcubbiklw
	li5+RMui8GgbpmAnXXLQ/5aAeQZW9TtRFTwgklqfj6T1W1yD20VV6OxspOf6XAYj72Z9rPkjw+U
	NVcteLg0lJCLCvO5K/16gQtZ9vHF8qgYLPBLaOq/7abflKQp8AXyqxptVXpSFv9ATJwu+ul/9Nu
	6Cgtyg+aj16AFCAa2U/HXMb+S8dtkM2u6RG8e8pmMh1k24UwkxEFBR54MQ8rPx1rOEHXO2U0CXD
	9POoRJnApeA+4pMJcA7kETFi5fejPD1y+eH2Qcrlbb/stqCck/x6YU9pGSMdwlSJCrgo1zQ42sd
	ND9rGFCaKx++Wsk4UkXKpEMAXuQRvnfabAH/TnqkCAVVi4jadMs
X-Received: by 2002:a05:600c:4685:b0:485:329b:24c with SMTP id 5b1f17b1804b1-486f457987dmr72673945e9.5.1773910807656;
        Thu, 19 Mar 2026 02:00:07 -0700 (PDT)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8c40ccbsm87930985e9.9.2026.03.19.02.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 02:00:07 -0700 (PDT)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH] iio: adc: qcom-spmi-adc5-gen3: remove redundant OR with zero
Date: Thu, 19 Mar 2026 12:57:42 +0400
Message-ID: <20260319085741.109359-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The expression 'ADC5_GEN3_CHAN_CONV_REQ | 0' is redundant because
OR-ing any value with zero does nothing. Remove the pointless '| 0'
to simplify the code.

This cleanup has no functional change.

Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
 drivers/iio/adc/qcom-spmi-adc5-gen3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
index f8168a14b907..b3af28ad729d 100644
--- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -144,7 +144,7 @@ static int adc5_gen3_configure(struct adc5_chip *adc,
 	 * Use channel 0 by default for immediate conversion and to indicate
 	 * there is an actual conversion request
 	 */
-	buf[1] = ADC5_GEN3_CHAN_CONV_REQ | 0;
+	buf[1] = ADC5_GEN3_CHAN_CONV_REQ;
 
 	buf[2] = ADC5_GEN3_TIME_IMMEDIATE;
 
-- 
2.52.0

