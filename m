Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D452F8E88
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 20:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778444542; cv=none; b=u2NBKxWg76/ppzfiPONQ5fBsVA16rXJP1sbX+CxPHzbA7O3PP8fOHx97F0OCmWfAGhCCn+HODCGjk04kDZIqrAY0zWggzzp7Z8kItVDMUrMo+eKlJXDgMX+ZohdG2woRafXgE1wYs0Y/9WVsnUpDAipPc+klor0G1Qc2GvucMok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778444542; c=relaxed/simple;
	bh=PgxBvEECaNV9lDCHG6KlZlCxWTUwvbOYjz4vBvzGJIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qsL6cilxOJ0/aRh5VNnInfKovHvcFuPDtgt2fOqzFx6HciPJs5kz1xPh/28zT5YGyjcE3hBaKBfI2CKtSfGWBCgkR6ZyW3ig/p0ni4ALqKdPJL/6oRMTkoeOeK7KSBDqF2iCh0f+7QPTstR97ZnyOEZVr8COuM5WVSIKveIC07M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJi19RqX; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJi19RqX"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6841e6a5e51so1805085eaf.3
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 13:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778444540; x=1779049340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a72k0bShD/ZLf1gHwBBpZ/BxeW3UotQV/FxlgsyhPBI=;
        b=fJi19RqXy5EWZXYvzBOFqeXL5pLVnCdMdJk/LnAd4qxI8dyT58iHSMCfFcvOs+EF16
         rMHL5DMItoSL2SpzpVzD3mKxLHKxXToAtzOV4bmivVyvxm9Qb1fEn361UttMTBgZBF4z
         PZe4mLov26EQYX4KvYD2kA45Ud7jyy58jGLx7tfWor2QBHND0AC36GTT4KvVybgieuSU
         FXWkmxNUqd+RNw2Pp/1Jlb316IYKEXKNcMXB1msqY4pBy29tEmYDNIjmJ7DEqujK8CvH
         ii1jIU9ockW9L6SdZ1y0dwX0lgpO1EbkP6+XAmby2sLcWbO4brbBoujZFikA62kBILLV
         A9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778444540; x=1779049340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a72k0bShD/ZLf1gHwBBpZ/BxeW3UotQV/FxlgsyhPBI=;
        b=TOXJ0WnK8+3VA496oX7rDHFwX+EmyycswGJROL31aIdcA7/HXPT2JQsHMQvHaTALo/
         91I7/i6d0gWWEa9Hea87zXPX2dAK5uwxZe/WPCcHuzpvSInObZ7EsgFMeMzFfS91M9zm
         /yRc4RRtoTnSPoocfLcNZILDaBy+L3Hg6li2dVhUiqKVPmIj4ZXVPCBQA4XQmizmVvQu
         PuYG0u2eSnUZ1YKH2qv1I5YukOx3DgzVXsyVawSYoE82L/7x8qBqPtjaFUJkZL9kzSBa
         F7lIKciQLykAc7AevZSiNdoYq9YKXJmwwBZFLAbi+XhxVkFsHPXwBSKQqTrVAsO/7E7c
         kI1g==
X-Forwarded-Encrypted: i=1; AFNElJ8JfF6lvmkinStZaXTECmcqMcP5KSYYv1k3Xp0b+ymFk36rHx2UirdLvawzoX5v9hH8wd7oKqH0qLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMCgLC+gi73TQm2103+3GKVrBOnIHl3Obj+3CUo9SUDPxkTSPQ
	vL7W+UDr0dni16AfICpmdXWpU+gtWKCDfAgVgC7hl0wubY/zh9GODzetHBhVRgpto7k=
X-Gm-Gg: Acq92OHyW50jbmihC0JuDvPSRth/dbDrb8BaE+uEPeVNlWWZM1rzl3mQ+XwWRORhccz
	7vDUC4P0/rQofDjYg3XjgkvVMzfrHepb0tTxfPG46Xz5Kr4h56Mab1SCEp4t/RKl/cgIWvdHq3I
	G2eorHwQPcdopa2a+QwlZS9oOGoBKUN/EtZ3HbkztBn9jLOTO8uTMMNVMG3S/n17JVKc3KTBYdi
	JSlMdoaY1yHOCSnxmd7ajUWfPD95Dyrft0qfiRVwSJVZNmBMHRlYDzpVaexcF8zCX1jymPxg8+k
	dTV0sfCyX/oRndo1w0Oix6vzuC6cXdXSYxVGfl1MDZcVbCUeaXjcl0wdlioB8xHYrVZjQJyqKTq
	YzTUNESw71SKWc1VPO4TlZRNMWi7KjyFzokwEzxTvqhE/yLD/G1W/AsixKCK4zu0hGLPrW23kWW
	gj5m8JcdWXskYA7hlcCdj06sdu6gNRQknbqMBNd+0UY25we5RfqllALsmubg==
X-Received: by 2002:a05:6820:1793:b0:696:6d2c:92b with SMTP id 006d021491bc7-69998d1d63amr10832287eaf.33.1778444539780;
        Sun, 10 May 2026 13:22:19 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25c1ba56sm4772691eaf.3.2026.05.10.13.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 13:22:19 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: chemical: scd30: Prevent potential divide-by-zero errors
Date: Sun, 10 May 2026 15:21:56 -0500
Message-ID: <20260510202154.319585-3-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In scd30_read_raw, the current value of tmp in the
IIO_CHAN_INFO_SAMP_FREQ case is unchecked. Add checking to see if the
value we got was 0 to prevent a divide-by-zero error.

A similar case has also been found in scd30_write_raw(), also in the
IIO_CHAN_INFO_SAMP_FREQ case, where the value of val2 was unchecked.
Add checking for that variable as well and return -EINVAL if it's 0.

Fixes: 64b3d8b1b0f5 ("iio: chemical: scd30: add core driver")
Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 v2:
 - Switch to dev_err_ratelimited() per sashiko.
 - Fix another potential divide-by-zero error per sashiko (see commit
   message).

 drivers/iio/chemical/scd30_core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index be8c055be184..3851c9334c8b 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -237,6 +237,16 @@ static int scd30_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
 		if (ret)
 			return ret;
 
+		/*
+		 * Value of 0 is unexpected but possible if hardware is failing
+		 * or noise on data bus
+		 */
+		if (!tmp) {
+			dev_err_ratelimited(&indio_dev->dev,
+					    "Invalid measurement interval 0 received\n");
+			return -EIO;
+		}
+
 		*val = 0;
 		*val2 = 1000000000 / tmp;
 		return IIO_VAL_INT_PLUS_NANO;
@@ -261,7 +271,7 @@ static int scd30_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
 	guard(mutex)(&state->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val)
+		if (val || !val2)
 			return -EINVAL;
 
 		val = 1000000000 / val2;
-- 
2.54.0

