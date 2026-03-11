Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF433CF662
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222027; cv=none; b=OtXXS/r8tSgyMqZhRWG5yaLZm1F+L7QFmUWBxI2EVF4J4xUSBCl2b6C6a5ZKtxrs9T9hpRM7zxTvY3fOdN98ASkPEcwgp1bQP64mDOYBRYgKxwO8PSNjPtu340LhdKMrIieAq0rmYKyIGzG/0JpSZHEaz/KXU2xb3INbepZCklY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222027; c=relaxed/simple;
	bh=yBSXpIQAsWrq3XAXleNd/6C9XJEe12YsfG948Ui2/Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewenE+pjDNczBXSHVrAQtsKEZpyQIdusl1lgPnnAgkZGtSqq5XTz3qhsp7mMXO0CS48Q3rFDfJf/+52eeCSjnuIdLGWKMzt/HsLDcK69slQDspkB2uqWVgkPLp/1yCZAR/Vnh1ryzHh8QuKvWq4mfy5ebcc8veCN53IrN0luvlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8u6XWFY; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8u6XWFY"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-359fea895b5so527436a91.0
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 02:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773222025; x=1773826825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3schq7esNJMfuqJm1r9bLlo5xG+U+O+TEHkvuUSqZM=;
        b=j8u6XWFYUna2FU89Lt/BJlfwp3tQ7bVCENumrDw+FLPGps3Na/g9DPK8J7Ju98VU+V
         P7QpaNF//8WQykLHgxBzDC9Qi8395KHTR4XvtYNFwrmkJFEeB4OKS/XWZfsgSCUdtOCJ
         8H8st2Ow6cwl/yfcqlHER53Kh/DT3TPg/eglB/nEEI3e8xfD6gOGx81DLC2DfATTd7f9
         ROSa7iNXmdIh/cnsfq83XqQlvcsEwUmKsQKwICOddAWNhaZ/tdYl/lK+me/s6Y+lk2/0
         DC77DfrS+PcF44cpobyUXvtyzQbf98XtwAcb9IH4kAhffkVUqQIXeg+D7AyZLQe8h5uz
         ZyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773222025; x=1773826825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K3schq7esNJMfuqJm1r9bLlo5xG+U+O+TEHkvuUSqZM=;
        b=JLjhwI6RPiQ3/QOeKn/SXL5yIxcby9XO+LIFBuJrF2Qa3dqcStseumvCFhoSKr2huK
         +VbB9Rt9AVM3LALCsRR+Hx50LLf7lurxHGxsncE4HO7dT5dK2Ts9h4OIHyw+g0/2BeKi
         5Rc+CzWmox1dk+e0bfcYhILMQpzP9sArIHPpp9uFUSzTdCZ6XfwGTZyQ5gvIXkPLwhPA
         pkDCajTRd/xhH6+TaQvQldxWhTlAZ/PGTiBL5VhkR8gZy1XTuXkKeSWEMxIynmv2JJEh
         gq+uk0fU4mN33bOijI/Cfd+J5L2ruSX0CKJFcbN6HszaDZFyOLwWZiGw1NsLaRqR4gkE
         +v6w==
X-Forwarded-Encrypted: i=1; AJvYcCX/C0AnGSGGlWj81/F0Ag3V9aUcvCupjxdqQ+YwHmKWUAPyAkDT3clPvMsYC9Y14ydnrJqM82xQJS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuhFoikPNMhd/6KwgGmWXcZQY4LP/NCHYGdvAx1YFuQ0sciU3w
	oI4Z6RDZPOk9ul1xmhDFv+DejCTPWeTc2ikSC3FmU7TW0+YPzwRRIGxs
X-Gm-Gg: ATEYQzyaNR+Y4DBF13A60CiBRsolmQYg9Mt+aoSWmT1X31NjFgoY/DmJp+EtCQqsx+J
	wKMRRnV91NgXkYbExoTTQBv0s1Lq6P+vNurLbdLM4athGLHnv8cUxTGSODcxq+TRDYhjM/amHSK
	DuUOXSF/CDzfqCPPev62qwYIj43gGxD8sEZjIGkqzwQAhDbe4Gar2YWVko/EHz69Y79J88u4hD0
	KnxEc5aP2+EoQvmKCaolTOb4W48Z+DvjfcxNV6HzypbCQHecTt1/bmSRaNsAKwHyj/+OpmjUJUg
	6Fw8uuKzk2nLfZydZd4G88MmLKgPK/ftSzfVJASJu8VvlAfaWokL60OMSYUzoXV2gzsoffHC4HZ
	hQSs6W3ya97+Jqdm87LOOJp/GyzDKSZRdlf7x0petj4+poinXZcc0Du4xKlenVQ9qOPlI/QV9tH
	i16ICBq/iQaInYfneYUsvOHW4o
X-Received: by 2002:a17:90a:c2ce:b0:359:915b:81f8 with SMTP id 98e67ed59e1d1-35a0138a16dmr2077633a91.18.1773222025574;
        Wed, 11 Mar 2026 02:40:25 -0700 (PDT)
Received: from fedora ([2401:4900:1c6a:27e8:1c1d:af76:30f5:4937])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a022710edsm852623a91.5.2026.03.11.02.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 02:40:25 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	i.shihao.999@gmail.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	nuno.sa@analog.com,
	mazziesaccount@gmail.com,
	daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	d-gole@ti.com
Subject: [PATCH v4 5/6] iio: chemical: rephrase sentence and fix typo in comment
Date: Wed, 11 Mar 2026 15:09:32 +0530
Message-ID: <20260311093933.21333-6-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311093933.21333-1-i.shihao.999@gmail.com>
References: <20260311093933.21333-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix incorrect spelling and rephrase the sentence.

- insuffient -> insufficient

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 70f81c4a96ba..b5b2c8587749 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -807,7 +807,7 @@ static int bme680_read_gas(struct bme680_data *data, int *comp_gas_res)
	adc_gas_res = FIELD_GET(BME680_ADC_GAS_RES, gas_regs_val);

	/*
-	 * occurs if either the gas heating duration was insuffient
+	 * This may occur if either the gas heating duration was insufficient
	 * to reach the target heater temperature or the target
	 * heater temperature was too high for the heater sink to
	 * reach.
--
2.53.0
