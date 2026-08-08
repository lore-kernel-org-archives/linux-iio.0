Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B3E2C031E
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 22:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786226568; cv=none; b=eMgP7t070Hjh8IOb1tz4dapFQ5FVI51608x82XhY6YtQiP9vX6fpg7ezpkROx1pAADKLiXIzBea/RFoidTj4rL3LxXWgew+VkCFVPDrQC1uW+Tx7eP7rJhNgbCCIU5saDJl/HoQj8PrgA/6Q4TyZzzwdI2yVfV4TK0VV/Jb9X7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786226568; c=relaxed/simple;
	bh=MXNABjwkFM3ygJXG4y9MWDjU26SEGoy9JsAm0VFfye0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GzdvZHjHihE755BFM3F/vlm8uX7tqxYtmg9Hj2T3NkrHP4tiIP6rAcqcDqLD6ju1AfHawCTqHIPUS0nmGeHEAQAFlfA56LE90wuW9BGh9C5kd5VebTFFaRozRYqZtufv9QkNF/V2pGs9dxwk8WQtom+kGJ850Sn5gZ3V7xfFii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLMe0S6H; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLMe0S6H"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dcbade417so633886a91.1
        for <linux-iio@vger.kernel.org>; Sat, 08 Aug 2026 15:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786226566; x=1786831366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9ivHxQvBYprAvSvmBWNQylCm2WbLG79/ppwc2RYVtyQ=;
        b=aLMe0S6HWIRI1eyirq+I2yjRmJxtX03H28hs3vC2w6Iwb3t4Oyz/gYYaqFxUaOYTFR
         WQrtAvc6LIgU+rZVKbJ1XC/Orc+Dn+D4KjBirGUj3uWvVsREZUbwr9Ggmwt0caq/H03Y
         KtSsExA6ehTIMBWfY9qTnDEN7LyrlcQNGUJkKcv8InaR58umcNq6a0YtNXCT8Ne/LNYH
         GR8aYfg9rQWZzjUkrOHr/WWIE7TF2Lf4GsY0PDUTXz5IVaTGIIJ/lF3YFIxCUvp5gqmX
         hvuo60HG5DzcYsuzj1/7it1T41TdmoLPLBL8zrMNGVmQFg1a9BoBdNh3LrLK4pDlSbhK
         AwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786226566; x=1786831366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ivHxQvBYprAvSvmBWNQylCm2WbLG79/ppwc2RYVtyQ=;
        b=RvH1PACDwvXW/H8yXVu4iQGcruJVqPeRXRbK8vAsJE3PuAybL4sbYnWvMxrwfb/v4X
         nXWRRX8rqaThPufG3KL4xE+JCw9+VwOEcGxPEiVYrgh7XCICFrIsMo/ZqM0M5Y8UrLVV
         bDL/Zb+3JiT1vHPtxjm4YKnXak6jJEui1YJ8ZZf4tiob3w7zMPMIC5s1YB8Rnldnoev/
         QGugm4DERExViGEPM5xsVPqX2vxoqpqRIUrGXeKEVGzCb1XjoWm+hzmq/PsQnSSlE8ik
         +D0WXBDsxCUY3ujb+HuNwda29vbwnRjnrPCFdA96IA6eJD5CqrrZrvrea1EdjCRq2v1W
         3PGQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp47fASXzHkFDIQuN+93NXo5Hd35UOeJxYVw9dZp1nuUbIWLspc3h24ZUBEwTv1+vRexoWYtOTAgDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0baLii314Ka602KhZsYMnEDpp+KTuHFRYesAQdXBCeYd340zP
	XEqFyOnW8lyZIBiQAzZrBRhYiK4d6jL+zv0T2VR6SADkY01dflJ7GPCw5dgcHYKV
X-Gm-Gg: AR+sD12RxhvZ7ZH6nHA7PB7eYEjMjnvZfDBOHjRxLwkl7eE/bqWYlXbn0jJRI1EzPhd
	zoLD4007DjZleZgkWkIr/3VI/E+4j6huK1fnriyZ+kTeawKynPcSaktGNI9tL+OadGt7A5q8Je5
	/etAhx1rNU+lVVEE9Nc7aQy3EzNrb7h6QG/ijI6Iw82x6FL0lWAWHuwAElrfNYlnO6MZ4qDDlIa
	l23VIoVvM1jsAdMxfOqBS88yPOemI1NKWQjAJ3I5bMZ7cQ+2rFpxOo7erFtIwDkZD7sl7DBdfn8
	9xUObPwtXnI4r6hrv6fcegPgYJPfwG0SqvaNC6oA6SDZwAa2Q7QSeDvjPqe9lgFTWq/yXPbi2Hl
	rFHoQr7U/ogKxNg27R7l8Ot+w5KVF1rs2xdiWc8VKlisuWfeu0hk/exuUwiJKPE44wL8jUEi48+
	dI9MWY6/dJ5dxzFqk4Bxa/PcbVcN0bMpfcRpU6+7K2L2V2D/8ifY695wDu35mfjYyKgiRRJn+77
	B4rKGI6
X-Received: by 2002:a17:90b:5112:b0:38e:542:6485 with SMTP id 98e67ed59e1d1-3903c5919c4mr34140068a91.12.1786226566256;
        Sat, 08 Aug 2026 15:02:46 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.. ([2409:40d4:1066:5a44:df99:5069:f01e:6025])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085f2b2easm9490571a91.11.2026.08.08.15.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 15:02:45 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yash Suthar <yashsuthar983@gmail.com>
Subject: [PATCH] iio: accel: bmc150: use IIO_DECLARE_BUFFER_WITH_TS
Date: Sun,  9 Aug 2026 03:32:36 +0530
Message-ID: <20260808220236.421832-1-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace bmc150_accel_data plain buffer with
IIO_DECLARE_BUFFER_WITH_TS() that also keep
timestamp aligned.

Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
---
 drivers/iio/accel/bmc150-accel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
index e8f26198359f..e0773533efeb 100644
--- a/drivers/iio/accel/bmc150-accel.h
+++ b/drivers/iio/accel/bmc150-accel.h
@@ -64,7 +64,7 @@ struct bmc150_accel_data {
 	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
 	struct mutex mutex;
 	u8 fifo_mode, watermark;
-	s16 buffer[8];
+	IIO_DECLARE_BUFFER_WITH_TS(s16, buffer, 3);
 	/*
 	 * Ensure there is sufficient space and correct alignment for
 	 * the timestamp if enabled
-- 
2.43.0

