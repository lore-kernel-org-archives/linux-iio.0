Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38F33BAD80
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453268; cv=none; b=TFqIProL23ysxwBCt6K+x8vv9I961ZdierI3h/We1QlBsQJWrWugEtgYeHZYs6vLbXn78Wi/FgOHVdkcM3av24K7xFwzsHuXvgj8+bdYhdpJo/X8F9+Ic+AFzA3pkJMRgiort7r9BU/BVjDc/QuqDPweWXSWO2p+RJ54WHLHJAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453268; c=relaxed/simple;
	bh=ynhxuTkN4BN6oQfGbm87LslmDHKEkF+o1fRrWqA4b9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnGdK63y2RIrp9Ixm7KK+hMn2LQ4+W9H/jC/iWlaMot1kgsG9sLh+1ozFFGUxF7UyXBchY4hBMrthGNTjk7DtrckK9eNneBScdPV//hwOqy195sWTmvyi0HkJ41vXiN8XXUx9yJKadMFWS5AtMaX4WsKICcrXq5uLY0FiUTMsos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtGVe/vk; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtGVe/vk"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so18293195e9.2
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 05:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779453265; x=1780058065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yy2/x0VnVRjssoU/WahnWMqOpw1Hx5k8ab9OpEH/mx0=;
        b=OtGVe/vkLjRCzCZ8z5AUL/GvF/NB6xHewxGfymZXsJVRBhvp+rQlJKEIUGkxd2vflZ
         9Dkyx319MmwXwJrq4iAybE3Jgn/RPIpfOm5gejSN62opsqVrIJSxUijV+H0m/4iCGDv1
         JpQCMcExDKBAeG3sVwkU3/gC6eWnhf+Ug9Hf8+7w/MenIJi8pwwhhC0Vf0GUPqyELUFS
         CdItPBDqlRq92uGZTBF1PZwp7rAbP4SqNioRb/nZeYa6F8too6psLgc79PUPh2Ckm8ha
         7eldN7VPcut6ikGYPrCgwlI/uAJtAPPSFo2S+sP2979RHJGsjJR8VDu6/0HgBcOQxwY/
         GjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779453265; x=1780058065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yy2/x0VnVRjssoU/WahnWMqOpw1Hx5k8ab9OpEH/mx0=;
        b=Kg5G8PURfRJyWl6XRKLy/OBzLoOYBxwceyUbsxPBBNcoINd7SXAci1aRPwy/5yxBa8
         1akTjnU/kkq2B5g0w+prxnoVENP4iTzfthrzHK6SrejxomguveJU3NBh9Iz6xf785Qng
         lcRGs0/TWmR/6XUzwFSfb6Uvnjgm92SLx+3JUv16vq+lRUf07L0rxRoi95GpKbUdBv40
         MVcDYBXZQEQdpxhpkZ3sR/3LupHTKOi/GZFk9OkhyrdJnJtkqqaETorD2uMkv6AlrIKp
         2+5SoVujRrS3qlWGLOSw+A5Ew/BfzyPoBhyiTvcVf3uXP1/+bzouAwyvhReytMZPdOW6
         XHiw==
X-Forwarded-Encrypted: i=1; AFNElJ8+Omy1/HAOLyyKfccD8ezySANunohMLlfGJ+P8CINvD6XizLqOFeStWRNRLMWilZHEEUSxVeaAXHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHDT+d97pXuX0rmPpjUE+mjsDqOV1v/sOsVNh3yJvthiY8uUT8
	4nSvWIklHOlv2LyZ5OhFWQ0xUwJA862PZ092BHEbRkymEcFzFmKp0RJB
X-Gm-Gg: Acq92OHZPOVTcTweiIV8ivVTb7+Vduo6dV8y6UJ/15RmDGcKheYbzJAjxSFbzwuQhpC
	2wKXSXZK+M3WcxdHFvH5SkZWgco+xlisbJIJ2KHuPEMw607aQl1Xxs2Thu+CPhr/KLt+2IO4/mm
	U8qXVOSnmyyNRCv0xsuvhY8RXCGJEdImz4ZvM87vS/SKsDnGhYKUVOx9qIyfUKGsUBAt3S7y+5K
	gqYeJfGMUC7zEv6fR78nZq20DyBSxIecBigPbjNtXZ+tO0Z5z2Ji5DDyWqaE736sTntDGQv1gwW
	IhtmWPDpQB2A4Cd+sAwYzrct6UKUP1ksXGgoNZISwFMMvF6y5LYv3xZ1Zp/MbDTEWAYomjCW1Kx
	DfUjx5LIvbqU+tflKTJ2AFueJN1J87UsCrdibADx7mJ5AmBXGDHRMgc7YJVWX486qkyrdQB1FIM
	0g7IQ2F+53S9MGAct4zewRXRxEmmxNvTNc8kp8GY2aq5mndrJKdl5A
X-Received: by 2002:a05:600c:4510:b0:48f:e230:c3fa with SMTP id 5b1f17b1804b1-490428ddc9fmr45980945e9.32.1779453264941;
        Fri, 22 May 2026 05:34:24 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49042af0ac1sm14760175e9.31.2026.05.22.05.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 05:34:24 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	shuah@kernel.org,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v3 4/8] iio: tcs3472: use ! instead of explicit NULL check
Date: Fri, 22 May 2026 14:34:15 +0200
Message-ID: <20260522123420.45495-5-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522123420.45495-1-aldocontelk@gmail.com>
References: <20260522123420.45495-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace 'if (indio_dev == NULL)' with 'if (!indio_dev)' in
tcs3472_probe() to follow the preferred kernel style.

No functional change.

Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
v3:
- New patch.

 drivers/iio/light/tcs3472.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index b31714040a02..d7b5805108f6 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -452,7 +452,7 @@ static int tcs3472_probe(struct i2c_client *client)
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
-	if (indio_dev == NULL)
+	if (!indio_dev)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
-- 
2.54.0

