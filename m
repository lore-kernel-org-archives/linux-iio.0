Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ADB36AB77
	for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772182717; cv=none; b=qJT0r1aRUC/S/IUNrDuNVLs63ZGUcFeMqqDZfoMMyuqdtR83wEAMYTjuH0oNdLKJnJtun4bhplfVlu4Ec0GL89o1FTz2KhnxNGabcGmQ8QqUV6uOWmpvfjDtyyHXGYzhrjV3zbKzjCx6szgOuA4QMlCfOxUQMTowNdyQUFLUF2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772182717; c=relaxed/simple;
	bh=zwDtGyosnSZtNt0+04+ZrbW4hF3PzMfGOQmCDyJO9+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MTmeLcN0o9iNGi7SuDf3V+7cD7/3Wo8WfoWZlgdvOvcMZr+2+LiiLNIjTity9ctOn55mwtU49CbSY7NTi0E5zops6tRHVWX1DWlJE4eN9mGi13hiGm/b8ztOHfp+DiuhFCPWNZO4O99RuxH67gz4N38uljOenc/P3Qn6ea/vx4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rrmme/vL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rrmme/vL"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4832c8f9d87so2490235e9.3
        for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 00:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772182714; x=1772787514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nn61zq6ju5lIcYbyn8NUOWuWxNQAT3po4ZNh2x7kfao=;
        b=Rrmme/vLbjX06OMJ0LXVPr1de/Zw2C30JTopDPkoKYmK84qVcfn1H4OTZvKrA78Qij
         3z0/pVJKjp6DHk8MhOpYicqkpTiauKI53+zGbkliD5bnm+99mCDUvFGtign6kWD+GKYX
         M87/2DbUP4eW1ooP0efBbwwKDZTVhCxdHBJwHHW9tA0e13PmzQm4UxmbLlZ0SlAmZ9Yv
         8UR6j5hdIyUufRPwaYTGXvlcIHKCTr/RV1UsNhzlf4kAnGXcKO475wUCmcCAR2AYo0hO
         qAvLm1Q9MfGK9Y+qVqT1wtkjpU+xdZJOfCVmUD3ut0l7TFlg7FYTMkJ/eSR50MbwkZAs
         zjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772182714; x=1772787514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nn61zq6ju5lIcYbyn8NUOWuWxNQAT3po4ZNh2x7kfao=;
        b=vm3vf5C5KMt70YoGa2CD6Sm6BDQLfK64Bxty52DORzhLnS1HuyhV4hJh1jAZvl0mY3
         ihfKstdG3uKPUgPgneUaOyFDQ58j/yG9jLbOwK3EIe0e/veqV1vs4OWBZMTsWQADRBDD
         eysKAruLqRr2dArfLjYMmFYPjQLj8CXWzvsoJFo+2U0X+h4aVh7LhreTzhvpeYvw62ee
         RAtp8HZmgJ55sVuqReSvJe/yyqjSeP4zi4/2kutkyH72w6FVs3C4/lx03ZOOML6AOJ8j
         ivvAoDB6DkrwLbHZ2GeAUsEDHMQ7q7Xi9ujCy/hvo2oq4bfFaJU9M1WPaPrx3gkP3AMb
         GgOA==
X-Forwarded-Encrypted: i=1; AJvYcCW1J1quP5QHEOEItDPfTEMzwJ9yUwe1VIF5bBxjG096P3AbPNS38cgKM4SkU2CVo53u8IVZIaqk94s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIH70R+yF7VGXIDZ2FnIurYxdnBc5kWpUm6IZQM5ltHfeMAC9Y
	cvzx9ZzwISe+8nhOjvUmb9c8D4lE3m+ts2ekuVkDw+6cDvhP+ydFhF5s
X-Gm-Gg: ATEYQzw3bceE80zZQgi7J69ddokbk10ecSvbZfoeBVi/OzXk25fmTuq5j6eEVHNnRlk
	fbvqxKFRo2AqTU6IdBUzN9WjrCfZdk9i56N3Tk8tB81U6/z98qlQye4Y0ZO70W7DH4G3tKlLnLS
	XSrCdyhKk67YBP3SHqYVTTp2BedPxvwQ7EHUc2A7lyvvnD69Scrqlige7LqcN13CDT5babhTJmC
	42R41lJUXY5+j34VQ5Au26zS2JPwoLcESYppX1MlOUrrTcZq5hztsLb97WwYs5dk9kgFOAcE5zG
	aqfav7HHgeEmtouWx7Z++5VmqHyAs6KjfqQTy17GCC9sJrGsAJFtPydNV5wL766saeBo7JbjG2Z
	kbQzKh2gwH0IUF74owT9/uDwbKVzMLRQR4ZMChORc4K9lgQhNodbxZvNBXJOi8bmJZDsW/uYatM
	d1uEf5R6LErqpMedR9m62br8zvvr0gqnQeGrssx41vzvMFfnG9mZ91EGNUMJEMH59K9+s5H1KOa
	ccEY8YsfoJMhCJugt1z6X7Xf6TyNj8/TWJv0NTS9lMoJcIm7+J/nmL/Lu9ozGI=
X-Received: by 2002:a05:600c:474e:b0:483:7d93:9fb7 with SMTP id 5b1f17b1804b1-483c9b99876mr16105285e9.2.1772182714106;
        Fri, 27 Feb 2026 00:58:34 -0800 (PST)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c76b20bsm5654788f8f.35.2026.02.27.00.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 00:58:33 -0800 (PST)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH] iio: adc: ade9000: remove unused AD9000_CHANNELS_PER_PHASE macro
Date: Fri, 27 Feb 2026 12:58:13 +0400
Message-ID: <20260227085813.46417-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the AD9000_CHANNELS_PER_PHASE macro which is unused, has a
misspelled prefix (AD9000 instead of ADE9000), and has an incorrect
value (10 instead of 11, there are 33 total channels and 3 phases, so 11
for each).

Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
 drivers/iio/adc/ade9000.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index 5dcc26a08970..4be8df34428d 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -283,7 +283,6 @@ enum ade9000_wfb_cfg {
 #define ADE9000_PHASE_C_POS_BIT		BIT(6)

 #define ADE9000_MAX_PHASE_NR		3
-#define AD9000_CHANNELS_PER_PHASE	10

 /*
  * Calculate register address for multi-phase device.
--
2.52.0

