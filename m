Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9984A388361
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651719; cv=none; b=lDWiXs12yB6/I6ei/4AqPVZVPO/OtDnbzcpMelEmxkadBXbDql4X+/MnthzkHwFCg5J9BuAHa59U4D/a5HUaF1Pz4YiBpbBS2Hiw0sCQYEDEB6T/emrUhTEarICDOiUAVsR5SWEwOnzFij993aNGgKiL2IvN6vgnYuFYfvuy7Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651719; c=relaxed/simple;
	bh=nGVuAV7D+S8fSHs2kB1/eYAHHyt/9b3rTE3s/a4PtHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LXrT/XufJMIZCKFVFCng5PrFaaf0+H6C8eY/v4t6mi1OqkzAsBtHMqbIEhdxnCCcgJZlCdSb+lQB3Ou1ebZDujhh7o0B2mpYQTbJHRDZdZiDpa6YV0xeEHNPMb0tZIuztR3gMYiqgqMxPAFaR59frw8P4g65dyNqIIVnU/uRWd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWNQrOsA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWNQrOsA"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aae4816912so28352695ad.2
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 02:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773651718; x=1774256518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHq/CKBFoBWzeOSP0uPpRSevGUNZS3G/3vF8FZDnFHQ=;
        b=MWNQrOsAYpYLjCGPEJ/8xNCcMs6YR0zvvL3StD4Bk0L86JziQR7QQlf/RBmz3ZKgQm
         aNEiHIc4H9Uqy7+V+2wVBsCZZ/D62OIZkNXs8Qgj6dZk+RcvopsGFBiLQgx4Xx2wYNSR
         dDKi4W1XUV4zvYs/ZK+ewD/0P2fuxGpLyFMoaHulH8Tr3oD2xQQCC6Sk2fbAZBafRvoE
         sTBoIxdw9N3FVuTPoOm7eSS+YbImOOjU+l5AO2xnoFaqPpymOqsphvyJdVtzHeE1pvh9
         fs1kKYNN7YUlItGnOA4wB7xt5XomaGPP2+HzvZweu2nSI+FsGzIXuqWPAiJAsGYpTBM5
         KVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773651718; x=1774256518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JHq/CKBFoBWzeOSP0uPpRSevGUNZS3G/3vF8FZDnFHQ=;
        b=C6/IbMpNHrz7e8iXME2euRbuI4YDBZO8BeXxGfkSxsfoWyeE8qH0nKGi+PSauo8+/9
         CSLuCQP4vTdquWuk1pl6jbO9nudJbsFmWHlacMKKqf+7CAMcZ8S4YXREUbHIHt/fE3/3
         qpR0Yf0uBKAIrohJuSj8r9qHc8HSK+xG1rb6NoapHnQsFgtmVWKJD0zUoKAdxy6mL1d+
         6R7MPwwW31W7KLAnH5Lf+DY0Ji89JxV7tqzd5a4J3IVHZkqhmx3d1/wqHgqEXBkvI4e4
         c2XM4Jv+hbKhwZ29dzmlql2cL66/uTzCvXBRSyH3A4Azd/B7lgFoejeAcKhLJ9Bqg6xb
         wdvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOsxHtWHZ4PyU4blN4ym34zfD6RJKWyf/aGoWzvh/jnHIUJECKMa81qYwnygD26FDzxcg8ce2Pijo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1gbzpRIxSOjQhOLTPGyphpTktRTXoqr1sj1bh7G/Wl2lF85+4
	5zk6aXdePOPcZvg1/SboNV7qDsm2Q7IuCTKkYzmBaq87JDRVwaKln+be
X-Gm-Gg: ATEYQzx8kSbiUZYd28FwqW6LNDklbOyagoQ6pkKj1SPQSaY10BY1dlVZlf9s0YOVBxa
	gdvLzwAWwDQRnIk2dVfsoJQ2pHuFDxhS0O7kcg2+moTWRhPSPqWxkIUOISfurBN895KzDRixFRS
	UXVJtpkNsYOVtREu1lTLhZ9Iv2J0BEwAxtO8QtceBC4CQPEtcb0KZ2TArXQF2CxFGE0SbHuqDUs
	uCsD08tGK5PA/K1zutkVQX21OA2W4qR+0WegG7XHGvHtd9pOuR9bmyEBCOWv1vO0aTTuWUDm8tz
	SEKRsGvZRUoaXLgzoFMwH8V0wqAkmujxjWpbKdqrYYaAJNVJuvYiK+LWWknj8ukEv0xxMnXxY4w
	lAIc9dvhsc1ACWd2OQBdM97Jm0EnRJZlGlggw5iDDmQc2wvzFaiMynvgn1A2SguCvhEduJR1FHR
	7dndSSbdW9OWefbsrHvRdZWswT
X-Received: by 2002:a17:903:230a:b0:2ae:45b3:b688 with SMTP id d9443c01a7336-2aecac5fa42mr136507135ad.45.1773651717900;
        Mon, 16 Mar 2026 02:01:57 -0700 (PDT)
Received: from fedora ([2401:4900:1f33:4eeb:289f:fcde:6da5:35e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece868172sm98105835ad.89.2026.03.16.02.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:01:57 -0700 (PDT)
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
Subject: [PATCH v5 14/14] iio: amplifiers: fix typo from Curren to Current
Date: Mon, 16 Mar 2026 14:30:22 +0530
Message-ID: <20260316090023.14691-15-i.shihao.999@gmail.com>
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

Fix incorrect spelling from Curren to Current.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/amplifiers/ada4250.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/amplifiers/ada4250.c b/drivers/iio/amplifiers/ada4250.c
index 40f396ea9069..71e361af2074 100644
--- a/drivers/iio/amplifiers/ada4250.c
+++ b/drivers/iio/amplifiers/ada4250.c
@@ -109,7 +109,7 @@ static int ada4250_set_offset_uv(struct iio_dev *indio_dev,

	/*
	 * Compute Range and Voltage per LSB for the Sensor Offset Calibration
-	 * Example of computation for Range 1 and Range 2 (Curren Bias Set = AVDD):
+	 * Example of computation for Range 1 and Range 2 (Current Bias Set = AVDD):
	 *                     Range 1                            Range 2
	 *   Gain   | Max Vos(mV) |   LSB(mV)        |  Max Vos(mV)  | LSB(mV) |
	 *    2     |    X1*127   | X1=0.126(AVDD-1) |   X1*3*127    |  X1*3   |
--
2.53.0
