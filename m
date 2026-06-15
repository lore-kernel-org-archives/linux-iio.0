Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8423E3179
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781521955; cv=none; b=E8fnRwSC/xVw2XVjmscAQOlKTvoXsDe2GjV6VdESU0BKyqb0DddlLBYBw7SKMU4+coKwZqKrEzL+6+zHKa3VYw2g2hADi5jDj/CN5KfYvXjhUbpoJjwHOonTEzsZve7PpOSLv56BExJ1xAbS1nc/K8ICNZwDLQVxh3c2HWdR4zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781521955; c=relaxed/simple;
	bh=57jj2ELD/+bBbReTVLazCQ/T05lRPdlwkIwnR/LjmCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cUZU/rOYCnTv68N4bti9Sz8qFVoZRUq4VS4dgFFMvMFytxPIjeG/AeRsFSiwmDLVyBho+O5SzwkzZms6swim8Ki/CUhCiB1DqzGXHQ8CbiFNeuZ+wHb+w/i6CjK+AFnZOsbinB3mFW58RVEWJtsoPtbuEjkwnHsqEQ2SjNXGML4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCkm+SQ2; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCkm+SQ2"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36dac5d5d05so1519024a91.2
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 04:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781521953; x=1782126753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WsGLYIEljbmkgcXWOoiQ4CfE404Nv9JQoEZ+rL5nh7I=;
        b=iCkm+SQ22i/pPnnVY9RlB+7y9t7a/+BPEO1nHX+dunrbGOC26HIiJ2y85UWKTAdx76
         Z4Hk2mNE0+J3YmNczGqiz5TYUbnut5vc22OOc50CUlO4KYa4a2FwPzo2AP14+0+7AA6+
         /KS32YD3AaIiRHuxQmwfNlorjNuNqJAGildYXyuJH61MKit+buPF87NaPs/y8yvnqKxZ
         1I4051a5wbshNA6qpmu+Xb5MFj1uybT9fZ+igDNimiRpMAkGHuUfL8ZduzsSvhc5DIQn
         jluTF4rlNihlzGkdPDMeH3vCwH6cvtxT0UHYXiIpq9BptQCMnE0qIIxkVjasnTSiMZUt
         woaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781521953; x=1782126753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsGLYIEljbmkgcXWOoiQ4CfE404Nv9JQoEZ+rL5nh7I=;
        b=doibPIRrh3OtJUTPWDpC/RbqtBPDPBRj6Vf5bF3uwTrzw3botWerkIxN3Sqm03d6FK
         +9HIja3AS8P+jNNK3hXrT+2/g6oP1drvydZ+FqrIP9tHwHeo05DjwDAPDARuDS7B6McX
         LfiDfCMv5tRDiNSoIyIFFNJ9jZi98cKOaJRIlFMEIxtBBqYAGxezNDM6/6VDW7UzzU63
         K0hBtuAe4T7Stn0DXTYQmIcAmc5CjEJrXBL7zASGiSq6DlTQ1UQb38wDmNTgCDsfupWb
         IEJ+kjg74KY0cJXcz3Gh0VStN6LlJFb8hGOXzkcATAl8KWbJWMYVhAvHA/rVe+GiyjO5
         b02w==
X-Forwarded-Encrypted: i=1; AFNElJ+mZmFTVYSSQ8Q0ySUWEjszf9TrTn1p2LQilKlq90E1yTHbc4lmPvjOhsznkyus5xWuDnZ69szP8yM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Q7FjM69/82GP81HV4N62ulCUvRp1VfxP992mT5+636BexbVR
	/FyvErPCqO9emwQPDzDGeUxg1NV6ja8ij9NH0Ll80bwcMwU/ljHcIz8l
X-Gm-Gg: Acq92OG8exTiASqVwebu8j5h66Jw9Ks9w6ZTOeADHF1IVgCbm8Lus4zwDDkB4rV6yX2
	Mxse3sjTL8h7cgJNSkriAhSM4boYAmtQ4yzfr2iXQMTXa04Rm8CzBn4wWbHqsSslt6l1g7rtkvK
	oWgTdRawS+UDz4GYGOt5LhNtb/Cd0mOnKKua76UoRSq71JaovrFDXSGnXV+7HjB6mzCHXJ8Ihso
	62T2zRJxAY3zHmF40wCLKU1qfdLC8DRsein2V/AzYo9Oupzp0gX26j6p/8CENDb5nSIy7ClC8/b
	OiJAXqWg4UI92T6CjY86pwWw+3XhRwBsHvjTY2iksTVmClp+LwP+0N4cM8xgLOvcsxLFB0d2fMS
	Pdz5KLUpH7ZK4zeyvMcr6cC4bOtugE80KCQaiAFNDHNudJc0WYidGIWm/6UhLBwxWdwZGLnXSaF
	QxxlCbBwCrfq2hsLLAuRtV2kk2Gw6uL2dbqDb1aflE/Vhcj2fjEzFN/MGtlBtHvCHj8PX0yK7AT
	AA1rbAV8kQW6tg9ze4=
X-Received: by 2002:a17:90b:1fc3:b0:36a:7da3:266b with SMTP id 98e67ed59e1d1-37c2bd58218mr11637903a91.21.1781521953198;
        Mon, 15 Jun 2026 04:12:33 -0700 (PDT)
Received: from thorfinn ([2401:4900:8834:3eb8:287d:f61a:3d8a:67ee])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a2668cce5sm16969534a91.16.2026.06.15.04.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 04:12:32 -0700 (PDT)
From: Prashant Rahul <prashantrahul23@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Shuah Khan <shuahkhan@gmail.com>,
	Prashant Rahul <prashantrahul23@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Oleg Nesterov <oleg@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ti-adc12138: fail init on calibration timeout
Date: Mon, 15 Jun 2026 16:39:13 +0530
Message-ID: <20260615111156.199906-1-prashantrahul23@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

adc12138_init() starts device calibration and waits for the EOC
interrupt before checking the calibration status. The wait helper
returns -ETIMEDOUT if the interrupt does not arrive in time, but the
init path ignores the error and continues probing the device. This could
lead to registering the device even tho it may not be properly
initialized.

Return the wait error so probe fails cleanly when calibration does not
complete.

Signed-off-by: Prashant Rahul <prashantrahul23@gmail.com>
---
 drivers/iio/adc/ti-adc12138.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc12138.c b/drivers/iio/adc/ti-adc12138.c
index e5ec4b073daa..1f5f4b7794c1 100644
--- a/drivers/iio/adc/ti-adc12138.c
+++ b/drivers/iio/adc/ti-adc12138.c
@@ -300,7 +300,11 @@ static int adc12138_init(struct adc12138 *adc)
 	if (status < 0)
 		return status;

-	adc12138_wait_eoc(adc, msecs_to_jiffies(100));
+	ret = adc12138_wait_eoc(adc, msecs_to_jiffies(100));
+	if (ret) {
+		dev_warn(&adc->spi->dev, "wait eoc timeout\n");
+		return ret;
+	}

 	status = adc12138_read_status(adc);
 	if (status & ADC12138_STATUS_CAL) {
--
2.54.0
