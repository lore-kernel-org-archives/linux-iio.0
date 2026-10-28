Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156390;
	b=c17fa8iPNhkxBvOoQUr/ymPmZE7ZMmDtPuYNueQvc98Vndvd+tzBq0pyTULBcdXZL+CD
	 EWdjau6iL44+SlX2huWZo8PBpGzt2y9QMqaMze8zVPJk8ZOCdA/5DchxcPPyMwISzJjpU
	 JVpDpQg/Fdm2ORrIWiqO8K9DBXLb4UK+GehjRBpta6c16FBiEMEoqIo3f/v5QfBIikqOz
	 igCFwsl2gpmtfXBrAzU8H4uHK9k0LSRUal5WHppZzC58OG9VtN+bDdZJxgi9kFEiyPw/3
	 OLit7bxHILAPM6+R/9o0ek/p9hakcFoS+nK3h+/3oeQ4D7yxenG0aLG7nYY08HCc8YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=zmhLt1fcIW49TsxftipVDOrL5MaEf1i51ozTS3vuQE0=;
	b=Vs3LMhrQx7vTionIyVoKIUXylg1wOQQ5OOjPLxRtO4E/B2U9jbsJpRpFR9lX7V5/DcMA
	 2+9jZK35eu4EH+fVRQldy5pgoPwD1uvp/T39j3bp1yNi+m2mX1DYKuTaxUNYpXIXTGZsf
	 e+bdWPDbBCoQwtF2QszM2cloNMrSx6AvGIpZwFKcgLFLSOG+te0oOFJyue6KUuXYCrg83
	 wjzlRGu2uA7tNi9TOr3uNvZFDtcE1sMizxY+l00FxENoVUf0n6TDZEr19bzJJEW+E5ig0
	 eMOXjS6H4l/1MiprfvDY72tfAfVr1lviEJ/xQEA32LrruD2DfmYPrCSZTnLLu27i4nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tiXxZ5B2;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D44606A31E
	for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 02:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86D44606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tiXxZ5B2
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36a17a332ecso650426eec.1
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 19:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793156390; x=1793761190; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zmhLt1fcIW49TsxftipVDOrL5MaEf1i51ozTS3vuQE0=;
        b=tiXxZ5B23CrDdxwaxzsxnGEx/Tmy+ieUOR5s3xjD47whazeW89JHVTusEC3WEyH3sH
         sDVk/oaCL0wMEI25vEUyDqxLEGKyk2I+ox1vbPuaiMB6FEGn4xWsfPEfGrtIFkH4AJl1
         4DQrTs7V83Z9e+MtmJQGvhT5q5OpIoQTwhoAyqeOx+HDaixt5Cmr+3oLxYm06nVeVh6D
         x6MnAVJ9wJdA6pfjTd2ixEaxL40VpD04BiUPh9KynHYksDjwcia6elBYNQPLous61f4r
         kKISIi/84w/YC6qThME4mO6oKSbkMRzjkcGDbma0TSbjB9VNaWZVPciibd7ffMXdNS6y
         YWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793156390; x=1793761190;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zmhLt1fcIW49TsxftipVDOrL5MaEf1i51ozTS3vuQE0=;
        b=lbkMopdTp7PyGB/3KDgcEz6Tw+B9KUQjDdABQQgfQR0JBQqVO6FAChpWGcIf9DmawM
         b2J+nxf/1KpvUiFmkQV+Dr/ZV82Cc0UjjdSlFnye8j6+7g0b2mmE8s47lITnRVqvqrw8
         /YiKSyILc7VQ0MpldzJL3oMI9QBRDEH7VlyhrcbxUA1Y2C5KFZ7oJcoXqVPg+AeTXuRv
         vsyIiLIhenUuGzpg6ty8wivdT9CF/iDoRA6nLZuSMhlO3KdVy2pcZrmN+Ife74KzJlPM
         ZbuXLyFALVVQE7nczyZZSaCecoQgkb7s+w6CT27wQYorz6ZodJ4rBBprX2uXqlvYeUxe
         LpVw==
X-Gm-Message-State: AFq9FYLIxLn/TyFAHV/Tdqz4UGPZ+xAycBy5HCFzWdCkuDI+7/9lP/E2
	540SBVfR8Cb4W2LOUpgLGd/zkJD3TXbc0SUfJ7bq9RzHOoMtCzg7EHzM
