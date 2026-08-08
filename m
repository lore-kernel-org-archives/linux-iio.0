Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ED837A493
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 19:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786218894; cv=none; b=QcBHjr4vCQJOD87Wccsgc9uH3Ux20rcs5ayCUsdTV0XaQge21eL3UuQo4lYLQlaMYBDPHTWjFbRvnIK4Mjtwxh3Br/zA4VUMz6//gDhxIhF3iS3v85lDtBXwSKIuVasu+hvG6Ey1JX/iAHBu5al4veYACjVrUTZDWOV309Nq0aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786218894; c=relaxed/simple;
	bh=LAYdKgYH2LETrInYKwmyGak5xlAjQWWRuxSevJGDLRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZaFUpLfHk0kgf6CeUvANCKVH/LPoRli6Fn68zI9rB1JkvS/a/dghbWQDHJzmNRejJ7ToCQ2ZvuU3XBMMV6qIxjKbtna1BViOzeX8lu+WUCLlVb+bEwrF5krw+8hUivl2sqZmAeRuMyGbPEBbv+ki2qiAfMvh1YK7XFL2bg4NAlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZdsYcB+; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZdsYcB+"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92edb12cdf2so33509485a.3
        for <linux-iio@vger.kernel.org>; Sat, 08 Aug 2026 12:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786218892; x=1786823692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sOAgnp60dRGNij8DkDy6LUPtj+NkpvT/nYa8rtSuzhk=;
        b=YZdsYcB+i6R3D5hNu7AcbsdeYrdFpFqiEQBMRzwNn2Iv860teqJEkiQ1eKzKTa3eWZ
         p/K9vFBzY3sdw2rZXA78xtB/x57uj+q4y63efbYOyujPlisqab+bQxWX4hFGo96+dD7w
         dc/paAPpM50NuE2z9/VIXoIcALformLaXjWzAzLkBpXq06fB3OkN25Gk5T26FzMxQzjh
         c3G2CqNKZuc7GQpH64vQn9QZod5ZllMCMmgZcQbmXE7wb8htyAlfB4ercFtlW6Q4+QLO
         VGMkPdTnMzzBmfJ6P32XI6fd9CaIMn+Wddc8Y7RJFby5IA5TMTRGXe3jWjim6UOOav1h
         ZqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786218892; x=1786823692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sOAgnp60dRGNij8DkDy6LUPtj+NkpvT/nYa8rtSuzhk=;
        b=M8YafdoY8iTa5VbR4XQ/+CZMjqLg0UjWnLcWDrsFf0RE+6hbHYA2HPMvcUO0+hKZuw
         C79232bMpssMS84VaLs0+/t1CtkSxRUf572s0fNz5BLG9BH6rgLLCRhBnGrrVlxrNmqP
         h77RcUFuKEq9twUqQus/PKBfWqTMRJt6aMmbrZdiHijb8J8k3NPdyglj3mYz4IDISpzM
         PyeurA1lPXsjTUUbP8Q/ozgCuKcocM3rMi2Gxek2awZbop/0BiB5Tyx+JsRZvplFIII5
         +3lJPqSeDp3I+YBcB+q8UsyrpHsIDbXV4tfJ1kUyCI+SbjyBUv5EM8l8C7om3GwLUGY+
         I75w==
X-Forwarded-Encrypted: i=1; AHgh+Rot0qyizQmOHv7uF0w8xS+KiM+r+4Bif3GRRcTYl2xuSrkX28b0HodAO6jMWNzxT+DbYfhOg37K15Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNiVKqThRSRY+s+JmTi3W4u6QyF9EPT/6PUCTyYLYm6pWbNtvQ
	YEe1O0Kmsg4i4LFRd9zmfZHNlNLgAQJIxHHncS4vF2D6bQ7AKVSZUINE
