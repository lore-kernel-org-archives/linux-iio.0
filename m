Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B983B3ED107
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118685; cv=none; b=rnJe1LaLm0n4HNuGTeth3QGHw3O1XhFvs4Ahfd/0d0pVcbr6UIsM2C+BfReZ8gyQlCgqhhm2pG3sT452NbTEs54OSCVPnsocLQ6OKfx4ZK2lUy618CAkTHcm7QEMGnd6xKoQKZR3efdOdDI2Neci5pK5+Io8AHw6wuFQGOMCKww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118685; c=relaxed/simple;
	bh=NNWTiEb//BrzQ/xGozL9s9RqDOS1KYPUzlwFVG2TNDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3O1imdXYxeCQW7Ablq7ntvS1sHXplozIaiIxj1CQy8p3tvvgevvao+FYC0NP1azn3dShvyhnbEngzdSzj5Q3+RwqRGB91c51CN6qCRZr/oWZMgtgAnHTdJIOW8z0Vr1j4rRzW0/Ad7CiaAb/yPxYn+4RAfXmEUy847OEsfdd38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyRelujL; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyRelujL"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-89549b2f538so17015866d6.2
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 07:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772118684; x=1772723484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+TBrmc0fLXcmkm0VaaldSqs2PcXgyH2nxurKdQgp9Y=;
        b=iyRelujLQxQalRlxdGj27+QL+6ETlNkXWwxxgpW8LruqdUVmCOVor28GPNJRMvSgFA
         IwXd9wRwo5PldLqP0XEetMOGc/RgXzYFj4IV/lnScG1/8Huja+bvB0QbARlyvGad+xIX
         NdpuWH5VQ5pxuELSyKNawbziendaXLptybFIGCuERUeX+TSyxT2VFMH+NEVaVPuNaFMR
         yqhBs2raARgmS6RkFl/sMg014/2suHf/xx0GjhXxv1Hzrib8HzUFCfxTUT2I5ZwM/A8P
         mZnZzQwF9DVw/6yfxRo6x+n+BjjbOsfgiWsR6glgmCuqs2F21HZvc+EgDTQIG2PG3zN/
         qTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772118684; x=1772723484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4+TBrmc0fLXcmkm0VaaldSqs2PcXgyH2nxurKdQgp9Y=;
        b=eVxUpEv+mt5iL940I1GUGwFsEAv0cRaTmE0G4owE66nkEqLGzU2SiZYQBj0uJQ/oFA
         FV0uOnXKd/p5U2S23zyxUzp0E8lJIG2RHdeMl3MhPxkJsN0Gygyh//8ZGBpnAdexdSa5
         dJQgOdW+jbbaAs1ORF9/YxrfoOG/E7zp0m6sKs59dazJtRGCiKPcaVqxHuiKUC/dXZAx
         txW9OUbTFmpPRDkiZmNtmB22Cf6S5vVJ/OG7keomJ3JTcUSlJaXUroz2lV1nsAFscmtc
         0hAGy5P5dkc5ip6ZljJu9TO2RTzs7qT/LGvRLzdYsp5lYhaPyiAFGd+a0xBescYgF0JF
         qMTQ==
X-Gm-Message-State: AOJu0YzUcXHY4eYtRAfkuEd7ChR0CDTle4ZI4qzrhmjMfOBPIAS248Vo
	PBn26LLp8WGEsk8i7Wk2AAJtqgyamSaLOCJ52hRghMDJLfv+Ths3CXn9EW29lFU1
X-Gm-Gg: ATEYQzwivvFhREqQ7OBsQzloD/R2m9zqD2QTCi8ZYHkMzwV5bll/O3zRD4wtgDP/6g0
	ucf3jW4B3YzkPW3AOP+aFHkJ1ADhbmCq9AB3fUGXvEIRlu5xHt0y+I8onpO4XjhVCp1nDKdW2WF
	q62WfXq7AcwohADMn+BjD/Hh7kRqtA/7bfPMKlU9TsBa9Kktu8xS1FEtn/+dq6iLpjZmT3wf8i6
	TyzqcjLB6vB5YVbnJLeVs1wNsONbcozI6ppq3eHE/32+yUxM3nwIlpQg2AXEsjSkANI6uT5MNiL
	JH/v4sMBco0qpFbThLLOqSsKs/oyKJRx9QdI7VW+T5Bm79EpdSuLHa02BFaqHgWPm4WmfpLGMaV
	iVEm+x1SUP9/un97xTjJ83fjhlFUGu0dbaTLEWeb/b9aw3h9rX6E4Ljm9/ExKrtXVvb/P1H2eVw
	anFkpf5rK5xUUU459SgHa0ExtgFGu7D5Lw9IyHHlN76GBG0xKLbLVgQ+w86rrpaw==
X-Received: by 2002:a05:6214:1bcb:b0:899:bdae:beb2 with SMTP id 6a1803df08f44-899c13fea0bmr67244086d6.24.1772118683547;
        Thu, 26 Feb 2026 07:11:23 -0800 (PST)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c738e661sm19275136d6.43.2026.02.26.07.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 07:11:23 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v6 3/5] iio: accel: adxl345: Expose IIO_EV_INFO_VALUE for double tap
Date: Thu, 26 Feb 2026 15:11:04 +0000
Message-ID: <20260226151108.22383-4-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226151108.22383-1-0rayn.dev@gmail.com>
References: <20260226151108.22383-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADXL345 uses a single hardware register (ADXL345_REG_THRESH_TAP) to
store the threshold for both single tap and double tap events.

Currently, the driver only exposes the IIO_EV_INFO_VALUE attribute for
the single tap event.

However, the IIO ABI dictates that if an event is supported, its
associated configuration attributes should be exposed to userspace. This
applies even if writing to one channel property alters the value of
another due to shared underlying hardware state.

Add IIO_EV_INFO_VALUE to the double tap event specification to ensure
full ABI compliance.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 78e3f799ecc1..96d1417d77c6 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -235,7 +235,9 @@ static const struct iio_event_spec adxl345_events[] = {
 		/* double tap */
 		.type = IIO_EV_TYPE_GESTURE,
 		.dir = IIO_EV_DIR_DOUBLETAP,
-		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
+		.mask_shared_by_type =
+			BIT(IIO_EV_INFO_ENABLE) |
+			BIT(IIO_EV_INFO_VALUE) |
 			BIT(IIO_EV_INFO_RESET_TIMEOUT) |
 			BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
 	},
-- 
2.47.3