X-Gm-Gg: AYBFou3w70E1M2Eye5GHVh893u+jf07CpuNTUgFu2yyi40ubunBSkFZEOfttXAaOXcD
	joul1WYToePizNMUbu5Dzr7Gi1a+4yyoWgU8BkYOHWX3o6GaT7VowC/6kS6d1V4A6jW7bDEHWeP
	+SvxoM8j2Ma2P9ZMwY1KujCGlaCt1LEuLIh0HgWOXTtL5GrqAdZVIYc+1z1GTmTvpcASxE+EjY1
	OKQTqVKKk9EcuhWg/UYqlN6INSJtY7BebWFax7SbSFMZCytQ5cAdoRAmSsKbWG5deZmRqLARWFI
	8ylXfrQBPuWXdS4iP9eF71TTyrurpYDoCnBZhXTWj+BQ8n5oAwecIBTs9X0mrEQYuYMTlxwR94T
	u6BXiAUZSAQIBSfDaglRBX8O1HosRIYQtcgDfX2o3avlFO9oW3hXVtnbka/8l/OIaS5ME5mUjWJ
	jMXZqPUcGbkES/Pqspg8CoqI0HYVC54ou9CqAPZt30EBVhxGC7vtBBBCkUANMAAG5/iTzw3nu6S
	icsK3c/jMmv+09mIeKWVGaneAiIgn1PfrKH5rnNYa2bZm4RW5avAlq6bSb7u9PKGsQF2LWanJVK
	tGj+IjwyO6/RwW/COPVQSi/wcbk=
X-Received: by 2002:a05:7300:c88:b0:369:eec1:1d7e with SMTP id 5a478bee46e88-36a2011245fmr2678360eec.11.1793156389380;
        Tue, 27 Oct 2026 19:59:49 -0700 (PDT)
Received: from [127.0.1.1] ([2406:da16:4ab:8700:3d3b:2065:9087:3429])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a237bddb7sm1377850eec.3.2026.10.27.19.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 19:59:49 -0700 (PDT)
From: Liu Yufei <lyf98405@gmail.com>
Date: Wed, 28 Oct 2026 10:59:26 +0800
Subject: [PATCH] iio: imu: bmi270: fix zero timestamp in triggered buffer
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-bmi270-fix-timestamp-v1-1-99c0e5fe7d0c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAA1l4WoC/yXMSwqEMBBF0a1IjS1IgvjprYiDREuthqikogji3
 ju2wwPv3QuEApPAJ7sg0MHC65Kg8wz62S4TIQ/JYJQptTI1Os+mUjjyiZE9SbR+w6K2uilc2Qx
 OQ7pugdLgn22717K7L/XxacF9/wCHtErLeAAAAA==
X-Change-ID: 20261028-bmi270-fix-timestamp-48a194b69db1
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Gustavo Silva <gustavograzs@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, stable@vger.kernel.org, 
 Liu Yufei <lyf98405@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793156377; l=2048;
 i=lyf98405@gmail.com; s=20261028; h=from:subject:message-id;
 bh=A/1srCpfd1UGOdpJgwH+wipqcVfWHT5hKzmppz1xS28=;
 b=zes8qii00NcuE45PPu4stJ4xIYMjnHPkeaU4SW86Z6Tts6kgcxp+jNZYZKP+DQD8HFWvEzC4v
 ZVUz4JILlhbAuqBUFmVzhyVSvWcFzX6BPQDuPVG3/de4T6fhpBDmLe2
X-Developer-Key: i=lyf98405@gmail.com; a=ed25519;
 pk=lc+pS6pGKgsSIrWd9Plh5gs4dnZRQT6qkyv+hvAy7hs=

When the device's own data ready trigger is used, the trigger is
polled with iio_trigger_poll_nested() from the threaded IRQ handler.
In that path the pollfunc top half, iio_pollfunc_store_time(), is
never run, so pf->timestamp is left at zero and every sample pushed
to the buffer carries a zero timestamp.

Take the timestamp in the trigger handler itself and drop the top
half, so that a valid timestamp is provided for all triggers.

Fixes: a1854d55f54b ("iio: imu: bmi270: add support for data ready interrupt trigger")
Cc: stable@vger.kernel.org
Signed-off-by: Liu Yufei <lyf98405@gmail.com>
---
 drivers/iio/imu/bmi270/bmi270_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index fbcf6bb87acc..40ed1ee5ac58 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -840,6 +840,7 @@ static irqreturn_t bmi270_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmi270_data *data = iio_priv(indio_dev);
+	s64 timestamp = iio_get_time_ns(indio_dev);
 	int ret;
 
 	guard(mutex)(&data->mutex);
@@ -852,7 +853,7 @@ static irqreturn_t bmi270_trigger_handler(int irq, void *p)
 		goto done;
 
 	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
-					   pf->timestamp);
+					   timestamp);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
@@ -1630,8 +1631,7 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap,
 	if (ret)
 		return ret;
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      iio_pollfunc_store_time,
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 					      bmi270_trigger_handler, NULL);
 	if (ret)
 		return ret;

---
base-commit: 09f742b49cb2728086d78be2b0b35e4d1d71fc85
change-id: 20261028-bmi270-fix-timestamp-48a194b69db1

Best regards,
--  
Liu Yufei <lyf98405@gmail.com>

