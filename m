Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E96367B90
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489177; cv=none; b=jRaFYG4TYKDdVI545EROibkUWKyfNbI0EsuFDGgu3mQkYl4+x6jA2n+uNBHZrRtlVJ+b52xbDDEXdMvSppiMr4AuQKcLv5oQC4obErwr/6GkY+RNch2AsgJWAqgaM7UiX2UBqHrW1Gk+N2hEbIcMQmrrWZ6ol3qdazAPxRN7cUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489177; c=relaxed/simple;
	bh=Yt/JxUce6IhMqUO9FwATbcqq02Llm7nzcJqjRKevsQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q5yklRpJgYOoi3OGGnY1+lSgVO0PpS60yTdxmMqxJd04TFAMe/qfu72zYdOR+/IK+hjK3V6fCN1n/yFMvs3UPivJMAFN9hY4Bij7XFISEmd0ceJsxkkQwn3fPX1Z7wVsQmSZ/GnOlyprj02P2/Nw2E7ksO9ToQKQTtjfoMZdo+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkUtqRZk; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkUtqRZk"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36da151a152so2516552a91.1
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 05:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780489176; x=1781093976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pFoR23DydmSAorwZ58Hs6gBKs13ppUFc8z8JdA9tJm4=;
        b=TkUtqRZk/BsilHu5JEfC8CKcsVTkv1zLCSWS/r4knGpYFQ0i3qmd0mV/Cji40AuHVL
         cKKQoUE2jgMa6frG/Gb7v8LLZFHOzHZFZ5qNP0wSrOoCO03BR3K2bKovDaCyw8LFfPYq
         1YaA5cmSGhEecS+6NCkB/c6ZJW4vi/YtfJnbNOv9HOOWGxjTN/7Sfz7Se9jJX1C/e9jz
         P0Q4rlbi8sS/0dncrWCoWNQBS4huFnY5zyd4vctBTfWWkE347AdbmpUXyhJePflZz3eK
         kzAn/7QaxzjxS9KWbrjjfD3P79i0W2o7KcBXgrcV9uBAF3TU7MH5368fhgadwmJ3VQ+2
         Q2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780489176; x=1781093976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFoR23DydmSAorwZ58Hs6gBKs13ppUFc8z8JdA9tJm4=;
        b=Lf7sOvtIAcPSrv4AXQdJfDkl1bFPzCEPwMxnQ9eJf4YhIV+EdW3cD/es7QrK4r/6j6
         tIb6hXzvBNy6c02VtTAS7mOoR3fNGOfoWwuENqMVljxjS/ZMQztDVBQo1IR2+LysZMYT
         I1pjR/SREiRmL0hHJygN9v65vUdlbhMlAKRltTI0tOBEI+NsKV1YN2vy6T276TTud3d4
         jqpF3b1fEULVEjRZMKyNoeY1JagdUyVVOOVf9bKmj8UtJS4HcGkyUZRWFZix1fHzvgj9
         uGHbrKoIk37ytcB7kS1RGFP0uNPqwA+kBWUT/9TgVThUi4OaHS63F6p5bmN8PMQOCLoM
         9EXA==
X-Forwarded-Encrypted: i=1; AFNElJ/iUliHCmnRNNiU8laruJajGi86kwnyrrIl6TiYsfAoectw9ghTdrJeu+rUf37OKhKst2oayExhpTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnDcT6cBGfh/Tw20dGFwLZRWxq1/QXMWL8+848K8pbCzXjW3C5
	pvbq5E47Ea2/ZfsGBZUtYri6sAbRGd2Um1DrWr4KdzfUiC1r2VeEXueF
X-Gm-Gg: Acq92OEsO1KQ6fCnvcMtI6i0kYEs7NNtEkar6FdDxt/q4CskJesRo4jEgZuwqLs2Llq
	3g7bukKXr7XcAGjUfIKesqMtv5spYYiIpbMy+KB26U8d6B7V2YV3kNofq+yejvj33PiUTmjcJcZ
	2VWDveScSNq2z1l8dAu2dlrIomkBgGIQDUa1/+0NxhwfhLY+yO0iWI+bNFH3JsB7nyilwAmGpJy
	ZMwmDG2FnEkTz+qcu7aOa1NIyJlK0UXQ/bmtuGqhqLXDnk4I3/jkxrTIUG45uKt/N8NpFstamvb
	FFZWJoqXYct9G+BXxCfiRU04rttmzOI6c+DB50bVa0BLnA4Fc31orki4zS41Keo3TTHjsgP/DuF
	dIzVeeP31wkqHV3s1DqVBZc2bgO68ORDzL5qL3ZMwSLYqQZOLkG+8wNin7R9PhL9suZLbItyRhu
	JIbdqw2/UdWe0I6smj
X-Received: by 2002:a05:6a20:7289:b0:3b4:6af6:faa3 with SMTP id adf61e73a8af0-3b49748e7bdmr3401962637.10.1780489175782;
        Wed, 03 Jun 2026 05:19:35 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282375f2dsm3150698b3a.19.2026.06.03.05.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 05:19:35 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Francesco Dolcini <francesco@dolcini.it>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] iio: adc: ti-ads1119: fix PM reference leak in buffer preenable
Date: Wed,  3 Jun 2026 20:16:40 +0800
Message-ID: <20260603121640.1394763-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ads1119_triggered_buffer_preenable() resumes the device with
pm_runtime_resume_and_get() before starting a conversion.

If i2c_smbus_write_byte() fails, the function returns the error directly
and leaves the runtime PM usage counter elevated. The matching
postdisable callback is not called when preenable fails, so the reference
is leaked and the device may remain runtime-active indefinitely.

Store the I2C transfer result in ret and drop the runtime PM reference on
failure before returning the error.

Fixes: a9306887eba41 ("iio: adc: ti-ads1119: Add driver")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/iio/adc/ti-ads1119.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index 79be71b4de96..9324408cb3b0 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -459,7 +459,11 @@ static int ads1119_triggered_buffer_preenable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	return i2c_smbus_write_byte(st->client, ADS1119_CMD_START_SYNC);
+	ret = i2c_smbus_write_byte(st->client, ADS1119_CMD_START_SYNC);
+	if (ret)
+		pm_runtime_put_autosuspend(dev);
+
+	return ret;
 }
 
 static int ads1119_triggered_buffer_postdisable(struct iio_dev *indio_dev)
-- 
2.43.0