X-Gm-Gg: AR+sD10Ws+VEnYaw3IkC9VycJAt1AbfUPJdlG+xSHN0U0/vJzRqDjnps7aR7aCltkUz
	ZtIkBGmNVGkBoQMrM/zx9JXGYjUVRWfZaO3bfiS1POgPDBnso5hcbG5R4/Q3fDoUNK/B3MYxzP/
	5+MWzNiY6nPhcWqF1DoIep1av2hp/QFNLXolpKm52FAhXb7ECKT8ZS9+nL25vghBfBCruiNztCC
	kmJ5AOwA3LSU9nlSpXHCVV4hBVcvtvF2ChNccdR8EEZvt5orLUeshMMGO2e7zesn5uAdzqu5JZk
	65ppvF19dQO3PvY/o+8IYCdaOwMWJRhmlOd2C12M2NfKhGIOvIndxILvTlTEkwuP0QsT6dhlLSu
	8tf9phgqjXErVp/BRsPV+gKH97lLbVwpSFQ82byjTfB17AUKgAhWHjJH5KE56KC+KBSl05QGB1h
	Yw2lgi0ja8MIEpbf0Up5axRzDRcAz9iuOhowf7w11DNqufes9c5buTr5AKZAsTYnceEEA=
X-Received: by 2002:a05:620a:440b:b0:930:b19a:9d5e with SMTP id af79cd13be357-93671b4bd40mr1229795085a.1.1786218892023;
        Sat, 08 Aug 2026 12:54:52 -0700 (PDT)
Received: from localhost ([2600:4808:5693:8201:394e:8b9f:994c:b59f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e02d54esm429122085a.6.2026.08.08.12.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 12:54:51 -0700 (PDT)
From: Marco Chen <marcochen.dev@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	pmeerw@pmeerw.net,
	matt@ranostay.sg,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v4] iio: health: max30102: fix NULL dereference in interrupt handler
Date: Sat,  8 Aug 2026 15:54:50 -0400
Message-ID: <20260808195450.25420-1-marcochen.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interrupt is requested in max30102_probe() and stays enabled
for the lifetime of the device, but indio_dev->active_scan_mask is only
valid while a buffer is enabled. When an interrupt arrives while no
buffer is enabled, the handler dereferences the NULL active_scan_mask:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  Call trace:
   __bitmap_weight+0x64/0x98 (P)
   max30102_interrupt_handler+0x48/0x160 [max30102]

Call max30102_fifo_count() at the top of the handler and return early
unless it reports a FIFO sample is ready. Because FIFO_RDY is the only
interrupt source enabled in max30102_chip_init(), an invocation of
max30102_interrupt_handler() without the FIFO_RDY interrupt status bit
set carries no data to read and can return before touching
active_scan_mask. A negative return from max30102_fifo_count()
indicates a failed interrupt status read and is treated the same way.

Fixes: 90579b69e94b ("iio: health: max30102: Add MAX30105 support")
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Marco Chen <marcochen.dev@gmail.com>
---
Changes in v4:
- Trim the backtrace to only relevant frames and unwrap the first line
  as suggested by Andy.

max30102_fifo_count() still has the odd name and int return you mentioned
in v2, so I will send a follow-up patch once this lands.

Tested on a MAX30102 on Raspberry Pi 4 over I2C.

v1: https://lore.kernel.org/linux-iio/20260731184124.112124-1-marcochen.dev@gmail.com/
v2: https://lore.kernel.org/linux-iio/20260804234355.65319-1-marcochen.dev@gmail.com/
v3: https://lore.kernel.org/linux-iio/20260805040621.84843-1-marcochen.dev@gmail.com/

 drivers/iio/health/max30102.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index c37316c86f14..aee96167f01e 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -290,9 +290,15 @@ static irqreturn_t max30102_interrupt_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
 	struct max30102_data *data = iio_priv(indio_dev);
-	unsigned int measurements = bitmap_weight(indio_dev->active_scan_mask,
-						  iio_get_masklength(indio_dev));
-	int ret, cnt = 0;
+	unsigned int measurements;
+	int ret, cnt;
+
+	cnt = max30102_fifo_count(data);
+	if (cnt <= 0)
+		return IRQ_HANDLED;
+
+	measurements = bitmap_weight(indio_dev->active_scan_mask,
+				     iio_get_masklength(indio_dev));
 
 	mutex_lock(&data->lock);
 
-- 
2.55.0

